---[[
---	This here compilation unit contains the State class.
---	The class itself is meant to be the root of all the other states that are going to be
--- 	utilising within the software hence, this here base class acts much akin to Java's 
---	abstract classes.
---	
---	The class defined all the routines which a specialised state ought to override, though 
---	no default behaviour is provided for any of these methods.
--- 
---	Author: Andrei-Paul Ionescu.
---]]

State = class{}

function State:init() end
function State:enter() end
function State:exit() end
function State:update(deltaTime) end
function State:render() end
