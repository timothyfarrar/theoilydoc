A skeleton Preside application to be used as a starting point for a blog.

### Important

This package should be installed using the `preside new site` command from CommandBox rather than directly. See [PresideCMS Commands](https://www.forgebox.io/view/preside-commands).

### Dependencies

There are three dependencies in form of preside extensions that are automatically setup for you via CommandBox box.json

* [preside-ext-elasticsearch](https://github.com/pixl8/preside-ext-elasticsearch)
* [preside-ext-analytics-import](https://www.forgebox.io/view/preside-ext-analytics-import)
* [preside-ext-blog](https://www.forgebox.io/view/preside-ext-blog)

### Step by Step Guide

To get you up and running quickly here is a sample scenario of what you would do to start using the blog:

#### CommandBox Package Management

Use CommandBox to setup your site

    mkdir myblog --cd
    preside new site

Follow the wizard, use for example:

* skeleton: blog
* site-id: blog
* admin path: admin (remember this one to be able to access the admin later)
* site name: YOUR SITE NAME HERE
* site author: YOUR NAME HERE

#### Database

Create an empty database schema in mysql or mariadb that we can use.

#### Search Engine

Install and start ElasticSearch as described here: https://www.elastic.co/guide/en/elasticsearch/reference/1.7/_installation.html
At this point the ElasticSearch extension only works with a 1.7 release, but that might change later.
If you don't want to use a search engine you can skip this step. But you need to disable the extension later - otherwise you get into trouble.
Disabling it is describe further down below.

#### CommandBox Lucee Server

Use CommandBox to start the server (make sure that you are in your blog apps root dir)

    preside start

Setup MySQL datasource now [Y/n]? y
enter DB info (name, user, server, etc.)

You should now see a blank homepage.

#### Configuration / Initial setup

Access the Preside Admin by appending /admin to the URL, e.g. http://127.0.0.1:12345/admin
If you chose a different admin path in the wizard, append that accordingly.
If you forgot what admin path you took or want to change it now, you can do that in the Config.cfc of your project.

Setup the sysadmin (super user that can do everything in the admin) by entering an email address and password.
Login using username _sysadmin_ and the password you just entered

#### Disable ElasticSearch
If you decided _not_ to use elastic search (not recommended though), now it's time to disable the extension.
Open the developer console in the Preside admin (english keyboard: `, german keyboard: CTRL+SHIFT+´ < that is the accent next to the backspace, your keyboard: no idea ;-) )

    extension list
    extension disable preside-ext-elasticsearch
    extension list
    reload all

You should then reload the page in the browser and the extension is now disabled.
An alternative way to do the same is to edit the extensions.json file in your application and reloading the application afterwards.
An alternative way to reload the application is to add ?fwreinit=true to the URL.

#### ElasticSearch Integration settings

If you did not disable ElasticSearch, we are now configuring it.
In the Preside Admin go to System > Search Engine > ElasticSearch Settings

* Enter a default indexname, e.g. myblog
* Enter the server endpoint, probably http://localhost:9200 if you just installed it with the default settings
* Enter an API call timeout, e.g. 30 and maybe use 3 retry attempts
* save the settings

To make sure that the elastic search extension works as expected, add a test page in the site tree or edit the homepage there.
If it does not throw an error on save, it should work fine in theory.
Have a look under System > Search Engine. The index should be listed there and you should be able to refresh it manually.
There is no need to do this manually all the time as on each page save the page content is indexed automatically.
If you get errors on save of a page, reload the application and try again.

Now we need some further settings to have your blog work nicely

#### AddThis

Use AddThis.com to add social sharing buttons to your blog posts. Create an account there, take note of the generated ID and enter it afterwards in the Preside Admin here:

System > Settings > AddThis Social Sharing

#### Disqus

Use disqus.com for discussion threads/commenting on your blog posts. Create an account, configure it and take not of the _short name_, entering it afterwards in the Preside Admin here:

System > Settings > Disqus Comments > Disqus Short name

#### Google Analytics

You can setup google analytics for tracking but also make use of it to import the page views.
Those can then be used, e.g. to display a list of blog posts having the most viewed ones on top.
Getting the required infos from GA is kind of tricky and described here:

https://bitbucket.org/jjannek/preside-ext-analytics-import

Enter the necessary settings here:

System > Settings > Google Analytics Reporting Import

#### Basic data

Head over to the Data Manager in the Preside admin and enter some basic data

* Authors
* Tags
* Social Links

All those can also be entered/edited/updated on-the-fly while using them later, but it might be less confusing to do it step by step.

#### Create the blog listing page

Add a new page as a child of the Homepage by clicking the plus next to it. Choose "Blog" from the available options.
Fill in the basic blog data:

* title (probably just use _blog_)
* slug

Then save + publish.

Edit the just created Blog page again and have a look at the sidebar content field.
It's empty and we put 3 widgets in there (widgets can be added with the magic wand button in the rich editor):

* add widget _blog post list_:
    * select the blog from the dropdown
    * title = Top posts
    * flag top posts only
    * show author name
    * max items=5
* add widget _tag list_
    * title = Featured tags
    * flag featured tags only enabled
* add widget _blog post list_:
    * select the blog from the dropdown
    * title = Most viewed
    * flag order by most viewed
    * show author name
    * max items=5
* add widget _blog filters_:
    * select the blog from the dropdown
    * include authors, tags and archive (year/month filtering)
    * optionally adapt the titles
* add widget _rss feed_:
    * select the blog from the dropdown

then save + publish.

It was required to save the page first as it is referenced in the widgets.

#### Customize basic website settings

To customize the footer of the website, we can do the following:

Within the Preside admin go to Default Site > Manage sites and then edit the default site.
Open the Navigation tab and do the following:

* upload a logo file for the navigation bar
* enter contact infos
* add social media links (select the ones you created or create new ones, ordering possible)
* add a copyright info - e.g. use the copyright symbol from the rich editor
* Left content: put in the widget _blog post list_
    * select the blog from the dropdown
    * title=Latest posts
    * show publish date
    * max items = 3
    * collapse on mobile = enabled

#### Your first blog post

Go to the site tree and beneath the created blog page, click the link _manage blog post pages_.
Then click the button _add blog post_.

Fill in the following details:

* enter general blog content (main image, teaser, main content, maybe some block quotes or an image in the main content)
* author + publish date
* tagging tab: select existing or enter some new tags
* blog post settings: make it a top post and allow comments

Then save + publish

#### Inspecting the website

Have a look at the frontend website and if everything works as expected.

* There should be a link in the main navigation to your blog
* The blog should show a teaser to the blog post that your created
* If you made the post a top post, the widget in the sidebar will list it
* If you selected a featured tag, this tag will be visible in the sidebar beneath _Featured tags_
* you can click on a featured tag in the sidebar which will filter the blog posts
* most viewed should list the post
* if you click on the blog post the detailed post will be visible
* the post should show the addthis social sharing and the disqus comment section (if you chose to allow comments)
* the footer of the website should show the latest posts, contact info and social links
* obviously most of this makes more sense the more posts there are available

#### Importing pageviews from Google Analytics

Go to the Preside admin and navigate to System > Task Manager.

There you will find an import task. For now just try to run it manually and have a look if everything works as expected.
Later on you can edit the configuration there to automate the import.

#### Play with the code and customize the application

Have fun trying out Preside goodness, explore the existing code and customize to your desire.

Feel free to fork and contribute. Feedback is welcome - probably best on the Preside Slack.