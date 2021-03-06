-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Language.Clafer.Front.Parclafer where
import Language.Clafer.Front.Absclafer
import Language.Clafer.Front.Lexclafer
import Language.Clafer.Front.ErrM

}

%name pModule Module

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype { Token }

%token 
 '!' { PT _ (TS _ 1) }
 '!=' { PT _ (TS _ 2) }
 '#' { PT _ (TS _ 3) }
 '##>' { PT _ (TS _ 4) }
 '#[' { PT _ (TS _ 5) }
 '&' { PT _ (TS _ 6) }
 '&&' { PT _ (TS _ 7) }
 '(' { PT _ (TS _ 8) }
 ')' { PT _ (TS _ 9) }
 '*' { PT _ (TS _ 10) }
 '+' { PT _ (TS _ 11) }
 '++' { PT _ (TS _ 12) }
 ',' { PT _ (TS _ 13) }
 '-' { PT _ (TS _ 14) }
 '--' { PT _ (TS _ 15) }
 '-->' { PT _ (TS _ 16) }
 '->' { PT _ (TS _ 17) }
 '->>' { PT _ (TS _ 18) }
 '-[' { PT _ (TS _ 19) }
 '.' { PT _ (TS _ 20) }
 '..' { PT _ (TS _ 21) }
 '/' { PT _ (TS _ 22) }
 ':' { PT _ (TS _ 23) }
 ':=' { PT _ (TS _ 24) }
 ':>' { PT _ (TS _ 25) }
 ';' { PT _ (TS _ 26) }
 '<' { PT _ (TS _ 27) }
 '<:' { PT _ (TS _ 28) }
 '<<' { PT _ (TS _ 29) }
 '<=' { PT _ (TS _ 30) }
 '<=>' { PT _ (TS _ 31) }
 '=' { PT _ (TS _ 32) }
 '==>' { PT _ (TS _ 33) }
 '=>' { PT _ (TS _ 34) }
 '=[' { PT _ (TS _ 35) }
 '>' { PT _ (TS _ 36) }
 '>=' { PT _ (TS _ 37) }
 '>>' { PT _ (TS _ 38) }
 '?' { PT _ (TS _ 39) }
 'F' { PT _ (TS _ 40) }
 'G' { PT _ (TS _ 41) }
 'U' { PT _ (TS _ 42) }
 'W' { PT _ (TS _ 43) }
 'X' { PT _ (TS _ 44) }
 '[' { PT _ (TS _ 45) }
 '\\' { PT _ (TS _ 46) }
 ']' { PT _ (TS _ 47) }
 ']#>' { PT _ (TS _ 48) }
 ']->' { PT _ (TS _ 49) }
 ']=>' { PT _ (TS _ 50) }
 '`' { PT _ (TS _ 51) }
 'abstract' { PT _ (TS _ 52) }
 'after' { PT _ (TS _ 53) }
 'all' { PT _ (TS _ 54) }
 'and' { PT _ (TS _ 55) }
 'before' { PT _ (TS _ 56) }
 'between' { PT _ (TS _ 57) }
 'disj' { PT _ (TS _ 58) }
 'else' { PT _ (TS _ 59) }
 'enum' { PT _ (TS _ 60) }
 'eventually' { PT _ (TS _ 61) }
 'final' { PT _ (TS _ 62) }
 'finally' { PT _ (TS _ 63) }
 'globally' { PT _ (TS _ 64) }
 'if' { PT _ (TS _ 65) }
 'in' { PT _ (TS _ 66) }
 'initial' { PT _ (TS _ 67) }
 'initially' { PT _ (TS _ 68) }
 'let' { PT _ (TS _ 69) }
 'lone' { PT _ (TS _ 70) }
 'max' { PT _ (TS _ 71) }
 'min' { PT _ (TS _ 72) }
 'mux' { PT _ (TS _ 73) }
 'next' { PT _ (TS _ 74) }
 'no' { PT _ (TS _ 75) }
 'not' { PT _ (TS _ 76) }
 'one' { PT _ (TS _ 77) }
 'opt' { PT _ (TS _ 78) }
 'or' { PT _ (TS _ 79) }
 'some' { PT _ (TS _ 80) }
 'sum' { PT _ (TS _ 81) }
 'then' { PT _ (TS _ 82) }
 'until' { PT _ (TS _ 83) }
 'weakuntil' { PT _ (TS _ 84) }
 'xor' { PT _ (TS _ 85) }
 '{' { PT _ (TS _ 86) }
 '|' { PT _ (TS _ 87) }
 '||' { PT _ (TS _ 88) }
 '}' { PT _ (TS _ 89) }

