unit typesLab;

interface

uses sdl;

{~~~~~~~~~~ Les constantes ~~~~~~~~~~}

const
    HAUTEUR = 400;
    LARGEUR = 400;


{~~~~~~~~~~ Les types ~~~~~~~~~~}

{ Type
    Cell = record 
        i, j : Integer;
        walls : Array[0..3] of Boolean;
        visited : Boolean;
    end;
 \}
{~~~~~~~~~~ Les procedures ~~~~~~~~~~}

procedure fillRect(x, y, w, h, r, g, b : Integer; screen : PSDL_Surface);

implementation

procedure fillRect(x, y, w, h, r, g, b : Integer; screen : PSDL_Surface);
var destination_rect : TSDL_RECT;
begin
    destination_rect.x := x;
    destination_rect.y := y;
    destination_rect.w := w;
    destination_rect.h := h;
    SDL_FillRect(screen, @destination_rect, SDL_MapRGB(screen^.format, r, g, b));
end;

end.