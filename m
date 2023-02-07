Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8768CC9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBGCf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBGCfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:22 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F9D34020;
        Mon,  6 Feb 2023 18:35:21 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id ABBF62020780;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id EBDDCA6B9C;
        Tue,  7 Feb 2023 11:35:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/8] ARM: dts: uniphier: Add missing reg properties for glue layer
Date:   Tue,  7 Feb 2023 11:35:08 +0900
Message-Id: <20230207023514.29783-3-hayashi.kunihiko@socionext.com>
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

The nodes for glue layers should include "reg" property.
Add the property according to the DT schema.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 1 +
 arch/arm/boot/dts/uniphier-pro4.dtsi | 5 +++++
 arch/arm/boot/dts/uniphier-pro5.dtsi | 3 +++
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++++
 arch/arm/boot/dts/uniphier-sld8.dtsi | 1 +
 5 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 06b9571345a2..da2e3e0ffafd 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -347,6 +347,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld4-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 064f98b61525..048f4606fbae 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -421,6 +421,7 @@ sg_clk: clock-controller {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-pro4-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
@@ -535,6 +536,7 @@ ahci0: sata@65600000 {
 		sata-controller@65700000 {
 			compatible = "socionext,uniphier-pxs2-ahci-glue",
 				     "simple-mfd";
+			reg = <0x65700000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65700000 0x100>;
@@ -581,6 +583,7 @@ ahci1: sata@65800000 {
 		sata-controller@65900000 {
 			compatible = "socionext,uniphier-pro4-ahci-glue",
 				     "simple-mfd";
+			reg = <0x65900000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65900000 0x100>;
@@ -629,6 +632,7 @@ usb0: usb@65a00000 {
 		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pro4-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65b00000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x100>;
@@ -683,6 +687,7 @@ usb1: usb@65c00000 {
 		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pro4-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65d00000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x100>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 2af4fa19bf14..f4c87a100095 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -386,6 +386,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-pro5-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
@@ -489,6 +490,7 @@ usb0: usb@65a00000 {
 		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pro5-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65b00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
@@ -553,6 +555,7 @@ usb1: usb@65c00000 {
 		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pro5-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65d00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 050e9b7c83f1..1442320747ec 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -501,6 +501,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
@@ -614,6 +615,7 @@ ahci: sata@65600000 {
 		sata-controller@65700000 {
 			compatible = "socionext,uniphier-pxs2-ahci-glue",
 				     "simple-mfd";
+			reg = <0x65700000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65700000 0x100>;
@@ -658,6 +660,7 @@ usb0: usb@65a00000 {
 		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pxs2-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65b00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
@@ -753,6 +756,7 @@ usb1: usb@65c00000 {
 		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pxs2-dwc3-glue",
 				     "simple-mfd";
+			reg = <0x65d00000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index b4453f9fe981..c79c9bfef3ec 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -351,6 +351,7 @@ pinctrl: pinctrl {
 		syscon@5f900000 {
 			compatible = "socionext,uniphier-sld8-soc-glue-debug",
 				     "simple-mfd";
+			reg = <0x5f900000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0x5f900000 0x2000>;
-- 
2.25.1

