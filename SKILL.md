---
name: richcopy
description: Copy the last response as rich text to clipboard for pasting into Word, Teams, Outlook, etc.
---

Copy a response to the Windows clipboard as rich text so it pastes into Word, Teams, and Outlook with proper formatting (bold, headers, lists, tables, code blocks — no raw markdown).

## Which response to copy

Interpret $ARGUMENTS to decide what to copy:

- **No arguments** (`/richcopy`): Copy your most recent response (immediately before this command).
- **A number** (`/richcopy 3`): Copy the Nth-most-recent assistant response, counting back from the latest. `/richcopy 1` = latest, `/richcopy 3` = third-most-recent.
- **`pick`** (`/richcopy pick`): Present an interactive chooser. Show the 4 most recent assistant responses as options using AskUserQuestion, with a one-line summary of each (first ~60 characters). Include an "Older..." option. If the user picks "Older...", show the next 4. Repeat until they choose one.
- **Descriptive text** (`/richcopy just the table`): Copy only the portion of the most recent response matching that description.

## Steps

1. Identify the target response using the rules above.

2. Write the raw markdown text to `$TEMP/richcopy.md` using the Write tool. Do NOT convert to HTML yourself — a Perl script handles that.

3. Run the conversion and clipboard copy:
   ```bash
   perl ~/.claude/skills/richcopy/md2html.pl "$TEMP/richcopy.md" "$TEMP/richcopy.html" && powershell.exe -STA -NoProfile -ExecutionPolicy Bypass -File "$(cygpath -w ~/.claude/skills/richcopy/Set-HtmlClipboard.ps1)" -Path "$(cygpath -w "$TEMP/richcopy.html")"
   ```

4. Tell the user the content has been copied as rich text.
