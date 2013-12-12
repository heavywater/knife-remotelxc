== Knife Remotelxc

= DESCRIPTION

knife-remotelxc is a chef plugin which allows you to create, delete, list and get info on lxc
containers on remote machines using knife.

= INSTALLATION

Install using the ruby gem
```
gem install knife-remotelxc
```

Alternatively add this to your Gemfile
gem "knife-remotelxc"
and then
```
bundle install
```

= COMMANDS

* knife remotelxc create NODE_NAME
* knife remotelxc delete NODE_NAME
* knife remotelxc info NODE_NAME
* knife remotelxc list

command details:
knife remotelxc create --help

example:
```
knife remotelxc create -l lxc.enabled.host.com -E development -r "role[base]" -x ubuntu -i ~/.ssh/identification --sudo -y
```
