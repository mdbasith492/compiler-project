/* simple music notation lex file */

%{
    #include "y.tab.h"
    #include <stdlib.h>

    void yyerror(char *);
    int transform(int org);
%}

%%

[drmfslt]     {
                  yylval.num = transform(*yytext - 'a');
                  return SYMBOLS;
              }

[DRMFSLT]     {
                  yylval.num = transform(*yytext - 'A') + 10;
                  return SYMBOLS;
              }

[1-9]         {
                  yylval.num = atoi(yytext);
                  return ID;
              }

[0]           {
                  yylval.num = 8;
                  return SYMBOLS;
              }

[(:)/\!@>]    {
                  return *yytext;
              }

[-]+          {
                  yylval.num = strlen(yytext) + 1;
                  return EN;
              }

[ \t\n]+      ;

.             yyerror("unknown symbols");

%%

int yywrap(void) {
    return 1;
}

int transform(int org) {
    if (org == 3) {     
       // Dd 
        return 0;
    } else if (org == 17) {    
        // Rr 
        return 1;
    } else if (org == 12) {    
        // Mm 
        return 2;
    } else if (org == 5) {     
        // Ff 
        return 3;
    } else if (org == 18) {    
	   // Ss 
        return 4;
    } else if (org == 11) {    
        // Ll 
        return 5;
    } else if (org == 19) {    
        // Tt 
        return 6;
    } else {
       
 return -1;
    }
}