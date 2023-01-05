Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C4365EDA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjAENrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjAENq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:46:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343173D9FA;
        Thu,  5 Jan 2023 05:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5707B81AD7;
        Thu,  5 Jan 2023 13:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E88C433F1;
        Thu,  5 Jan 2023 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926414;
        bh=hDZVtcujKWtYdndI0ba6f6HB7HdfrT4YcZAnQccoayk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WOFoWAlDkvszr2Z9eXXqIFC8gOTs7I37sRn3nu8apjX/TkKYTAPrYcDIzcob28eaS
         SeyWfKycLybcABQHQPKx5Y6+yKe+rl632JOj6VAeujuekGIM1xfT7Yl37eWUPIDQ3A
         TXUjc4y42lLafyUY5hB4erUixdsqFoSYLX7OK0623wp096hPzQrHTllwIsSBoPY5ti
         JrJMtyRiMGR2tLK1U6d/Yu2/NLi7XucsmlqJEZC+I4n/MQ+ABVv1TzyedcJ821uh00
         bLond2MHPo/9+POwA4LJa2AGEthZSIU1ZsUw+xsCp95eyUHhIpp34Hrmit5od6w4id
         50btfknoOraqw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 04/27] ARM: pxa: drop pxa310/pxa320/pxa93x support
Date:   Thu,  5 Jan 2023 14:45:59 +0100
Message-Id: <20230105134622.254560-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There is currently no devicetree support for any of these three
SoCs, and no board files remain. As it seems unlikely that anyone
is going to add DT support soon, let's drop the SoC specific code
now.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-clk@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.h      |   1 -
 arch/arm/mach-pxa/mfp-pxa300.h   |  52 ----
 arch/arm/mach-pxa/mfp-pxa930.h   | 495 -------------------------------
 arch/arm/mach-pxa/pxa300.c       |  17 +-
 arch/arm/mach-pxa/pxa3xx.c       |   4 +-
 drivers/clk/pxa/clk-pxa3xx.c     |  22 +-
 drivers/cpufreq/pxa3xx-cpufreq.c |  21 +-
 drivers/mmc/host/pxamci.c        |   3 +-
 drivers/pcmcia/pxa2xx_base.c     |   6 -
 include/linux/soc/pxa/cpu.h      |  93 +-----
 10 files changed, 9 insertions(+), 705 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/mfp-pxa930.h

diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 82c83939017a..1c252eca39c1 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -54,7 +54,6 @@ extern struct platform_device pxa_device_asoc_ssp4;
 extern struct platform_device pxa25x_device_gpio;
 extern struct platform_device pxa27x_device_gpio;
 extern struct platform_device pxa3xx_device_gpio;
-extern struct platform_device pxa93x_device_gpio;
 
 void __init pxa_register_device(struct platform_device *dev, void *data);
 void __init pxa2xx_set_dmac_info(struct mmp_dma_platdata *dma_pdata);
diff --git a/arch/arm/mach-pxa/mfp-pxa300.h b/arch/arm/mach-pxa/mfp-pxa300.h
index 1223e350cea0..058698e7e513 100644
--- a/arch/arm/mach-pxa/mfp-pxa300.h
+++ b/arch/arm/mach-pxa/mfp-pxa300.h
@@ -27,15 +27,6 @@
 #define GPIO61_GPIO		MFP_CFG(GPIO61, AF0)
 #define GPIO62_GPIO		MFP_CFG(GPIO62, AF0)
 
-#ifdef CONFIG_CPU_PXA310
-#define GPIO7_2_GPIO		MFP_CFG(GPIO7_2, AF0)
-#define GPIO8_2_GPIO		MFP_CFG(GPIO8_2, AF0)
-#define GPIO9_2_GPIO		MFP_CFG(GPIO9_2, AF0)
-#define GPIO10_2_GPIO		MFP_CFG(GPIO10_2, AF0)
-#define GPIO11_2_GPIO		MFP_CFG(GPIO11_2, AF0)
-#define GPIO12_2_GPIO		MFP_CFG(GPIO12_2, AF0)
-#endif
-
 /* Chip Select */
 #define GPIO1_nCS2		MFP_CFG(GPIO1,	AF1)
 #define GPIO2_nCS3		MFP_CFG(GPIO2,  AF1)
