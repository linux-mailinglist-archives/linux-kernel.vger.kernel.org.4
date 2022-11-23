Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71808636AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiKWUSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiKWURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FF58220A;
        Wed, 23 Nov 2022 12:17:04 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.96.241]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQ5nK-1obqm93cWG-00M72I; Wed, 23 Nov 2022 21:05:22 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 52F8F3C015;
        Wed, 23 Nov 2022 21:05:18 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 6B7191C7; Wed, 23 Nov 2022 21:05:16 +0100 (CET)
Date:   Wed, 23 Nov 2022 21:05:16 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v2 1/5] kbuild: add test-{le,ge,lt,gt} macros
Message-ID: <Y358/NPL/nx0Kptd@bergen.fjasle.eu>
References: <20221123151828.509565-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="znPVOg7B9IQKl2yp"
Content-Disposition: inline
In-Reply-To: <20221123151828.509565-1-masahiroy@kernel.org>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:4TMCF6+BpNhqadPJZDcAdY3nwKfqAcbysQj2EF2ZdxOp1xLt7kb
 CGQoLOVIqh9IH0cDu/83ip3VChnh93SA2dQlOdMZkBApDKkMCQ0sSJjy+HTSg7cTL4wlXNc
 7t/jDMZdOzTzTNsywe0uKTB1iDA4rvKUYKlgFnFHqeoo0qF5UboIlCNEz/khQueq8mSWMNA
 ppZquw2lOcSOIIetCF6Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WeU5pR5T+80=:7VzCmYxtX5SZAkIZGY64d6
 HsBY0lEqIdhAhuEofrGY0LXWVrYqvg+Ack14NcGEZ9dbzJrEshXGEVIriew3q7+SsS3PLIs92
 Zyq/KD/JSwFJAdIFJkzMslckdNvJFKonlgmTzTlG2z4DvNkmnFXvTy+V9XNviK4WHp2F4LYhG
 p1bCZJM88mXPkYo6ECIlgu62fkZWZ5OtUIWxjQMQiDm8RLKyv9gcqaadSMIVLE5F9bB1Scmy/
 n0kxUCWLW11JG/VXboIyIEuBwpVwO3Hq4LyUuTxJW2e9+Q0py7M+xqvaMpdiUATnUilM6E+0B
 033Y7F3Jan5i6hEkTZiE3+STolA+FLkxS/j0vCko361FNacesuo1FSVnVNxMxt5DWgbWypIgY
 t4L5YCD2zwJEqJsxQ9FP7cgu5qVT0+0SfrEzujRpfnxMZAncYcknErYZ+OF5hIfjMEA6IdMmu
 3Lum7MYLhoJWiBVOi8dh6HtCjHK2z9DQxOw8Z/kyBkCcRC322w7Z7PFCHmVhQqZF7ju6k0ykP
 a9za5h9w/QQnjJ+dNj+5/B4/EbrjvkcWbTKFGPzgWOxxkBp7WbRPqekz3SLZvoIE3k7Eo9X5J
 xhGbx+5s8MFvceAgrFF+LBAQJyP+S0mAisihyotMBrzSIXZCj7uMzfIHYqEi6cFmG0nGqQhF6
 7nB0HpnMIMfCmVtmCcQj1bdiqkCURCLTxW/x2SDdsK0acnjnqI7iUJlGePyb82KZoceW2G51k
 4zegIJdM5ID6PnGMUyGl+Jf0yYiG5CM6RAOPlyeCtAOCnNrDcflQVOSb5zu8/TDe/7aTyuc3e
 cIUZsT7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--znPVOg7B9IQKl2yp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 24 Nov 2022 00:18:24 GMT, Masahiro Yamada wrote:
