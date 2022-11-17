Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F90A62E628
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiKQUxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:53:21 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E17EC93;
        Thu, 17 Nov 2022 12:53:13 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.117]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCJzI-1omSOi2BT0-009QOB; Thu, 17 Nov 2022 21:47:10 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 71B6D3C0EE;
        Thu, 17 Nov 2022 21:47:06 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 115573F8; Thu, 17 Nov 2022 21:47:03 +0100 (CET)
Date:   Thu, 17 Nov 2022 21:47:02 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/3] kbuild: add kbuild-file macro
Message-ID: <Y3adxuxz5kLcYuKu@bergen.fjasle.eu>
References: <20221113111525.3762483-1-masahiroy@kernel.org>
 <20221113111525.3762483-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YNAOpTOMhEpbU/4w"
Content-Disposition: inline
In-Reply-To: <20221113111525.3762483-2-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:McLy0KI7sU/zsSU73G3/J7VLOD8WkbCkUcNidtFwGll41E4d+0G
 w2pXfJKz3BD989ceh0Q8LFIrKtpKkZh7oBaUgqpa5ykZgLDu6HYPvxUTC5wSsGyEWdTZPkN
 qjTGTn8laxeTUwHngITSQx7GvAriLRGFqEgi1mDWKc/A11u115xDymbQLna3cRbtjVDRBDO
 TxU1tzJMV3Nuy6V5r73Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GHUJXAwkD7k=:w1BPCDuQgCp/je9p502LOw
 f2aEDXt3kh+oppVrfuWKuJqjl4+n1sti9DHQQ/zAZpZuj6hj958iUXDJmAVD18kyBhtaVhCPk
 ey6hciShDR7ArOpjTAiWPM8ZFTYU8bjKgKiOQS3PxAt8g53A2xI40CRCSdpAu7W88VZR/q4SE
 NkToshxAWoR81WCqsYGKPD4IyDWraSKc2p33nIAFXEbCJ7AVSBJMoWt+Zg9tFrZsWyMhSIRpv
 Wb/ZdeUnP4/LRgpWDCBBvyfqLqZ3l2ogFs8ruewHyyWWThGR5oSnevC4n2OzqvuGkyG8ivgXs
 dq2R8+5pDOGZ8VTm6rYCmBe61OwxIUurapyWGh4PBVbFOLiDrxaak3UxQt263O0h7VukVlXjZ
 ES2mSpMNpvTCsvVhyqgQs+wOLdgoXsdV/66/ZHJ+mpbtEqJD6o769ZYn+nn1ewnKvqRFTcqhr
 SpIE9OveEbBQ36Iytemztd8AYpmJPOLwIGmWiIXsJ8+Shn1Hn3VNqNfNQnDUPHcgMacAe6oz0
 rHbzF80WmZRPDCqczKihjtgcFMNJzJvK3bDdcnrP2+c3bPen35sdzEjIZ1zEM5ITAgt/1QYYq
 Aqds7RQotQt+uyqfzHtzA9JqI4HdvjIP5K+P8YVVS+7Hvn0TugU8Fm4bgklysMUp3G8m8eeev
 EWrsrkJqVwwUcvvRaFpyLAHYIaenVXvdVmkW7p7REgqPFPxm4kTwTJAcIyEeFkkNw2zQp1DbP
 InEKi9o3MIqyRoCpZOQ7ydwXf6A5NSsMTp8aXXksnymZ/9EZGo5AIto/N9DZTHWOlGHUEAJUZ
 PWgmqRC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YNAOpTOMhEpbU/4w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Nov 2022 20:15:23 +0900 Masahiro Yamada wrote:
