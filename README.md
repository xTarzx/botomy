# BOTomy

.
-- Scene
---- Gameplay
---- Characters
------- Script



```
i have an idea for a game where you write the brain for a character
, basically creating the AI that controls a character. it will be written in lua using love2d
the characters and gameplay itself are up to the corresponding "level" or "scene".
each level should expose a correspondent api, this being a function definition, where the arguments are specified, these being for example the character position or if it holding somehting, raycasat information to act as vision, anything that the player needs to know,this is dependant on the type of level. the scene should also expose the expected return format, could be an object, a string, a single number, anything really, again depends on the type of level.
as a player, we create lua files that we can load into a scene and attach to a character. the file is expected to return an object containing the function as specified by the scene. that is the only requirement, the object can also be used to hold state if the player so wishes.
```
