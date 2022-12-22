Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC56B65477C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiLVUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiLVUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:46:11 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75164E4;
        Thu, 22 Dec 2022 12:46:10 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKjqCK129515;
        Thu, 22 Dec 2022 14:45:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671741952;
        bh=t0CVlGayMw5HcUXgmGTym4TtlkZXIl8bMzE8UidCg5k=;
        h=From:To:CC:Subject:Date;
        b=HWlECEZuZQdcMs1QjhMsKnx5gryDNYkfRok6Z0h2QfGaMVfqFjQ7GYgsNEtkGOrJa
         Au2fc/lhRX6Ce3o9q0d/0js9WfxDG6S+FioHJBTQSobLkvFrtklQbJ435kORBhVTG5
         wzLRpuvGTTiaSGt83bFbgqs8YDn2HWvNPurTmD6Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BMKjqqM120296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Dec 2022 14:45:52 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 22
 Dec 2022 14:45:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 22 Dec 2022 14:45:51 -0600
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BMKjk7M004121;
        Thu, 22 Dec 2022 14:45:47 -0600
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
Subject: [PATCH v4 0/4] Add initial support for J784S4 SoC
Date:   Fri, 23 Dec 2022 02:15:41 +0530
Message-ID: <20221222204545.45281-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

bootlog: https://rentry.co/gbefx/raw

Changes in v4:
- Removed ti,sci-dev-id from main_navss and mcu_navss, also changed their
  compatibles to "simple-bus"
- Removed status = "disabled" from phy_gmii_sel and cpts@3d000
- Removed empty chosen {} from k3-j784s4.dtsi

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
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      |  196 ++++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi    | 1007 +++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  311 +++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi         |  284 +++++
 include/dt-bindings/pinctrl/k3.h              |    3 +
 7 files changed, 1809 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4.dtsi

-- 
2.34.1

