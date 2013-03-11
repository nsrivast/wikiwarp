## About ##

Wikiwarp was created by [Nikhil Srivastava] (http://www.nikhilsrivastava.com) in 2009, 
and was maintained in partial fulfillment of the requirements for [this course] 
(http://www.eecs.harvard.edu/cs286r/).

## WikiWarp ##

WikiWarp is intended to be a "game with a purpose", a game played by human participants 
whose strategic gameplay results in the solving of computational tasks that are difficult for 
computers alone to perform. Other games of this sort include image labeling and aggregation of 
common sense knowledge [1].

This game's computational target is measuring the semantic relatedness between different ideas 
and concepts, for example _prison_ and _democracy_. The accurate aggregation of such meta-information, 
or even a small improvement on current methods of aggregation, has important applications including 
search engine technology and advertising.

The paths constructed between disparate topics contain some information 
about their semantic relatedness, and the goal of the game is to encourage high-volume 
production of this user-generated information.

Data gathered over the 2 weeks the application was online (800+ games from 200+ users, 
generating 50+ hours of gameplay) was used to create the results and discussion in 
[wikiwarp_final_report] (https://github.com/nsrivast/wikiwarp/blob/master/wikiwarp_final_report.pdf).

## How to Play ##

Playing WikiWarp, you'll be placed on a start page on Wikipedia and instructed to navigate 
through the links of the website to arrive at a specified target page. You'll be scored
on the total time of your successful warp as well as the number of links you click along the way.

There are a variety of game types, including:

* _featured games_ that use hand-selected start and target pages for exciting and informative warping
* _random games_ that use completely random start and target pages from Wikipedia
* _custom games_ in which the user can choose their own start and target pages

At every step of each of these games, you are presented with a page that looks like [this]
(https://github.com/nsrivast/wikiwarp/blob/master/public/images/how_to_play_mod.png).

Game statistics are visible in the yellow status bar, and below that is a reproduction of the
Wikipedia page you are currently viewing. Click on any of the links that you think will get you closer
to your target.

## Notes ##

This application was created in Rails 2 and refurbished in Rails 3. It runs properly but may have some
deprecated file structures and formats.

## References ##

* [1] [Games with a Purpose - Louis von Ahn] (http://www.cs.cmu.edu/~biglou/ieee-gwap.pdf)

* [2] [www.GWAP.com] (http://www.gwap.com/) - a collection of other games with a purpose

* [3] [Semantic relatedness] (http://en.wikipedia.org/wiki/Semantic_relatedness)
