Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C426E6A2450
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBXWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBXWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:34:40 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072AF1B2D3;
        Fri, 24 Feb 2023 14:34:28 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.255]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqsGv-1oj6HP0rzN-00msTJ; Fri, 24 Feb 2023 23:33:58 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id CB2903C1C6; Fri, 24 Feb 2023 23:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1677278037; bh=IzpPdAljP6D+kkXtSu5TE2u6Adkx6xfgEMGoP5a+qDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hlvTdwtA2Wra2Bx+weh8Zx5spiFZVTf3ePpksTXCDoEMuVSjgUzs4B2GjyQ71Tt5L
         kWREvrZ3F5zIiBKbqarb0Pb4ubK8eIC6yC8p5rsmglOcOGIhUqi1R90HBX1cjTIVkx
         pXv/udz9/eUdU3ZZ5j50gA+xExaSf5R6SRkfie/0=
Date:   Fri, 24 Feb 2023 23:33:56 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 05/12] kbuild: deb-pkg: hide KDEB_SOURCENAME from
 Makefile
Message-ID: <Y/k7VA2z6MdgfS/v@fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d+5jJHEioP29KR0F"
Content-Disposition: inline
In-Reply-To: <20230215012034.403356-5-masahiroy@kernel.org>
X-Provags-ID: V03:K1:J+JqGm7lCNUl9/Bv30fi6PMPSlcxNx0rUEdcOSOPCh2nSCdJZN5
 OfpNW4U+ZnWp4HCXF1FRlUs9hjckaSYXz8Ect21wFC6qbB1SUUE9dK6eyLZvR/nUuG4XLni
 D/5SbKMBSX9T11n+D60fADjEIStjknrTMPb7mHBnYBWTwFtLdouUveLsUPbp35Q77rhAvcc
 +K3MTUDwE8+CqUYfs6GhQ==
UI-OutboundReport: notjunk:1;M01:P0:qeAniLkTwCk=;tScqdyJzK3sCMMKHIF2/25cR4Gq
 8hb6Akt65x1pdRy79x9v+zURu/SZrwhoZ5BUSX4XEpVYjvUoGFkyBMvjkZ9c3F+fPYWYM79ww
 s+CU4bPU2GVmp4XS+kLd/aMZpMJuzK/0JBAODILDuZbkaFG320MlfAD8U3qIs0zQSHZB0dUtE
 Pl1TAGiVW6GbbNjdspfYLioA/P0bIlLj5Ob5EMxTRTEUbiWJ/9EpbSCHNBzulxn36wNBn3LxK
 /cbWrB0Tn+bWuKhxRLEm2WAQd1UHfRT3FiRGUUW7E7B7m/l45ouTRx+cLKG0zwD1zd8NTQpUd
 8bkLjHemzLyBeOLEd3JYGlpHqiuzwdhnCj4OXAc6/BNKX0rnHuHLnH9U2CdSXZVYkFKnQ1cjd
 kuYI2yHhTWTzqYLw0tmd+3G25j//zJNw/Sn59/9oMr8Dk2vSBwQibK/j1r8GfUY1aP3ODlYSH
 8wZg7NT+M8QAFxnRIwAXsa7Hgdz4sQpmJnhSh7nHfO69+VFY9so5VM2QzcoOpLl8V+hT2VZO/
 gEfNapbktWD2rVwLGAXMUMESmiyuVaH1AVbPH3SMBY/AChVKwifnYUO1khL6EcnTVVaXBUU8C
 xfbq3iDvmc+VKpxkVoMrMryn/oQbJx+Z6QIDswdnBxSDr6Ithw3xyTA4teETNuYkWm0Cdn/mo
 ogJUzuNLT2uVQUdots8WI335dE0O+a1GEnFUu197DQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d+5jJHEioP29KR0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:20:27AM +0900 Masahiro Yamada wrote:
