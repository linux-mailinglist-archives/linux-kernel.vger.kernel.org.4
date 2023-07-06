Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6F749B12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjGFLqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjGFLqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:46:01 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EFE10EC;
        Thu,  6 Jul 2023 04:45:59 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Thu, 6 Jul 2023
 19:45:48 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <brgl@bgdev.pl>, <andy@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 1/2] dt-bindings: gpio: Add a header file for Amlogic C3 SoCs
Date:   Thu, 6 Jul 2023 19:45:21 +0800
Message-ID: <20230706114522.2490655-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230706114522.2490655-1-huqiang.qin@amlogic.com>
References: <20230706114522.2490655-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding and related header file for Amlogic C3 GPIO

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 .../pinctrl/amlogic,meson-pinctrl-a1.yaml     |  1 +
 include/dt-bindings/gpio/amlogic-c3-gpio.h    | 72 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 include/dt-bindings/gpio/amlogic-c3-gpio.h

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
index 99080c9eaac3..e019b6aa6ca3 100644
--- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-a1.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - amlogic,meson-a1-periphs-pinctrl
       - amlogic,meson-s4-periphs-pinctrl
+      - amlogic,c3-periphs-pinctrl
 
 required:
   - compatible
diff --git a/include/dt-bindings/gpio/amlogic-c3-gpio.h b/include/dt-bindings/gpio/amlogic-c3-gpio.h
new file mode 100644
index 000000000000..75c8da6f505f
--- /dev/null
+++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Huqiang Qin <huqiang.qin@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_C3_GPIO_H
+#define _DT_BINDINGS_AMLOGIC_C3_GPIO_H
+
+#define	GPIOE_0		0
+#define	GPIOE_1		1
+#define	GPIOE_2		2
+#define	GPIOE_3		3
+#define	GPIOE_4		4
+
+#define	GPIOB_0		5
+#define	GPIOB_1		6
+#define	GPIOB_2		7
+#define	GPIOB_3		8
+#define	GPIOB_4		9
+#define	GPIOB_5		10
+#define	GPIOB_6		11
+#define	GPIOB_7		12
+#define	GPIOB_8		13
+#define	GPIOB_9		14
+#define	GPIOB_10	15
+#define	GPIOB_11	16
+#define	GPIOB_12	17
+#define	GPIOB_13	18
+#define	GPIOB_14	19
+
+#define	GPIOC_0		20
+#define	GPIOC_1		21
+#define	GPIOC_2		22
+#define	GPIOC_3		23
+#define	GPIOC_4		24
+#define	GPIOC_5		25
+#define	GPIOC_6		26
+
+#define	GPIOX_0		27
+#define	GPIOX_1		28
+#define	GPIOX_2		29
+#define	GPIOX_3		30
+#define	GPIOX_4		31
+#define	GPIOX_5		32
+#define	GPIOX_6		33
+#define	GPIOX_7		34
+#define	GPIOX_8		35
+#define	GPIOX_9		36
+#define	GPIOX_10	37
+#define	GPIOX_11	38
+#define	GPIOX_12	39
+#define	GPIOX_13	40
+
+#define	GPIOD_0		41
+#define	GPIOD_1		42
+#define	GPIOD_2		43
+#define	GPIOD_3		44
+#define	GPIOD_4		45
+#define	GPIOD_5		46
+#define	GPIOD_6		47
+
+#define	GPIOA_0		48
+#define	GPIOA_1		49
+#define	GPIOA_2		50
+#define	GPIOA_3		51
+#define	GPIOA_4		52
+#define	GPIOA_5		53
+
+#define	GPIO_TEST_N	54
+
+#endif /* _DT_BINDINGS_AMLOGIC_C3_GPIO_H */
-- 
2.37.1

