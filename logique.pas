unit logique;

interface

uses typesLab, sdl, sdl_image;

Const 
    w = 40; //taille des cellules (carre de 40*40)

var grid : array[0..99] of Cell; // 100 cellules dans le labyrinthe
var current : Cell; // variable contenant la cellule actuelle 
var index : Integer;

procedure show(grid : Array of Cell; screen : PSDL_Surface);
procedure calcIndex(i, j : Integer);
procedure checkNeighbors(cell : Cell);
procedure setup;

implementation

procedure show(grid : Array of Cell; screen : PSDL_Surface); //affiche les murs des cellules
var x, y, test, count: Integer;
begin
    test := 255;
    for count := 0 to Length(grid)-1 do
    begin
        x := grid[count].i * w;
        y := grid[count].j * w;
        //grid[count].visited := true;
        if grid[count].visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
        if grid[count].walls[0] then fillRect(x        , y        , w, 1, 255, 255, 255, screen); // ligne à gauche de la cellule
        if grid[count].walls[1] then fillRect(x        , y        , 1, w, 255, 255, 255, screen); // ligne en haut de la cellule
        if grid[count].walls[2] then fillRect(x + w - 1, y        , 1, w, 255, 255, 255, screen); // ligne à droite de la cellule
        if grid[count].walls[3] then fillRect(x        , y + w - 1, w, 1, 255, 255, 255, screen); // ligne en bas de la cellule
        SDL_Flip(screen);
        //writeln(grid[count].walls[0], grid[count].walls[3]);
    end;
    checkNeighbors(grid[count]);
    
end;

procedure calcIndex(i, j : Integer);
begin
    index := i + j * (LARGEUR div w);
end;

procedure checkNeighbors(cell : Cell);
var neighbors : Array[0..3] of Cell;
var top, right, bottom, left : Cell;
begin
    calcIndex(cell.i, cell.j - 1);
    top := grid[index];
    calcIndex(cell.i + 1, cell.j);
    right := grid[index];                   { ~~~~~~~~~ CF video part 2 a 9min ~~~~~~~~ }
    calcIndex(cell.i, cell.j + 1);
    bottom := grid[index];
    calcIndex(cell.i - 1, cell.j);
    left := grid[index];
    //write(index); 

    if top.visited <> true then neighbors[0] := top;
    if right.visited <> true then neighbors[0] := right;
    if bottom.visited <> true then neighbors[0] := bottom;
    if left.visited <> true then neighbors[0] := left;

end;

procedure setup;
var rows, cols, j, i, count : Integer;
var cells : Cell;
begin
    count := 0;
    rows := HAUTEUR div w;
    cols := LARGEUR div w;

    for j := 0 to rows-1 do
    begin
        for i := 0 to cols-1 do
        begin
            cells.i := i; // creer les cellules
            cells.j := j;
            cells.visited := false; // initialement les cellules n'ont pas ete visite
            cells.walls[0] := true; // initialement les cellules ont les 4 murs
            cells.walls[1] := true;
            cells.walls[2] := true;
            cells.walls[3] := true;
            //writeln(count,' ',cells.i, ' ',cells.j);
            grid[count] := cells; // ajouter les cellules dans un tableau
            count := count + 1;
        end;
    end;
    grid[0].visited := true;
    //grid[26].visited := true;
    //grid[48].visited := true;
    //grid[73].visited := true;
end;

end.