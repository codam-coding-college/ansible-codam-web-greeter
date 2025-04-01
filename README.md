# Ansible playbook for codam-web-greeter
This Ansible playbook installs [codam-web-greeter](https://github.com/codam-coding-college/codam-web-greeter) on a 42 network cluster computer. It is intended to be used by IT staff at 42 schools to install the greeter theme on all cluster computers at once without too much effort.

---

## How to use
Add the following to the roles in your `requirements.yml` file in your `ansiblecluster` repository:
```yaml
roles:
  - name: codam.webgreeter
    src: git+https://github.com/codam-coding-college/ansible-codam-web-greeter.git
    version: v1.5.1
```
It is recommended to change the version specified to the latest one from the [Releases](https://github.com/codam-coding-college/ansible-codam-web-greeter/releases) page. Please note that this version is specific to this playbook and does not necessarily match the version of the codam-web-greeter itself.

Then run the following command to install the role:
```bash
ansible-galaxy install -r requirements.yml
```

Modify the [variables](#variables) using the `vars/all.yml` file in your `ansiblecluster` repository to your liking. The one you most likely want to change is the `codam_web_greeter_data_server_url` variable to point to your own data server.

> ⚠️ If using iMacs with T2 chips, set the `ddcci_backlight_support` variable to `false` to avoid issues with the ddcci-backlight kernel module.

Add the role to your `site.yml` playbook as the last role executed (do not define tags here, this is unneccessary and is a mistake 42 made for all the other roles):
```yaml
roles:
  ...
  - { role: codam.webgreeter }
```

Congratulations, the codam-web-greeter will now be installed on your cluster computers when you run the `site.yml` playbook! You can run it with the tag `codam.webgreeter` to only run the steps for the codam-web-greeter specifically.

> ⚠️ Do not run the playbook on all cluster computers at once without testing it first on a testing machine. Your campus setup could potentially break, resulting in students not being able to log in and changes that can not easily be reverted.

### Campus logo
Now, the following is optional but recommended: add your campus's logo to the `campus_files` directory in your `ansiblecluster` repository. The logo should be named `logo.png` and be placed in `campus_files/usr/share/codam/web-greeter/`. It will then get copied to the cluster computer and displayed by the login screen.

However, keep in mind that most campuses feature their logo already in the wallpaper used by the login screen provided by 42/Ubuntu. In this case, the logo would be displayed twice by the login screen. It is recommended to remove the logo from your login screen wallpaper or to use a custom wallpaper without the logo (defined in the `login_wallpaper_path` variable) to avoid this.

Using this feature over the logo embedded in the wallpaper has the advantage that the logo can be shifted around and resized more easily when required by the login screen's user interface.

It is also possible to specify a default user image in case the user's `~/.face` file is not present in their home folder. This image should be named `user.png` and be placed in the same directory as the logo. The default 42 user image can be found [here](https://github.com/codam-coding-college/ansible-codam-web-greeter/blob/main/files/usr/share/codam/web-greeter/user.png). If no default user image is present on the system, no image will be displayed on the lock screen at all and it will just display the student's name.

## Variables
| Variable | Description | Default value |
|----------|---------|-------------|
| `nody_greeter_version` | The version of the nody-greeter to install from GitHub. | `1.6.2` |
| `codam_web_greeter_git_repo` | The repository to download codam-web-greeter from. | `https://github.com/codam-coding-college/codam-web-greeter` |
| `codam_web_greeter_version` | The version of codam-web-greeter to download (use a tag or a branch name from the git repo). | `v1.2.0` |
| `codam_web_greeter_theme` | The theme to use for the greeter. Can be `dark` or `light`. | `dark` |
| `codam_web_greeter_boxed_mode` | Boxed mode adds a semi-transparent background to the login/unlock forms for better readability. Can be `default` (no background) or `boxed`. | `default` |
| `codam_web_greeter_data_server_url` | The URL to the data server to download the greeter data from. Hostname is appended to the url, so make sure it ends with a slash. | `https://clusterdata.codam.nl/api/config/` |
| `dbus_cache_group_check_enabled`| Whether to check if a user is in a specific ldap group before adding it to the dbus cache. Usually this is not required. | `false` |
| `dbus_cache_group_check_group`| The group to check for. | `student` |
| `login_wallpaper_path` | The path to the login wallpaper to set. | `/usr/share/42/login-screen.jpg` |
| `ddcci_backlight_support` | Whether to enable support for DDC/CI to allow controlling the brightness of external monitors. Should be set to `false` if you're using iMacs with T2 chips or any other *ddcci-dkms* unsupported kernel. | `true` |
