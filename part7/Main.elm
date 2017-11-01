module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, classList, href, src, target, type_, width)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode exposing (Decoder, Value)
import Json.Decode.Pipeline as Pipeline exposing (decode, optional, required)


{--Model
The `initialModel` function initializes our Model. This function is called in `init` and outputs a Model
--}


initialModel : String -> Model
initialModel url =
    { errorMessage = ""
    , portfolio =
        { categories = []
        , items = []
        }
    , apiUrl = url
    }


type alias Model =
    { errorMessage : String
    , portfolio : Portfolio
    , apiUrl : String
    }


type alias Portfolio =
    { categories : List Category
    , items : List Item
    }


type alias Category =
    { id : Int, label : String }


type alias Item =
    { id : Int
    , title : String
    , categoryId : Int
    , imageUrl : String
    , linkUrl : String
    , description : String
    , overlayColor : String
    }



{--View
The function `view` renders an Html element using our application model.
Note that the type signature is Model -> Html Msg. This means that this function transforms an argument
of Model into an Html element would produce messages tagged with Msg.

We will see this when we introduce some interaction.
--}


view : Model -> Html Msg
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



{--Update--
The `update` function will be called by Html.program each time a message is received.
This update function responds to messages (Msg), updating the model and returning commands as needed.
--}


type Msg
    = ApiResponse (Result Http.Error Portfolio)
    | None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ApiResponse response ->
            case response of
                Ok response ->
                    let
                        updatedModel =
                            { model | portfolio = response }
                    in
                    ( updatedModel, Cmd.none )

                Err error ->
                    let
                        errorMessage =
                            "An error occurred: " ++ toString error
                    in
                    ( { model | errorMessage = errorMessage }, Cmd.none )

        None ->
            ( model, Cmd.none )



-- Http


getPortfolio : String -> Cmd Msg
getPortfolio url =
    Http.send ApiResponse (Http.get url portfolioDecoder)



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



{--Subscriptions
In Elm, using subscriptions is how your application can listen for external input. Some examples are:
 - Keyboard events
 - Mouse movements
 - Browser locations changes
 - Websocket events

In this application, we don't have a need for any active subscriptions so we add in Sub.none
--}


subscriptions =
    \_ -> Sub.none



{--Program setup and initialization--}
{--
The `main` function is the entry point for our app which means it's the first thing that is run
--}


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init "http://www.mocky.io/v2/59f8cfa92d0000891dad41ed"
        , subscriptions = subscriptions
        }



{--The `init` function is run by `main` upon application startup and allows us to set
our app's initial state as well as scheduling any commands we'd like to run after the app starts
up. For now, we don't need to run any commands so we'll use Cmd.none here.
--}


init : String -> ( Model, Cmd Msg )
init url =
    ( initialModel url, getPortfolio url )
