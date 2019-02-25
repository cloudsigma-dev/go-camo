go-camo(1) "" "GO-Camo Manual"

# NAME

*go-camo* -- Go version of Camo server

# SYNOPSIS

*go-camo* [_OPTIONS_] [_OPTION-ARGUMENTS_]

# DESCRIPTION

*go-camo* is an implementation of Camo in Go.

Camo is a special type of image proxy that proxies non-secure images over
SSL/TLS. This prevents mixed content warnings on secure pages.

It works in conjunction with back-end code to rewrite image URLs and sign them
with an HMAC.

# ENVIRONMENT VARS

*GOCAMO_HMAC*
	The HMAC key to use.

_Note_: _OPTIONS_, if provided, override those defined in environment
variables. For exmaple, if the HMAC key is provided on the command line, it
will over- ride (if present), an HMAC key set in the environment var.

# OPTIONS

*-k*, *--key*=<_hmac-key_>
	The HMAC key to use.

*-H*, *--header*=<_header_>
	Extra header to return for each response. This option can be used
	multiple times to add multiple headers.

	See _ADD\_HEADERS_ for more info.

*--stats*
	Enable stats collection and reporting functionality.

	If stats flag is provided, then the service will track bytes and
	clients served, and offer them up at an http endpoint /status via
	HTPT GET request.

	See _STATS_ for more info.

*--no-log-ts*
	Do not add a timestamp to logging output.

*--allow-list*=<_file_>
	Path to a text file that contains a list (one per line) of regex host
	matches to allow.

	If an allow list is defined, and a request does not match one of the listed
	host regex, then the request is denied.

*--max-size*=<_size_>
	Max response image size in KB. Default: 5120

*--timeout*=<_time_>
	Timeout value for upstream response. Format is "4s" where _s_ means
	seconds.  Default: 4s

*--max-redirects*
	Maximum number of redirects to follow. Default: 3

*--no-fk*
	Disable frontend http keep-alive support.

*--no-bk*
	Disable backend http keep-alive support.

*--listen*=<_address_:_port_>
	Address and port to listen to, as a string of "address:port".
	Default: "0.0.0.0:8080"

*--ssl-listen*=<_address_:_port_>
	Address and port to listen via SSL to, as a string of "address:port".

*--ssl-key*=<_ssl-key-file_>
	Path to ssl private key. Default: key.pem

*--ssl-cert*=<_ssl-cert-file_>
	Path to ssl certificate. Default: cert.pem

*-v*, *--verbose*
	Show verbose (debug) level log output

*-V*, *--version*
	Print version and exit; specify twice to show license information

*-h*, *--help*
	Show help output and exit

# ADD_HEADERS

Additional default headers (headers sent on every reply) can be set with the
*-H*, *--header* flag. This option can be used multiple times.

The list of default headers sent are:

```
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
Content-Security-Policy: default-src 'none'
```

Additional headers are added to the above set.

As an example, if you wanted to return an _Strict-Transport-Security_ and an
_X-Frame-Options_ header by default, you could add this to the command line:

```
-H "Strict-Transport-Security: max-age=16070400" \
-H "X-Frame-Options: deny"
```

# STATS

If the *--stats* flag is provided, then the service will track bytes and
clients served, and offer them up at an http endpoint "/status" via HTTP GET
request.

The output format is show as an example:

```
ClientsServed, BytesServed
4, 27300
```

# EXAMPLES

Listen on loopback port 8080 with a upstream timeout of 6 seconds:

```
go-camo -k BEEFBEEFBEEF --listen=127.0.0.1:8080 --timeout=6s
```

Set HMAC key via env var, and an HSTS header:

```
export GOCAMO_HMAC=BEEFBEEFBEEF
go-camo --listen=127.0.0.1:8080 \
   --timeout=6s \
   -H "Strict-Transport-Security: max-age=16070400"
```

# WWW

*https://github.com/cactus/go-camo*

# SEE ALSO

*https://github.com/atmos/camo*
