Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0A85B66DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIME0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIMEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:25:41 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AA8158082;
        Mon, 12 Sep 2022 21:22:57 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:22:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 1DE6D2059027;
        Tue, 13 Sep 2022 13:22:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:22:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AEF60B62AE;
        Tue, 13 Sep 2022 13:22:52 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 3/9] ARM: dts: uniphier: Rename usb-glue node for USB3 to usb-controller
Date:   Tue, 13 Sep 2022 13:22:43 +0900
Message-Id: <20220913042249.4708-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
References: <20220913042249.4708-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This "usb-glue" stands for an external controller associated with USB core,
however, this is not common. So rename to "usb-controller".

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pro5.dtsi | 4 ++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 6140eb42c42a..2232c67134a0 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -518,7 +518,7 @@ usb0: usb@65a00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65b00000 {
+		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pro4-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -571,7 +571,7 @@ usb1: usb@65c00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65d00000 {
+		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pro4-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 3525125832dd..afc225f3b4b8 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -480,7 +480,7 @@ usb0: usb@65a00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65b00000 {
+		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pro5-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -544,7 +544,7 @@ usb1: usb@65c00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65d00000 {
+		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pro5-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index c6288c772a7d..2602503e2275 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -609,7 +609,7 @@ usb0: usb@65a00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65b00000 {
+		usb-controller@65b00000 {
 			compatible = "socionext,uniphier-pxs2-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -704,7 +704,7 @@ usb1: usb@65c00000 {
 			dr_mode = "host";
 		};
 
-		usb-glue@65d00000 {
+		usb-controller@65d00000 {
 			compatible = "socionext,uniphier-pxs2-dwc3-glue",
 				     "simple-mfd";
 			#address-cells = <1>;
-- 
2.25.1

