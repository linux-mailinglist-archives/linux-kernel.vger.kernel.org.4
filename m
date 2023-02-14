Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471F4696664
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjBNORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjBNORl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:17:41 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA52A99F;
        Tue, 14 Feb 2023 06:17:15 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 0C37626F791;
        Tue, 14 Feb 2023 15:07:36 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 15:07:23 +0100
Subject: [PATCH 2/2] arm64: dts: apple: t600x: Disable unused PCIe ports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-apple_dts_pcie_disable_unused-v1-2-5ea0d3ddcde3@jannau.net>
References: <20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net>
In-Reply-To: <20230214-apple_dts_pcie_disable_unused-v1-0-5ea0d3ddcde3@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667; i=j@jannau.net;
 h=from:subject:message-id; bh=74L4fYQpSoiEaY1wpdyutKStOgs9Y2VuNjtikaZdZnc=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXU5f9OvxLTOaU8uPdmfdO3+rM9m/R4xRfOWVG9yOJ2
 uWhC1RedpSyMIhxMMiKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhI8R+G/7nrLv9U6+jacuHs
 3Ozkvwo77cz7F6Zqpn++zq+Z5f1uyQdGhrVbfLOtmKV/PvSbuTzq1h+2/+fVdAzD13csq1Wb3nH
 VjgUA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe ports are unused (without devices) so disable them instead of
removing them.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  4 ++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 11 -----------
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 11 +++++++++++
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 1c41954e3899..273d7060d031 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -233,6 +233,7 @@ pcie0_dart_2: iommu@583008000 {
 		interrupt-parent = <&aic>;
 		interrupts = <AIC_IRQ 0 1277 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&ps_apcie_gp_sys>;
+		status = "disabled";
 	};
 
 	pcie0_dart_3: iommu@584008000 {
@@ -242,6 +243,7 @@ pcie0_dart_3: iommu@584008000 {
 		interrupt-parent = <&aic>;
 		interrupts = <AIC_IRQ 0 1280 IRQ_TYPE_LEVEL_HIGH>;
 		power-domains = <&ps_apcie_gp_sys>;
+		status = "disabled";
 	};
 
 	pcie0: pcie@590000000 {
@@ -338,6 +340,7 @@ port02: pci@2,0 {
 					<0 0 0 2 &port02 0 0 0 1>,
 					<0 0 0 3 &port02 0 0 0 2>,
 					<0 0 0 4 &port02 0 0 0 3>;
+			status = "disabled";
 		};
 
 		port03: pci@3,0 {
@@ -357,5 +360,6 @@ port03: pci@3,0 {
 					<0 0 0 2 &port03 0 0 0 1>,
 					<0 0 0 3 &port03 0 0 0 2>,
 					<0 0 0 4 &port03 0 0 0 3>;
+			status = "disabled";
 		};
 	};
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 34906d522f0a..356a73d1ce4c 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -101,14 +101,3 @@ sdhci0: mmc@0,0 {
 		wp-inverted;
 	};
 };
-
-&pcie0_dart_2 {
-	status = "disabled";
-};
-
-&pcie0_dart_3 {
-	status = "disabled";
-};
-
-/delete-node/ &port02;
-/delete-node/ &port03;
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index 00d3a9447c89..1e5a19e49b08 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -104,6 +104,7 @@ sdhci0: mmc@0,0 {
 &port02 {
 	/* 10 Gbit Ethernet */
 	bus-range = <3 3>;
+	status = "okay";
 	ethernet0: ethernet@0,0 {
 		reg = <0x30000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
@@ -114,4 +115,14 @@ ethernet0: ethernet@0,0 {
 &port03 {
 	/* USB xHCI */
 	bus-range = <4 4>;
+	status = "okay";
+};
+
+
+&pcie0_dart_2 {
+	status = "okay";
+};
+
+&pcie0_dart_3 {
+	status = "okay";
 };

-- 
2.39.1

