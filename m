Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6764367165D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjARIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjARIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:35:10 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84AB7E681;
        Tue, 17 Jan 2023 23:55:15 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.8]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7sYM-1pLvAY1Uhu-004zI3; Wed, 18 Jan 2023 08:54:48 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:219:b8ff:fe08:dd7c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id A45723C0EE;
        Wed, 18 Jan 2023 08:54:46 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id AFB65176; Wed, 18 Jan 2023 08:54:44 +0100 (CET)
Date:   Wed, 18 Jan 2023 08:54:44 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kbuild: also delete temporary directories
Message-ID: <Y8elxMUAlFzUv91j@bergen.fjasle.eu>
References: <20230117-kernel-kheaders-gitignore-v3-0-e686b93b0732@weissschuh.net>
 <20230117-kernel-kheaders-gitignore-v3-1-e686b93b0732@weissschuh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="erULJRCZC1qO21ze"
Content-Disposition: inline
In-Reply-To: <20230117-kernel-kheaders-gitignore-v3-1-e686b93b0732@weissschuh.net>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:DUxzvGDOJd3f4cmWAvEC+6SsDn/37sKvzHxpoIVy3TYtoWAHPpH
 3/lShVa/TR/LEw9ukehAvApfas06IOA5PUlmbVOARKnLh1m23iS0UzCxDoFpFLwAYetD0z8
 0RsyfV6rCiJPkx1+lFiKQMJK59loii6JMZmWprkYG/MbPcGyhT1BSETmUgWJ1f3y990661k
 1LG8b2OAA2DFcZh5fMFGQ==
UI-OutboundReport: notjunk:1;M01:P0:ZxXE5b1zzoU=;cx/n+xEA8oxx03kp0z8eqCy1AfV
 MeYyV6BG29mRI9II+yx3AVIbNKKPgxsjZE55LGFPkOMJkBu5BrTQ3nZ6/xG7je3mRK4LRbMdq
 64awuGLwboKHYMevLosC4AaBIEUy4ZkX44Tk7scy/qBRUFwGUXfI3iHaxC/JmjYphWG1zKkHC
 CVZWlvR1hHPw1zjVM3PgcZvRlfYrCCylmW6DQUpUebGS/0BH2Vr1zjiciNecS2/uAHdBUHxv6
 bJnck/1nYQm/PqPRrO0tHiRnqDwlPkSnCUk2fLRSrcQwfpsz2ONWRPaH827jPl63LfvT+c7V0
 9JfBbtaNqp2EjqiB8/VqtmEBKTo5Bi1kidy2oUVsLPuxUYFBXLEGVmVQm4FqvSgLEqCPVQGzh
 mXSOo5/MPcry7szBLtCqGP+Bqh06LXbadf4s3tMZNUfTUCTHTLBNKUmL+AxZ/IQSBAjvDdCoY
 LRh9aYozvJqVGlSSo2hrStRZXl3+pQre3LyyQxn56za6Gh8TAS5/oLf635To9MhkpeH68KU69
 nheDqUN/WGBgJgP2gZBivpfaVGavjtLKSP2JV8Os4lLCLB1MrTmy1wZ3elFOwD9OWXNcn7urI
 IW0fZZHL6ikA9j/kcweoP30CDzRsVO1WLkZXYcNijUnBvcfcT0jbLNz7y3TrEQt4yeRU9J3Kw
 yAVRKzii6quGU0RbcwlHlH6LQgm9rrVlten/zGrmiw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--erULJRCZC1qO21ze
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 18 Jan 2023 05:05:34 GMT, Thomas Wei=DFschuh wrote:
> Reuse the standard naming schema for temporary files also for=20
> temporary
> directories.
>=20
> Such a directory will be used by the kheaders generation.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index e09fe100efb2..863b3fdd4374 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2026,11 +2026,12 @@ clean: $(clean-dirs)
>  		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
>  		-o -name '*.asn1.[ch]' \
>  		-o -name '*.symtypes' -o -name 'modules.order' \
> -		-o -name '.tmp_*' \
>  		-o -name '*.c.[012]*.*' \
>  		-o -name '*.ll' \
>  		-o -name '*.gcno' \
> -		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
> +		-o -name '*.*.symversions' \) -type f -print \
> +		-o -name '.tmp_*' -print \
> +		| xargs rm -rf
> =20
>  # Generate tags for editors
>  # ----------------------------------------------------------------------=
-----
>=20
> --=20
> 2.39.1

Thanks!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nicolas Schier <nicolas@fjasle.eu>

--erULJRCZC1qO21ze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmPHpb4ACgkQB1IKcBYm
EmmUcQ//RT3ArPXJvjC31Exedyd0ZE3b5tuzmn4d8NrJ80WULQuPou+ezqxlza/6
WuVFrsssLiL2SzS9qYV64wMf9NDBYVsEA2/ovD0yTTFLPbCjXWQO8a16EKtqWph1
GnvXVGP/UU1G6oji5u6GiT33KQErrSdGH205tHslAi1512whPDYiqz8H3TTj/4b4
dsTv9hGR3d+eOQQzXQgVmDGfQDDG5tliR77sH9BP9YpHpt49CnDIJ1KXBPL1y46l
exHtXpBbXLreTSHwp9aKgHst5yP0ximuufd153ur9qmStlhC0EIh9sMx3XObovjq
VeUX/AXPiax8E5x5LAqorzrmBD6lSwmv2XlPmvgxpiCi4hEe94NjLFShlUV9p3rt
IuORl5xJHeMv4hdjL9n+mYieNnymgRuR17iXPPigELSWIvU9OUaZsQHpl5EXIPdq
PgKF97D81z9pm3MIIwQ3qNR7f5k9GUxTeygtYo0yCkIsvZQVZJdyUv/QdG7LWq5d
o9XLNof7Dd2kMGsw05izxijaaep71K+HuoLUZ7Z+SAwjTB0RmDcOpjxtfbbP1mjS
lprbLWnkXVEJGJ8177MWAjlcDyE39uNeWmXwsRlmiu5/6raN+XOST3RFIV3wgLkO
IlL0Ghv3olqkmjXWBQ52wW12zJv/pGh9HMiF+j5A7wGDuoNu7XM=
=43p1
-----END PGP SIGNATURE-----

--erULJRCZC1qO21ze--
