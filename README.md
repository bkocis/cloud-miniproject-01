
#### Jenkinsfile for building and running docker locally on the jenkins node running in systemd 

On Ubuntu the systemd service files are located in `/etc/systemd/system` folder. 
The basic service file can look something like this:

```bash
[Unit]
Description=simple name 
After=multi-user.target

[Service]
Type=Simple
ExacStart=/home/user/v_env/bokeh_1.3/bin/bokeh serve /path/to/app/ --flags

[Install]
WantedBy=multi-user.target
```

After the file is put into the `/etc/systemd/system` folder, run 
`sudo systemctl daemon-reload`
`sudo systemctl start service-name.service`




