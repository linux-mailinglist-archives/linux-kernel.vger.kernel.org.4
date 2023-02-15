Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1B26987E6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBOWal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjBOWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:30:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0455315545;
        Wed, 15 Feb 2023 14:30:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHCT60JfQz4x5R;
        Thu, 16 Feb 2023 09:30:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676500234;
        bh=Kt6oZlWNOjJAgDVEDmDiCoobLfG01+ebZqohe3TBGDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uq4h5Uo182XLp4tA9gr7yXAcxaQ2xRSwodsfuQzCX01YmU2g3oj+KuriWGlR+jQ5E
         NcRNG+KdFEka2KVj2HyKh5SEgaJWO6YoFJF4Q4JyuOxC0iRxe7sTw6eCLNXxRkGeFC
         Nem8vzsvy7lnDZcEUHcWIkY/KlyA91zZaSQwEeug2Uezptwrzd/Et5J5K02krQu722
         8BIo27xuf8nketd4tu0vY6TWL6d5rhE55HQB7MLf82RV/awu6CRCd0SCrscthfNoQt
         lRajMpyB74g1cCm30PEfQG4lqAt7+FBkheHYhoOhmKgbb2Hp5jz4h69hJjMGZ3F9mu
         3NEjPhwdpGW9A==
Date:   Thu, 16 Feb 2023 09:30:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the
 arm-soc tree
Message-ID: <20230216093033.111304fa@canb.auug.org.au>
In-Reply-To: <20230209094548.44b29fd5@canb.auug.org.au>
References: <20230209094548.44b29fd5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zVBciUgVX8PI0LZ9lSqHMNz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zVBciUgVX8PI0LZ9lSqHMNz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 9 Feb 2023 09:45:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the v4l-dvb-next tree got conflicts in:
>=20
>   drivers/media/platform/ti/davinci/vpbe_display.c
>   drivers/media/platform/ti/davinci/vpbe_osd.c
>   drivers/media/platform/ti/davinci/vpbe_venc.c
>=20
> between commit:
>=20
>   eeee69739353 ("media: davinci: remove vpbe support")
>=20
> from the arm-soc tree and commits:
>=20
>   eb78ca6a0496 ("media: ti/davinci: vpbe_osd: Drop empty platform remove =
function")
>   5204a5dce04b ("media: ti/davinci: vpbe_venc: Drop empty platform remove=
 function")
>   0d3732fb1b20 ("media: ti: davinci: vpbe_display.c: return 0 instead of =
'ret'.")
>=20
> from the v4l-dvb-next tree.
>=20
> I fixed it up (I removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and the v4l-dvb tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zVBciUgVX8PI0LZ9lSqHMNz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPtXQkACgkQAVBC80lX
0Gy+Ggf/QKsv2F0vQynX7yDsclbllvM6YTgRV+dkJV/HlmyddwK5TRxkG2I64Br9
eyvMz96LMGcpw4KqlSpTj24E7oFITRZTgwPgBwH78tmvTFmmYi8/Zhk4Ybbn24eC
EpKTVk8x1ijI3BgkSWbvER0Jx4UmwLX7V0dNSrv5xbxOMGrLXVgi5xgQW8Svwq6M
9oPjqqp9KTbosq1ytOGEoyaZhrctwwKH4+pjMPES/Rc5bdK5RL82I9WSq0Yt2ceH
WctOsp2H63m5xvMZlEQtj5GS50NtEHfFqEIbd17AHdJKR9s3ikdhWcFaSLGl49m7
4xByKwBTNDgfnTjCywIHA7gwYDCRuA==
=K4ul
-----END PGP SIGNATURE-----

--Sig_/zVBciUgVX8PI0LZ9lSqHMNz--
