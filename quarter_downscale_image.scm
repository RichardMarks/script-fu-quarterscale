; MIT License
; 
; Copyright (c) 2016 Richard Marks
; 
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
; 
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
; 
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

(define (fitlayerafterscale image)
  (define layers (vector->list (cadr (gimp-image-get-layers image))))
  (map gimp-layer-resize-to-image-size layers)
)

(define (script-fu-quarterscale-image image)
  (define current_width (car (gimp-image-width image)))
  (define current_height (car (gimp-image-height image)))
  (define desired_width (* 0.25 current_width))
  (define desired_height (* 0.25 current_height))
  (gimp-image-scale image desired_width desired_height)
  (fitlayerafterscale image)
)

(define (script-fu-quarterscale)
  (define images (vector->list (cadr (gimp-image-list))))
  (map script-fu-quarterscale-image images)
  (gimp-displays-flush)
)

(script-fu-register
  "script-fu-quarterscale"
  "Quarter Scale"
  "downscales images to 25%"
  "Richard Marks"
  "Copyright 2016, Richard Marks"
  "September 5, 2016"
  "*"
)

(script-fu-menu-register
  "script-fu-quarterscale"
  "<Image>/Image/Transform"
)