> scripts/Makefile.package does not need to know the value of
> KDEB_SOURCENAME because the source name can be taken from
> debian/changelog by using dpkg-parsechangelog.
>=20
> Move the default of KDEB_SOURCENAME (i.e. linux-upstream) to
> scripts/package/mkdebian.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v5)
>=20
> Changes in v5:
>   - Copy linux.tar.gz to .orig tarball
>=20
> Changes in v3:
>   - Move cmd_debianize
>=20
> Changes in v2:
>   - New patch
>=20
>  scripts/Makefile.package | 23 +++++++++++++++--------
>  scripts/package/mkdebian |  2 +-
>  2 files changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 7266a11855f4..c207f4ec47ac 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -4,9 +4,7 @@
>  include $(srctree)/scripts/Kbuild.include
> =20
>  KERNELPATH :=3D kernel-$(subst -,_,$(KERNELRELEASE))
> -KDEB_SOURCENAME ?=3D linux-upstream
>  KBUILD_PKG_ROOTCMD ?=3D"fakeroot -u"
> -export KDEB_SOURCENAME
>  # Include only those top-level files that are needed by make, plus the G=
PL copy
>  TAR_CONTENT :=3D Documentation LICENSES arch block certs crypto drivers =
fs \
>                 include init io_uring ipc kernel lib mm net rust \
> @@ -87,17 +85,26 @@ binrpm-pkg:
>  	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
>  		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
> =20
> +quiet_cmd_debianize =3D GEN     $@
> +      cmd_debianize =3D $(srctree)/scripts/package/mkdebian
> +
> +debian: FORCE
> +	$(call cmd,debianize)
> +
> +PHONY +=3D debian-orig
> +debian-orig: private source =3D $(shell dpkg-parsechangelog -S Source)
> +debian-orig: private version =3D $(shell dpkg-parsechangelog -S Version =
| sed 's/-[^-]*$$//')
> +debian-orig: private orig-name =3D $(source)_$(version).orig.tar.gz
> +debian-orig: linux.tar.gz debian
> +	$(Q)cp $< ../$(orig-name)
> +
>  PHONY +=3D deb-pkg
> -deb-pkg: linux.tar.gz
> -	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
> -	origversion=3D$$(dpkg-parsechangelog -SVersion |sed 's/-[^-]*$$//');\
> -		cp linux.tar.gz ../$(KDEB_SOURCENAME)_$${origversion}.orig.tar.gz
> +deb-pkg: debian-orig
>  	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) \
>  		--build=3Dsource,binary --source-option=3D-sP -nc -us -uc
> =20
>  PHONY +=3D bindeb-pkg
> -bindeb-pkg:
> -	$(CONFIG_SHELL) $(srctree)/scripts/package/mkdebian
> +bindeb-pkg: debian
>  	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) -b -nc -uc
> =20
>  PHONY +=3D intdeb-pkg
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 68b13ef590ba..534e9713761a 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -95,7 +95,7 @@ else
>  	revision=3D$($srctree/init/build-version)
>  	packageversion=3D$version-$revision
>  fi
> -sourcename=3D$KDEB_SOURCENAME
> +sourcename=3D${KDEB_SOURCENAME:-linux-upstream}
> =20
>  if [ "$ARCH" =3D "um" ] ; then
>  	packagename=3Duser-mode-linux
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--d+5jJHEioP29KR0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmP5O1QACgkQB1IKcBYm
EmlCQw//dDksmYmZQDZ8w9XJqimgk/xTmsDcKSpcl30JcRLpU8XhpdiNiVDP/z/b
wiTbaYKesEowZWqKKrGOxYpLM5/wTvSbhdGyGqvbswHnZLXKCa6xxIKPIMKYyVTP
wis7pJz/TtgxXEotv6ysAG7qbgUWrg0FrItMwrF5UIQNaRLFTD67ZlR9npbw0CN0
d5RU6Xd9P71uSrmKtro9mx01iNQ3LoouJJe2d0QODsmp2hTMC7vwF1m9IeZWTtzn
i2DKGm1mkz55fMtdtJNYQE0ZMeCFcEn9VseYj1XqHmRWdPgoDiQmTHE2wo5mR+bK
dVIKLrVFOSrwTktFKDXkfxsnMG4F1w5/WE0MBaRmKr+Ot2yITokfzYmQ0xkeqEd+
W/rGhTLO0yKmENeMUhQQwqCzasfMm22ZpROM27hx7Q6O/HYEoIJNoMyP4GE16zYQ
nCfetRTe4YYX2cdA9A63W/KustpAjRQW3RoeX+7xshTbKFG0Vy6eWBMMaR3Z3/tY
aO25/opa937bYyWLUCERebe4+GMu7z3zLmAPItXvIfk9n0py7BNOOzP5hsNwvpJ3
Hc1RN8SNmUnuRSv7KY7WbB52X7ziCPsbTZbi2TZPFSB8OitMSIHgd9HL3AdUc4Y9
dzhz5bzYEKhmYQY6NrNOdgJdSHUBzkjUNWOhSKRVrkDBuLMnPvw=
=bG8k
-----END PGP SIGNATURE-----

--d+5jJHEioP29KR0F--
