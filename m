Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8468CCA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBGCff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBGCfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:24 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E37382BF2B;
        Mon,  6 Feb 2023 18:35:22 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:21 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3316F2058B4F;
        Tue,  7 Feb 2023 11:35:21 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B9E627368;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 6/8] arm64: dts: uniphier: Add missing reg properties for glue layer nodes
Date:   Tue,  7 Feb 2023 11:35:12 +0900
Message-Id: <20230207023514.29783-7-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
References: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nodes for some glue layers don't include necessary reg properties.
Add the properties according to the DT schema.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 1 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 5 +++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 148d9092572a..45004b0ae3eb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -562,6 +562,7 @@ usb_phy2: phy@2 {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld11-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index c83265c9b520..d70929b26a2a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -626,6 +626,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld20-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
@@ -778,6 +779,7 @@ usb: usb@65a00000 {
 		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-ld20-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65b00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index dd60cc04d6fb..4d200fec23fe 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -452,6 +452,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
@@ -619,6 +620,7 @@ ahci0: sata@65600000 {
 		sata-controller@65700000 {
 			compatible = "socionext,uniphier-pxs3-ahci-glue",
 				     "simple-mfd";
+			reg = <0x65700000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65700000 0x100>;
@@ -659,6 +661,7 @@ ahci1: sata@65800000 {
 		sata-controller@65900000 {
 			compatible = "socionext,uniphier-pxs3-ahci-glue",
 				     "simple-mfd";
+			reg = <0x65900000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65900000 0x100>;
@@ -703,6 +706,7 @@ usb0: usb@65a00000 {
 		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pxs3-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65b00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
@@ -805,6 +809,7 @@ usb1: usb@65c00000 {
 		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pxs3-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65d00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
-- 
2.25.1

