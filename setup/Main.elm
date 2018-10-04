module Main exposing (Model, Msg(..), main, update, view)

{-| THIS FILE IS NOT PART OF THE COURSE! It is only to verify that you
have everything set up properly.
-}

import Browser
import Html exposing (Html, div, h1, header, img, text)
import Html.Attributes exposing (class, src)


type alias Model =
    {}


type Msg
    = None


init : Model
init =
    {}


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ img [ src "static/images/elm-detroit.png", class "logo" ] []
        , header [] [ h1 [] [ text "Introduction to Elm" ] ]
        , div [ class "intro-message" ] [ text "You are good to go." ]
        ]


update : Msg -> Model -> Model
update msg model =
    model


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
