Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046E75F044B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiI3FuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3FuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:50:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0644564;
        Thu, 29 Sep 2022 22:49:57 -0700 (PDT)
X-QQ-mid: bizesmtp77t1664516986tn7ksjcj
Received: from ubuntu.localdomain ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 13:49:44 +0800 (CST)
X-QQ-SSF: 01000000000000305000000A0000000
X-QQ-FEAT: dcYQFNbI8vE+qoAKv14uwKmwB+isk8Bi6JVRmSKueWlrbNKei9wcurdjin6Tn
        ISnvD+5g9odJ/SFlZ9pw09fv28J0oBeNBSVRCfuaKL1mV6mRbii1yGlUcb9B/7RfhsML+mj
        7GctJjx3b7sZO7Iy8vqrjtmqKubrulGoleILQdZR5rou94ZixVsRHw9LTe3YJe2LwYh2Mqt
        YAiLWksFg7y9X48cPV5uzTElKD5tFUAgUz/PmsfQOl/5yLCw7kYet8Lo5YHAcohxqFfwIOq
        W88ZezD9JDAiM65D7SCBuggVgAtOie96KFN8Vu9Z0Vom7GIwEIt9hh6bIEj4DZmYRWIPvrK
        r71o2PirKRT+HLVU+1YqZX0o5PGejkix77qyZeEQi2IZ/ZKlSoSWPhD/zh92J7HSgtABMHB
        22Xyd2iVRJs1zKEXfTSoRA==
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 19/30] dt-bindings: clock: Add StarFive JH7110 always-on definitions
Date:   Fri, 30 Sep 2022 13:49:43 +0800
Message-Id: <20220930054943.4744-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add all clock outputs for the StarFive JH7110 always-on clock generator.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../dt-bindings/clock/starfive-jh7110-aon.h   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/clock/starfive-jh7110-aon.h

diff --git a/include/dt-bindings/clock/starfive-jh7110-aon.h b/include/dt-bindings/clock/starfive-jh7110-aon.h
new file mode 100644
index 000000000000..5f1f7f2f1533
--- /dev/null
+++ b/include/dt-bindings/clock/starfive-jh7110-aon.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_AON_H__
+#define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_AON_H__
+
+#define JH7110_AONCLK_OSC_DIV4			 0
+#define JH7110_AONCLK_APB_FUNC			 1
+#define JH7110_AONCLK_GMAC0_AHB			 2
+#define JH7110_AONCLK_GMAC0_AXI			 3
+#define JH7110_AONCLK_GMAC0_RMII_RTX		 4
+#define JH7110_AONCLK_GMAC0_TX			 5
+#define JH7110_AONCLK_GMAC0_TX_INV		 6
+#define JH7110_AONCLK_GMAC0_RX			 7
+#define JH7110_AONCLK_GMAC0_RX_INV		 8
+#define JH7110_AONCLK_OTPC_APB			 9
+#define JH7110_AONCLK_RTC_APB			10
+#define JH7110_AONCLK_RTC_INTERNAL		11
+#define JH7110_AONCLK_RTC_32K			12
+#define JH7110_AONCLK_RTC_CAL			13
+
+#define JH7110_AONCLK_END			14
+
+#endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_H__ */
-- 
2.17.1

