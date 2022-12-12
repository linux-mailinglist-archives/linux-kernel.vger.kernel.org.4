Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB65C64AB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiLLXNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiLLXMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:12:52 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144816406;
        Mon, 12 Dec 2022 15:12:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWHTr60XTz4xN4;
        Tue, 13 Dec 2022 10:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670886769;
        bh=ZmQuWEiTl4pJ0qMkgHfKvSKtoabOfj1EshSB7dzTg6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VtdQ/4eQkUGOy61/icVh2YaWUQVSgGlyy3OuIuvL0hIEHHFFSlykKpfcj8C47HjnG
         DLiAhYgPxEpeWTs0ZtnCKQV8mGwo75gN11mPioMjCZFu27sX0AEl7vFWgKsuCscOxE
         ReCF24oL0K7hCvCzn7blqkuinWQhXdLUCZahWR7wHgoPhKQQd110CJ4uiKKVa2XtEw
         nQ7cyMsZez19Ni8u9hu8G/kGIeDz0ECUkNwEYPIYUMhOU80GddU0Qu0tGiXjOH8pOq
         eDJrvks9UsrcwD5a0mRS7G8zHBqiLUj+y4It4aUzN27dpfBwHLdOi15AzwNa98+Y/P
         ODRQZZQJrng4A==
Date:   Tue, 13 Dec 2022 10:12:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the execve tree with the vfs tree
Message-ID: <20221213101247.1d252d9d@canb.auug.org.au>
In-Reply-To: <20221128143704.3fe8f7b1@canb.auug.org.au>
References: <20221128143704.3fe8f7b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LrhL4FzPAU2BHsHU1D80OAu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LrhL4FzPAU2BHsHU1D80OAu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 28 Nov 2022 14:37:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the execve tree got a conflict in:
>=20
>   fs/binfmt_elf.c
>=20
> between commit:
>=20
>   9a938eba8d28 ("kill coredump_params->regs")
>=20
> from the vfs tree and commit:
>=20
>   8f6e3f9e5a0f ("binfmt: Fix whitespace issues")
>=20
> from the execve tree.
>=20
> I fixed it up (I just use the former where they conflicted, so may have
> lost some white space fixups) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

This is now a conflict between the vfs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LrhL4FzPAU2BHsHU1D80OAu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOXtW8ACgkQAVBC80lX
0Gw/dAf/dmzLHBULiNcamwSftEMhh66FN40pjtm/AIWJx5xCT2klbW6XziMNVSE/
e3tLg0Vm2TYhrqJZrMhVBpo+HwkRTqFZTC06G5JJOxR66FrQKOmdqwuxRcqz4d0o
QJO7WW2VLI/TUQCLp4dApHDn/qTsJ0b3ujCyOjQ8zTNXKNiU+F8/PjsgjeCA7J2C
nIR0IKxyRNPEAjVw2MzPL7hXwpdZbe1M1Lf+iDUgbGQUGnImzmNwLzWQ2TyL8PV8
3wFBf0wRVhu9EaB80bSVcP6ec6Qoh11mYcttBEZwjR2jZCixmkSg/vXF75lQa8BK
FEWzIRcQHCfZkoygVrLnKrtMmCRKwA==
=9Yx0
-----END PGP SIGNATURE-----

--Sig_/LrhL4FzPAU2BHsHU1D80OAu--
