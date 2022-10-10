# This lesson is meant to be a short introduction to logical operations in R.

#There are two logical values in R, also called boolean values. They are TRUE  
# and FALSE. In R you can construct logical expressions which will evaluate to 
# either TRUE or FALSE

#Creating logical expressions requires logical operators. You're probably 
# familiar with arithmetic operators like `+`, `-`, `*`, and `/`. The first 
# logical operator we are going to discuss is the equality operator, represented 
# by two equals signs `==`. Use the equality operator below to find out if TRUE 
# is equal to TRUE.

TRUE == TRUE # [1] TRUE

# Just like arithmetic, logical expressions can be grouped by parenthesis so 
# that the entire expression (TRUE == TRUE)  == TRUE evaluates to TRUE.

(FALSE == TRUE) == FALSE # [1] TRUE
6 == 7 # [1] FALSE

#The less than operator `<` tests whether the number on the left side of the 
# operator (called the left operand) is less than the number on the right side 
# of the operator (called the right operand). Write an expression to test 
# whether 6 is less than 7.

6 < 7 # [1] TRUE

#There is also a less-than-or-equal-to operator `<=` which tests whether the 
# left operand is less than or equal to the right operand. Write an expression 
# to test whether 10 is less than or equal to 10.

10 <= 10 # [1] TRUE

#The next operator we will discuss is the 'not equals' operator represented 
# by `!=`. Not equals tests whether two values are unequal, so TRUE != FALSE 
# evaluates to TRUE. Like the equality operator, `!=` can also be used with
# numbers. Try writing an expression to see if 5 is not equal to 7.

5 != 7 # [1] TRUE

#In order to negate boolean expressions you can use the NOT operator. An 
# exclamation point `!` will cause !TRUE (say: not true) to evaluate to FALSE 
# and !FALSE (say: not false) to evaluate to TRUE. Try using the NOT operator 
# and the equals operator to find the opposite of whether 5 is equal to 7.

!(5==7) #[1] TRUE
(TRUE != FALSE) == !(6 == 7) # [1] FALSE 

#Let's look at how the AND operator works. There are two AND operators in R, 
# `&` and `&&`. Both operators work similarly, if the right and left operands 
# of AND are both TRUE the entire expression is TRUE, otherwise it is FALSE.
# For example, TRUE & TRUE evaluates to TRUE. Try typing FALSE & FALSE to how 
# it is evaluated.

FALSE & FALSE # [1] FALSE

#You can use the `&` operator to evaluate AND across a vector. The `&&` version 
# of AND only evaluates the first member of a vector. Let's test both for 
# practice. Type the expression TRUE & c(TRUE, FALSE, FALSE).

TRUE & c(TRUE, FALSE, FALSE) # [1] TRUE FALSE FALSE

#What happens in this case is that the left operand `TRUE` is recycled across 
# every element in the vector of the right operand. This is the equivalent 
# statement as c(TRUE, TRUE, TRUE) & c(TRUE, FALSE, FALSE).

TRUE && c(TRUE, FALSE, FALSE) #[1] TRUE
                              #Warning message:
                              # In TRUE && c(TRUE, FALSE, FALSE) :
                              # 'length(x) = 3 > 1' in coercion to 'logical(1)'

#In this case, the left operand is only evaluated with the first member of the 
# right operand (the vector). The rest of the elements in the vector aren't 
# evaluated at all in this expression.

#The OR operator follows a similar set of rules. The `|` version of OR 
# evaluates OR across an entire vector, while the  `||` version of OR only 
# evaluates the first member of a vector.
#An expression using the OR operator will evaluate to TRUE if the left operand 
# or the right operand is TRUE. If both are TRUE, the expression will evaluate 
# to TRUE, however if neither are TRUE, then the expression will be FALSE.

TRUE | c(TRUE, FALSE, FALSE) # [1] TRUE TRUE TRUE
TRUE || c(TRUE, FALSE, FALSE) # TRUE

#Logical operators can be chained together just like arithmetic operators. The 
# expressions: `6 != 10 && FALSE && 1 >=  2` or `TRUE || 5 < 9.3 || FALSE` are 
# perfectly normal to see.

5>8 || 6 != 8 && 4 >3.9 # [1] TRUE

