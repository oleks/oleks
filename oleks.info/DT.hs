module DT where

import Data.Time
import Data.Functor

datestamp :: IO String
datestamp = do
    getCurrentTime <&>
        formatTime defaultTimeLocale "%Y-%m-%d"
