Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF1D721ADA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFDW0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFDW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:26:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F52AD;
        Sun,  4 Jun 2023 15:26:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZBDH308Wz4x3x;
        Mon,  5 Jun 2023 08:26:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685917599;
        bh=LYKL2s/R2S+E6A0qazd/89JPM69t6YgFBNnwmVZH/7c=;
        h=Date:From:To:Cc:Subject:From;
        b=L1LNXSza24z1fOHXJmKye3wn+KjejOvgVEa+c0gt/BdauvDFET/l96v3bC+Rg52s4
         A+AWGRqIXNNVvebkmMMOugGPZPGKFKQPftQkT3rZGV+U9OhbnTPE2QZl2oNWRvHFNl
         YHSWajhztwcV/FZ029YvbIbBOGz0QAYfJ8mJok2bKBCfweSHGbqNI/Mm1lkhaWvhAX
         swpalkv7UOMU+p/21DBGqppDL2jG4UxKf051ia7L9Ykghyqow6Momqx2C4d6tM5IcO
         EfCfeDvun2Uo1FRbc1C3Jpvb4Tx1gYokgNdAzXYHMtMZha5j5IRe8m+N9wLzVQWhnW
         7dpJftmNc5Kug==
Date:   Mon, 5 Jun 2023 08:26:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-next tree
Message-ID: <20230605082638.3879839e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Pw_N5dTQFon=NcaPKQlGY7i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Pw_N5dTQFon=NcaPKQlGY7i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  2a7d6b9c55ba ("media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_li=
nks_to_pad()")
  2f16c95e7aa9 ("media: staging: media: imx: initialize hs_settle to avoid =
warning")

These are commits

  3a4cdef13fa3 ("media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_li=
nks_to_pad()")
  6970888d38be ("media: staging: media: imx: initialize hs_settle to avoid =
warning")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Pw_N5dTQFon=NcaPKQlGY7i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9D54ACgkQAVBC80lX
0Gyi1Qf+O3WGdCZu5Q/ubivugdYdsEZ4x7k4s+TreyjHMBwIsu8CZDw6QFQyij1I
BHm5dmvBLxeWoUuAUBJ6kqBNZRYJwdgP+XVAyxrnDInbe5KcK8UbqGpnc8xw3WHv
fLi0q+NhLx54lBJPWYJnDLH3rf3IYjyrS6/b/5iN9y58XcqSpmdYxZ8mgNIuppcU
x/3R51aKfiCMhdG8s9vn72dlgYbEQn+712OPHQvm3dCtlQDqAthPzYV9/2rDpwIZ
d9qByyjanQlQZfv/V6jJQ2oy2EYdldB6K472dBJ6Uk2v74OtNyhuh3HvM/CHbEM3
fLs4RQmEcUy6zKmtz0eRPExTFuFlTw==
=4FbY
-----END PGP SIGNATURE-----

--Sig_/Pw_N5dTQFon=NcaPKQlGY7i--
