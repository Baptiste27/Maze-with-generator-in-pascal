{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}

program main;

uses labyrinthe, const_lab, perso_lab, sdl, sdl_image, sysutils, sdl_ttf;


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

function initSprites() : PSpriteSheet;
{On charge les textures en memoires}
var newSpriteSheet : PSpriteSheet;
begin
    new(newSpriteSheet);
    newSpriteSheet^.up:=IMG_Load('ressources/haut.png');
    newSpriteSheet^.down:=IMG_Load('ressources/bas.png');
    newSpriteSheet^.right:=IMG_Load('ressources/droite.png');
    newSpriteSheet^.left:=IMG_Load('ressources/gauche.png');
    initSprites:=newSpriteSheet;
end;

procedure disposeSprite(p_sprite_sheet: PSpriteSheet);
{On décharge les textures de la mémoire}
begin
    SDL_FreeSurface(p_sprite_sheet^.up);
    SDL_FreeSurface(p_sprite_sheet^.down);
    SDL_FreeSurface(p_sprite_sheet^.right);
    SDL_FreeSurface(p_sprite_sheet^.left);
    dispose(p_sprite_sheet);
end;

var fin : Boolean;
    fenetre : PSDL_SURFACE;
    event : TSDL_Event;
    perso : Coord;
    sprites : PSpriteSheet;
begin
    randomize;
    initialise(fenetre);
    setup;
    SDL_EnableKeyRepeat(0,1000);
    

    fin := False;
    sprites := initSprites();
    perso.x := 0;
    perso.y := 0;
    perso.dir := bottom;

    while not fin do
    begin
        SDL_Delay(40); // 25 fps

        draw(fenetre);
        drawScene(fenetre, perso, sprites);
        SDL_Flip(fenetre);
        SDL_PollEvent(@event);
        if event.type_ = SDL_KEYDOWN then processKey(event.key, perso);
        if event.type_ = SDL_QUITEV then fin := True;
        if perso.x = arrivee.i then if perso.y = arrivee.j then fin := True;
    end;

    termine(fenetre);
end.