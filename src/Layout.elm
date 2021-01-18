module Layout exposing (view)

import Element exposing (Element)
import Element.Background
import Element.Font
import Element.Region
import Html exposing (Html)
import Route exposing (Route)


maxWidth : Element.Length
maxWidth =
    Element.maximum 1200 Element.fill


view :
    Maybe Route
    -> { title : String, body : List (Element msg) }
    -> { title : String, body : Html msg }
view activeRoute document =
    { title = document.title
    , body =
        Element.column
            [ Element.width Element.fill
            , Element.height Element.fill
            ]
            [ header activeRoute
            , Element.column
                [ Element.width maxWidth
                , Element.padding 30
                , Element.spacing 20
                , Element.centerX
                , Element.Region.mainContent
                , Element.height Element.fill
                ]
                document.body
            , footer
            ]
            |> Element.layout
                [ Element.width Element.fill
                , Element.height Element.fill
                ]
    }



-- HEADER


header : Maybe Route -> Element msg
header activeRoute =
    Element.row
        [ Element.width maxWidth
        , Element.centerX
        , Element.padding 25
        , Element.Font.color <| Element.rgb 1 1 1
        ]
        [ headerLogo
        , headerItems activeRoute
        ]
        |> Element.el
            [ Element.width Element.fill
            , Element.Background.color <| Element.rgb255 0x5F 0xAB 0xDC
            , Element.Region.navigation
            ]


headerLogo : Element msg
headerLogo =
    Route.linkToRoute
        [ Element.Font.bold
        , Element.Font.size 32
        ]
        { route = Route.Home, label = Element.text "elm-starter" }


headerItems : Maybe Route -> Element msg
headerItems activeRoute =
    List.map (headerItem activeRoute) [ Route.Home, Route.About ]
        |> Element.row [ Element.alignRight, Element.spacing 20 ]


headerItem : Maybe Route -> Route -> Element msg
headerItem activeRoute itemRoute =
    let
        isActive =
            case activeRoute of
                Nothing ->
                    False

                Just r ->
                    r == itemRoute
    in
    Route.linkToRoute
        [ if isActive then
            Element.Font.bold

          else
            Element.Font.color <| Element.rgba 1 1 1 0.7
        , Element.mouseOver [ Element.Font.color <| Element.rgb 1 1 1 ]
        ]
        { route = itemRoute
        , label = Element.text <| routeTitle itemRoute
        }


routeTitle : Route -> String
routeTitle route =
    case route of
        Route.Home ->
            "Home"

        Route.About ->
            "About"



-- FOOTER


footer : Element msg
footer =
    Element.column
        [ Element.width maxWidth
        , Element.Region.footer
        , Element.centerX
        , Element.padding 25
        ]
        [ Element.paragraph
            [ Element.Font.center
            , Element.Font.color <| Element.rgb255 86 86 86
            ]
            [ Element.text "This was generated by "
            , Element.newTabLink [ Element.Font.underline ]
                { url = "https://github.com/NeoVier/elm-starter"
                , label = Element.text "NeoVier/elm-starter"
                }
            ]
        ]
        |> Element.el
            [ Element.width Element.fill
            , Element.Background.color <| Element.rgb255 234 234 234
            ]