L_PosInteger { PT _ (T_PosInteger _) }
L_PosDouble { PT _ (T_PosDouble _) }
L_PosString { PT _ (T_PosString _) }
L_PosIdent { PT _ (T_PosIdent _) }
L_err    { _ }


%%

PosInteger    :: { PosInteger} : L_PosInteger { PosInteger (mkPosToken $1)}
PosDouble    :: { PosDouble} : L_PosDouble { PosDouble (mkPosToken $1)}
PosString    :: { PosString} : L_PosString { PosString (mkPosToken $1)}
PosIdent    :: { PosIdent} : L_PosIdent { PosIdent (mkPosToken $1)}

Module :: { Module }
Module : ListDeclaration { Module ((mkCatSpan $1)) (reverse $1) } 


Declaration :: { Declaration }
Declaration : 'enum' PosIdent '=' ListEnumId { EnumDecl ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 } 
  | Element { ElementDecl ((mkCatSpan $1)) $1 }


Clafer :: { Clafer }
Clafer : Abstract TempModifier GCard PosIdent Super Card Init Transition Elements { Clafer ((mkCatSpan $1) >- (mkCatSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4) >- (mkCatSpan $5) >- (mkCatSpan $6) >- (mkCatSpan $7) >- (mkCatSpan $8) >- (mkCatSpan $9)) $1 $2 $3 $4 $5 $6 $7 $8 $9 } 


Constraint :: { Constraint }
Constraint : '[' 'final' ']' { FinalConstraint ((mkTokenSpan $1) >- (mkTokenSpan $2) >- (mkTokenSpan $3)) } 
  | '[' ListExp ']' { Constraint ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) }


SoftConstraint :: { SoftConstraint }
SoftConstraint : '(' ListExp ')' { SoftConstraint ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) } 


Goal :: { Goal }
Goal : '<<' ListExp '>>' { Goal ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) } 


TempModifier :: { TempModifier }
TempModifier : {- empty -} { NoTempModifier noSpan } 
  | 'initial' { Initial ((mkTokenSpan $1)) }
  | 'final' { Final ((mkTokenSpan $1)) }


Transition :: { Transition }
Transition : {- empty -} { TransitionEmpty noSpan } 
  | TransArrow Exp { Transition ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 }


Abstract :: { Abstract }
Abstract : {- empty -} { AbstractEmpty noSpan } 
  | 'abstract' { Abstract ((mkTokenSpan $1)) }


Elements :: { Elements }
Elements : {- empty -} { ElementsEmpty noSpan } 
  | '{' ListElement '}' { ElementsList ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) (reverse $2) }


Element :: { Element }
Element : Clafer { Subclafer ((mkCatSpan $1)) $1 } 
  | '`' Name Card Elements { ClaferUse ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4)) $2 $3 $4 }
  | Constraint { Subconstraint ((mkCatSpan $1)) $1 }
  | Goal { Subgoal ((mkCatSpan $1)) $1 }
  | SoftConstraint { Subsoftconstraint ((mkCatSpan $1)) $1 }


Super :: { Super }
Super : {- empty -} { SuperEmpty noSpan } 
  | SuperHow SetExp { SuperSome ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 }


