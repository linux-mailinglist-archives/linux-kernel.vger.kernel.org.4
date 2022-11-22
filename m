Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8A634436
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiKVTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiKVTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:02:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5558CB96
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:02:22 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ29nL116100;
        Tue, 22 Nov 2022 13:02:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669143729;
        bh=BCty4pZBwB98iVeJv134I77xk2ywtC/TI5uVLzrZFLI=;
        h=Date:From:To:CC:Subject;
        b=eXfUU/uCsGTC1nJQeT4HGlbEluXmYoWbg+qtztVR/h2JlZ47Mta2vWs47a8YU82KA
         IJEmr7ym0hSNCmsV7V2+WV/44Uic4xCXJBYsJNBJs5ogVP7mNKciLWSrnhJ8RFqFqY
         VFwVReBXAmdj4FjeaTfMSSgWRfRVd0HcorZWZ92Q=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AMJ29NR011542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Nov 2022 13:02:09 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 22
 Nov 2022 13:02:09 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 22 Nov 2022 13:02:09 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AMJ29Sw122597;
        Tue, 22 Nov 2022 13:02:09 -0600
Date:   Tue, 22 Nov 2022 13:02:09 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: [GIT PULL 3/4] arm64: dts: TI K3 updates for v6.2
Message-ID: <20221122190209.jwfj56d6kxpxdkua@untreated>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwrkr7uhta26c6qe"
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

--pwrkr7uhta26c6qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please find the TI K3 SoC related devicetree changes for v6.2-rc1 below.

---
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-=
for-v6.2

for you to fetch changes up to fae14a1cb8dddb83bb923093aade3470a872f048:

  arm64: dts: ti: Add k3-j721e-beagleboneai64 (2022-11-21 15:49:45 -0600)

----------------------------------------------------------------
TI K3 devicetree updates for v6.2

New Features:
J721e:
* PWMs, BeagleBone AI-64 platform.
J721s2:
* Crypto

AM65/AM62:
* General purpose Timer support (system timer is still arch timer)

Fixes:
* Bunch of fixes in crypto usage and GPIO intr
* Minor schema related fixes for audio, addressing etc.

Cleanups:
* Refactor of device tree to "disable" peripherals at SoC level
  for nodes that are un-usable without board level properties.
  TI K3 devices have large number of peripherals of which only a
  smaller subset is actually enabled on platforms. Switching
  to this approach enables two benefits: lesser confusion in
  creating board level devicetrees as only relevant pinned out
  device nodes need enabled, as well as smaller board device
  trees as most un-used peripherals don't need to explicitly
  disabled.

----------------------------------------------------------------
Andrew Davis (43):
      arm64: dts: ti: k3-am64: Enable UART nodes at the board level
      arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board level
      arm64: dts: ti: k3-am62: Enable UART nodes at the board level
      arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am62: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am62: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am62: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am62: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-j721e: Enable UART nodes at the board level
      arm64: dts: ti: k3-j721e: Enable I2C nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MCASP nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-j7200: Enable UART nodes at the board level
      arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable UART nodes at the board level
      arm64: dts: ti: k3-j721e: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j7200: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am65: Enable UART nodes at the board level
      arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am65: Enable McASP nodes at the board level

Jayesh Choudhary (8):
      arm64: dts: ti: k3-am65-main: Drop dma-coherent in crypto node
      arm64: dts: ti: k3-j721e-main: Drop dma-coherent in crypto node
      arm64: dts: ti: k3-j7200-mcu-wakeup: Drop dma-coherent in crypto node
      arm64: dts: ti: j721e-common-proc-board: Fix sound node-name
      arm64: dts: ti: k3-am65-main: Drop RNG clock
      arm64: dts: ti: k3-j721e-main: Drop RNG clock
      arm64: dts: ti: k3-am64-main: Drop RNG clock
      arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator

Keerthy (1):
      arm64: dts: ti: k3-j721s2: Fix the interrupt ranges property for main=
 & wkup gpio intr

Krzysztof Kozlowski (1):
      arm64: dts: ti: Trim addresses to 8 digits

Matt Ranostay (1):
      arm64: dts: ti: Rename clock-names adc_tsc_fck to fck

Rahul T R (1):
      arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header

Robert Nelson (2):
      dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
      arm64: dts: ti: Add k3-j721e-beagleboneai64

Tony Lindgren (3):
      arm64: dts: ti: k3-am65: Configure pinctrl for timer IO pads
      arm64: dts: ti: k3-am65: Add general purpose timers for am65
      arm64: dts: ti: k3-am62: Add general purpose timers for am62

Vijay Pothukuchi (1):
      arm64: dts: ti: k3-j721e-main: Add dts nodes for EHRPWMs

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    1 +
 arch/arm64/boot/dts/ti/Makefile                    |    1 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |  122 +++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |   49 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |    4 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |   81 +-
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |    2 +-
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |   44 +-
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi            |    6 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |  119 +--
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |  142 +--
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |  101 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  207 +++-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   85 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |    2 +
 .../dts/ti/k3-am6528-iot2050-basic-common.dtsi     |    1 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |  113 +--
 .../dts/ti/k3-am6548-iot2050-advanced-common.dtsi  |    4 -
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |   48 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   29 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |    8 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |   42 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 1055 ++++++++++++++++=
++++
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  143 +--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  125 ++-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   11 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |  205 ++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |   33 +-
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  132 +--
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   79 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |    9 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |   98 +-
 32 files changed, 2007 insertions(+), 1094 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--pwrkr7uhta26c6qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmN9HKgACgkQ3bWEnRc2
JJ08EA//d5uOb+1pR9ITxW/o3ykcSSl5TQnMeGvqOpRZ9YmwV+nVn3Z4iQV/LRoL
F3P7pVSh3vq6gR5xY5GP/u3KZPw0i6NzShJZEzNB5pI7DO1F+IFDCi/WNG0etn06
pugwBJGHSGYipY7aEegXPX6r3E1FCvRnTQ/GEpA/OSoYNjEV9yL7JJCJKPOez7on
wqwrwdgmz7cxISmfN4jyR0KODuJy8uK3c1JlGS2ckuF6HRRaDQ7DTpqduFlrpFj8
5HSlpMsguxxhF5WLeQuimJ0Ka2I6RFdsauXdxPItVV53xh4OCvLsRWS8nkcX0C6W
zakyTpzlrXf1cTS0ZkDnYSp6rd2aNLZRKjo+g7Mcdu5VB3mVXTAxvfbDA5hpe2Ht
SY2Dbe7eg6PRN3QhIvw7EMbkqOYiVHFx6wNttw5EQwDU66otsczkQwWQKO+0AlLi
37n1jnP8S9k1+Pil3j0L5S3PRPk/aqgS6yiX1OHWRRUrU1sMFETzmCiNXJ1SHydz
x6GfFQFz8iOan+JsXeZ6w7qw5oc7Zbe2Tu/vVjUB5tQJvoC2Wrj0tTKTSknquiUP
vx+r24Ec3hJZ/SxdAt/SapN64xgkxHzsIiGF4I6/+1XrL/37uD/FHNbnY9RJ0Kg3
D2mL4Bsu2X+A6Xo6oXYXGGnjeLcec2NaeFCgHe6Px10POE1dnb8=
=q9Hv
-----END PGP SIGNATURE-----

--pwrkr7uhta26c6qe--
