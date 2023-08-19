> Whether to remove a bullet when it crosses the screen or reuse 
it depends on the specific requirements and design of your game. 
Let's explore the advantages and disadvantages of both approaches:

## Removing Bullets:

### Advantages:

+ Simplicity: Removing bullets once they cross the screen is straightforward to implement.

+ Less Memory Usage: 
Releasing memory by removing bullets might be beneficial for performance, especially on resource-constrained platforms.

+ Predictable Behavior:
 Bullets won't accumulate indefinitely, avoiding potential memory issues over time.

### Disadvantages:

+ Resource Overhead: 
If bullets are frequently created and destroyed, this can cause memory allocation and deallocation overhead, potentially impacting performance.

+ Flickering: 
Rapidly appearing and disappearing bullets can cause flickering effects, which might not look visually pleasing.

## Reusing Bullets:

### Advantages:

+ Efficient Memory Usage:  Reusing bullets can reduce memory allocation and deallocation overhead, leading to better performance, especially in situations where bullets are frequently fired.

+ Consistent Memory Footprint: The memory footprint remains relatively constant, avoiding potential spikes caused by frequent memory allocation.

### Disadvantages:

+ Complexity:
 Implementing bullet reuse requires more complex logic to manage the state of bullets and their availability.

+ Predicting Travel Distance: Reused bullets might have leftover effects from their previous use, like animation states or particle effects, which could be challenging to reset. 

## Conclusion :

Repeatedly adding and removing elements from the table can cause
memory fragmentation over time, especially if the table is resized
frequently. This might not be an issue for relatively small-scale games
or if the rate of firing and removal is relatively slow.
However, if you have a high rate of bullet firing and removal,
it could lead to performance problems due to frequent memory allocation
and deallocation.
