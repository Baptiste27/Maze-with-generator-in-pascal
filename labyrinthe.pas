unit labyrinthe;

interface

uses sdl, class_lab, const_lab;

procedure setup;
procedure removeWalls(a, b : Cell);
procedure draw(var screen : PSDL_Surface);

implementation

procedure setup;
var count, i, j, k: Integer;
var cellule : Cell;
begin
    count := 0;
    for j := 0 to rows -1 do
    begin
        for i := 0 to cols - 1 do
        begin
            cellule := Cell.new(i, j);
            for k := 0 to 3 do
            begin
                cellule.walls[k] := true; // De base, les cellules ont les 4 murs
            end;
        grid[count] := cellule;
        count := count + 1;
        end;
    end;
    current := grid[0];
    //grid[0].visited := true; // Première cellule sur laquelle on sera
end;


procedure removeWalls(a, b : Cell);
var x, y : Integer;
begin
    x := a.i - b.i;
    if x = 1 then
    begin
        a.walls[3] := false;
        b.walls[1] := false;
    end
    else if x = -1 then
    begin
        a.walls[1] := false;
        b.walls[3] := false;
    end
    else
    begin
        y := a.j -  b.j;
        if y = 1 then
        begin
            a.walls[0] := false;
            b.walls[2] := false;
        end
        else if y = -1 then
        begin
            a.walls[2] := false;
            b.walls[0] := false;
        end
    end
end;


procedure draw(var screen :  PSDL_Surface);
var k, count : Integer;
begin
    count := 0;
    undefined := Cell.new(-1, -1);  // Cellule indefini

    while count >= 0 do
    begin
        current.visited := true;
        next := current.checkNeighbors();      // ETAPE 1 choisir un voisin aleatoirement
        if next <> undefined then 
        begin

            stack[count] := current;
            count := count + 1;
            //writeln(count);

            removeWalls(current, next);         // ETAPE 3 retirer les murs
            next.visited := true;
            current := next;
        end
        else if count >= 0 then       // si la pile n'est pas vide
        begin
            if count = 0 then count := -1 // si count = 0, on a tout depiler
            else
            begin
                count := count - 1;
                //writeln(count, ' ', 'indefini');
                current := stack[count];
            end;
        end;
    end;

    for k := 0 to Length(grid) - 1 do
    begin
        grid[k].show(screen);
    end;

end;

end.