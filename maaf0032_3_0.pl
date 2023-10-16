% My queries
% ==========================================
% Query(1)
% Keep in mind that allways was renamed to allways_acyclic to avoid confusion
% ?- allways_acyclic(a,e).
%  bcde
%  true
%  bce
%  true
%  cde
%  true
%  ce
%  true
%  false 
%  Query(2)
%  ?- allways_acyclic(e,a).
%  false
%  anyway was renamed to anyway_cyclic to avoid confusion
%  Query(3)  
%  ?- anyway_cyclic(e,a). 
%  false 
%  %  Query(4)  
%  ?- anyway_cyclic(a,e). 
%  true 
%  Query(5)  
%  ?- citystate(Country).
%  Country = ceuta ;
%  Country = hong_kong ;
%  Country = liechtenstein ;
%  Country = melilla ;
%  Country = saint_pierre_and_miquelon ;
%  Country = singapore ;
%  false. 
%  Query(6) 
%  ?- circumference(C,sweden).
%  C = 2205. 
%?- lll(Country, Continent).
%  Country = bolivia,
%  Continent = 'America' ;
%  Country = belarus,
%  Continent = 'Europe' ;
%  Country = mongolia,
%  Continent = 'Asia' ;
%  Country = mali,
%  Continent = 'Africa' ;
%  false. 

%------------------------Graphs------------------------------

% a rule to see X is a member of a list
custom_member(X,[H|T]):-X=H;custom_member(X,T).

edge(a, b).
edge(a, c).
edge(b, c).

%edge(c, k). for testing

edge(c, e).
edge(c, d).

%edge(k, c). for testing

%edge(d, x). for testing

edge(d, e).

edge(f, g).
edge(g, h).

edge2(d,a).
edge2(h,f).
edge2(X,Y) :- edge(X,Y).

rev(L, R) :- rev(L, R, []). % set up the accumulator
rev([], R, R). % Copy the accumulator to the result
rev([H | T], R, Acc) :-rev(T, R, [H | Acc]). % Add the first element of the list to the accumulator

% rule to print a list by printing the head of list recursively
list_printer([]):- write('').
list_printer([H|T]):- write(H),list_printer(T).

allways_acyclic(X,Y):-
% we avoid the head because we don't want X to be printed in the answer
    allways_acyclic(X,Y,[_|Path]),
    list_printer(Path).

% in the base of the recursion we have reached our goal, therefore the path that gets returned includes X
allways_acyclic(X,X,Path):-Path=[X].

% we try to see what nodes we can get to from X and then recursively inspect if we can get to the goal node via it and continue doing this until we reach the base.
allways_acyclic(X,Y,Path):-
edge(X,Z),
allways_acyclic(Z,Y,Temp),
Path=[X|Temp].

% same as the allways_acyclic rule except we don't print the path.
anyway_acyclic(X,Y):-allways_acyclic(X,Y,[_|_]).

% in the helper function we initialize both the Visited list and the Stack queue list with empty lists.
anyway_cyclic(X,Y):-allways_cyclic(X,Y,[],[]).

% in the base of the recursion we have reached our goal.
allways_cyclic(X,X,_,_).

% we try to see what nodes we can get to from X and then recursively inspect if we can get to the goal node via it and continue doing this until we reach the base.
% we use the visited list to avoid expanding on nodes that we have already visited and we use the stack list to a previous node, in case we run into a dead end.
allways_cyclic(X,Y,Visited,Stack):-
    ((edge(X,Z);
    edge2(X,Z)),
    \+custom_member(Z,Visited)
    )
    -> (
       UpdatedStack=[X|Stack],
       UpdatedVisited=[Z|Visited],
       allways_cyclic(Z,Y,UpdatedVisited,UpdatedStack)
     );
    (   
    [Top|Tail]=Stack,
    allways_cyclic(Top,Y,Visited,Tail)).


%------------------------The World------------------------------

:- consult(mondial).

% we write a function to calculate the sum of a list
% below is the base of the recursion, that is the sum of an empty list is zero
sum([],0).
% here we add the head of the list to the sum of the tail of the list
sum([H|T],S):- sum(T,S1), S is H+S1.

%the predicate citystate takes in a country as argument and returns true if the argument is a country with a city where the population makes up 
%for at least 75% of the total population in the country.
citystate(Country):- 
    country(Country, _, _, Population),
	% below we see if the population is not null
    integer(Population),
    city(_,Country,_,CityPopulation),
    integer(CityPopulation),
    CityPopulation>=0.75*Population.

% we recursively try to finding the neighboring countries of Country and find the sum of their shared borders 
circumference(Circumference,Country):-
    circumference(Country,[],Borders),
    sum(Borders,Circumference).

circumference(Country,Visited,Borders):-
% we use a visited list to keep track of neighboring countries we have already inspected
    ((borders(Country,Z,Border);
    borders(Z,Country,Border))
    ,\+custom_member(Z,Visited)) 
    ->(   
    UpdatedVisited=[Z|Visited],
    circumference(Country,UpdatedVisited,Temp),
    Borders=[Border|Temp]
     )
    ;
	% we handle our base condition in the else of the if else.
	Borders=[]
    .

%the predicate lll/ is true when the country found in the first argument,
% is the country with the longest border circumference on the continent
%  found in the second argument. To qualify as the longest border,
% one may not border any sea (therefore “lll”, as in “Longest LandLocked”) and can only be in one continent
% below we check that the country is only in one continent and also is not bordering any sea.
% then we calculate it's circumference and use the helper function with the visited list initialized with inputted country.
lll(Country,Continent):-
    encompasses(Country,Continent,Percent),
    Percent=100,
    \+geo_sea(_,Country,_),
    circumference(Circumference,Country),
    lll(Continent,Circumference,[Country]).

% below we check if there is a country with a bigger circumference than the inputted country, that is only in one continent and is not bordering any sea.
% we also check that we haven't visited it before, in which case we add it to the visited countries and calculate it's circumference.
lll(Continent,Circumference1,Visited):-
    country(Country2,_,_,_),
    encompasses(Country2,Continent,Percent),
    Percent=100,
    \+geo_sea(_,Country2,_),
    \+custom_member(Country2,Visited)
    ->(   
    circumference(Circumference2,Country2),
    Circumference1>Circumference2,
    UpdatedVisited=[Country2|Visited],
    lll(Continent,Circumference1,UpdatedVisited)
    );
	% if we have checked all the possible countries with the inputted continent and visited list and have not found one with a bigger circumference, then we return true.
	true.
	










    
    

    
    
