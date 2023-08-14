## Inheritance:
Inheritance is a fundamental OOP concept where you can create a 
new class (subclass) based on an existing class (parent or superclass).
Subclasses inherit properties and methods from their parent classes.
In Love##, you can implement inheritance by creating tables that act as classes.
Subclasses extend these classes to inherit and extend their behavior.

### Example:

Imagine a game where you have different types of enemies.
You could define a generic Enemy class that includes properties and methods common to all enemies. 
Then, create specific enemy subclasses like Zombie and Alien that inherit from the Enemy class.
This way, the subclasses automatically gain the shared functionality while allowing you to customize their behavior.

## Encapsulation:
Encapsulation involves bundling data (properties) and methods that operate on 
the data within a single unit (object). In Love##, you can achieve encapsulation by 
creating Lua tables (objects) that contain both properties and methods. 
This encapsulated design helps manage data and behavior associated with specific entities or elements in your game.

### Example:

In a platformer game, you might encapsulate a Player entity by creating a Player class.
This class could include properties like position and velocity and methods for updating the player's position,
handling input, and managing animations. By encapsulating these details within the Player class,
you keep the player's logic contained and organized.

## Polymorphism:
Polymorphism allows objects of different classes to be treated as
instances of a common superclass. In Love##, you can achieve polymorphism by 
designing methods with the same name but different behaviors in subclasses. 
This allows you to use objects interchangeably based on their shared interface, 
making code more flexible and extensible.

### Example:

Consider a strategy game with different types of units (e.g., infantry, cavalry, archers). 
You could define a common Unit class with methods like move and attack.
Each unit type (subclasses) would implement these methods differently to suit their unique characteristics.
Despite the differences, you can treat all units uniformly through their shared interface.

## Abstraction:
Abstraction involves modeling classes based on their essential characteristics, 
simplifying complex reality. In Love##, you can create abstract classes that 
define common behaviors and properties for a group of related game entities.
Subclasses then implement specific variations while adhering to the common interface defined by the abstract class.

### Example:

Suppose you're making a space exploration game with various celestial bodies like planets, stars, and asteroids.
You could create an abstract CelestialBody class that defines properties such as position and radius
and methods like draw and update. Subclasses like Planet and Star would inherit from this abstract class,
allowing you to create and manage different celestial bodies with a consistent interface.
