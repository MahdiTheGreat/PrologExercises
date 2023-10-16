
% List processing----------------------------------------------------------------------
% a rule called same_member(L1, L2, E) that is true if and only if E is a member of both L1 and L2
% we simply use the built-in function 'member' to see if E is a member of both lists, via the and operator
same_member(L1, L2, E) :- 
    member(E, L1),
    member(E, L2).

% a rule to get the nth element of a list, where L is the list, N is the index of the element and E is the element. We use recursion to do this.
% Base of recursion, that is if n is equal to one, we return the head. This is also useful if user just wants the first element of a list
get_nth_element([E|_],1,E).
get_nth_element([_|L], N, E) :- get_nth_element(L, N1,E ), N is N1 + 1.

% the below function uses the get_nth_element to find elements of the two lists which have the same index
% keep in mind that if the lists are variable, the program gets stuck in an infinite loop because there are infinite lists that satisfy the rule.
% this problem was talked about during the class and it was deemed acceptable that program gets stuck.
eq_pos(L1,L2,E1,E2):-
get_nth_element(L1,N1,E1),
get_nth_element(L2,N2,E2),
N1=N2.

%essentially we try to find the set of a list and compare it with the inputted set.
% the cut operation is used to remove redundancy and not have every permutation 
% of set as an answer, but if we don't have the cut operation, the program would still work.
set(L,S):-
    setfinder(L,TEMP),
    permutation(TEMP,S),
    !.
% base of the recursion, as the set of an empty list is an empty set.
setfinder([],S):- S=[].

% This is our helper function, which by itself is incomplete, as it's only used to find
% a set of a list, and cannot be used to see if a given set is the set of the inputted list or not.
% At every recursion, we check if the head of the list is already in our set or not, and if it isn't we insert it in to the set 
% otherwise we leave the set as it is.
setfinder([H|T],S):-
    setfinder(T,TEMP),
    ( \+member(H,TEMP) 
    -> S=[H|TEMP]
    ;S=TEMP ).

% Math----------------------------------------------------------------------
% based on the definition of a prime number, it has to be a positive integer bigger than one and also only be dividable by itself and one.
% this is reflected below
prime(X) :- X>1,integer(X),M is X-1,prime(X,M).
% the base rule, for when the number is one. keep in mind that this doesn't mean that one is a prime number
prime(X,1).
% a recursive program that checks if an integer is only divisible by itself and one.
% basically M is initially equal to X-1 and then it recursively checks if X mod M is bigger than zero, which shows that X is not divisible by M.
prime(X,M) :- ( X mod M) > 0,M1 is M-1,prime(X,M1).

% Lists and math----------------------------------------------------------------------
% we write a function to calculate the sum of a list
% below is the base of the recursion, that is the sum of an empty list is zero
sum([],0).
% here we add the head of the list to the sum of the tail of the list
sum([H|T],S):- sum(T,S1), S is H+S1.
% below we use the sum and the length function to calculate the mean of a list
mean(L,M):-sum(L,S),length(L,Len),M is (S / Len) .








