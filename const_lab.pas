unit const_lab;

interface

uses sdl;

const
    HAUTEUR = 800;                  // Taille de la surface d'affichage
    LARGEUR = 1200;
    w = 30;                         // Taille des cellules = carré de w*w
    cols = LARGEUR div w;           // Nombre de colonnes
    rows = HAUTEUR div w;
    nbCell = cols * rows;           // Nombre de cellules

procedure fillRect(x, y, w, h, r, g, b : Integer; screen : PSDL_Surface);
procedure blitSurface(x, y, w, h : Integer; screen, surface : PSDL_Surface);


implementation

procedure fillRect(x, y, w, h, r, g, b : Integer; screen : PSDL_Surface);
{ Simplifie la procedure SDL_FillRect }
var destination_rect : TSDL_RECT;
begin
    destination_rect.x := x;
    destination_rect.y := y;
    destination_rect.w := w;
    destination_rect.h := h;
    SDL_FillRect(screen, @destination_rect, SDL_MapRGB(screen^.format, r, g, b));
end;

procedure blitSurface(x, y, w, h : Integer; screen, surface : PSDL_Surface);
{ Simplifie la procedure SDL_BlitSurface }
var destination_rect : TSDL_RECT;
begin
    destination_rect.x := x;
    destination_rect.y := y;
    destination_rect.w := w;
    destination_rect.h := h;
    SDL_BlitSurface(surface, NIL, screen, @destination_rect);
end;

end.