Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A621C7430B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjF2Wp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjF2WpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:45:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A942681;
        Thu, 29 Jun 2023 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1688078698;
        bh=KOoxnaHdHGVzj44ONoItqPJM3VHlcti3bCP6+5zewB8=;
        h=Date:From:To:Cc:Subject:From;
        b=RLGCXRf0i3ZK+h0oGqHDbNnPVe6xSxlTjqZ8CPanKolmCBDGoAx0HT4tpy7vCSwws
         9aDLXvBev/zlsdygZjT1tl6MMCJbW1aFM9fE1RKlvRLuQXuwqpASAzzyir3erETfdW
         IKREkM/4yHquXQRRxWIznUxMjnFz2r160cqgwGZSpUJTMORsKOafJD7SCx6bmlD0Gb
         mOxw12g2F0ddg0WMS0e0+iuDKBhaP7ydf8TNSZFZO4jHkdiDtaM/FzbME5q649GDM9
         zXbO0s+0zzuocIx4HHI/gfbp9S9ClnR1JY4SPVgurO9uMyMC5SBNInVJT9dBusIMV/
         30HQod5aiwQkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsYRt3lwDz4wZn;
        Fri, 30 Jun 2023 08:44:58 +1000 (AEST)
Date:   Fri, 30 Jun 2023 08:44:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mediatek tree
Message-ID: <20230630084457.3a483c12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nEbcSFWz=yAAVT18N5UZZnZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nEbcSFWz=yAAVT18N5UZZnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  1139eb7bf5ef ("arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltag=
e scaling")
  113b5cc06f44 ("arm64: dts: mediatek: mt8173-elm: remove panel model numbe=
r in DT")
  2cb0317922e2 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3=
 dts")
  320f2af8c387 ("arm64: dts: mt7986: add thermal and efuse")
  4a7fcb3cdf6c ("arm64: dts: mt7986: use size of reserved partition for bl2=
")
  58d2424d9f83 ("arm64: dts: mediatek: mt8192: Add missing dma-ranges to so=
c node")
  5e042912c86b ("arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name=
")
  7c8cf2a19228 ("arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz")
  861af546db4f ("arm64: dts: mt7986: add thermal-zones")
  8b018984aad7 ("arm64: dts: mt8173: Power on panel regulator on boot")
  c45c921fb524 ("arm64: dts: mt7986: increase bl2 partition on NAND of Bana=
napi R3")
  ccc2a6d8446c ("arm64: dts: mt8195: Add video decoder node")
  d0b4508ad0b5 ("arm64: dts: mediatek: Add cpufreq nodes for MT8192")
  e5b12f3b851f ("arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP tab=
le")
  eb5aab271611 ("arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cell=
s")
  f38ff7d3b0f1 ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequenc=
y scaling")
  fd6d9a1c9819 ("arm64: dts: mt8192: Add video-codec nodes")

--=20
Cheers,
Stephen Rothwell

--Sig_/nEbcSFWz=yAAVT18N5UZZnZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSeCWkACgkQAVBC80lX
0Gz0qAgAl6tZkeLRkOiABxGb5fDk270OLGC2WjrPFBLeB8yJcAZMDf8MzlQSfTW7
JdEi9PdlarBdkTpEVklKN2BkdEjdMYGRQS680Wdkz2yP7ezFYZSwLdYkUOBNfeis
7GjD8Jv9jPLZPCu/StgaZGLjEkL5LPFyoexHPPe5s+EifilXsBcPR7IgIMtLbCL1
lsa/T0tOyjLgfeQoEyF6YJoEYbayF0HAw0vHCQ5pjbOriERUnciDjRoSVSMhB5tX
EN86XuOBqdN4j3twxcJz4lEJnWBXQ92Xk2Z9+HhlWY1v3trCtuZFqdEZpmQK8BMu
vppo7ph5Ko7zoxA31n+7dHhMV9ANbA==
=6HtC
-----END PGP SIGNATURE-----

--Sig_/nEbcSFWz=yAAVT18N5UZZnZ--
