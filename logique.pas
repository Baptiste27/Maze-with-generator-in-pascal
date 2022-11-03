{
    Implementation de l'algorithme Randomized depth-first search

    Sources : 
        https://en.wikipedia.org/wiki/Maze_generation_algorithm#Randomized_depth-first_search
        Video de Coding Train : https://youtu.be/HyK_Q5rrcr4
}
unit logique;

interface

uses typesLab, sdl, sdl_image, crt;

Const 
    w = 40; //taille des cellules (carre de 40*40)

var grid : array[0..99] of Cell; // 100 cellules dans le labyrinthe
var current, next : Cell; // variable contenant la cellule actuelle 
var index : Integer;

procedure show(grid : Array of Cell; screen : PSDL_Surface);
procedure calcIndex(i, j : Integer);
procedure checkNeighbors(cell : Cell);
procedure setup;

implementation

procedure show(grid : Array of Cell; screen : PSDL_Surface); //affiche les murs des cellules
var x, y, count: Integer;
begin
    current := grid[0];
    for count := 0 to Length(grid)-1 do
    begin
        x := grid[count].i * w;
        y := grid[count].j * w;
        //grid[count].visited := true;
        //if grid[count].visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
        if grid[count].walls[0] then fillRect(x        , y        , w, 1, 255, 255, 255, screen); // ligne à gauche de la cellule
        if grid[count].walls[1] then fillRect(x        , y        , 1, w, 255, 255, 255, screen); // ligne en haut de la cellule
        if grid[count].walls[2] then fillRect(x + w - 1, y        , 1, w, 255, 255, 255, screen); // ligne à droite de la cellule
        if grid[count].walls[3] then fillRect(x        , y + w - 1, w, 1, 255, 255, 255, screen); // ligne en bas de la cellule
        SDL_Flip(screen);
        //writeln(grid[count].walls[0], grid[count].walls[3]);
    end;
    current.visited := true;
    x := current.i * w;
    y := current.j * w;
    if current.visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
    checkNeighbors(current); //current deviens la cellule suivante
    x := current.i * w;
    y := current.j * w;
    if current.visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
    if current.i < 10 then //Donc si current n'est pas une cellule hors de la grille
        begin
            current.visited := true;
            x := current.i * w;
            y := current.j * w;
            if current.visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
            checkNeighbors(current);
            x := current.i * w;
            y := current.j * w;
            if current.visited = true then fillRect(x, y, w, w, 0, 0, 255, screen);
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
var top, right, bottom, left, horside, randomCell : Cell;
var nbVoisins, count, r : Integer;
begin
    writeln(neighbors[0].i);
    Randomize;
    horside.i := 10;
    horside.j := 10;
    horside.visited := true;
    {Pas sur de ce que je fais ici avec mes cellules en dehors de la grille}
    nbVoisins := 0;
    count := 0;
    calcIndex(cell.i, cell.j - 1);
    if index <> -1 then begin top := grid[index]; nbVoisins := nbVoisins + 1 end;
    if index = -1 then top.visited := true;
    calcIndex(cell.i + 1, cell.j);
    if index <> -1 then begin right := grid[index]; nbVoisins := nbVoisins + 1 end; 
    if index = -1 then right.visited := true;                   
    calcIndex(cell.i, cell.j + 1);
    if index <> -1 then begin bottom := grid[index]; nbVoisins := nbVoisins + 1 end; 
    if index = -1 then bottom.visited := true; 
    calcIndex(cell.i - 1, cell.j);
    if index <> -1 then begin left := grid[index]; nbVoisins := nbVoisins + 1 end;
    if index = -1 then left.visited := true; 
    //write(index); 

    if top.visited <> true then begin neighbors[count] := top; count := count + 1 end; //si la cellule n a pas ete visite, on ajoute la cellule dans le debut du tableau et on incremente count de 1
    if top.visited = true then neighbors[3-count] := horside; // si la cellule a deja ete visite, on ajoute la cellule dans la fin du tableau
    if right.visited <> true then begin neighbors[1] := right; count := count + 1 end;
    if right.visited = true then neighbors[3-count] := horside;
    if bottom.visited <> true then begin neighbors[2] := bottom; count := count + 1 end;
    if bottom.visited = true then neighbors[3-count] := horside;
    if left.visited <> true then begin neighbors[3] := left; count := count + 1 end; 
    if left.visited = true then neighbors[3-count] := horside;
    //writeln(neighbors[0].visited, ' ', neighbors[0].i, ' ', neighbors[0].j, ' ', neighbors[0].walls[0]);

    if nbVoisins > 0 then randomCell := neighbors[random(nbVoisins+1)] else randomCell := horside;
    current := randomCell;
    //writeln(nbVoisins, ' ', r);


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