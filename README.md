# Top-Down-2D (Godot + LimboAI)
Este proyecto consiste en un prototipo de juego top-down enfocado en combate y comportamiento de enemigos.
Implemente un sistema de inteligencia artificial utilizando Behavior Trees con LimboAI, junto con una arquitectura modular basada en componentes y sistemas.

### Funcionalidades implementadas
- Movimiento y combate básico del jugador
- Sistema de daño con feedback visual (flash, partículas, camera shake)
- Enemigo con comportamiento autónomo usando Behavior Trees (LimboAI)
- Maquina de estados para control de comportamiento
- Sistema de spawn de enemigos
- Componentes reutilizables
  - Health
  - Hitbox / Hurtbox
- Efectos de sonido contextuales

---

### Instrucciones para ejecutar
#### Requisitos
- Godot Engine (versión utilizada: 4.6.2)
- Addon:
  - LimboAI (incluido en la carpeta `addons/`)

#### Pasos
1. Clonar el repositorio
2. Abrir el proyecto con Godot
3. Ejecutar la escena principal (ubicada en `scenes/world/` o configurada como main scene)

#### Controles
- Movimiento: WASD
- Ataque: Space

---

### Decisiones de diseño y arquitectura
1. Uso de Behavior Trees (LimboAI)
Utilice LimboAI para implementar la lógica de los enemigos mediante Behavior Trees, lo que me permitió:
- Separar lógica de decisión de la implementación
- Facilitar la escalabilidad del comportamiento
- Reutilizar tareas entre distintos estados

---

2. Arquitectura basada en componentes
Implemente componentes reutilizables como:
- Health
- Hitbox/Hurtbox
Esto permite desacoplar funcionalidades y reutilizar entre distintas entidades (player, enemigos).

---

3. Separación por sistemas
La lógica global del juego la organice en sistemas independientes, como:
- Spawn controller
- Máquina de estados
Esto ayuda a mantener el código limpio.
