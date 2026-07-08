import pygame

def draw_text(screen, text, x, y, size):
    font = pygame.font.Font(
        "assets/fonts/Geist.ttf",
        size
    )

    surface = font.render(
        text,
        True,
        (255,255,255)
    )

    screen.blit(surface, (x,y))