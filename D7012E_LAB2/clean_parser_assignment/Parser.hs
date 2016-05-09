module Parser(module CoreParser, T, digit, digitVal, chars, letter, err,
              lit, number, iter, accept, require, token,
              spaces, word, (-#), (#-)) where
import Prelude hiding (return, fail)
import Data.Char
import CoreParser
infixl 7 -#, #- 

type T a = Parser a

-- writes out an error message
err :: String -> Parser a
err message cs = error (message++" near "++cs++"\n")

-- iterates a parser until it fails. 
-- iter digit "123hej" --> Just ("123","hej")
iter :: Parser a -> Parser [a]  
iter m = m # iter m >-> cons ! return [] 

cons(a, b) = a:b

-- Runs both parser-functions, only return result from second call
(-#) :: Parser a -> Parser b -> Parser b
(m -# n) cs = ((m # n) >-> snd) cs

-- Runs both parser-functions, only return result from first call
(#-) :: Parser a -> Parser b -> Parser a
(m #- n) cs = ((m # n) >-> fst) cs

-- Takes all spaces before string, return rest of string
-- ("     hej") ---> Just ("      ","hej")
spaces :: Parser String
spaces cs =  iter (char ? isSpace) cs

-- Removes spaces after accepted string
token :: Parser a -> Parser a
token m = m #- spaces

-- Checks if first char in string is a character
-- Returns Just ('h',"ej") if true for example
-- And "nothing" if false
letter :: Parser Char
letter =  char ? isAlpha

-- Concatinates result chars to string
word :: Parser String
word = token (letter # iter letter >-> cons)

-- Returns n number of characters from string
chars :: Int -> Parser String
-- When n is zero, return list of wanted characters
chars 0 = return []
-- takes one char n times recursivly an then concatinate all chars into a list
-- Removes all paranthesis and put elements in one list
chars n = (char # chars (n-1)) >-> cons

-- Checks if one string exists in input string
-- accept "h" "hej" --> Just ("h","ej")
accept :: String -> Parser String
accept w = (token (chars (length w))) ? (==w)

-- Gives you feedback/errormsg, instead of just nothing when using accept
require :: String -> Parser String
require w = accept w ! (error ("Program error: Expecting " ++ w ))

-- Checks if char equals first letter in string, if so send it to token
lit :: Char -> Parser Char
lit c = token char ? (==c)

-- Checks if first char in string is a digit
-- Just ('9',"hej") if true
-- Returns "nothing" if false
digit :: Parser Char 
digit = char ? isDigit 

-- Takes a string, and if the first char is digit then an integer is returned
-- digitVal "123" --> Just (1,"23")
digitVal :: Parser Integer
digitVal = digit >-> digitToInt >-> fromIntegral

number' :: Integer -> Parser Integer
number' n = digitVal #> (\ d -> number' (10*n+d))
          ! return n

-- Converts a string of integers to integer
number :: Parser Integer
number = token (digitVal #> number')

