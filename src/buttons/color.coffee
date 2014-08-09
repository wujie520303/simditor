
class ColorButton extends Button

  name: 'color'

  icon: 'font'

  title: '文字颜色'

  disableTag: 'pre'

  menu: true

  render: (args...) ->
    super args...

  renderMenu: ->
    $('''
      <ul class="color-list">
        <li><a href="javascript:;" class="font-color font-color-1" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-2" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-3" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-4" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-5" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-6" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-7" data-color=""></a></li>
        <li><a href="javascript:;" class="font-color font-color-8" data-color=""></a></li>
        <li class="remove-color"><a href="javascript:;" class="link-remove-color">去掉颜色</a></li>
      </ul>
    ''').appendTo(@menuWrapper)

    @menuWrapper.on 'mousedown', '.color-list', (e) ->
      false

    @menuWrapper.on 'click', '.font-color', (e) =>
      @wrapper.removeClass('menu-on')
      $link = $(e.currentTarget)
      rgb = window.getComputedStyle($link[0], null).getPropertyValue('background-color')
      hex = @_convertRgbToHex rgb
      return unless hex
      document.execCommand 'foreColor', false, hex
      @editor.trigger 'valuechanged'
      @editor.trigger 'selectionchanged'

    @menuWrapper.on 'click', '.link-remove-color', (e) =>
      @wrapper.removeClass('menu-on')
      $p = @editor.body.find 'p'
      return unless $p.length > 0

      rgb = window.getComputedStyle($p[0], null).getPropertyValue('color')
      hex = @_convertRgbToHex rgb
      return unless hex

      document.execCommand 'foreColor', false, hex
      @editor.trigger 'valuechanged'
      @editor.trigger 'selectionchanged'

  _convertRgbToHex:(rgb) ->
    re = /rgb\((\d+),\s?(\d+),\s?(\d+)\)/g
    match = re.exec rgb
    return '' unless match

    rgbToHex = (r, g, b) ->
      componentToHex = (c) ->
        hex = c.toString(16)
        if hex.length == 1 then '0' + hex else hex
      "#" + componentToHex(r) + componentToHex(g) + componentToHex(b)

    rgbToHex match[1] * 1, match[2] * 1, match[3] * 1


Simditor.Toolbar.addButton(ColorButton)

