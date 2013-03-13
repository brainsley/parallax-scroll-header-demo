class Header
  activeFactor: null
  
  constructor: ->
    @initiateSteps()
    @initiateHeaderStickynessSwitch()
    @alterateOpacs()
    
  initiateHeaderStickynessSwitch: ->
    $( '.main-container' ).waypoint (dir) =>
      if dir is 'up'
        $( '.header-container' ).removeClass 'sticky-header'
      else
        $( '.header-container' ).addClass 'sticky-header'
    ,
      offset: 200
  
  initiateSteps: ->
    for x in [0..9]
      new_elem = $( '<div></div>' )
      new_elem.addClass 'opac-trigger'
      new_elem.data 'opac-factor', x
      $( '.header-container' ).append new_elem
      new_elem.css
        top: new_elem.height() * x
  
  translateOpacityAlterations: ( factor ) ->
    $( '.intro .short' ).css
      opacity: 0.1 * factor
      
    $( '.intro .long' ).css
      opacity: 1 - 0.1 * factor
       
  alterateOpacs: ->
    M = @
    $( '.opac-trigger' ).waypoint ( dir ) ->
      M.activeFactor = $( this )
      if dir is 'up'
        M.activeFactor = M.activeFactor.prev()
      
      unless M.activeFactor.length
        M.activeFactor = $( this )
      
      value = M.activeFactor.data 'opac-factor'
    
      M.translateOpacityAlterations( value )

if $( '.header-container' ).length > 0 and $( '.main-container' ).length > 0
  header = new Header
