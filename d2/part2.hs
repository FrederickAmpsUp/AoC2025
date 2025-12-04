import Data.Fixed (mod')
import Debug.Trace (trace)

num_digits :: Int -> Int
num_digits x = floor (logBase 10 (fromIntegral x)) + 1

is_repeated :: Int -> Int -> Int
is_repeated a n =
  if (num_digits a) <= n then
    if (num_digits a) == n then 1
      else 0
  else
    let r2 = a `mod` (10 ^ (n * 2))
        ls = r2 `div` (10 ^ n)
        rs = r2 `mod` (10 ^ n)
        result = if ls == rs then 1 else 0
    in (is_repeated ((a `div` (10 ^ n))) n) * result
  

check_nd :: Int -> Int -> Int
check_nd a 0 = 0
check_nd a n =
  if ((num_digits a) `mod` n) /= 0 then check_nd a (n-1)
    else let failed = trace ("num " ++ (show a) ++ " dl " ++ (show n) ++ " r " ++ (show (is_repeated a n))) is_repeated a n
      in if failed == 1 then 1
        else check_nd a (n-1)

num :: Int -> Int -> Int
num _ (-1) = 0
num a b =
  let id = a + b
  in (num a (b-1)) + (id * (check_nd id (num_digits id - 1)))

range :: String -> Int
range "" = 0
range s = 
  let (aS, bSD) = break (== '-') s
      a = read aS
      b = read (tail bSD)
  in num a (b-a)

process :: String -> Int
process "" = 0
process s =
  let (first, rest) = break (== ',') s
      rest' = if null rest then "" else tail rest
  in (range first) + (process rest')

main :: IO()
main = do
  input <- readFile "input.txt"
  print "Going"
  print (process input)
