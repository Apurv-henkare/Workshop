# What is a Game Loop ?

A **Game Loop** is a fundamental concept in game development. It's a continuous process that controls the flow of a video game, allowing it to update and render the game world, handle player input, and maintain a consistent frame rate. The game loop is responsible for making the game interactive and responsive to player actions.

<p align="center">
  <img src="https://gameprogrammingpatterns.com/images/game-loop-fixed.png" alt="Gameloop" width="780" height = "309">
</p>

<sup>Credits: Bob Nystrom, Game Programming Patterns</sup>

## Implementation of a Game Loop

Implementing a game loop involves balancing the need for smooth gameplay and efficient resource usage. Here's a basic outline of how a game loop can be implemented:

```lua
while (true)
{
  processInput(); --Process Player Input
  update(); --Update Game State
  render(); --Render Game World and Objects
  control_framerate() -- Control Framerate using Timing Mechanisms
}
```

1. **Input Handling**: The loop starts by checking for user input, such as keyboard or mouse actions, controller input, or touch events. This allows the game to respond to the player's commands.

2. **Update Phase**: During this phase, the game logic is updated. This involves calculating changes in the game world based on the passage of time. For example, characters might move, AI might make decisions, physics simulations might be updated, and various game systems are processed.

3. **Rendering**: In this phase, the updated game state is rendered to the screen. This includes drawing characters, objects, environments, user interfaces, and other visual elements. The goal is to create a visually coherent frame for the player.

4. **Frame Rate Control**: To ensure a smooth and consistent experience, the game loop often incorporates a mechanism to control the frame rate. This might involve limiting the number of updates and renders per second to match the capabilities of the hardware.

5. **Repeat**: After completing the rendering phase, the loop starts over by checking for input, updating the game state, and rendering the next frame. This cycle continues as long as the game is running.

After completing the rendering phase, the loop starts over by checking for input, updating the game state, and rendering the next frame. This cycle continues as long as the game is running.

## Timing Mechanisms:
Timing is critical for a smooth game experience. Most game loops use one of these timing mechanisms:

* **Fixed Time Step**: In this approach, the game updates at a fixed interval, regardless of the actual frame rate. This ensures consistent behavior across different systems, but it might not take full advantage of high-performance hardware.

* **Variable Time Step**: Here, the game loop measures the time between frames and adjusts the game logic updates accordingly. This provides smoother animations, but it can lead to different behaviors on various systems.

* **Frame Skipping**: If the game is running too slowly, some frames might be skipped to catch up with real-time. This maintains the responsiveness of the game at the cost of visual smoothness.

## Controlling Gameplay Speed in a Game Loop:
In a game loop, there are different methods to control how fast the game runs and adapts to varying hardware. The main focus is on managing time and making sure the game runs smoothly on different devices.


1. Fixed Time Step without Synchronization:
Simple and Direct: The game loop runs as quickly as possible without waiting for anything.  
    * **Pros**: Easy to understand and implement.  
    * **Cons**: Game speed directly depends on hardware and complexity. If there's variation, game speed is affected.

2. Fixed Time Step with Synchronization:
Adding a Rest: The game loop still has a fixed time step, but it includes a short delay to avoid running too fast.
    * _**Pros**_: Power-efficient, saving battery on mobile devices. Prevents the game from running too fast.  
    * _**Cons**_: The game might run slower than intended if updates and rendering take longer.

3. Variable Time Step:
Adapting to Time: The game loop adjusts the time step depending on how fast the game is running.  
    * _**Pros**_: Adapts to both slow and fast systems.  
    * _**Cons**_: Makes gameplay unpredictable and unstable. Can cause issues with physics and networking.

4. Fixed Update Time Step, Variable Rendering:
Balancing Act: The game loop updates with a fixed time step but adjusts rendering frames to match the player's pace.
    * _**Pros**_: Adapts to different systems, providing smoother gameplay on high-end devices.  
    * _**Cons**_: More complex to implement. Requires finding a balance between fast updates for powerful devices and not being too slow for low-end devices.

In summary, the game loop's job is to ensure that the game runs smoothly regardless of the hardware it's on. The methods for controlling gameplay speed involve finding a balance between fixed time steps, synchronization, and adapting to the passage of time. Each method has its pros and cons, so game developers choose the one that best fits their game's needs and the devices it will be played on.