> Because GNU Make is only able to handle strings, it is very hard to
> perform arighmetic in Makefiles.
>=20
> When we compare two integers, we invokes shell. One example is in the
> top Makefile:
>=20
>   ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
>=20
> This is more expensive than using built-in functions since it forks a
> process.
>=20
> If we know the two have the same number of digits, we can do better.
>=20
> This commit adds four macros, test-le, test-ge, test-lt, test-gt.
>=20
> $(call test-lt, A, B) is evaluated to 'y' if A is less than B, or
> empty otherwise. This will replace $(call shell test A -lt B).
>=20
> Again, the limitation is that A and B must have the same number of
> digits because these macros are based on $(sort ) function.
>=20
>   $(call test-lt, 1, 9)    -->  y        (Works!)
>   $(call test-lt, 10, 9)   -->  y        (Not work...)
>=20
> To make the latter work, you need to add '0' prefix to align the number
> of digits:
>=20
>   $(call test-lt, 10, 09)  -->  empty    (Works!)
>=20
> Actually, we can live with this limitation in many places. As for the
> example above, we know $(CONFIG_LLD_VERSION) is 6-digits because the
> minimal supported version of LLVM is 11.0.0.
>=20
> So, the shell invocation can be replaced with more efficient code:
>=20
>   ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>=20
> Of course, this assumption will break when LLVM 100 is released, but it
> will be far in the future.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile               |  2 +-
>  arch/riscv/Makefile    |  2 +-
>  arch/x86/Makefile      |  2 +-
>  scripts/Kbuild.include | 10 ++++++++++
>  4 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 6f846b1f2618..eb80332f7b51 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -986,7 +986,7 @@ KBUILD_LDFLAGS +=3D -mllvm -import-instr-limit=3D5
>  # Check for frame size exceeding threshold during prolog/epilog insertion
>  # when using lld < 13.0.0.
>  ifneq ($(CONFIG_FRAME_WARN),0)
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>  KBUILD_LDFLAGS	+=3D -plugin-opt=3D-warn-stack-size=3D$(CONFIG_FRAME_WARN)
>  endif
>  endif
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0d13b597cb55..faf2c2177094 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -37,7 +37,7 @@ else
>  endif
> =20
>  ifeq ($(CONFIG_LD_IS_LLD),y)
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),y)
>  	KBUILD_CFLAGS +=3D -mno-relax
>  	KBUILD_AFLAGS +=3D -mno-relax
>  ifndef CONFIG_AS_IS_LLVM
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 415a5d138de4..e72c7a49cd59 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -211,7 +211,7 @@ endif
>  KBUILD_LDFLAGS +=3D -m elf_$(UTS_MACHINE)
> =20
>  ifdef CONFIG_LTO_CLANG
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>  KBUILD_LDFLAGS	+=3D -plugin-opt=3D-stack-alignment=3D$(if $(CONFIG_X86_3=
2),4,8)
>  endif
>  endif
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index cbe28744637b..9996f34327cb 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -11,6 +11,16 @@ space   :=3D $(empty) $(empty)
>  space_escape :=3D _-_SPACE_-_
>  pound :=3D \#
> =20
> +###
> +# Comparison macros.
> +# Usage: $(call test-le, A, B)
> +# works like shell's "test A -le B", but A and B must have the same numb=
er of
> +# digits since it is just ASCII sort.
> +test-le =3D $(if $(filter $1, $(firstword $(sort $1 $2))),y)
> +test-ge =3D $(call test-le, $2, $1)
> +test-lt =3D $(if $(filter-out $2, $(firstword $(sort $1 $2))),y)
> +test-gt =3D $(call test-lt, $2, $1)
> +

I like that whole patch set, thanks!  A cherry on the cake would be a=20
sanity check for equal length of A and B ...

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>  ###
>  # Name of target with a '.' as filename prefix. foo/bar.o =3D> foo/.bar.o
>  dot-target =3D $(dir $@).$(notdir $@)
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--znPVOg7B9IQKl2yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmN+fPcACgkQB1IKcBYm
EmnCBhAA6NDD7gDwc+de/8pXIN89eqC0GlDxjEX5RKJrTSUcWoja2UWiPQ0eDlJi
vlU7IeOXvCK/rN4A68oqjcEEmTIoiBzzg2B+vs2DshDEslXehAmxJjJ+w0BORDMm
BtKFMn1h0KTP08Eo/ChYDWltp+eu0nFo3NAJ7bEaMmd0BVz1LwdNmYRDvB07xgEE
/SGs9c6NF5mG5cgZryX1tezqtmw7Fb3so8AX6mkqRlzVQNIMw98RK3i5kBTrf1Nd
ost6PL0s7yll44CmfmtdvCWYouHU0VHjOZsGTTNdnOwU60Sc+0z+ZfZky4pyfQgN
stmG5zDCseO1uRVTLva71DBcjY3aux7Z6kvvqOfsx2fig9hpDJ8Q/kVEsI/sgv0q
OZdujzgx6KZiFNcyMHjeKYlMevmz8KGLLQVtdm6zmSLa0VZnqWcESkAN5x1m0ylf
QxPN8TTTDzgmgeFDMxn3ni0OfK1p2dVsJgzr9rQkAEeP9uIIXAGFoJSZe+AVYpii
ExZa+SeNS+AMuR2pRVT+lptiYdBoTyEGXKp0IF/u30VGNRl6gODKQmZXkxRWWtxJ
Sol2JpxbhEmLBb1j8YPrgU2Kit2OuXvqHGC55k+Nvl4TMWyZbJ8nBaSb9dscOe9D
ggiJMKDaJUs7NAiyTP2Kx2Fj7XqnL08DHLwkNMr5WIdkiz1v10w=
=x0uX
-----END PGP SIGNATURE-----

--znPVOg7B9IQKl2yp--
