unit class_lab;

{$MODE OBJFPC}  //directive to be used for creating classes
{$M+}          //directive that allows class constructors and destructors

interface

uses const_lab, crt, sdl;


type 
    Cell = class
    public
        i, j : Integer;                     // i -> Colonne de la cellule  /  j -> Ligne de la cellule
        walls : Array[0..3] of Boolean;     //  Les booleans sont initialise sur false
        visited : Boolean;
        finish : Integer;                   // 0 -> cellule normal / 1 -> cellule de depart / 2 -> cellule d'arriver
        
        constructor new(x, y : Integer);
        function checkNeighbors() : Cell;
        procedure show(screen : PSDL_Surface);
end;

function index(i, j : Integer) : Integer;

var grille : array[0..nbCell-1] of Cell;
var stack : array[0..nbCell-1] of Cell;
var cell_final : Array[0..2] of Cell;
var actuelle, next: Cell;
var undefined : Cell;

implementation

constructor Cell.new(x, y : Integer);
{ Création d'une nouvelle cellule }
begin
    i := x;
    j := y;
end;

function index(i, j : Integer) : Integer;
{ Calcul l'index de la cellule dans un tableau a 1 dimension}
begin
    if ((i < 0) or (j < 0) or (i > cols - 1) or (j > rows - 1)) then index := -1            // Cas des cellules en dehors de la grille ( utile lorsque l'on vérifie les voisins )
    else index := i + j * cols;
end;

function Cell.checkNeighbors() : Cell;

var neighbors : Array[0..3] of Cell;
var top, right, bottom, left : Cell;
var nbVoisins, count, count2, k, r : Integer;

begin
    count := 0;                    
    count2 := 3;
    undefined := Cell.new(-1, -1);          // Création d'une cellule indéfini

    k := index(i, j-1);                     // Index de la cellule voisine du dessus
    if (k <> -1) then  
        top := grille[k]                    // top cellule voisine du dessus
    else 
        top := undefined;                   // Cellule hors de la grille => Cellule indéfini

    k := index(i-1, j);                     // Index de la cellule voisine de gauche
    if (k <> -1) then 
        right := grille[k]
    else 
        right := undefined;

    k := index(i, j+1);                     // Index de la cellule voisine du dessous
    if (k <> -1) then 
        bottom := grille[k]
    else 
        bottom := undefined;

    k := index(i+1, j);                     // Index de la cellule voisine de droite
    if (k <> -1) then 
        left := grille[k]
    else 
        left := undefined;


    if (top.visited <> true) and (top <> undefined) then            // Verifie que la cellule n'a jamais ete visite et est defini
        begin
            neighbors[count] := top;                                // Ajout dans le debut du tableau
            count := count + 1;
        end
    else 
        begin
            neighbors[count2] := top;                               // Sinon ajout dans la fin du tableau
            count2 := count2 - 1;
        end;
    {--------------------------------------------------------} // <- sert à rien
    if (right.visited <> true) and (right <> undefined) then
        begin
            neighbors[count] := right;
            count := count + 1;
        end
    else 
        begin
            neighbors[count2] := right;
            count2 := count2 - 1;
        end;
    {--------------------------------------------------------}
    if (bottom.visited <> true) and (bottom <> undefined) then
        begin
            neighbors[count] := bottom;
            count := count + 1;
        end
    else 
        begin
            neighbors[count2] := bottom;
            count2 := count2 - 1;
        end;
    {--------------------------------------------------------}
    if (left.visited <> true) and (left <> undefined) then
        begin
            neighbors[count] := left;
            count := count + 1;
        end
    else
        begin 
            neighbors[count2] := left;
            count2 := count2 - 1;
        end;
    {--------------------------------------------------------}

    //writeln('le gras cest la vie');
    nbVoisins := count;         // Nombre de voisins qui n'ont jamais ete visite

    { Choisi aléatoirement une cellule qui n'a pas encore été visité }
    if (nbVoisins > 0) then 
        begin
            r := Random(nbVoisins);
            //writeln(r, ' ', nbVoisins);
            checkNeighbors := neighbors[r];
        end
    else
        begin
            //writeln('undefini');
            checkNeighbors := undefined;
        end;
end;

procedure Cell.show(screen : PSDL_Surface);
var x, y : Integer;
begin
    x := i * w;         // Positions x et y de la cellule sur la surface screen
    y := j * w;

    //if (visited = true) then fillRect(x, y, w, w, 0, 0, 255, screen);
    if (finish = 0) 
        then fillRect(x, y, w, w, 0, 0, 255, screen)            // Couleur des cellules "normales"
    else if (finish = 2) 
        then fillRect(x, y, w, w, 255, 51, 51, screen)          // Couleur pour la cellule d'arriver
    else 
        fillRect(x, y, w, w, 102, 204, 0, screen);              // Couleur pour la cellule de départ
    
    if (walls[0] = true) then fillRect(x        , y        , w, 1, 255, 255, 255, screen);          // Ligne à gauche de la cellule
    if (walls[1] = true) then fillRect(x + w - 1, y        , 1, w, 255, 255, 255, screen);          // Ligne en haut de la cellule
    if (walls[2] = true) then fillRect(x        , y + w - 1, w, 1, 255, 255, 255, screen);          // Ligne à droite de la cellule
    if (walls[3] = true) then fillRect(x        , y        , 1, w, 255, 255, 255, screen);          // Ligne en bas de la cellule

end;


end.