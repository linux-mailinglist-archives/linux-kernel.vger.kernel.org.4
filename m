Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEAC5B66D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiIME0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIMEZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:25:39 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF23958095;
        Mon, 12 Sep 2022 21:22:54 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:22:53 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 1F49720584CE;
        Tue, 13 Sep 2022 13:22:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:22:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id DD041B62A4;
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
Subject: [PATCH v3 4/9] ARM: dts: uniphier: Rename gpio-hog node
Date:   Tue, 13 Sep 2022 13:22:44 +0900
Message-Id: <20220913042249.4708-5-hayashi.kunihiko@socionext.com>
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

According to gpio-hog schema, should add the suffix "-hog" to the node
names including gpio-hog to fix the following warning.

  uniphier-pro4-ref.dtb: gpio@55000000: 'xirq2' does not match any of the regexes: '^.+-hog(-[0-9+)?$', 'pinctrl-[0-9]+'
      From schema: Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml

This applies to the devicetree for LD4, LD6b, Pro4 and sLD8 SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-ld4-ref.dts  | 2 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts | 2 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ld4-ref.dts
index c46c2e8a10a7..e2d25c9160bd 100644
--- a/arch/arm/boot/dts/uniphier-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld4-ref.dts
@@ -56,7 +56,7 @@ &serial3 {
 };
 
 &gpio {
-	xirq1 {
+	xirq1-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(1) 0>;
 		input;
diff --git a/arch/arm/boot/dts/uniphier-ld6b-ref.dts b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
index 5bc7fe11b517..4f5e8848cecf 100644
--- a/arch/arm/boot/dts/uniphier-ld6b-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ld6b-ref.dts
@@ -60,7 +60,7 @@ &serial2 {
 };
 
 &gpio {
-	xirq4 {
+	xirq4-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(4) 0>;
 		input;
diff --git a/arch/arm/boot/dts/uniphier-pro4-ref.dts b/arch/arm/boot/dts/uniphier-pro4-ref.dts
index 3b9b61314d01..cc2cae935b5d 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ref.dts
@@ -59,7 +59,7 @@ &serial2 {
 };
 
 &gpio {
-	xirq2 {
+	xirq2-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(2) 0>;
 		input;
diff --git a/arch/arm/boot/dts/uniphier-sld8-ref.dts b/arch/arm/boot/dts/uniphier-sld8-ref.dts
index 6db949ec7411..b73647bafc63 100644
--- a/arch/arm/boot/dts/uniphier-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-sld8-ref.dts
@@ -56,7 +56,7 @@ &serial3 {
 };
 
 &gpio {
-	xirq0 {
+	xirq0-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
-- 
2.25.1

