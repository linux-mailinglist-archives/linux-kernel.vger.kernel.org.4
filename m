Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A007E62BEF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiKPNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiKPNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:04:47 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAAF2FC30;
        Wed, 16 Nov 2022 05:04:42 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGD4XuG060612;
        Wed, 16 Nov 2022 07:04:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668603873;
        bh=W9LOsNQ3d8aW/4MtosEUbpffw4i6MSxRHD13/xiBvdo=;
        h=From:To:CC:Subject:Date;
        b=DPFc+wfRpk0FLQuKPt58FUb4GpSpVvOxsQiHJFMIv0jjx8DK/Nbv5RpoJZl37ZvCn
         eiJ8xf1hAJBxta5fIPY1DicWWBwGnahEYSdhwdhECAUxlVlIWu69n5B+zyFI7sgQDl
         Xf1Zi8xdQCnWfaMOVt/vKpwX6FhNTtltynh4zRVc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGD4XBP018474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 07:04:33 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 07:04:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 07:04:32 -0600
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGD4TbZ121231;
        Wed, 16 Nov 2022 07:04:29 -0600
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH v3 0/4] Add initial support for J784S4 SoC
Date:   Wed, 16 Nov 2022 18:34:24 +0530
Message-ID: <20221116130428.161329-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J784S4 SoC belongs to the K3 Multicore SoC architecture
platform, providing advanced system integration in automotive,
ADAS and industrial applications requiring AI at the network edge.
This SoC extends the K3 Jacinto 7 family of SoCs with focus on
raising performance and integration while providing interfaces,
memory architecture and compute performance for multi-sensor, high
concurrency applications.

Some highlights of this SoC are:
* Up to 8 Cortex-A72s, four clusters of lockstep capable dual Cortex-R5F MCUs,
  4 C7x floating point vector DSPs with Matrix Multiply Accelerator(MMA) for
  deep learning and CNN.
* 3D GPU: Automotive grade IMG BXS-4-64
* Vision Processing Accelerator (VPAC) with image signal processor and Depth
  and Motion Processing Accelerator (DMPAC)
* Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and one
  DPI interface.
* Integrated gigabit ethernet switch, up to 8 ports (TDA4VH), two ports
  support 10Gb USXGMII; Two 4 lane PCIe-GEN3 controllers, USB3.0 Dual-role
  device subsystems, Up to 20 MCANs, among other peripherals.

See J784S4 Technical Reference Manual (SPRUJ52 - JUNE 2022)
for further details: http://www.ti.com/lit/zip/spruj52

bootlog: https://pastebin.ubuntu.com/p/DtmGZgzR6v/plain/

Changes in v3:
- Enabled hwspinlock, main_ringacc, main_udmap, cpts, and mcu_navss in
  the dtsi
- Removed alignment in secure_ddr optee
- Changed the assigned clock parent in main and mcu cpts to main pll0, hsdiv6
  from pll3, hsdiv1
- Removed few signed-off by
- Formatting fixes at some places
- Corrected link to EVM board schmatics in the commit

Changes in v2:
- Disabled all the IPs that are not mandatory for booting up the SoC by
  default in the dtsi, and thus this gives a minimal SoC boot devicetree.
- Moved no-1-8-v property from the k3-j784s4-evm.dts file to
  k3-j784s4-main.dtsi file.
- Naming changes (hwlock, regulator) and commit description changes.
- Added device specific compatible for j721e system controller.
- Dropped bootargs completely.

Apurva Nandan (4):
  dt-bindings: arm: ti: Add bindings for J784s4 SoC
  dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
  arm64: dts: ti: Add initial support for J784S4 SoC
  arm64: dts: ti: Add support for J784S4 EVM board

 .../devicetree/bindings/arm/ti/k3.yaml        |    6 +
 arch/arm64/boot/dts/ti/Makefile               |    2 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  197 ++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 1008 +++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  316 ++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  286 +++++
 include/dt-bindings/pinctrl/k3.h              |    3 +
 7 files changed, 1818 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4.dtsi

-- 
2.17.1

