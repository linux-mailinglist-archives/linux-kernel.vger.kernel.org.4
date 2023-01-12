Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE56673AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjALNy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjALNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:54:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81AC5132B;
        Thu, 12 Jan 2023 05:54:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id v3so12816143pgh.4;
        Thu, 12 Jan 2023 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhM7bwow3Axmxv0uwAXgeOIfb2v+Ug4+kK9onW1wHUg=;
        b=Kg5G+EalZKQL3CrtUo45+YZ25ACthjVafKI9bvO4cEIEr/WWZiPNyq0Pdik5cTjV4T
         nu1cYE8zd6yT5XxH8qQvqykBOnpa6ulaWdgavIBlREtE80mvBWfYC6rVHGniVBm+XJxX
         ecfnuvZkfRiv3PFM3sNe4FZQngN49Xu/c6nu9IarvMLcJBN3bcpvRSKl0MnFMNdV1RBS
         BuU+wTHGh5NBtar9OvRbPnGYEM+zq+fZNE3V6fIxmkyOxAsCoYELGkpKfqkvitBSvxP/
         OLKmNaic/Pi/REyWBl8LW5QXBzwCUnTuOYRFxfpkzBi39pS2Jlj1jyHCEbmD8nYe2nYU
         5MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhM7bwow3Axmxv0uwAXgeOIfb2v+Ug4+kK9onW1wHUg=;
        b=RQ3+W3wjYY+Mzyw3b5QM6RREc+xre97aUqoFFALwz/aUERM+9lJvOLOj3IGNmQjYWp
         oO8ENJPQ1IKIBFcXP3SK6g/5JRhX4KIIa5adfii/IJ2YIwcoxaRxdjqSTWfO3hUo2Pv8
         0Zg+o4lAlSdsAJtys4bJ98Bs4upQ7Gmkii4oaCwI4fn4AOefjB4fEuxtYeNZnqYfjTc2
         ZrRzhrJPCCbfx8MvZ1iYItJuhteXOOUJO0SbzRlwxg+s2kzlWN5DV+ywWnHDRx4NDNUM
         HabBmWdKFdWcYqHIM4mRkfw24nwIkYLKoqN2KPolCXAFm6/h51cclF7xM6freufIXDFw
         iiJg==
X-Gm-Message-State: AFqh2kpTXrkdYltetqORY9+zu6UE0Gnmv1+nKI1fwIicL2YyCs9TEPUe
        ItGsI3BMpxwjW11Um5SZhBFRdnA+QUTJWA==
X-Google-Smtp-Source: AMrXdXtuvEFooyLOGPTf/zTn6cAWHP4b3gizbVWMUGs8C6bQ8Sy+v//PDXC1RVyrdFt2Gl6bvL49wA==
X-Received: by 2002:a62:6487:0:b0:563:cc80:fb66 with SMTP id y129-20020a626487000000b00563cc80fb66mr58235208pfb.0.1673531647659;
        Thu, 12 Jan 2023 05:54:07 -0800 (PST)
Received: from droid01-cd.amlogic.com (60-248-184-76.hinet-ip.hinet.net. [60.248.184.76])
        by smtp.gmail.com with ESMTPSA id 207-20020a6218d8000000b00580d877a50fsm11949947pfy.55.2023.01.12.05.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:54:07 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] cpufreq: loongson1: Delete obsolete driver
Date:   Thu, 12 Jan 2023 21:53:42 +0800
Message-Id: <20230112135342.3927338-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic DT based cpufreq driver works for Loongson-1,
so delete the old custom driver.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/cpufreq/Kconfig             |   9 --
 drivers/cpufreq/Makefile            |   1 -
 drivers/cpufreq/loongson1-cpufreq.c | 222 ----------------------------
 3 files changed, 232 deletions(-)
 delete mode 100644 drivers/cpufreq/loongson1-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2a84fc63371e..448b8ffb4ebd 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -270,15 +270,6 @@ config LOONGSON2_CPUFREQ
 
 	  Loongson2F and its successors support this feature.
 
