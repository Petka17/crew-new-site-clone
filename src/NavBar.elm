module NavBar exposing (navBar)

import Colors exposing (..)
import Common exposing (logo)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


navBar : Element msg
navBar =
    row
        [ width fill
        , height <| px 100
        , paddingXY 60 10
        , Font.size 16
        , Font.color white
        , Background.color purple
        ]
        [ el [ alignLeft ] logo
        , el [ alignRight ] <|
            row [ spacing 20 ]
                [ link [] { label = text "Home", url = "https://crewnew.com" }
                , bar
                , link [] { label = text "About Us", url = "https://crewnew.com/about" }
                , bar
                , link [] { label = text "Contact", url = "https://crewnew.com/contact" }
                ]
        ]


bar : Element msg
bar =
    el
        [ height fill
        , Border.color white
        , Border.widthEach { top = 0, right = 3, bottom = 0, left = 0 }
        ]
        none
