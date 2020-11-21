module Common exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border


logo : Element msg
logo =
    link []
        { url = "https://crewnew.com"
        , label =
            image []
                { src = "https://crewnew.com/_nuxt/img/f14217b.png"
                , description = ""
                }
        }


checkboxIcon : Bool -> Element msg
checkboxIcon isChecked =
    el
        [ width <| px 20
        , height <| px 20
        , centerY
        , padding 2
        , Border.rounded 3
        , Border.width 1
        , Border.color <| rgb255 0xC0 0xC0 0xC0
        ]
    <|
        el
            [ width fill
            , height fill
            , Background.color <|
                if isChecked then
                    rgb255 114 159 207

                else
                    rgb255 0xFF 0xFF 0xFF
            ]
        <|
            none
