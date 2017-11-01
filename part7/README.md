
Back to [Part 6](../part6/README.md)

# Introduction to Elm (Part 7)

In this section, we'll be updating our `view` function to display the data returned by the API in a meaningful
way. 

Let's start by removing the code we currently have in `view` function and replacing it with the following code:

```
view model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ div
                [ class "col"
                ]
                [ br [] [] ]
            ]
        , div [ class "row" ]
            [ div
                [ class "col"
                ]
                [ h1 [] [ text "Elmfolio" ] ]
            ]
        ]
```


#### Recap

In this section, updated our `view` function to display the data returned by the API in a meaningful
way. 

In the next section we'll wire up our final messages and have a fully funcional Elm web app!

Go to [Part 8](../part8/README.md)