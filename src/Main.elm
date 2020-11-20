module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html


type alias Flags =
    ()


type alias Model =
    { email : String
    , password : String
    , confirmationPassword : String
    , fullName : String
    , mobileNumber : String
    , whatsAppFlag : Bool
    , linkedInLink : String
    , freelanceUrl : String
    , country : String
    , town : String
    }


type FormField
    = Email String
    | Password String
    | ConfirmationPassword String
    | FullName String
    | MobilePhone String
    | WhatsAppFlag Bool
    | LinkedInLink String
    | FreelancerLink String
    | Country String
    | Town String


type Msg
    = UpdateForm FormField


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { email = ""
      , password = ""
      , confirmationPassword = ""
      , fullName = ""
      , mobileNumber = ""
      , whatsAppFlag = False
      , linkedInLink = ""
      , freelanceUrl = ""
      , country = ""
      , town = ""
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Freelancer Sign Up - CrewNew"
    , body =
        [ layout
            [ Font.family [ Font.typeface "Montserrat", Font.sansSerif ] ]
          <|
            column [ width fill, height fill ]
                [ navBar
                , column [ width fill, height fill, scrollbarY, spacing 40 ]
                    [ mainContent model
                    , footer
                    ]
                ]
        ]
    }


navBar : Element Msg
navBar =
    let
        bar =
            el
                [ height fill
                , Border.color white
                , Border.widthEach { top = 0, right = 3, bottom = 0, left = 0 }
                ]
                none
    in
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
                [ text "Home"
                , bar
                , text "About Us"
                , bar
                , text "Contact"
                ]
        ]


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


mainContent : Model -> Element Msg
mainContent model =
    column
        [ width <| maximum 900 fill
        , paddingXY 20 0
        , centerX
        ]
    <|
        [ paragraph
            [ Font.color purple
            , Font.size 28
            , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
            ]
            [ text "Apply to join the coolest freelancers' & PM's startup!" ]
        , firstStep model
        ]


firstStep : Model -> Element Msg
firstStep model =
    column [ spacingXY 0 20 ]
        [ paragraph
            [ Font.color purple
            , Font.size 16
            ]
            [ text "We're super excited to have you here joining us! We're all great at what we do and hope you're the same! Let's get started and hopefully we'll be all one big family very soon:)" ]
        , paragraph
            [ Font.size 16
            , Font.bold
            , Font.family [ Font.typeface "Gibbs", Font.sansSerif ]
            ]
            [ text "All fields marked with * are required!" ]
        , row [ width fill, Font.family [ Font.typeface "Gibbs", Font.sansSerif ] ]
            [ column [ width (fillPortion 1), spacing 10 ] <| formFields model
            , column [ width (fillPortion 1) ]
                [ image
                    [ centerX, width fill, padding 20 ]
                    { src = "https://crewnew.com/_nuxt/cc9f8459dfcf22cabb5f7f5e1933f36a.svg", description = "" }
                ]
            ]
        ]


formFields : Model -> List (Element Msg)
formFields model =
    [ formField "Email: *" <|
        Input.email []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "@"
            , text = model.email
            , onChange = UpdateForm << Email
            }
    , formField "Passwor x2: *" <|
        column [ width fill ]
            [ Input.newPassword []
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.password
                , onChange = UpdateForm << Password
                }
            , Input.newPassword []
                { label = Input.labelHidden ""
                , placeholder = Nothing
                , show = False
                , text = model.confirmationPassword
                , onChange = UpdateForm << ConfirmationPassword
                }
            ]
    , formField "Name: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Full name"
            , text = model.fullName
            , onChange = UpdateForm << FullName
            }
    , formField "Mobile: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "+ country code"
            , text = model.mobileNumber
            , onChange = UpdateForm << MobilePhone
            }
    , formField "" <|
        Input.checkbox []
            { label = Input.labelRight [] <| text "WhatsApp"
            , checked = model.whatsAppFlag
            , icon = checkboxIcon
            , onChange = UpdateForm << WhatsAppFlag
            }
    , formField "LinkedIN:" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "https://"
            , text = model.linkedInLink
            , onChange = UpdateForm << LinkedInLink
            }
    , formField "Freelance URL:" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Freelance / job site profile"
            , text = model.freelanceUrl
            , onChange = UpdateForm << FreelancerLink
            }
    , formField "Country: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text ""
            , text = model.country
            , onChange = UpdateForm << Country
            }
    , formField "Town: *" <|
        Input.text []
            { label = Input.labelHidden ""
            , placeholder = Just <| Input.placeholder [] <| text "Or village or area..."
            , text = model.town
            , onChange = UpdateForm << Town
            }
    ]


formField : String -> Element Msg -> Element Msg
formField labelText field =
    row [ width fill ]
        [ paragraph
            [ width (fillPortion 1)
            , Font.color <| rgb255 66 55 91
            , Font.size 16
            ]
            [ text labelText ]
        , field
        ]


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


