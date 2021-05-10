:-dynamic compteur/2.
 
% fonction compteur(Joue, Gagne)
compteur(0,0).
 
% fonction lancement de la partie si gagant
lancement(gagne, Mise, Pari, Resultat) :-
    Resultat is Mise + Pari.
% fonction lancement de la partie si perdant
lancement(perdu, Mise, Pari, Resultat) :-
    Resultat is Mise - Pari.
 % fonction qui génére le resultat
gen_resultat(Resultat) :-
    N is random(2),
    (   N = 0
    ->  Resultat = perdu
    ;   Resultat = gagne).
  
 
 
% fonction qui execute le déroulement de la partie
jeu(Mise_init,Strategie, Valeur):-
    % on verifie que la mise est superieur a 0
    (   Mise_init =< 0
     %on ecrit Vous êtes runiné.
    ->  writeln('Vous êtes ruiné!'),
     %on incrémete le compteur si il gagne
        compteur(Joue, Gagne),
     %on calcul le nombre de partie perdu
     Perdu is Joue - Gagne,
     %on affiche le nombre de partie total,gagner et perdu
        format('Parties Jouees ~w, gagnees ~w~n, Perdu ~w~n ', [Joue, Gagne,Perdu])
    ;   % calcul du montant du pari
        writeln('Avoir ': Mise_init),
     %verification de la strategie utilisé si 1 en % si 2 la mise = le nombre definie
        (   Strategie = 1
        ->  Pari is  round(Mise_init * Valeur / 100)
        ;  Strategie = 2 -> Pari = Valeur),
            % obtention du resultat du pari (gagne/perdu)
        gen_resultat(Resultat),
     %recursivité.
        retract(compteur(J, G)),
     %si resultat= gagne incremente le compteur gagne
        J1 is J+1,
        (   Resultat = gagne
        ->   G1 is G+1
        ;   G1 = G),
        assert(compteur(J1, G1)),
        lancement(Resultat, Mise_init, Pari, Nouvelle_Mise),
        jeu(Nouvelle_Mise, Strategie, Valeur)).
