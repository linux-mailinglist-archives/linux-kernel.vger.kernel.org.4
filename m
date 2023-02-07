Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E10168DBFE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjBGOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjBGOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:47:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC302683
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1675781229; bh=MMWnLGk13nFV3gpf/8YU5Lz9JoR4h/WQ6ROv9etjxvc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dVpUAZ3CvQzfWT5GBgPpFRf3hFA67dtrdPZLi7fjxMlXarhO6ePXqgT6omIMpotqV
         qYfgJKchuTIBy/2sP1h2wvJGxff3uBqDhJ6yQMYgyVFvcnH1NFv+m1w2KmaKGZCqw4
         Xone7lo6WbSL8aHTrMR+Cd14mKKlv+DJgzDuXL5DXyl0htidpZtzPfwqCOrlfkjgiY
         3OvhbgmXXudPJlDuQtQ9gt8UdNmAoJ+zOB8Um52RGTwAe6K7iMXo9EJswJ55a6loGL
         cfJI/zb40KqslsDpCre1WnreDOn0lPty8CIB6izT3PjK+lAaKyBGmwqJVTRJE0QwQr
         I92kv+DpShgpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1oacD80HZD-00u0PA; Tue, 07
 Feb 2023 15:47:09 +0100
Date:   Tue, 7 Feb 2023 15:47:08 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Relax commit ID check to allow more than
 12 chars
Message-ID: <Y+JkbGmuU9hmuc80@probook>
References: <20230129123431.1282427-1-j.neuschaefer@gmx.net>
 <78d224a63f6c27bf700d59007b6f3c89746d728c.camel@perches.com>
 <3afee0493d3718f2e38b6c54dab23d38360cd5d0.camel@perches.com>
 <CAMuHMdWcjUXwkk2V29p-hifDnMhLRSwQBXMzVeURRA48znKC5Q@mail.gmail.com>
 <bbdf99df867786510f709473fa2c3744dbf27bb4.camel@perches.com>
 <CAMuHMdU4HUmTJZiecL9u0G1LuZ18K_1hYo4Q_U9S2a2fuo=xRA@mail.gmail.com>
 <12e05a2c2aa1ab5627f4a57135ce4c493abb5a97.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mHUblShxIQCLrkNy"
Content-Disposition: inline
In-Reply-To: <12e05a2c2aa1ab5627f4a57135ce4c493abb5a97.camel@perches.com>
X-Provags-ID: V03:K1:K0DYKqKLFq2TaFcR2aoCxyhVfrW14QDMZSs3ZaewK1dEHGfnsjM
 Z35dUpMC5rFxRmqtbbX1EYQt6BPgmHEemk2r6YVXr053YBYRFjpuEpInXNgEgKm36Bqf1mV
 zdl07n589TVjpBLtvizV6TbeVcs+HbxSX01bKjSI/pxDJvP0+fMCWiWWyq3XwPhh2tpCxh3
 DEY4jv5yfFzehGbZGYaOw==
UI-OutboundReport: notjunk:1;M01:P0:/sUrG9bO2uQ=;J2fHoGA+ZRfBk3S9m48n9yZ6W5s
 9XM1b5ovLBOfagCC1zEOawjDJ7S8aho0dshmBEZL19EQAzFjzCSOBuqVKBDd7wFSdtO+O1VmB
 iXTJfjBpn2m5O7BZ9ZSlaPaRrAUheecZ0/9ZJNCLoZ9rK1ALsa7fCXFIU+JIR7F5kURiDlzwu
 K5cQhaRk+lSRhIzmbHSZOs/20fXF9/vGtOhm6O5K83+LN/ln84ip3wu7wXsgaFgjWcjRd9dCx
 ITtrQp60/sq+ozdCAUSj8DtjeHo39ndOAt4rx/TVx3/3cLwODVwPr06653J+5rA2knsYhhAes
 9isK13rEkWKwNItdbojR/CCRB7QJiYiPRtfEor3/P3CfZEuATi0pX4pb1XiYaZVhmwXgpxX8k
 zrSFd06KTknhkkjozdfV2DY/JZi82pft8uPXANGfs45j9wbMcHvtUbXHwHEJH6PszvGut1jTc
 xKqnNUSlCjctA46BpT+5UxKa2TTW0IHziyjlfiddaIeg42GSlcJSrAbg2z0cwzvEaXpIh/X8W
 bFfBxZmlho0nwdLU6SwC60hYEQpFAhsBSYe05YIz3P3tFhxwnDpWaGKRpffT7T2iI9SRj6tDE
 z4n+puKxKerJZOZLV2SGBneVy67M6NfzajDKZTeXUq0WO1nV6ycz5ArZLwpMd0bj1v8qHhyQc
 VCTgco4W8hKVnqcy5UhJHAicEFyh2w30CbAIcQTjauSRulGjoJcvlYkmzDWG4IHqYrLs1TQDW
 WkBFlqjE8P2VQpQL6fKafAUaCF9E7M2tOZ1EoBgmImeiY9dRXmkRFBdXTXvP0e1AL2cr87xyo
 Oby+jgO7Y+CCCtJVF5+vhj/IQ/c2FKKDeM/lGGc1mVbnHN3s5v+dmefXUx/f53fSnUCDpwj38
 cLEj7TKTHN25Pz2XMNTZBUUnc47fVQpPYUH2kFIi8SqMilzdPnoEZAsuPBNEulVo8N3HnYfQv
 ZA5w9feINNZETGkQS9SqXctXrJY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mHUblShxIQCLrkNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 04:25:19AM -0800, Joe Perches wrote:
