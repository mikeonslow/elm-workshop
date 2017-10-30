module Main exposing (..)

import Html exposing (Html, div, h1, header, text, img)
import Html.Attributes exposing (class, src, width)


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , update = update
        , init = init
        , subscriptions = subscriptions
        }



init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    {}


type alias Model =
    {}


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ img [ src "static/images/elm-detroit.png", class "logo" ] []
        , header [] [ h1 [] [  text "Introduction to Elm" ] ]
        , div [ class "intro-message" ] [ text "You are good to go!" ]
        ]


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions =
    \_ -> Sub.none