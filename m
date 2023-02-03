Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C9689FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjBCQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjBCQvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:51:08 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18455A87B8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:50:50 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 313GoSvV037892;
        Fri, 3 Feb 2023 10:50:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675443028;
        bh=wZiSoyDzT1HY7RrfCgBc416eSVYgS5iAUjlHrN/MAF8=;
        h=Date:To:CC:From:Subject;
        b=rUy3Bte+YjWx0/RlIvD+NETX5S8CLW4TTSV5IYhRpOq8V5gggrKsvpVx2/b0zjPfI
         4ksqGrVp6GShG/3azmVA8JzuKOUWKA4IIFq7DzyjLJ05ksL5E6wFOsh8a7jni0aa1h
         +Ut+vHiHsKeQ3C+pxxW4J3gIEaOHwEaU7FBPN6vc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 313GoShb115707
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Feb 2023 10:50:28 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 3
 Feb 2023 10:50:27 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 3 Feb 2023 10:50:27 -0600
Received: from [10.250.234.92] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 313GoN7E083344;
        Fri, 3 Feb 2023 10:50:24 -0600
Message-ID: <642cf238-43e5-d6fa-68b5-a9dfbc0277bf@ti.com>
Date:   Fri, 3 Feb 2023 22:20:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        SoC <soc@kernel.org>, arm-soc <arm@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, "Menon, Nishanth" <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL] TI K3 device tree updates for v6.3
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------mQbk22gNIVZ5BG1WrDYPh67e"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------mQbk22gNIVZ5BG1WrDYPh67e
Content-Type: multipart/mixed; boundary="------------wR77ZxnJpAP9xehXdVrK9pLW";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 SoC <soc@kernel.org>, arm-soc <arm@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 Tero Kristo <kristo@kernel.org>, "Menon, Nishanth" <nm@ti.com>,
 Tony Lindgren <tony@atomide.com>
Message-ID: <642cf238-43e5-d6fa-68b5-a9dfbc0277bf@ti.com>
Subject: [GIT PULL] TI K3 device tree updates for v6.3

--------------wR77ZxnJpAP9xehXdVrK9pLW
Content-Type: multipart/mixed; boundary="------------5AsrFPCgDHpggZ3sNJPgNNc5"

--------------5AsrFPCgDHpggZ3sNJPgNNc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC Maintainers,


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71=
c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.3

for you to fetch changes up to 47d72bbb6c0f7dc0901d7601d1aa6b1419282049:

  arm64: dts: ti: Makefile: Rearrange entries alphabetically (2023-02-01 =
23:10:29 +0530)

----------------------------------------------------------------
TI K3 device tree updates for v6.3

New features:
J784S4 SoC and EVM support
AM68 and AM69 StarterKit, phyBOARD-Electra-AM642, Siemens IoT2050 M.2
AM62A7 SK additional peripherals
AM62 SK USB support

Non critical fixes
AM62:
McSPI Clock ID fixes
MMC TAP value updates
J7200:
pinmux range update
All:
Cache DT node fixes

Cleanups:
Reorder dts Makefile entries alphabetically

----------------------------------------------------------------
Apurva Nandan (4):
      dt-bindings: arm: ti: Add bindings for J784s4 SoC
      dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
      arm64: dts: ti: Add initial support for J784S4 SoC
      arm64: dts: ti: Add support for J784S4 EVM board

Aswath Govindraju (2):
      arm64: dts: ti: k3-am62-main: Add support for USB
      arm64: dts: ti: k3-am625-sk: Add support for USB

Dasnavis Sabiya (2):
      dt-bindings: arm: ti: Add binding for AM69 Starter Kit
      arch: arm64: dts: Add support for AM69 Starter Kit

Dhruva Gole (1):
      arm64: dts: ti: k3-am62-main: Fix clocks for McSPI

Jan Kiszka (2):
      arm64: dts: ti: iot2050: Add layout of OSPI flash
      dt-bindings: arm: ti: Add binding for Siemens IOT2050 M.2 variant

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select

Pierre Gondois (1):
      arm64: dts: Update cache properties for ti

Sinthu Raja (3):
      dt-bindings: arm: ti: Add binding for AM68 SK
      arm64: dts: ti: Add initial support for AM68 SK System on Module
      arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board

Vaishnav Achath (1):
      arm64: dts: ti: k3-j7200: Fix wakeup pinmux range

Vignesh Raghavendra (5):
      arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
      arm64: dts: ti: k3-am62a-main: Add more peripheral nodes
      arm64: dts: ti: k3-am62a7-sk: Enable ethernet port
      arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
      arm64: dts: ti: Makefile: Rearrange entries alphabetically

Wadim Egorov (2):
      dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
      arm64: dts: ti: Add support for phyBOARD-Electra-AM642

chao zeng (1):
      arm64: dts: ti: iot2050: Add support for M.2 variant

 Documentation/devicetree/bindings/arm/ti/k3.yaml         |   15 +
 arch/arm64/boot/dts/ti/Makefile                          |   35 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi                 |   98 +-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts                   |   27 +
 arch/arm64/boot/dts/ti/k3-am625.dtsi                     |    1 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                |  365 ++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi                 |   51 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                  |   70 +
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi                    |    1 +
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi          |  231 +++
 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts |  277 +++
 arch/arm64/boot/dts/ti/k3-am642.dtsi                     |    1 +
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi       |   46 +
 arch/arm64/boot/dts/ti/k3-am654.dtsi                     |    2 +
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts |  121 ++
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         |  335 +++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi               |   29 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                    |  180 ++
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts    |    2 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi          |   29 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                     |    1 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                     |    1 +
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                    |    1 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                 |  196 ++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi               | 1007 ++++++++=
++
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi         |  311 +++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                    |  287 +++
 include/dt-bindings/pinctrl/k3.h                         |    3 +
 28 files changed, 3688 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.=
dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.=
dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4.dtsi
--------------5AsrFPCgDHpggZ3sNJPgNNc5
Content-Type: application/pgp-keys; name="OpenPGP_0xF903332F551A78E9.asc"
Content-Disposition: attachment; filename="OpenPGP_0xF903332F551A78E9.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
mlob7AjOAg0Xezz3
=3DMffl
-----END PGP PUBLIC KEY BLOCK-----

--------------5AsrFPCgDHpggZ3sNJPgNNc5--

--------------wR77ZxnJpAP9xehXdVrK9pLW--

--------------mQbk22gNIVZ5BG1WrDYPh67e
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmPdO08FAwAAAAAACgkQxEYeRXyRFuPq
ewf+LM1nsAcJkOTGjo+dMWVWA7AE71N1pG+x56pocEU+ldSi7IHByDjZuVAkLOvTfKF22SglTwcU
roZ+w4bc9NpPWjM5ktbm34WTZ8KNZ1108tmVrAxqn6ZMF/bYXQ/PjlniyOGNwWl6lPBZolDwC5TH
1jYHGDChA+aMIxtU/7uUgyonnqTQwMcoVLByKvT3hCQO2k1+j+pAt6cDLQEeZ9PM9DR4O+1sP6qI
I5gHNUPrvsOT3iUwrXNNiWdBUJFnjsAMp2HsIxKrVsgLfBX8+OIIROiqhNfMvLqiGIGkxdXhTXI0
6/qWdKFR+2EzJJ8qefum3C4wFUUazSXlezE2tVRp8A==
=rsaD
-----END PGP SIGNATURE-----

--------------mQbk22gNIVZ5BG1WrDYPh67e--
