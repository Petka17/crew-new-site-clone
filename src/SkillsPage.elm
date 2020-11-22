module SkillsPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Page


type Model
    = Model
        { navKey : Nav.Key
        , skills : List Skill
        }


type alias Skill =
    { name : String
    , level : String
    , experience : String
    , comments : String
    }


type Msg
    = UpdatedComment Int String
    | ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        , skills = List.repeat 10 initSkill
        }


initSkill : Skill
initSkill =
    { name = ""
    , level = "6 - Midlevel"
    , experience = "<1 year"
    , comments = ""
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UpdatedComment selectedIndex comments ->
            let
                updateComment index skill =
                    if index == selectedIndex then
                        { skill | comments = comments }

                    else
                        skill

                skills =
                    List.indexedMap updateComment model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

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
            skillsTable model
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


skillsTable : Model -> Element Msg
skillsTable (Model { skills }) =
    column [ width fill, spacing 20 ] <|
        List.append [ tableHeader ] <|
            List.indexedMap tableRow skills


tableHeader : Element msg
tableHeader =
    row [ width fill, Font.bold, Font.size 15 ]
        [ el [ countWidth ] <| text "#"
        , el [ skillWidth ] <| text "Skill"
        , el [ levelWidth ] <| text "Level"
        , el [ experienceWidth ] <| text "Experience"
        , el [ commentsWidth ] <| text "Comments"
        ]


tableRow : Int -> Skill -> Element Msg
tableRow index skill =
    row [ width fill, Font.size 16 ]
        [ el [ countWidth ] <| text (indexToString index)
        , el [ skillWidth ] <|
            text skill.name
        , el [ levelWidth ] <|
            text skill.level
        , el [ experienceWidth ] <|
            text "Experience"
        , el [ commentsWidth ] <|
            Input.multiline [ height (px 60) ]
                { label = Input.labelHidden ""
                , placeholder = fieldPlaceholder "Eg. 'since 2006 my main language' or 'Have done 3 bigger projects' or 'I have worked with almost all major APIs' etc."
                , text = skill.comments
                , onChange = UpdatedComment index
                , spellcheck = False
                }
        ]


indexToString : Int -> String
indexToString index =
    let
        strIndex =
            String.fromInt (index + 1) ++ "."
    in
    if index < 3 then
        strIndex ++ "*"

    else
        strIndex


countWidth : Attribute msg
countWidth =
    width (fillPortion 1)


skillWidth : Attribute msg
skillWidth =
    width (fillPortion 5)


levelWidth : Attribute msg
levelWidth =
    width (fillPortion 2)


experienceWidth : Attribute msg
experienceWidth =
    width (fillPortion 3)


commentsWidth : Attribute msg
commentsWidth =
    width (fillPortion 12)