footer : Element msg
footer =
    row
        [ width fill
        , alignBottom
        , Font.color white
        , Font.size 16
        , Background.color purple
        , Border.roundEach { topLeft = 60, topRight = 0, bottomRight = 0, bottomLeft = 0 }
        , paddingEach { top = 60, right = 50, bottom = 20, left = 60 }
        , spacing 30
        ]
        [ column [ alignTop, spacing 30 ]
            [ logo
            , row [ spacing 15 ]
                [ socialLink "/assets/icons/twitter.svg" "https://twitter.com/crewnew_com"
                , socialLink "/assets/icons/linkedin.svg" "https://www.linkedin.com/company/crewnew"
                , socialLink "/assets/icons/facebook.svg" "https://www.facebook.com/crewnewcom"
                , socialLink "/assets/icons/medium.svg" "https://medium.com/crewnew-com"
                ]
            ]
        , row [ alignRight, alignTop, spacing 40 ]
            [ column [ alignRight, alignTop, spacing 15 ]
                [ footerSectionHeader "ABOUT"
                , link [] { label = text "Top 1% talent", url = "https://crewnew.com/about#1%-talent" }
                , link [] { label = text "All skills rated and tested", url = "https://crewnew.com/about#rated-&-tested" }
                , link [] { label = text "Agency culture & tools", url = "https://crewnew.com/about#culture-&-tools" }
                , link [] { label = text "Buyer protection", url = "https://crewnew.com/about#protection" }
                , link [] { label = text "Pricing and offers", url = "https://crewnew.com/about#pricing" }
                , link [] { label = text "Always project managed", url = "https://crewnew.com/about#project-managed" }
                ]
            , column [ alignRight, alignTop, spacing 15 ]
                [ footerSectionHeader "MESSAGE US"
                , messageUsItem "Skype" "/assets/icons/skype.png" "https://join.skype.com/invite/hn6ZHvTHDfax"
                , messageUsItem "WhatsApp" "/assets/icons/whatsapp.svg" "https://wa.me/447588699948"
                , messageUsItem "Telegram" "/assets/icons/telegram.svg" "https://t.me/crewnew"
                , messageUsItem "Facebook Messenger" "/assets/icons/facebook-messenger.svg" "https://www.messenger.com/login.php?next=https%3A%2F%2Fwww.messenger.com%2Ft%2F1776148165943905%2F%3Fmessaging_source%3Dsource%253Apages%253Amessage_shortlink"
                ]
            , column [ alignRight, alignTop, spacing 15 ]
                [ footerSectionHeader "CONTACT US"
                , contactUsItem [ text "11 Marchalsea Road", text "London SE11EN" ]
                , contactUsItem
                    [ link [] { url = "tel:+442039849495", label = text "+44 203 98 4949 5" }
                    , link [] { url = "tel:+447588699948", label = text "+44 75 886 999 48" }
                    ]
                , contactUsItem
                    [ link [] { url = "https://www.facebook.com/crewnewcom", label = text "Facebook chat" }
                    , link [] { url = "#", label = text "Contact form" }
                    ]
                ]
            ]
        ]


footerSectionHeader : String -> Element msg
footerSectionHeader headerText =
    paragraph
        [ paddingEach { top = 0, right = 0, bottom = 20, left = 0 }
        , Font.size 15
        , Font.bold
        ]
        [ text headerText ]


socialLink : String -> String -> Element msg
socialLink iconUrl url =
    link [] { url = url, label = image [] { src = iconUrl, description = "social" } }


messageUsItem : String -> String -> String -> Element msg
messageUsItem itemText iconUrl url =
    link []
        { url = url
        , label =
            row [ spacing 10 ]
                [ image [] { src = iconUrl, description = itemText }
                , text itemText
                ]
        }


contactUsItem : List (Element msg) -> Element msg
contactUsItem listOfElements =
    row [ spacing 15 ]
        [ image [ alignTop ] { src = "/assets/icons/green-arrow.svg", description = "arrow" }
        , column [ alignTop, spacing 5 ] listOfElements
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateForm field ->
            case field of
                Email email ->
                    ( { model | email = email }, Cmd.none )

                Password password ->
                    ( { model | password = password }, Cmd.none )

                ConfirmationPassword password ->
                    ( { model | confirmationPassword = password }, Cmd.none )

                FullName fullName ->
                    ( { model | fullName = fullName }, Cmd.none )

                MobilePhone mobileNumber ->
                    ( { model | mobileNumber = mobileNumber }, Cmd.none )

                WhatsAppFlag flag ->
                    ( { model | whatsAppFlag = flag }, Cmd.none )

                LinkedInLink url ->
                    ( { model | linkedInLink = url }, Cmd.none )

                FreelancerLink url ->
                    ( { model | freelanceUrl = url }, Cmd.none )

                Country country ->
                    ( { model | country = country }, Cmd.none )

                Town town ->
                    ( { model | town = town }, Cmd.none )



-- VIEW


purple : Color
purple =
    rgb255 66 55 91


white : Color
white =
    rgb255 255 255 255
