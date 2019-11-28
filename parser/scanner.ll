%{

#include "scanner.hh"
#include <cstdlib>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef  YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option c++
%option yyclass="Scanner"
%option noyywrap

%%
%{
    yylval = lval;
%}
fin return token::END;

"+"           return '+';
"*"           return '*';
"-"           return '-';
"/"           return '/';
"("           return '(';
")"           return ')';
"="           return '=';
"{"           return '{';
"}"           return '}';
","           return ',';
"%%"          return '%%';
"/%"          return '/%';
"%/"          return '%/';
"->"          return '->';
"["           return '[';
"]"           return ']';
"°"           return '°';
"Maison"      return token::HOUSE;
"Route"       return token::ROAD;
"Construire"  return token::CONSTRUCT;
"Tourner"     return token::TURN;
"Orienter"    return token::ORIENTATE;
"Deplacer"    return token::MOVE;
"Detruire"    return token::DESTRUCT;
"Position"    return token::POSITION;
"Orientation" return token::ORIENTATION;
"Voisinage"   return token::NEIGHBORHOOD;
"maison"      return token::HOUSELIST;
"horaire"     return token::CLOCKWISE;
"!horaire"     return token::ANTI_CLOCKWISE;
[0-9]+      {
    yylval->build<int>(std::atoi(YYText()));
    return token::NUMBER;
}

"\n"          {
    loc->lines();
    return token::NL;
}

%%
