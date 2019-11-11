module Components.App where

import Prelude

import Data.Array as Array
import Data.Maybe (Maybe(..), maybe)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import React.Basic.Events (handler_)



component :: Component Unit
component = createComponent "Counter"

counter :: JSX
counter = make component
  { initialState
  , render
  } unit
  where
    initialState =
      { squares: (Array.range 0 8 <#> \_ -> Nothing) :: Array (Maybe String)
      }
    render self =
      R.div
      { className: "game"
      , children:
        [ R.div
          { className: "game-board"
          , children:
            [ R.div 
              { className: "status"
              , children:
                [ R.text "status" ]
              }
            , R.div
              { className: "board-row"
              , children:
                  (\i ->
                    R.button
                    { className: "square"
                    , children:
                      [ R.text
                          case Array.index self.state.squares i of
                            Just v -> maybe "" (\v' -> v') v
                            Nothing -> "" 
                      ]
                    }) <$> Array.range 0 2
              }
            , R.div
              { className: "board-row"
              , children: 
                  (\i ->
                    R.button
                    { className: "square"
                    , children:
                      [ R.text
                        case Array.index self.state.squares i of
                          Just v -> maybe "" (\v' -> v') v
                          Nothing -> "" 
                      ]
                    }) <$> Array.range 3 5
              }
            , R.div
              { className: "board-row"
              , children: 
                  (\i ->
                    R.button
                    { className: "square"
                    , children:
                      [ R.text
                        case Array.index self.state.squares i of
                          Just v -> maybe "" (\v' -> v') v
                          Nothing -> "" 
                      ]
                    }) <$> Array.range 6 8
              }
            ]
          }
        , R.div
          { className: "game-info"
          , children:
            [ R.div
              { children: []
              }
            , R.ol
              { children: []
              }
            ]
          }
        ]
          
      }
