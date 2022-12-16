Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E2164ECFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLPOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiLPOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:36:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254A566D0;
        Fri, 16 Dec 2022 06:36:29 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 20A1D6602C96;
        Fri, 16 Dec 2022 14:36:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671201388;
        bh=BqgYz8Eogobh4whm0C4LEh90RF++fj19v2v//Dm1BHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7TI6E/JdKAOqWmlq2fDBy0HQipa3RX7Mq5AHFR6pdG+gKUl+BO60tLsLNzm1aZ0/
         YWUgQtQNm6SvmswFMGIwljN6nbXcc/VeuLALy5d/O6KK/B+tUqLQeGsfUwkmIE79AL
         zdoGZt9hKFCT8fr9rjzFv2DVkDtpXSoJIPSaHij4zcQH3WKPM3+ZHxz7wN5lfa+Uth
         IlMMOWPXN2BkCe9dpwXt8jou4eNKBNFqKGiDs5q0OMMVlLAsKWanuI6pREWneBmvsz
         n7DGLG+kbzL5EaDEYZpImKVZoDYo4h1R155xHeOqiTLBtMyt3nJNL4XOy1zr0u5PHa
         oRUD0xpvKmEwQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id F166F5E33158; Fri, 16 Dec 2022 15:36:25 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     martyn.welch@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62-main: Add support for USB
Date:   Fri, 16 Dec 2022 15:36:22 +0100
Message-Id: <20221216143624.23708-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216143624.23708-1-sjoerd@collabora.com>
References: <20221216143624.23708-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

AM62 SoC has two instances of USB on it. Therefore, add support for the
same.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[cherry-pick from vendor BSP]]
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 28c250a8d1ec..105ffbf94a75 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -442,6 +442,50 @@ sdhci2: mmc@fa20000 {
 		ti,clkbuf-sel = <0x7>;
 	};
 
+	usbss0: dwc3-usb@f900000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f900000 0x00 0x800>;
+		clocks = <&k3_clks 161 3>;
+		clock-names = "ref";
+		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
+		ranges;
+
+		usb0: usb@31000000 {
+			compatible = "snps,dwc3";
+			reg =<0x00 0x31000000 0x00 0x50000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+			interrupt-names = "host", "peripheral";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+		};
+	};
+
+	usbss1: dwc3-usb@f910000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f910000 0x00 0x800>;
+		clocks = <&k3_clks 162 3>;
+		clock-names = "ref";
+		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		ranges;
+
+		usb1: usb@31100000 {
+			compatible = "snps,dwc3";
+			reg =<0x00 0x31100000 0x00 0x50000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+			interrupt-names = "host", "peripheral";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+		};
+	};
+
 	fss: bus@fc00000 {
 		compatible = "simple-bus";
 		reg = <0x00 0x0fc00000 0x00 0x70000>;
-- 
2.39.0

