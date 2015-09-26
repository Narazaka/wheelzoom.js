# wheelzoom.js

The mouse wheel zoom (y axis).

## Usage

Download [this](https://raw.githubusercontent.com/Narazaka/wheelzoom.js/master/wheelzoom.js) and [wheelevent.js](https://github.com/Narazaka/wheelevent.js), or install by

```
bower install wheelzoom.js
```

then

```
<script src="wheelevent.js"></script>
<script src="wheelzoom.js"></script>
<script>
window.onload = function(){
  var target = document.getElementById('target');
  var parent = target.parentNode;
  wheelzoom(target, parent); // parent is optional; default = target.parentNode
};
</script>
```

## Compatibility

- IE5+(checked by IE11 emulate)
- Firefox
- Google Chrome

## License

(C) 2015 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2015
