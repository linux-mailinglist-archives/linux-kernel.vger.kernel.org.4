Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E330693C15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 03:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 21:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBMCNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 21:13:38 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC84FF3B;
        Sun, 12 Feb 2023 18:13:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFSYW4JF2z4x4q;
        Mon, 13 Feb 2023 13:13:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676254401;
        bh=bbcjEUJGsdDOVEMqLdw3YwdZqFRiTlcQcnrcQsgS1TY=;
        h=Date:From:To:Cc:Subject:From;
        b=ZdOiY72+IeaKHjjYL2/MV8tEYw5jignlndNWvLVSOj0Xgn4IDT3rbbAy9+22qUCU0
         rapQiDOtPJ6nDaWOJW31iefcr99lEljP0GgRsdE1ygovzHGrEpY7bFY+mjg3Svmddm
         HrqOfdxIbxHH0wFMJ2YH3f8v75hAumoSzOmpw8tamadIGCgXrcBH9CTFcWMl1s07+r
         M/JBOAquNZSCnjpwTeBpVX5VyM1KYu/CJB2VPEfNnFbUzolBhzPaDMIPZoV0z39sIX
         0dKgtIdQ7qQSYrSN8iHrrDo+cGhthryp9zfnei8pQG+r8LECaPuPLW5uT0kv3y8i/O
         LFnZS7WAdYd7g==
Date:   Mon, 13 Feb 2023 13:13:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: linux-next: manual merge of the staging tree with the v4l-dvb tree
Message-ID: <20230213131318.2fdaf4fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U3rHEJ6=z_Buc.uGIPn/nlC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U3rHEJ6=z_Buc.uGIPn/nlC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got a conflict in:

  MAINTAINERS

between commit:

  ba47652ba655 ("media: meye: remove this deprecated driver")

from the v4l-dvb tree and commit:

  eec8ccab1b57 ("most: add maintainer entry")

from the staging tree.

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
index ccbc53c08734,12a35773db78..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -14090,6 -14149,23 +14090,16 @@@ F:	drivers/regulator/mpq7920.
  F:	drivers/regulator/mpq7920.h
  F:	include/linux/mfd/mp2629.h
 =20
+ MOST(R) TECHNOLOGY DRIVER
+ M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+ M:	Christian Gromm <christian.gromm@microchip.com>
+ S:	Maintained
+ F:	Documentation/ABI/testing/configfs-most
+ F:	Documentation/ABI/testing/sysfs-bus-most
+ F:	drivers/most/
+ F:	drivers/staging/most/
+ F:	include/linux/most.h
+=20
 -MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
 -S:	Orphan
 -W:	http://popies.net/meye/
 -F:	Documentation/userspace-api/media/drivers/meye*
 -F:	drivers/staging/media/deprecated/meye/
 -F:	include/uapi/linux/meye.h
 -
  MOTORCOMM PHY DRIVER
  M:	Peter Geis <pgwipeout@gmail.com>
  M:	Frank <Frank.Sae@motor-comm.com>

--Sig_/U3rHEJ6=z_Buc.uGIPn/nlC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPpnL4ACgkQAVBC80lX
0GxEPQf+MjCkMihl1EVtouk+VSBhy6hV5PsA8mk+SLWnCzi1xLNnZaqCy7mqv5uZ
E+qNq95J558xYQETuSOIUBgfbLV8bhZqb4dq4MVLuDFEF0Pu0q12Dl7FPUeUABtf
gaBQZqI7YOxWE2fVlovbfo1+YFozZZzZ8HaBJWucxmTzCze8mfPvUvN7uvVA+Y4E
SOcruLN95OvbAnK/3BAYpXJhyX40hIIZ7PLzrVosZUN/FD0Hq2vrhPAvQLyTulXe
sPWX7DMMdiItT7bwQWJ28iRq5q/n2WVrSz2n2PrEv+s+v9bXUfvkFhrxGrsDV6+8
v3y2zbcpqT88fqXL8W5dLSuRqgsp4g==
=w8tJ
-----END PGP SIGNATURE-----

--Sig_/U3rHEJ6=z_Buc.uGIPn/nlC--