> While building, installing, cleaning, Kbuild visits sub-directories
> and includes 'Kbuild' or 'Makefile' that exists there.
>=20
> Add 'kbuild-file' macro, and reuse it from scripts/Makefie.*
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  scripts/Kbuild.include       | 5 +++++
>  scripts/Makefile.asm-generic | 6 +++---
>  scripts/Makefile.build       | 6 +-----
>  scripts/Makefile.clean       | 5 +----
>  scripts/Makefile.dtbinst     | 2 +-
>  5 files changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 2bc08ace38a3..cbe28744637b 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -40,6 +40,11 @@ escsq =3D $(subst $(squote),'\$(squote)',$1)
>  # Quote a string to pass it to C files. foo =3D> '"foo"'
>  stringify =3D $(squote)$(quote)$1$(quote)$(squote)
> =20
> +###
> +# The path to Kbuild or Makefile. Kbuild has precedence over Makefile.
> +kbuild-dir =3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> +kbuild-file =3D $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Make=
file)
> +
>  ###
>  # Easy method for doing a status message
>         kecho :=3D :
> diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
> index 1d501c57f9ef..8d01b37b7677 100644
> --- a/scripts/Makefile.asm-generic
> +++ b/scripts/Makefile.asm-generic
> @@ -10,15 +10,15 @@ PHONY :=3D all
>  all:
> =20
>  src :=3D $(subst /generated,,$(obj))
> --include $(src)/Kbuild
> +
> +include $(srctree)/scripts/Kbuild.include
> +-include $(kbuild-file)
> =20
>  # $(generic)/Kbuild lists mandatory-y. Exclude um since it is a special =
case.
>  ifneq ($(SRCARCH),um)
>  include $(srctree)/$(generic)/Kbuild
>  endif
> =20
> -include $(srctree)/scripts/Kbuild.include
> -
>  redundant :=3D $(filter $(mandatory-y) $(generated-y), $(generic-y))
>  redundant +=3D $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$(s=
rc)/$(f)),$(f)))
>  redundant :=3D $(sort $(redundant))
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 41f3602fc8de..37cf88d076e8 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -38,11 +38,7 @@ subdir-ccflags-y :=3D
> =20
>  include $(srctree)/scripts/Kbuild.include
>  include $(srctree)/scripts/Makefile.compiler
> -
> -# The filename Kbuild has precedence over Makefile
> -kbuild-dir :=3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> -include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
> -
> +include $(kbuild-file)
>  include $(srctree)/scripts/Makefile.lib
> =20
>  # Do not include hostprogs rules unless needed.
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 878cec648959..3649900696dd 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -9,10 +9,7 @@ PHONY :=3D __clean
>  __clean:
> =20
>  include $(srctree)/scripts/Kbuild.include
> -
> -# The filename Kbuild has precedence over Makefile
> -kbuild-dir :=3D $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
> -include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
> +include $(kbuild-file)
> =20
>  # Figure out what we need to build from the various variables
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> diff --git a/scripts/Makefile.dtbinst b/scripts/Makefile.dtbinst
> index 190d781e84f4..2ab936e4179d 100644
> --- a/scripts/Makefile.dtbinst
> +++ b/scripts/Makefile.dtbinst
> @@ -15,7 +15,7 @@ __dtbs_install:
> =20
>  include include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
> -include $(src)/Makefile
> +include $(kbuild-file)
> =20
>  dtbs    :=3D $(addprefix $(dst)/, $(dtb-y) $(if $(CONFIG_OF_ALL_DTBS),$(=
dtb-)))
>  subdirs :=3D $(addprefix $(obj)/, $(subdir-y) $(subdir-m))
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

What do you think about using $(kbuild-file) also in Makefile.modpost?


diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -93,7 +93,7 @@ obj :=3D $(KBUILD_EXTMOD)
 src :=3D $(obj)
=20
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
-include $(or $(wildcard $(src)/Kbuild), $(src)/Makefile)
+include $(kbuild-file)
=20
 module.symvers-if-present :=3D $(wildcard Module.symvers)
 output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers


Kind regards,
Nicolas

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--YNAOpTOMhEpbU/4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN2ncYACgkQB1IKcBYm
EmlKIRAAx7HxYpsbRW+pUUjWlFp63VKAaHVQ/Pee3Kx1goTL+PG+/yjBEYewNTEu
pbKV5smfCPTpDivE6a9TDHa7OgESONN5XL10PtF1w03NQHolgnaY/uCVXvp1zpo7
baGinGgZjHgmteCf9koEGzxUJG3U37ze++JC5a4RIAY3x66okZumikQC+yBMgB1m
FDlm/m6IV25f4g5uNkOX6GMg+rP5FBJJW7x3YQK0n3JJ3RvqSG8mb0gSxu7KYBGI
tyooDvOJLdL1y4ptt1Hq0Thwo77SXriZZShnCqf+uTl9BIuejE28S/Pi2EhYIPJm
DC1jgdT8wcPsa8KSXaF2/DqFIWpp7/E03LQYnJ2juxPjFb+mZuycwKCnnS0SR2pC
zEtMI4YcvRIImvDDU8ncemgnAFy423ekJh5cqfHT1RXNioGKL/hOxm2a2QqxpcQJ
g3jkKWs3K42p8v+IXAWfBAxNOKYe+gCmXBlIYdJOKNCdQith4UG+QWH+jBHJvKy8
RRVrrStSxnM6JzWeN1V4sy0/qBMWyPeCGpBRphbzJ4PAUpewnFv6LIBvNeJCLpLV
etXpPL45N89X/9QlwQdL++KQak/DozJW1chv4UltKgJOlQQfJXsqH0NAth/enrYV
/ou+c2/Cs7vpO2hTsG/9frwhqNyOtofZgjdZh4Aczzvpj2oFomk=
=p0DK
-----END PGP SIGNATURE-----

--YNAOpTOMhEpbU/4w--
