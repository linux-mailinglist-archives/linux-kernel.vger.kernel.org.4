Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51853636B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiKWUjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiKWUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:38:14 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1E317E2;
        Wed, 23 Nov 2022 12:38:05 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MN5Nt-1ofaIS20t3-00J19c; Wed, 23 Nov 2022 21:37:25 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id C03043C0EF;
        Wed, 23 Nov 2022 21:37:23 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 012A31C7; Wed, 23 Nov 2022 21:37:19 +0100 (CET)
Date:   Wed, 23 Nov 2022 21:37:19 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/5] kbuild: implement {gcc,clang}-min-version only
 with built-in functions
Message-ID: <Y36Ef3ie05YO1moS@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
 <20221123151828.509565-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PpEkvchnOzhLX3fl"
Content-Disposition: inline
In-Reply-To: <20221123151828.509565-2-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:na8JOkgmRkyUHvQjG/nRKFVayFT0XtmW2jpmkJ4MzytkAMKrjAH
 bFyEPQjPoHJZfuROM8VIYVHGbFRcLPdiwCD/kOoJC8mQJb2Vpo4o6I8tyVyXi+00JhPzs0a
 RRnOfVhFouQuHJU3dOm3U+YGkwsP8YKVrWqad1za0MriHGs0564j4yJfEEPfou/waOmBjuz
 1h3pnPYz2Gp8KKWi1Fkog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W4207Z2qFVU=:RWzvvS9FK2+3aPke4dDHhe
 ts/nLPAIKuTEO1RP61E7BNJe9YIpnhEk4IrlvN+U4LdLFOAr62x3KjaU/9Q+TpEjTY2EfIoRa
 NhG2R1DdUYEBn6lw1o7OMjfTRzncTvomPK61/nAKQAdEt9I1cksY5rQSPt4APbQvgpVh4qnQo
 H33lh44pLsC+o7rvY8oiGGbDWDNhhNPlOW5ZLBcPGl4jZkAUaQf60vh/3u0jd5KOHlb1lYiAM
 cYJzQmBv6/m6AG0wYz+i6H6xJWdDE8B/n9vz/Zj1whSqu8btbXGluI+y3uoco40V+ZRXIbWRM
 vm8kZlvvRgIH8LtTh/exD7INIzWneETN2Yg6K1VDOE4LcQUR/zjPsSJ1rBcCgYaqd82o+stSt
 4hAfT51tDUsB+2mG8ajhdw/cVjDOZ7ABVair4kKxJ2iZvEM4HvASgcFpYJ+kT2g0nRKdBbRRG
 kG8vaEfWaoyW/09447RaSF1I2+igwknMmzsbfELS2aRPkdXrnzNi8EtSvFdwp0vJaTqOFpXIQ
 qm1VritI8/YRFQC+IuCEXHMGgLgpvKtH/5GgacyCeleTt68tMBLuipwALoE5KmoMgG8cfLwYy
 2d65fui17a89xlzsfbGse2fTLAMPDzpbJoW8HybAoeLAZHhqBpfCE2jO3ApC7mGacpelWrti9
 jaeMQ1NTF6px2ZyzW5p2UE6f6DUnL3x/cFYVpmGpAVgyuv/26IjiNMHcuSJz5mTzYjMXgQZ5d
 t25Telvu2+8iQExsqTN0tCLX+G/HJg91W2DebSln0P8taSSLvBJOUrqcmldJU+vNBX2GRmtOj
 Zz9eVBp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PpEkvchnOzhLX3fl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 00:18:25 GMT, Masahiro Yamada wrote:
> Converting clang-min-version is straightforward because the versions
> are always 6-digit.
>=20
> gcc-min-version is somewhat tricky because the minimal GCC version
> is GCC 5.2; prepend '0' to the version that is less than 10 so that
> test-ge is always passed with 6-digit versions.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v2:
>   - Covert gcc-min-version in a different way
>=20
>  scripts/Makefile.compiler | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 20d353dcabfb..cd75f81e88ef 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -63,11 +63,15 @@ cc-disable-warning =3D $(call try-run,\
> =20
>  # gcc-min-version
>  # Usage: cflags-$(call gcc-min-version, 70100) +=3D -foo
> -gcc-min-version =3D $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo=
 y)
> +
> +# Preprend 0 to the version that is less than 10 so test-ge works.
> +gcc-min-version =3D $(call test-ge, \
> +                  $(or $(filter 1%, $(CONFIG_GCC_VERSION)), 0$(CONFIG_GC=
C_VERSION)), \
> +                  $(or $(filter 1%, $1), 0$(strip $1)))

Hm, this silently expects a gcc version < 20, which we should expect in=20
about seven-eight years [1].   I am thinking about the possibility of=20
silent (but unlikely) breaks when someone in far future uses a gcc 20=20
against a kernel with this line.  Probably we should not care about=20
that today, yet, right?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

[1]: https://gcc.gnu.org/develop.html#timeline

> =20
>  # clang-min-version
>  # Usage: cflags-$(call clang-min-version, 110000) +=3D -foo
> -clang-min-version =3D $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && =
echo y)
> +clang-min-version =3D $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
> =20
>  # ld-option
>  # Usage: KBUILD_LDFLAGS +=3D $(call ld-option, -X, -Y)
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--PpEkvchnOzhLX3fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+hHsACgkQB1IKcBYm
EmkAThAA5+mKXEmPVZ/5RESfzp3+FMom6bTBouBT+hf2t8aQp6PYzzdFgjnq0hWw
WbRBrNHqFOSkLJQkL2mo3YfZIORaaLtpOk9VSHWphc7LVQq4rmZGLznJwa4lmhDa
R54r9pY16ywl660NjlJaL/rsMrTDsizYbs2Aj3fccjqa8js9aekVZ0uyuaIruaYG
pvWT4VljvowG6YO97KLILsdqJklPd0+YLA/tzBJ/qGacaEzyvGN0ljGO4nLYnWuB
5xmjW/JTKjUs5JrkNNcYZP9T3QB7u/AmRVp4IcRIOAZ8K/iV+pdWG06+XFB1kmoO
80B/9sKTCUGtjgxPqmKAGgYd2tGV2vCHRUPs2LVExbYlbRiwKumDrySidSec5Wjs
5YNjryPS7MyQftL7glG3CeEUB2Xw5IGEbb21rlChS3Q4IlLsBIqlmT9UjPgqz0r+
F5jnTtnoEx/Lk6WM8a8jUKjxGIrGaiDwFeY+KWVikBPuuzx08JRlVbD/zg155du1
9F3rpiIlO1OrwWzucaiW2PYrkpUqA8I8XMVBn5d5CtRtxVeQ3aXU081bn68xyM9y
FzS38YJDMrWfzj6j0wMVYCZb3F1wv97mJBoy7X2+xiq/oEUJmH0B/x/zo/yhZRbi
W1Q/+L5DygbN11q/1paxAhAIXPxBbFQNWLHvT3Yg3d1dJk21ihY=
=gMci
-----END PGP SIGNATURE-----

--PpEkvchnOzhLX3fl--