#Let's walk through the order of operations in the above case. First the left 
# and right operands of the AND operator are evaluated. 6 is not equal 8, 4 is 
# greater than 3.9, therefore both operands are TRUE so the resulting expression
# `TRUE && TRUE` evaluates to TRUE. Then the left operand of the OR operator is 
# evaluated: 5 is not greater than 8 so the entire expression is reduced to 
# FALSE || TRUE. Since the right operand of this expression is TRUE the entire
# expression evaluates to TRUE.

TRUE && FALSE || 9 >= 4 && 3 < 6 # FALSE || TRUE && FALSE --> FALSE || FALSE --> [1] FALSE
FALSE || TRUE && FALSE # FALSE || FALSE --> FALSE
TRUE && 62 < 62 && 44 >= 44 # TRUE && FALSE && TRUE --> [1] FALSE
99.99 > 100 || 45 < 7.3 || 4 != 4.0 # FALSE || FALSE || TRUE --> [1] TRUE
!(8 > 4) ||  5 == 5.0 && 7.8 >= 7.79 # FALSE || TRUE && TRUE -->  [1] TRUE
FALSE || TRUE && 6 != 4 || 9 > 4 # FALSE || TRUE && FALSE || TRUE --> FALSE || FALSE || TRUE --> [1] TRUE
6 >= -9 && !(6 > 7) && !(!TRUE)  # TRUE && TRUE && TRUE --> [1] TRUE
FALSE && 6 >= 6 || 7 >= 8 || 50 <= 49.5 # FALSE && TRUE || FALSE || FALSE --> FALSE || FALSE || FALSE --> [1] FALSE

#The function isTRUE() takes one argument. If that argument evaluates to TRUE, 
# the function will return TRUE. Otherwise, the function will return FALSE. 

isTRUE(6 > 4) # [1] TRUE
!isTRUE(4 < 3) # [1] TRUE
isTRUE(3) # [1] ?
!isTRUE(8 != 5) # [1] FALSE
isTRUE(!TRUE) # [1] FALSE
isTRUE(NA) # [1] FALSE

#The function identical() will return TRUE if the two R objects passed to it as 
# arguments are identical.

identical('twins', 'twins') #[1] TRUE
identical(5 > 4, 3 < 3.1) # [1] TRUE
identical('hello', 'Hello') # [1] FALSE
identical(4, 3.1) # [1] FALSE
!identical(7, 7) # [1] FALSE

#You should also be aware of the xor() function, which takes two arguments. 
# The xor() function stands for exclusive OR. If one argument evaluates to TRUE 
# and one argument evaluates to FALSE, then this function will return TRUE, 
# otherwise it will return FALSE.

xor(5 == 6, !FALSE) #[1] TRUE

#5 == 6 evaluates to FALSE, !FALSE evaluates to TRUE, so xor(FALSE, TRUE) 
# evaluates to TRUE. On the other hand if the first argument was changed to 
# 5 == 5 and the second argument was unchanged then both arguments would have 
# been TRUE, so xor(TRUE, TRUE) would have evaluated to FALSE.

xor(4 >= 9, 8 != 8.0) # xor(FALSE, FALSE) --> [1] FALSE
xor(!isTRUE(TRUE), 6 > -1) #xor(FALSE, TRUE) --> [1] TRUE
xor(!!TRUE, !!FALSE) #xor(TRUE, FALSE) --> [1] TRUE 
xor(identical(xor, 'xor'), 7 == 7.0) #xor(FALSE, TRUE) --> [1] TRUE

#For the next few questions, we're going to need to create a vector of integers 
# called ints.
ints <- sample(10)
ints #[1] 7 8 2 1 4 5 3 9 10 6

#The vector `ints` is a random sampling of integers from 1 to 10 without 
# replacement. Let's say we wanted to ask some logical questions about contents 
# of ints. If we type ints > 5, we will get a logical vector corresponding to 
# whether each element of ints is greater than 5.

ints >5 # TRUE TRUE FALSE FALSE FALSE FALSE FALSE TRUE TRUE TRUE

#We can use the resulting logical vector to ask other questions about ints. The 
# which() function takes a logical vector | as an argument and returns the 
# indices of the vector that are TRUE. For example which(c(TRUE, FALSE, TRUE)) 
# would return the vector c(1, 3).

which(ints > 7) # [1] 2 8 9      <- the indices within the vector

#Like the which() function, the functions any() and all() take logical vectors 
# as their argument. The any() function will return TRUE if one or more of the 
# elements in the logical vector is TRUE. The all() function will return TRUE if
# every element in the logical vector is TRUE.

all(ints > 0) # [1] TRUE
