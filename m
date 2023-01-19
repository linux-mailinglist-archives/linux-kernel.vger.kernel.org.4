Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21B1673288
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjASHdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjASHdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:33:19 -0500
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 23:33:00 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D864D8A;
        Wed, 18 Jan 2023 23:32:44 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.48.177]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHVWT-1pVpbM1ViL-00DYbp; Thu, 19 Jan 2023 08:26:57 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 65F643C0CA;
        Thu, 19 Jan 2023 08:26:54 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id C684B226; Thu, 19 Jan 2023 08:26:53 +0100 (CET)
Date:   Thu, 19 Jan 2023 08:26:53 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts: remove bin2c
Message-ID: <Y8jwvStxgvq8fLFi@bergen.fjasle.eu>
References: <20230119071215.23042-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AD2LLBSH5JgWqAez"
Content-Disposition: inline
In-Reply-To: <20230119071215.23042-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:yAtR0qK5w0zRMZ+oxj7A3ID+ZqecFGRvQI5yqtG5LIe0tEXwDUH
 wOrCONxq7U7ztbejoY8gxwwG25btpQp/dproYgzk2BRsR/lRFUNDXbmCu18dmH+TWjEOLNg
 mmO3nXlsF2/rIWjJsqrGtuTUPq71TNHu7HxHyW83U3xg3fJWYHU+W9Xsw90abyW5DcIKk7B
 7NhKs8o+cbxzJc5LB3Cqg==
