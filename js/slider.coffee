---
---

class Slider
    constructor: (@config) ->
        return new Slider(@config) unless this instanceof Slider
        @parentSelector = @config.parentSelector || '.slider'
        @childSelector = @config.childSelector || '.slide'
        throw '[SLIDER]: Container não encontrado.' unless @parent = document.querySelector @parentSelector
        throw '[SLIDER]: Slides não encontrados.' unless @children = @parent.querySelectorAll @childSelector
        @index = 0
        @duration = @config.duration || 3000
        @compose()

Slider.prototype =
    compose: () ->
        prevIndex = if @index > 0 then @index - 1 else @children.length - 1
        nextIndex = if @index < @children.length - 1 then @index + 1 else 0
        @children.forEach (el) ->
            el.classList.remove 'prev'
            el.classList.remove 'current'
            el.classList.remove 'next'
            true
        @children[prevIndex].classList.add 'prev'
        @children[@index].classList.add 'current'
        @children[nextIndex].classList.add 'next'
        @
    play: () ->
        that = @
        @playingStateID = setInterval () ->
                that.next()
            , @duration
        @isPlaying = true
        @
    pause: () ->
        clearInterval @playingStateID
        @isPlaying = false
        @
    playpause: () ->
        if @isPlaying
            @pause()
        else
            @play()
    prev: () ->
        if @index > 0 then @index-- else @index = @children.length - 1
        playingState = @isPlaying
        @pause() if playingState
        @compose()
        @play() if playingState
    next: () ->
        if @index < @children.length - 1 then @index++ else @index = 0
        playingState = @isPlaying
        @pause() if playingState
        @compose()
        @play() if playingState
    on: (event, fn) ->
        that = @
        @parent.addEventListener event, fn
        @
    off: (event, fn) ->
        that = @
        @parent.removeEventListener event, fn
        @
    inspect: () ->
        console.group @parentSelector
        try
            console.info @children.length + ' slides'
        catch err
            console.error err
        console.groupEnd @parentSelector
        @

window.Slider = Slider