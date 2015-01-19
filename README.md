Pinocchio
=========

Pinocchio web application.
-------------------------------

> The main goal is to know the level of our developers by contributing to this very simple application.

Instalation:
------------

#### 1- Clone the repository.

```
git clone [git-repo-rul] pinocchio
```

#### 2- Go to the project directory.

```
cd pinocchio
```

#### 3- Install the gems.

```
bundle install
```

#### 4- Create & migrate the database.

```
rake db:create db:migrate
```

#### 5- Start the server.

```
rails s
```

Description
-----------

Implement a blog web application. It should allow the user to upload his/her information and a CRUD for post resource.


Features List:
--------------

* Implement authentication from scratch.
  * Sign Up by email, password & password confirmation.
  * Sign In by email & password.
  * Add Sign Out, Sign In, Sign Up links.
  * Add profile page. (user information summary)
  * Implement OAuth

* Add picture to post.
  * A user can add an image to his post.
  * Add column image to each post of the listing.
  * Add image to the post page.
  * Validate image format png, jpg.
  * Validate size < 2 mb.
  * Validate presence.

* Implement commentable posts.

* Implement ActiveAdmin Panel. (or alternative)
  * Add post resource.

* Implement search.
  * Search by title.

* Implement pagination to the listing of posts.
  * 15 posts per page.

* Implement rate system for posts.
  * Add rates count on the post page.
  * Add rate button on the post page.
  * A post can be rated once per user.
  * Sort posts by rating.

* Implement authorization system.
  * A user can manage his posts.
  * A user can manage his profile.

* Create a Readme file
  * How to
    * Deploy
    * Run tests
  * Explain the most important gems and tools used

Considerations
--------------

* Best practices
* Code quality
* Test coverage
* You dont need to do every thing, we are going to evaluate what you do.

How to submit your work:
------------------------

* Fork the repository.
* Create a new branch feature/feature-name.
* Add your code.
* Test with capybara & rspec.
* Make a pull request.
