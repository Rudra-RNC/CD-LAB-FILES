%option noyywrap
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int executable_count = 0;

long long min_size = -1, max_size = -1;
char min_name[256], max_name[256];

char oldest_name[256], newest_name[256];
time_t oldest_time = 0, newest_time = 0;

int resource_count = 0;

int month_number(char *month)
{
    char *months[] = {
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    };

    for (int i = 0; i < 12; i++)
        if (strcmp(month, months[i]) == 0)
            return i;
    return -1;
}

void process_entry(char *line)
{
    int blocks, links, size, day, hour, minute;
    char perm[20], owner[100], group[100], month[10], time_str[10], name[256];

    int n = sscanf(line,
        "%d %s %d %s %s %d %s %d %s %255[^\n]",
        &blocks, perm, &links, owner, group, &size, month, &day, time_str, name);

    resource_count++;

    if (perm[0] == '-' &&
        (perm[3] == 'x' || perm[6] == 'x' || perm[9] == 'x'))
    {
        executable_count++;
    }

    if (min_size == -1 || size < min_size)
    {
        min_size = size;
        strcpy(min_name, name);
    }

    if (max_size == -1 || size > max_size)
    {
        max_size = size;
        strcpy(max_name, name);
    }

    if (perm[7] == '-' &&
        perm[8] == '-' &&
        perm[9] == '-')
    {
        printf("Not accessible to others: %s\n", name);
    }

    struct tm t;
    memset(&t, 0, sizeof(t));

    time_t now = time(NULL);
    struct tm *current = localtime(&now);

    t.tm_year = current->tm_year;
    t.tm_mon = month_number(month);
    t.tm_mday = day;

    sscanf(time_str, "%d:%d", &hour, &minute);

    t.tm_hour = hour;
    t.tm_min = minute;
    t.tm_sec = 0;

    time_t file_time = mktime(&t);

    if (oldest_time == 0 || file_time < oldest_time)
    {
        oldest_time = file_time;
        strcpy(oldest_name, name);
    }

    if (newest_time == 0 || file_time > newest_time)
    {
        newest_time = file_time;
        strcpy(newest_name, name);
    }
}
%}
%%

^total[ \t]+[0-9]+[ \t]*\n
        { }

^[ \t]*[0-9]+[ \t]+[d-][rwx-]{9}[ \t]+.*\n
        {
            process_entry(yytext);
        }

[^\n]*\n
        { }

%%

int main()
{
    printf("===== LINUX FILE SYSTEM SCANNER =====\n\n");

    yylex();

    printf("\n===== SCAN RESULTS =====\n\n");

    printf("(a) Number of executable files: %d\n",
           executable_count);

    printf("\n(b) Largest resource:\n");
    printf("    Name : %s\n", max_name);
    printf("    Size : %lld bytes\n", max_size);

    printf("\n    Smallest resource:\n");
    printf("    Name : %s\n", min_name);
    printf("    Size : %lld bytes\n", min_size);

    printf("\n(c) Resources not accessible to other users:\n");

    printf("\n(d) Oldest resource:\n");
    printf("    %s\n", oldest_name);

    printf("\n    Most recent resource:\n");
    printf("    %s\n", newest_name);

    printf("\n=====================================\n");

    return 0;
}

