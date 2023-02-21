Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687469D8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjBUCrV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 21:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBUCrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:47:10 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED4E23C45;
        Mon, 20 Feb 2023 18:46:59 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5465A24E331;
        Tue, 21 Feb 2023 10:46:58 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 10:46:58 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 10:46:57 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/19] reset: starfive: Rename "jh7100" to "jh71x0" for the common code
Date:   Tue, 21 Feb 2023 10:46:33 +0800
Message-ID: <20230221024645.127922-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230221024645.127922-1-hal.feng@starfivetech.com>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

For the common code will be shared with the StarFive JH7110 SoC.

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../reset/starfive/reset-starfive-jh7100.c    |  2 +-
 .../reset/starfive/reset-starfive-jh71x0.c    | 50 +++++++++----------
 .../reset/starfive/reset-starfive-jh71x0.h    |  2 +-
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index 9d7cb4ed8869..5f06e5ae3346 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -51,7 +51,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return reset_starfive_jh7100_register(&pdev->dev, pdev->dev.of_node,
+	return reset_starfive_jh71x0_register(&pdev->dev, pdev->dev.of_node,
 					      base + JH7100_RESET_ASSERT0,
 					      base + JH7100_RESET_STATUS0,
 					      jh7100_reset_asserted,
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
index 3577444a89c6..a689f4730ed7 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.c
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Reset driver for the StarFive JH7100 SoC
+ * Reset driver for the StarFive JH71X0 SoCs
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
@@ -15,7 +15,7 @@
 
 #include "reset-starfive-jh71x0.h"
 
-struct jh7100_reset {
+struct jh71x0_reset {
 	struct reset_controller_dev rcdev;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -24,16 +24,16 @@ struct jh7100_reset {
 	const u64 *asserted;
 };
 
-static inline struct jh7100_reset *
-jh7100_reset_from(struct reset_controller_dev *rcdev)
+static inline struct jh71x0_reset *
+jh71x0_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh7100_reset, rcdev);
+	return container_of(rcdev, struct jh71x0_reset, rcdev);
 }
 
-static int jh7100_reset_update(struct reset_controller_dev *rcdev,
+static int jh71x0_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
 	unsigned long offset = BIT_ULL_WORD(id);
 	u64 mask = BIT_ULL_MASK(id);
 	void __iomem *reg_assert = data->assert + offset * sizeof(u64);
@@ -62,34 +62,34 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
+static int jh71x0_reset_assert(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	return jh7100_reset_update(rcdev, id, true);
+	return jh71x0_reset_update(rcdev, id, true);
 }
 
-static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
+static int jh71x0_reset_deassert(struct reset_controller_dev *rcdev,
 				 unsigned long id)
 {
-	return jh7100_reset_update(rcdev, id, false);
+	return jh71x0_reset_update(rcdev, id, false);
 }
 
-static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
+static int jh71x0_reset_reset(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
 	int ret;
 
-	ret = jh7100_reset_assert(rcdev, id);
+	ret = jh71x0_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh7100_reset_deassert(rcdev, id);
+	return jh71x0_reset_deassert(rcdev, id);
 }
 
-static int jh7100_reset_status(struct reset_controller_dev *rcdev,
+static int jh71x0_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	struct jh71x0_reset *data = jh71x0_reset_from(rcdev);
 	unsigned long offset = BIT_ULL_WORD(id);
 	u64 mask = BIT_ULL_MASK(id);
 	void __iomem *reg_status = data->status + offset * sizeof(u64);
@@ -98,25 +98,25 @@ static int jh7100_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh7100_reset_ops = {
-	.assert		= jh7100_reset_assert,
-	.deassert	= jh7100_reset_deassert,
-	.reset		= jh7100_reset_reset,
-	.status		= jh7100_reset_status,
+static const struct reset_control_ops jh71x0_reset_ops = {
+	.assert		= jh71x0_reset_assert,
+	.deassert	= jh71x0_reset_deassert,
+	.reset		= jh71x0_reset_reset,
+	.status		= jh71x0_reset_status,
 };
 
-int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_node,
+int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u64 *asserted, unsigned int nr_resets,
 				   struct module *owner)
 {
-	struct jh7100_reset *data;
+	struct jh71x0_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->rcdev.ops = &jh7100_reset_ops;
+	data->rcdev.ops = &jh71x0_reset_ops;
 	data->rcdev.owner = owner;
 	data->rcdev.nr_resets = nr_resets;
 	data->rcdev.dev = dev;
@@ -129,4 +129,4 @@ int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_no
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
-EXPORT_SYMBOL_GPL(reset_starfive_jh7100_register);
+EXPORT_SYMBOL_GPL(reset_starfive_jh71x0_register);
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
index 1fc5a648c8d8..ac9e80dd3f59 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
@@ -6,7 +6,7 @@
 #ifndef __RESET_STARFIVE_JH71X0_H
 #define __RESET_STARFIVE_JH71X0_H
 
-int reset_starfive_jh7100_register(struct device *dev, struct device_node *of_node,
+int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u64 *asserted, unsigned int nr_resets,
 				   struct module *owner);
-- 
2.38.1

