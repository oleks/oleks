module DT where

import Data.Time
import Data.Functor

timestamp :: IO String
timestamp = do
    getCurrentTime <&>
        formatTime defaultTimeLocale "%Y-%m-%d %H:%M %Z"
