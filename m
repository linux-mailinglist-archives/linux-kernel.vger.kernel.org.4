Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225E70E966
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbjEWXOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWXOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:14:21 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD80DA;
        Tue, 23 May 2023 16:14:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQqrh0lxzz4x2j;
        Wed, 24 May 2023 09:14:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684883653;
        bh=jfY1ZQA1iHV4JSZMNcgRNB7+bNhuN21X6QA4Zw31PQw=;
        h=Date:From:To:Cc:Subject:From;
        b=gwgoLNZhoHNvZsWkpt2RvXXZCsg/By75pyFy0sZawssTL0fgmv8OEUrg4DO9xvoX9
         Fe3B2MDgdADKPQffTLGwTmAEIvE+kd0hpDYihB3/pYxF/kdosEnzwvtUOt/94cMqY6
         1hxhjTtY5IMvMA+G5kcCXykB1in0JpHz8+Dou5Yy2Osj3CfQGAn6hAXJv1MOxSrHNK
         E6gDNI0RU48bHy4wb4v54atb8g/hkwgjW7XNW9kLi9+zfevoCu4L8NZPf8cd9BL0V9
         bTTNIqbpz5vS7imFxTgeLXCv3Xb6dNYt705SuMt14L5qHi8nJIM45ximo9SWIUxm2A
         kUVTttvbaJrRg==
Date:   Wed, 24 May 2023 09:14:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: linux-next: manual merge of the mtd-fixes tree with Linus' tree
Message-ID: <20230524091407.71b4a42e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3=scmLKFEkHmx.=+sNQ_Uvh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3=scmLKFEkHmx.=+sNQ_Uvh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mtd-fixes tree got a conflict in:

  MAINTAINERS

between commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree and commit:

  faa5e6cbb559 ("MAINTAINERS: Add myself as reviewer instead of Naga")

from the mtd-fixes tree.

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
index b484d589e51c,3678799f537c..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1761,22 -1771,6 +1761,22 @@@ S:	Odd Fixe
  F:	drivers/mmc/host/mmci.*
  F:	include/linux/amba/mmci.h
 =20
 +ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
 +M:	Miquel Raynal <miquel.raynal@bootlin.com>
- M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
++R:	Michal Simek <michal.simek@amd.com>
 +L:	linux-mtd@lists.infradead.org
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
 +F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
 +
 +ARM PRIMECELL PL35X SMC DRIVER
 +M:	Miquel Raynal <miquel.raynal@bootlin.com>
- M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
++R:	Michal Simek <michal.simek@amd.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Maintained
 +F:	Documentation/devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml
 +F:	drivers/memory/pl353-smc.c
 +
  ARM PRIMECELL SSP PL022 SPI DRIVER
  M:	Linus Walleij <linus.walleij@linaro.org>
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

--Sig_/3=scmLKFEkHmx.=+sNQ_Uvh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRtSL8ACgkQAVBC80lX
0GyTcQf+KhOYUEeS/dSwNUORYxdxoTCMDzFXDGMr384/7qgZf5/c362seRHyVFMv
GFlP1QsnOBw3UwtyFzQ562T7onohRJ47ldjSD9Xf6gmP+cSpfpSzOoqwr5rpnQSU
xdMJgCXliDOB++13HwDm71B2FzcYMRH6BCrAc1VJo5QKErcRs/DmjmZ1H3FWjqbp
L82SZVd+SaNDUfdmdy0hk6p6tn4NNfPcfPlq7ZZ1HtwzDivmYsSZyGpD/+EGF5Oj
jsApFmc7p0u/Br1AFeevUVoHnIx3/RV5l71Mnne0aQUoc/ZBfv/3XbZ2vaTwGcGf
eeMAqz+X9b5tTIP2QsXT1LYlB2ZWuA==
=A8CK
-----END PGP SIGNATURE-----

--Sig_/3=scmLKFEkHmx.=+sNQ_Uvh--
