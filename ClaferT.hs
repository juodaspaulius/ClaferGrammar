module ClaferT where

import Control.Monad.Error
import Control.Monad.State
import Control.Monad.Identity
import Data.List
import Data.Map (Map)
import qualified Data.Map as Map

import Absclafer

data ClaferEnv = ClaferEnv {
                            modelFrags :: [String], -- original text of the model fragments
                            cAst :: Maybe Module,
                            frags :: [Pos]    -- line numbers of fragment markers
                            } deriving Show


makeEnv :: ClaferEnv
makeEnv = ClaferEnv {
                           modelFrags = [],
                           cAst = Nothing,
                           frags = []
                           }

-- | Get the ClaferEnv
getEnv :: Monad m => ClaferT m ClaferEnv
getEnv = get

getsEnv :: Monad m => (ClaferEnv -> a) -> ClaferT m a
getsEnv = gets

-- | Modify the ClaferEnv
modifyEnv :: Monad m => (ClaferEnv -> ClaferEnv) -> ClaferT m ()
modifyEnv = modify

-- | Set the ClaferEnv. Remember to set the env after every change.
putEnv :: Monad m => ClaferEnv -> ClaferT m ()
putEnv = put


voidf :: Monad m => m t -> m ()
voidf f = do
  _ <- f
  return ()

-- | Monad for using Clafer.
type ClaferM = ClaferT Identity

-- | Monad Transformer for using Clafer.
type ClaferT m = ErrorT ClaferErrs (StateT ClaferEnv m)

type ClaferErr = CErr ErrPos
type ClaferErrs = CErrs ErrPos

-- | Possible errors that can occur when using Clafer
-- | Generate errors using throwErr/throwErrs:
data CErr p =
  -- | Generic error
  ClaferErr {
    msg :: String
  } |
  -- | Error generated by the parser
  ParseErr {
    -- | Position of the error
    pos :: p,
    msg :: String
  } |
  -- | Error generated by semantic analysis
  SemanticErr {
    pos :: p,
    msg :: String
  }
  deriving Show

-- | Clafer keeps track of multiple errors.
data CErrs p =
  ClaferErrs {errs :: [CErr p]}
  deriving Show

instance Error (CErr p) where
  strMsg = ClaferErr

instance Error (CErrs p) where
  strMsg m = ClaferErrs [strMsg m]

data ErrPos =
  ErrPos {
    -- | The fragment where the error occurred.
    fragId :: Int,
    -- | Error positions are relative to their fragments.
    -- | For example an error at (Pos 2 3) means line 2 column 3 of the fragment, not the entire model.
    fragPos :: Pos,
    -- | The error position relative to the model.
    modelPos :: Pos
  }
  deriving Show

{-class Throwable t where-}
  {-toErr :: t -> Monad m => ClaferT m ClaferErr-}

{-instance Throwable (CErr p) where-}
  {-toErr (ClaferErr mesg) = return $ ClaferErr mesg-}
  {-toErr err = return $ -}
    {-do-}
      {-pos' <- toErrPos $ pos err-}
      {-return $ err{pos = pos'}-}

-- | Throw many errors.
throwErrs :: (Monad m) => [CErr ErrPos] -> ClaferT m a
throwErrs throws = throwError $ ClaferErrs throws
  {-do-}
    {-errors <- mapM toErr throws-}
    {-throwError $ ClaferErrs throws-}

-- | Throw one error.
throwErr :: (Monad m) => CErr ErrPos -> ClaferT m a
throwErr throw = throwErrs [throw]

-- | Catch errors
catchErrs :: Monad m => ClaferT m a -> ([ClaferErr] -> ClaferT m a) -> ClaferT m a
catchErrs e h = e `catchError` (h . errs)

addPos :: Pos -> Pos -> Pos
addPos (Pos l c) (Pos 1 d) = Pos l (c + d - 1)    -- Same line
addPos (Pos l _) (Pos m d) = Pos (l + m - 1) d    -- Different line
minusPos :: Pos -> Pos -> Pos
minusPos (Pos l c) (Pos 1 d) = Pos l (c - d + 1)  -- Same line
minusPos (Pos l c) (Pos m _) = Pos (l - m + 1) c  -- Different line

inSpan :: Pos -> Span -> Bool
inSpan pos' (Span start end) = pos' >= start && pos' <= end


runClaferT :: Monad m => ClaferT m a -> m (Either [ClaferErr] a)
runClaferT exec =
  mapLeft errs `liftM` evalStateT (runErrorT exec) makeEnv
  where
  mapLeft :: (a -> c) -> Either a b -> Either c b
  mapLeft f (Left l) = Left (f l)
  mapLeft _ (Right r) = Right r


