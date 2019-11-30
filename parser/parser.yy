%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "expressionBinaire.hh"
    #include "expressionUnaire.hh"
    #include "constante.hh"
    #include "variable.hh"

    class Scanner;
    class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
    #include <iostream>
    #include <string>

    #include "scanner.hh"
    #include "driver.hh"

    #undef  yylex
    #define yylex scanner.yylex
}

%token HOUSE ROAD CONSTRUCT TURN ORIENTATE MOVE DESTRUCT POSITION ORIENTATION NEIGHBORHOOD HOUSELIST CLOCKWISE ANTI_CLOCKWISE
%token COMMENT_INLINE COMMENT_OPEN COMMENT_CLOSE ARROW DEGREE
%token                  NL
%token                  END
%token <int>            NUMBER

%type <int>             city_header
%type <int>             operation
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

program: city NL program |
	     END { YYACCEPT; }

city:
 	city_header '{' NL commands '}'
	{
		std::cout << "construire ville de taille: " << $1 << "\n";
		// YYACCEPT;
	}

city_header:
	CONSTRUCT '(' NUMBER ')' { $$ = $3; } |
	CONSTRUCT                { $$ = 5;  }

commands:
	command NL commands | command NL

command:
    operation  {
        std::cout << "#-> " << $1 << std::endl;
    }

operation:
    NUMBER {
        $$ = $1;
    }
    | '(' operation ')' {
        $$ = $2;
    }
    | operation '+' operation {
        $$ = $1 + $3;
    }
    | operation '-' operation {
        $$ = $1 - $3;
    }
    | operation '*' operation {
        $$ = $1 * $3;
    }
    | operation '/' operation {
        $$ = $1 / $3;
    }
    | '-' operation %prec NEG {
        $$ = - $2;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
