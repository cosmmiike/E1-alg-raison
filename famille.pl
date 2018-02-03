% Relation epouse(Femme, Marie)
epouse(sylvie, jean).
epouse(marie, paul).
epouse(helene, jacques).
epouse(bernadette, jose).
epouse(valentine, loic).


% Relation enfant(Enfant, Père)
enfant(jacques, jean).
enfant(pierre, jean).
enfant(marie, jean).
enfant(eric, pierre).
enfant(thomas, pierre).
enfant(vincent, jacques).
enfant(loic, jacques).
enfant(michele, jacques).
enfant(valentin, jose).
enfant(olivier, jose).
enfant(david, thomas).
enfant(christine, thomas).


% Relation enfant(Enfant, Mère)
enfant(mark, marie).
enfant(laure, marie).
enfant(sophie, sylvie).
enfant(alex, sylvie).
enfant(serge, laure).
enfant(juliette, laure).


% helene est mere de michele mais michele n'est pas enfant de helene - ?! (vincent et loic : idem).
% Il faut ajouter le predicat enfant pour les relations qui ne sont pas descrit.


% I - Écrire le prédicat homme pour chaque individu (masculin) de cette base.
homme(jean).
homme(paul).
homme(jacques).
homme(jose).
homme(loic).
homme(pierre).
homme(eric).
homme(thomas).
homme(vincent).
homme(valentin).
homme(olivier).
homme(mark).
homme(alex).
homme(david).
homme(serge).


% II - Écrire la règle (’\+’ veut dire not : la négation en Prolog)
femme(X) :- nonvar(X), \+ homme(X). % ce qui n’est pas ’homme’ est ’femme’.

% III- Écrire les prédicats basiques:
epoux(H, F) :- epouse(F, H).

pere(Dad, Enf) :- enfant(Enf, Dad), homme(Dad); enfant(Enf, Mam), epouse(Mam, Dad).
mere(Mam, Enf) :- enfant(Enf, Mam), femme(Mam); enfant(Enf, Dad), epoux(Dad, Mam).

parent(Par, Enf) :- pere(Par, Enf).
parent(Par, Enf) :- mere(Par, Enf).

% enfant(Enf, Par) :- parent(Par, Enf).
% fils(Enf, Par) :- enfant(Enf, Par), homme(Enf).
% fille(Enf, Par) :- enfant(Enf, Par), femme(Enf).
% je ne peux pas utiliser la construction enfant(Enf, Par) à cause de le predicat enfant n'est pas descript completement.

fils(Enf, Par) :- parent(Par, Enf), homme(Enf).
fille(Enf, Par) :- parent(Par, Enf), femme(Enf).

frere(Frere, Enf) :- pere(P, Frere), pere(P, Enf), homme(Frere), Frere\=Enf.
soeur(Soeur, Enf) :- pere(P, Soeur), pere(P, Enf), femme(Soeur), Soeur\=Enf.

grand_pere(GrP, GrE) :- pere(GrP, Enf), parent(Enf, GrE).
grand_mere(GrM, GrE) :- mere(GrM, Enf), parent(Enf, GrE).

oncle(O, Enf) :- parent(Par, Enf), frere(O, Par).
tante(T, Enf) :- parent(Par, Enf), soeur(T, Par).

ancetre(A, Enf) :- parents(A, Enf); parents(A, Par), ancetre(Par, Enf).

% IV - A quoi correspond la relation décrite ci-dessous :
% Qui est "le frère du fils du mari de la mère du père de la soeur du fils de ma mère" ?

qui_est(Qui, Vous) :- mere(Mam, Vous), fils(Fils, Mam), soeur(Soeur, Fils), pere(Dad, Soeur), mere(Mam2, Dad), epoux(Dad2, Mam2), fils(Fils2, Dad2), frere(Qui, Fils2).

% qui_est(Qui, Vous) :- mere(Mam, Vous), fils(Fils, Mam), soeur(Qui, Fils).
