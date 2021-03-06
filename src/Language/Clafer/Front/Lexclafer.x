-- -*- haskell -*-
-- This Alex file was machine-generated by the BNF converter
{
{-# OPTIONS -fno-warn-incomplete-patterns #-}
{-# OPTIONS_GHC -w #-}
module Language.Clafer.Front.Lexclafer where



import qualified Data.Bits
import Data.Word (Word8)
}


$l = [a-zA-Z\192 - \255] # [\215 \247]    -- isolatin1 letter FIXME
$c = [A-Z\192-\221] # [\215]    -- capital isolatin1 letter FIXME
$s = [a-z\222-\255] # [\247]    -- small isolatin1 letter FIXME
$d = [0-9]                -- digit
$i = [$l $d _ ']          -- identifier character
$u = [\0-\255]          -- universal: any character

@rsyms =    -- symbols and non-identifier-like reserved words
   \= | \[ | \] | \( | \) | \< \< | \> \> | \{ | \} | \` | \: | \- \> | \- \> \> | \: \= | \? | \+ | \* | \. \. | \| | \< \= \> | \= \> | \| \| | \& \& | \! | \< | \> | \< \= | \> \= | \! \= | \- | \/ | \# | \- \- \> | \- \[ | \] \- \> | \= \= \> | \= \[ | \] \= \> | \# \# \> | \# \[ | \] \# \> | \+ \+ | \, | \- \- | \& | \< \: | \: \> | \. | \; | \\

:-
"//" [.]* ; -- Toss single line comments
"/*" ([$u # \*] | \* [$u # \/])* ("*")+ "/" ; 

$white+ ;
@rsyms { tok (\p s -> PT p (eitherResIdent (TV . share) s)) }
$d + { tok (\p s -> PT p (eitherResIdent (T_PosInteger . share) s)) }
$d + \. $d + (e \- ? $d +)? { tok (\p s -> PT p (eitherResIdent (T_PosDouble . share) s)) }
\" ($u # [\" \\]| \\ [\" \\ n t]) * \" { tok (\p s -> PT p (eitherResIdent (T_PosString . share) s)) }
$l ($l | $d | \_ | \')* { tok (\p s -> PT p (eitherResIdent (T_PosIdent . share) s)) }

$l $i*   { tok (\p s -> PT p (eitherResIdent (TV . share) s)) }





{

tok f p s = f p s

share :: String -> String
share = id

data Tok =
   TS !String !Int    -- reserved words and symbols
 | TL !String         -- string literals
 | TI !String         -- integer literals
 | TV !String         -- identifiers
 | TD !String         -- double precision float literals
 | TC !String         -- character literals
 | T_PosInteger !String
 | T_PosDouble !String
 | T_PosString !String
 | T_PosIdent !String

 deriving (Eq,Show,Ord)

data Token = 
   PT  Posn Tok
 | Err Posn
  deriving (Eq,Show,Ord)

tokenPos (PT (Pn _ l _) _ :_) = "line " ++ show l
tokenPos (Err (Pn _ l _) :_) = "line " ++ show l
tokenPos _ = "end of file"

tokenPosn (PT p _) = p
tokenPosn (Err p) = p
tokenLineCol = posLineCol . tokenPosn
posLineCol (Pn _ l c) = (l,c)
mkPosToken t@(PT p _) = (posLineCol p, prToken t)

prToken t = case t of
  PT _ (TS s _) -> s
  PT _ (TL s)   -> s
  PT _ (TI s)   -> s
  PT _ (TV s)   -> s
  PT _ (TD s)   -> s
  PT _ (TC s)   -> s
  PT _ (T_PosInteger s) -> s
  PT _ (T_PosDouble s) -> s
  PT _ (T_PosString s) -> s
  PT _ (T_PosIdent s) -> s


data BTree = N | B String Tok BTree BTree deriving (Show)

eitherResIdent :: (String -> Tok) -> String -> Tok
eitherResIdent tv s = treeFind resWords
  where
  treeFind N = tv s
  treeFind (B a t left right) | s < a  = treeFind left
                              | s > a  = treeFind right
                              | s == a = t

resWords = b "[" 45 (b ":" 23 (b "++" 12 (b "&" 6 (b "#" 3 (b "!=" 2 (b "!" 1 N N) N) (b "#[" 5 (b "##>" 4 N N) N)) (b ")" 9 (b "(" 8 (b "&&" 7 N N) N) (b "+" 11 (b "*" 10 N N) N))) (b "->>" 18 (b "--" 15 (b "-" 14 (b "," 13 N N) N) (b "->" 17 (b "-->" 16 N N) N)) (b ".." 21 (b "." 20 (b "-[" 19 N N) N) (b "/" 22 N N)))) (b "=>" 34 (b "<<" 29 (b ";" 26 (b ":>" 25 (b ":=" 24 N N) N) (b "<:" 28 (b "<" 27 N N) N)) (b "=" 32 (b "<=>" 31 (b "<=" 30 N N) N) (b "==>" 33 N N))) (b "F" 40 (b ">=" 37 (b ">" 36 (b "=[" 35 N N) N) (b "?" 39 (b ">>" 38 N N) N)) (b "W" 43 (b "U" 42 (b "G" 41 N N) N) (b "X" 44 N N))))) (b "initially" 68 (b "between" 57 (b "`" 51 (b "]#>" 48 (b "]" 47 (b "\\" 46 N N) N) (b "]=>" 50 (b "]->" 49 N N) N)) (b "all" 54 (b "after" 53 (b "abstract" 52 N N) N) (b "before" 56 (b "and" 55 N N) N))) (b "finally" 63 (b "enum" 60 (b "else" 59 (b "disj" 58 N N) N) (b "final" 62 (b "eventually" 61 N N) N)) (b "in" 66 (b "if" 65 (b "globally" 64 N N) N) (b "initial" 67 N N)))) (b "or" 79 (b "next" 74 (b "max" 71 (b "lone" 70 (b "let" 69 N N) N) (b "mux" 73 (b "min" 72 N N) N)) (b "one" 77 (b "not" 76 (b "no" 75 N N) N) (b "opt" 78 N N))) (b "xor" 85 (b "then" 82 (b "sum" 81 (b "some" 80 N N) N) (b "weakuntil" 84 (b "until" 83 N N) N)) (b "||" 88 (b "|" 87 (b "{" 86 N N) N) (b "}" 89 N N)))))
   where b s n = let bs = id s
                  in B bs (TS bs n)

unescapeInitTail :: String -> String
unescapeInitTail = id . unesc . tail . id where
  unesc s = case s of
    '\\':c:cs | elem c ['\"', '\\', '\''] -> c : unesc cs
    '\\':'n':cs  -> '\n' : unesc cs
    '\\':'t':cs  -> '\t' : unesc cs
    '"':[]    -> []
    c:cs      -> c : unesc cs
    _         -> []

-------------------------------------------------------------------
-- Alex wrapper code.
-- A modified "posn" wrapper.
-------------------------------------------------------------------

data Posn = Pn !Int !Int !Int
      deriving (Eq, Show,Ord)

alexStartPos :: Posn
alexStartPos = Pn 0 1 1

alexMove :: Posn -> Char -> Posn
alexMove (Pn a l c) '\t' = Pn (a+1)  l     (((c+7) `div` 8)*8+1)
alexMove (Pn a l c) '\n' = Pn (a+1) (l+1)   1
alexMove (Pn a l c) _    = Pn (a+1)  l     (c+1)

type Byte = Word8

type AlexInput = (Posn,     -- current position,
                  Char,     -- previous char
                  [Byte],   -- pending bytes on the current char
                  String)   -- current input string

tokens :: String -> [Token]
tokens str = go (alexStartPos, '\n', [], str)
    where
      go :: AlexInput -> [Token]
      go inp@(pos, _, _, str) =
               case alexScan inp 0 of
                AlexEOF                   -> []
                AlexError (pos, _, _, _)  -> [Err pos]
                AlexSkip  inp' len        -> go inp'
                AlexToken inp' len act    -> act pos (take len str) : (go inp')

alexGetByte :: AlexInput -> Maybe (Byte,AlexInput)
alexGetByte (p, c, (b:bs), s) = Just (b, (p, c, bs, s))
alexGetByte (p, _, [], s) =
  case  s of
    []  -> Nothing
    (c:s) ->
             let p'     = alexMove p c
                 (b:bs) = utf8Encode c
              in p' `seq` Just (b, (p', c, bs, s))

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar (p, c, bs, s) = c

  -- | Encode a Haskell String to a list of Word8 values, in UTF8 format.
utf8Encode :: Char -> [Word8]
utf8Encode = map fromIntegral . go . ord
 where
  go oc
   | oc <= 0x7f       = [oc]

   | oc <= 0x7ff      = [ 0xc0 + (oc `Data.Bits.shiftR` 6)
                        , 0x80 + oc Data.Bits..&. 0x3f
                        ]

   | oc <= 0xffff     = [ 0xe0 + (oc `Data.Bits.shiftR` 12)
                        , 0x80 + ((oc `Data.Bits.shiftR` 6) Data.Bits..&. 0x3f)
                        , 0x80 + oc Data.Bits..&. 0x3f
                        ]
   | otherwise        = [ 0xf0 + (oc `Data.Bits.shiftR` 18)
                        , 0x80 + ((oc `Data.Bits.shiftR` 12) Data.Bits..&. 0x3f)
                        , 0x80 + ((oc `Data.Bits.shiftR` 6) Data.Bits..&. 0x3f)
                        , 0x80 + oc Data.Bits..&. 0x3f
                        ]
}
