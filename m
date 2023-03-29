Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027656CF3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjC2UC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjC2UC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:02:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CEE126;
        Wed, 29 Mar 2023 13:02:50 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.96.253]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeCxj-1qGP3A1O91-00bHfd; Wed, 29 Mar 2023 22:02:23 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 773E53C07B;
        Wed, 29 Mar 2023 22:02:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1680120141; bh=84G13KGf0S3haP/PaVBEgLLnNP1CV5H5DLxOLq0RpgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3BbnXyomrKbcPHOWZe6DJk0K8ksdjAG5NsImVKCrzLyBz73t8cYa/3e0sG3P70/7
         d3dfnGHPotQOFiJbGS+1lbGqt+fyzFmDcWPF3auLUP2oKlavEmSupHVH2pTHTGufUN
         uZAAOFSOds1kcndOae7lq+dKnL2NyaQcbFTBcREY=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id E0468210; Wed, 29 Mar 2023 22:02:20 +0200 (CEST)
Date:   Wed, 29 Mar 2023 22:02:20 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: fix package build error due to broken symlinks
Message-ID: <ZCSZTLjhLshLBKWM@bergen.fjasle.eu>
References: <20230325141909.2512452-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1uuWaD320kt9WZSJ"
Content-Disposition: inline
In-Reply-To: <20230325141909.2512452-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux 12.0
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:aFPjbh+dtcyTDl68dBPv2zvHvcV+f9FAJsYe2ScMv9UBkhabhij
 jykcSk2AfsOWmcGp208BKbQebToKX89Oce8lKH//e9SqB5TVIY2bEqdUKHmE7wSlt8TF/Dt
 IsWDjJA4Gn8H4AvgWoCcYRArJfoWPokef+rE0x+2n9QsuETvTpUnaUzbmeRTSyLTEtXpXc3
 6cK5X0vmf/nwjyt/HfNYA==
