Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6968018A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 22:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjA2V3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 16:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2V3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:29:49 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8563314481;
        Sun, 29 Jan 2023 13:29:42 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.220]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbAxU-1op7PI31yK-00bbJp; Sun, 29 Jan 2023 22:29:16 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 281563C0EF;
        Sun, 29 Jan 2023 22:29:15 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 377657A8; Sun, 29 Jan 2023 22:29:12 +0100 (CET)
Date:   Sun, 29 Jan 2023 22:29:12 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/7] kbuild: do not put .scmversion into the source
 tarball
Message-ID: <Y9blKNz0ZZbvsMAb@bergen.fjasle.eu>
References: <20230122141428.115372-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghocTM7W3/fNaZNM"
Content-Disposition: inline
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:tAdVXwW8Tj+i3lLQUBqbGFwcIIhHmgIgsCvR9fm1wrDUdSlQzC+
 HTq0m8xE+BQdHDqKloM8sbElXABk2TT+LG6wMggomyNseeCz8xeodEUI4NbBjii4NbAMdIW
 mmEf2EE3rsBoepLqB/9WmgWzeaECOe8aCDR8nKTC/w2dOLOkTqTqvNSGAPzmwUOtbHd8vyP
 gxVWwqZjs93ix6juSnOAA==
UI-OutboundReport: notjunk:1;M01:P0:GW3Itcr4dSM=;uct4H6PaJ8EqaeJrN1IahZKnjCa
 oyNEOPj9j1L66tKcO/uCPzXM8UjPzYXhjzezyqHO0a0/mDB/4JP+mo7PJDKfnS4LAVjAGN94x
 /gqb/9np0AvCmx0MV6B6fLjTX/vYtBEcnsd8AG5qig6OmmKWZNFfEkfHid6pIg45BbVu3j+yo
 xDTFQMKmRQeydfxc5wdWHPuQO5vtyVmC3DMP9O8aWKKvm7ctBPwTnmR7oWO2BJovYXvV/Kra2
 DIfE/CHFY92TVs4d/fY3ueZsAIKr7DVdQyTZlDzyPHBRKCGTAPp5gcOuavvUrFILAbFBdIS3R
 zbH54m6HgsPfO+rEg7Dm9rdQ0ElnzMcee7zILt9iU5tODSamZKJnD00JA1nNdrWYwfYgTw33j
 W6LPkCZeLcEKwmsTznjBZLu/dSfmdqWRxSm+0jrLuRN7D11movgARZlAOcA/8V4g/4NDcQnTv
 WJfVaYNK3lEO96umF+Jq3k+rHfezEtdWyFklDb0gzUPLdzxaUdc7TF+onBRI9iafJFHZtNWwo
 qRIopC1h8EPm8wuwtxcZ/htO04Qh2UrnU0M7C1MP/wnQU5V0oSoZcU/TcqKeOPNnbsR5J7UAs
 Wz1XjEkXXgNcQDVqkHYeIWERZFCYmp66JNWyIQLnP+IfFoxXZsBbVFJYGlrXnMzDYx/X0jUEk
 0wWWNz9apTTWH2EkIgMoPj5pmQJ3nYYDps6vpbiO3g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghocTM7W3/fNaZNM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 22 Jan 2023 23:14:21 GMT, Masahiro Yamada wrote:
