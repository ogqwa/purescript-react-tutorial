module Components.App where

import Prelude
import Components.Board as Borad
import Data.Array as Array
import Data.Maybe (Maybe(..))
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "Counter"

counter :: JSX
counter =
  make component
    { initialState
    , render
    }
    unit
  where
  initialState =
    { squares: (Array.range 0 8 <#> \_ -> Nothing) :: Array (Maybe String)
    }

  render self =
    R.div
      { className: "game"
      , children:
        [ Borad.board
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
