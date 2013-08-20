bowling
=======

Polyglot bowling scoring solutions

At a minimum write a bowling score calculator that takes a list of rolls and returns a score. Read the [Wikipedia article on bowling](http://en.wikipedia.org/wiki/Ten-pin_bowling#Scoring) if your understanding of the game isn't at Lebowskian levels. Your scorer will need to be aware of frames, spares, and strikes.

Your calculator should take a list of rolls. It should return the current score.

For extra credit: specify if the game is complete (or not),  and present any special messages (e.g. "spare", "strike", "gutterball", "turkey").  

Here's are some examples in Erlang:

````
 score([]) -> {0, incomplete, ""}
 
 score([5]) -> {5, incomplete, ""}
 
 score([10]) -> {10, incomplete, "Strike"}
 
 score([7, 3]) -> {10, incomplete, "Spare"}
 
 score([10,3,6]) -> {28, incomplete, ""}
 
 score([7,3,4,2]) -> {incomplete, 20, ""} 
 
 score([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]) -> {complete, 0, "Game over"}

 score([10,10,10,10,10,10,10,10,10,10,10,10]) -> {complete, 300, "Perfect game!"}

````

For extra fun:
* You could implement a server that takes one roll at a time, presents a score, and returns messages (e.g. "spare", "strike", "double", "turkey") 
* You could implement a server that lets multiple players play: ```` Game = bowling:start(["The Dude", "Walter", "Donny"]). ````

Contribute your solution by adding a folder name {your twitter handle}+{your language} such as "bryan_hunter+erlang".

Enjoy.