UI-OutboundReport: notjunk:1;M01:P0:zh2HAhn5lVw=;qO3CB+jVlMNyQtOfqz4S2ZvQD8C
 KF+43Q3WfR21R0aui25aCFsGU+STEyTmvy1CloytvsiIy+rMY26FkI6sY0bn3vztxX2EjWxkD
 vOUt3XDA8dthqLsfGVRaXIZrpZZhPchCJrjau59wCLEDIKmxPOfJbdSG6uPm/z8PtpyCdv97s
 oM1x7QMPM69ekvK/GORSq9nlFsxKcOAojNIaYy7gMTM+zN2XL7zKTPZLGBrIcRjCnssFezNmr
 BBgheqIxsuUoq/5g82JYm3NvRWw2QAJJ9d/u93Vk15jREWmd6FXZIQ6fqw13cazCV8+LowkNs
 ElHW9d0hWMXhmFGuLJFXKQ43TznB+Aw6ijWKCiNnNwWqCr/Ds+GcA0txxcFIcr/5ALl0Fyd+s
 vkrOQOVNHh9Z3lOpL2znBnpZBqGy3Fd49J6YlN1/9rf71CNlwS3GmuRxupUGq5KvSleFHqF3P
 Igz8G/IxkoLtFT7RygUCXvsr/KkygzXdUwxOvDbbw7aPO/8DK+o25Y7n7gM/Y4OpSAvK53aC1
 m//OKNjS55k9w8UnCkAv4gmhFg4mbKYisN3rhPL0EUHe+7+E6tCc2t9WbDCuxjtP48VymunN8
 byVAMABzX3wdywIBI80maRN6+5evEMo6Az2viAprOjPlr35S1Nu8lLs7UJzbgLrbsLAa1Rc0q
 yO6RayI/UY5njqgWIdThF9I2lfH4E3OcAtFvUj7m5A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AD2LLBSH5JgWqAez
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 19 Jan 2023 16:12:15 GMT, Masahiro Yamada wrote:
> Commit 80f8be7af03f ("tomoyo: Omit use of bin2c") removed the last
> use of bin2c.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Documentation/dontdiff     |  1 -
>  init/Kconfig               |  4 ----
>  scripts/.gitignore         |  1 -
>  scripts/Makefile           |  1 -
>  scripts/bin2c.c            | 36 ------------------------------------
>  scripts/remove-stale-files |  2 ++
>  6 files changed, 2 insertions(+), 43 deletions(-)
>  delete mode 100644 scripts/bin2c.c
>=20
> diff --git a/Documentation/dontdiff b/Documentation/dontdiff
> index 352ff53a2306..3c399f132e2d 100644
> --- a/Documentation/dontdiff
> +++ b/Documentation/dontdiff
> @@ -91,7 +91,6 @@ asm_offsets.h
>  autoconf.h*
>  av_permissions.h
>  bbootsect
> -bin2c
>  binkernel.spec
>  bootsect
>  bounds.h
> diff --git a/init/Kconfig b/init/Kconfig
> index 7ceabd320425..f66ba19f9482 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -682,10 +682,6 @@ config CPU_ISOLATION
> =20
>  source "kernel/rcu/Kconfig"
> =20
> -config BUILD_BIN2C
> -	bool
> -	default n
> -
>  config IKCONFIG
>  	tristate "Kernel .config support"
>  	help
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index 11bf3c075fb6..6e9ce6720a05 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /asn1_compiler
> -/bin2c
>  /generate_rust_target
>  /insert-sys-cert
>  /kallsyms
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 0e0ae3c06ed7..32b6ba722728 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -3,7 +3,6 @@
>  # scripts contains sources for various helper programs used throughout
>  # the kernel for the build process.
> =20
> -hostprogs-always-$(CONFIG_BUILD_BIN2C)			+=3D bin2c
>  hostprogs-always-$(CONFIG_KALLSYMS)			+=3D kallsyms
>  hostprogs-always-$(BUILD_C_RECORDMCOUNT)		+=3D recordmcount
>  hostprogs-always-$(CONFIG_BUILDTIME_TABLE_SORT)		+=3D sorttable
> diff --git a/scripts/bin2c.c b/scripts/bin2c.c
> deleted file mode 100644
> index c3d7eef3ad06..000000000000
> --- a/scripts/bin2c.c
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/*
> - * Unloved program to convert a binary on stdin to a C include on stdout
> - *
> - * Jan 1999 Matt Mackall <mpm@selenic.com>
> - *
> - * This software may be used and distributed according to the terms
> - * of the GNU General Public License, incorporated herein by reference.
> - */
> -
> -#include <stdio.h>
> -
> -int main(int argc, char *argv[])
> -{
> -	int ch, total =3D 0;
> -
> -	if (argc > 1)
> -		printf("const char %s[] %s=3D\n",
> -			argv[1], argc > 2 ? argv[2] : "");
> -
> -	do {
> -		printf("\t\"");
> -		while ((ch =3D getchar()) !=3D EOF) {
> -			total++;
> -			printf("\\x%02x", ch);
> -			if (total % 16 =3D=3D 0)
> -				break;
> -		}
> -		printf("\"\n");
> -	} while (ch !=3D EOF);
> -
> -	if (argc > 1)
> -		printf("\t;\n\n#include <linux/types.h>\n\nconst size_t %s_size =3D %d=
;\n",
> -		       argv[1], total);
> -
> -	return 0;
> -}
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index c71bf2f68360..04fcdf739638 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -29,3 +29,5 @@ rm -f scripts/extract-cert
>  rm -f scripts/kconfig/[gmnq]conf-cfg
> =20
>  rm -f rust/target.json
> +
> +rm -f scripts/bin2c
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--AD2LLBSH5JgWqAez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPI8LgACgkQB1IKcBYm
EmmJtg//WvcJNv/0KI8LzM6boTkDJsF/NqrFVLUvMlPvO4PcwXb8jO3lcAK47gl7
6Bi/JPXgGeOYQMzTe9YJ2/M7CKw4ekc5ff+L0c8WdtQrSR+DgwTHpXH6b/cqwk2F
vmaxhhylBSu8NEA4NGEuoN5JK1IQiMxEjL5VFnUfNR9IzsAkRg9gA4zz8wC8ia0D
1T+UQZQq7bTTZ0fAOj35yhJ4wFQVJXkBSX5Fn08kGHzptdtww5uC7AEHnswFjgLg
4HXII8e234HCeHPnj3ighWCh7tTEn83Mz9lF2GmGSAr641lvvWhn75WN9Gm43hUr
gfiS1+cV5ZhGVQV69ZWY2VnZKkogEFXahPIFHw1u2dOrfKxBp08X1baUsNGIsBh4
AcTcLsgHPDxrXiTyRfQRvxVciGwXYovOXCp/n2ULjBvAu32xbgUzajsbLp+EYcjq
QZ9OTGAGqxrjWTiXJ8N4GH6/PybbrY8hnlA2WDLzNLowW4iSh/yi4QkWJSxUp6Mw
5qPLeDh1wczs6SMLKNHn1ihimr/3bBSc6EbJe/N0sSh3HXi3FQDkL7T2CiukxZLt
2Ign0F2SWmy5kPLy/394iGBSEaevTHAwyHbtiXPZNq9KcByeS5ijxvzgcvgE86br
ZIBbmcf9ZFdWKqRJmToG9bC9D4B8OzqWKo9+O+xKjIt21E7S7mo=
=ATIy
-----END PGP SIGNATURE-----

--AD2LLBSH5JgWqAez--
