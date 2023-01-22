Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3D6772B2
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAVVfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAVVfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:35:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F016AE0;
        Sun, 22 Jan 2023 13:35:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0RN36mpvz4xyF;
        Mon, 23 Jan 2023 08:34:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674423300;
        bh=vgWQMNWMOBeEgmRIMGTyD/Ft1sPNNTzyu9y34fCVk8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kox7UxlzDLpHNXbeT9tmCus0kD7YxekyPbq/0xkU3zjeQKgwglCgnfywhA4u29RlQ
         MNpCR4bhWm+Y7RtuxBBZw8GJQL4r/6FZJhn4fy8Dgg7njvffGITTVZ7ahn1rmYipNE
         MBrGSOEYOr9AQB1aC+KehQb/mf3whvGGFxtdVJsLz7gsn/SIzz44ysxZzOGr7Wzb/Y
         nnazBZ3uCafgeOrOKMRia3YJb8M5tjxXn6KyOws4dIU9qawlVaktVollGHlR9/aP/c
         PU4ygh6rrTXLN2iMQEyKFn965AjMTS28tmPDDEJzVKXbIMnHiiU6W/gUD1siw9j6/U
         w0Vx7wzLliNEw==
Date:   Mon, 23 Jan 2023 08:34:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
Message-ID: <20230123083458.45f3641c@canb.auug.org.au>
In-Reply-To: <61a0120a-4cff-90c0-6f87-4957aaee7a0b@kernel.dk>
References: <20230123080830.7d50fccd@canb.auug.org.au>
        <61a0120a-4cff-90c0-6f87-4957aaee7a0b@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iVJQIDUCZV/cJkn5NgggFCI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iVJQIDUCZV/cJkn5NgggFCI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Sun, 22 Jan 2023 14:30:15 -0700 Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/22/23 2:08=E2=80=AFPM, Stephen Rothwell wrote:
> >=20
> > Commit
> >=20
> >   24337ddf1ff4 ("io_uring: Enable KASAN for request cache")
> >=20
> > is missing a Signed-off-by from its committer. =20
>=20
> Fixed up, thanks.

Thanks.

Except you misspelled "Signed-off-by" :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/iVJQIDUCZV/cJkn5NgggFCI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNrAIACgkQAVBC80lX
0Gx37Af+LaA/dwy6gN1s09kONhcXZMMw2nEiV8uihi6czSHCsOZTBGJzoCO7pZ9d
GODGy+sDN123v4Pnk2gsoRVTHuMW781jVrM/XQof4/YMzNceqHdOFyzIiD97YL3C
f0CuWaOo1svUzcbpGlgaLHabZb/Xzq/O54myGeFIecNpVcnshci0H6h+jXNIW7F+
tnci3QdzhXJ0uq4q8KFU58rfnBpmM5uaP8w8YOgqNntXsPVLkqiuCI27NQcAVLMI
wjDA7XmgCTFqxCR0PQq7mchUDczJ4A6lu+4MJrrUUm2h15HnGB79vKEFCgXLjwh9
S4lQhX9nQYUCLHd04n5CLbtiY3rUHw==
=Gkrd
-----END PGP SIGNATURE-----

--Sig_/iVJQIDUCZV/cJkn5NgggFCI--
