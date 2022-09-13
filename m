Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110185B66EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIME15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiIME1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:27:07 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C913564F2;
        Mon, 12 Sep 2022 21:23:54 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Sep 2022 13:23:29 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 3891B2059027;
        Tue, 13 Sep 2022 13:23:29 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 13 Sep 2022 13:23:29 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E7BE8B62A4;
        Tue, 13 Sep 2022 13:23:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 04/10] arm64: dts: uniphier: Rename gpio-hog nodes
Date:   Tue, 13 Sep 2022 13:23:15 +0900
Message-Id: <20220913042321.4817-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220913042321.4817-1-hayashi.kunihiko@socionext.com>
References: <20220913042321.4817-1-hayashi.kunihiko@socionext.com>
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

  uniphier-ld11-ref.dtb: gpio@55000000: 'xirq0' does not match any of the regexes: '^.+-hog(-[0-9+)?$', 'pinctrl-[0-9]+'
      From schema: Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml

This applies to the devicetre for LD11, LD20 and PXs3 SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts     | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts | 4 ++--
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts     | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
index 617d2b1e9b1e..41b47f5d2ed7 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts
@@ -51,7 +51,7 @@ &serial0 {
 };
 
 &gpio {
-	xirq0 {
+	xirq0-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
index aa159a11292c..b55b70ded015 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dts
@@ -168,12 +168,12 @@ &pcie {
 
 &gpio {
 	/* IRQs for Max3421 */
-	xirq0 {
+	xirq0-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(0) 1>;
 		input;
 	};
-	xirq10 {
+	xirq10-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(10) 1>;
 		input;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
index 39ee279a1eb9..8c111588c9a1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts
@@ -51,7 +51,7 @@ &serial0 {
 };
 
 &gpio {
-	xirq0 {
+	xirq0-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(0) 0>;
 		input;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 086040306fb3..feb070f934e9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -68,7 +68,7 @@ &serial3 {
 };
 
 &gpio {
-	xirq4 {
+	xirq4-hog {
 		gpio-hog;
 		gpios = <UNIPHIER_GPIO_IRQ(4) 0>;
 		input;
-- 
2.25.1

