Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BEC5F4BCE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJDWYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiJDWYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:24:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D486CD2C;
        Tue,  4 Oct 2022 15:24:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhsgG5hXSz4wgv;
        Wed,  5 Oct 2022 09:23:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664922238;
        bh=PJvV9GSwTzxUzZ3q+upLLSeckY4hE3k1CD2xrv4ZpQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TD8Xgt/gOUT22IwM+gaJEZ1xc7TioQmCi6m5aYHunoTzLhsNagggDAf4U60QyKFoz
         CUTGxK9T46RF233NpzR6UnxxPNhe2DyLu3ZZv1EvPQM6KURU/Rv9veIY/67dlWZmiJ
         uWOXT4TtcD+wvT0tEnxhT+xWXx/wcnQ+pchTodOPbG77d9JKGfjy/2loxUswIx8O2W
         NkZWvskeN+M/aM6VnWOj4npStm5V90spFxttPQpUw+z503lztT4WfqX2Zr7tjLwhq1
         05m21awBdM135AKax+SoDL9QwYd9PQ7LJeIKGIHeAvaLSaqpiaK+rCZGdlRCCALS4k
         E/CVCxyLaUQuA==
Date:   Wed, 5 Oct 2022 09:23:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     broonie@kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20221005092353.78eb0160@canb.auug.org.au>
In-Reply-To: <20220927181647.487727-1-broonie@kernel.org>
References: <20220927181647.487727-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=dwaqcMymkfiiQn=D7GB4.v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=dwaqcMymkfiiQn=D7GB4.v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 27 Sep 2022 19:16:47 +0100 broonie@kernel.org wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>=20
>   Makefile
>=20
> between commit:
>=20
>   0cc1b22fa606e ("kbuild: list sub-directories in ./Kbuild")
>   ca5f20da2ffcb ("kbuild: move .vmlinux.objs rule to Makefile.modpost")
>=20
> from the kbuild tree and commit:
>=20
>   d64ddbd68af8f ("Kbuild: add Rust support")
>=20
> from the rust tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc Makefile
> index 2b4980490ecb2,c759ee3152544..0000000000000
> --- a/Makefile
> +++ b/Makefile
> @@@ -789,7 -862,11 +861,10 @@@ KBUILD_CFLAGS +=3D $(stackp-flags-y
>  =20
>   KBUILD_CFLAGS-$(CONFIG_WERROR) +=3D -Werror
>   KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) +=3D -Wno-array-bounds
>  -KBUILD_CFLAGS +=3D $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>  =20
> + KBUILD_RUSTFLAGS-$(CONFIG_WERROR) +=3D -Dwarnings
> + KBUILD_RUSTFLAGS +=3D $(KBUILD_RUSTFLAGS-y)
> +=20
>   ifdef CONFIG_CC_IS_CLANG
>   KBUILD_CPPFLAGS +=3D -Qunused-arguments
>   # The kernel builds with '-std=3Dgnu11' so use of GNU extensions is acc=
eptable.
> @@@ -1098,9 -1182,16 +1179,8 @@@ export MODORDER :=3D $(extmod_prefix)modu
>   export MODULES_NSDEPS :=3D $(extmod_prefix)modules.nsdeps
>  =20
>   ifeq ($(KBUILD_EXTMOD),)
>  -core-y			+=3D kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
>  -core-$(CONFIG_BLOCK)	+=3D block/
>  -core-$(CONFIG_IO_URING)	+=3D io_uring/
>  -core-$(CONFIG_RUST)	+=3D rust/
>  -
>  -vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, \
>  -		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
>  -		     $(libs-y) $(libs-m)))
> --
>  -vmlinux-alldirs	:=3D $(sort $(vmlinux-dirs) Documentation \
>  +build-dir	:=3D .
>  +clean-dirs	:=3D $(sort . Documentation \
>   		     $(patsubst %/,%,$(filter %/, $(core-) \
>   			$(drivers-) $(libs-))))
>  =20
> @@@ -1497,7 -1585,7 +1581,8 @@@ endif # CONFIG_MODULE
>   # Directories & files removed with 'make clean'
>   CLEAN_FILES +=3D include/ksym vmlinux.symvers modules-only.symvers \
>   	       modules.builtin modules.builtin.modinfo modules.nsdeps \
> - 	       compile_commands.json .thinlto-cache .vmlinux.objs
>  -	       compile_commands.json .thinlto-cache rust/test rust/doc
> ++	       compile_commands.json .thinlto-cache .vmlinux.objs \
> ++	       rust/test rust/doc
>  =20
>   # Directories & files removed with 'make mrproper'
>   MRPROPER_FILES +=3D include/config include/generated          \
> diff --git a/Kbuild b/Kbuild
> index 8a37584d1fd6b..5f4a23fc87b63 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -91,6 +91,7 @@ obj-$(CONFIG_BLOCK)	+=3D block/
>  obj-$(CONFIG_IO_URING)	+=3D io_uring/
>  obj-y			+=3D $(ARCH_LIB)
>  obj-y			+=3D drivers/
> +obj-$(CONFIG_RUST)	+=3D rust/
>  obj-y			+=3D sound/
>  obj-$(CONFIG_SAMPLES)	+=3D samples/
>  obj-$(CONFIG_NET)	+=3D net/

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/=dwaqcMymkfiiQn=D7GB4.v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8snkACgkQAVBC80lX
0Gx3Wgf/c5htheFHnK3X9gd9vcZjBc4a/Kr8CTtDQqm+fPy68fzjG+HjzNhFB6uB
ZOye8h8HRMkEUDtY2PmP3iY8z64FWQaxNLgbVu3/PkR/MuBHj7ZpfLQD1fogAlZw
YuT1PB2nQajIuAIkdxPEVg5l+unqT5wEMbdu+NVw4s3qsZ88MP6wo2Nxb4L4suHU
zG9IROopaanPl+fOjQkPNh8MMBwfxkUDF+rS208nw9M/DYu+5UIG8Tav+Sjd75Jz
6qedEX2L9Pr30JOUt0Sbra24/+Fd0rJQaEwAMBmXJbcDq/DugTztfcEi0ZdpRY8D
AEivesbql6lf8pEwmae6jT62MvDVIg==
=wuWl
-----END PGP SIGNATURE-----

--Sig_/=dwaqcMymkfiiQn=D7GB4.v--
