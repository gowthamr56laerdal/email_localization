---
name: email-cloning
description: Clone an input HTML email for a new locale by swapping the locale code and stripping Eloqua tracking params from links. Use when the user provides an email HTML file and asks to clone/duplicate it for another locale (input_locale_1 -> input_locale_2).
---

Input:
- The input HTML is at `.temp/email-cloning/input-email.html`.
- The `input_locale_1` and `input_locale_2` are provided as arguments when the skill is called.

Task:
1. check the `.temp/email-cloning/cloned.html` file exists. If it does, delete it.
2. read `.temp/email-cloning/input-email.html` and update the html email code:
   1. replace the `input_locale_1` with the `input_locale_2`
   2. remove all the elqTrackId and elqTrack parameters in all the `<a>` tags
3. only do the above tasks otherthan that keep everything same.
4. save the output html file as `.temp/email-cloning/cloned.html`.
5. after the output file is created, empty the `.temp/email-cloning/input-email.html` file.