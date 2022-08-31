# Calculator Soccer Ranking

## Installation

### Dependencies

* ruby '2.7.2'
* BUNDLED '2.3.8'

### Clone repository

Go your terminal and clone the repository:
`git clone git@github.com:substantial/developer-candidate-philip13.git`
Go to the folder:
`cd developer-candidate-philip13`

### Installation of bundle

Make sure  that you have ruby version 2.7.1 installed, if you don't have,
we recomend install on Ruby Version manager, for example [rvm](https://rvm.io/rvm/install), afeter that install the correct version of ruby:

`rvm use 2.7.2`

Next install bundler gem
`gem install bundler -v '~> 2.3.8'`

And finaly install gems dependncies
`bundle install`

### Usage
To get ranking points table you need a `file.txt` you have a example called `sample-input.txt` and execute in your terminal:

`./calculate-ranking.rb init -p sample-input.txt`

### Execute automating test
If yor installations was successful, run in your termina 
`rspec` or `bundle exec rspect`

and your output seem similar to: 
```
bundle exec rspec
....

Finished in 0.00892 seconds (files took 0.20442 seconds to load)
4 examples, 0 failures
```

#### Give Execute Permissions(optional)

If your comand does now work run this comman in your root directory
`chmod +x calculate-ranking.rb`