SuperHow :: { SuperHow }
SuperHow : ':' { SuperColon ((mkTokenSpan $1)) } 
  | '->' { SuperArrow ((mkTokenSpan $1)) }
  | '->>' { SuperMArrow ((mkTokenSpan $1)) }


Init :: { Init }
Init : {- empty -} { InitEmpty noSpan } 
  | InitHow Exp { InitSome ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 }


InitHow :: { InitHow }
InitHow : '=' { InitHow_1 ((mkTokenSpan $1)) } 
  | ':=' { InitHow_2 ((mkTokenSpan $1)) }


GCard :: { GCard }
GCard : {- empty -} { GCardEmpty noSpan } 
  | 'xor' { GCardXor ((mkTokenSpan $1)) }
  | 'or' { GCardOr ((mkTokenSpan $1)) }
  | 'mux' { GCardMux ((mkTokenSpan $1)) }
  | 'opt' { GCardOpt ((mkTokenSpan $1)) }
  | NCard { GCardInterval ((mkCatSpan $1)) $1 }


Card :: { Card }
Card : {- empty -} { CardEmpty noSpan } 
  | '?' { CardLone ((mkTokenSpan $1)) }
  | '+' { CardSome ((mkTokenSpan $1)) }
  | '*' { CardAny ((mkTokenSpan $1)) }
  | PosInteger { CardNum ((mkCatSpan $1)) $1 }
  | NCard { CardInterval ((mkCatSpan $1)) $1 }