UI-OutboundReport: notjunk:1;M01:P0:Lc0KRV6t7FQ=;TFli5q8I+0u4yI76NlOQRoER2MG
 UbqFdSTioqrzGxqoB75W6EltW6VUkCx9wALCeXxBmcxvYqcdR7i2YqJ49slufCCH6RnIUD6kd
 EQ35bLQb1UXPmjAXdZXSaSWtyAsaRqZiv1VtT3x4kyjLPxC3idZuNl+di4L2X0LVkzxT+hp7M
 cWMbk4vyTNERwZiSQ0tclSavk2uNODnwNZL8sQ/UXLPW3tpBBL2CP6TjtErIhB3OIcGqd6jkb
 Lp9+/3F2WQjpGQqDLtyd2nxMtPZ0U5j66bcWAfAxRdLEoL0TKtrIpdfBsbJQuk+hj+2YeGZle
 61Yc/j9D+5yjb1A4Tq8+8SAGHo6rWaMY2xRgayLx60hk9nMJlT3LVkxOGtfbv5gVxND8nK4rw
 mP/4HioLYEkqGfqbpAXyLwaQgxu1QlTgyn1Jfdd/IbqlUsCi3iDw86W9SfA1Dv6Ktpb5io1xd
 warnSPuLpkEozWY6X712FAv092eJC4iSqYSJbiCbQ2CqiTNO37r0H1CPYIUaFzgevxZi1eYhl
 bHuVrTwvAE3MBCETc5CsMmxO2A2rMVd7EYn8ozM2GupIDioBVsOEoUNukeEsgeeHWxjw5Tngx
 UFH8s19YmhCMFdLOBVnbNhW3rnOsLs3Thu7GsorMnwcxvVkfWOxlnvjmYwd+K4c5C3BhRxHeK
 OKRb/PkyO/UtSI7SPuwTrlXLRvC9z6myOXx+oAV8kw==
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1uuWaD320kt9WZSJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 25 Mar 2023 23:19:09 GMT, Masahiro Yamada wrote:
> 'make deb-pkg' and 'make rpm-pkg' fail if a broken symlink exists in
> a dirty source tree. Handle symlinks properly, and also, keep the
> executable permission.
>=20
> Fixes: 05e96e96a315 ("kbuild: use git-archive for source package creation=
")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/package/gen-diff-patch | 36 +++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>=20
> diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-pa=
tch
> index f842ab50a780..23551de92e1b 100755
> --- a/scripts/package/gen-diff-patch
> +++ b/scripts/package/gen-diff-patch
> @@ -23,16 +23,34 @@ fi
>  git -C ${srctree} status --porcelain --untracked-files=3Dall |
>  while read stat path
>  do
> -	if [ "${stat}" =3D '??' ]; then
> -
> -		if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
> -			! head -n1 .tmp_diff | grep -q "Binary files"; then
> -			{
> -				echo "--- /dev/null"
> -				echo "+++ linux/$path"
> -				cat .tmp_diff | tail -n +3
> -			} >> ${untracked_patch}
> +	if [ "${stat}" !=3D '??' ]; then
> +		continue
> +	fi
> +
> +	if [ -L "${path}" ]; then
> +		{
> +			echo "diff --git a/${path} b/${path}"
> +			echo "new file mode 120000"
> +			echo "--- /dev/null"
> +			echo "+++ b/$path"
> +			echo "@@ -0,0 +1 @@"
> +			printf "+"; readlink ${path}

Better quote "${path}"?

> +			echo '\ No newline at end of file'
> +		} >> ${untracked_patch}

Here quoting should not be necessary as mkdebian and mkspec give only=20
save filenames, but for consistency I'd quote ${untracked_patch} as=20
well.

> +	elif ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
> +	     ! head -n1 .tmp_diff | grep -q "Binary files"; then
> +		if [ -x ${path} ]; then

Same here.

> +			mode=3D100755
> +		else
> +			mode=3D100644
>  		fi
> +		{
> +			echo "diff --git a/${path} b/${path}"
> +			echo "new file mode ${mode}"
> +			echo "--- /dev/null"
> +			echo "+++ b/$path"
> +			cat .tmp_diff | tail -n +3
> +		} >> ${untracked_patch}

And possibly here?

>  	fi
>  done
> =20
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--1uuWaD320kt9WZSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmQkmUYACgkQB1IKcBYm
Eml5ew//Wg16jiGOTJdUJ5WhRk1FaKp6WOqDNex6tstFAlYJkC8KzMcsu+BIStyy
FPoKdcbDTGKRE6YnhaRZs3iVD+wZwLsds1GA2t4hnIWdlZOvkdl7QUeO5t9GARhI
5leruyIWkzLbp3Kpo62UJMZQzgQ0j1oPaYsE/guNBj5pLvZqvLFgKt6Pbb0STlL2
skiTaC6gH00iLny/ikMzaFo5ZkOCzhHc7mIdO7S+6cZlDXCa6j4eidRmmHuGx3nl
B9eCNZ4+X51Y6LhtQIxNxgYVCERdp7ruFLbgk+5AtQFT2rFoOax3alJ4an7gIUAR
ktXFaxIq/hCGZIYai8mLI4jsUdejEGXgHstpiyWvd5iLXiyvWm67evTPUpKomSEH
AwxFNvanNMbK6d9KcCUoEa1Wj8I1GIGF0UykG/HRU4kvVQNeLgroj3cfzz8rAYRF
z6B+QcmGSnCN4bz6KTDPbT9qjtzoyay6MKKYpFzxGDuUglelRL0OLyLPs7WY3GoY
6LrEorhhBzTOh5Y1ktt4JBKmE8KSVitF/suRFN6SVMJBvaSDZnFbBHyKC5V0RE3E
KQCkhcnGzRLfTkL06xa6OEmkYkOw18kYGsarIDsF5qupUQccBRVz3+BXpPJfd900
QWT7rc2pXKtnYwaJ3KI5b46iT2ffbcsvB5U3HbuLC6gWFuJDJ3Q=
=n7Vx
-----END PGP SIGNATURE-----

--1uuWaD320kt9WZSJ--
