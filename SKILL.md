---
name: memory
description: >
  A skill for storing, retrieving, and deleting key-value memories on local disk.
  Use this skill when the user asks you to remember something, recall something
  previously stored, or forget/delete a stored memory. Memories persist across sessions.
---

# Memory Skill

This skill provides persistent local key-value storage using the `memory.sh` script
in this skill's directory.

## Available Commands

Run the script using `bash` with the full path to `memory.sh` in this skill directory.

### Store a memory

```bash
bash <skill-dir>/memory.sh storeMemory <key> <value>
```

- **key**: A short identifier (no slashes or `..`). Use kebab-case (e.g. `favorite-language`, `project-name`).
- **value**: The string value to store. Wrap in quotes if it contains spaces.

### Retrieve a memory

```bash
bash <skill-dir>/memory.sh getMemory <key>
```

Returns the stored value. Exits with an error if the key doesn't exist.

### Delete a memory

```bash
bash <skill-dir>/memory.sh deleteMemory <key>
```

Removes the key-value pair. Exits with an error if the key doesn't exist.

### List all memories

```bash
bash <skill-dir>/memory.sh listMemories
```

Lists all stored memory keys, one per line. Prints "No memories stored." if none exist.

## Guidelines

- When the user says "remember that X is Y", call `storeMemory` with an appropriate key and value.
- When the user asks "what is X?" or "do you remember X?", call `getMemory` with the relevant key.
- When the user says "forget X" or "delete X", call `deleteMemory` with the relevant key.
- When the user asks "what do you remember?" or "list memories", call `listMemories`.
- Keys should be short, descriptive, and use kebab-case.
- Memories are stored as individual files in the `memories/` subdirectory of this skill.
