Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982A46A2474
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjBXWsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXWsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:48:17 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CDE4E5FB;
        Fri, 24 Feb 2023 14:48:08 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.255]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M5wY1-1pPL6y32D5-007WKq; Fri, 24 Feb 2023 23:42:31 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 826D33C1C6; Fri, 24 Feb 2023 23:42:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1677278550; bh=3Q1ZIqpG+fkEm+5lSz4xt93M7STQCsuQ3AehnRYSWT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhfSEuA8di20WiQrOaQGJk1Y/jEXcRu6v3W7dGlig6IfiNt4BzsTN//iXlE8Qsc3R
         GOTcNuJ5GYERmCcuR2X+MkJ5xPrkIeu9LoeQSF4M88hFgZAadZ+VyuLv6z64usy2rr
         J7YgfJB98ghY5fBM9MUYcELXI2IOEx50O5G8NhBY=
Date:   Fri, 24 Feb 2023 23:42:30 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v6 07/12] kbuild: deb-pkg: switch over to source format
 3.0 (quilt)
Message-ID: <Y/k9VkL+Amj8JaSe@fjasle.eu>
References: <20230215012034.403356-1-masahiroy@kernel.org>
 <20230215012034.403356-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ug59cDCp0STC2gvi"
Content-Disposition: inline
In-Reply-To: <20230215012034.403356-7-masahiroy@kernel.org>
X-Provags-ID: V03:K1:hT/um+7HUktSResSMTXZ6GSgJX158k27KJSYkZBzl6VDYxtvBJ4
 YPvuZePuwsXEP/WSG2AxTzB4P8pyzhLLSQ4ePlTOWCvdaAeDhINbPssn/1NXqZ6iFgnLWXn
 EBGKHAzMPEDHz1i+SqjYm1IZVzpsTdtggvW7LQJtRjfBZUG/ghLGgXW9DZxsvFujUtTqX/U
 B2HiOzBRsMEfZDFh+N27g==
UI-OutboundReport: notjunk:1;M01:P0:Hk+YLX1btlY=;F4sCEcowpy/1XxLS3yAV+grjT9j
 t1zxlEbt1P5e6mIDrBW2ZZi3Mck8Kw4Ll7Ay8yTXyB9UvRri8VhzhiW1U7vsfSWT8yo+eA65f
 2SZ7TtUqC/0PlN71FiYloZT5cVos164B3nVvjFDCHh7/Tm+DsMka2iV+gqVaZBR0reUM00gyq
 0Fw3R2jEeJnEVtuGJcmofKDFxqUYqyIJOR4KfASkay/zTt6YjTAME55ZYdS2ID4+ZcVxxp4Og
 gJ0U/SfQuUB8WTAAwl1CVdvhlCCcXN/vl7QGHCLYI/yPWa5yilWsVyuPekPeAWNaw9/hNgZcp
 S8+IBSaBM8/SInP4/U7+Rqg1DCMigU8XmuHalG/jCjd60KkYIS3KDkCzu0ipYWLJ4Bvie5HlD
 +fYjEsskyyI1c4FMruw2ErtpauISjvPy2CtdkbXZz+MrdsNqbQhqisOiyu5PSBluW1JBptlJR
 yEPMdAHHImjQ8k2E9w0XsDQHa8MRxMyg0Yl0cKhG2Ata0C79RPIu2oBjuI/HHkQXG8ciL0CUb
 SZwP779f4f8h6U5WakGuIJXMEULcplqA1bXZXy74erzNoziPo0gvQZi88S0orAwWn706+ZiKu
 Wm6ge4Ktsa57PlcecnFxFMxsqPU8CNCLPKsn5uk78QEnK1nM1hdQg4h02R3wKNQp4vrsaDY2l
 Au9Bs4/By+fb0yCwdIPSsdn18H1mMkDFL8cQRtEQyQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ug59cDCp0STC2gvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 10:20:29AM +0900 Masahiro Yamada wrote:
> Change the source format from "1.0" to "3.0 (quilt)" because it works
> more cleanly.
>=20
> All files except .config and debian/ go into the orig tarball.
> Add a single patch, debian/patches/config, and delete the ugly
> extend-diff-ignore patterns.
>=20
> The debian tarball will be compressed into *.debian.tar.xz by default.
> If you like to use a different compression mode, you can pass the
> command line option, DPKG_FLAGS=3D-Zgzip, for example.
>=20
> The orig tarball only supports gzip for now. The combination of
> gzip and xz is somewhat clumsy, but it is not a practical problem.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Thanks, that switch to 3.0/quilt sounds really good to me.

