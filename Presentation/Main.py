import pygame
import math
from effects import particles
from slides import s1, s2, s3, s4

spring_phase = 0

Toggleparticles = False
SLIDES = [s1, s2, s3, s4]
current_slide = 0

pygame.init()





def draw_spring_simulation(screen, x, y, width, height):
    global spring_phase

    # Rectangle
    box = pygame.Rect(x, y, width, height)
    pygame.draw.rect(screen, (0, 0, 0), box)          # Fill black
    pygame.draw.rect(screen, (255, 255, 255), box, 2) # White border

    center_y = y + height // 2

    # Block movement
    movement = math.sin(spring_phase) * 70

    block_w = 60
    block_h = 60

    block_x = x + width // 2 - block_w // 2 + movement
    block_y = center_y - block_h // 2

    pygame.draw.rect(
        screen,
        (220, 220, 220),
        (block_x, block_y, block_w, block_h)
    )

    def draw_spring(start_x, end_x, color):
        coils = 12
        amplitude = 12

        points = [(start_x, center_y)]

        for i in range(1, coils):
            t = i / coils
            px = start_x + (end_x - start_x) * t
            py = center_y + (amplitude if i % 2 else -amplitude)
            points.append((px, py))

        points.append((end_x, center_y))

        pygame.draw.lines(screen, color, False, points, 3)

    # Left spring (blue)
    draw_spring(
        x + 20,
        block_x,
        (80, 170, 255)
    )

    # Right spring (orange)
    draw_spring(
        x + width - 20,
        block_x + block_w,
        (255, 170, 60)
    )

    # Walls
    pygame.draw.line(
        screen,
        (255,255,255),
        (x + 20, center_y - 45),
        (x + 20, center_y + 45),
        4
    )

    pygame.draw.line(
        screen,
        (255,255,255),
        (x + width - 20, center_y - 45),
        (x + width - 20, center_y + 45),
        4
    )

    spring_phase += 0.05



ball_x = 0
ball_y = 0
vx = 4
vy = 3
timer = 0

def draw_ball_simulation(screen, x, y, width, height):
    global ball_x, ball_y, vx, vy, timer

    box = pygame.Rect(x, y, width, height)

    if ball_x == 0 and ball_y == 0:
        ball_x = box.centerx
        ball_y = box.centery

    pygame.draw.rect(screen, (0,0,0), box)
    pygame.draw.rect(screen, (255,255,255), box, 2)

    radius = 12

    ball_x += vx
    ball_y += vy
    timer += 1

    # odbicia
    if ball_x-radius <= box.left or ball_x+radius >= box.right:
        vx *= -1

    if ball_y-radius <= box.top or ball_y+radius >= box.bottom:
        vy *= -1


    # po 8 sekundach reset
    if timer > 480:  # 60 FPS * 8 sekund
        ball_x = box.centerx
        ball_y = box.centery
        timer = 0


    pygame.draw.circle(
        screen,
        (255,255,255),
        (int(ball_x), int(ball_y)),
        radius
    )


ai_timer = 0

def draw_ai_simulation(screen):
    global ai_timer

    width, height = screen.get_size()
    center_y = height // 2

    screen.fill((0, 0, 0))

    # ---------- Pozycje neuronów ----------

    layer1 = [
        (int(width * 0.25), center_y - 150),
        (int(width * 0.25), center_y - 50),
        (int(width * 0.25), center_y + 50),
        (int(width * 0.25), center_y + 150),
    ]

    layer2 = [
        (int(width * 0.45), center_y - 120),
        (int(width * 0.45), center_y),
        (int(width * 0.45), center_y + 120),
    ]

    layer3 = [
        (int(width * 0.65), center_y - 70),
        (int(width * 0.65), center_y + 70),
    ]

    output = (int(width * 0.85), center_y)

    # ---------- Połączenia ----------

    for a in layer1:
        for b in layer2:
            pygame.draw.line(screen, (80, 80, 80), a, b, 2)

    for a in layer2:
        for b in layer3:
            pygame.draw.line(screen, (80, 80, 80), a, b, 2)

    for a in layer3:
        pygame.draw.line(screen, (80, 80, 80), a, output, 2)

    t = ai_timer

    # ---------- Kolory neuronów ----------

    c1 = (70, 140, 255)
    c2 = (255, 170, 40)
    c3 = (255, 90, 90)
    c4 = (80, 255, 120)

    # Podświetlanie aktywnej warstwy
    if 180 <= t < 360:
        c1 = (170, 220, 255)

    if 360 <= t < 540:
        c2 = (255, 230, 120)

    if 540 <= t < 720:
        c3 = (255, 170, 170)

    if 720 <= t < 900:
        c4 = (170, 255, 180)

    # ---------- Rysowanie neuronów ----------

    for p in layer1:
        pygame.draw.circle(screen, c1, p, 22)

    for p in layer2:
        pygame.draw.circle(screen, c2, p, 22)

    for p in layer3:
        pygame.draw.circle(screen, c3, p, 22)

    pygame.draw.circle(screen, c4, output, 24)

    # ---------- Animacja danych ----------

    if t < 180:
        progress = t / 180

        x = int(width * 0.05 + progress * width * 0.18)

        for dy in (-60, 0, 60):
            pygame.draw.circle(
                screen,
                (120, 180, 255),
                (x, center_y + dy),
                10
            )

    if 720 <= t < 900:
        progress = (t - 720) / 180

        x = int(output[0] + progress * width * 0.1)

        pygame.draw.circle(
            screen,
            (120, 255, 120),
            (x, center_y),
            14
        )

    # ---------- Napisy ----------

    font = pygame.font.Font(None, 54)

    screen.blit(font.render("INPUT", True, (210,210,210)),
                (410, 100))

    screen.blit(font.render("HIDDEN 1", True, (210,210,210)),
                (int(width*0.40), 100))

    screen.blit(font.render("HIDDEN 2", True, (210,210,210)),
                (int(width*0.60), 100))

    screen.blit(font.render("OUTPUT", True, (210,210,210)),
                (int(width*0.78), 100))

    ai_timer += 1

    # Reset po około 25 s przy 60 FPS
    if ai_timer >= 1000:
        ai_timer = 0





WIDTH = 1920
HEIGHT = 1080

pygame.mixer.music.load("assets/music/music.mp3")
pygame.mixer.music.play(-1)


screen = pygame.display.set_mode(
    (WIDTH, HEIGHT),
    pygame.FULLSCREEN
)

clock = pygame.time.Clock()

running = True

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_RIGHT:
                current_slide += 1
            if event.key == pygame.K_LEFT:
                current_slide -= 1
            if event.key == pygame.K_z:
                Toggleparticles=not Toggleparticles

    screen.fill((0, 0, 0))
    if Toggleparticles:
        particles.update()
        particles.draw(screen)
    SLIDES[current_slide].draw(screen)
    if(current_slide == 1):
        draw_spring_simulation(screen, 700, 450, 500, 300)
    if(current_slide == 2):
        draw_ball_simulation(screen, 700, 450, 500, 300)
    if(current_slide == 3):
        draw_ai_simulation(screen)
    pygame.display.flip()
    clock.tick(60)

pygame.quit()