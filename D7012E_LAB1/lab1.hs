import Data.List

list :: [Int]
list = [1, 1, 1, 1, 1, 4, 4,4,4,4, 2, -1, 3]

-- Two "input-lists", to one result-list
unique :: [Int] -> [Int] -> [Int]
-- Base case, when input list is empty, result-list is done.
unique [] y = reverse y

-- Split input list (head and tail). 
-- x is the first element (head), xs is the tail. Y is result-list, initialy empty.
unique (x:xs) y
-- Compares head-element with all elements in Y.
-- If element is not unique, continue comparisson with tail-list.
-- Otherwise, put head-element in result-list
	| x `elem` y = unique xs y
	| otherwise = unique xs (x:y)


kmaxsubunique :: [Int] -> Int -> [(Int, Int, Int)]
-- x is list, k is numer of tripplets
-- sorts after first element in tripplet
-- reverses into decreasing order (largest sum first)
-- takes k sums
kmaxsubunique x k = take k $ reverse $ sort (findsubsec (unique x []) 0 0)


findsubsec :: [Int] -> Int -> Int -> [(Int, Int, Int)]
-- Base case, if the list is empty, return empty list (don't care about pointers here)
findsubsec [] _ _ = []
-- pattern matching
findsubsec x p1 p2
-- check so that max-pointer is in the end of the list
-- base-case: if first pointer is in the end of the list, create a list of tripplets
-- if last-pointer is in the end of the list, create a tripplet of elements p1:p2
	-- and concatinate it with next subset
	-- - start over to find next subset, move pointers one step
-- otherwise create tripplets until we reach base case, then concatinate all heads to a list
	| (length x) == (p1+1) = [(createtripplet x p1 p2)]
	| (length x) == (p2+1) = (createtripplet x p1 p2):findsubsec x (p1+1) (p1+1)
	| otherwise = (createtripplet x p1 p2):findsubsec x p1 (p2+1)


createtripplet :: [Int] -> Int -> Int -> (Int, Int, Int)
-- drop removes elements below index p1, take keeps p2+1 elements
-- sum calculates sum of the chosen elements.
-- performs tasks right->left
createtripplet x p1 p2 = (sum $ drop p1 $ take (p2+1) x, (p1+1), (p2+1))


main = print (kmaxsubunique list 3)

