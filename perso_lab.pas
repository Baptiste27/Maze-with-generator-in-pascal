unit perso_lab;

interface

uses labyrinthe, const_lab, class_lab, sdl;


{ TSpriteSheet est une feuille de textures qui contient toutes les textures du jeu }
Type TSpriteSheet=record            // Definition du type enregistrement 
    up,down,right,left:PSDL_Surface;
end;

Type PSpriteSheet=^TSpriteSheet;            // Definition du type pointeur

type direction=(top, right, bottom, left);

Type coord=record
	x,y:Integer;
	dir : direction;
end;

procedure drawScene(screen : PSDL_SURFACE; perso : Coord; p_sprite_sheet : PSpriteSheet);
procedure processKey(key : TSDL_KeyboardEvent; var perso : Coord);

implementation

procedure drawScene(screen : PSDL_SURFACE; perso : Coord; p_sprite_sheet : PSpriteSheet);
var perso_sprite : PSDL_SURFACE;
    destination_rect : TSDL_RECT;
begin
    destination_rect.x := perso.x*w;
    destination_rect.y := perso.y*w;
    destination_rect.w := w;
    destination_rect.h := w;

    case perso.dir of
        top : perso_sprite := p_sprite_sheet^.up;
        right : perso_sprite := p_sprite_sheet^.right;
        bottom : perso_sprite := p_sprite_sheet^.down;
        left : perso_sprite := p_sprite_sheet^.left;
    end;
    { On affiche sur la surface le perso }
    SDL_BlitSurface(perso_sprite, NIL, screen, @destination_rect);
    SDL_Flip(screen);
end;

procedure processKey(key : TSDL_KeyboardEvent; var perso : Coord);
var x, y : Integer;
begin
    { Suivant la touche appuyée on change la direction du personnage et on le déplace
        sans sortir de la fenetre et sans rentrer dans un mur }
    x := perso.x;
    y := perso.y;

    case key.keysym.sym of
        SDLK_LEFT:  begin
                        perso.dir := left;
                        if x > 0 then
                            if grille[index(x, y)].walls[3] <> True then
                            begin
                                perso.x := x - 1;
                                //writeln('gauche', x);
                            end;
                    end;
        SDLK_RIGHT: begin
                       perso.dir := right;
                       if x < cols - 1 then
                            if grille[index(x, y)].walls[1] <> True then
                            begin
                                perso.x := x + 1;
                                //writeln('droite', x);
                            end;
                    end;
        SDLK_UP:    begin
                        perso.dir := top;
                        if y > 0 then
                            if grille[index(x, y)].walls[0] <> True then
                            begin
                                perso.y := y - 1;
                                //writeln('haut', y);
                            end;
                    end;
        SDLK_DOWN:  begin
                        perso.dir := bottom;
                        if y < rows - 1 then
                            if grille[index(x, y)].walls[2] <> True then
                            begin    
                                perso.y := y + 1;
                                //writeln('bas', y);
                            end;
                    end;
    end;
end;


end.