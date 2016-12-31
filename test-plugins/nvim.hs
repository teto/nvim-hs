{-# LANGUAGE LambdaCase #-}
import           Control.Concurrent      (killThread, takeMVar)
import           Neovim
import qualified Neovim.Context.Internal as Internal
import           Neovim.Main             (realMain)

import           Fibonacci

main :: IO ()
main = realMain transitionHandler Nothing defaultConfig
    { plugins = [ Fibonacci.plugin ]
    }
  where
    transitionHandler tids cfg = takeMVar (Internal.transitionTo cfg) >>= \case
      Internal.InitSuccess ->
          transitionHandler tids cfg

      _ ->
          mapM_ killThread tids

