---
name: email-cloning
description: Clone an input HTML email for a new locale by swapping the locale code and stripping Eloqua tracking params from links. Use when the user provides an email HTML file and asks to clone/duplicate it for another locale (input_locale_1 -> input_locale_2).
---

Task:
1. update the input html email code:
   1. replace the `input_locale_1` with `input_locale_2`
   2. remove all the elqTrackId and elqTrack parameters in all the `<a>` tags
2. only do the above tasks otherthan that keep everything same.
3. save the output html file as `.temp/email-cloning/cloned.html`. If it already exists, overwrite it.