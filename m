Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27784642231
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLEELR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLEELM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:11:12 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4610B4F;
        Sun,  4 Dec 2022 20:11:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NQVTn1m8Wz4xND;
        Mon,  5 Dec 2022 15:11:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670213469;
        bh=B1DH3ySHKN6hQxNG7KtN/gWXRvUpKwe4vTB/QmeoCIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A99GV9fIKrHHG3bXS+Jpl5KSdLwXw300lPIWncUq9e9RXpEmJ84W0aaDuMK1X8Jqy
         HAJbygLCJZ7GX/XtdbDJnX1VIsqStmTPaqtDpcI0Cu8c8NZUruRSwUs1JdR57FGtLi
         kLbTXMyUdLEnA6LHBVs63Ih+WI/j4dFCWWePuKBD07kbE9hWxKP9hcD+cRT4doJYfn
         QBDCECnUXHHw5nEfhoBy/ZgiBDDKPh2QlbLiW9ASnFERhsb3/C4uch5VSPLRkWR4Gr
         rDYxEaf55NOK9lWpALZGv0+ObB9smOHGlFhdJ9gfKIMCvhFc81hzF4qv31Hy7ft1J/
         l+upJsGDcM+9w==
Date:   Mon, 5 Dec 2022 15:11:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, Gao Xiang <xiang@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the erofs tree
Message-ID: <20221205151107.05579d52@canb.auug.org.au>
In-Reply-To: <Y41h7hz12QXQaSYS@B-P7TQMD6M-0146.local>
References: <20221205092415.56cc6e19@canb.auug.org.au>
        <Y41h7hz12QXQaSYS@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BSu3Op1WMDlbMXA2a781hFT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BSu3Op1WMDlbMXA2a781hFT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gao,

On Mon, 5 Dec 2022 11:13:50 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> w=
rote:
>
> On Mon, Dec 05, 2022 at 09:24:15AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the vfs tree got a conflict in:
> >=20
> >   fs/erofs/fscache.c
> >=20
> > between commits:
> >=20
> >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mo=
de")
> >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mo=
de")
> >=20
> > from the erofs tree and commit:
> >=20
> >   89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mo=
de")
> >=20
> > from the vfs tree. =20
>=20
> Is the commit from the vfs tree correct?
>=20
> The conflict fix looks good to me (we tend to enable large folios in the
> next cycle.)

The commits should be

  89175ef1262d ("erofs: switch to prepare_ondemand_read() in fscache mode")
  a21274e993a6 ("erofs: support large folios for fscache mode")

from the erofs tree and

  de4eda9de2d9 ("use less confusing names for iov_iter direction initialize=
rs")

from the vfs tree.

Cut and paste weirdness caught me again :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/BSu3Op1WMDlbMXA2a781hFT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmONb1sACgkQAVBC80lX
0GzOFggAlwu3mKOVKfVFh8bKoRysoRJ2X/daFw/Jg4c4YevaFil52yuJ1wmxO5XD
yK+qtZagnmU19mS5PidFZwN0/XOi5MzF3kuxsNiG2Ni9XGOk6hgM8Lv9qykqB/uc
uKvieUhUj8j3FL0tgM1+ayBg+5M8dMwum5OgtTYIv3JNaridWHNhtXUNsgHBWzdc
kql81SPZS39x66Wwi6HolCAmkd859YBpsx81dA7zUYGXoPqsDRefLE1w3bGjH0a3
VGzIfGpuBdlx5cbr2An22GhkV+4AAGQdsMemq2tg1L+feA9EUfJoaXXVys3vLQl7
h6t3jBP5iahQHeVlDsE1aY9exxPGlw==
=RN8q
-----END PGP SIGNATURE-----

--Sig_/BSu3Op1WMDlbMXA2a781hFT--
