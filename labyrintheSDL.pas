program labyrintheSDL;

uses sdl, sdl_image, sysutils, typesLab, logique;

procedure initialise(var screen : PSDL_Surface);
begin
    SDL_Init(SDL_INIT_VIDEO);
    screen := SDL_SetVideoMode(LARGEUR, HAUTEUR, 32, SDL_SWSURFACE); //largeur, hauteur, *profondeur des couleurs, type de fenetre
end;

procedure termine(var screen : PSDL_Surface);
begin
    SDL_FreeSurface(screen);
    SDL_Quit();
end;

var fenetre : PSDL_Surface;
begin
    initialise(fenetre);
    SDL_Delay(1000);
    //fillRect(100, 100, 50, 50, 108, 214, 96, fenetre);
    setup;
    show(grid, fenetre);
    SDL_Flip(fenetre);
    SDL_Delay(5000);
    termine(fenetre);
end.