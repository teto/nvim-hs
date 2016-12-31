module Fibonacci.Plugin where

import Neovim

fib :: Int -> Neovim' String
fib n = return . show $ fibs !! n
  where
    fibs = 0:scanl (+) 1 fibs

brokenFib :: Int -> Neovim' String
brokenFib n = error "Expecting this to be caught."
