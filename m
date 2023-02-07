Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB068CFEF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBGG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:59:31 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08E36685;
        Mon,  6 Feb 2023 22:59:28 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1E3C0C0000EE;
        Mon,  6 Feb 2023 22:59:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1E3C0C0000EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753168;
        bh=0k0L1DVAv3HjqN3Sb/dJaroOKuLAje4aCN9W6RDJm1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itG0Zjp61Nef0JgI4QLbl4cU6pXfkuoIh0OGUavmc2uK4nyOGORaO8zFEIMPYRr2V
         s5PSmEFZhvfwqHLV23GEiKbE+W6ZKL+sRrryS3ohyeX5Y+KFWgd3AW2oRAiFwGyu/W
         2+ezitIVG5YuTemgtqSA85RjEwNitkfjTPIEiumg=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 1C7D918041CAC6;
        Mon,  6 Feb 2023 22:59:28 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 6EB60101B35; Mon,  6 Feb 2023 22:59:17 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] ARM: dts: broadcom: bcmbca: Add spi controller node
Date:   Mon,  6 Feb 2023 22:58:14 -0800
Message-Id: <20230207065826.285013-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HSSPI controller in ARMv7 chip dts files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v3:
- Drop the generic compatible string brcm,bcmbca-hsspi

Changes in v2:
- Update compatible string with SoC model number, controller version
  info and bcmbca fall back name
- Add interrupt property

 arch/arm/boot/dts/bcm47622.dtsi    | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi    | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm63148.dtsi    | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm63178.dtsi    | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm6756.dtsi     | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm6846.dtsi     | 18 ++++++++++++++++++
 arch/arm/boot/dts/bcm6855.dtsi     | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm6878.dtsi     | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm947622.dts    |  4 ++++
 arch/arm/boot/dts/bcm963138.dts    |  4 ++++
 arch/arm/boot/dts/bcm963138dvt.dts |  4 ++++
 arch/arm/boot/dts/bcm963148.dts    |  4 ++++
 arch/arm/boot/dts/bcm963178.dts    |  4 ++++
 arch/arm/boot/dts/bcm96756.dts     |  4 ++++
 arch/arm/boot/dts/bcm96846.dts     |  4 ++++
 arch/arm/boot/dts/bcm96855.dts     |  4 ++++
 arch/arm/boot/dts/bcm96878.dts     |  4 ++++
 17 files changed, 184 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/bcm47622.dtsi
