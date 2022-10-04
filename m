Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D95F4C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJDXEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJDXEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:04:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90844B0CF;
        Tue,  4 Oct 2022 16:04:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhtYf3PPWz4x1D;
        Wed,  5 Oct 2022 10:04:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664924646;
        bh=vkw1pfzTvTHY7nMrUZhZNC6y25oDkSCN2BnPtzDF9Ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MdYt3Unh13reAB+SYjdnjFmhq/0qYb/lyU0qWzzzpeomZjyZJhx3INnVuFEfwHJDy
         YYQMWlRmCaClGJ6avQdTBTnCAA1fsT3yqSqapMCbh3i3AgfPmB87vUYtX4GxScQY/D
         RS4BkNimwzrLm+NMYa/eWvSjSyWCviWWgGuQnYp3FJ4bi2/s67Z4hDlM1734y+Raaf
         CuLpmKKy4i+PFg/Pnx/ftdYdo2wkUOk3J8FFWTR+iCMuGixglStBDjtGvFm6tYYca3
         NzdlGk0j6mQex+HiVWRzh1U7EC9hEB45lo8oU8neIoBuUivwxATUt0iHqqmMZXw/9L
         3B6WvClJ9oqkw==
Date:   Wed, 5 Oct 2022 10:04:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Eunhee Rho <eunhee83.rho@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the statx-dioalign tree with the
 f2fs tree
Message-ID: <20221005100404.3e3b1597@canb.auug.org.au>
In-Reply-To: <20221004095158.46d920d0@canb.auug.org.au>
References: <20221004095158.46d920d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r6zUz+FFUdL1vPFxp9p8Sb3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r6zUz+FFUdL1vPFxp9p8Sb3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Oct 2022 09:51:58 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the statx-dioalign tree got a conflict in:
>=20
>   fs/f2fs/f2fs.h
>=20
> between commit:
>=20
>   2958e881d590 ("f2fs: allow direct read for zoned device")
>=20
> from the f2fs tree and commit:
>=20
>   2db0487faa21 ("f2fs: move f2fs_force_buffered_io() into file.c")
>=20
> from the statx-dioalign tree.
>=20
> I fixed it up (I used the latter version of this file and applied the
> following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> From c5beb9e5e8c4a68c68dfbca7ddd21afa4ba3fa57 Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 4 Oct 2022 09:48:22 +1100
> Subject: [PATCH] f2fs: fix up for "f2fs: allow direct read for zoned devi=
ce"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/f2fs/file.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b1135f584677..996aad7c1e34 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -822,7 +822,12 @@ static bool f2fs_force_buffered_io(struct inode *ino=
de, int rw)
>  	/* disallow direct IO if any of devices has unaligned blksize */
>  	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
>  		return true;
> -
> +	/*
> +	 * for blkzoned device, fallback direct IO to buffered IO, so
> +	 * all IOs can be serialized by log-structured write.
> +	 */
> +	if (f2fs_sb_has_blkzoned(sbi) && (rw =3D=3D WRITE))
> +		return true;
>  	if (f2fs_lfs_mode(sbi) && rw =3D=3D WRITE && F2FS_IO_ALIGNED(sbi))
>  		return true;
>  	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
> --=20
> 2.35.1

This is now a conflict between the f2fs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/r6zUz+FFUdL1vPFxp9p8Sb3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM8u+QACgkQAVBC80lX
0GxH4Af+N1PMJDBvbSOW6xd9PN44VZskAbYPiflj/fsYiGNcvHg2BmtcYew5LVLQ
mnX5hE3mfwA6aY9Bror1yYXKizhgfGczFZOTi8dIHj0BpyEFfLHrBtYN/1D+WC4R
FT6rBHLstLnHuq30ayqTLVR9ryn/KQ5oBiiAClgYBCdqHGJYiGZrtPes+xKjGlmj
eFV2P/kemCpQzPOTK5TATQg/4201zM3JhU9siZOnNIvoWWXxU8jHI3YGhcr5rvJi
FKc2ujbewJY98CRDvN0rPIHdF+hW8AnKtK5Jnt5KsQ5bYvKIDLginBmwEQMqFxkH
R3U2QEvFJ8t3SbGfPcUqXGqWRy2DgQ==
=4Fr4
-----END PGP SIGNATURE-----

--Sig_/r6zUz+FFUdL1vPFxp9p8Sb3--
