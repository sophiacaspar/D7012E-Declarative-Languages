module Program(T, parse, fromString, toString, exec) where
import Parser hiding (T)
import qualified Statement
import qualified Dictionary
import Prelude hiding (return, fail)
newtype T = Program [Statement.T] -- to be defined
instance Parse T where
  
  -- Creates a list of statements and send it to run as program
	parse = (iter Statement.parse) >-> Program

-- Every statement in program-list is transformed into a string
	toString (Program (x:xs)) = Statement.toString x ++ toString (Program xs)
	toString (Program []) = ""

--exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]    
-- Defines how an exec should work. It takes a Program with list of statements and an integer-list.
-- Then executes with list of statements, creates an empty dictionary, and intlList
exec (Program lst) intLst = Statement.exec lst Dictionary.empty intLst
