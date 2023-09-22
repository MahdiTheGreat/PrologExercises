

% a rule called same_member(L1, L2, E) that is true if and only if E is a member of both L1 and L2
% we simply use the builtin function 'member' to see if E is a member of both lists, via the and operator
same_member(L1, L2, E) :- 
    member(E, L1),
    member(E, L2).

% a rule to get the nth element of a list, where L is the list, N is the index of the element and E is the element. We use recursion to do this.
% Base of recursion, that is if n is equal to one, we return the head. This is also usefull if user just wants the first element of a list
get_nth_element([E|_],1,E).
get_nth_element([_|L], N, E) :- get_nth_element(L, N1,E ), N is N1 + 1.

eq_pos(L1,L2,E1,E2):-
    length(L1,Len1),
    length(L2,Len2),
    M is max(Len1,Len2),
    M >= Len1,
    M >= Len2,
    get_nth_element(L1,N1,E1),
    get_nth_element(L2,N2,E2),
    N1=N2.

prime(X) :- X>1,integer(X),M is X-1,prime(X,M).
prime(X,1).
prime(X,M) :- ( X mod M) > 0,M1 is M-1,prime(X,M1).

% we write a function to calculate the sum of a list
% below is the base of the recursion, that is the sum of an empty list is zero
sum([],0).
% here we add the head of the list to the sum of the tail of the list
sum([H|T],S):- sum(T,S1), S is H+S1.
% below we use the sum and the length function to calculate the mean of a list
mean(L,M):-sum(L,S),length(L,Len),M is (S / Len) .








