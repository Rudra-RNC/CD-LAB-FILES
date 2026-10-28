  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #include <stdbool.h>

  // working with an array representation of a symtab 
  struct element 
  { char name[20];
    short type;
    short width;
    short offset;
  };
  // list of functions
  const short SIZE = 100;
  struct element symtab[100]; // max 100 elements in symbol table
  int currindex;
  short reladdr = 0;
  void initialize (struct element symtab[])
  {  char * tabname=(char*)malloc(sizeof("Global Tab"));
     strcpy(symtab[0].name,tabname); symtab[0].type = 0;
     symtab[0].width = 0;
     for (int i = 1; i < SIZE; i++) 
     {strcpy(symtab[i].name, ""); symtab[i].type = 0; 
      symtab[i].width = 0; symtab[i].offset = 0; 
     }
     currindex = 1; // empty table
     return;
  }
  
  bool isempty ( struct element table[] )
  { if (currindex == 0) return true; else return false; }

  int length (struct element table[] ) { return currindex; }
 
  int  find (char* id, struct element symtab[]) 
  // search for id in symtab ; return value is index in table 
  { int index = -1;    // assume id is not present in table
    char* idname = (char*) malloc(sizeof(id));
    strcpy(idname, id);
    for (int i = 1; i <= currindex; i++)
    { if (strcmp(idname, symtab[i].name) == 0) // id exists in table
      {index = i; return index;}
    };
    return index; // else -1 returned 
  }
          
  // append function to insert an element at the current index of symtab
  void append(struct element stab[], char* id, 
              short typ, short bytes)
  { char* idname = (char*) malloc(sizeof(id));
    // char* tname = (char*) malloc(sizeof(typ));
    strcpy(idname, id); 
    strcpy(stab[currindex].name, idname); stab[currindex].type = typ;
    stab[currindex].width = bytes; stab[currindex].offset = reladdr;
    reladdr += stab[currindex].width;
    ++currindex;
    return;
  }    
    
  // a function to display the symbol table

  void display (struct element stab[])
  { printf(" Display Contents of Symbol Table \n");
    printf("Index \tName \tType \tSize \t|Symbols|/offset\n"); 
    for ( int i = 0 ; i < currindex ; i++ )
     printf(" [%d] \t%s \t%d\t%d \t%d\n", 
            i, stab[i].name, stab[i].type, stab[i].width, stab[i].offset);
  }
