Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74C7393B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFVA0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVA0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:26:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E2A1;
        Wed, 21 Jun 2023 17:26:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qmh4m6KjLz4wjC;
        Thu, 22 Jun 2023 10:26:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687393593;
        bh=19SFAqyiGHIjSeaYz7gu4pZOvtfALbexMUSRYuNdHw4=;
        h=Date:From:To:Cc:Subject:From;
        b=K2NPfU0uhfr4a623V49I9xDEFiNVzXEBZtWb2yE4khz5sixZ1qjbpqCfu6mCmGG6k
         Ovt7SbKc2rFxzqCeZ1Wa/a0zPIleyHzpDRydr0pxbat3bOON2mx8If449AhECiVwVW
         YhLBlSnhxFLTMtdrGlzzJPOcaTC9o0pGSvUNaQGxuw9esqGuwZNihZRs0WDVMFlK7K
         +pRts073PhQfLZVCs+T5AcBMQLxNbvV7rTgzGCEGR3TGRoALOERJKf739flpYmVvEo
         g9BPMtAEisCrjRbaLYUt4wA9jyfbs3BzNJ7zH7q5J72TRa5Idox/6YPsWV61oZYLUP
         Cgu1DztPm7NFA==
Date:   Thu, 22 Jun 2023 10:26:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the amlogic tree with the arm-soc tree
Message-ID: <20230622102630.263ae2b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7kMeHOL46Wi1SEsNy3paLl4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7kMeHOL46Wi1SEsNy3paLl4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amlogic tree got a conflict in:

  MAINTAINERS

between commit:

  724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")

from the arm-soc tree and commit:

  9e70e49474bb ("MAINTAINERS: add PHY-related files to Amlogic SoC file lis=
t")

from the amlogic tree.

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
index 7ad2bf6ac1af,9f769aa65936..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1912,7 -1915,8 +1912,8 @@@ L:	linux-arm-kernel@lists.infradead.or
  L:	linux-amlogic@lists.infradead.org
  S:	Maintained
  W:	http://linux-meson.com/
+ F:	Documentation/devicetree/bindings/phy/amlogic*
 -F:	arch/arm/boot/dts/meson*
 +F:	arch/arm/boot/dts/amlogic/
  F:	arch/arm/mach-meson/
  F:	arch/arm64/boot/dts/amlogic/
  F:	drivers/mmc/host/meson*

--Sig_/7kMeHOL46Wi1SEsNy3paLl4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSTlTcACgkQAVBC80lX
0GyURQgAl+Qbm7E2ysNSAIEmaeEJdqI4S7xHT6lY6Pjx2TqE4o22DDM+QYta5Q2g
A6rjVOHGVNn3aBDExOobs/ZdilyTkGCMd4kny2MJmMpFLTl2cKAgTo6AWV8OB01e
VeeOrP7MfQNeQgZVSQU4NSRG1P7XxujQWhjHdXJ5nabG9oZrUphbtUHBr+853MET
Io6tmj5lJHcXUtkT56RbD/xQ15HtUH2Dbzt9FBzBg/NM1OEPtgDzud0+wDwDhPjX
cx+ERt6xgT1CUOOMwYSKI7Q4Th4xLAJB5ICeaYMmrsz7V2gsiRJWapUmVQvk3NJL
pIo+0+RCh4wpQ1Kfew9WtE9oleVYxg==
=ZJRc
-----END PGP SIGNATURE-----

--Sig_/7kMeHOL46Wi1SEsNy3paLl4--
