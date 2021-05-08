:-dynamic compteur/2.
 
% compteur(Joue, Gagne).
compteur(0,0).
 
 
lancement(gagne, Mise, Pari, Resultat) :-
    Resultat is Mise + Pari.
 
lancement(perdu, Mise, Pari, Resultat) :-
    Resultat is Mise - Pari.
 
gen_resultat(Resultat) :-
    N is random(2),
    (   N = 0
    ->  Resultat = perdu
    ;   Resultat = gagne).
  
 
 
 
jeu(Mise_init,Strategie, Valeur):-
    (   Mise_init =< 0
    ->  writeln('You loose !'),
        compteur(Joue, Gagne),
        format('Parties Jouees ~w, gagnees ~w~n', [Joue, Gagne])
    ;   % calcul du montant du pari
        writeln('Avoir ': Mise_init),
        (   Strategie = 1
        ->  Pari is  round(Mise_init * Valeur / 100)
        ;  Strategie = 2 -> Pari = Valeur),
            % obtention du resultat du pari (gagne/perdu)
        gen_resultat(Resultat),
        retract(compteur(J, G)),
        J1 is J+1,
        (   Resultat = gagne
        ->   G1 is G+1
        ;   G1 = G),
        assert(compteur(J1, G1)),
        lancement(Resultat, Mise_init, Pari, Nouvelle_Mise),
        jeu(Nouvelle_Mise, Strategie, Valeur)).
