-- Robert Russo & Robert Rotering
-- Programming Languages Fall 2016

import PA1Helper

-- ID
id' :: Lexp -> Lexp
id' v@(Atom _) = v
id' lexp@(Lambda (Atom _) _) = lexp
id' lexp@(Apply _ _) = lexp

-- Alpha Renaming
alpha :: Lexp -> Lexp
alpha v@(Atom _) = v
alpha lexp@(Lambda (Atom a) (Atom b))
  | (Atom a) == (Atom b) = (Lambda (Atom (a ++ "1")) (Atom(b ++ "1")))
  | otherwise = lexp
alpha lexp@(Lambda (Atom a) (Lambda (Atom b) c)) = (Lambda (Atom a) (alpha (Lambda (Atom b) c))) --alphaExt (Atom a) (alpha (Lambda (Atom b) c))
alpha lexp@(Lambda (Atom a) (Apply (Atom b) (Atom c)))
  | (Atom a) == (Atom b) && (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Apply (Atom (b ++ "1")) (Atom (c ++ "1"))))
  | (Atom a) == (Atom b) = (Lambda (Atom (a ++ "1")) (Apply (Atom (b ++ "1")) (Atom c)))
  | (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Apply (Atom b) (Atom (c ++ "1"))))
  | otherwise = lexp
alpha lexp@(Apply a b) = (Apply (alpha a) (alpha b))
alpha lexp@(_) = lexp

-- Alpha Helper
alphaExt :: Lexp -> Lexp -> Lexp
alphaExt v@(Atom a) lexp@(Lambda (Atom b) subExp@(Lambda c d)) = alphaExt v (alphaExt (Atom b) subExp) -- likely a loop
alphaExt v@(Atom a) lexp@(Lambda (Atom b) (Atom c))
  | (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Lambda (Atom b) (Atom (c ++ "1"))))
  | (Atom a) == (Atom b) = (Lambda (Atom (a ++ "1")) (Lambda (Atom (b ++ "1")) (Atom c)))
  | otherwise = (Lambda v lexp)
alphaExt v@(Atom a) lexp@(Lambda (Atom y) (Apply (Atom b) (Atom c)))
  | (Atom a) == (Atom b) && (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Atom (b ++ "1")) (Atom (c ++ "1")))))
  | (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Atom b) (Atom (c ++ "1")))))
  | (Atom a) == (Atom b) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Atom (b ++ "1")) (Atom c))))
  | otherwise = (Lambda v lexp)
alphaExt v@(Atom a) lexp@(Lambda (Atom y) (Apply (Apply (Atom b) (Atom c)) (Atom d)))
  | (Atom a) == (Atom b) && (Atom a) == (Atom c) && (Atom a) == (Atom d) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom (b ++ "1")) (Atom (c ++ "1"))) (Atom (d ++ "1")))))
  | (Atom a) == (Atom b) && (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom (b ++ "1")) (Atom (c ++ "1"))) (Atom d))))
  | (Atom a) == (Atom b) && (Atom a) == (Atom d) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom (b ++ "1")) (Atom c)) (Atom (d ++ "1")))))
  | (Atom a) == (Atom c) && (Atom a) == (Atom d) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom b) (Atom (c ++ "1"))) (Atom (d ++ "1")))))
  | (Atom a) == (Atom b) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom (b ++ "1")) (Atom c)) (Atom d))))
  | (Atom a) == (Atom c) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom b) (Atom (c ++ "1"))) (Atom d))))
  | (Atom a) == (Atom d) = (Lambda (Atom (a ++ "1")) (Lambda (Atom y) (Apply (Apply (Atom b) (Atom c)) (Atom (d ++ "1")))))
  | otherwise = (Lambda v lexp)

-- Beta Reduction
beta :: Lexp -> Lexp
beta v@(Atom _) = v
beta lexp@(Lambda (Atom _) _) = lexp
beta lexp@(Apply (Atom _) _) = lexp
beta lexp@(Apply subExp@(Lambda x e) m) = betaExt x e m
beta lexp@(Apply subExp@(Apply a b) c) = beta (Apply (beta subExp) c)

-- Beta Helper
betaExt :: Lexp -> Lexp -> Lexp -> Lexp
betaExt x@(Atom _) e@(Atom _) m
  | x == e = m
  | otherwise = e
betaExt x@(Atom _) (Lambda a subExp@(Apply b c)) m
  | a == c = betaExt x b m
  | x == b = beta (Lambda a (Apply m c))
  | x == c = beta (Lambda a (Apply b m))
  | otherwise = betaExt x (eta subExp) m
betaExt x@(Atom _) subExp@(Lambda (Atom a) b) m
  | x == b = (Lambda (Atom a) m)
  | otherwise = betaExt x (eta(Lambda (Atom a) (b))) m
betaExt x@(Atom _) (Apply a b) m
  | x == a && x == b = (Apply m m)
  | x == a = (Apply m b)
  | x == b = (Apply a m)
  | otherwise = x
betaExt x@(_) y@(_) z@(_) = (Apply (Lambda x y) z)

-- Eta Reduction
eta :: Lexp -> Lexp
eta v@(Atom _) = v
eta lexp@(Lambda (Atom x) subExp@(Lambda _ _)) = (Lambda (Atom x) (eta subExp))
eta lexp@(Lambda (Atom x) (Apply e m))
  | (Atom x) == m = eta e
  | otherwise = lexp
eta lexp@(Lambda (Atom _) _) = lexp
eta lexp@(Apply a b) = beta (Apply (eta a) (eta b))


-- Entry point of program
main = do
    putStrLn "Please enter a filename containing lambda expressions:"
    fileName <- getLine
    runProgram fileName (eta . beta . alpha)
