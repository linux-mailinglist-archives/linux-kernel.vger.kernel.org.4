Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0AC661577
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjAHNXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 08:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 08:23:13 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1071510055;
        Sun,  8 Jan 2023 05:23:03 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.97.169]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MK3BO-1pUOtS1KCU-00LZbc; Sun, 08 Jan 2023 14:22:40 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id E6BBF3C1B9; Sun,  8 Jan 2023 14:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1673184158; bh=UG+3zxCKsSety2TzcFTuaj2SAVGrA9MgyY7mNKt3rbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfCKV4hicY6etu/fBr907KfyVOghib/v3KEWCedJNqbuVZ8K6tgD2P0dIcjoh/sq1
         01LFBbUBPzHO+ZSaiLtjPW/iNyyKumgZui+eiyuj5Mlggb30q/pz6lglpuJFoG2lPz
         on/45KQbbNpJCWb1Il5hoh9S20ozNi9tWjKIacfU=
Date:   Sun, 8 Jan 2023 14:22:37 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] kbuild: do not export LDFLAGS_vmlinux to decompressor
 Makefiles
Message-ID: <Y7rDnda0PzCw2Eao@fjasle.eu>
References: <20230108095342.2766757-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xWw0cIEXiYn5foMi"
Content-Disposition: inline
In-Reply-To: <20230108095342.2766757-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:WfH94E+d4wZAacQ4WUgXNvAquiZ79Z/1gzfILXhc62T/HP/91T5
 RNfCXm+JHWdzxPKappq9gXBq9RVowLF0/fM2N2oJlXqQWLuZ9bd9ra7gEejfEzMrgYxlzeX
 kjJBQQE8YfTwMTrbpkUizH2gF6PaQew/Ho1yGvLPBiCTyRUW7XXylMk7YhFo/F+FSppd6s7
 nKnwascVceD5YZic8spIw==
UI-OutboundReport: notjunk:1;M01:P0:8zO87uPZ+XE=;qTp2HHLwz1kpQwScJcNjeASnyO0
 Vd8+b8TuuzzA6umAa8mHSS8R7OU+DbUNCv+sb0e4cqCYylXb0c2+8IQrhKMmaW2NKmqeD78eg
 Q7RbzKyZJw7x9VVJ2StQ14jdINnaqk06eWiskmkk/syMKwP9BlJ7QF1MxE6AwAfbXKydlc8kP
 xY4jJAjzSfcJpC0lGERvTxlK1vGXN52n4NMum0NClyeVdjijxb9ES9ITmzTVME1pNgagwOvJX
 3zOndgvabWPw70iG+avhqGlUif/uE77MB8gP+i8i7HWBkYVyW5PtgRDJcQ7aSGzHDDnb+E4nc
 mnRe8NdF8Q4Bhf5c9y/KFz4gLNAYqttnlREl1FkqJuBMyzAiBHjAJrtYcLWowiOJqAp0BuFUw
 g7i5pRlfzxakGqV7Uwq/e39lMo4iAbW9GpBiVshdTMJ5WWHlQn2Rltl8+EKyxgq8ioESQMJKH
 j4QT8dI/rQcYB1JK9rzPMhhAuvPI11xirL+l8siHanaMzAzNgVthpZ71Y4Omsn5gf8LHRxcLH
 +6ywCjXolNavVoJ7C0hzJFN+XCu6eQIXJA5X189cjo4iq9dhvqeWp4kFqeSaQ5ydrkAfdnCyR
 QIcsiAVKb2v4iVuQOBNzkPmW2CE3f+2SoNq5aGCl5Hj6VXEzpEU42+wRJjzg4Pd/pN95YZdbx
 7SzrWs1JUQ9oHPpUvxgKkPkuzOYyPfcDNOG8TqHrbA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xWw0cIEXiYn5foMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2023 at 06:53:42PM +0900 Masahiro Yamada wrote:
