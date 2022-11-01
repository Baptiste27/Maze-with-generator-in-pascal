{
    Implementation de l'algorithme Randomized depth-first search

    Sources : 
        https://en.wikipedia.org/wiki/Maze_generation_algorithm#Randomized_depth-first_search
        Video de Coding Train : https://youtu.be/HyK_Q5rrcr4
}
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
        checkNeighbors(grid[count]);
        //writeln(grid[count].walls[0], grid[count].walls[3]);
    end;
    
    
end;

procedure calcIndex(i, j : Integer);
var cols, rows : Integer;
begin
    cols := LARGEUR div w;
    rows := HAUTEUR div w;
    if ((i < 0) or (j < 0) or (i > cols - 1) or (j > rows - 1)) then index := -1 // cas des cellules sur le bord de la grille
    else index := i + j * (LARGEUR div w);
end;

procedure checkNeighbors(cell : Cell); // check si les voisins ont deja ete visite
var neighbors : Array[0..3] of Cell;
var top, right, bottom, left : Cell;
begin
    calcIndex(cell.i, cell.j - 1);
    if index <> -1 then top := grid[index] else top.visited := true;
    calcIndex(cell.i + 1, cell.j);
    if index <> -1 then right := grid[index] else right.visited := true;                   
    calcIndex(cell.i, cell.j + 1);
    if index <> -1 then bottom := grid[index] else bottom.visited := true; 
    calcIndex(cell.i - 1, cell.j);
    if index <> -1 then left := grid[index] else left.visited := true; 
    //write(index); 

    if top.visited <> true then neighbors[0] := top;
    if right.visited <> true then neighbors[1] := right;
    if bottom.visited <> true then neighbors[2] := bottom;
    if left.visited <> true then neighbors[3] := left;
    writeln(neighbors[0].visited, ' ', neighbors[0].i, ' ', neighbors[0].j, ' ', neighbors[0].walls[0]);

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