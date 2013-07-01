import Data.Char
import Data.List
import Data.Bits (xor)
import Data.Ord (comparing)

problem52 = head $ [x | x<-testNos, sameDig x (2*x), sameDig x (3*x), sameDig x (4*x),
                                    sameDig x (5*x), sameDig x (6*x)]
    where getNosToTest n = takeWhile (<(17 * 10^n)) [10^(n+1)..]
          sameDig x n = (sort.show) x == (sort.show) n
          testNos = concatMap getNosToTest [1..]

problem53 = length $ [1| x<-[1..100], y<-[1..x], (choose x y) > 1000000]
    where choose n k = fac n `div` (fac (n-k) * fac k)
          fac 0 = 1
          fac x = product [1..x]

problem56 = maximum $ [digitSum (a^b)| a<-[1..99], b<-[1..99] ]
    where digitSum n = sum $ map (digitToInt) (show n)

problem59 = do
    inFile <- readFile "p59.dat"
    let ctext = read inFile :: [Int]
    let c1 = [ctext!!n | n<-[0,3..(length ctext - 1)]]
    let c2 = [ctext!!n | n<-[1,4..(length ctext - 1)]]
    let c3 = [ctext!!n | n<-[2,5..(length ctext - 1)]]

    let ptext = decrypt (map findKeyNum [c1,c2,c3])  ctext
    print $ sum $ map (ord) ptext
    where
        findKeyNum c = fst $ maximumBy (comparing snd) [(k, (numLcase $ (decrypt [k] c))) | k<-[97..122] ]
        decrypt k c = map (\x -> chr ((fst x) `xor` (snd x))) $ zip (cycle k) c
        numLcase x = length $ filter isAlpha x
