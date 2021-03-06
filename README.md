[deprecated] see http://github.com/dradis/dradis-ce 
===================================================
 

Dradis Framework HTTP API
=========================

[![Build Status](https://secure.travis-ci.org/dradis/dradis-api.png)][travis][![Dependency Status](https://gemnasium.com/dradis/dradis-api.png)][gemnasium]

[travis]: https://secure.travis-ci.org/dradis/dradis-api
[gemnasium]: https://gemnasium.com/dradis/dradis-api

This plugin provides an external HTTP API that you can use to publish data to your Dradis Framework instance.

Installing
----------

*WARNING* this plugin is in early stages of development. Use at your own risk!

Add the following line to the bottom of your `Gemfile.plugins`:

```
gem 'dradis-api', github: 'dradis/dradis-api'
```

And run Bundler:

```
$ bundle
```

Using the API
-------------
You can test the API with `curl`. You will need to provide your Dradis instance password and a username of your choosing.

To get the list of nodes:
```
$ curl -u user:password http://dradisframework.dev/api/nodes
```

To add a new node:
```
$ curl -u user:password -d "node[label]=from_api" http://dradisframework.dev/api/nodes
```

A comprehensive API documentation is in the making

Getting help
------------
* http://dradisframework.org/
* Dradis Guides: http://guides.dradisframework.org
* [Community Forums](http://dradisframework.org/community/)
* IRC: **#dradis** `irc.freenode.org`


Contributing
------------

* Join the developer discussion at: [dradis-devel](https://lists.sourceforge.net/mailman/listinfo/dradis-devel)
* [Report a bug](https://github.com/dradis/dradis-api/issues)
* Help with the [Dradis Guides](https://github.com/dradis/dradisguides) project or submit your guide.
* Submit a patch:
  * Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
  * Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
  * Fork the project
  * Start a feature/bugfix branch
  * Commit and push until you are happy with your contribution
  * Make sure to add tests for it. This is important so we don't break it in a future version unintentionally.
  * Review our [Contributor's Agreement](https://github.com/dradis/dradisframework/wiki/Contributor%27s-agreement). Sending us a pull request means you have read and accept to this agreement
  * Send us a [pull request](http://help.github.com/pull-requests/)


License
-------

Dradis Framework is released under [GNU General Public License version 2.0](http://www.gnu.org/licenses/old-licenses/gpl-2.0.html)
