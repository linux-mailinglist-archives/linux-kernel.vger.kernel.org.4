Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB4715245
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 01:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjE2XUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 19:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjE2XUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 19:20:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14DEB5;
        Mon, 29 May 2023 16:20:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVWhf1YDSz4x3k;
        Tue, 30 May 2023 09:20:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685402402;
        bh=JSVDY/yQEAokY04F0M3R7T9qnLRPv9UpGlq82avVifg=;
        h=Date:From:To:Cc:Subject:From;
        b=WDFx2hiMPO8O5Q3Qx8xyJzTVVi1UqhJphzerVfmvO+cpXDzJ/ymuO3iDXfwR2/bqe
         Z5g88/xw746WlyHpnvI2AQqGQw826xjwgu5p1deJyPK6oXJ2u/5MvDp8s3yg7HAk9g
         G3QXOATa1LgP2EvmJNiiJE5k5oyZ51lyQDcRtRHDN4x5mwlh1gLxvJTuSViopg5SY9
         tnbEA7cjl2gelmwUDN9Tb24Fpvmj6BCTItn9EeIns/TKquqWAoKfYdoqVry3MvU+kH
         1Xj+6HY07kNFkVYyYyKf4s5tvxMPM6rRKs8evuz1mUngwtUn7CZq7+ZRC89OdXxN/n
         8P2Z3kjpHSB1w==
Date:   Tue, 30 May 2023 09:20:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the broadcom tree with Linus' tree
Message-ID: <20230530092000.256732c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SJfC87q9xCYp9F8FTWksNl2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SJfC87q9xCYp9F8FTWksNl2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the broadcom tree got a conflict in:

  MAINTAINERS

between commit:

  80e62bc8487b ("MAINTAINERS: re-sort all entries and fields")

from Linus' tree and commit:

  31345a0f5901 ("MAINTAINERS: Replace my email address")

from the broadcom tree.

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
index 062962cb35aa,040ffd682131..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3910,8 -3913,36 +3910,8 @@@ F:	drivers/net/dsa/bcm_sf2
  F:	include/linux/dsa/brcm.h
  F:	include/linux/platform_data/b53.h
 =20
 -BROADCOM BCMBCA ARM ARCHITECTURE
 -M:	William Zhang <william.zhang@broadcom.com>
 -M:	Anand Gore <anand.gore@broadcom.com>
 -M:	Kursad Oney <kursad.oney@broadcom.com>
 -M:	Florian Fainelli <florian.fainelli@broadcom.com>
 -M:	Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
 -R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadco=
m.com>
 -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 -S:	Maintained
 -T:	git https://github.com/broadcom/stblinux.git
 -F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
 -F:	arch/arm64/boot/dts/broadcom/bcmbca/*
 -N:	bcmbca
 -N:	bcm[9]?47622
 -N:	bcm[9]?4912
 -N:	bcm[9]?63138
 -N:	bcm[9]?63146
 -N:	bcm[9]?63148
 -N:	bcm[9]?63158
 -N:	bcm[9]?63178
 -N:	bcm[9]?6756
 -N:	bcm[9]?6813
 -N:	bcm[9]?6846
 -N:	bcm[9]?6855
 -N:	bcm[9]?6856
 -N:	bcm[9]?6858
 -N:	bcm[9]?6878
 -
  BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
- M:	Florian Fainelli <f.fainelli@gmail.com>
+ M:	Florian Fainelli <florian.fainelli@broadcom.com>
  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadco=
m.com>
  L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@@ -4007,34 -4039,6 +4008,34 @@@ N:	brcmst
  N:	bcm7038
  N:	bcm7120
 =20
 +BROADCOM BCMBCA ARM ARCHITECTURE
 +M:	William Zhang <william.zhang@broadcom.com>
 +M:	Anand Gore <anand.gore@broadcom.com>
 +M:	Kursad Oney <kursad.oney@broadcom.com>
- M:	Florian Fainelli <f.fainelli@gmail.com>
++M:	Florian Fainelli <florian.fainelli@broadcom.com>
 +M:	Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
 +R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadco=
m.com>
 +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 +S:	Maintained
 +T:	git https://github.com/broadcom/stblinux.git
 +F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
 +F:	arch/arm64/boot/dts/broadcom/bcmbca/*
 +N:	bcmbca
 +N:	bcm[9]?47622
 +N:	bcm[9]?4912
 +N:	bcm[9]?63138
 +N:	bcm[9]?63146
 +N:	bcm[9]?63148
 +N:	bcm[9]?63158
 +N:	bcm[9]?63178
 +N:	bcm[9]?6756
 +N:	bcm[9]?6813
 +N:	bcm[9]?6846
 +N:	bcm[9]?6855
 +N:	bcm[9]?6856
 +N:	bcm[9]?6858
 +N:	bcm[9]?6878
 +
  BROADCOM BDC DRIVER
  M:	Justin Chen <justinpopo6@gmail.com>
  M:	Al Cooper <alcooperx@gmail.com>

--Sig_/SJfC87q9xCYp9F8FTWksNl2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR1MyAACgkQAVBC80lX
0GxIFAf/QENvpcvx5SEpRMKTNLdj3chVGort6f6nNn/fqk1Qu8G4u1B2gY7A1Vr1
szaEbFI3xiydeBNz5J9FvYZIhR2oTDER5ela0gvO0ZvD4snBiF/BiLN2z4GEtUU+
eFjg1a8ov70rzYPr4YoTOlocreZR+l/xx08QgTjZ238F4dhrm55H0RS79mQEMT+c
xsG7IR8xcTACPaH5jG424L34T3ddP8qZ5TnBRn99C/gkCjmAcEpxG4nkaAWVcnyU
iWBe38yYSZhpK1hUNVzoXOoOULp4OtpO+POuPY7LEwlqUK89xJkbOn/ezOro1Mn+
PZwDTv1x3eRwSFVFssXGlNUdDNqm/A==
=gYO/
-----END PGP SIGNATURE-----

--Sig_/SJfC87q9xCYp9F8FTWksNl2--
