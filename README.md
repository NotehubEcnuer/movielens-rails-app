# MovieLens Rails App

Rails app for [MovieLens](http://grouplens.org/datasets/movielens/) data. For data hacking and whatnot.


## Getting data

Download dump created at [https://github.com/ankane/movielens.sql](https://github.com/ankane/movielens.sql):

```
createdb movielens_development
curl https://raw.githubusercontent.com/ankane/movielens.sql/master/movielens.sql | psql -d movielens_development
```

## Dataset

100,000 Ratings
1682 Movies
18 Genres
943 Users
21 Occupations
