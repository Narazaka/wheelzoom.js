### (C) 2015 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2015 ###
px2num = (px) -> px.substr(0, px.length - 2) - 0
num2px = (num) -> num + 'px'
computed_styles = (element) -> (document.defaultView or window).getComputedStyle?(element, null)
page_offset = (element) ->
  # from jquery
  docElem = element.ownerDocument.documentElement
  box = element.getBoundingClientRect()
  win = document.defaultView || element.parentWindow || window
  top: box.top  + ( win.pageYOffset || docElem.scrollTop )  - ( docElem.clientTop  || 0 )
  left: box.left + ( win.pageXOffset || docElem.scrollLeft ) - ( docElem.clientLeft || 0 )

wheelevent = @wheelevent
wheelzoom = (target, parent=target.parentNode) ->
  # init
  target.style.position = 'relative'
  target.style.left = '0px'
  target.style.top = '0px'
  target.setAttribute('data-wheelzoom-scale-factor', 0)

  handler = (event, delta) ->
    old_scale_factor = target.getAttribute('data-wheelzoom-scale-factor') - 0
    scale_factor = old_scale_factor + if Math.abs(delta) > 80 then delta / 1000 else delta / 30 # ie=120, fx=3, ch=100
    old_scale = Math.exp(old_scale_factor)
    scale = Math.exp(scale_factor)

    old_left = px2num(target.style.left)
    old_top = px2num(target.style.top)
    # ie, fx, ch
    old_width = target.clientWidth
    old_height = target.clientHeight
    unless old_width # ?
      old_target_styles = computed_styles(target)
      old_width = px2num(old_target_styles.width)
      old_height = px2num(old_target_styles.height)

    offset = page_offset(parent)
    mouse_x = (event.clientX || window.event.clientX) + parent.ownerDocument.documentElement.scrollLeft - offset.left
    mouse_y = (event.clientY || window.event.clientY) + parent.ownerDocument.documentElement.scrollTop - offset.top

    scale_delta = scale / old_scale
    left = mouse_x - (mouse_x - old_left) * scale_delta
    top = mouse_y - (mouse_y - old_top) * scale_delta
    width = old_width * scale_delta
    height = old_height * scale_delta

    target.style.width = num2px(width)
    target.style.height = num2px(height)
    target.style.left = num2px(left)
    target.style.top = num2px(top)
    target.setAttribute('data-wheelzoom-scale-factor', scale_factor)

    event.preventDefault?()
    return false

  wheelevent parent, handler

@wheelzoom = wheelzoom