> On Mon, 2023-02-06 at 12:54 +0100, Geert Uytterhoeven wrote:
> > Hi Joe,
>=20
> rehi Geert
>=20
> maybe:
> ---

At a quick glance, this looks reasonable to me. Feel free to take over
the patch and send a real v2.


Thanks,
Jonathan


>  scripts/checkpatch.pl | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bd44d12965c98..55267ee6b1190 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -36,6 +36,8 @@ my $showfile =3D 0;
>  my $file =3D 0;
>  my $git =3D 0;
>  my %git_commits =3D ();
> +my $git_sha1_min =3D 12;
> +my $git_sha1_max =3D 14;
>  my $check =3D 0;
>  my $check_orig =3D 0;
>  my $summary =3D 1;
> @@ -1230,7 +1232,13 @@ sub git_commit_info {
>  		 $lines[0] =3D~ /^fatal: bad object $commit/) {
>  		$id =3D undef;
>  	} else {
> -		$id =3D substr($lines[0], 0, 12);
> +		my $len =3D length($commit);
> +		if ($len < $git_sha1_min) {
> +			$len =3D $git_sha1_min;
> +		} elsif ($len > $git_sha1_max) {
> +			$len =3D $git_sha1_max;
> +		}
> +		$id =3D substr($lines[0], 0, $len);
>  		$desc =3D substr($lines[0], 41);
>  	}
> =20
> @@ -1297,7 +1305,7 @@ for my $filename (@ARGV) {
>  	if ($filename eq '-') {
>  		$vname =3D 'Your patch';
>  	} elsif ($git) {
> -		$vname =3D "Commit " . substr($filename, 0, 12) . ' ("' . $git_commits=
{$filename} . '")';
> +		$vname =3D "Commit " . substr($filename, 0, $git_sha1_min) . ' ("' . $=
git_commits{$filename} . '")';
>  	} else {
>  		$vname =3D $filename;
>  	}
> @@ -3191,7 +3199,7 @@ sub process {
>  				$tag_case =3D 0 if $tag eq "Fixes:";
>  				$tag_space =3D 0 if ($line =3D~ /^fixes:? [0-9a-f]{5,} ($balanced_pa=
rens)/i);
> =20
> -				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{12}$/i);
> +				$id_length =3D 0 if ($orig_commit =3D~ /^[0-9a-f]{$git_sha1_min,$git=
_sha1_max}$/i);
>  				$id_case =3D 0 if ($orig_commit !~ /[A-F]/);
> =20
>  				# Always strip leading/trailing parens then double quotes if existing
> @@ -3208,7 +3216,7 @@ sub process {
>  			if ($ctitle ne $title || $tag_case || $tag_space ||
>  			    $id_length || $id_case || !$title_has_quotes) {
>  				if (WARN("BAD_FIXES_TAG",
> -				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"=
<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr) &&
> +				     "Please use correct Fixes: style 'Fixes: <$git_sha1_min to $git=
_sha1_max chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\=
")'\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] =3D "Fixes: $cid (\"$ctitle\")";
>  				}
> @@ -3300,9 +3308,9 @@ sub process {
>  		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
>  		    (($line =3D~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
>  		      ($line =3D~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $r=
awlines[$linenr] =3D~ /^\s*[0-9a-f]{5,}\b/i)) ||
> -		     ($line =3D~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
> -		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
> -		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
> +		     ($line =3D~ /(?:\s|^)[0-9a-f]{$git_sha1_min,40}(?:[\s"'\(\[]|$)/i=
 &&
> +		      $line !~ /[\<\[][0-9a-f]{$git_sha1_min,40}[\>\]]/i &&
> +		      $line !~ /\bfixes:\s*[0-9a-f]{$git_sha1_min,40}/i))) {
>  			my $init_char =3D "c";
>  			my $orig_commit =3D "";
>  			my $short =3D 1;
> @@ -3340,11 +3348,11 @@ sub process {
>  			if ($input =3D~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
>  				$init_char =3D $1;
>  				$orig_commit =3D lc($2);
> -				$short =3D 0 if ($input =3D~ /\bcommit\s+[0-9a-f]{12,40}/i);
> +				$short =3D 0 if ($input =3D~ /\bcommit\s+[0-9a-f]{$git_sha1_min,40}/=
i);
>  				$long =3D 1 if ($input =3D~ /\bcommit\s+[0-9a-f]{41,}/i);
>  				$space =3D 0 if ($input =3D~ /\bcommit [0-9a-f]/i);
>  				$case =3D 0 if ($input =3D~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
> -			} elsif ($input =3D~ /\b([0-9a-f]{12,40})\b/i) {
> +			} elsif ($input =3D~ /\b([0-9a-f]{$git_sha1_min,40})\b/i) {
>  				$orig_commit =3D lc($1);
>  			}
> =20
> @@ -3355,7 +3363,7 @@ sub process {
>  			    ($short || $long || $space || $case || ($orig_desc ne $descriptio=
n) || !$has_quotes) &&
>  			    $last_git_commit_id_linenr !=3D $linenr - 1) {
>  				ERROR("GIT_COMMIT_ID",
> -				      "Please use git commit description style 'commit <12+ chars of=
 sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'=
\n" . $herectx);
> +				      "Please use git commit description style 'commit <$git_sha1_mi=
n to $git_sha1_max chars of sha1> (\"<title line>\")' - ie: '${init_char}om=
mit $id (\"$description\")'\n" . $herectx);
>  			}
>  			#don't report the next line if this line ends in commit and the sha1 =
hash is the next line
>  			$last_git_commit_id_linenr =3D $linenr if ($line =3D~ /\bcommit\s*$/i=
);

--mHUblShxIQCLrkNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmPiZEgACgkQCDBEmo7z
X9t62Q//UdgHWYcEJttPbyDDm17nSZqa+x9zIQ5dudVZ5iEC2PDGLHZop1MN5JaA
xVbhChDSC3deG7q7coizb9+vPDJPjoXAaCESsbVI/J2SVWOvKg/P43/11kEJzrex
8/q9e5M1Wp6skzzd/gopAP1s1knpp/GrXoAVaG0tcCdqx506IUIFePQcU5ExCRk2
7ud7Jqz7KDEXGg4Dt20PcB1VqYhkIeZjcNBoFXtw0grHdsAorGPT8uDvvg3mSW3E
nshJnKk7vl+Lt6wYIv/15ahc66WjIibFKl8t/7sp0NdEjdIDj5VSnl+7lTDxKZrF
Y0KkSXpjh3/tGdAi4RnDPzkaNFyOEzvwxVABf1pDheIvvcIVo5XVqLrzlJ4tDj6T
UJKbpZb229DVpaIyWjq3UVVvSKSGCbKJ6Q9BXrVsv0wDtV61Uj2vp4/GbpeGmKL4
kKLRknRobf5AYoRDylCW1APQFU1MSnsz9w72FLkKScbP+VRtykT6gJfeFCl8oott
JwI97+S8ZaDDavrDAn2IGwxJ8PmQtsXW7MnOHnPyuB70OtFOT9VBpxugSfn+iT3w
dZKOW5S0DzAH5tMjBxIm59G97VZBvUJJRQmSB/ks87UI/sHhsE9w/c+Zv3Bfpaph
EP+uXMgHrPLMSx6yXsX2e148qnr1vCQRJcxkjh7tQ9IOMiiq+AI=
=hAIe
-----END PGP SIGNATURE-----

--mHUblShxIQCLrkNy--
