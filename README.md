# api-blueprint-compiler

A code skimmer that will scan your source code and scrape out api blueprint documentation.

## How it works
1) Above any route that you would want to document with API blueprint documentation, simply put:
```
/*
@StartBluePrint
[your blueprint syntax goes here]
@EndBluePrint
*/
```
2) Anything that is between the `@StartBluePrint` and `@EndBluePrint` lines will be aggregated and outputed into your file.

## Setup
Minimal setup is required, but you do need to do a little legwork to get it rolling. We recommend creating a `.sh` file
that can be called as part of your pre-commit hook to allow for constant updating of your `apiary.apib` file. An example file
would look something like this...

```
#!/bin/bash

# DEFINE OUTPUT FILE
OUTPUT="apiary.apib"

# SETUP OUTPUT FILE WITH DEFAULT CONTENT
cat ./build/apiary-default.apib > $OUTPUT
echo '' >> $OUTPUT

# SEARCH, PARSE & COMPILE INLINE DOCUMENTATION
FILES=(
  "./*.php"
)
RESET=0 #ENSURE RESET IS 0, BECAUSE WE JUST WANT TO APPEND THE FILE

# COMPILE
for SEARCH in "${FILES[@]}"
do
  sh ./vendor/teamgantt/api-blueprint-compiler/src/parse.sh -s "$SEARCH" -r "$RESET" -o "$OUTPUT"
done
```

In our example, we have a file in the `/build` directory that contains header information for our apiary file. Infomation such as
`FORMAT`, `HOST`, and general blueprint information is stored there.

Then simply update the `FILES` array with location of the files you'd like to scrape.

## Using the commit hook
If you plan to use a commit hook (highly recommended), we recommend updating your `pre-commit` hook to
1) Call the file you created above.
2) Followed by `git add apiary.apib`

An example

```
# Generate API Blueprint
sh ./build/generate_api_blueprint.sh
git add apiary.apib
```
