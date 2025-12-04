import Data.Fixed (mod')
-- import Debug.Trace (trace)

num_digits :: Int -> Int
num_digits x = floor (logBase 10 (fromIntegral x)) + 1

is_invalid_id :: Int -> Int
is_invalid_id a = 
  let nd = num_digits a
      hn = nd `div` 2
      pw = 10 ^ hn
      ls = a `div` pw
      rs = a `mod` pw
  in (if ls == rs then 1 else 0)

num :: Int -> Int -> Int
num _ (-1) = 0
num a b =
  (num a (b-1)) + ((a + b) * (is_invalid_id (a + b)))

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
  print (process input)
