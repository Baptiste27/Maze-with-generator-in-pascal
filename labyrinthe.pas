unit labyrinthe;

interface

uses sdl, class_lab, const_lab;

procedure setup;
procedure retirer_murs(a, b : Cell);
procedure draw(var screen : PSDL_Surface);

var arrivee : Cell;

implementation

procedure setup;
{ Initialise toutes les cellules du labyrinthe }
var count, i, j, k: Integer;
var cellule : Cell;
begin
    count := 0;
    for j := 0 to rows -1 do
    begin
        for i := 0 to cols - 1 do
        begin
            cellule := Cell.new(i, j);          // Création d'une nouvelle cellule
            for k := 0 to 3 do
            begin
                cellule.walls[k] := true;       // La nouvelle cellule possède 4 murs
            end;
        grille[count] := cellule;                 // Ajout de la cellule dans un tableau
        count := count + 1;
        end;
    end;


    actuelle := grille[0];                         // Initialise la cellule actuelle sur la première cellule du tableau

    grille[0].finish := 1;                         // Choix de la cellule de départ
    

    { Choix aléatoire de la cellule de fin }
    cell_final[0] := grille[index(cols - 1, 0)];      
    cell_final[1] := grille[index(0, rows - 1)];
    cell_final[2] := grille[index(cols - 1, rows - 1)];

    arrivee := cell_final[random(3)];
    arrivee.finish := 2;

end;


procedure retirer_murs(a, b : Cell);
{ Retire les murs }
var x, y : Integer;
begin
    x := a.i - b.i;                 
    if x = 1 then                       // La cellule a a pour voisin de gauche la cellule b
    begin
        a.walls[3] := false;            // Supprime le mur de gauche de la cellule a
        b.walls[1] := false;            // ------------------ droite ------------- b
    end
    else if x = -1 then                 // La cellule a a pour voisin de droite la cellule b
    begin
        a.walls[1] := false;            // Supprime le mur de droite de la cellule a
        b.walls[3] := false;            // ------------------ gauche ------------- b
    end
    else
    begin
        y := a.j -  b.j;
        if y = 1 then                   // La cellule a a pour voisin du bas la cellule b
        begin
            a.walls[0] := false;        // Supprime le mur du bas de la cellule a
            b.walls[2] := false;        // ------------------ haut ------------ b
        end
        else if y = -1 then             // La cellule a a pour voisin du haut la cellule b
        begin
            a.walls[2] := false;        // Supprime le mur du haut de la cellule a
            b.walls[0] := false;        // ------------------ bas -------------- b
        end
    end
end;


procedure draw(var screen :  PSDL_Surface);
{ Génère aléatoirement et dessine le labyrinthe }
var k, count : Integer;
begin
    count := 0;
    undefined := Cell.new(-1, -1);              // Création d'une cellule "indefini"

    while count >= 0 do
    begin
        actuelle.visited := true;
        next := actuelle.checkNeighbors();          // ETAPE 1 Choix aléatoire d'un voisin
        if next <> undefined then 
        begin

            stack[count] := actuelle;               // ETAPE 2 Ajout de la cellule actuelle dans une pile
            count := count + 1;
            //writeln(count);

            retirer_murs(actuelle, next);           // ETAPE 3 Retirer les murs entre la cellule actuelle et la prochaine cellule

            next.visited := true;                   // ETAPE 4 Marquer la cellule choisi comme visité
            actuelle := next;                       
        end

        { Tant que la cellule next est indéfini et que la pile n'est pas vide, 
          alors on dépile jusqu'à retrouver une cellule possédant un voisin pas encore visité }

        else if count >= 0 then                     // Si la cellule next est indéfini et que la pile n'est pas vide
        begin
            if count = 0 then count := -1           // Si count = 0, on a tout depiler
            else
            begin
                count := count - 1;
                //writeln(count, ' ', 'indefini');
                actuelle := stack[count];
            end;
        end;
    end;


    for k := 0 to Length(grille) - 1 do
    begin
        grille[k].show(screen);             // On affiche la grille du labyrinthe
    end;

end;

end.