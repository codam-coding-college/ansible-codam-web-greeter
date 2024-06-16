# Ansible playbook for codam-web-greeter
This Ansible playbook installs [codam-web-greeter](https://github.com/codam-coding-college/codam-web-greeter) on a 42 network cluster computer. Install it using Ansible Galaxy.

---

## How to use
Add the following to the roles in your `requirements.yml` file:
```yaml
roles:
  - name: codam.webgreeter
    src: git+https://github.com/codam-coding-college/ansible-codam-web-greeter.git
    version: v1.0.0
```
It is recommended to change the version to the latest one defined on the [Releases](https://github.com/codam-coding-college/ansible-codam-web-greeter/releases) page.

Then run the following command to install the role:
```bash
ansible-galaxy install -r requirements.yml
```

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

However, keep in mind that most campuses feature their logo already in the wallpaper used by the login screen provided by 42/Ubuntu. In this case, the logo would be displayed twice by the login screen. It is recommended to remove the logo from your login screen wallpaper.

Using this feature over the logo embedded in the wallpaper has the advantage that the logo can be shifted around and resized more easily when required by the login screen's user interface.

It is also possible to specify a default user image in case the user's `~/.face` file is not present in their home folder. This image should be named `user.png` and be placed in the same directory as the logo. The default 42 user image can be found [here](https://github.com/codam-coding-college/ansible-codam-web-greeter/blob/main/files/usr/share/codam/web-greeter/user.png). If no default user image is present on the system, no image will be displayed on the lock screen at all and it will just display the student's name.
