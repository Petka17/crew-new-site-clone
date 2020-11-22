module SkillsPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page


type Model
    = Model
        { navKey : Nav.Key
        }


type Msg
    = ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        ButtonClicked ->
            ( Model model, Nav.pushUrl model.navKey (Page.toString Page.Final) )


view : Model -> List (Element Msg)
view model =
    [ paragraph
        [ Font.color purple
        , Font.size 28
        , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
        ]
        [ text "Hi! Please, tell us about your top 10 skills that you're best at. Most\u{00A0}important information about you!" ]
    , form model
    ]


form : Model -> Element Msg
form model =
    column [ spacingXY 0 20, Font.light ]
        [ paragraph [ Font.size 16 ]
            [ text "* You must enter at least 3 skills! But profiles that have entered 10 skills will be proceeded much quicker! " ]
        , el [ width fill ] <|
            formFields model
        , paragraph [ Font.size 15 ]
            [ text "Please, note that the more details you add about your skillselt the bigger chance you will be contacted with jobs and jobs that are very relavant to your skillset!" ]
        , Input.button
            [ paddingXY 32 15
            , centerX
            , Font.size 13
            , Background.color lightGrey
            , Border.width 1
            , Border.color grey
            ]
            { label = text "Done!"
            , onPress = Just ButtonClicked
            }
        ]


formFields : Model -> Element Msg
formFields (Model model) =
    column []
        []
