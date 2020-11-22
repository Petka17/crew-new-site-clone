module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Element exposing (..)
import Element.Font as Font
import FinalPage
import Footer exposing (footer)
import NavBar exposing (navBar)
import Page exposing (Page(..))
import SignUpPage
import SkillsPage
import ThankYouPage
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }



-- MODEL


type alias Model =
    { navKey : Nav.Key
    , url : Url.Url
    , page : Maybe Page
    , signUpForm : SignUpPage.Model
    , skillsForm : SkillsPage.Model
    , finalForm : FinalPage.Model
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( { url = url
      , navKey = navKey
      , page = Page.fromUrl url
      , signUpForm = SignUpPage.init navKey
      , skillsForm = SkillsPage.init navKey
      , finalForm = FinalPage.init navKey
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = ClickedLink Browser.UrlRequest
    | ChangedUrl Url.Url
    | GotSignUpPageMsg SignUpPage.Msg
    | GotSkillsPageMsg SkillsPage.Msg
    | GotFinalPageMsg FinalPage.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        ChangedUrl url ->
            ( { model | url = url, page = Page.fromUrl url }
            , Cmd.none
            )

        GotSignUpPageMsg subMsg ->
            let
                ( signUpForm, newCmd ) =
                    SignUpPage.update subMsg model.signUpForm
            in
            ( { model | signUpForm = signUpForm }, Cmd.map GotSignUpPageMsg newCmd )

        GotSkillsPageMsg subMsg ->
            let
                ( skillsForm, newCmd ) =
                    SkillsPage.update subMsg model.skillsForm
            in
            ( { model | skillsForm = skillsForm }, Cmd.map GotSkillsPageMsg newCmd )

        GotFinalPageMsg subMsg ->
            let
                ( finalForm, newCmd ) =
                    FinalPage.update subMsg model.finalForm
            in
            ( { model | finalForm = finalForm }, Cmd.map GotFinalPageMsg newCmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- UPDATE


view : Model -> Browser.Document Msg
view model =
    { title = "Freelancer Sign Up - CrewNew"
    , body =
        [ layout [] <|
            column [ width fill, height fill ]
                [ navBar
                , column [ width fill, height fill, scrollbarY, spacing 40 ]
                    [ column
                        [ width <| maximum 900 fill
                        , paddingXY 20 0
                        , centerX
                        ]
                      <|
                        mainContent model
                    , footer
                    ]
                ]
        ]
    }


mainContent : Model -> List (Element Msg)
mainContent model =
    case model.page of
        Nothing ->
            [ text "not found" ]

        Just SingUp ->
            SignUpPage.view model.signUpForm
                |> List.map (Element.map GotSignUpPageMsg)

        Just Skills ->
            SkillsPage.view model.skillsForm
                |> List.map (Element.map GotSkillsPageMsg)

        Just Final ->
            FinalPage.view model.finalForm
                |> List.map (Element.map GotFinalPageMsg)

        Just ThankYou ->
            ThankYouPage.view
