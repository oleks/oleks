module DT where

import Data.Time

timestamp :: IO String
timestamp = do
    fmap show getCurrentTime