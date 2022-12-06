Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989DC644F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLFXPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:15:35 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B740429A1;
        Tue,  6 Dec 2022 15:15:33 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 5E03B26F48E;
        Tue,  6 Dec 2022 23:57:44 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 06 Dec 2022 23:57:37 +0100
Subject: [PATCH 2/2] arch: arm64: apple: t600x: Use standard "iommu" node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221206-arm64-dts-apple-pcie-iommu-v1-2-210c56e48c01@jannau.net>
References: <20221206-arm64-dts-apple-pcie-iommu-v1-0-210c56e48c01@jannau.net>
In-Reply-To: <20221206-arm64-dts-apple-pcie-iommu-v1-0-210c56e48c01@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>
X-Mailer: b4 0.11.0-dev-022da
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=j@jannau.net;
 h=from:subject:message-id; bh=PR59BFpwWKZuVp84D3tOoUGAXly9jSYCgHXD5W2xG5Y=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuT+E8/+Hvg17aflWQs3cUn3rqJMR7EECZZduwQei8emnDYw
 /MzVUcrCIMbBICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCKcMYwMe14YmF27Z2vxKHXrkdqJkt
 rqDyXmPZVI5//q9rNGO+FzDsNf4aa4WcGT+57XdFf7Xnq9Ol5KMDI/cOWsjQ9ct839+WgzPwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe iommu nodes use "dart" as node names. Replace it with the
the standard "iommu" node name as all other iommu nodes.

Fixes: 7b0b0191a2c7 ("arm64: dts: apple: Add initial t6000/t6001/t6002 DTs")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 0b8958a8db77..f006f990a8e2 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -208,7 +208,7 @@ mca: mca@39b600000 {
 		#sound-dai-cells = <1>;
 	};
 
-	pcie0_dart_0: dart@581008000 {
+	pcie0_dart_0: iommu@581008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x5 0x81008000 0x0 0x4000>;
 		#iommu-cells = <1>;
@@ -217,7 +217,7 @@ pcie0_dart_0: dart@581008000 {
 		power-domains = <&ps_apcie_gp_sys>;
 	};
 
-	pcie0_dart_1: dart@582008000 {
+	pcie0_dart_1: iommu@582008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x5 0x82008000 0x0 0x4000>;
 		#iommu-cells = <1>;
@@ -226,7 +226,7 @@ pcie0_dart_1: dart@582008000 {
 		power-domains = <&ps_apcie_gp_sys>;
 	};
 
-	pcie0_dart_2: dart@583008000 {
+	pcie0_dart_2: iommu@583008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x5 0x83008000 0x0 0x4000>;
 		#iommu-cells = <1>;
@@ -235,7 +235,7 @@ pcie0_dart_2: dart@583008000 {
 		power-domains = <&ps_apcie_gp_sys>;
 	};
 
-	pcie0_dart_3: dart@584008000 {
+	pcie0_dart_3: iommu@584008000 {
 		compatible = "apple,t6000-dart";
 		reg = <0x5 0x84008000 0x0 0x4000>;
 		#iommu-cells = <1>;

-- 
2.38.1
