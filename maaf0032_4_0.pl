% in this exercise we learn to implement functions similar to how they are
% portrayed in fol.

%----------------------Task 1
%?- eval( plus(minus(8,2), times(4,-3)), N).
%N = -6
% we use several rules, depending if their input is
% plus, minus or times and then these rules recursively
% call themselves until we reach to the base of recursions 
% where A is constant and then it's returned and then the 
% rules can do their calculations.
eval(plus(A,B),N):- 
     eval(A,N1),integer(N1),eval(B,N2),integer(N2),N is N1+N2.
eval(minus(A,B),N):-
    eval(A,N1),integer(N1),eval(B,N2),integer(N2),N is N1-N2.
eval(times(A,B),N):-
    eval(A,N1),integer(N1),eval(B,N2),integer(N2),N is N1*N2.
eval(A,N):-integer(A),N is A.

%----------------------Task 2
%?- printterm( plus(minus(8,2), times(4,-3))).
%((8 - 2) + (4 * -3))
%true.
% we use several rules, depending if their input is
% plus, minus or times and then these rules recursively
% call themselves until we reach to the base of recursions 
% where A is constant and then A is printed and then the 
% rules can do the parenthesis and operation sign prints.
printterm(plus(A,B)):- 
     write('('),printterm(A),write(' + '),printterm(B),write(')').
printterm(minus(A,B)):-
     write('('),printterm(A),write(' - '),printterm(B),write(')').
printterm(times(A,B)):-
     write('('),printterm(A),write(' * '),printterm(B),write(')').
printterm(A):-integer(A),write(A).

%----------------------Task 3
%?- printeval( plus(minus(8,2), times(4,-3))).
%((8 - 2) + (4 * -3)) = -6
%true
% We first call eval rule and find the output of the formula and 
% then we print the formula with printterm and finally we 
% print the equal sign and the output of the formula.
printeval(Formula):-
    eval(Formula,N),printterm(Formula),write(' = '),write(N).
    
    
