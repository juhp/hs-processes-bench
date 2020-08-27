{-# LANGUAGE OverloadedStrings #-}

import Criterion (bench, nfIO)
import Criterion.Main (defaultMain)

import qualified System.Process as P

import qualified Data.ByteString.Lazy.Char8 as B
import qualified System.Process.Typed as T

main :: IO ()
main = defaultMain
  [ bench "P.readProcess" $ nfIO (dirFiles readProcessLines)
  , bench "T.readProcess_" $ nfIO (dirFiles readProcess_Lines)
  ]

-- command :: (String -> [String] -> IO [a]) -> String -> [String]
--         -> IO [a]
-- command cmd c args =
--   cmd c args

dirFiles :: (String -> [String] -> IO [a]) -> IO [a]
dirFiles cmd =
  cmd "ls" ["."]

readProcessLines :: String -> [String] -> IO [String]
readProcessLines c args =
  lines <$> P.readProcess c args ""

readProcess_Lines :: String -> [String] -> IO [B.ByteString]
readProcess_Lines c args =
  let p = T.proc c args
  in do
    (out,_err) <- T.readProcess_ p
    return $ B.lines out
