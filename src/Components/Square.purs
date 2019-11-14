module Components.Square where


import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R

type Props = { value :: String }

component :: Component Props
component = createComponent "Square"

square :: Props -> JSX
square = make component
  { initialState
  , render
  }
  where
  initialState =
    { hoge: 1 }

  render self =
    R.button
    { className: "square"
    , children:
      [ R.text self.props.value
      ]
    }
