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

%Rules:

%C is a daughter of P if C is the child of P, and C is female.
daughter(C,P) :- child(C,P), female(C).

%Gp is the grandparent of C if (for any P) C is the child of P, and P is the child of Gp
grandchild(C,Gp) :- child(C,P), child(P,Gp).

%C is a son of P if C is the child of P, and C is not female.
son(C,P) :- child(C,P), \+ female(C).

%A is parther with B if they have a child together
partner(A, B) :- child(C, A), child(C, B), not(A = B) .

%X and Y are in a family if X is the child of Y, or Y is the child of X.
family(X,Y) :- child(X,Y).
family(X,Y) :- child(Y,X).

% X is a titan if X is the child of Y, and Y is Uranus.
titan(X) :- child(X,Y), Y == uranus.

% Printouts from prompt:

%Is Atlas female?
%   ?- female(atlas).
%   false.

%Who is the parent of both Apollo and Ares?
%   ?- child(apollo,P), child(ares,P).
%   P = zeus ;
%   false.
