The `atan2` function, short for "arctangent 2," is a mathematical function commonly found in programming libraries and used to calculate the angle between the positive X-axis and a point given its Cartesian coordinates (X, Y).

In other words, `atan2` takes two arguments: the Y-coordinate and the X-coordinate of a point and returns the angle (in radians) between the positive X-axis and the line connecting the origin (0, 0) to the given point.

The key advantage of `atan2` over a simple `atan(y/x)` calculation is that it can handle all four quadrants of the Cartesian coordinate system without needing special case handling. This is because it takes both the Y and X coordinates as inputs, which allows it to determine the correct angle and handle the sign of the coordinates.

Here's how the angle is calculated for different quadrants:

- Quadrant I (top right): The angle is positive and measured counterclockwise from the positive X-axis.
- Quadrant II (top left): The angle is positive and measured counterclockwise from the positive X-axis.
- Quadrant III (bottom left): The angle is negative and measured clockwise from the negative X-axis.
- Quadrant IV (bottom right): The angle is negative and measured clockwise from the negative X-axis.

Here's an example usage in Lua:

```lua
local angle = math.atan2(2, 1)  -- Calculates the angle for the point (1, 2)
print("Angle in radians:", angle)
print("Angle in degrees:", math.deg(angle))  -- Converts radians to degrees
```

In this example, the point (1, 2) is in the first quadrant, so the calculated angle would be positive and measured counterclockwise from the positive X-axis.

The result of `atan2` is usually in radians. If you want the angle in degrees, you can use the `math.deg` function to convert it from radians to degrees.
