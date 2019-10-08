# Writing Vale rules

This is not a comprehensive list of parameters for vale styles configuration.

Should organise all parameters by type of rule they apply to.

```yaml
extends: substitution|existence|conditional|capitalization
message: Do something # Helpful message about fixing the error/warning
link: 'https://contribute.jquery.org/style-guide/prose/#grammar'
scope: sentence|heading
ignorecase: true|false # Makes all matches case-insensitive.
level: error|warning
match: $title, $sentence, $lower, $upper, or a pattern.
style: AP or Chicago; only applies when match is set to $title.
nonword: true|false  #??
first: \b([A-Z]{3,5})\b # if this is true
code: true|false
raw: A list of tokens to be concatenated into a pattern.
second: (?:\b[A-Z][a-z]+[']? )+\(([A-Z]{3,5})\) # then this must be true
exceptions: # unless it's one of these. An array of strings to be ignored.
  - ABC
swap: # all the wrong ways: the correct way
  '\beg\b': e.g.,
  user testing: "'usability testing'"
tokens: # the existence of these tokens triggers the error/warning
  - '(?:[^,]+,){1,}\s\w+\sand'
```
