Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670BE6801A7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjA2VhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjA2VhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:37:01 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB041630F;
        Sun, 29 Jan 2023 13:36:53 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.220]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNHa-1omuRz1Bgm-00ZNFJ; Sun, 29 Jan 2023 22:31:19 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 517F53C015;
        Sun, 29 Jan 2023 22:31:18 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 08BE0AFF; Sun, 29 Jan 2023 22:31:13 +0100 (CET)
Date:   Sun, 29 Jan 2023 22:31:12 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 3/7] setlocalversion: make indentation shallower
Message-ID: <Y9bloPVG++Vk2Exz@bergen.fjasle.eu>
References: <20230122141428.115372-1-masahiroy@kernel.org>
 <20230122141428.115372-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tAQ6zxKoh4N3MN95"
Content-Disposition: inline
In-Reply-To: <20230122141428.115372-3-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:P2uiDCG9TUNAkjjaBbcRzuw70DBYA0CJDLdTQGlSq1H5cprPERQ
 QdLYeVCjjA4YzKK+z2u361V5kNHUfWNnK9O9eYNefa2xtx1KwV3zInmmhGxWWZxshxULyc9
 o2EqyN05tqHl8+BOBRkocrsI3L2kZLG57WpWfRAlom3vAOkXTEjZ2i8JROVE15U5XrUGrhX
 hHn0ePDZKFKdbC9nGrrwg==
