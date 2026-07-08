from .Basics import draw_text

def draw(screen):
    draw_text(
        screen,
        "Czym jest symulacja?",
        500,
        100, 100
    )
    draw_text(
        screen,
        "Symulacja to przybliżone odtwarzanie zjawisk czy zachowań obiektu za pomocą modelu.",
        540,
        280, 20
    )
    draw_text(
        screen,
        "Gdy nie jesteśmy w stanie coś policzyć dokładnie, to korzystając z symulacji można coś policzyć.",
        500,
        330, 20
    )
    draw_text(
        screen,
        "Symulacje potrafią też rozpatrzeć hipotetyczne scenariusze, których prawdopodobieństwo w prawdziwym życiu jest znikome.",
        380,
        380, 20
    )