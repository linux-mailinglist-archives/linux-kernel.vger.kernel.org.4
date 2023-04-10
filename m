Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633386DC7A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDJOFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDJOFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:05:30 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED555B96
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:05:29 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33AE5H8I093216;
        Mon, 10 Apr 2023 09:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681135517;
        bh=mz1xGh/0maaZBflnv+aE+R/ae1jQFC1sPYJzvCJXy/E=;
        h=Date:From:To:CC:Subject;
        b=sdtnqFXTo7/TUNUu6CXuJ/wuYPBDR9TYJaf/iHOL7Not7VNF/Z4B0Li4ykKUkgkUK
         tB9LdEBJBAPWfy2Z6SpRapvJNU6BGg395NFT/rTy/isXD1HtgMIvMCVFvmEmxIn6f4
         in3fxF3dYfwyjV7Hfc6bspLVDBQ1yx2QpvTNLnL0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33AE5Hww078405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Apr 2023 09:05:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 10
 Apr 2023 09:05:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 10 Apr 2023 09:05:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33AE5H2k028013;
        Mon, 10 Apr 2023 09:05:17 -0500
Date:   Mon, 10 Apr 2023 09:05:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL 2/3] arm64: defconfig: TI K3 updates for v6.4
Message-ID: <20230410140517.ovxnagc4xh3gqath@canary>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jtpwqicorzld4rss"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--jtpwqicorzld4rss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-con=
fig-for-v6.4

for you to fetch changes up to 44b263bf040a8e819da11c45f14a80de8866461a:

  arm64: defconfig: Enable audio drivers for AM62-SK (2023-03-30 11:58:36 -=
0500)

----------------------------------------------------------------
arm64: TI K3 defconfig updates for v6.4

* Enable drivers for BeaglePlay and Audio drivers for AM62-SK

For this tag, Bloat-o-meter reports (17.0.0 + v6.3-rc1 base):
add/remove: 61/2 grow/shrink: 3/1 up/down: 17852/-208 (17644)
[...]
Total: Before=3D27746954, After=3D27764598, chg +0.06%

----------------------------------------------------------------
Jai Luthra (1):
      arm64: defconfig: Enable audio drivers for AM62-SK

Nishanth Menon (1):
      arm64: defconfig: Enable drivers for BeaglePlay

 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--jtpwqicorzld4rss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmQ0F5YACgkQ3bWEnRc2
JJ2x8A//d/oewWZCYzLnJyVh6PzdvlcyzEKdc16ujc/Kr+mfuiRy/EkUURv/IcVV
okgt7pc10LAJV8XmcqPfVwdJBL9LfAI2EUlcRYLPuHPJSl6yV6FjayjlQ06NF2pT
ezA7/zCVT0koH4YgbWOjBdbLo4CeagmxbRvKzcd6b464RKwpKyIfZ3vunofvgweh
MObAB5u312VoVXHpPvgcvKroNy74yVHy+R5uephKxCfYsaijaHeHqA9uFsTvGzan
TEU+85riNI4h4lcT1LaMNaDvRgat8HvRNFI1pCKaetMAfU3e/r3IPol6RalSuxyj
hD5c3iksW+wBWqknK/5xOP95TV1lZHBhtdcCTwRZtIrzf3RhsrYaGSAmchstD64d
FM6rfw9fclYNqawOUHulK7V+1FYGv2xlQtXL/xvxs2xlqIP1O8Y9gKq9bO0+EVAN
6T0Pi9rRLC1W+upk/JVgh3qoRMiQ47WIcXlzkRpqqg6wy1p+cL7hNkUS791vqD0z
4I+QhqbaKiDx8khjpouXFN6zFyYL8wPArrKkyJ6wtvN2U0MPJ5uUdthhRwvuPz4D
5nKbFQ34WcMIgiAoO3rFKdRoNlAxVQUe4KzZOKGw949RMs33bJypRS3qFrDrzq6d
XcdVoqdRKLlq8Vga1z/NCTnuFjbWIQvJ5Ojd6xgQSc8EQBz2iVk=
=TV79
-----END PGP SIGNATURE-----

--jtpwqicorzld4rss--
