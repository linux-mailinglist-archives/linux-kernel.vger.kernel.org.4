Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624A1677361
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 00:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAVXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 18:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAVXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 18:01:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CC018ABD;
        Sun, 22 Jan 2023 15:01:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P0TJF3FZcz4xZb;
        Mon, 23 Jan 2023 10:01:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674428511;
        bh=yQ7hL8V1d6N/GdcSCF+uExTlfY+LEaNIBvxpKLmJHAE=;
        h=Date:From:To:Cc:Subject:From;
        b=hWgxGeihYF+gpArJqjOxtHh0MEacjjNziid6zzi2yvfU9LikLYy+843Vi/1UQDgNZ
         +K68BlszSfwnZjHC6jFSRLbuojqvgaHldvDal2hYLYr9r6bRz8pqYP5lY+/tpUC4BA
         U8PphJsHdiwucJGwRpCQqjftLhDBa+KSq/GqPenbjPW6l4Vt2ktZtz9hIk34Y24yVb
         3+3wjDERZz26iicTriZfTzBQeKEoHuzvKIvPwF22PIygPkKdBh1qcMk86kVLGYbAq0
         1/kTYuXKyine9IJt9C7zVjxdelfNZOC+7tio5cmclM13Kt6Bs7UICMVGRkoktNT+hV
         q3J6pipj1uvAg==
Date:   Mon, 23 Jan 2023 10:01:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the v4l-dvb-next tree with Linus' tree
Message-ID: <20230123100147.5d8aff75@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W78ZZYFNhsOtmz7thiSwUpR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W78ZZYFNhsOtmz7thiSwUpR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb-next tree got conflicts in:

  MAINTAINERS

between commit:

  e0be11a833e8 ("MAINTAINERS: add networking entries for Willem")

from Linus' tree and commit:

  3673237b62a8 ("media: zr364xx: remove deprecated driver")

from the v4l-dvb-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 56c7cb44a42a,ba5254cd1002..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -21582,23 -21710,6 +21565,13 @@@ S:	Orpha
  W:	http://linux-lc100020.sourceforge.net
  F:	drivers/net/wireless/zydas/zd1201.*
 =20
- USB ZR364XX DRIVER
- M:	Antoine Jacquet <royale@zerezo.com>
- L:	linux-usb@vger.kernel.org
- L:	linux-media@vger.kernel.org
- S:	Maintained
- W:	http://royale.zerezo.com/zr364xx/
- T:	git git://linuxtv.org/media_tree.git
- F:	Documentation/admin-guide/media/zr364xx*
- F:	drivers/staging/media/deprecated/zr364xx/
-=20
 +USER DATAGRAM PROTOCOL (UDP)
 +M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
 +S:	Maintained
 +F:	include/linux/udp.h
 +F:	net/ipv4/udp.c
 +F:	net/ipv6/udp.c
 +
  USER-MODE LINUX (UML)
  M:	Richard Weinberger <richard@nod.at>
  M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>

--Sig_/W78ZZYFNhsOtmz7thiSwUpR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPNwFwACgkQAVBC80lX
0GzemQf/UuDwXGZIjgnMEKAcTIV4cFSlMZIc8BvzfvDID4jO0k3FEpY/yMnY+goQ
qJIPQI+OsmhcBwRvG3Jv8hQ9t63kq9OeEruPAQH5TNS6f4MyTBckIhq+VUEXDKQ4
1347cU0bY2cbxFK8YkVW1TvsDPGA79C0cQFkujYyjU2ttHdPqqoQndW9phUHOXI4
x00uhhQFwK6H0/+d1p5/qCGfnpkHLzc7daUfwqNRXZseUNH06p5Ly2FNdeuRrsCs
izwylwWPJzOrq6vh/GG2Y///KtopVrsGAyKhaBODL6AiQk6xXrl9+E34oAzLlIp6
kP4Ox7xqR+tO8lQpmeIbtywW0VU1pw==
=dDwg
-----END PGP SIGNATURE-----

--Sig_/W78ZZYFNhsOtmz7thiSwUpR--
