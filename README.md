# RECON1: Recon Framework

Modular and extensible automated recon framework

-----------------------------------------------
## Features

- ** Modular arch **
- ** Auto tool setup and check **
- ** Targeted asset discovery **
- ** Integrated vulnerability checks **
- ** Notification hooks **
- ** Logging **
- ** Extensible **
- ** Batch and cron ready **

## Usage
./recon.sh ( Remember to give +x permissions )

## Adding modules
- Place your module in the `modules/` directory
- Call it from `recon.sh` by adding:
    `./modules/yourmodule.sh $OUT`

### Examples
- portscan.sh: Fast TCP port scanning and service identification
- s3hunt.sh: Find exposed cloud storage buckets
- jssecrets.sh: Scrape JS files and hunt for secrets, endpoints and API keys
- cloudmeta.sh: Cloud metadata/SSRF checks
- fuzz.sh: Fuzz params, directories, endpoints

## Dependencies
- Go
- subfinder, amass, assetfinder, dnsx, httpx, nuclei, gowitness
- gau, waybackurls, qsreplace, dalfox, notify
- nmap, naabu, ffuf, arjun, gitdorks, trufflehog
- jq, curl, python3

## Notifications
- Configure slack, telegram or custom notification hooks in `config.conf`
- The `notify.sh` module will send alerts with critical findings

## Reporting
- All result saved in `/output/{target-date}/folders`
- Use the `vulnsummary.sh` modoule to collate the most relevant findings for reporting
- Add your own HTML/PDF/Markdown report generators in the `/reports/` directory

## Legal
Only use this framework on assets you own or have explicit permission to test.
