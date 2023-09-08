
%added facts

child(pan ,hermes ).
child(pan ,dryope ).

% my queries

%Is Tethys female?
%   ?- female(tethys ).
%   true.

%query that answers the question which gods are children of Rhea and Chronus
% ?- child(G,rhea),child(G,chronus).
% G = hera ;
% G = hades ;
% G = demeter ;
% G = poseidon ;
% G = zeus.

% query that answers the question who is the mother of Phoebe
% ?- mother(M,phoebe).
% M = gaia ;
% false.

% query that answers the question which gods are partners of Hermes
% ?- partner(hermes,B).
% B = aphrodite ;
% B = dryope ;
% B = aphrodite ;
% B = dryope.

% query that answers the question who are bachelors
% ?- bachelor(B).
% B = hades ;
% B = hades ;
% B = poseidon ;
% B = poseidon ;
% B = hephaestus ;
% B = hephaestus ;
% B = apollo ;
% B = apollo ;
% B = eros ;
% B = eros ;
% B = hermaphroditus ;
% B = hermaphroditus ;
% B = pan ;
% B = pan ;
% false.

% query that answers the question who is a sibling of Apollo
% ?- sibling(apollo,B).
% B = artemis ;
% false.

% query that answers the question who is a part of Ares family
% ?- family(X,ares). 
% X = hephaestus ;
% X = aphrodite ;
% X = aphrodite ;
% X = eros ;
% X = zeus ;
% X = hera.

% a query, without creating a new rule, that answers the question which goddesses have more than one partner
% ?- female(F),partner(F,B),partner(F,C),B\=C.
% F = aphrodite,
% B = ares,
% C = hermes ;
% F = aphrodite,
% B = ares,
% C = hermes ;
% F = aphrodite,
% B = hermes,
% C = ares ;
% F = aphrodite,
% B = hermes,
% C = ares ;
% F = aphrodite,
% B = ares,
% C = hermes ;
% F = aphrodite,
% B = ares,
% C = hermes ;
% F = aphrodite,
% B = hermes,
% C = ares ;
% F = aphrodite,
% B = hermes,
% C = ares ;
% false.

% my rules

%the rule mother(M, C) that is true if M is the mother of C.
mother(M,C) :- female(M),child(C,M).

%the rule father(F, C) that is true if F is the mother of C.
father(F,C) :- child(C,F),\+female(F).

%the rule partner(A, B) that is true if A and B have a child together
partner(A, B) :- child(C,A),child(C,B),A\=B.

god(P):-child(P,F);father(P,C);mother(P,C).

male(M):- god(M),\+female(M).

%the rule bachelor(B) that is true if X is a male without children.
bachelor(B) :- male(B),\+father(B,C).

%the rule sibling(A, B) that is true if A and B are siblings (that is, they share both parents!)
sibling(A, B) :- mother(Ma,A),mother(Mb,B),father(Fa,A),father(Fb,B),Ma==Mb,Fa==Fb,A\=B.

% extending the definition
family(X,Y) :- sibling(X,Y);partner(X, Y).

% Simplification of titan definition
titan(X) :- child(X,uranus).


child(rhea,uranus).
child(rhea,gaia).
child(chronus,uranus).
child(chronus,gaia).
child(phoebe,uranus).
child(phoebe,gaia).
child(coeus,uranus).
child(coeus,gaia).
child(iapetus,uranus).
child(iapetus,gaia).
child(tethys,uranus).
child(tethys,gaia).
child(oceanus,uranus).
child(oceanus,gaia).
child(hera,chronus).
child(hera,rhea).
child(hades,chronus).
child(hades,rhea).
child(demeter,chronus).
child(demeter,rhea).
child(poseidon,chronus).
child(poseidon,rhea).
child(zeus,chronus).
child(zeus,rhea).
child(leto,phoebe).
child(leto,coeus).
child(epimetheus,iapetus).
child(atlas,iapetus).
child(pleione,tethys).
child(pleione,oceanus).
child(hephaestus,zeus).
child(hephaestus,hera).
child(ares,zeus).
child(ares,hera).
child(persephone,zeus).
child(persephone,demeter).
child(artemis,zeus).
child(artemis,leto).
child(apollo,zeus).
child(apollo,leto).
child(dione,epimetheus).
child(dryope,atlas).
child(dryope,pleione).
child(maia,atlas).
child(maia,pleione).
child(aphrodite,zeus).
child(aphrodite,dione).
child(hermes,zeus).
child(hermes,maia).
child(eros,ares).
child(eros,aphrodite).
child(hermaphroditus,aphrodite).
child(hermaphroditus,hermes).
child(athena,zeus).
female(gaia).
female(rhea).
female(phoebe).
female(tethys).
female(hera).
female(demeter).
female(leto).
female(pleione).
female(persephone).
female(aphrodite).
female(athena).
female(artemis).
female(dione).
female(dryope).
female(maia).


% keep in mind that for consult we need to use the forward slash for directory

%Rules:

%C is a daughter of P if C is the child of P, and C is female.
daughter(C,P) :- child(C,P), female(C).

%Gp is the grandparent of C if (for any P) C is the child of P, and P is the child of Gp
grandchild(C,Gp) :- child(C,P), child(P,Gp).

%C is a son of P if C is the child of P, and C is not female.
son(C,P) :- child(C,P), \+ female(C).

%A is partner with B if they have a child together
partner(A, B) :- child(C, A), child(C, B), not(A = B) .

%X and Y are in a family if X is the child of Y, or Y is the child of X.
family(X,Y) :- child(X,Y).
family(X,Y) :- child(Y,X).



% X is a titan if X is the child of Y, and Y is Uranus.
% need to use father here
% titan(X) :- child(X,Y), Y == uranus.


% Printouts from prompt:

%Is Atlas female?
%   ?- female(atlas).
%   false.

%Who is the parent of both Apollo and Ares?
%   ?- child(apollo,P), child(ares,P).
%   P = zeus ;
%   false.