index f4b2db9bc4ab..cd25ed2757b7 100644
--- a/arch/arm/boot/dts/bcm47622.dtsi
+++ b/arch/arm/boot/dts/bcm47622.dtsi
@@ -88,6 +88,12 @@ uart_clk: uart-clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	psci {
@@ -119,6 +125,18 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm47622-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
index b774a8d63813..93281c47c9ba 100644
--- a/arch/arm/boot/dts/bcm63138.dtsi
+++ b/arch/arm/boot/dts/bcm63138.dtsi
@@ -66,6 +66,12 @@ apb_clk: apb_clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 
 	/* ARM bus */
@@ -203,6 +209,18 @@ serial1: serial@620 {
 			status = "disabled";
 		};
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63138-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		nand_controller: nand-controller@2000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/bcm63148.dtsi b/arch/arm/boot/dts/bcm63148.dtsi
index 7cd55d64de71..ba7f265db121 100644
--- a/arch/arm/boot/dts/bcm63148.dtsi
+++ b/arch/arm/boot/dts/bcm63148.dtsi
@@ -60,6 +60,12 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <50000000>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 
 	psci {
@@ -100,5 +106,17 @@ uart0: serial@600 {
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63148-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm63178.dtsi b/arch/arm/boot/dts/bcm63178.dtsi
index 043e699cbc27..d8268a1e889b 100644
--- a/arch/arm/boot/dts/bcm63178.dtsi
+++ b/arch/arm/boot/dts/bcm63178.dtsi
@@ -71,6 +71,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -78,6 +79,12 @@ uart_clk: uart-clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	psci {
@@ -109,6 +116,18 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63178-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm6756.dtsi b/arch/arm/boot/dts/bcm6756.dtsi
index 5c72219bc194..49ecc1f0c18c 100644
--- a/arch/arm/boot/dts/bcm6756.dtsi
+++ b/arch/arm/boot/dts/bcm6756.dtsi
@@ -88,6 +88,12 @@ uart_clk: uart-clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	psci {
@@ -119,6 +125,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6756-hsspi", "brcm,bcmbca-hsspi-v1.1";
+			reg = <0x1000 0x600>, <0x2610 0x4>;
+			reg-names = "hsspi", "spim-ctrl";
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm6846.dtsi b/arch/arm/boot/dts/bcm6846.dtsi
index 81513a793815..fbc7d3a5dc5f 100644
--- a/arch/arm/boot/dts/bcm6846.dtsi
+++ b/arch/arm/boot/dts/bcm6846.dtsi
@@ -61,6 +61,12 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 
 	psci {
@@ -100,5 +106,17 @@ uart0: serial@640 {
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6846-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm6855.dtsi b/arch/arm/boot/dts/bcm6855.dtsi
index 5fa5feac0e29..5e0fe26530f1 100644
--- a/arch/arm/boot/dts/bcm6855.dtsi
+++ b/arch/arm/boot/dts/bcm6855.dtsi
@@ -78,6 +78,12 @@ uart_clk: uart-clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	psci {
@@ -109,6 +115,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6855-hsspi", "brcm,bcmbca-hsspi-v1.1";
+			reg = <0x1000 0x600>, <0x2610 0x4>;
+			reg-names = "hsspi", "spim-ctrl";
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm6878.dtsi b/arch/arm/boot/dts/bcm6878.dtsi
index 4ec836ac4baf..96529d3d4dc2 100644
--- a/arch/arm/boot/dts/bcm6878.dtsi
+++ b/arch/arm/boot/dts/bcm6878.dtsi
@@ -61,6 +61,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -68,6 +69,12 @@ uart_clk: uart-clk {
 			clock-div = <4>;
 			clock-mult = <1>;
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
 	};
 
 	psci {
@@ -100,6 +107,18 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6878-hsspi", "brcm,bcmbca-hsspi-v1.0";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		uart0: serial@12000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x12000 0x1000>;
diff --git a/arch/arm/boot/dts/bcm947622.dts b/arch/arm/boot/dts/bcm947622.dts
index 6f083724ab8e..93b8ce22678d 100644
--- a/arch/arm/boot/dts/bcm947622.dts
+++ b/arch/arm/boot/dts/bcm947622.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm963138.dts b/arch/arm/boot/dts/bcm963138.dts
index d28c4f130ca2..1b405c249213 100644
--- a/arch/arm/boot/dts/bcm963138.dts
+++ b/arch/arm/boot/dts/bcm963138.dts
@@ -25,3 +25,7 @@ memory@0 {
 &serial0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm963138dvt.dts b/arch/arm/boot/dts/bcm963138dvt.dts
index 15bec75be74c..b5af61853a07 100644
--- a/arch/arm/boot/dts/bcm963138dvt.dts
+++ b/arch/arm/boot/dts/bcm963138dvt.dts
@@ -50,3 +50,7 @@ &ahci {
 &sata_phy {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm963148.dts b/arch/arm/boot/dts/bcm963148.dts
index 98f6a6d09f50..1f5d6d783f09 100644
--- a/arch/arm/boot/dts/bcm963148.dts
+++ b/arch/arm/boot/dts/bcm963148.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm963178.dts b/arch/arm/boot/dts/bcm963178.dts
index fa096e9cde23..d036e99dd8d1 100644
--- a/arch/arm/boot/dts/bcm963178.dts
+++ b/arch/arm/boot/dts/bcm963178.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm96756.dts b/arch/arm/boot/dts/bcm96756.dts
index 9a4a87ba9c8a..8b104f3fb14a 100644
--- a/arch/arm/boot/dts/bcm96756.dts
+++ b/arch/arm/boot/dts/bcm96756.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm96846.dts b/arch/arm/boot/dts/bcm96846.dts
index c70ebccabc19..55852c229608 100644
--- a/arch/arm/boot/dts/bcm96846.dts
+++ b/arch/arm/boot/dts/bcm96846.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm96855.dts b/arch/arm/boot/dts/bcm96855.dts
index 4438152561ac..2ad880af2104 100644
--- a/arch/arm/boot/dts/bcm96855.dts
+++ b/arch/arm/boot/dts/bcm96855.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm96878.dts b/arch/arm/boot/dts/bcm96878.dts
index 8fbc175cb452..b7af8ade7a9d 100644
--- a/arch/arm/boot/dts/bcm96878.dts
+++ b/arch/arm/boot/dts/bcm96878.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
-- 
2.37.3

