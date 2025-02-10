
```r
# Based on: https://ellmer.tidyverse.org/
# ellmer makes it easy to use large language models (LLM) from R.
# a first-try of ellmer

# Using ellmer
library(ellmer)
# usethis::edit_r_environ()

# R6-object
chat <- chat_openai(
    model = "gpt-4o-mini",
    system_prompt = "You are a friendly but terse assistant."
)

chat$chat("Hei, hvordan går det?")

# Chat with chatGPT
live_console(chat)
```

## Getting startet: https://ellmer.tidyverse.org/articles/ellmer.html

## Prompt: questions or a request
```{r}
chat$chat("Who created R?", echo = FALSE)

# https://ellmer.tidyverse.org/articles/prompt-design.html

question <- "Hvordan kan jeg regne ut snitt og median av flere variabler i datasettet df?"

chat$chat( question)

``` 

Resultatet fra chat:

```{r}
# Anta at df er datasettet ditt

# Regn ut snitt
snitt <- colMeans(df, na.rm = TRUE)

# Regn ut median
medianer <- apply(df, 2, median, na.rm = TRUE)

# Skriv ut resultatene
print(snitt)
print(medianer)
```

# Sørg for å justere `na.rm = TRUE` for å håndtere eventuelle NA-verdier.

chat$chat( "kan du lage et enkelt datasett, slik at jeg kan teste?")



# Vis datasettet
# print(df)
# Dette datasettet `df` har tre variabler (A, B og C) med fem observasjoner hver. Du kan bruke dette datasettet til å teste ut snitt og median.

chat <- chat_openai(
    model = "gpt-4o-mini",
    system_prompt = 
    "You are an expert R programmer who prefers the data.table.
    Just give me the code. I don't want any explanation or sample data.
    Dont return the answar with ```r ```, but with # (out commeting) 
    "
    )



chat$chat("
  I want to 
  Can you give the code in base R. Use the base pip |> and always use double quotes for strings")



```{r}

# Example data frame
df <- data.frame(a = c(1, 2, NA, 4), b = c(5, NA, 7, 8), c = c(NA, NA, 3, 6))

# Calculate mean and median for columns "a", "b", "c"
result <- lapply(df[, c("a", "b", "c"), drop = FALSE], function(x) {
  list(mean = mean(x, na.rm = TRUE), median = median(x, na.rm = TRUE))
  }) |>
   as.data.frame()

result
```

