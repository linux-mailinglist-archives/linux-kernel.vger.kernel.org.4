Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58767A5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjAXWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjAXWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:32:58 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295046705;
        Tue, 24 Jan 2023 14:32:41 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 79EB4C0000F2;
        Tue, 24 Jan 2023 14:32:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 79EB4C0000F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599561;
        bh=yJ9f28rX5LQP6+TImskdZY8NmUTjai6oUeR89G3OSJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeObNYOZdpPpeotacuUPYb995yPj3RCHbtLGZIeg2Gv6caPIIGJd5Jp7ZjMhBu7pN
         a/nLZDE5So+XmwmQdv9ygSqf4biGq2E6xW82wMvtZ95u4fi0UKpWitsIw/zdUAN82u
         8SZk2V31jNvAy9uMY+1upGqkJZM9kEzz/fvewrtg=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 6F89918041CAC6;
        Tue, 24 Jan 2023 14:32:41 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 64335101B55; Tue, 24 Jan 2023 14:32:41 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] ARM: dts: broadcom: bcmbca: Add spi controller node
Date:   Tue, 24 Jan 2023 14:12:06 -0800
Message-Id: <20230124221218.341511-4-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230124221218.341511-1-william.zhang@broadcom.com>
References: <20230124221218.341511-1-william.zhang@broadcom.com>
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

Changes in v2:
- Update compatible string with SoC model number, controller version
  info and bcmbca fall back name
- Add interrupt property

 arch/arm/boot/dts/bcm47622.dtsi    | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi    | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm63148.dtsi    | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm63178.dtsi    | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm6756.dtsi     | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm6846.dtsi     | 19 +++++++++++++++++++
 arch/arm/boot/dts/bcm6855.dtsi     | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm6878.dtsi     | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm947622.dts    |  4 ++++
 arch/arm/boot/dts/bcm963138.dts    |  4 ++++
 arch/arm/boot/dts/bcm963138dvt.dts |  4 ++++
 arch/arm/boot/dts/bcm963148.dts    |  4 ++++
 arch/arm/boot/dts/bcm963178.dts    |  4 ++++
 arch/arm/boot/dts/bcm96756.dts     |  4 ++++
 arch/arm/boot/dts/bcm96846.dts     |  4 ++++
 arch/arm/boot/dts/bcm96855.dts     |  4 ++++
 arch/arm/boot/dts/bcm96878.dts     |  4 ++++
 17 files changed, 192 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47622.dtsi b/arch/arm/boot/dts/bcm47622.dtsi
index f4b2db9bc4ab..6de4a2287c90 100644
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
@@ -119,6 +125,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm47622-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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
index b774a8d63813..2c436b95f874 100644
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
@@ -203,6 +209,19 @@ serial1: serial@620 {
 			status = "disabled";
 		};
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63138-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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
index 7cd55d64de71..646906c8c260 100644
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
@@ -100,5 +106,18 @@ uart0: serial@600 {
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63148-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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
index 043e699cbc27..15f550dadc60 100644
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
@@ -109,6 +116,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63178-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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
index 5c72219bc194..45c09a54ac20 100644
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
@@ -119,6 +125,20 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6756-hsspi", "brcm,bcmbca-hsspi-v1.1",
+						 "brcm,bcmbca-hsspi";
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
index 81513a793815..e8895d69e249 100644
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
@@ -100,5 +106,18 @@ uart0: serial@640 {
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6846-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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
index 5fa5feac0e29..6ecfe7ac0554 100644
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
@@ -109,6 +115,20 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6855-hsspi", "brcm,bcmbca-hsspi-v1.1",
+						 "brcm,bcmbca-hsspi";
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
index 4ec836ac4baf..636a6ae416b3 100644
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
@@ -100,6 +107,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6878-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
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

