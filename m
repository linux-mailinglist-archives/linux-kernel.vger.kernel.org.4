Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEC667AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjALQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjALQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:30:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D1D60;
        Thu, 12 Jan 2023 08:28:53 -0800 (PST)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531:0:26cc:6c0f:ebfb:d967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF6BD6602DBB;
        Thu, 12 Jan 2023 16:28:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673540931;
        bh=/MUXja0lZkywFQKNAJ/ZYCX/AfVpxbPZT9qjorcgbTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ST32RcIJHyNRh+zZKkZrBx/I2Mxzi7yj/z+UC7xfTtN9tOvhS+h1SOuVcfaEP2DQy
         rq6Q8UfOU/Q1MqBGm9RWQl010dyVoJFJK0aMrWX/ICVxT4GTs1PDCe5Vd7G3x+1Ae4
         crSm3XCYJVleUkO6MkHXzW2Fb8gj31EUmrDXugiigYy0rH3WYkRJ3o5Iug0XlSRnRB
         c5iFfkX+OjfOHpCus/pHjGSqpaZBNg/fHiP7KrkOIubHuwxZ8jBkMJhKIZHWYC2WVg
         +qKmKTIne2ZI+HsPOWvV5s/djJJyADwJQa0AUEervCOzRu9PlkI3lVx/zzHkmdQGD7
         sX8GGrDdkU76Q==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 7199460E4F20; Thu, 12 Jan 2023 17:28:49 +0100 (CET)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     kernel@collabora.com, Nitin Yadav <n-yadav@ti.com>,
        martyn.welch@collabora.com,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: ti: k3-am62-main: Add support for USB
Date:   Thu, 12 Jan 2023 17:28:45 +0100
Message-Id: <20230112162847.973869-3-sjoerd@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112162847.973869-1-sjoerd@collabora.com>
References: <20230112162847.973869-1-sjoerd@collabora.com>
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
[cherry-pick from vendor BSP, disable nodes by default]
Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Tested-by: Martyn Welch <martyn.welch@collabora.com>

---

Changes in v4:
- Default to status="disabled" for usbss nodes

Changes in v3:
- Rebased against current ti-next aka 6.2-rc1
- Add Martyn's tested-by

Changes in v2:
- Rebase against linux-next 20221220

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 466b94d1cee9..2d437d3b94ed 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -555,6 +555,52 @@ sdhci2: mmc@fa20000 {
 		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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