@@ -526,47 +517,4 @@
 #define GPIO46_UTM_PHYDATA_7	MFP_CFG(GPIO46,  AF3)
 #endif /* CONFIG_CPU_PXA300 */
 
-/*
- * PXA310 specific MFP configurations
- */
-#ifdef CONFIG_CPU_PXA310
-/* USB P2 */
-#define GPIO36_USB_P2_1		MFP_CFG(GPIO36, AF1)
-#define GPIO30_USB_P2_2		MFP_CFG(GPIO30, AF1)
-#define GPIO35_USB_P2_3		MFP_CFG(GPIO35, AF1)
-#define GPIO32_USB_P2_4		MFP_CFG(GPIO32, AF1)
-#define GPIO34_USB_P2_5		MFP_CFG(GPIO34, AF1)
-#define GPIO31_USB_P2_6		MFP_CFG(GPIO31, AF1)
-
-/* MMC1 */
-#define GPIO24_MMC1_CMD		MFP_CFG(GPIO24, AF3)
-#define GPIO29_MMC1_DAT0	MFP_CFG(GPIO29, AF3)
-
-/* MMC3 */
-#define GPIO103_MMC3_CLK	MFP_CFG(GPIO103, AF2)
-#define GPIO105_MMC3_CMD	MFP_CFG(GPIO105, AF2)
-#define GPIO11_2_MMC3_CLK	MFP_CFG(GPIO11_2, AF1)
-#define GPIO12_2_MMC3_CMD	MFP_CFG(GPIO12_2, AF1)
-#define GPIO7_2_MMC3_DAT0	MFP_CFG(GPIO7_2, AF1)
-#define GPIO8_2_MMC3_DAT1	MFP_CFG(GPIO8_2, AF1)
-#define GPIO9_2_MMC3_DAT2	MFP_CFG(GPIO9_2, AF1)
-#define GPIO10_2_MMC3_DAT3	MFP_CFG(GPIO10_2, AF1)
-
-/* ULPI */
-#define GPIO38_ULPI_CLK		MFP_CFG(GPIO38, AF1)
-#define GPIO30_ULPI_DATA_OUT_0	MFP_CFG(GPIO30, AF3)
-#define GPIO31_ULPI_DATA_OUT_1	MFP_CFG(GPIO31, AF3)
-#define GPIO32_ULPI_DATA_OUT_2	MFP_CFG(GPIO32, AF3)
-#define GPIO33_ULPI_DATA_OUT_3	MFP_CFG(GPIO33, AF3)
-#define GPIO34_ULPI_DATA_OUT_4	MFP_CFG(GPIO34, AF3)
-#define GPIO35_ULPI_DATA_OUT_5	MFP_CFG(GPIO35, AF3)
-#define GPIO36_ULPI_DATA_OUT_6	MFP_CFG(GPIO36, AF3)
-#define GPIO37_ULPI_DATA_OUT_7	MFP_CFG(GPIO37, AF3)
-#define GPIO33_ULPI_OTG_INTR	MFP_CFG(GPIO33, AF1)
-
-#define ULPI_DIR	MFP_CFG_DRV(ULPI_DIR, AF0, DS01X)
-#define ULPI_NXT	MFP_CFG_DRV(ULPI_NXT, AF0, DS01X)
-#define ULPI_STP	MFP_CFG_DRV(ULPI_STP, AF0, DS01X)
-#endif /* CONFIG_CPU_PXA310 */
-
 #endif /* __ASM_ARCH_MFP_PXA300_H */
