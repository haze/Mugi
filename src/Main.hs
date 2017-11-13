module Main where
import           Data.List          (intercalate)
import           Data.List.Split    (splitOn)
import qualified Data.Maybe         as M
import           System.Directory   (doesFileExist, getCurrentDirectory,
                                     removeFile)
import           System.Environment (getArgs)
import           System.IO.Temp     (writeSystemTempFile)
import qualified System.Process     as P

cPrelude :: Int -> String
cPrelude n = "unsigned char t[" ++ show n ++ "], p;"

source :: Int -> String
source tapeLength = "#include <stdio.h>\n" ++ cPrelude tapeLength ++ "\nint main()\n{"

endSource :: String
endSource = "}"

toAction :: Char -> Maybe String
toAction x
  | z 'p' = Just "++t[p]"
  | z 'r' = Just "++p"
  | z 'l' = Just "--p"
  | z 'm' = Just "--t[p]"
  | z 'o' = Just "putchar(t[p])"
  | otherwise = Nothing
  where z = (==) x

run :: [String] -> IO ()
run x
  | null x = putStrLn "No input files found."
  | length x == 1 = run' $ head x
  | otherwise = putStrLn "usage: mugi <file>"

writeToFile :: String -> String -> IO ()
writeToFile filename str = do
  path <- writeSystemTempFile "mugi_source.c" str
  cwd <- getCurrentDirectory
  putStrLn (cwd ++ "/" ++ filename)
  exitCode <- P.system ("gcc -Ofast -o " ++ cwd ++ "/" ++ filename ++ " " ++ path)
  removeFile path
  putStrLn $ "Exit Code: " ++ show exitCode

run' :: String -> IO ()
run' filename = do
  content <- readFile filename
  let actions = map toAction $ init content
  if any M.isNothing actions then putStrLn "Unknown Character Found"
  else writeToFile (head (splitOn "." (last (splitOn "/" filename)))) (source 500 ++ intercalate "\n" (map ((++ ";") . M.fromJust) actions) ++ endSource)

main :: IO ()
main = getArgs >>= run
