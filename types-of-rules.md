# Types of style rules

An attempt at listing all the types of rules supported by Vale - with examples.

## Substitution: recommended alternative

Prefer X instead of Y.

```yaml
extends: substitution
message: Prefer %s over '%s.'
level: warning
ignorecase: true
swap:
  Y: "'X'"
  user testing: "'usability testing'"
  'e\.? ?g\.?(?:[^,]|$)': for example,
```
Forbidden words example:

```yaml
extends: substitution
message: '%s'
level: warning
ignorecase: true
swap:
  (?:commit|pledge): "Be more specific — we’re either doing something or we’re not."
  advancing: "Avoid using 'advancing.'"
  agenda: "Avoid using 'agenda' (unless you’re talking about a meeting)."
```

## Existence: If it exists, remove it

Avoid using X because reasons.

```yaml
extends: existence
message: 'Avoid hyphens in ages unless it clarifies the text.'
level: warning
tokens:
  - '\d{1,3}-year-old'
```

## Conditional:

If `first` is true, then `second` must be true. Unless it's one of the items in `exceptions`.

```yaml
extends: conditional
message: "'%s' has no definition"
level: warning
first: \b([A-Z]{3,5})\b
second: (?:\b[A-Z][a-z]+[']? )+\(([A-Z]{3,5})\)
exceptions:
  - ABC
```

## Capitalisation

`capitalization` checks that the text in the specified scope matches the case of match. There are a few pre-defined variables that can be passed as matches:

`$title`: "The Quick Brown Fox Jumps Over the Lazy Dog."
`$sentence`: "The quick brown fox jumps over the lazy dog."
`$lower`: "the quick brown fox jumps over the lazy dog."
`$upper`: "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG."

```yaml
extends: capitalization
message: "'%s' should be in sentence case"
link: https://github.com/cockroachdb/docs/blob/master/STYLE.md#capitalization-and-punctuation
level: warning
scope: heading
match: $sentence
```

## Spelling

```yaml
extends: spelling
message: "Did you really mean '%s'?"
level: error
ignore:
  - CockroachDB/vocab.txt # list of the words probably not in dictionary
```

Customisation example:

```yaml
extends: spelling
message: "Did you really mean '%s'?"
level: error
# This disables the built-in filters. If you omit this key or set it to false,
# custom filters (see below) are added on top of the built-in ones.
#
# By default, Vale includes filters for acronyms, abbreviations, and numbers.
custom: true
# A "filter" is a regular expression specifying words to ignore during spell
# checking.
filters:
  # Ignore all words starting with 'py' -- e.g., 'PyYAML'.
  - '[pP]y.*\b'
# Vale will search for these files under $StylesPath -- so, vocab.txt is assumed
# to be $StylesPath/vocab.txt.
ignore:
  - vocab.txt
```

## Readability

```yaml
extends: readability
message: "Grade level (%s) too high!"
level: warning
grade: 8
metrics:
  - Flesch-Kincaid
  - Gunning Fog
```

## Consistency

`consistency` will ensure that a key and its value (e.g., "advisor" and "adviser") don't both occur in its scope.

```yaml
extends: consistency
message: "Inconsistent spelling of '%s'"
level: error
scope: text
ignorecase: true
nonword: false
# We only want one of these to appear.
either:
  advisor: adviser
  centre: center
```

## Repetition

```yaml
extends: repetition
message: "'%s' is repeated!"
level: error
alpha: true # Limits all matches to alphanumeric tokens.
tokens:
  - '[^\s]+'
```

## Occurrence

```yaml
extends: occurrence
message: "More than 3 commas!"
level: error
# Here, we're counting the number of times a comma appears in a sentence.
# If it occurs more than 3 times, we'll flag it.
scope: sentence
ignorecase: false
max: 3 # The maximum amount of times token may appear in a given scope.
min: 1 # The minimum amount of times token may appear in a given scope.
token: ','
```