diff --git a/arch/arm/mach-pxa/mfp-pxa930.h b/arch/arm/mach-pxa/mfp-pxa930.h
deleted file mode 100644
index 0d195d3a8c61..000000000000
diff --git a/arch/arm/mach-pxa/pxa300.c b/arch/arm/mach-pxa/pxa300.c
index f77ec118d5b9..accd270ff8e2 100644
--- a/arch/arm/mach-pxa/pxa300.c
+++ b/arch/arm/mach-pxa/pxa300.c
@@ -69,28 +69,13 @@ static struct mfp_addr_map pxa300_mfp_addr_map[] __initdata = {
 	MFP_ADDR_END,
 };
 
-/* override pxa300 MFP register addresses */
-static struct mfp_addr_map pxa310_mfp_addr_map[] __initdata = {
-	MFP_ADDR_X(GPIO30,  GPIO98,   0x0418),
-	MFP_ADDR_X(GPIO7_2, GPIO12_2, 0x052C),
-
-	MFP_ADDR(ULPI_STP, 0x040C),
-	MFP_ADDR(ULPI_NXT, 0x0410),
-	MFP_ADDR(ULPI_DIR, 0x0414),
-
-	MFP_ADDR_END,
-};
-
 static int __init pxa300_init(void)
 {
-	if (cpu_is_pxa300() || cpu_is_pxa310()) {
+	if (cpu_is_pxa300()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa300_mfp_addr_map);
 	}
 
-	if (cpu_is_pxa310())
-		mfp_init_addr(pxa310_mfp_addr_map);
-
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index b26f00fc75d5..7a02ddb30969 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -496,8 +496,6 @@ static int __init pxa3xx_init(void)
 		pxa3xx_init_pm();
 
 		enable_irq_wake(IRQ_WAKEUP0);
-		if (cpu_is_pxa320())
-			enable_irq_wake(IRQ_WAKEUP1);
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
@@ -509,7 +507,7 @@ static int __init pxa3xx_init(void)
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 		if (ret)
 			return ret;
-		if (cpu_is_pxa300() || cpu_is_pxa310() || cpu_is_pxa320()) {
+		if (cpu_is_pxa300()) {
 			platform_device_add_data(&pxa3xx_device_gpio,
 						 &pxa3xx_gpio_pdata,
 						 sizeof(pxa3xx_gpio_pdata));
diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 42958a542662..9b45dc297b22 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -269,19 +269,6 @@ static struct desc_clk_cken pxa300_310_clocks[] __initdata = {
 	PXA3XX_CKEN_1RATE("pxa3xx-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
 };
 
-static struct desc_clk_cken pxa320_clocks[] __initdata = {
-	PXA3XX_PBUS_CKEN("pxa3xx-nand", NULL, NAND, 1, 2, 1, 6, 0),
-	PXA3XX_PBUS_CKEN("pxa3xx-gcu", NULL, PXA320_GCU, 1, 1, 1, 1, 0),
-	PXA3XX_CKEN_1RATE("pxa3xx-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
-};
-
-static struct desc_clk_cken pxa93x_clocks[] __initdata = {
-
-	PXA3XX_PBUS_CKEN("pxa3xx-gcu", NULL, PXA300_GCU, 1, 1, 1, 1, 0),
-	PXA3XX_PBUS_CKEN("pxa3xx-nand", NULL, NAND, 1, 2, 1, 4, 0),
-	PXA3XX_CKEN_1RATE("pxa93x-gpio", NULL, GPIO, pxa3xx_13MHz_bus_parents),
-};
-
 static unsigned long clk_pxa3xx_system_bus_get_rate(struct clk_hw *hw,
 					    unsigned long parent_rate)
 {
@@ -446,13 +433,8 @@ int __init pxa3xx_clocks_init(void __iomem *regs, void __iomem *oscc_reg)
 	ret = clk_pxa_cken_init(pxa3xx_clocks, ARRAY_SIZE(pxa3xx_clocks), regs);
 	if (ret)
 		return ret;
-	if (cpu_is_pxa320())
-		return clk_pxa_cken_init(pxa320_clocks,
-					 ARRAY_SIZE(pxa320_clocks), regs);
-	if (cpu_is_pxa300() || cpu_is_pxa310())
-		return clk_pxa_cken_init(pxa300_310_clocks,
-					 ARRAY_SIZE(pxa300_310_clocks), regs);
-	return clk_pxa_cken_init(pxa93x_clocks, ARRAY_SIZE(pxa93x_clocks), regs);
+	return clk_pxa_cken_init(pxa300_310_clocks,
+				 ARRAY_SIZE(pxa300_310_clocks), regs);
 }
 
 static void __init pxa3xx_dt_clocks_init(struct device_node *np)
diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
index 4afa48d172db..23bc3c7a6288 100644
--- a/drivers/cpufreq/pxa3xx-cpufreq.c
+++ b/drivers/cpufreq/pxa3xx-cpufreq.c
@@ -91,15 +91,6 @@ static struct pxa3xx_freq_info pxa300_freqs[] = {
 	OP(624, 24, 2, 208, 260, 208, 312, 3, 1375, 1400), /* 624MHz */
 };
 
-static struct pxa3xx_freq_info pxa320_freqs[] = {
-	/*  CPU XL XN  HSS DMEM SMEM SRAM DFI VCC_CORE VCC_SRAM */
-	OP(104,  8, 1, 104, 260,  78, 104, 3, 1000, 1100), /* 104MHz */
-	OP(208, 16, 1, 104, 260, 104, 156, 2, 1000, 1100), /* 208MHz */
-	OP(416, 16, 2, 156, 260, 104, 208, 2, 1100, 1200), /* 416MHz */
-	OP(624, 24, 2, 208, 260, 208, 312, 3, 1375, 1400), /* 624MHz */
-	OP(806, 31, 2, 208, 260, 208, 312, 3, 1400, 1400), /* 806MHz */
-};
-
 static unsigned int pxa3xx_freqs_num;
 static struct pxa3xx_freq_info *pxa3xx_freqs;
 static struct cpufreq_frequency_table *pxa3xx_freqs_table;
@@ -186,17 +177,11 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 
 	/* set default policy and cpuinfo */
 	policy->min = policy->cpuinfo.min_freq = 104000;
-	policy->max = policy->cpuinfo.max_freq =
-		(cpu_is_pxa320()) ? 806000 : 624000;
+	policy->max = policy->cpuinfo.max_freq = 624000;
 	policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
 
-	if (cpu_is_pxa300() || cpu_is_pxa310())
-		ret = setup_freqs_table(policy, pxa300_freqs,
-					ARRAY_SIZE(pxa300_freqs));
-
-	if (cpu_is_pxa320())
-		ret = setup_freqs_table(policy, pxa320_freqs,
-					ARRAY_SIZE(pxa320_freqs));
+	ret = setup_freqs_table(policy, pxa300_freqs,
+				ARRAY_SIZE(pxa300_freqs));
 
 	if (ret) {
 		pr_err("failed to setup frequency table\n");
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2a988f942b6c..60bdd691c391 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -44,8 +44,7 @@
 #define NR_SG	1
 #define CLKRT_OFF	(~0)
 
-#define mmc_has_26MHz()		(cpu_is_pxa300() || cpu_is_pxa310() \
-				|| cpu_is_pxa935())
+#define mmc_has_26MHz()		(cpu_is_pxa300())
 
 struct pxamci_host {
 	struct mmc_host		*mmc;
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 5254028354f4..a6c6ee034582 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -268,12 +268,6 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 		goto err0;
 	}
 
-	if (cpu_is_pxa320() && ops->nr > 1) {
-		dev_err(&dev->dev, "pxa320 supports only one pcmcia slot");
-		ret = -EINVAL;
-		goto err0;
-	}
-
 	clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(clk))
 		return -ENODEV;
diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
index 5782450ee45c..0f894d12fe1d 100644
--- a/include/linux/soc/pxa/cpu.h
+++ b/include/linux/soc/pxa/cpu.h
@@ -56,12 +56,6 @@
  *  PXA935	B1	0x56056938	0x8E653013
  */
 #ifdef CONFIG_PXA25x
-#define __cpu_is_pxa210(id)				\
-	({						\
-		unsigned int _id = (id) & 0xf3f0;	\
-		_id == 0x2120;				\
-	})
-
 #define __cpu_is_pxa250(id)				\
 	({						\
 		unsigned int _id = (id) & 0xf3ff;	\
@@ -80,7 +74,6 @@
 		_id == 0x2100;				\
 	})
 #else
-#define __cpu_is_pxa210(id)	(0)
 #define __cpu_is_pxa250(id)	(0)
 #define __cpu_is_pxa255(id)	(0)
 #define __cpu_is_pxa25x(id)	(0)
@@ -106,51 +99,6 @@
 #define __cpu_is_pxa300(id)	(0)
 #endif
 
-#ifdef CONFIG_CPU_PXA310
-#define __cpu_is_pxa310(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x689;				\
-	 })
-#else
-#define __cpu_is_pxa310(id)	(0)
-#endif
-
-#ifdef CONFIG_CPU_PXA320
-#define __cpu_is_pxa320(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x603 || _id == 0x682;		\
-	 })
-#else
-#define __cpu_is_pxa320(id)	(0)
-#endif
-
-#ifdef CONFIG_CPU_PXA930
-#define __cpu_is_pxa930(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x683;				\
-	 })
-#else
-#define __cpu_is_pxa930(id)	(0)
-#endif
-
-#ifdef CONFIG_CPU_PXA935
-#define __cpu_is_pxa935(id)				\
-	({						\
-		unsigned int _id = (id) >> 4 & 0xfff;	\
-		_id == 0x693;				\
-	 })
-#else
-#define __cpu_is_pxa935(id)	(0)
-#endif
-
-#define cpu_is_pxa210()					\
-	({						\
-		__cpu_is_pxa210(read_cpuid_id());	\
-	})
-
 #define cpu_is_pxa250()					\
 	({						\
 		__cpu_is_pxa250(read_cpuid_id());	\
@@ -176,27 +124,6 @@
 		__cpu_is_pxa300(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa310()					\
-	({						\
-		__cpu_is_pxa310(read_cpuid_id());	\
-	 })
-
-#define cpu_is_pxa320()					\
-	({						\
-		__cpu_is_pxa320(read_cpuid_id());	\
-	 })
-
-#define cpu_is_pxa930()					\
-	({						\
-		__cpu_is_pxa930(read_cpuid_id());	\
-	 })
-
-#define cpu_is_pxa935()					\
-	({						\
-		__cpu_is_pxa935(read_cpuid_id());	\
-	 })
-
-
 
 /*
  * CPUID Core Generation Bit
@@ -215,25 +142,12 @@
 #ifdef CONFIG_PXA3xx
 #define __cpu_is_pxa3xx(id)				\
 	({						\
-		__cpu_is_pxa300(id)			\
-			|| __cpu_is_pxa310(id)		\
-			|| __cpu_is_pxa320(id)		\
-			|| __cpu_is_pxa93x(id);		\
+		__cpu_is_pxa300(id);			\
 	 })
 #else
 #define __cpu_is_pxa3xx(id)	(0)
 #endif
 
-#if defined(CONFIG_CPU_PXA930) || defined(CONFIG_CPU_PXA935)
-#define __cpu_is_pxa93x(id)				\
-	({						\
-		__cpu_is_pxa930(id)			\
-			|| __cpu_is_pxa935(id);		\
-	 })
-#else
-#define __cpu_is_pxa93x(id)	(0)
-#endif
-
 #define cpu_is_pxa2xx()					\
 	({						\
 		__cpu_is_pxa2xx(read_cpuid_id());	\
@@ -244,9 +158,4 @@
 		__cpu_is_pxa3xx(read_cpuid_id());	\
 	 })
 
-#define cpu_is_pxa93x()					\
-	({						\
-		__cpu_is_pxa93x(read_cpuid_id());	\
-	 })
-
 #endif
-- 
2.39.0

