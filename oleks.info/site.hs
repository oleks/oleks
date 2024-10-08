--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import qualified DT as DT


--------------------------------------------------------------------------------
main :: IO ()
main = do
  datestamp <- DT.datestamp
  let defaultCtx =
        constField "date" datestamp `mappend`
        constField "header" "Oleks" `mappend`
        defaultContext

  hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList [
      "research.rst",
      "teaching.rst",
      "industry.rst",
      "programming.md",
      "education.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultCtx
            >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            getResourceBody
                >>= applyAsTemplate defaultCtx
                >>= loadAndApplyTemplate "templates/default.html" defaultCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
