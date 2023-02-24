Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E926A247D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBXWtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjBXWta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:49:30 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D70686BA;
        Fri, 24 Feb 2023 14:48:58 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.255]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Macaw-1ouy8g3lWc-00c9bU; Fri, 24 Feb 2023 23:48:32 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id CE7EA3C1C6; Fri, 24 Feb 2023 23:48:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1677278911; bh=vrUhpplmDe5TxJLS1RzpU1pDGFYh/NUf2vbwea/IFfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6E/p9TuNNggPFPNGpz3Ael82vRAcLa0wtd1wTjzOLw3+EDvB8Xo59hbGQklDOu85
         N1JFJQ0tX4mirBq4kvYr8OzEoux5xHsnwPLtb1UyUiaqbFhD2ylx0G4TfXgtBdhZU8
         kru6g75athzw7mGvNy0UqYbWg994QE3JZXPo4IDo=
Date:   Fri, 24 Feb 2023 23:48:31 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 12/12] kbuild: add srcdeb-pkg target
Message-ID: <Y/k+v/Yj8VQ6q32H@fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-12-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xyhkELFYzeT9W8Br"
Content-Disposition: inline
In-Reply-To: <20230215012034.403356-12-masahiroy@kernel.org>
X-Provags-ID: V03:K1:imxum19Ju3OgbdZ8gxTd262nAFzCaj7lC/BMt9NaZKV5WGyzJR+
 zskFnOlJtvpp0ScIpijmIVxW+2Jn/JACciH932tAmlgo1PVgVDPe4DeFAzwQ1uPfSldWfgp
 4qxnsTHIJ5CdCSH6uW/37lWiGWGLHw/QVVpx7b9B7G281PBqy17hnUVX9Wm0nL9tkeN2KPG
 0dSTnTb+8QHCkaE2KgsHQ==
UI-OutboundReport: notjunk:1;M01:P0:ATLNQKD3FWI=;Cc1DROFjxJRj1LbyYY8jSHcVqxs
 f/lgGutPPI6/x4wufpi7e5ND2YBujAIUxTr/hjB0TSFYsCf2nXrFoWOss+J/+lh/zyg0DYKpt
 S1P1lFcop4/D6tMcFbVeLUWsiyEX9LOIZNfbyMOjG5ckKu7JcDlNw6DDVd51M+B35VtNpRc3h
 1eu/qNE3jX9ZKGwu588vqGZCewdH4V+vq5usza+mt0RhEOnX8GnPAmdAeckf4nk1DdN5PEji5
 kschtnN+Lcpf62cf5gFFN7DUGkabtFCEBr1tOHAEw5jHB1D9Vry/dit0KcfpivphFq6qXix/M
 Ep8/85JJFicznbNJEHzUEb1uS1u2g5ODNDigcsjH08b6hzYcTOTgJc7JtAV3U8PPKxN4VbVo4
 t5ippFYAO3wF9tzHGCumamLCM2LhHn3BgzKutcPfSwrF+ftiogGFo5OcPDSbojUCpEfPWQSBK
 dHs+WRq8Bixn8kSAXsVAZqY3rlVs8TIOZPh8zpH4/fk/m9Lfq2s6CEK+nGdZWPC8A3BUdJfGy
 zqtSApE7ApBryXGAa7AI1TsAKl3n0xshWZn+hAeHWW0HyqvdYQ59LyMZP4giUoVLVdi3DYRj0
 Wga8dPJqRG3QzRkCdN+djVGdCrBUPLSKf/UpsUzcliZdzvkZZZNoolMuz4wdJGocClbK62BrS
 T1A6u/pdW4D7T6jzoyHtgPG+3jJkbDstYfyArJRkBg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xyhkELFYzeT9W8Br
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:20:34AM +0900 Masahiro Yamada wrote:
> This new target builds only the debian source package.
>=20
> Factor similar code out to the 'build-deb-pkg' variable.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v6:
>   - New patch
>=20
>  scripts/Makefile.package | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index b941e6341b36..8650d9432c26 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -100,6 +100,9 @@ binrpm-pkg:
>  	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
>  		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
> =20
> +# deb-pkg srcdeb-pkg bindeb-pkg
> +# ----------------------------------------------------------------------=
-----
> +
>  quiet_cmd_debianize =3D GEN     $@
>        cmd_debianize =3D $(srctree)/scripts/package/mkdebian
> =20
> @@ -117,14 +120,27 @@ debian-orig: linux.tar.gz debian
>  		cp $< ../$(orig-name); \
>  	fi
> =20
> +build-deb-pkg =3D \
> +        dpkg-buildpackage \
> +        --build=3D$(build-type) --no-pre-clean --unsigned-changes \
> +        $(if $(findstring source, $(build-type)), --unsigned-source) \
> +        $(if $(findstring binary, $(build-type)), -r$(KBUILD_PKG_ROOTCMD=
) -a$$(cat debian/arch)) \
> +        $(DPKG_FLAGS)
> +
>  PHONY +=3D deb-pkg
> +deb-pkg: private build-type :=3D source,binary
>  deb-pkg: debian-orig
> -	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) \
> -		--build=3Dsource,binary -nc -us -uc
> +	+$(build-deb-pkg)
> +
> +PHONY +=3D srcdeb-pkg
> +srcdeb-pkg: private build-type :=3D source
> +srcdeb-pkg: debian-orig
> +	+$(build-deb-pkg)
> =20
>  PHONY +=3D bindeb-pkg
> +bindeb-pkg: private build-type :=3D binary
>  bindeb-pkg: debian
> -	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) -b -nc -uc
> +	+$(build-deb-pkg)
> =20
>  PHONY +=3D intdeb-pkg
>  intdeb-pkg:
> @@ -225,6 +241,7 @@ help:
>  	@echo '  srcrpm-pkg          - Build only the source kernel RPM package'
>  	@echo '  binrpm-pkg          - Build only the binary kernel RPM package'
>  	@echo '  deb-pkg             - Build both source and binary deb kernel =
packages'
> +	@echo '  binsrc-pkg          - Build only the source kernel deb package'

