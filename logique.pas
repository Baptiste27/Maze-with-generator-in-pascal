unit logique;

interface

uses typesLab, sdl, sdl_image;

Const 
    w = 40; //taille des cellules (carre de 40*40)

var grid : array[0..99] of Cell; // 100 cellules dans le labyrinthe
var current : Cell; // variable contenant la cellule actuelle 

procedure show(grid : Array of Cell; screen : PSDL_Surface);
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
        //if grid[count].visited = true then fillRect(x, y, w, w, 255, 0, 255, screen);
        if grid[count].walls[0] then fillRect(x        , y        , w, 1, 150, test - count*2, 0, screen); // ligne à gauche de la cellule
        if grid[count].walls[1] then fillRect(x        , y        , 1, w, 150, test - count*2, 0, screen); // ligne en haut de la cellule
        if grid[count].walls[2] then fillRect(x + w - 1, y        , 1, w, 150, test - count*2, 0, screen); // ligne à droite de la cellule
        if grid[count].walls[3] then fillRect(x        , y + w - 1, w, 1, 150, test - count*2, 0, screen); // ligne en bas de la cellule
        SDL_Flip(screen);
    end;
    current.visited := true;
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
            //writeln(count,' ',cells.i, ' ',cells.j);
            grid[count] := cells; // ajouter les cellules dans un tableau
            count := count + 1;
        end;
    end;
    current := grid[0];
end;

end.