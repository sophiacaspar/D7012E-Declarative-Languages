module Statement(T, parse, toString, fromString, exec) where
import Prelude hiding (return, fail)
import Parser hiding (T)
import qualified Dictionary
import qualified Expr
type T = Statement

-- All statements and its inputs
data Statement =
    Assignment String Expr.T 
	|	Skip 
	|	Begin [Statement]
	|   If Expr.T Statement Statement 
	|	While Expr.T Statement
	|	Read String
	|	Write Expr.T
		deriving Show

-- assigns a value to a variable. 
-- Looks for a variable with := after (which is removed)
-- Then runs the expression after. Require ; but removes it for build.
assignment = word #- accept ":=" # Expr.parse #- require ";" >-> buildAss
buildAss (v, e) = Assignment v e

-- Builds a skip. Looks for "skip" in beginning, then skip.
skip = accept "skip" # require ";" >-> buildSkip
buildSkip _ = Skip

-- Looks for "begin" and then iter over a list of statements. 
begin = accept "begin" -# iter (parse) #- require "end" >-> buildBegin
buildBegin stmts = Begin stmts

-- Looks for an "if" in the beginning, then run the statements which follows
ifStmt = accept "if" -# (Expr.parse #- require "then" # parse) # (require "else" -# parse) >-> buildIf
buildIf ((c, t), e) = If c t e

-- Looks for a "while" in the beginning, then builds while with expression and a runstatement
while = accept "while" -# Expr.parse #- require "do" # parse >-> buildWhile
buildWhile (c, s) = While c s

-- Looks for a "read" in the beginning, then builds read with a string word
readStmt = accept "read" -# word #- require ";" >-> buildRead
buildRead str = Read str

-- Looks for a "write" in the beginning and builds write with an expression
write = accept "write" -# Expr.parse #- require ";" >-> buildWrite
buildWrite e = Write e


-- Defines what all statements should do and how they execute
exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]

-- Base case when list is empty
exec [] dict input = []

-- Pattern matching for if.
-- If head of statements is If, take three following inputs as 1 condition and 2 statements
exec (If cond thenStmts elseStmts: stmts) dict input = 
-- Checks towards a value and condition, ex count in dictionary, if value is greater than 0,
-- execute first statement, else execute second
	if (Expr.value cond dict)>0 
	then exec (thenStmts: stmts) dict input
	else exec (elseStmts: stmts) dict input

-- Should just skip input. 
-- Executes rest of input, but doesn't do anything cool with it
exec (Skip :stmts) dict input =
	exec stmts dict input

-- If head in statementlist is read, save first input as variable
exec (Read var :stmts) dict (input:rest) =
	-- Execute rest of the statements, save variable and input in dictionary
	exec stmts (Dictionary.insert (var,input) dict) rest

-- Saves new value in input-list
exec (Write cond: stmts) dict input = 
	(Expr.value cond dict) : (exec stmts dict input)

-- begin executes all statements in input list
exec (Begin lst : stmts) dict input =
	exec (lst++stmts) dict input

-- Executes as long as value is greater than 0.
-- If true then recursive call to while again, and execute run statements.
-- Else stop while-loop
exec (While cond runStmts : stmts) dict input = 
	if (Expr.value cond dict) > 0
	then exec (runStmts:(While cond runStmts):stmts) dict input
	else exec stmts dict input

-- Executes an assignment statement, some string (variable) gets assigned a value
-- The variable is inserted in thhe dictionary with its corresponding expression-value
exec (Assignment str e : stmts) dict input =
	exec stmts (Dictionary.insert (str, (Expr.value e dict)) dict) input

-- Defines all parse-statements that can be used
instance Parse Statement where
	parse = skip ! ifStmt ! assignment ! begin ! while ! readStmt ! write

-- Defines how every statement should print its string according to TestProgram
	toString Skip = "skip;\n"
	toString (If cond thenStmts elseStmts) = "if " ++ (Expr.toString cond) ++ " then\n" ++ (toString thenStmts) ++ "else\n" ++ (toString elseStmts)
	toString (Read var) = "read " ++ var ++ ";\n"
	toString (Write cond) = "write " ++ (Expr.toString cond) ++ ";\n"
	toString (Begin lst) = "begin\n" ++ (helpToString lst) ++ "end\n"
	toString (While cond runStmts) = "while " ++ (Expr.toString cond) ++ " do\n" ++ (toString runStmts)
	toString (Assignment str e) = str ++ " := " ++ (Expr.toString e) ++ ";\n"
	toString _ = "" -- <-- Base case

-- Help function to convert all statements in a list into a string
helpToString (x:xs) = (toString x) ++ (helpToString xs)
helpToString [] = ""


