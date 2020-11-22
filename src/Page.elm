module Page exposing (Page(..), fromUrl, href, toString)

import Browser.Navigation as Nav
import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser, oneOf, s, string)


type Page
    = SingUp
    | Skills
    | Final
    | ThankYou


href : Page -> Attribute msg
href targetRoute =
    Attr.href (toString targetRoute)


fromUrl : Url -> Maybe Page
fromUrl =
    Parser.parse parser


parser : Parser (Page -> a) a
parser =
    oneOf
        [ Parser.map SingUp Parser.top
        , Parser.map Skills (s (toString Skills))
        , Parser.map Final (s (toString Final))
        , Parser.map ThankYou (s (toString ThankYou))
        ]


toString : Page -> String
toString route =
    case route of
        SingUp ->
            ""

        Skills ->
            "step2"

        Final ->
            "step3"

        ThankYou ->
            "thanks"
