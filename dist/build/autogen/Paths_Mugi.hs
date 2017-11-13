{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_Mugi (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/haze/Library/Haskell/bin"
libdir     = "/Users/haze/Library/Haskell/ghc-8.0.2-x86_64/lib/Mugi-0.1.0.0"
dynlibdir  = "/Users/haze/Library/Haskell/ghc-8.0.2-x86_64/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/haze/Library/Haskell/share/ghc-8.0.2-x86_64/Mugi-0.1.0.0"
libexecdir = "/Users/haze/Library/Haskell/libexec"
sysconfdir = "/Users/haze/Library/Haskell/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Mugi_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Mugi_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Mugi_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Mugi_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Mugi_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Mugi_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
