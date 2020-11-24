module SkillsPage exposing (Model, Msg, init, update, view)

import Browser.Navigation as Nav
import Colors exposing (..)
import Common exposing (fieldPlaceholder)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Option exposing (Option)
import Page
import Select
import SelectWithFilter


type Model
    = Model
        { navKey : Nav.Key
        , skills : List Skill
        }


type alias Skill =
    { name : SelectWithFilter.State
    , level : Maybe Option
    , experience : Maybe Option
    , comments : String
    }


type Msg
    = UpdatedSkill Int SelectWithFilter.Msg
    | UpdatedLevel Int (Maybe Option)
    | UpdatedExperience Int (Maybe Option)
    | UpdatedComment Int String
    | ButtonClicked


init : Nav.Key -> Model
init navKey =
    Model
        { navKey = navKey
        , skills = List.repeat 10 initSkill
        }


initSkill : Skill
initSkill =
    { name = SelectWithFilter.init Nothing "Select Skill"
    , level = takeAt 5 levelOptions
    , experience = List.head experienceOptions
    , comments = ""
    }


takeAt : Int -> List a -> Maybe a
takeAt index list =
    list |> List.take (index + 1) |> List.drop index |> List.head


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        UpdatedSkill selectedIndex subMsg ->
            let
                updateSkillName index skill =
                    if index == selectedIndex then
                        { skill | name = SelectWithFilter.update subMsg skill.name }

                    else
                        skill

                skills =
                    List.indexedMap updateSkillName model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        UpdatedLevel selectedIndex level ->
            let
                updateLevel index skill =
                    if index == selectedIndex then
                        { skill | level = level }

                    else
                        skill

                skills =
                    List.indexedMap updateLevel model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

        UpdatedExperience selectedIndex experience ->
            let
                updateExperience index skill =
                    if index == selectedIndex then
                        { skill | experience = experience }

                    else
                        skill

                skills =
                    List.indexedMap updateExperience model.skills
            in
            ( Model { model | skills = skills }, Cmd.none )

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
        tableHeader
            :: List.indexedMap tableRow skills


tableHeader : Element msg
tableHeader =
    row [ width fill, Font.bold, Font.size 15, spacing 5 ]
        [ el [ countWidth ] <| text "#"
        , el [ skillWidth ] <| text "Skill"
        , el [ levelWidth ] <| text "Level"
        , el [ experienceWidth ] <| text "Experience"
        , el [ commentsWidth ] <| text "Comments"
        ]


