unit class_lab;

{$MODE OBJFPC}  //directive to be used for creating classes
{$M+}          //directive that allows class constructors and destructors

interface

uses const_lab, crt, typesLab, sdl;


type 
    Cell = class
    private
        i, j : Integer; //coordonnes de la cellule

    public
        walls : Array[0..3] of Boolean; //les booleans sont initialise sur false
        visited : Boolean;
        
        constructor new(x, y : Integer);
        function checkNeighbors() : Cell;
        procedure show(screen : PSDL_Surface);
end;

function index(i, j : Integer) : Integer;

var grid : array[0..99] of Cell; // 100 cellules dans le labyrinthe

implementation

constructor Cell.new(x, y : Integer);
begin
    i := x;
    j := y;
end;

function index(i, j : Integer) : Integer;
begin
    if ((i < 0) or (j < 0) or (i > cols - 1) or (j > rows - 1)) then index := -1 // cas des cellules sur le bord de la grille
    else index := i + j * cols;
end;

function Cell.checkNeighbors() : Cell;

var neighbors : Array[0..3] of Cell;
var top, right, bottom, left, undefined : Cell;
var nbVoisins, count, count2, k, r : Integer;

begin
    Randomize;
    count := 0;                    
    count2 := 3;
    undefined := Cell.new(-1, -1);  // Cellule indefini

    k := index(i, j-1);                 // index de la cellule voisine du dessus
    if (k <> -1) then  
        top := grid[index(i, j-1)]      // top cellule voisine du dessus
    else top := undefined;              // si la cellule est hors de la grille, elle est indefini

    k := index(i-1, j);
    if (k <> -1) then 
        right := grid[index(i, j-1)]
    else right := undefined;

    k := index(i, j+1);
    if (k <> -1) then 
        bottom := grid[index(i, j-1)]
    else bottom := undefined;

    k := index(i+1, j);
    if (k <> -1) then 
        left := grid[index(i, j-1)]
    else left := undefined;


    if (top.visited <> true) and (top <> undefined) then    // Verifie que la cellule n'a jamais ete visite et est defini
        begin
            neighbors[count] := top;                        // Si c'est le cas, on l'ajoute dans le debut du tableau
            count := count + 1;
        end
    else 
        begin
            neighbors[count2] := top;                       // Sinon on l'ajoute, vers la fin du tableau
            count2 := count2 - 1;
        end;
    {--------------------------------------------------------} // <- sert a rien
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

    nbVoisins := count; // le nb de voisins qui n'ont jamais ete visite
    if (nbVoisins > 0) then 
        begin
            r := Random(nbVoisins + 1);
            checkNeighbors := neighbors[r];
        end
    else
        begin
            checkNeighbors := undefined;
        end;
end;

procedure Cell.show(screen : PSDL_Surface);
var x, y : Integer;
begin
    x := i * w; // position sur la grille
    y := j * w;

    if (visited = true) then fillRect(x, y, w, w, 255, 0, 255, screen);
    
    if (walls[0] = true) then fillRect(x        , y        , w, 1, 255, 255, 255, screen);
    if (walls[1] = true) then fillRect(x        , y        , 1, w, 255, 255, 255, screen);
    if (walls[2] = true) then fillRect(x + W - 1, y        , w, 1, 255, 255, 255, screen);
    if (walls[3] = true) then fillRect(x        , y + W - 1, w, 1, 255, 255, 255, screen);

end;


end.