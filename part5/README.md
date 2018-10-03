
Back to [Part 4](../part4/README.md)

# Introduction to Elm (Part 5)

>Before getting started with this part, be sure to `cd` into the directory `part5` in your project and open the `Main.elm` file

In this part, we'll use the `Http` library to send a request to the API and create the code necessary to receive that
message by modifying the `update` function to use a `case` expression to route our updates based on the `Msg` that was
sent.

>Messages can be sent by user input (onClick etc.), as the result of a command (`Cmd`) or as the result of a subscription (`Sub`)  

So now we know that we want to route messages that come back from the API to `ApiResponse`, so how do we go about doing that?

The first step is to change the `update` function so that it uses a `case` expression, here's a quick example of using
`case` to handle a `Maybe`:

```elm
case maybe of
  Just value -> value
  Nothing -> []
```

Let's modify our `update` function as follows:

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ApiResponse response ->
            ( model, Cmd.none )

        None ->
            ( model, Cmd.none )
```

For now, both of our messages cause the same effect to happen (nothing!). Let's modify the `ApiResponse` case so that it
receives the `response` from the API.

```elm
        ApiResponse response ->
            case response of
                Ok portfolio ->
                    let
                        updatedModel =
                            { model | portfolio = portfolio }
                    in
                    ( updatedModel, Cmd.none )

                Err error ->
                    let
                        updatedModel =
                            { model | errorMessage = "An error occurred while attempted to fetch your portfolio" }
                    in
                    ( updatedModel, Cmd.none )
```

So, we're now updating the `Model` if we get an `Ok response` as the result from `Http.send` if we get an `Err error` however
we'll update the `errorMessage` field of the `Model` (we still need to add this) with that message.

Next, let's add two new fields to our `Model`, the first is an `errorMessage` and the second is an `apiUrl` that 
we'll use for our request:

```elm
type alias Model =
    { errorMessage : String
    , portfolio : Portfolio
    , apiUrl : String
    }
```

Since, we've updated our `Model`, we'll need to update our `initialModel` function as well. We're going to make a few
key updates here:

Change `initialModel` from

```elm
initialModel : Model
initialModel =
    { portfolio = { categories = [], items = [] } }
```

to

```elm
initialModel : String -> Model
initialModel url =
    { errorMessage = ""
    , portfolio =
        { categories = []
        , items = []
        }
    , apiUrl = url
    }
```

Here's what we've done here:

- Changed the function signature and definition for `initialModel` to except a `String` (`url`) as it's single argument:

  ```elm
  initialModel : String -> Model
  initialModel url =
  ```
- We're setting `apiUrl` based on the `url` passed into `initialModel`

Next, let's add a new section above the `main` function:

```elm
-- Http


getPortfolio : String -> Cmd Msg
getPortfolio url =
    Http.send ApiResponse (Http.get url portfolioDecoder)
```

This function takes in a `String` for the API URL and returns a command `Cmd Msg`.

We'll use this in the `init` function to schedule the command to call out to the API.

Let's do this now as well as passing in the API URL to `initialModel` and scheduling our
command to call out to the API:

```elm
init : String -> ( Model, Cmd Msg )
init url =
    ( initialModel url, getPortfolio url )
```

We also need to update the call to `init = init` in the `main` function:

```elm
main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init "https://www.mocky.io/v2/59f8cfa92d0000891dad41ed"
        , subscriptions = subscriptions
        }
```

Once `init` is updated, we need to add decoders to our file to translate the JSON object returned by
the API into our `Portfolio` type which holds are `List Category` and `List Item`.

```elm
-- JSON Decoding


portfolioDecoder : Decoder Portfolio
portfolioDecoder =
    decode Portfolio
        |> required "categories" (Decode.list categoryDecoder)
        |> required "items" (Decode.list itemDecoder)


categoryDecoder : Decoder Category
categoryDecoder =
    decode Category
        |> required "id" Decode.int
        |> required "label" Decode.string


itemDecoder : Decoder Item
itemDecoder =
    decode Item
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "categoryId" Decode.int
        |> required "imageUrl" Decode.string
        |> required "linkUrl" Decode.string
        |> required "description" Decode.string
        |> required "overlayColor" Decode.string



-- Helpers


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
```

We'll discuss decoders more in the next section, but for, now let's run:

`nom start`

If things are working properly, we we'll see a massive wall of text with the data returned from the API

This is where that little trick in `text (toString model)` in the `view` function becomes less valuable
and the Elm debugger comes in handy.

In this part, we've added the `--debug` flag to the Elm compile (`npm start` is running this automatically), 
which will compile the app with debug mode enabled. If this worked, you should see a small black UI at the bottom, 
right-hand side of your screen:

![Elm Debugger](static/images/elm-debugger.png)

You can click "Explore History" to view details about your app as it runs:

![Elm Debugger](static/images/elm-debugger-expanded.png)

Here we can see that our `update` function ran once and routed to the message `ApiResponse Ok ...` and we can see that 
the `portfolio` field in our `Model` populated with lists of `Category` and `Item` successfully. 
 
>One shortcoming of the Elm debugger is that it does not show the entire `Msg` passed in. We believe
this will be addressed in the next release of the debugger but are not certain.

#### Recap

In this part, we accomplished a lot. We added code to wire up our API request and are now successfully 
handling the response.

In the next section, we'll explain JSON decoders and how they snap together like LEGOs to transform
a string of JSON into concrete Elm types.

Go to [Part 6](../part6/README.md)