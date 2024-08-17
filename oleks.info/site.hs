--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import qualified DT as DT


--------------------------------------------------------------------------------
main :: IO ()
main = do
  timestamp <- DT.timestamp
  let defaultCtx =
        constField "time" timestamp `mappend`
        constField "header" "Oleks" `mappend`
        defaultContext

  hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["research.rst", "teaching.rst", "industry.rst", "projects.rst"]) $ do
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

    match "contact.html" $ do
        route idRoute
        compile $ do
            let contactCtx =
                    constField "title" "Contact"            `mappend`
                    defaultCtx

            getResourceBody
                >>= applyAsTemplate contactCtx
                >>= loadAndApplyTemplate "templates/default.html" contactCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler


--------------------------------------------------------------------------------
