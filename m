Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0167A5DA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjAXWdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjAXWdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:33:01 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvacalvio01.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A104658E;
        Tue, 24 Jan 2023 14:32:47 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 622D4C0000D9;
        Tue, 24 Jan 2023 14:32:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 622D4C0000D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1674599567;
        bh=8t0J92fHk2Bj3QSrJolNub4D3eaNwQesYqZrk62nEj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbO+4w0efA9+aEZzCATYpDQw+HAdmyiDcPg6OFxkO210c20CbuG1SWDIkWm2jFJSo
         kxFOpmm/py13E2L881ZHa2N4+my6lVl3uo3nuH8q1wZpSfZdv4CMUc+gJ1QMb7HyXc
         QStkLrZMzu+kEQTYBiLdyksnIinARev84XQrEGQM=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 607B118041CAC6;
        Tue, 24 Jan 2023 14:32:47 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 5BC0C101ACF; Tue, 24 Jan 2023 14:32:47 -0800 (PST)
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
Subject: [PATCH v2 04/14] arm64: dts: broadcom: bcmbca: Add spi controller node
Date:   Tue, 24 Jan 2023 14:12:07 -0800
Message-Id: <20230124221218.341511-5-william.zhang@broadcom.com>
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

Add support for HSSPI controller in ARMv8 chip dts files.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v2:
- Update compatible string with SoC model number, controller version
  info and bcmbca fall back name
- Add interrupt property

 .../boot/dts/broadcom/bcmbca/bcm4908.dtsi     | 19 +++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm4912.dtsi     | 21 +++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm63146.dtsi    | 20 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm63158.dtsi    | 20 ++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm6813.dtsi     | 21 +++++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm6856.dtsi     | 19 +++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm6858.dtsi     | 19 +++++++++++++++++
 .../boot/dts/broadcom/bcmbca/bcm94908.dts     |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm94912.dts     |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm963146.dts    |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm963158.dts    |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm96813.dts     |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm96856.dts     |  4 ++++
 .../boot/dts/broadcom/bcmbca/bcm96858.dts     |  4 ++++
 14 files changed, 167 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index eb2a78f4e033..7818cd562e17 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -107,6 +107,12 @@ periph_clk: periph_clk {
 			clock-frequency = <50000000>;
 			clock-output-names = "periph";
 		};
+
+		hsspi_pll: hsspi-pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <400000000>;
+		};
 	};
 
 	soc {
@@ -531,6 +537,19 @@ leds: leds@800 {
 			#size-cells = <0>;
 		};
 
+		hsspi: spi@1000{
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm4908-hsspi", "brcm,bcmbca-hsspi-v1.0",
+						 "brcm,bcmbca-hsspi";
+			reg = <0x1000 0x600>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&hsspi_pll &hsspi_pll>;
+			clock-names = "hsspi", "pll";
+			num-cs = <8>;
+			status = "disabled";
+		};
+
 		nand-controller@1800 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
index d5bc31980f03..75a63b5156b3 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
@@ -79,6 +79,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -86,6 +87,12 @@ uart_clk: uart-clk {
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
@@ -117,6 +124,20 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm4912-hsspi", "brcm,bcmbca-hsspi-v1.1",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
index 6f805266d3c9..b4ef4e1ba7e0 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
@@ -60,6 +60,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -67,6 +68,12 @@ uart_clk: uart-clk {
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
@@ -99,6 +106,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63146-hsspi", "brcm,bcmbca-hsspi-v1.0",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
index b982249b80a2..fc11d85235f7 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
@@ -79,6 +79,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -86,6 +87,12 @@ uart_clk: uart-clk {
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
 
 	psci {
@@ -117,6 +124,19 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm63158-hsspi", "brcm,bcmbca-hsspi-v1.0",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
index a996d436e977..412fafaede20 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
@@ -79,6 +79,7 @@ periph_clk: periph-clk {
 			#clock-cells = <0>;
 			clock-frequency = <200000000>;
 		};
+
 		uart_clk: uart-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -86,6 +87,12 @@ uart_clk: uart-clk {
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
@@ -117,6 +124,20 @@ bus@ff800000 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0xff800000 0x800000>;
 
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6813-hsspi", "brcm,bcmbca-hsspi-v1.1",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
index 62c530d4b103..930110022260 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
@@ -60,6 +60,12 @@ periph_clk:periph-clk {
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
+			compatible = "brcm,bcm6856-hsspi", "brcm,bcmbca-hsspi-v1.0",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
index 34c7b513d363..b9c1f7dad934 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
@@ -78,6 +78,12 @@ periph_clk:periph-clk {
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
@@ -137,5 +143,18 @@ uart0: serial@640 {
 			clock-names = "refclk";
 			status = "disabled";
 		};
+
+		hsspi: spi@1000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "brcm,bcm6858-hsspi", "brcm,bcmbca-hsspi-v1.0",
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
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
index fcbd3c430ace..c4e6e71f6310 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
index a3623e6f6919..e69cd683211a 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm94912.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
index e39f1e6d4774..db2c82d6dfd8 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963146.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
index eba07e0b1ca6..25c12bc63545 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm963158.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
index af17091ae764..faba21f03120 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96813.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
index 032aeb75c983..9808331eede2 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96856.dts
@@ -28,3 +28,7 @@ memory@0 {
 &uart0 {
 	status = "okay";
 };
+
+&hsspi {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
index 0cbf582f5d54..1f561c8e13b0 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm96858.dts
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

