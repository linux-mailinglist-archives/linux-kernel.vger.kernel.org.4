Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1914F61E9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiKGDwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiKGDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:52:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6FEE86;
        Sun,  6 Nov 2022 19:52:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5HPN4G3Hz4xG8;
        Mon,  7 Nov 2022 14:52:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667793160;
        bh=/W09fEjEk6dmxq8VJiAMaKMbqp+5ilZYFXnZP85X8KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kevqY741sjDbqsZAZFYAGctC09Qb6ODcncol6a0TSNrS8l8cYqZNRCek+tMn40uS4
         uXCk6J+z3Gu6lEmARbRvXSKTjjddMDLx22mvtytF/0ZohJ80sxtCO1Xa4gEPLiwOkl
         mrIqiGVlxrrD8Sf1AeivVaiEBjwMj6bdE9yfVXWpzZjflkM11zOUXBYyHu2Btr+t3R
         S9AgzcjRLZiDfLm8KqlVtvTMZ8VjBgY0Z3ocrWEnLiXselvCG9uctTPc1GubwbxR+M
         DXKKiAzyXfmAADYsBAXC09kkia0WARrW8ii8WPdBF/IQLVTfcTa/cthphfnrAdZRg/
         Wy9dYvBLaxTYw==
Date:   Mon, 7 Nov 2022 14:52:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc-fixes
 tree
Message-ID: <20221107145238.208d517a@canb.auug.org.au>
In-Reply-To: <94003e66-399f-2c13-0ad5-72d5c6e87da3@huawei.com>
References: <20221031083917.6944b95b@canb.auug.org.au>
        <20221107084318.5a83394a@canb.auug.org.au>
        <94003e66-399f-2c13-0ad5-72d5c6e87da3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b/n=SAtgraly9H1nM6C=w4D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b/n=SAtgraly9H1nM6C=w4D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Mon, 7 Nov 2022 11:03:39 +0800 Chen Zhongjin <chenzhongjin@huawei.com> w=
rote:
>
> On 2022/11/7 5:43, Stephen Rothwell wrote:
> >
> > On Mon, 31 Oct 2022 08:39:17 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> >>
> >> After merging the sound-asoc-fixes tree, today's linux-next build (arm
> >> multi_v7_defconfig) produced this warning:
> >>
> >> WARNING: modpost: sound/soc/snd-soc-core.o: section mismatch in refere=
nce: init_module (section: .init.text) -> snd_soc_util_exit (section: .exit=
.text)
> >>
> >> Introduced by commit
> >>
> >>    6ec27c53886c ("ASoC: core: Fix use-after-free in snd_soc_exit()") =
=20
> > I am still getting this warning. =20
>=20
> I compiled linux-next/master and didn't find the warning.
>=20
> Also I noticed that the fix patch 06ba770a799f ("ASoC: soc-utils: Remove =
__exit for snd_soc_util_exit()") is on the tree.
>=20
> Have no idea what's going wrong. Could you please check whether this fixu=
p takes effect?

That fix patch is in the sound-asoc tree (and makes the warning go
away), but the patch causing the warning is in the sound-asoc-fixes
tree ... so the latter patch needs to be moved into the
sound-asoc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/b/n=SAtgraly9H1nM6C=w4D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNogQYACgkQAVBC80lX
0GxOFAf7Bpbk9iVoIMCWv8sbCN1zDbKi/2Wa26rDJkU1UTEq7CGI0ojKwSVYmz2H
Ll1ZjYCrG4pukrCaokS5riPXF4Q4cN1SLf6ogZ01QbOG0D3iqa5Rs5SdDysEYIPx
s33AdikvYE13phqmjjAeg+u7n0HA0XVi/NiN+jKkSCbqMnfUDbzbNQdIElfDdJLa
C4+fSb84uNINV/exx82m+pVN0yEcf9seFHovouVEchSVFGGmzMQruEE8ja4j+35L
B7+lWwRNrBP6lJl/zyUy6mtBKZvIde+lAtH6uhCObD4T34C/AS2tpxU3xwEoPTpF
Nmo36NMY3/hzFXM6yXY3rj1XxzFp2A==
=9/Rn
-----END PGP SIGNATURE-----

--Sig_/b/n=SAtgraly9H1nM6C=w4D--