>=20
> Changes in v6:
>   - Fix error when KCONFIG_CONFIG is set
>=20
> Changes in v4:
>   - New patch
>=20
>  scripts/Makefile.package |  2 +-
>  scripts/package/mkdebian | 41 ++++++++++++++++++----------------------
>  2 files changed, 19 insertions(+), 24 deletions(-)
>=20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 80a96eb61426..5538deacb136 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -105,7 +105,7 @@ debian-orig: linux.tar.gz debian
>  PHONY +=3D deb-pkg
>  deb-pkg: debian-orig
>  	+dpkg-buildpackage -r$(KBUILD_PKG_ROOTCMD) -a$$(cat debian/arch) $(DPKG=
_FLAGS) \
> -		--build=3Dsource,binary --source-option=3D-sP -nc -us -uc
> +		--build=3Dsource,binary -nc -us -uc
> =20
>  PHONY +=3D bindeb-pkg
>  bindeb-pkg: debian
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 534e9713761a..22fc73a5e4f2 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -135,29 +135,24 @@ else
>  fi
> =20
>  mkdir -p debian/source/
> -echo "1.0" > debian/source/format
> -
> -# Ugly: ignore anything except .config or debian/
> -cat<<'EOF' > debian/source/local-options
> -diff-ignore
> -
> -extend-diff-ignore =3D ^[^.d]
> -
> -extend-diff-ignore =3D ^\.[^c]
> -extend-diff-ignore =3D ^\.c($|[^o])
> -extend-diff-ignore =3D ^\.co($|[^n])
> -extend-diff-ignore =3D ^\.con($|[^f])
> -extend-diff-ignore =3D ^\.conf($|[^i])
> -extend-diff-ignore =3D ^\.confi($|[^g])
> -extend-diff-ignore =3D ^\.config.
> -
> -extend-diff-ignore =3D ^d($|[^e])
> -extend-diff-ignore =3D ^de($|[^b])
> -extend-diff-ignore =3D ^deb($|[^i])
> -extend-diff-ignore =3D ^debi($|[^a])
> -extend-diff-ignore =3D ^debia($|[^n])
> -extend-diff-ignore =3D ^debian[^/]
> -EOF
> +echo "3.0 (quilt)" > debian/source/format
> +
> +{
> +	echo "diff-ignore"
> +	echo "extend-diff-ignore =3D .*"
> +} > debian/source/local-options
> +
> +# Add .config as a patch
> +mkdir -p debian/patches
> +{
> +	echo "Subject: Add .config"
> +	echo "Author: ${maintainer}"
> +	echo
> +	echo "--- /dev/null"
> +	echo "+++ linux/.config"

bike-shedding:

	cat <<-eof
	Subject: Add .config
	Author: ${maintainer}

	--- /dev/null
	+++ linux/.config
	eof


> +	diff -u /dev/null "${KCONFIG_CONFIG}" | tail -n +3
> +} > debian/patches/config
> +echo config > debian/patches/series
> =20
>  echo $debarch > debian/arch
>  extra_build_depends=3D", $(if_enabled_echo CONFIG_UNWINDER_ORC libelf-de=
v:native)"
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--Ug59cDCp0STC2gvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmP5PVUACgkQB1IKcBYm
Emk+uhAA2TE8BdL0TPrv42P4qNx16ODICbnWZnOyC7kDk9rqd0mYR0mMa/w/i7BV
q+QlnwyfB/U1QGzO3ygtvicFvExPAuNeH4Cc/vSpp+aMmLWEYIPdMU+WEvjqzkiz
8ockigUferhu2+3+fViCIejRhN6hrGsSLmxcx8mrOEtF95qjDekHRQMsfDl82QQS
25F5Y7JZDxydUAJoExIBE3e7VhAfEDpuuxRADeiJsW+b75a6M0ikvPenEoPK2Pko
bY63NCHNC7us5Rz1mgbtn1IVAIbYp/9r1bQsS4IbNc2XXhNfoc560KSInehhcorb
IIG/zQ1eModa0Q4CsgjbzO5bD6BQhZtHmK0x8Qe0AQOEqVpgSvBMDY78zS1/5FbI
Gft6Fq0VDOv/ZJBHdduUXiaX/Tefi/DxAvx35+/ed/fkehtmiskgbb4RkjpkodYx
V8SDFRg/RxSx15dmMBq+LjZFIZnnvPCUCIVTaWtV70Pdt+nBQqEDUopzQXpDMJY8
2C6Xr1U6ODrcHn0ql9tR1XtgEqEsfZnEVwcf7RxAkzskfh6D30Uc5/SYTbKzBcSZ
FMax+hH7CIOMe5TsO4m/D8JyUc/GU7pi6oiOMwZ0FZ2sRlVyFAjiTzskl9AjYFtq
I0Mr0zu2pHil6Cfs/3hV38dRTWN50vgb4tql62L/vYkIvG4tPlw=
=48FK
-----END PGP SIGNATURE-----

--Ug59cDCp0STC2gvi--