NCard :: { NCard }
NCard : PosInteger '..' ExInteger { NCard ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 


ExInteger :: { ExInteger }
ExInteger : '*' { ExIntegerAst ((mkTokenSpan $1)) } 
  | PosInteger { ExIntegerNum ((mkCatSpan $1)) $1 }


Name :: { Name }
Name : ListModId { Path ((mkCatSpan $1)) $1 } 


Exp :: { Exp }
Exp : Exp1 TransArrow Exp { TransitionExp ((mkCatSpan $1) >- (mkCatSpan $2) >- (mkCatSpan $3)) $1 $2 $3 } 
  | Exp1 {  $1 }


Exp1 :: { Exp }
Exp1 : 'all' 'disj' Decl '|' Exp1 { DeclAllDisj ((mkTokenSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkTokenSpan $4) >- (mkCatSpan $5)) $3 $5 } 
  | 'all' Decl '|' Exp1 { DeclAll ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 }
  | Quant 'disj' Decl '|' Exp1 { DeclQuantDisj ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkTokenSpan $4) >- (mkCatSpan $5)) $1 $3 $5 }
  | Quant Decl '|' Exp1 { DeclQuant ((mkCatSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $1 $2 $4 }
  | 'let' VarBinding 'in' Exp1 { LetExp ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 }
  | Exp2 {  $1 }


Exp2 :: { Exp }
Exp2 : Exp3 PatternScope { TmpPatJustScope ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 } 
  | Exp3 'before' Exp3 { TmpPatBeforeNoScope ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp3 'after' Exp3 { TmpPatAfterNoScope ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp3 'before' Exp3 PatternScope { TmpPatBefore ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4)) $1 $3 $4 }
  | Exp3 'after' Exp3 PatternScope { TmpPatAfter ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3) >- (mkCatSpan $4)) $1 $3 $4 }
  | 'initially' Exp3 { TmpInitially ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | 'finally' Exp3 { TmpFinally ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp3 {  $1 }


Exp3 :: { Exp }
Exp3 : 'max' Exp4 { EGMax ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | 'min' Exp4 { EGMin ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp3 '<=>' Exp4 { EIff ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp4 {  $1 }


Exp4 :: { Exp }
Exp4 : Exp4 '=>' Exp5 { EImplies ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp5 {  $1 }


Exp5 :: { Exp }
Exp5 : Exp5 '||' Exp6 { EOr ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp6 {  $1 }


Exp6 :: { Exp }
Exp6 : Exp6 'xor' Exp7 { EXor ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp7 {  $1 }


Exp7 :: { Exp }
Exp7 : Exp7 '&&' Exp8 { EAnd ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp8 {  $1 }


Exp8 :: { Exp }
Exp8 : Exp8 'U' Exp9 { LtlU ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp8 'until' Exp9 { TmpUntil ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp9 {  $1 }


Exp9 :: { Exp }
Exp9 : Exp9 'W' Exp10 { LtlW ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp9 'weakuntil' Exp10 { TmpWUntil ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp10 {  $1 }


Exp10 :: { Exp }
Exp10 : 'F' Exp10 { LtlF ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | 'eventually' Exp10 { TmpEventually ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | 'G' Exp10 { LtlG ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | 'globally' Exp10 { TmpGlobally ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | 'X' Exp10 { LtlX ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | 'next' Exp10 { TmpNext ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | '!' Exp10 { ENeg ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp11 {  $1 }


Exp15 :: { Exp }
Exp15 : Exp15 '<' Exp16 { ELt ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp15 '>' Exp16 { EGt ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 '=' Exp16 { EEq ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 '<=' Exp16 { ELte ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 '>=' Exp16 { EGte ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 '!=' Exp16 { ENeq ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 'in' Exp16 { EIn ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp15 'not' 'in' Exp16 { ENin ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $1 $4 }
  | Exp16 {  $1 }


Exp16 :: { Exp }
Exp16 : Quant Exp20 { QuantExp ((mkCatSpan $1) >- (mkCatSpan $2)) $1 $2 } 
  | Exp17 {  $1 }


Exp17 :: { Exp }
Exp17 : Exp17 '+' Exp18 { EAdd ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp17 '-' Exp18 { ESub ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp18 {  $1 }


Exp18 :: { Exp }
Exp18 : Exp18 '*' Exp19 { EMul ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | Exp18 '/' Exp19 { EDiv ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | Exp19 {  $1 }


Exp19 :: { Exp }
Exp19 : 'sum' Exp20 { ESumSetExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 } 
  | '#' Exp20 { ECSetExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | '-' Exp20 { EMinExp ((mkTokenSpan $1) >- (mkCatSpan $2)) $2 }
  | Exp20 {  $1 }


Exp20 :: { Exp }
Exp20 : 'if' Exp20 'then' Exp20 'else' Exp21 { EImpliesElse ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4) >- (mkTokenSpan $5) >- (mkCatSpan $6)) $2 $4 $6 } 
  | Exp21 {  $1 }


Exp21 :: { Exp }
Exp21 : PosInteger { EInt ((mkCatSpan $1)) $1 } 
  | PosDouble { EDouble ((mkCatSpan $1)) $1 }
  | PosString { EStr ((mkCatSpan $1)) $1 }
  | SetExp { ESetExp ((mkCatSpan $1)) $1 }
  | '(' Exp ')' {  $2 }


TransGuard :: { TransGuard }
TransGuard : Exp1 { TransGuard ((mkCatSpan $1)) $1 } 


TransArrow :: { TransArrow }
TransArrow : '-->' { AsyncTransArrow ((mkTokenSpan $1)) } 
  | '-[' TransGuard ']->' { GuardedAsyncTransArrow ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) $2 }
  | '==>' { SyncTransArrow ((mkTokenSpan $1)) }
  | '=[' TransGuard ']=>' { GuardedSyncTransArrow ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) $2 }
  | '##>' { NextTransArrow ((mkTokenSpan $1)) }
  | '#[' TransGuard ']#>' { GuardedNextTransArrow ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3)) $2 }


PatternScope :: { PatternScope }
PatternScope : 'between' Exp 'and' Exp { PatScopeBetween ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 } 
  | 'after' Exp 'until' Exp { PatScopeUntil ((mkTokenSpan $1) >- (mkCatSpan $2) >- (mkTokenSpan $3) >- (mkCatSpan $4)) $2 $4 }


SetExp :: { SetExp }
SetExp : SetExp '++' SetExp1 { Union ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp ',' SetExp1 { UnionCom ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 }
  | SetExp1 {  $1 }


SetExp1 :: { SetExp }
SetExp1 : SetExp1 '--' SetExp2 { Difference ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp2 {  $1 }


SetExp2 :: { SetExp }
SetExp2 : SetExp2 '&' SetExp3 { Intersection ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp3 {  $1 }


SetExp3 :: { SetExp }
SetExp3 : SetExp3 '<:' SetExp4 { Domain ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp4 {  $1 }


SetExp4 :: { SetExp }
SetExp4 : SetExp4 ':>' SetExp5 { Range ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp5 {  $1 }


SetExp5 :: { SetExp }
SetExp5 : SetExp5 '.' SetExp6 { Join ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 
  | SetExp6 {  $1 }


SetExp6 :: { SetExp }
SetExp6 : Name { ClaferId ((mkCatSpan $1)) $1 } 
  | '(' SetExp ')' {  $2 }


Decl :: { Decl }
Decl : ListLocId ':' SetExp { Decl ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 


VarBinding :: { VarBinding }
VarBinding : LocId '=' Name { VarBinding ((mkCatSpan $1) >- (mkTokenSpan $2) >- (mkCatSpan $3)) $1 $3 } 


Quant :: { Quant }
Quant : 'no' { QuantNo ((mkTokenSpan $1)) } 
  | 'not' { QuantNot ((mkTokenSpan $1)) }
  | 'lone' { QuantLone ((mkTokenSpan $1)) }
  | 'one' { QuantOne ((mkTokenSpan $1)) }
  | 'some' { QuantSome ((mkTokenSpan $1)) }


EnumId :: { EnumId }
EnumId : PosIdent { EnumIdIdent ((mkCatSpan $1)) $1 } 


ModId :: { ModId }
ModId : PosIdent { ModIdIdent ((mkCatSpan $1)) $1 } 


LocId :: { LocId }
LocId : PosIdent { LocIdIdent ((mkCatSpan $1)) $1 } 


ListDeclaration :: { [Declaration] }
ListDeclaration : {- empty -} { []  } 
  | ListDeclaration Declaration { flip (:)  $1 $2 }


ListEnumId :: { [EnumId] }
ListEnumId : EnumId { (:[])  $1 } 
  | EnumId '|' ListEnumId { (:)  $1 $3 }


ListElement :: { [Element] }
ListElement : {- empty -} { []  } 
  | ListElement Element { flip (:)  $1 $2 }


ListExp :: { [Exp] }
ListExp : {- empty -} { []  } 
  | ListExp Exp { flip (:)  $1 $2 }


ListLocId :: { [LocId] }
ListLocId : LocId { (:[])  $1 } 
  | LocId ';' ListLocId { (:)  $1 $3 }


ListModId :: { [ModId] }
ListModId : ModId { (:[])  $1 } 
  | ModId '\\' ListModId { (:)  $1 $3 }


Exp11 :: { Exp }
Exp11 : Exp12 {  $1 } 


Exp12 :: { Exp }
Exp12 : Exp13 {  $1 } 


Exp13 :: { Exp }
Exp13 : Exp14 {  $1 } 


Exp14 :: { Exp }
Exp14 : Exp15 {  $1 } 



{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad (pp ts) $
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> "before " ++ unwords (map (id . prToken) (take 4 ts))

gp x@(PT (Pn _ l c) _) = Span (Pos (toInteger l) (toInteger c)) (Pos (toInteger l) (toInteger c + toInteger (length $ prToken x)))
pp (PT (Pn _ l c) _ :_) = Pos (toInteger l) (toInteger c)
pp (Err (Pn _ l c) :_) = Pos (toInteger l) (toInteger c)
pp _ = error "EOF"

mkCatSpan :: (Spannable c) => c -> Span
mkCatSpan = getSpan

mkTokenSpan :: Token -> Span
mkTokenSpan = gp
myLexer = tokens
}

