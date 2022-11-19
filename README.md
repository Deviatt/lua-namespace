# Curvy namespaces (C++ Like)
### Example usage (Please don't do it):
```lua
local namespace = require "namespace"

namespace("pop")
	function print123()
		print(123)
	end
namespace()

print(pop.g) -- nil

namespace("pop")
	namespace("g")
		p = 10
		print123() -- 123
	namespace()
	print123() -- 123
namespace()

print(pop.g.print) -- Output builtin function, Here's the catch, I'm too lazy to look for an solution (maybe there is no solutions).
```
#### "Getting rid" of local garbage
```lua
local namespace = require "namespace"

namespace("io")
	function _G.fwrite(x) write(x) end
namespace()

fwrite(512)
```

### Why is this needed?
#### A: i don't know :D
