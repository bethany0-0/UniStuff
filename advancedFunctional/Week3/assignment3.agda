module assignment3 where

-- Natural numbers

data Nat : Set where
  zero : Nat
  suc  : Nat → Nat

₀ = zero
₁ = suc ₀
₂ = suc ₁
₃ = suc ₂

_+'_ : Nat → Nat → Nat
zero  +' n = n
suc m +' n = suc (m +' n)

infixr 10 _+'_


-- Equality as an INDEXED type

data _≡_ {A : Set} : A → A → Set where
  refl : {x : A} → x ≡ x

cong-suc : ∀ m n → m ≡ n → suc m ≡ suc n
cong-suc m .m refl = refl 

-- basic properties of equality

trans-≡ : {A : Set} → (a b c : A) → a ≡ b → b ≡ c → a ≡ c
trans-≡ a .a .a refl refl = refl

sym-≡ : {A : Set} → (a b : A) → a ≡ b → b ≡ a
sym-≡ a .a refl = refl

cong-≡ : {A B : Set} → (a b : A) (f : A → B) → a ≡ b → f a ≡ f b
cong-≡ a .a p refl = refl


--------------------------Week 3 Assignment ----------
-- com moinoids are commutative, associative, and have an identity element.


-- prove from definition of +'
  -- _+'_ : Nat → Nat → Nat
  -- zero  +' n = n
  -- suc m +' n = suc (m + n)
nil-+ : (x : Nat) → (zero +' x) ≡ x 
nil-+  x = refl

+-nil : (x : Nat) → (x +' zero) ≡ x
+-nil zero = refl
-- cong 1 2 3 4
  -- prove 1 == 2 by 4. 4 reduces to zero which is fundamental proof. 3 is function that can be applied to 1 and 2 and they are stil equal
+-nil (suc x) = cong-≡ (x +' zero) x (suc) (+-nil x)


-- Informally :  xs + (ys + zs) = xs + (ys + zs)
-- We prove this by induction on xs
-- Base case is zero + (ys + zs) ≡  zero + (ys + zs), automatic from definition of +
-- Inductive case 
-- Inductive hypothesis :  xs + (ys + zs) ≡ xs + (ys + zs)                    (note IH in Agda)
-- WTP :  suc( xs) + (ys + zs) ≡ suc( xs) + (ys + zs)                           (note Goal in Agda)        
-- ... which we can immediately see that it is an application of the IH in context x âˆ· ...


+-ass : (x y z : Nat) → ((x +' y) +' z) ≡ (x +' (y +' z))
+-ass zero _ _ = refl
+-ass (suc x) y z = cong-≡ ((x +' y) +' z) (x +' (y +' z)) (suc) (+-ass x y z)


--commutative
-- cong-≡ param type suc (x +' y) ≡ suc (y +' x)
-- final param type   suc (y +' x) ≡ (y +' suc x)


--doing this makes it harder! need to call +-com from goal which you cannot from this point, also IH is never used
-- goal' : (x y : Nat) → suc (x +' y) ≡ (y +' suc x)
-- goal' zero y = {!!}
-- goal' x y = {!!}

-- +-com : (m n : Nat) → (m +' n) ≡ (n +' m)
-- +-com zero y = sym-≡ (y +' zero) y (+-nil y)
-- +-com (suc x) y = Goal where
--  IH : (x +' y) ≡ (y +' x)
--  IH = +-com x y
--  Goal : suc (x +' y) ≡ (y +' suc x)
--  Goal = goal' x y

+-com : (m n : Nat) → (m +' n) ≡ (n +' m)
+-com zero y = sym-≡ (y +' zero) y (+-nil y)
           -- requires type suc (x +' y) ≡ (y +' suc x) totlly
             -- use trans (nat) (nat) (nat) (suc (x +' y) ≡ suc (y +' x)) (suc (y +' x) ≡ (y +' suc x))
                    --- trans 1 2 3 (proof 1 == 2) (proof 2 = 3)
                                  
             -- hardone = (suc (y +' x) ≡ (y +' suc x)) = (suc y) + x move suc to x so y + suc x
+-com (suc x) y = trans-≡ (suc (x +' y)) (suc (y +' x)) (y +' suc x) (cong-≡ (x +' y) (y +' x) (suc) (+-com x y)) (hardOne y x) where
           hardOne : (x' y' : Nat) → suc (x' +' y') ≡ (x' +' suc y')
           hardOne zero y' = refl
                   -- switch around y and x so x = 0 above
                             -- reapplying the suc in cong as it is taken away from parameter x'
           hardOne (suc x') y' = cong-≡ (suc x' +' y') (x' +' suc y') suc (hardOne x' y')
