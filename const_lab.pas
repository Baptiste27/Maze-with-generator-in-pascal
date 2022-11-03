unit const_lab;

interface

uses sdl;

const
    HAUTEUR = 800;
    LARGEUR = 1200;
    w = 30; // cellule = carre de w*w
    cols = LARGEUR div w; //nb de colonne largeur de la zone diviser par la taille d une cellule
    rows = HAUTEUR div w;
    nbCell = cols * rows;

procedure fillRect(x, y, w, h, r, g, b : Integer; screen : PSDL_Surface);
procedure blitSurface(x, y, w, h : Integer; screen, surface : PSDL_Surface);


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

procedure blitSurface(x, y, w, h : Integer; screen, surface : PSDL_Surface);
var destination_rect : TSDL_RECT;
begin
    destination_rect.x := x;
    destination_rect.y := y;
    destination_rect.w := w;
    destination_rect.h := h;
    SDL_BlitSurface(surface, NIL, screen, @destination_rect);
end;

end.