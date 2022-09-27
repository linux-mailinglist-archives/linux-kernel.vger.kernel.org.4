Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E01E5EC112
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiI0LVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiI0LU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6A954C84;
        Tue, 27 Sep 2022 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664277626; x=1695813626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEKnwwtNJPu/Lc90Ya+WHDXfcID2nQ42G1LiippA8aI=;
  b=a/lHNm9lugaE3n6r/HB7fYZPLOcbou56wNthppniPI5w1auoRdtGA0h9
   5xLoh9YYDTRxu9O4k0KMnvGe1WOJs/UfUqBdwpeaV5iMmzGVMsEq0+3wa
   pUkdnlINhFk421ITUnxATQ7c+v9/MAu6TebFQLIpMF1MGecK5BMKqNn4G
   ejaqWq6ft/EoB2ofNI25INJdjJWNuWgTxphrnnWzTbuuNrNIiQQ0G8leV
   T6HL98xTL0KsJ1YPxMTQ11fLSSKNeAQP25tlwwiH2JGRPfHorSBwHUeKT
   nrtxBjXfEdzcO5hvbbtKC/Y6i2bT/fqahtrbUK616lJ346rPN25tXAayR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="179094388"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 04:20:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 04:20:22 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 27 Sep 2022 04:20:20 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 09/11] riscv: dts: microchip: add sevkit device tree
Date:   Tue, 27 Sep 2022 12:19:21 +0100
Message-ID: <20220927111922.3602838-10-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111922.3602838-1-conor.dooley@microchip.com>
References: <20220927111922.3602838-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vattipalli Praveen <praveen.kumar@microchip.com>

Add a basic dts for the Microchip Smart Embedded Vision dev kit.
The SEV kit is an upcoming first party board, featuring an MPFS250T and:
- Dual Sony Camera Sensors (IMX334)
- IEEE 802.11 b/g/n 20MHz (1x1) Wi-Fi
- Bluetooth 5 Low Energy
- 4 GB DDR4 x64
- 2 GB LPDDR4 x32
- 1 GB SPI Flash
- 8 GB eMMC flash & SD card slot (multiplexed)
- HDMI2.0 Video Input/Output
- MIPI DSI Output
- MIPI CSI-2 Input

Link: https://onlinedocs.microchip.com/pr/GUID-404D3738-DC76-46BA-8683-6A77E837C2DD-en-US-1/index.html?GUID-065AEBEE-7B2C-4895-8579-B1D73D797F06
Signed-off-by: Vattipalli Praveen <praveen.kumar@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 ++++++
 .../riscv/boot/dts/microchip/mpfs-sev-kit.dts | 145 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 39aae7b04f1c..f18477b2e86d 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
new file mode 100644
index 000000000000..8545baf4d129
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Microchip Technology Inc */
+
+/ {
+	fabric_clk3: fabric-clk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	fabric_clk1: fabric-clk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	pcie: pcie@2000000000 {
+		compatible = "microchip,pcie-host-1.0";
+		#address-cells = <0x3>;
+		#interrupt-cells = <0x1>;
+		#size-cells = <0x2>;
+		device_type = "pci";
+		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+		reg-names = "cfg", "apb";
+		bus-range = <0x0 0x7f>;
+		interrupt-parent = <&plic>;
+		interrupts = <119>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		interrupt-map-mask = <0 0 0 7>;
+		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic1", "fic3";
+		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
+		msi-parent = <&pcie>;
+		msi-controller;
+		status = "disabled";
+		pcie_intc: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
new file mode 100644
index 000000000000..013cb666c72d
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-sev-kit-fabric.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define MTIMER_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PolarFire-SoC SEV Kit";
+	compatible = "microchip,mpfs-sev-kit", "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <MTIMER_FREQ>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		fabricbuf0ddrc: buffer@80000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x80000000 0x0 0x2000000>;
+		};
+
+		fabricbuf1ddrnc: buffer@c4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xc4000000 0x0 0x4000000>;
+		};
+
+		fabricbuf2ddrncwcb: buffer@d4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xd4000000 0x0 0x4000000>;
+		};
+	};
+
+	ddrc_cache: memory@1000000000 {
+		device_type = "memory";
+		reg = <0x10 0x0 0x0 0x76000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+	};
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+	};
+};
+
+&mac1 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart2 {
+	status = "okay";
+};
+
+&mmuart3 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.37.3

