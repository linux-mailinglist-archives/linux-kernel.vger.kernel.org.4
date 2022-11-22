Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAD634438
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiKVTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiKVTCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:02:55 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E6721264
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:02:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ2XcR093169;
        Tue, 22 Nov 2022 13:02:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669143753;
        bh=m0/DLF68b85LoKFLJJt19I0JrKIm/sTxsw56dEALVzY=;
        h=Date:From:To:CC:Subject;
        b=NkmfRiOreRheWMjE2MJnfRthLqj/8Yw1Yn0VeJs8X8nyF30S7T/qJyrKVVN3m1IAD
         JQkXh9WhUsdVK+Iupy9k6L97YYPcjSRmZCh/Hb3IkEGGIoOtPu1MKJyf0PeKuIMOPF
         VnFleish6R+3vBpXg5lo/7Q7Rn22Ihr7UiSiZvPk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMJ2XIV050056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 13:02:33 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 13:02:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 13:02:33 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ2X1T128680;
        Tue, 22 Nov 2022 13:02:33 -0600
Date:   Tue, 22 Nov 2022 13:02:33 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: [GIT PULL 4/4] arm64: configs: TI K3 updates for v6.2
Message-ID: <20221122190233.63o3tjtkimlimgtq@armrest>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zmzopvzdqj5ajz7f"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zmzopvzdqj5ajz7f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please find the TI K3 SoC related defconfig changes for v6.2-rc1 below.

---
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-con=
fig-for-v6.2

for you to fetch changes up to 9f7e3ed268520f4d539c03d4d48a604a9658ba37:

  arm64: defconfig: Enable TI_TFP410 DVI bridge (2022-11-03 21:44:23 -0500)

----------------------------------------------------------------
arm64: TI K3 defconfig updates for v6.2

* Enable TI_TFP410 DVI bridge as module for J721e-sk platform

----------------------------------------------------------------
Rahul T R (1):
      arm64: defconfig: Enable TI_TFP410 DVI bridge

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--zmzopvzdqj5ajz7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmN9HMIACgkQ3bWEnRc2
JJ0IVBAAqYEhU3KDDfHP2bdsDC0OcJ7d2DyK2aoD2+hq4cFjAqojIA7nCqM1QREt
p7CpUJNqprR/+zHc2al06BkteRgaTXWZZu0EJSwwAsUasX1zLAvQl1HvGqiJ3YiT
BSihPDNJsc3YPR/u2dagNq0dMVpDsrxn9UvL86kBWwsyu2vWz90qMNZF76CX0nY6
UqT+2BD0hqTcDnkMhPJySDjq1rPbxXsegSOVdSYT+OKppFzpU2CTGz6BPM6QxjM+
DTSREdMjqbAo0QPKmlyvT06w5HivUZuirraCVQesXAr56e30RW7bBQLIjRsVyJtF
0zl0CPAEW3kYXg9eM6FOpblTuc5CQBkJXCsQvGQ8qRPxnOB1OypcesXD78KudrYH
zQ8PD1QdY1VHLcpW4hgQDAGjtT9e1/2CaJaR5LHbE6+FjIFjYj2JJXeRgSy4+8DL
HfoE5PoSaQY4YxCQ1MaacO34YQxtNOWdVPn4DcxD6hAnUL0oduJlOpmENn1pSvyK
6GCj4/iQNFHH+D7ihsDoUOZ1xQ0XcRC9IcDs7BBgwZOHIVez3tgGfLfu/bcyjAm9
cd0BGhyXf/L6yKqKTwMS4xkkSDHKqG/mlP7hdPrW7qgOJ35ByM7FfWquh6h7fbJK
yf3zIb8NgdZQp/xAgI9jFFTAJWQ9deH8dwO9kuznrUvh6ht0RVY=
=ToLi
-----END PGP SIGNATURE-----

--zmzopvzdqj5ajz7f--