UI-OutboundReport: notjunk:1;M01:P0:v0S25payN+c=;tUaUN4cf2EeKGB0o6NXxYCOIrHT
 xYT25i6cAcMSM1OqWu+chBCDxy8djYVp9UZhqVCwzNoHK/WbHiXxzRl8yqkgLEutqFXuFbx9I
 vDUxomyW1T1k8GNGm8/AqBJ6P8LsQh8CJgs3StT1h9e3Oc5kBrU46IUuEqyoqO3DGohFqiK/r
 lYTUBR9uu9n05zSUo7wK034reVGUhIgGdqxzT5DhVuPZhPSZ/ndlWdfmEW5QG89+OFGJ+Xmy7
 i6zSBAvhsaTiaSbpwi3v0RWbaXPkGRoaBTMZhTYtGmw3ofqYPu9NF3P5Qu6JDIgjEcWVjoAnf
 Ahy4vpejEedwc6T5ts1dNcljCJ5OuBypP2IV0DVVqi6kG0kP7cV6n/ioz+GdJcRoHctBo8sN7
 jmfzXFRyVdv4pmL0OOBWYfd9k31jECxP0L70VGz2PX1zCGZHZ0rA1Dv8i+yL89dclMSn1LPCM
 rIkuItxsCmD7lBGPEF1gu7TsI+GlY8mTw9B0w/xDHOj8yxBZsKMQ1DncRHi7ynZU/XUbNEgzJ
 Ns2I0JRqR3f7uoAFSDA2mHxsTYZQidBGsp0I5CXcxdwq/G1Z4sRrmpkcLconyYq8kZx0bu1ue
 eDRX09iMUk0zgRkYz4M9OSXom7oEx6T/zRf2QRJF4RojbmY8w1LRXW0+oWqNTj98Ciu4QOoel
 IXYNiJDGff/gT2nyoqUXQSsTEPDCMaW6f+ragzqyNg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tAQ6zxKoh4N3MN95
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 22 Jan 2023 23:14:23 GMT, Masahiro Yamada wrote:
> Return earlier if we are not in the correct git repository. This makes
> the code more readable.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/setlocalversion | 79 +++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 38 deletions(-)
>=20
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 5cdf409204aa..b8e1018d611e 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -34,46 +34,49 @@ scm_version()
>  		short=3Dtrue
>  	fi
> =20
> -	# Check for git and a git repo.
> -	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
> -	   head=3D$(git rev-parse --verify HEAD 2>/dev/null); then
> -
> -		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
> -		# it, because this version is defined in the top level Makefile.
> -		if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
> -
> -			# If only the short version is requested, don't bother
> -			# running further git commands
> -			if $short; then
> -				echo "+"
> -				return
> -			fi
> -			# If we are past a tagged commit (like
> -			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> -			if atag=3D"$(git describe 2>/dev/null)"; then
> -				echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
> -			fi
> -
> -			# Add -g and exactly 12 hex chars.
> -			printf '%s%s' -g "$(echo $head | cut -c1-12)"
> -		fi
> +	if test -n "$(git rev-parse --show-cdup 2>/dev/null)"; then
> +		return
> +	fi
> +
> +	if ! head=3D$(git rev-parse --verify HEAD 2>/dev/null); then
> +		return
> +	fi
> +
> +	# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore it
> +	# because this version is defined in the top level Makefile.
> +	if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
> =20
> -		# Check for uncommitted changes.
> -		# This script must avoid any write attempt to the source tree,
> -		# which might be read-only.
> -		# You cannot use 'git describe --dirty' because it tries to
> -		# create .git/index.lock .
> -		# First, with git-status, but --no-optional-locks is only
> -		# supported in git >=3D 2.14, so fall back to git-diff-index if
> -		# it fails. Note that git-diff-index does not refresh the
> -		# index, so it may give misleading results. See
> -		# git-update-index(1), git-diff-index(1), and git-status(1).
> -		if {
> -			git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> -			git diff-index --name-only HEAD
> -		} | read dummy; then
> -			printf '%s' -dirty
> +		# If only the short version is requested, don't bother
> +		# running further git commands
> +		if $short; then
> +			echo "+"
> +			return
>  		fi
> +		# If we are past a tagged commit (like
> +		# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> +		if atag=3D"$(git describe 2>/dev/null)"; then
> +			echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
> +		fi
> +
> +		# Add -g and exactly 12 hex chars.
> +		printf '%s%s' -g "$(echo $head | cut -c1-12)"
> +	fi
> +
> +	# Check for uncommitted changes.
> +	# This script must avoid any write attempt to the source tree, which
> +	# might be read-only.
> +	# You cannot use 'git describe --dirty' because it tries to create
> +	# .git/index.lock .
> +	# First, with git-status, but --no-optional-locks is only supported in
> +	# git >=3D 2.14, so fall back to git-diff-index if it fails. Note that
> +	# git-diff-index does not refresh the index, so it may give misleading
> +	# results.
> +	# See git-update-index(1), git-diff-index(1), and git-status(1).
> +	if {
> +		git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> +		git diff-index --name-only HEAD
> +	} | read dummy; then
> +		printf '%s' -dirty
>  	fi
>  }
> =20
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--tAQ6zxKoh4N3MN95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPW5aAACgkQB1IKcBYm
EmmiuQ//f8/tfLu14M2PSEM7jEus0XAyx5BbICT3xrhHSnY7LCmX/KqgU9yAkyuu
H4qIqzkQgtRH+P0NYT4iAqgpq4wzBkYiwuK/N5oaLs8yxC9mjleLBX3a99R1lP4H
aX6FO8L9WNaed/KUmUVTayejb6YABp8ANLVq7ZQQr9wbJn+F1SjQQft2nYfIHoS2
neJBtr7PsZAvVURIqFZ3qbn4lxvFpXpAmiVwty5A9sCxlBl9uia1aPeH10GB22kj
G+BOYbbUrNNYNQq/WcotyktGvnuLjI5KB/RgoNQwrVOB+53Tu+7ap0/4wcen6irF
JVH8hnDcDgLHJrX2HwCV7ntAaU44WEg/vRdH1y31jcLvmLbJaPHjieyz9XrKzV9A
+ogT05Ps3nqbQGBZf86uSh22iDlcg0dx5hYjZcVZTYuPphod6wX1IfSvVPThuJC4
QR6g4pwV0SMBImNtsrYcXrxLEOCCMjttQa71tPSVJPQ/pSKlq8JFv/5gsrkxY+ee
cySM17gb+M5grLVqVM6p8vg8Q3tbCEK2K8/DbyRPylk3sJUqaBF5fRVARnNP2VzR
KiYjGMi2AqArb6m+llzzZUaJjpuOjiwWCsRHXxYU/nj+V8YUQsNqeCEzqblisCNn
ffvWJg8sB8JiYpMZsRBgyOJeOhKqIJW3v5Mi/REDNYJIEOXbdDk=
=iZPX
-----END PGP SIGNATURE-----

--tAQ6zxKoh4N3MN95--
