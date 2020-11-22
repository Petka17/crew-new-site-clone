module ThankYouPage exposing (view)

import Colors exposing (..)
import Element exposing (..)
import Element.Font as Font


view : List (Element msg)
view =
    [ paragraph
        [ Font.color purple
        , Font.size 28
        , paddingEach { top = 40, right = 0, bottom = 20, left = 0 }
        ]
        [ text "All done!" ]
    , row [ alignTop, width fill ]
        [ column [ spacing 30, width (fillPortion 3), Font.size 16 ]
            [ column [ width fill, Font.light, spacing 6 ]
                [ paragraph [] [ text "Thanks! We'll come back to you soon:)" ]
                , paragraph [] [ text "As you didn't apply for any specific job, we don't need any further information from you! We will check your LinkedIN and freelance/job site URL and come back to you!" ]
                ]
            , paragraph [ Font.light ]
                [ text "Hint: go and update your LinkedIn profile, make sure it's up to date, you have there high quality profile picture, decent title/descriptio \" About \" section written and corrected with "
                , link [ Font.color blue ] { url = "https://grammarly.com/", label = text "Grammarly" }
                , text ", all the latest skills, etc. It's very useful for getting selected for CrewNew or any other job, too!"
                ]
            , paragraph [ Font.medium ]
                [ text "Please, join also LinkedIn Group "
                , link [ Font.color blue ] { url = "https://www.linkedin.com/groups/8707263/", label = text "Hand Picked Freelancers & Project Managers" }
                , text " and Facebook group "
                , link [ Font.color blue ] { url = "https://www.facebook.com/groups/it.jobs.europe", label = text "IT / Development / Programming Jobs (Eastern-Europe, Remote)." }
                ]
            ]
        , image [ width (fillPortion 2) ] { src = "/assets/images/thanks.svg", description = "" }
        ]
    ]
