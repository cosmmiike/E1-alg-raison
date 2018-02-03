entree(salade).
entree(oeufs).
entree(pate).
entree(melon).
plat(poisson).
plat(poulet).
plat(viande).
dessert(glace).
dessert(pomme).
dessert(raisin).
dessert(gateau).
dessert(fromage).

calorifique(salade, 100).
calorifique(oeufs, 200).
calorifique(pate, 300).
calorifique(melon, 250).
calorifique(poisson, 400).
calorifique(poulet, 500).
calorifique(viande, 800).
calorifique(glace, 300).
calorifique(pomme, 250).
calorifique(raisin, 250).
calorifique(gateau, 400).
calorifique(fromage, 320).

repas(Entree, Plat, Dessert, Valeur) :- entree(Entree), plat(Plat), dessert(Dessert),
  Valeur #= X+Y+Z, calorifique(Entree, X), calorifique(Plat, Y), calorifique(Dessert, Z).

repas_leger(E, P, D, Val) :- Min = 800, Max = 1000, repas(E, P, D, Val),  Val #> Min, Val #< Max.

repas_sans_dessert(E1, E2, P, Val) :- entree(E1), entree(E2), plat(P),
  Val #= X+Y+Z, calorifique(E1, X), calorifique(E2, Y), calorifique(P, Z), E1\=E2, Val #> 800.
