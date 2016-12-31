{-# LANGUAGE TemplateHaskell #-}
module Fibonacci where

import Neovim

import Fibonacci.Plugin

plugin :: Neovim (StartupConfig NeovimConfig) () NeovimPlugin
plugin = wrapPlugin $ Plugin
    { exports = [ $(function' 'fib) Sync
                , $(function' 'brokenFib) Sync
                ]
    , statefulExports = []
    }
