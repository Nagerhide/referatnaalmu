from .Basics import draw_text

def draw(screen):
    draw_text(
        screen,
        "Jak działa symulacja?",
        500,
        100, 100
    )
    draw_text(
        screen,
        "Symulacja przyjmuje parametry, które później przetwarza i zwraca wynik",
        610,
        280, 20
    )
    draw_text(
        screen,
        "Ponieważ dane mogą być astronomiczne, do przetwarzania danych wykorzystujemy zazwyczaj karty graficzne.",
        440,
        330, 20
    )
    draw_text(
        screen,
        "Coraz częściej wykorzystuje się AI do tworzenia symulacji, gdyż pozwala ono tworzyć modele, samemu nie znając algorytmu.",
        380,
        380, 20
    )