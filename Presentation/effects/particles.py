import random
import pygame

particles = []

WIDTH, HEIGHT = 1920, 1080

class Particle:
    def __init__(self):
        self.x = random.randint(0, WIDTH)
        self.y = random.randint(0, HEIGHT)

        self.vx = random.uniform(-0.5, 0.5)
        self.vy = random.uniform(-2, -0.5)

        self.size = random.randint(2, 6)
        self.life = random.randint(50, 150)

        self.color = (
            random.randint(150, 255),
            random.randint(150, 255),
            255
        )

    def update(self):
        self.x += self.vx
        self.y += self.vy
        self.life -= 1

        # wrap around screen
        if self.y < 0:
            self.y = HEIGHT
            self.x = random.randint(0, WIDTH)
            self.life = random.randint(50, 150)

    def draw(self, screen):
        alpha = max(0, int(self.life * 2))

        surf = pygame.Surface((self.size*4, self.size*4), pygame.SRCALPHA)

        pygame.draw.circle(
            surf,
            self.color,
            (self.size*2, self.size*2),
            self.size
        )

        screen.blit(
            surf,
            (self.x - self.size*2,
             self.y - self.size*2)
        )


# create particles
for _ in range(300):
    particles.append(Particle())


def update():
    for p in particles:
        p.update()


def draw(screen):
    for p in particles:
        p.draw(screen)