tableRow : Int -> Skill -> Element Msg
tableRow index skill =
    row [ width fill, Font.size 16, spacing 5 ]
        [ el [ countWidth ] <| text (indexToString index)
        , el [ skillWidth ] <|
            (SelectWithFilter.view [ Font.size 14 ] skillsOptions skill.name
                |> Element.map (UpdatedSkill index)
            )
        , el [ levelWidth ] <|
            Select.view levelOptions skill.level (UpdatedLevel index)
        , el [ experienceWidth ] <|
            Select.view experienceOptions skill.experience (UpdatedExperience index)
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



-- WIDTH


countWidth : Attribute msg
countWidth =
    width (fillPortion 1)


skillWidth : Attribute msg
skillWidth =
    width (fillPortion 6)


levelWidth : Attribute msg
levelWidth =
    width (fillPortion 4)


experienceWidth : Attribute msg
experienceWidth =
    width (fillPortion 3)


commentsWidth : Attribute msg
commentsWidth =
    width (fillPortion 12)



-- OPTIONS


experienceOptions : List Option
experienceOptions =
    [ { id = "0.5", value = "<1 year" }
    , { id = "1", value = "1 year" }
    , { id = "1.5", value = "1,5 years" }
    , { id = "2", value = "2 years" }
    , { id = "3", value = "3 years" }
    , { id = "4", value = "4 years" }
    , { id = "5", value = "5 years" }
    , { id = "7.5", value = "7-8 years" }
    , { id = "9.5", value = "9-10 years" }
    , { id = "13", value = "11-15 years" }
    , { id = "17.5", value = "16-19 years" }
    , { id = "22", value = "20-24 years" }
    , { id = "27", value = "25-29 years" }
    , { id = "31", value = "30+ years" }
    ]


levelOptions : List Option
levelOptions =
    [ { id = "1", value = "1 - Started" }
    , { id = "2", value = "2 - Minimal" }
    , { id = "3", value = "3 - Little" }
    , { id = "4", value = "4 - Junior" }
    , { id = "5", value = "5 - Junior/Mid" }
    , { id = "6", value = "6 - Midlevel" }
    , { id = "7", value = "7 - Mid/Senior" }
    , { id = "8", value = "8 - Senior" }
    , { id = "9", value = "9 - Senior Expert" }
    , { id = "10", value = "10 - Top Expert" }
    ]


skillsOptions : List Option
skillsOptions =
    [ { id = "Google Analytics", value = "Google Analytics" }
    , { id = "Google Tag Manager", value = "Google Tag Manager" }
    , { id = "Data Science", value = "Data Science" }
    , { id = "Search Engine Optimisation (SEO)", value = "Search Engine Optimisation (SEO)" }
    , { id = "PHP", value = "PHP" }
    , { id = "CSS", value = "CSS" }
    , { id = "jQuery", value = "jQuery" }
    , { id = "HTML", value = "HTML" }
    , { id = "MySQL", value = "MySQL" }
    , { id = "Bootstrap", value = "Bootstrap" }
    , { id = "Codeigniter", value = "Codeigniter" }
    , { id = "Web Development", value = "Web Development" }
    , { id = "WordPress", value = "WordPress" }
    , { id = "PSD to HTML", value = "PSD to HTML" }
    , { id = "Data entry", value = "Data entry" }
    , { id = "HTML5", value = "HTML5" }
    , { id = "JavaScript", value = "JavaScript" }
    , { id = "CSS3", value = "CSS3" }
    , { id = "Photoshop", value = "Photoshop" }
    , { id = "Photo Editing / Manipulation", value = "Photo Editing / Manipulation" }
    , { id = "Graphic design", value = "Graphic design" }
    , { id = "Logo design", value = "Logo design" }
    , { id = "Web design", value = "Web design" }
    , { id = "CakePHP", value = "CakePHP" }
    , { id = "Angular.js", value = "Angular.js" }
    , { id = "MongoDB", value = "MongoDB" }
    , { id = "Laravel", value = "Laravel" }
    , { id = "Node.js", value = "Node.js" }
    , { id = "Magento", value = "Magento" }
    , { id = "OpenCart", value = "OpenCart" }
    , { id = "Joomla!", value = "Joomla!" }
    , { id = "Moodle", value = "Moodle" }
    , { id = "Drupal", value = "Drupal" }
    , { id = "SugarCRM", value = "SugarCRM" }
    , { id = "Illustrations", value = "Illustrations" }
    , { id = "Android App Development", value = "Android App Development" }
    , { id = "iOS Development", value = "iOS Development" }
    , { id = "Illustrator", value = "Illustrator" }
    , { id = "Corel Draw", value = "Corel Draw" }
    , { id = "Sketch", value = "Sketch" }
    , { id = "Social media marketing (SMM)", value = "Social media marketing (SMM)" }
    , { id = "Internet Marketing", value = "Internet Marketing" }
    , { id = "Java", value = "Java" }
    , { id = "JSP", value = "JSP" }
    , { id = "JSON", value = "JSON" }
    , { id = "Express", value = "Express" }
    , { id = "Docker", value = "Docker" }
    , { id = "PostgreSQL", value = "PostgreSQL" }
    , { id = "Dojo", value = "Dojo" }
    , { id = "WordPress Plugin", value = "WordPress Plugin" }
    , { id = "HTML &amp; CSS", value = "HTML &amp; CSS" }
    , { id = "Yii", value = "Yii" }
    , { id = "Flyer / Brochure / etc Design", value = "Flyer / Brochure / etc Design" }
    , { id = "MODx", value = "MODx" }
    , { id = "Photography", value = "Photography" }
    , { id = "Video Production", value = "Video Production" }
    , { id = "Video Editing", value = "Video Editing" }
    , { id = "Camera Operator", value = "Camera Operator" }
    , { id = "Adobe Premiere", value = "Adobe Premiere" }
    , { id = "Project Management", value = "Project Management" }
    , { id = "Project Management Soft", value = "Project Management Soft" }
    , { id = "Copywriting", value = "Copywriting" }
    , { id = "Pay Per Click (PPC)", value = "Pay Per Click (PPC)" }
    , { id = "Python", value = "Python" }
    , { id = "KeystoneJS", value = "KeystoneJS" }
    , { id = "Django", value = "Django" }
    , { id = "Chamilo", value = "Chamilo" }
    , { id = "Odoo", value = "Odoo" }
    , { id = "Art direction", value = "Art direction" }
    , { id = "Market / Customer Research", value = "Market / Customer Research" }
    , { id = "Marketing Strategy", value = "Marketing Strategy" }
    , { id = "Business development", value = "Business development" }
    , { id = "Project planning", value = "Project planning" }
    , { id = "SQL", value = "SQL" }
    , { id = "phpMyAdmin", value = "phpMyAdmin" }
    , { id = "Mautic", value = "Mautic" }
    , { id = "Twilio", value = "Twilio" }
    , { id = "Text editing", value = "Text editing" }
    , { id = "SEO Writing", value = "SEO Writing" }
    , { id = "English - Estonian translation", value = "English - Estonian translation" }
    , { id = "xCart", value = "xCart" }
    , { id = "Ethereum", value = "Ethereum" }
    , { id = "HubSpot", value = "HubSpot" }
    , { id = "Sharpspring", value = "Sharpspring" }
    , { id = "Sales", value = "Sales" }
    , { id = "Git", value = "Git" }
    , { id = "Jira", value = "Jira" }
    , { id = "C", value = "C" }
    , { id = "C++", value = "C++" }
    , { id = "Cryptography / Security", value = "Cryptography / Security" }
    , { id = "Open SSL", value = "Open SSL" }
    , { id = "OpenSC", value = "OpenSC" }
    , { id = "Linux development", value = "Linux development" }
    , { id = "PKCS#11", value = "PKCS#11" }
    , { id = "GnuTLS", value = "GnuTLS" }
    , { id = "PGP", value = "PGP" }
    , { id = "GnuPG", value = "GnuPG" }
    , { id = "X.509", value = "X.509" }
    , { id = "Software testing", value = "Software testing" }
    , { id = "ERP / CRM", value = "ERP / CRM" }
    ]
