program labyrinthe;

const 
    MAX = 100;
    rows = 10;
    cols = 10;
    w = 40;


Type 
    Lab = array[1..MAX, 1..MAX] of Boolean;

    Coord = record
        x, y: Integer
    end;

    Cell = record
        i, j: Integer;
        visited: Boolean;
        walls: array[1..4] of Boolean; 
    end;

var grid : array[0..MAX] of Cell;

procedure setup;
var i,j : Integer;
var cells : Cell;
var count : Integer;
begin 
    count := 0;
    for j := 0 to rows do
        begin 
            for i := 0 to cols do
                begin
                    cells.i := i;
                    cells.j := j;
                    grid[count] := cells;
                    write(count,' ');
                    count := count + 1;
                    if i = 10 then writeln();
                end
        end;
    if cells.walls[1] <> true then writeln('Le silence eternel de ces espaces infinis m effraie');
end;

procedure show(cell: Cell);
var x, y: Integer;
begin
    x := cell.i * w;
    y := cell.j * w;
end;

begin
setup;
end.