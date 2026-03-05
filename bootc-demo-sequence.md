# bootc update demo steps

## examine the system

This starts with the initial bootc device already installed.  Root's password is "root".

First, go to http://10.0.1.10 in your browser and look at the web page there.

Then:

```
ssh root@10.0.1.10
bootc status
```

## first update example

On the laptop, make a change to index.html, any kind of update you want.  I suggest updating "version" to "2".  Save.

```
cd /git/bootc-device-demo
podman build --tag 10.0.1.1:8000/httpd CONTAINERFILE
```

Now, we're going to "test" this update.  It's a bootable container, but it's also a container, so we'll run it:

```
podman run --port 8080:80 10.0.1.1:8000/httpd
```

Check http://localhost:8080.  How's it look?  Good.  Now let's push to the registry.

```
podman push 10.0.1.1:8000/httpd 
```

On the ssh connection:

```
bootc update
bootc status
systemctl reboot
```

Wait 2 minutes, then check http://10.0.1.10. Then:

```
ssh root@10.0.1.10
bootc status
```

## 2nd Update

For this update, we're going to try to apply the update without a full reboot.

On the laptop, make a change to index.html, any kind of update you want.  I suggest updating "version" to "3".  Save.

```
podman build --tag 10.0.1.1:8000/httpd CONTAINERFILE
podman push 10.0.1.1:8000/httpd 
```

On the ssh connection:

```
bootc update --apply
```

This should do a "soft reboot". Immediately check http://10.0.1.10. Then, on ssh:

```
bootc status
```

## Update and Rollback

For this update, we're going make a bad update and rollback.

On the laptop, make a change to index.html.  This change should break the HTML doc so that it won't render correctly.  Then:

```
podman build --tag 10.0.1.1:8000/httpd CONTAINERFILE
podman push 10.0.1.1:8000/httpd 
```

Don't test or check it this time.  Instead:

```
bootc update --apply
bootc status
```

Now, go to http://10.0.1.10 and see the broken web page.  Time to rollback!

```
bootc rollback
bootc status
systemctl reboot
``

Wait a couple minutes and go back to http://10.0.1.10.  You should be back on version 3.
