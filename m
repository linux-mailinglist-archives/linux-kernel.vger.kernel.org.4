Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90A6B7B11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjCMOvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCMOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:50:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3570A74335;
        Mon, 13 Mar 2023 07:50:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DEnfpJ044507;
        Mon, 13 Mar 2023 09:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678718981;
        bh=RTf4J3zVmz9UIzhMrDvWTIRzZ+fFJueiDX/4hEq8MBE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ECc7xZK6Uq5/iqt+wpPmNqxZZMOgNQI2tV42X2C5/1/N3GjfoR5ih07MyZrWoQvLU
         Un90ZJiIfrzSkMNhqSYhxUc0XSfOXtl9n3MMrPh2bAyxAWrcIZrV/fyrjNNg+YOjHQ
         HbVcFFGt4TkL1bu35gDNa+85U1fSMibaLm7F9iZw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DEnfiw123658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 09:49:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 09:49:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 09:49:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DEne6B122948;
        Mon, 13 Mar 2023 09:49:40 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 2/6] arm64: dts: ti: k3-am62-main: Add McASP nodes
Date:   Mon, 13 Mar 2023 20:19:31 +0530
Message-ID: <20230313-mcasp_upstream-v5-2-d6844707aa8a@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=vAiECCbRBTuSSHKHrNzv2pqB2mqxrvCFcodpCjBORbU=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkDzbT0m2OKRNjmKmrjsr206qiPgO1VWbQ8Lzv5
 CMc7ApG6yCJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZA820wAKCRBD3pH5JJpx
 RfWkEAC9/j83YlMzER6zNlTE4Xup4i4aRlyLAGWYjHRuPngFrYWpcdDOklwhLy9ddAMF0lmfwrd
 qX1jiMskbDrdM6LyG+HEP5yw6eZgMDl7V7EFEzrxO0q93GCFg+kNLzunMuio3geU7o2RKWhfdOe
 jQprhBW/se7L6pnWyxiOGQhQ8N8LXSnwRX9ROcqVmOOHhW9vEk6oeOCX2At8y5hzPISOGHa05KI
 y/MECJyDgXxc4xuWAwSKriqutGYRmjRafxoQKrKxbAkXKhwK/alpATFbatoaof7qEjEO10QQYmb
 vBbPmYvgSvIIorzZA80NiVB3q/a/PtQv3N8Nm75L2S5uOaGcfy9vpzzh8duu462No5zjy3C/BrI
 ALsvUGo6POZSHcH/GCoWOp6iNyUd3lqxQ0p5w2YIAb8dCCZwNN+yWRM6gdi0W2qRUcd5XrIiuFJ
 cCjnQTosfx5h1EKDukj09bdtHgt+mk4Bkc0h8t8TdmHhy67fANvC36iSIkvexSmdzzsHsTlPcu2
 BvzYTyXfrpqlMKhguWEgWuL6t1b2SYXA34uQlhLFaW6E948QrYm7TF07P83LAeMFPy3RbLQVbLx
 HCacxmaMQNX1aaWLlD2gUq3WvzxRrHAnZ/IMI9uT+8hGlZnLRes5CaLWd3dGcR0r10Uj0Odq2To
 CQ01hD1d9LcWo6A==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayesh Choudhary <j-choudhary@ti.com>

Add the nodes for McASP 0-2.

Use the audio-friendly 96MHz main_1_hsdivout6_clk as clock parent
instead of the default 100Mhz main_2_hsdivout8_clk source.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index ea683fd77d6a..4da5747987bb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -787,4 +787,64 @@ epwm2: pwm@23020000 {
 		clock-names = "tbclk", "fck";
 		status = "disabled";
 	};
+
+	mcasp0: mcasp@2b00000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b00000 0x00 0x2000>,
+		      <0x00 0x02b08000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc500 0>, <&main_bcdma 0 0x4500 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 190 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 190 0>;
+		assigned-clock-parents = <&k3_clks 190 2>;
+		power-domains = <&k3_pds 190 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp1: mcasp@2b10000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b10000 0x00 0x2000>,
+		      <0x00 0x02b18000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc501 0>, <&main_bcdma 0 0x4501 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 191 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 191 0>;
+		assigned-clock-parents = <&k3_clks 191 2>;
+		power-domains = <&k3_pds 191 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
+
+	mcasp2: mcasp@2b20000 {
+		compatible = "ti,am33xx-mcasp-audio";
+		reg = <0x00 0x02b20000 0x00 0x2000>,
+		      <0x00 0x02b28000 0x00 0x400>;
+		reg-names = "mpu","dat";
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tx", "rx";
+
+		dmas = <&main_bcdma 0 0xc502 0>, <&main_bcdma 0 0x4502 0>;
+		dma-names = "tx", "rx";
+
+		clocks = <&k3_clks 192 0>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 192 0>;
+		assigned-clock-parents = <&k3_clks 192 2>;
+		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
+	};
 };

-- 
2.39.2
