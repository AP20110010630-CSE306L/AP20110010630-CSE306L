digit [0-9]*

id [a-zA-Z][a-zA-Z0-9]*

num [digit]*\.[digit]*

op [ + | - | * | % |/ ]

%{

#include<stdio.h>

#include<string.h>

int cnt=0,i=0,j=0;

int com=0,scom=0,quote=0;

char st[10][10];

int look_up(char st[10][10],char *id,int n);

%}

%%

\n {com=0;}

" "

-- {fprintf(yyout,"\n%s is the decrement\n",yytext);p

"++" {fprintf(yyout,"\n%s is the increment\n",yytext);}

%d |

%f |

%s |

%c {fprintf(yyout,"\n%s is a format specifier\n",yytext);}

int |

float |

char |

double |

void |

if |

for |

while |

double |

break |

do |

\\n |

\\t |

switch { if(!com&&!scom)fprintf(yyout," \n %s is keyword\n",yytext);}

"//" { com=1;fprintf(yyout,"\n %s is comment line\n",yytext);}

"/*" { scom=1;fprintf(yyout,"\n %s is multi line comment opened\n",yytext);}

"*/" { scom=0;fprintf(yyout,"\n %s is comment line opened\n",yytext);}

{num} {if(!com&&!scom) fprintf(yyout,"\n %s is float",yytext);}

"=" {fprintf(yyout,"\n%s is the assignment operator\n",yytext);}

{id} {if(com==0 && scom==0){fprintf(yyout,"\n %s is identifier",yytext);

if(!look_up(st,yytext,i)){

strcpy(st[i++],yytext);

cnt++;}

}

}

"<=" |

"<" |

">" |

">=" |

"==" |

"!=" {if(!com&&!scom)fprintf(yyout,"\n%s is the relational operator\n",yytext);}

{op} {if(!com&&!scom)fprintf(yyout,"\n%s is the arthematic operator\n",yytext);}

{digit} {if(!com&&!scom) fprintf(yyout,"\n %s is digit",yytext);}

. {if(!com&&!scom)fprintf(yyout,"\n %s is delimiter",yytext);}

%%

main(int argc, char **argv) {

yyin=fopen(argv[1],"r"); // passing input file name as argv[1]

yyout=fopen(argv[2],"w");

yylex();

fprintf(yyout,"\n%d is the no of identifiers",cnt);

for( j=0;j<i;j++){

fprintf(yyout,"\n%s",st[j]); 

}

return 0;

}

int yywrap()

{

return 1;

}

int look_up(char st[10][10],char *id,int n)

{

for(j=0;j<n;j++)

if(!strcmp(st[j],id)){

return 1;}

return 0;

}
