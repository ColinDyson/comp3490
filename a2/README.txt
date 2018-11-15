Name - Colin Dyson
Student # - 7683407

This assignment was created using Processing v3.4 on Windows 10 laptop with an
Nvidia NVS 3100M GPU

Question 1 Transformations:

translation: tree, window
rotation: roof, window
scaling: door
reflection: roof, trunk
shearing: leaves, front wall

Note that the roof is not always attached to the wall due to
it's uniform scaling.

From bottom-left to top right:
1)  roof scaled 1.25x, tree scaled 1x
    door scaled 0.75x
    roof rotated 5 degrees, window rotated 10 degrees
    leaves sheared by 30 degrees, wall sheared by 5 degrees
    window moved up, tree moved down
    4x4 brick wall

2)  roof scaled 1.15x, tree scaled 1.2x
    door scaled 0.6x
    roof rotated 20 degrees, window rotated -35 degrees
    leaves sheared by -20 degrees, wall sheared by 10 degrees
    window moved up, tree moved left
    6x5 brick wall

3)  roof scaled 1.2x, tree scaled 0.6x
    door scaled 0.9x
    roof rotated 30 degrees, window rotated 60 degrees
    leaves sheared by -10 degrees, wall sheared by -5 degrees
    window moved left, tree moved up and right
    4x4 brick wall

4)  roof scaled 1.1x, tree scaled 1.1x
    door scaled 0.8x
    roof rotated 45 degrees, window rotated -5 degrees
    leaves sheared by 15 degrees, wall sheared by -10 degrees
    window moved down and right, tree moved up and right
    5x4 brick wall

5)  No transformations

6)  roof scaled 0.9x, tree scaled 0.7x
    door scaled 1.2x
    roof rotated 10 degrees, window rotated 45 degrees
    leaves sheared by -30 degrees, wall sheared by 15 degrees
    window moved right, tree moved left
    5x5 brick wall

7)  roof scaled 0.8x, tree scaled 0.9x
    door scaled 0.55x
    roof rotated 60 degrees, window rotated -20 degrees
    leaves sheared by -25 degrees, wall sheared by 20 degrees
    window moved up and left, tree moved up and right
    6x4 brick wall

8)  roof scaled 0.7x, tree scaled 1.25x
    door scaled 1.15x
    roof rotated -35 degrees, window rotated 5 degrees
    leaves sheared by 25 degrees, wall sheared by -15 degrees
    window moved down and right, tree moved up and left
    5x4 brick wall

9)  roof scaled 0.75x, tree scaled 0.3x
    door scaled 1.3x
    roof rotated -45 degrees, window rotated 90 degrees
    leaves sheared by 20 degrees, wall sheared by -20 degrees
    window moved up and right, tree moved up and right
    5x3 brick wall

Question 2:

Note that triangles will be drawn on top of palette in case of overlap. While not stated in the assignment as a requiremnt, the gravity for vertex
selection is multiplied as the view is scaled.
