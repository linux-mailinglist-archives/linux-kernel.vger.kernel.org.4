Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473D45F90B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiJIW0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 18:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiJIWZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 18:25:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3793DBE0;
        Sun,  9 Oct 2022 15:18:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MlxHZ2mpPz4wgv;
        Mon, 10 Oct 2022 09:17:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665353850;
        bh=5LhU91hzXcsdTITP/y2kFOEOJhWJVytyRhyKH9Dkk0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ztag6pwhjM9Dzx9O0gIZXwZoaGVe/BQCJG4sFGH0vTPhTIb1LSnBklRdTUg4wAa5g
         EMRIDExQ8E8TuYImGPFwEIubNbN3KD4IvSSKkzQsdPkVUOm8t5ehUGYpTuMuFmBVAp
         Tly22HtZ3S3u2Xc6n2vi6t8Juie+09x4KLvE/PO0uqxFGiydgMoutewRFaFH4Lxdzf
         Q5ASQQIYYmbXhSF1sh5hNDx+kQyPT2aalTEA0/kGk5qQruY7v7NXpGTcaOrvUUxGNX
         qSQIgO3+151nuI7R30ArfTDBZ9mxIXqD2bbJRapx2dZJdt7Omgr2NSaBB6yY47li+i
         1hbeSDar7RhYg==
Date:   Mon, 10 Oct 2022 09:17:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the kbuild
 tree
Message-ID: <20221010091728.479da473@canb.auug.org.au>
In-Reply-To: <20221004091606.71418ddc@canb.auug.org.au>
References: <20221004091606.71418ddc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FjJq/BB9oL1OU8/74gW1U78";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FjJq/BB9oL1OU8/74gW1U78
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Oct 2022 09:16:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/powerpc/Makefile
>=20
> between commit:
>=20
>   ce697ccee1a8 ("kbuild: remove head-y syntax")
>=20
> from the kbuild tree and commit:
>=20
>   dfc3095cec27 ("powerpc: Remove CONFIG_FSL_BOOKE")
>=20
> from the powerpc tree.
>=20
> I fixed it up (I used the former version of this file and added the
> following merge fix patch) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 4 Oct 2022 09:13:46 +1100
> Subject: [PATCH] powerpc: fix up for "kbuild: remove head-y syntax"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  scripts/head-object-list.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> index dd2ba2eda636..e8219d65c3b7 100644
> --- a/scripts/head-object-list.txt
> +++ b/scripts/head-object-list.txt
> @@ -34,7 +34,7 @@ arch/powerpc/kernel/head_44x.o
>  arch/powerpc/kernel/head_64.o
>  arch/powerpc/kernel/head_8xx.o
>  arch/powerpc/kernel/head_book3s_32.o
> -arch/powerpc/kernel/head_fsl_booke.o
> +arch/powerpc/kernel/head_85xx.o
>  arch/powerpc/kernel/entry_64.o
>  arch/powerpc/kernel/fpu.o
>  arch/powerpc/kernel/vector.o
> --=20
> 2.35.1

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FjJq/BB9oL1OU8/74gW1U78
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNDSHgACgkQAVBC80lX
0GwuBggAmO8EhxNN2jAtp3nrStgr7Uqe2ZKLDOaZg0d3R6w4GIj5OQn8bhXRYjrr
YscC5o5rSOuoe2Z26+vXQzHiOLV02FVtfL/gpyf1efqZ3BR1+JN/kQCIbkSHEgie
R7B4/X9mOoll7MsWUAmpCmM71ccgPl9lI4SKygAcJimN8YxwDvGhjXNpsVY9JgRN
Dt6f9ovcl3gjD9jWVS0JtfuXwMp7vG0SR8c6LEC+G9GA0nqZY+cexQrPK5feAGbL
3XAXdXlXjYyZfGLixJ24HZnU4lPA6F5pbfts6cz8jVk8DRRSfqDxrlzvqXuls54C
nYvH+rLQ7bPKy9bHg3M1vxKcDGn2nA==
=zYnB
-----END PGP SIGNATURE-----

--Sig_/FjJq/BB9oL1OU8/74gW1U78--