typo: srcdeb-dpkg

With this typo fixed:
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  	@echo '  bindeb-pkg          - Build only the binary kernel deb package'
>  	@echo '  snap-pkg            - Build only the binary kernel snap packag=
e'
>  	@echo '                        (will connect to external hosts)'
> --=20
> 2.34.1

Thanks for the patch (and the whole patch set), I appreciate it!

While testing, I stumbled over one thing, not really related to this patch:

As tar complains about any kind of tree changes while it creates an archive,
'olddefconfig' and 'srcdeb-pkg' must not be build at the same time.  Is it
sensible to add another 'mixed-build' check in top-level Makefile against a=
ll
target depending on linux.tar.gz?

    $ make olddefconfig srcdeb-pkg -j8
    #
    # No change to .config
    #
      GEN     debian
      UPD     .tmp_filelist
      TAR     linux.tar.gz
    tar: .: file changed as we read it
    make[2]: *** [scripts/Makefile.package:58: linux.tar.gz] Error 1
    make[2]: *** Deleting file 'linux.tar.gz'
    make[1]: *** [Makefile:1654: srcdeb-pkg] Error 2
    make: *** [Makefile:358: __build_one_by_one] Error 2

Kind regards,
Nicolas

--xyhkELFYzeT9W8Br
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmP5Pr8ACgkQB1IKcBYm
EmlO7Q/8CWlqVpr4DJD++xGQ12W6TYFFD7kcu6fHd3jhuK3LUPYcFtPW9zGQIgrl
81vRZ/gP7aTHcEUuUEDr5npmDfmuyTu+8GmRwo7CjE4sGFvKwDcKM6FeHlwst2rE
+WTDPKCRVKenRhoa/CXVIYB0v8mBXQMk7Y3bblSIrUGsLzZNW65greW8bqkX+8JN
+BYXX3MNxBUw1m4W+uux8Lz8kl9wY2g7GcIZooITNaE+iUTtDvlavU/XgNb/t9Gc
uT+DqY0j2ifNoDhNLxnHSndu9oOdqoqMvpjv1Veyqjq/MhkNmSTMiAY/qlmECxIF
66Hr1v1c2VIKn4Wc0A50vTEOjUbdCf/oiIOpSuUTraofkwjwTz36VYTUgWLSATdS
LMbfIKVp9bVHzM/jbgJXlY0Qh7+noLvIrw9oyOPo3YP82csQDzmxVVDS5ckOzIzZ
OPIGWJcJob5JfV3glh+VTSHDy8G4T+q54v2oze5N5YeKZhhu1+ga2zHmRTEqClsU
JVoTbxa3i1nu+VadRMQkX+a7q9voWUJn3Dgd4qSfb3GgXWrVVcPikUNQmN1pMr4W
8I2dL+Dt2zexYUnKWP6USVLnkHL5GYX2YSvq6fMnEgQNapvDFHHFxoMGEUi2ELZt
LOIfaETmHBKXogGpD6Y9W+PvBTYJ9vojzcuKYIqT7Bd78syyrR4=
=0Rbh
-----END PGP SIGNATURE-----

--xyhkELFYzeT9W8Br--
