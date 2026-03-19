# Memory Skill

A simple Copilot skill that provides persistent key-value storage on local disk. Memories are saved as individual files and persist across sessions.

## Commands

| Command | Usage | Description |
|---------|-------|-------------|
| **storeMemory** | `memory.sh storeMemory <key> <value>` | Save a value under a key |
| **getMemory** | `memory.sh getMemory <key>` | Retrieve a stored value |
| **deleteMemory** | `memory.sh deleteMemory <key>` | Remove a stored memory |
| **listMemories** | `memory.sh listMemories` | List all stored memory keys |

## Key Rules

- Keys must be non-empty and cannot contain `/` or `..`
- Use kebab-case for keys (e.g. `favorite-language`, `project-name`)
- Wrap values in quotes if they contain spaces

## How It Works

Memories are stored as plain text files in the `memories/` directory. Each key maps to a single file whose contents are the stored value.

## Examples

```bash
# Store a memory
bash memory.sh storeMemory favorite-color blue

# Retrieve it
bash memory.sh getMemory favorite-color
# → blue

# List all memories
bash memory.sh listMemories
# → favorite-color

# Delete it
bash memory.sh deleteMemory favorite-color
```
