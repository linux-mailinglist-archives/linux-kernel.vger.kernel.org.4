Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74765697294
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBOAQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBOAQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 19:16:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C410030184;
        Tue, 14 Feb 2023 16:16:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGdsj4Kxyz4x4r;
        Wed, 15 Feb 2023 11:16:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676420187;
        bh=BbNn6Pgl+xjsw/pPrE8cV2dCSLevjgOOJD49Mzbz0Bs=;
        h=Date:From:To:Cc:Subject:From;
        b=DtgkI+GbHy3dmcoX6/nN47rCf+8HR5zHhn5MvtRgNiE0Lf18Pop5po6BBAsKLXteK
         hO12dvDBxDcqY0387PiGfpH1CC9n+Fgmit38ALla8/XjQChAR0WgZtkN6vXU91XHCU
         2+41vhorFb6jrn6puAbKO4wiLZHmPNr2/dulBmEGg+H3/9xwsbB2Qh9sNRkZpcis4x
         Ky9itz8q8uK/EILIpJobxpw+AuGO2QNMVMZZnVi5pAlMfg67dHQnQd5jDO2wqe+KVV
         sYpM982haAcuk5+dcCozx2MNjw+QG4LzOxXroPO/iRDxWTMVXrkeKPZpm6WzPJaqz9
         8MYUvljyuWd/g==
Date:   Wed, 15 Feb 2023 11:16:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>
Subject: linux-next: manual merge of the mmc tree with the arm-soc, crypto
 trees
Message-ID: <20230215111623.06d9aa24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xYWY+F03bDGzVDc1ewxMDwP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xYWY+F03bDGzVDc1ewxMDwP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mmc tree got a conflict in:

  MAINTAINERS

between commits:

  08b9a94e8654 ("soc: starfive: Add StarFive JH71XX pmu driver")
  c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")

from the arm-soc, crypto trees and commit:

  bfde6b3869f5 ("mmc: starfive: Add sdio/emmc driver support")

from the mmc tree.

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
index 9262a1d7203d,71355c68a237..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -19840,25 -19926,12 +19840,31 @@@ F:	Documentation/devicetree/bindings/=
re
  F:	drivers/reset/reset-starfive-jh7100.c
  F:	include/dt-bindings/reset/starfive-jh7100.h
 =20
+ STARFIVE JH7110 MMC/SD/SDIO DRIVER
+ M:	William Qiu <william.qiu@starfivetech.com>
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/mmc/starfive*
+ F:	drivers/mmc/dw_mmc-starfive.c
+=20
 +STARFIVE JH71XX PMU CONTROLLER DRIVER
 +M:	Walker Chen <walker.chen@starfivetech.com>
 +S:	Supported
 +F:	Documentation/devicetree/bindings/power/starfive*
 +F:	drivers/soc/starfive/jh71xx_pmu.c
 +F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 +
 +STARFIVE SOC DRIVERS
 +M:	Conor Dooley <conor@kernel.org>
 +S:	Maintained
 +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 +F:	drivers/soc/starfive/
 +
 +STARFIVE TRNG DRIVER
 +M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
 +S:	Supported
 +F:	Documentation/devicetree/bindings/rng/starfive*
 +F:	drivers/char/hw_random/jh7110-trng.c
 +
  STATIC BRANCH/CALL
  M:	Peter Zijlstra <peterz@infradead.org>
  M:	Josh Poimboeuf <jpoimboe@kernel.org>

--Sig_/xYWY+F03bDGzVDc1ewxMDwP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPsJFcACgkQAVBC80lX
0GyVyQf/WkesqKQgdqnkmU9O1rz8bojh62kuao4DrPg3KM8fZ9oYae7IlzoU8/xm
MqU1bzcN1+4984cFpI035ua1vKgDsLc/JfBvEzbxdCMaM/fuJ09U5fiX14jf2pR7
TLKdW0rmTs4hk2HyD1KfmDezsFy8d6mCnPxKvU5zTHazqYANFAwuE3yC0vuHGf+s
fsp7xPSLRK9Dj+opFY5OfrrF4QBv8IY7Dr+zNEqXegz50xyWheFeHM+YZeRzFEkL
lZatSkrzB8cqfkZzs5keA9YqqWLYX2yefofxOBXPPJGBDfGWdeA4p5fQUrHzTjHX
3IAPsIdrqXbp1iwdNHWmEEzRVSI+kA==
=VMnB
-----END PGP SIGNATURE-----

--Sig_/xYWY+F03bDGzVDc1ewxMDwP--