> Date: Sun,  8 Jan 2023 18:53:42 +0900
> From: Masahiro Yamada <masahiroy@kernel.org>
> To: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
>  Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers
>  <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>
> Subject: [PATCH v2] kbuild: do not export LDFLAGS_vmlinux to decompressor
>  Makefiles
> Message-Id: <20230108095342.2766757-1-masahiroy@kernel.org>
> X-Mailer: git-send-email 2.34.1
>=20
> Nathan Chancellor reports an error message from $(NM) if GNU Make 4.4
> is used to build the ARM decompressor.
>=20
>   $ make-4.4 ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- O=3Dbuild defc=
onfig zImage
>     [snip]
>     LD      vmlinux
>     NM      System.map
>     SORTTAB vmlinux
>     OBJCOPY arch/arm/boot/Image
>     Kernel: arch/arm/boot/Image is ready
>   arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': N=
o such file
>   /bin/sh: 1: arithmetic expression: expecting primary: " "
>     LDS     arch/arm/boot/compressed/vmlinux.lds
>     AS      arch/arm/boot/compressed/head.o
>     GZIP    arch/arm/boot/compressed/piggy_data
>     AS      arch/arm/boot/compressed/piggy.o
>     CC      arch/arm/boot/compressed/misc.o
>=20
> This occurs since GNU Make commit 98da874c4303 ("[SV 10593] Export
> variables to $(shell ...) commands"), and the O=3D option is needed to
> reproduce it. The generated zImage is correct despite the error message.
>=20
> As the commit description of 98da874c4303 [1] says, exported variables
> are passed down to $(shell ) functions, which means exported recursive
> variables might be expanded earlier than before, in the parse stage.
>=20
> The following test code demonstrates the change for GNU Make 4.4.
>=20
> [Test Makefile]
>=20
>   $(shell echo hello > foo)
>   export foo =3D $(shell cat bar/../foo)
>   $(shell mkdir bar)
>=20
>   all:
>           @echo $(foo)
>=20
> [GNU Make 4.3]
>=20
>   $ rm -rf bar; make-4.3
>   hello
>=20
> [GNU Make 4.4]
>=20
>   $ rm -rf bar; make-4.4
>   cat: bar/../foo: No such file or directory
>   hello
>=20
> The 'foo' is a resursively expanded (i.e. lazily expanded) variable.
>=20
> GNU Make 4.3 expands 'foo' just before running the recipe '@echo $(foo)',
> at this point, the directory 'bar' exists.
>=20
> GNU Make 4.4 expands 'foo' to evaluate $(shell mkdir bar) because it is
> exported. At this point, the directory 'bar' does not exit yet. The cat
> command cannot resolve the bar/../foo path, hence the error message.
>=20
> Let's get back to the kernel Makefile.
>=20
> In arch/arm/boot/compressed/Makefile, KBSS_SZ is referenced by
> LDFLAGS_vmlinux, which is recursive and also exported by the top
> Makefile.
>=20
> GNU Make 4.3 expands KBSS_SZ just before running the recipes, so it
> works fine.
>=20
> GNU Make 4.4 expands KBSS_SZ in the parse stage, where the directory
> arm/arm/boot/compressed does not exit yet. When compiled O=3D option,
> the output directory is created by $(shell mkdir -p $(obj-dirs))
> in scripts/Makefile.build.
>=20
> There are two ways to fix this particular issue:
>=20
>  - change "$(obj)/../../../../vmlinux" in KBSS_SZ to "vmlinux"
>  - unexport LDFLAGS_vmlinux
>=20
> This commit takes the latter course because it is what I originally
> intended.
>=20
> Commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux")
> unexported LDFLAGS_vmlinux.
>=20
> Commit 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its
> prerequisite is updated") accidentally exported it again.
>=20
> We can clean up arch/arm/boot/compressed/Makefile later.
>=20
> [1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=3D98da874c4303=
5a490cdca81331724f233a3d0c9a
>=20
> Link: https://lore.kernel.org/all/Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X/
> Fixes: 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its prerequi=
site is updated")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> Changes in v2:
>   - Postpone the change for arch/arm/boot/compressed/Makefile
>   - Update the commit description
>=20
>  Makefile | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Once again thanks for the interesting details!

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--xWw0cIEXiYn5foMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmO6w50ACgkQB1IKcBYm
EmnzGA/+O2aKpk1N8ODj8JjSMoj0ktoih1U89phUqcH8yp4Tmrq0UiIK/e/f7xxF
V8csEx9sjXboWqpsnFefYSe3Ifa5yrF4IfpGI0HYgeB4tfCrUQfTgHqL4BwMvRtx
YtEkxNjakAbL+0m8Q9Qz+1jKjxIvCHX6GUGIFL9iwYNUSfF64UAqlSOqVub4Vgrs
VHrcSvG6n5xygkiitzhqOo3HBRN5/HSB8QSsIsn7X9S2I5RGZ8ybBF4BJQjLxKgO
OpISZLz693BGx7E5Bf11+2zK2pcz307dV9/nRj9whTip9Z1n5U6zmlye9m62YgQS
s+xggCH3JmfhWj8f2GNjfo3rVsZeGcT9RycSYylbSpNeL9AsCtjh+O6GBOsu6jgV
OjPtN9vv5KEqNzu4N3iC4qx9E9apVZ++m2LLvHbNsr76iNXsV6iyTHqdyXc4fwOF
hnjEgd+cJMqPnbk3FHFSxNtQV/CQvLcAImkeqOA/Yn0mVaN5qHmatIoEEEOJ5NwS
kLnRiaSX0GXBh9rVLj2dKkZl4tR/yGrjNDZNrZVu1CDpkHtdD0kAHnN9k9soVWey
PNofq6C2nAKM5NgqMXGsi3U2RSX5awheepK1HUDmoYN/IFUOLjujtH6nIQ2Yas9g
JCXu+5mBkkTQxOe+v2zxXz5oPtA5bYN9Mlcz/wQNhZhwVIoPyeI=
=MzXv
-----END PGP SIGNATURE-----

--xWw0cIEXiYn5foMi--