> .scmversion is used by (src)rpm-pkg and deb-pkg to carry=20
> KERNELRELEASE.
>=20
> In fact, deb-pkg does not rely on it any more because the generated
> debian/rules specifies KERNELRELEASE from the command line.
>=20
> Do likwise for (src)rpm-pkg, and remove this feature.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Makefile.package |  6 ++----
>  scripts/package/mkspec   |  6 +++---
>  scripts/setlocalversion  | 19 +------------------
>  3 files changed, 6 insertions(+), 25 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 525a2820976f..e84c4e8ceb8e 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -32,7 +32,7 @@ export KDEB_SOURCENAME
>  TAR_CONTENT :=3D Documentation LICENSES arch block certs crypto drivers =
fs \
>                 include init io_uring ipc kernel lib mm net rust \
>                 samples scripts security sound tools usr virt \
> -               .config .scmversion Makefile \
> +               .config Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     :=3D $(srctree)/scripts/package/mkspec
> =20
> @@ -47,10 +47,8 @@ if test "$(objtree)" !=3D "$(srctree)"; then \
>  	echo >&2; \
>  	false; \
>  fi ; \
> -$(srctree)/scripts/setlocalversion --save-scmversion; \
>  tar -I $(KGZIP) -c $(RCS_TAR_IGNORE) -f $(2).tar.gz \
> -	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3); \
> -rm -f $(objtree)/.scmversion
> +	--transform 's:^:$(2)/:S' $(TAR_CONTENT) $(3)
> =20
>  # rpm-pkg
>  # ----------------------------------------------------------------------=
-----
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index adab28fa7f89..d3c6701b7769 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -90,7 +90,7 @@ $S	rm -f scripts/basic/fixdep scripts/kconfig/conf
>  $S	rm -f tools/objtool/{fixdep,objtool}
>  $S
>  $S	%build
> -$S	$MAKE %{?_smp_mflags} KBUILD_BUILD_VERSION=3D%{release}
> +$S	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} KBUILD_BUILD_VERSION=
=3D%{release}
>  $S
>  	%install
>  	mkdir -p %{buildroot}/boot
> @@ -101,8 +101,8 @@ $S
>  	%else
>  	cp \$($MAKE -s image_name) %{buildroot}/boot/vmlinuz-$KERNELRELEASE
>  	%endif
> -$M	$MAKE %{?_smp_mflags} INSTALL_MOD_PATH=3D%{buildroot} modules_install
> -	$MAKE %{?_smp_mflags} INSTALL_HDR_PATH=3D%{buildroot}/usr headers_insta=
ll
> +$M	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} INSTALL_MOD_PATH=3D%=
{buildroot} modules_install
> +	$MAKE %{?_smp_mflags} KERNELRELEASE=3D%{version} INSTALL_HDR_PATH=3D%{b=
uildroot}/usr headers_install
>  	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
>  	cp .config %{buildroot}/boot/config-$KERNELRELEASE
>  $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index af4754a35e66..3b31702b4a4a 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -11,16 +11,11 @@
>  #
> =20
>  usage() {
> -	echo "Usage: $0 [--save-scmversion] [srctree]" >&2
> +	echo "Usage: $0 [srctree]" >&2

Hi Masahiro,

as .scmversion will not we generated (or removed by 'make clean' or=20
'make mrproper'), might it make sense to add it to=20
scripts/remove-stale-files?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

Kind regards,
Nicolas

--ghocTM7W3/fNaZNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPW5ScACgkQB1IKcBYm
Eml+uQ/+Mh9C1sPnM18nwKc3pAZhpImfKMj1VGGpUi3qX9wat2ZBTFMVY6xOyA6O
XGm11iKN6y85ZyNnJwn5ZVvin9ufyVz7uZGypuV42Doa/wvs8jOGcCi5p9ld2nfq
CSDlkk10b6aJbZuIgCeNNn5WBUR2h/mB3MXHH3q/t9RRuaDB2IZtCkclFQXQxvYI
/minLbdYrphkp9BsItjoSToE7FtUP0aMTTo1Z/mREZ6095c/u2g9Z/s+eyD4ydmX
FaR3IubVE7XM92DlyzJh35dlZDolG1Yey49pFu2AuSdmg00ZtYnmjMcGYr13qnm4
9qFrvLEPZR9sE/KufRW6SwMRCL6SpznAfYGk38uM/pMIP3vLOrnlSVm0okObHyu7
a88aV9iD5AvGUJERKXCO9AG8e0aiv/2kpr/Ej87pvG+nJrU7rnyObwEP30iSMmWR
92438eiHTGWfAl/BTJIywkVahCHygzpTyWwdQx15n4vOmpxeBBzl8wRrA+YgmDM3
ShhT4PeESZIreQNIHn9oxeNxmCynj376H2aUcHKDiwLqa2rzbywqU6ch6beQShtm
pbwssS9bM7/XijSJXOuIm/EFhsNM+SxRTHMCxQhqqbpDPXR9qGM3+FuyeO75ktR6
eCamITtfOvNDApIgF6qoLbICha/GjITfi5KpODEVko3Tpg2m/qE=
=vsBm
-----END PGP SIGNATURE-----

--ghocTM7W3/fNaZNM--
