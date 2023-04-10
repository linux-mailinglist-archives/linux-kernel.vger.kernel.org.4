Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B858D6DC7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDJOFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDJOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:05:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB49E7D95
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:05:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33AE5L1i093233;
        Mon, 10 Apr 2023 09:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681135521;
        bh=AIwMLx5zivcNKdarlibtfBgnGtOCiEdnfhcDUKPiAjs=;
        h=Date:From:To:CC:Subject;
        b=fVPDvW2xL+ogv/+UjsFnrFvDYBg4ju5f2GzTHc9dnNkTGl/85aW/WfFkD8SFsGOwB
         XzuoBzBjk9pCGvIiGq5HmwWeCuMszLYyWSISn/zZO17Uvo54xbMHedOTRJXPFvR4RL
         MA+eqcxKZgfU/lLvF1B5LduF/xQWx3PIVbXkrtgw=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33AE5Li7126305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Apr 2023 09:05:21 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 10
 Apr 2023 09:05:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 10 Apr 2023 09:05:21 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33AE5L5X040962;
        Mon, 10 Apr 2023 09:05:21 -0500
Date:   Mon, 10 Apr 2023 09:05:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 3/3] arm64: dts: ti: K3 updates for v6.4
Message-ID: <20230410140521.3u3fftgnejakqnzj@shakable>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Hi,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-for-v6.4

for you to fetch changes up to 891db0c48efb48c3af334006f9d7ea6a0aa49cb9:

  arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support (2023-03-30 13:36:34 -0500)

----------------------------------------------------------------
TI K3 device tree updates for v6.4

New features:
* Overlays for CPSW9G and CPSW5G on J721e-evm, J7200-evm
* Add support for AM625 based BeaglePlay, AM62-LP-SK
* Audio, RTC, watchdog support for AM625
* McSPI for J7200,j721e, j721s2, J784s4
* ADC for j721s2
* Crypto acceleration, CPSW2G for J784s4

Non critical fixes:
AM62, AM62a:
* Fix schematics error to increase DDR to 4GB on AM62a-SK
* L2Cache size fix (AM62a/AM625)
* ti,vbus-divider property to USB1 on AM625-SK
* Gpio count fix for AM625

J7200,j721e, j721s2, J784s4, AM68, AM69:
* ti,sci-dev-id for J784s4 NAVSS nodes
* j721e-sk: Drop application specific firmware name
* am68-sk: Fix the gpio expander lines for production version

Cleanups:
* Pinmux header move to dt folder (next kernel PR, we will drop the uapi header).
* j721e: ti,strobe-sel property cleanup for descoped HS400 MMC operation

----------------------------------------------------------------
Anand Gadiyar (2):
      arm64: dts: ti: Refractor AM625 SK dts
      arm64: ti: dts: Add support for AM62x LP SK

Andrew Davis (1):
      arm64: dts: ti: k3-j721e-sk: Remove firmware-name override for R5F

Apurva Nandan (1):
      arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support

Bhavya Kapoor (3):
      arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
      arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux information for ADC

Devarsh Thakkar (1):
      arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB

Dhruva Gole (1):
      arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

Jai Luthra (1):
      arm64: dts: ti: Enable audio on SK-AM62(-LP)

Jayesh Choudhary (3):
      arm64: dts: ti: k3-j784s4-*: Add 'ti,sci-dev-id' for NAVSS nodes
      arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator
      arm64: dts: ti: k3-am62-main: Add McASP nodes

Julien Panis (1):
      arm64: dts: ti: k3-am62: Add watchdog nodes

Nishanth Menon (4):
      dt-bindings: net: ti: k3-am654-cpsw-nuss: Drop pinmux header
      arm64: dts: ti: Use local header for pinctrl register values
      dt-bindings: pinctrl: k3: Deprecate header with register constants
      arm64: dts: ti: k3-am62-wakeup: Introduce RTC node

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT

Robert Nelson (2):
      dt-bindings: arm: ti: Add BeaglePlay
      arm64: dts: ti: Add k3-am625-beagleplay

Siddharth Vadapalli (5):
      arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G
      arm64: dts: ti: k3-j721e: Add CPSW9G nodes
      arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII mode
      arm64: dts: ti: j7200-main: Add CPSW5G nodes
      arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII mode

Sinthu Raja (1):
      arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO lines for Rev E2

Vaishnav Achath (4):
      arm64: dts: ti: k3-j721e: Add MCSPI nodes
      arm64: dts: ti: k3-j7200: Add MCSPI nodes
      arm64: dts: ti: k3-j721s2: Add MCSPI nodes
      arm64: dts: ti: k3-j784s4: Add MCSPI nodes

Vignesh Raghavendra (3):
      arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
      arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB
      dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   2 +
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   1 -
 arch/arm64/boot/dts/ti/Makefile                    |   8 +-
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts           | 231 +++++++
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           | 109 ++-
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |  11 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  21 +
 arch/arm64/boot/dts/ti/k3-am62.dtsi                |   3 +-
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     | 758 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             | 244 +------
 arch/arm64/boot/dts/ti/k3-am625.dtsi               |   2 +-
 arch/arm64/boot/dts/ti/k3-am62a.dtsi               |   3 +-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |   5 +-
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi              |   2 +-
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     | 351 ++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi                |   3 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   3 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |  12 +-
 .../dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso     | 101 +++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          | 176 +++++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  33 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               |   3 +-
 .../dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso     | 133 ++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          | 205 +++++-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  33 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |   4 -
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |   4 +-
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  44 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  88 +++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |  73 ++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi              |   3 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  59 ++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 108 +++
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  34 +
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |   3 +-
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |  53 ++
 include/dt-bindings/pinctrl/k3.h                   |   7 +
 37 files changed, 2672 insertions(+), 261 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-pinctrl.h
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