-	  If in doubt, say N.
-
-config LOONGSON1_CPUFREQ
-	tristate "Loongson1 CPUFreq Driver"
-	depends on LOONGSON1_LS1B
-	help
-	  This option adds a CPUFreq driver for loongson1 processors which
-	  support software configurable cpu frequency.
-
 	  If in doubt, say N.
 endif
 
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 32a7029e25ed..4a806cc5265b 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -111,7 +111,6 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
deleted file mode 100644
index fb72d709db56..000000000000
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ /dev/null
@@ -1,222 +0,0 @@
-/*
- * CPU Frequency Scaling for Loongson 1 SoC
- *
- * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/cpu.h>
-#include <linux/cpufreq.h>
-#include <linux/delay.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include <cpufreq.h>
-#include <loongson1.h>
-
-struct ls1x_cpufreq {
-	struct device *dev;
-	struct clk *clk;	/* CPU clk */
-	struct clk *mux_clk;	/* MUX of CPU clk */
-	struct clk *pll_clk;	/* PLL clk */
-	struct clk *osc_clk;	/* OSC clk */
-	unsigned int max_freq;
-	unsigned int min_freq;
-};
-
-static struct ls1x_cpufreq *cpufreq;
-
-static int ls1x_cpufreq_notifier(struct notifier_block *nb,
-				 unsigned long val, void *data)
-{
-	if (val == CPUFREQ_POSTCHANGE)
-		current_cpu_data.udelay_val = loops_per_jiffy;
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block ls1x_cpufreq_notifier_block = {
-	.notifier_call = ls1x_cpufreq_notifier
-};
-
-static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
-			       unsigned int index)
-{
-	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	unsigned int old_freq, new_freq;
-
-	old_freq = policy->cur;
-	new_freq = policy->freq_table[index].frequency;
-
-	/*
-	 * The procedure of reconfiguring CPU clk is as below.
-	 *
-	 *  - Reparent CPU clk to OSC clk
-	 *  - Reset CPU clock (very important)
-	 *  - Reconfigure CPU DIV
-	 *  - Reparent CPU clk back to CPU DIV clk
-	 */
-
-	clk_set_parent(policy->clk, cpufreq->osc_clk);
-	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
-		     LS1X_CLK_PLL_DIV);
-	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
-		     LS1X_CLK_PLL_DIV);
-	clk_set_rate(cpufreq->mux_clk, new_freq * 1000);
-	clk_set_parent(policy->clk, cpufreq->mux_clk);
-	dev_dbg(cpu_dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
-
-	return 0;
-}
-
-static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
-{
-	struct device *cpu_dev = get_cpu_device(policy->cpu);
-	struct cpufreq_frequency_table *freq_tbl;
-	unsigned int pll_freq, freq;
-	int steps, i;
-
-	pll_freq = clk_get_rate(cpufreq->pll_clk) / 1000;
-
-	steps = 1 << DIV_CPU_WIDTH;
-	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
-	if (!freq_tbl)
-		return -ENOMEM;
-
-	for (i = 0; i < (steps - 1); i++) {
-		freq = pll_freq / (i + 1);
-		if ((freq < cpufreq->min_freq) || (freq > cpufreq->max_freq))
-			freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else
-			freq_tbl[i].frequency = freq;
-		dev_dbg(cpu_dev,
-			"cpufreq table: index %d: frequency %d\n", i,
-			freq_tbl[i].frequency);
-	}
-	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
-
-	policy->clk = cpufreq->clk;
-	cpufreq_generic_init(policy, freq_tbl, 0);
-
-	return 0;
-}
-
-static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	kfree(policy->freq_table);
-	return 0;
-}
-
-static struct cpufreq_driver ls1x_cpufreq_driver = {
-	.name		= "cpufreq-ls1x",
-	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= ls1x_cpufreq_target,
-	.get		= cpufreq_generic_get,
-	.init		= ls1x_cpufreq_init,
-	.exit		= ls1x_cpufreq_exit,
-	.attr		= cpufreq_generic_attr,
-};
-
-static int ls1x_cpufreq_remove(struct platform_device *pdev)
-{
-	cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
-				    CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-
-	return 0;
-}
-
-static int ls1x_cpufreq_probe(struct platform_device *pdev)
-{
-	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
-	struct clk *clk;
-	int ret;
-
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
-		dev_err(&pdev->dev, "platform data missing\n");
-		return -EINVAL;
-	}
-
-	cpufreq =
-	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
-	if (!cpufreq)
-		return -ENOMEM;
-
-	cpufreq->dev = &pdev->dev;
-
-	clk = devm_clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get %s clock\n",
-			pdata->clk_name);
-		return PTR_ERR(clk);
-	}
-	cpufreq->clk = clk;
-
-	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
-			__clk_get_name(cpufreq->clk));
-		return PTR_ERR(clk);
-	}
-	cpufreq->mux_clk = clk;
-
-	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
-			__clk_get_name(cpufreq->mux_clk));
-		return PTR_ERR(clk);
-	}
-	cpufreq->pll_clk = clk;
-
-	clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "unable to get %s clock\n",
-			pdata->osc_clk_name);
-		return PTR_ERR(clk);
-	}
-	cpufreq->osc_clk = clk;
-
-	cpufreq->max_freq = pdata->max_freq;
-	cpufreq->min_freq = pdata->min_freq;
-
-	ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to register CPUFreq driver: %d\n", ret);
-		return ret;
-	}
-
-	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
-
-	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to register CPUFreq notifier: %d\n",ret);
-		cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-	}
-
-	return ret;
-}
-
-static struct platform_driver ls1x_cpufreq_platdrv = {
-	.probe	= ls1x_cpufreq_probe,
-	.remove	= ls1x_cpufreq_remove,
-	.driver	= {
-		.name	= "ls1x-cpufreq",
-	},
-};
-
-module_platform_driver(ls1x_cpufreq_platdrv);
-
-MODULE_ALIAS("platform:ls1x-cpufreq");
-MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
-MODULE_LICENSE("GPL");

base-commit: 837dc62247d5e50a0724af2001f070962300c87e
-- 
2.34.1

