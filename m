Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54A6F1790
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjD1MUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjD1MUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:20:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874616590
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:19:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682684356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0uASr97gD798bhQY88XCMztt6vkPz+6sIXjRtMqqAG4=;
        b=zApBQ3EWPxEnLo98Ra08iD3xszmrEE84bY7jiOvG4O1wZa+mLnGAV+Vx1QoVKd22Zjd/mJ
        GojKrnSYRZ7Mpoh2belC9HrsN+L2IOt3/hVOUd+F1G9G/eInV/mPFYfM8FioWCHGXY/7lD
        xqC000FzxpaYDlZjgl5HNHEvZbRptWVCXwpsw/lIz8Yk2JhNBmEaJjWVW2OqHDyKkmrvHf
        UUrflOfqFEiY/3pTwHsIyot/1nE6skaNjX3EoToarKdO8bCjG/1BAcrB6m+TyJKOM43JN9
        86H6HTDozhExdc7ytvJg/ipZXXTS3AhXALRlLKuH8mz6LSFG1rJQczIF/RXMEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682684356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0uASr97gD798bhQY88XCMztt6vkPz+6sIXjRtMqqAG4=;
        b=7Y09+QghIkDpMO1j/xTYNKF54tD9CHJTa83uhvqxJUoXm50WgA690yk1tB5vniv6+Fsk3z
        MUcI6ZEksHA1rnAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 6.4-rc1
Message-ID: <168268425233.1877133.18332460532605313393.tglx@xen13.lab.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Fri, 28 Apr 2023 14:19:15 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-04-28

up to:  158009f1b4a3: timekeeping: Fix references to nonexistent ktime_get_fa=
st_ns()


Timekeeping and clocksource/event driver updates the second batch:

  - A trivial documentation fix in the timekeeping core

  - A really boring set of small fixes, enhancements and cleanups in the
    drivers code. No new clocksource/clockevent drivers for a change.

Thanks,

	tglx

------------------>
AngeloGioacchino Del Regno (1):
      clocksource/drivers/timer-mediatek: Split out CPUXGPT timers

Cristian Ciocaltea (2):
      dt-bindings: timer: rockchip: Drop superfluous rk3288 compatible
      dt-bindings: timer: rockchip: Add rk3588 compatible

Fabio Estevam (1):
      clocksource/drivers/timer-imx-gpt: Remove non-DT function

Geert Uytterhoeven (1):
      timekeeping: Fix references to nonexistent ktime_get_fast_ns()

Krzysztof Kozlowski (2):
      clocksource/drivers/exynos_mct: Explicitly return 0 for shared timer
      clocksource/drivers/stm32-lp: Drop of_match_ptr for ID table

Qinrun Dai (1):
      clocksource/drivers/davinci: Fix memory leak in davinci_timer_register =
when init fails

Rob Herring (2):
      clocksource/drivers/timer-ti-dm: Use of_address_to_resource()
      clocksource/drivers/ti: Use of_property_read_bool() for boolean propert=
ies

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix finding alwon timer

Uwe Kleine-K=C3=B6nig (5):
      clocksource/drivers/sh_mtu2: Mark driver as non-removable
      clocksource/drivers/timer-stm32-lp: Mark driver as non-removable
      clocksource/drivers/timer-ti-dm: Improve error message in .remove
      clocksource/drivers/timer-tegra186: Convert to platform remove callback=
 returning void
      clocksource/drivers/timer-ti-dm: Convert to platform remove callback re=
turning void


 .../bindings/timer/rockchip,rk-timer.yaml          |   2 +-
 drivers/clocksource/Kconfig                        |   9 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/exynos_mct.c                   |   2 +-
 drivers/clocksource/sh_mtu2.c                      |   7 +-
 drivers/clocksource/timer-davinci.c                |  30 ++++-
 drivers/clocksource/timer-imx-gpt.c                |  19 ---
 drivers/clocksource/timer-mediatek-cpux.c          | 140 +++++++++++++++++++=
++
 drivers/clocksource/timer-mediatek.c               | 114 -----------------
 drivers/clocksource/timer-stm32-lp.c               |  11 +-
 drivers/clocksource/timer-tegra186.c               |   6 +-
 drivers/clocksource/timer-ti-dm-systimer.c         |  63 +++++-----
 drivers/clocksource/timer-ti-dm.c                  |  15 +--
 include/soc/imx/timer.h                            |   7 --
 kernel/time/timekeeping.c                          |   4 +-
 15 files changed, 223 insertions(+), 207 deletions(-)
 create mode 100644 drivers/clocksource/timer-mediatek-cpux.c

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml b=
/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
index 65e59836a660..19e56b7577a0 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml
@@ -23,8 +23,8 @@ properties:
               - rockchip,rk3188-timer
               - rockchip,rk3228-timer
               - rockchip,rk3229-timer
-              - rockchip,rk3288-timer
               - rockchip,rk3368-timer
+              - rockchip,rk3588-timer
               - rockchip,px30-timer
           - const: rockchip,rk3288-timer
   reg:
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5fc8f0e7fb38..526382dc7482 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -479,6 +479,15 @@ config MTK_TIMER
 	help
 	  Support for Mediatek timer driver.
=20
+config MTK_CPUX_TIMER
+	bool "MediaTek CPUX timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	default ARCH_MEDIATEK
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  Support for MediaTek CPUXGPT timer driver.
+
 config SPRD_TIMER
 	bool "Spreadtrum timer driver" if EXPERT
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 64ab547de97b..f12d3987a960 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_FSL_FTM_TIMER)	+=3D timer-fsl-ftm.o
 obj-$(CONFIG_VF_PIT_TIMER)	+=3D timer-vf-pit.o
 obj-$(CONFIG_CLKSRC_QCOM)	+=3D timer-qcom.o
 obj-$(CONFIG_MTK_TIMER)		+=3D timer-mediatek.o
+obj-$(CONFIG_MTK_CPUX_TIMER)	+=3D timer-mediatek-cpux.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+=3D timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+=3D timer-ti-32k.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+=3D timer-oxnas-rps.o
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index bfd60093ee1c..ef8cb1b71be4 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -682,7 +682,7 @@ static int __init mct_init_dt(struct device_node *np, uns=
igned int int_type)
 	 * processor cannot use the global comparator.
 	 */
 	if (frc_shared)
-		return ret;
+		return 0;
=20
 	return exynos4_clockevent_init();
 }
diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 169a1fccc497..6bd2d0299397 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -484,11 +484,6 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int sh_mtu2_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct platform_device_id sh_mtu2_id_table[] =3D {
 	{ "sh-mtu2", 0 },
 	{ },
@@ -503,10 +498,10 @@ MODULE_DEVICE_TABLE(of, sh_mtu2_of_table);
=20
 static struct platform_driver sh_mtu2_device_driver =3D {
 	.probe		=3D sh_mtu2_probe,
-	.remove		=3D sh_mtu2_remove,
 	.driver		=3D {
 		.name	=3D "sh_mtu2",
 		.of_match_table =3D of_match_ptr(sh_mtu2_of_table),
+		.suppress_bind_attrs =3D true,
 	},
 	.id_table	=3D sh_mtu2_id_table,
 };
diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-=
davinci.c
index 9996c0542520..b1c248498be4 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -257,21 +257,25 @@ int __init davinci_timer_register(struct clk *clk,
 				resource_size(&timer_cfg->reg),
 				"davinci-timer")) {
 		pr_err("Unable to request memory region\n");
-		return -EBUSY;
+		rv =3D -EBUSY;
+		goto exit_clk_disable;
 	}
=20
 	base =3D ioremap(timer_cfg->reg.start, resource_size(&timer_cfg->reg));
 	if (!base) {
 		pr_err("Unable to map the register range\n");
-		return -ENOMEM;
+		rv =3D -ENOMEM;
+		goto exit_mem_region;
 	}
=20
 	davinci_timer_init(base);
 	tick_rate =3D clk_get_rate(clk);
=20
 	clockevent =3D kzalloc(sizeof(*clockevent), GFP_KERNEL);
-	if (!clockevent)
-		return -ENOMEM;
+	if (!clockevent) {
+		rv =3D -ENOMEM;
+		goto exit_iounmap_base;
+	}
=20
 	clockevent->dev.name =3D "tim12";
 	clockevent->dev.features =3D CLOCK_EVT_FEAT_ONESHOT;
@@ -296,7 +300,7 @@ int __init davinci_timer_register(struct clk *clk,
 			 "clockevent/tim12", clockevent);
 	if (rv) {
 		pr_err("Unable to request the clockevent interrupt\n");
-		return rv;
+		goto exit_free_clockevent;
 	}
=20
 	davinci_clocksource.dev.rating =3D 300;
@@ -323,13 +327,27 @@ int __init davinci_timer_register(struct clk *clk,
 	rv =3D clocksource_register_hz(&davinci_clocksource.dev, tick_rate);
 	if (rv) {
 		pr_err("Unable to register clocksource\n");
-		return rv;
+		goto exit_free_irq;
 	}
=20
 	sched_clock_register(davinci_timer_read_sched_clock,
 			     DAVINCI_TIMER_CLKSRC_BITS, tick_rate);
=20
 	return 0;
+
+exit_free_irq:
+	free_irq(timer_cfg->irq[DAVINCI_TIMER_CLOCKEVENT_IRQ].start,
+			clockevent);
+exit_free_clockevent:
+	kfree(clockevent);
+exit_iounmap_base:
+	iounmap(base);
+exit_mem_region:
+	release_mem_region(timer_cfg->reg.start,
+			   resource_size(&timer_cfg->reg));
+exit_clk_disable:
+	clk_disable_unprepare(clk);
+	return rv;
 }
=20
 static int __init of_davinci_timer_register(struct device_node *np)
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index 7b2c70f2f353..ca3e4cbc80c6 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -420,25 +420,6 @@ static int __init _mxc_timer_init(struct imx_timer *imxt=
m)
 	return mxc_clockevent_init(imxtm);
 }
=20
-void __init mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type t=
ype)
-{
-	struct imx_timer *imxtm;
-
-	imxtm =3D kzalloc(sizeof(*imxtm), GFP_KERNEL);
-	BUG_ON(!imxtm);
-
-	imxtm->clk_per =3D clk_get_sys("imx-gpt.0", "per");
-	imxtm->clk_ipg =3D clk_get_sys("imx-gpt.0", "ipg");
-
-	imxtm->base =3D ioremap(pbase, SZ_4K);
-	BUG_ON(!imxtm->base);
-
-	imxtm->type =3D type;
-	imxtm->irq =3D irq;
-
-	_mxc_timer_init(imxtm);
-}
-
 static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_ty=
pe type)
 {
 	struct imx_timer *imxtm;
diff --git a/drivers/clocksource/timer-mediatek-cpux.c b/drivers/clocksource/=
timer-mediatek-cpux.c
new file mode 100644
index 000000000000..a8e3df4c09fd
--- /dev/null
+++ b/drivers/clocksource/timer-mediatek-cpux.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * MediaTek SoCs CPUX General Purpose Timer handling
+ *
+ * Based on timer-mediatek.c:
+ * Copyright (C) 2014 Matthias Brugger <matthias.bgg@gmail.com>
+ *
+ * Copyright (C) 2022 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include "timer-of.h"
+
+#define TIMER_SYNC_TICKS        3
+
+/* cpux mcusys wrapper */
+#define CPUX_CON_REG		0x0
+#define CPUX_IDX_REG		0x4
+
+/* cpux */
+#define CPUX_IDX_GLOBAL_CTRL	0x0
+ #define CPUX_ENABLE		BIT(0)
+ #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
+ #define CPUX_CLK_DIV1		BIT(8)
+ #define CPUX_CLK_DIV2		BIT(9)
+ #define CPUX_CLK_DIV4		BIT(10)
+#define CPUX_IDX_GLOBAL_IRQ	0x30
+
+static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	return readl(timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	writel(val, timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
+{
+	const unsigned long *irq_mask =3D cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+
+	if (enable)
+		val |=3D *irq_mask;
+	else
+		val &=3D ~(*irq_mask);
+
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Clear any irq */
+	mtk_cpux_set_irq(to_timer_of(clkevt), false);
+
+	/*
+	 * Disabling CPUXGPT timer will crash the platform, especially
+	 * if Trusted Firmware is using it (usually, for sleep states),
+	 * so we only mask the IRQ and call it a day.
+	 */
+	return 0;
+}
+
+static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
+{
+	mtk_cpux_set_irq(to_timer_of(clkevt), true);
+	return 0;
+}
+
+static struct timer_of to =3D {
+	/*
+	 * There are per-cpu interrupts for the CPUX General Purpose Timer
+	 * but since this timer feeds the AArch64 System Timer we can rely
+	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
+	 */
+	.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt =3D {
+		.name =3D "mtk-cpuxgpt",
+		.cpumask =3D cpu_possible_mask,
+		.rating =3D 10,
+		.set_state_shutdown =3D mtk_cpux_clkevt_shutdown,
+		.tick_resume =3D mtk_cpux_clkevt_resume,
+	},
+};
+
+static int __init mtk_cpux_init(struct device_node *node)
+{
+	u32 freq, val;
+	int ret;
+
+	/* If this fails, bad things are about to happen... */
+	ret =3D timer_of_init(node, &to);
+	if (ret) {
+		WARN(1, "Cannot start CPUX timers.\n");
+		return ret;
+	}
+
+	/*
+	 * Check if we're given a clock with the right frequency for this
+	 * timer, otherwise warn but keep going with the setup anyway, as
+	 * that makes it possible to still boot the kernel, even though
+	 * it may not work correctly (random lockups, etc).
+	 * The reason behind this is that having an early UART may not be
+	 * possible for everyone and this gives a chance to retrieve kmsg
+	 * for eventual debugging even on consumer devices.
+	 */
+	freq =3D timer_of_rate(&to);
+	if (freq > 13000000)
+		WARN(1, "Requested unsupported timer frequency %u\n", freq);
+
+	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to);
+	val &=3D ~CPUX_CLK_DIV_MASK;
+	val |=3D CPUX_CLK_DIV2;
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to);
+
+	/* Enable all CPUXGPT timers */
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to);
+	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	return 0;
+}
+TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer=
-mediatek.c
index d5b29fd03ca2..7bcb4a3f26fb 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -22,19 +22,6 @@
=20
 #define TIMER_SYNC_TICKS        (3)
=20
-/* cpux mcusys wrapper */
-#define CPUX_CON_REG		0x0
-#define CPUX_IDX_REG		0x4
-
-/* cpux */
-#define CPUX_IDX_GLOBAL_CTRL	0x0
- #define CPUX_ENABLE		BIT(0)
- #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
- #define CPUX_CLK_DIV1		BIT(8)
- #define CPUX_CLK_DIV2		BIT(9)
- #define CPUX_CLK_DIV4		BIT(10)
-#define CPUX_IDX_GLOBAL_IRQ	0x30
-
 /* gpt */
 #define GPT_IRQ_EN_REG          0x00
 #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
@@ -85,52 +72,6 @@
=20
 static void __iomem *gpt_sched_reg __read_mostly;
=20
-static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
-{
-	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
-	return readl(timer_of_base(to) + CPUX_CON_REG);
-}
-
-static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
-{
-	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
-	writel(val, timer_of_base(to) + CPUX_CON_REG);
-}
-
-static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
-{
-	const unsigned long *irq_mask =3D cpumask_bits(cpu_possible_mask);
-	u32 val;
-
-	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
-
-	if (enable)
-		val |=3D *irq_mask;
-	else
-		val &=3D ~(*irq_mask);
-
-	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
-}
-
-static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
-{
-	/* Clear any irq */
-	mtk_cpux_set_irq(to_timer_of(clkevt), false);
-
-	/*
-	 * Disabling CPUXGPT timer will crash the platform, especially
-	 * if Trusted Firmware is using it (usually, for sleep states),
-	 * so we only mask the IRQ and call it a day.
-	 */
-	return 0;
-}
-
-static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
-{
-	mtk_cpux_set_irq(to_timer_of(clkevt), true);
-	return 0;
-}
-
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
@@ -340,60 +281,6 @@ static struct timer_of to =3D {
 	},
 };
=20
-static int __init mtk_cpux_init(struct device_node *node)
-{
-	static struct timer_of to_cpux;
-	u32 freq, val;
-	int ret;
-
-	/*
-	 * There are per-cpu interrupts for the CPUX General Purpose Timer
-	 * but since this timer feeds the AArch64 System Timer we can rely
-	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
-	 */
-	to_cpux.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK;
-	to_cpux.clkevt.name =3D "mtk-cpuxgpt";
-	to_cpux.clkevt.rating =3D 10;
-	to_cpux.clkevt.cpumask =3D cpu_possible_mask;
-	to_cpux.clkevt.set_state_shutdown =3D mtk_cpux_clkevt_shutdown;
-	to_cpux.clkevt.tick_resume =3D mtk_cpux_clkevt_resume;
-
-	/* If this fails, bad things are about to happen... */
-	ret =3D timer_of_init(node, &to_cpux);
-	if (ret) {
-		WARN(1, "Cannot start CPUX timers.\n");
-		return ret;
-	}
-
-	/*
-	 * Check if we're given a clock with the right frequency for this
-	 * timer, otherwise warn but keep going with the setup anyway, as
-	 * that makes it possible to still boot the kernel, even though
-	 * it may not work correctly (random lockups, etc).
-	 * The reason behind this is that having an early UART may not be
-	 * possible for everyone and this gives a chance to retrieve kmsg
-	 * for eventual debugging even on consumer devices.
-	 */
-	freq =3D timer_of_rate(&to_cpux);
-	if (freq > 13000000)
-		WARN(1, "Requested unsupported timer frequency %u\n", freq);
-
-	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
-	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-	val &=3D ~CPUX_CLK_DIV_MASK;
-	val |=3D CPUX_CLK_DIV2;
-	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-
-	/* Enable all CPUXGPT timers */
-	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
-
-	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
-					TIMER_SYNC_TICKS, 0xffffffff);
-
-	return 0;
-}
-
 static int __init mtk_syst_init(struct device_node *node)
 {
 	int ret;
@@ -452,4 +339,3 @@ static int __init mtk_gpt_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
-TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index db2841d0beb8..d14a17549fe8 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -195,11 +195,6 @@ static int stm32_clkevent_lp_probe(struct platform_devic=
e *pdev)
 	return ret;
 }
=20
-static int stm32_clkevent_lp_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct of_device_id stm32_clkevent_lp_of_match[] =3D {
 	{ .compatible =3D "st,stm32-lptimer-timer", },
 	{},
@@ -207,11 +202,11 @@ static const struct of_device_id stm32_clkevent_lp_of_m=
atch[] =3D {
 MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
=20
 static struct platform_driver stm32_clkevent_lp_driver =3D {
-	.probe	=3D stm32_clkevent_lp_probe,
-	.remove =3D stm32_clkevent_lp_remove,
+	.probe  =3D stm32_clkevent_lp_probe,
 	.driver	=3D {
 		.name =3D "stm32-lptimer-timer",
-		.of_match_table =3D of_match_ptr(stm32_clkevent_lp_of_match),
+		.of_match_table =3D stm32_clkevent_lp_of_match,
+		.suppress_bind_attrs =3D true,
 	},
 };
 module_platform_driver(stm32_clkevent_lp_driver);
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index ea742889ee06..ccc762d32422 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -447,15 +447,13 @@ static int tegra186_timer_probe(struct platform_device =
*pdev)
 	return err;
 }
=20
-static int tegra186_timer_remove(struct platform_device *pdev)
+static void tegra186_timer_remove(struct platform_device *pdev)
 {
 	struct tegra186_timer *tegra =3D platform_get_drvdata(pdev);
=20
 	clocksource_unregister(&tegra->usec);
 	clocksource_unregister(&tegra->osc);
 	clocksource_unregister(&tegra->tsc);
-
-	return 0;
 }
=20
 static int __maybe_unused tegra186_timer_suspend(struct device *dev)
@@ -505,7 +503,7 @@ static struct platform_driver tegra186_wdt_driver =3D {
 		.of_match_table =3D tegra186_timer_of_match,
 	},
 	.probe =3D tegra186_timer_probe,
-	.remove =3D tegra186_timer_remove,
+	.remove_new =3D tegra186_timer_remove,
 };
 module_platform_driver(tegra186_wdt_driver);
=20
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource=
/timer-ti-dm-systimer.c
index 632523c1232f..c2dcd8d68e45 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -251,24 +251,24 @@ static void __init dmtimer_systimer_assign_alwon(void)
 		counter_32k =3D -ENODEV;
=20
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
=20
-		if (of_property_read_bool(np, "ti,timer-alwon")) {
-			const __be32 *addr;
-
-			addr =3D of_get_address(np, 0, NULL, NULL);
-			pa =3D of_translate_address(np, addr);
-			if (pa) {
-				/* Quirky omap3 boards must use dmtimer12 */
-				if (quirk_unreliable_oscillator &&
-				    pa =3D=3D 0x48318000)
-					continue;
-
-				of_node_put(np);
-				break;
-			}
-		}
+		if (!of_property_read_bool(np, "ti,timer-alwon"))
+			continue;
+
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		pa =3D res.start;
+
+		/* Quirky omap3 boards must use dmtimer12 */
+		if (quirk_unreliable_oscillator && pa =3D=3D 0x48318000)
+			continue;
+
+		of_node_put(np);
+		break;
 	}
=20
 	/* Usually no need for dmtimer clocksource if we have counter32 */
@@ -285,24 +285,22 @@ static void __init dmtimer_systimer_assign_alwon(void)
 static u32 __init dmtimer_systimer_find_first_available(void)
 {
 	struct device_node *np;
-	const __be32 *addr;
 	u32 pa =3D 0;
=20
 	for_each_matching_node(np, dmtimer_match_table) {
+		struct resource res;
 		if (!dmtimer_is_preferred(np))
 			continue;
=20
-		addr =3D of_get_address(np, 0, NULL, NULL);
-		pa =3D of_translate_address(np, addr);
-		if (pa) {
-			if (pa =3D=3D clocksource || pa =3D=3D clockevent) {
-				pa =3D 0;
-				continue;
-			}
-
-			of_node_put(np);
-			break;
-		}
+		if (of_address_to_resource(np, 0, &res))
+			continue;
+
+		if (res.start =3D=3D clocksource || res.start =3D=3D clockevent)
+			continue;
+
+		pa =3D res.start;
+		of_node_put(np);
+		break;
 	}
=20
 	return pa;
@@ -586,7 +584,7 @@ static int __init dmtimer_clkevt_init_common(struct dmtim=
er_clockevent *clkevt,
 	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, t->base + t->wakeup);
=20
 	pr_info("TI gptimer %s: %s%lu Hz at %pOF\n",
-		name, of_find_property(np, "ti,timer-alwon", NULL) ?
+		name, of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", t->rate, np->parent);
=20
 	return 0;
@@ -787,7 +785,7 @@ static int __init dmtimer_clocksource_init(struct device_=
node *np)
 		       t->base + t->ctrl);
=20
 	pr_info("TI gptimer clocksource: %s%pOF\n",
-		of_find_property(np, "ti,timer-alwon", NULL) ?
+		of_property_read_bool(np, "ti,timer-alwon") ?
 		"always-on " : "", np->parent);
=20
 	if (!dmtimer_sched_clock_counter) {
@@ -812,7 +810,7 @@ static int __init dmtimer_clocksource_init(struct device_=
node *np)
  */
 static int __init dmtimer_systimer_init(struct device_node *np)
 {
-	const __be32 *addr;
+	struct resource res;
 	u32 pa;
=20
 	/* One time init for the preferred timer configuration */
@@ -826,8 +824,9 @@ static int __init dmtimer_systimer_init(struct device_nod=
e *np)
 		return -EINVAL;
 	}
=20
-	addr =3D of_get_address(np, 0, NULL, NULL);
-	pa =3D of_translate_address(np, addr);
+
+	of_address_to_resource(np, 0, &res);
+	pa =3D (u32)res.start;
 	if (!pa)
 		return -EINVAL;
=20
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index b24b903a8822..1d3ad51e4634 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,13 +1104,13 @@ static int omap_dm_timer_probe(struct platform_device=
 *pdev)
 	platform_set_drvdata(pdev, timer);
=20
 	if (dev->of_node) {
-		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-alwon"))
 			timer->capability |=3D OMAP_TIMER_ALWON;
-		if (of_find_property(dev->of_node, "ti,timer-dsp", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-dsp"))
 			timer->capability |=3D OMAP_TIMER_HAS_DSP_IRQ;
-		if (of_find_property(dev->of_node, "ti,timer-pwm", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
 			timer->capability |=3D OMAP_TIMER_HAS_PWM;
-		if (of_find_property(dev->of_node, "ti,timer-secure", NULL))
+		if (of_property_read_bool(dev->of_node, "ti,timer-secure"))
 			timer->capability |=3D OMAP_TIMER_SECURE;
 	} else {
 		timer->id =3D pdev->id;
@@ -1177,7 +1177,7 @@ static int omap_dm_timer_probe(struct platform_device *=
pdev)
  * In addition to freeing platform resources it also deletes the timer
  * entry from the local list.
  */
-static int omap_dm_timer_remove(struct platform_device *pdev)
+static void omap_dm_timer_remove(struct platform_device *pdev)
 {
 	struct dmtimer *timer;
 	unsigned long flags;
@@ -1197,7 +1197,8 @@ static int omap_dm_timer_remove(struct platform_device =
*pdev)
=20
 	pm_runtime_disable(&pdev->dev);
=20
-	return ret;
+	if (ret)
+		dev_err(&pdev->dev, "Unable to determine timer entry in list of drivers on=
 remove\n");
 }
=20
 static const struct omap_dm_timer_ops dmtimer_ops =3D {
@@ -1272,7 +1273,7 @@ MODULE_DEVICE_TABLE(of, omap_timer_match);
=20
 static struct platform_driver omap_dm_timer_driver =3D {
 	.probe  =3D omap_dm_timer_probe,
-	.remove =3D omap_dm_timer_remove,
+	.remove_new =3D omap_dm_timer_remove,
 	.driver =3D {
 		.name   =3D "omap_timer",
 		.of_match_table =3D omap_timer_match,
diff --git a/include/soc/imx/timer.h b/include/soc/imx/timer.h
index b888d5076b4d..25f29c6bbd0b 100644
--- a/include/soc/imx/timer.h
+++ b/include/soc/imx/timer.h
@@ -13,11 +13,4 @@ enum imx_gpt_type {
 	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
 };
=20
-/*
- * This is a stop-gap solution for clock drivers like imx1/imx21 which call
- * mxc_timer_init() to initialize timer for non-DT boot.  It can be removed
- * when these legacy non-DT support is converted or dropped.
- */
-void mxc_timer_init(unsigned long pbase, int irq, enum imx_gpt_type type);
-
 #endif  /* __SOC_IMX_TIMER_H__ */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5579ead449f2..09d594900ee0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -526,7 +526,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  *
- * The caveats vs. timestamp ordering as documented for ktime_get_fast_ns()
+ * The caveats vs. timestamp ordering as documented for ktime_get_mono_fast_=
ns()
  * apply as well.
  */
 u64 notrace ktime_get_boot_fast_ns(void)
@@ -576,7 +576,7 @@ static __always_inline u64 __ktime_get_real_fast(struct t=
k_fast *tkf, u64 *mono)
 /**
  * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
  *
- * See ktime_get_fast_ns() for documentation of the time stamp ordering.
+ * See ktime_get_mono_fast_ns() for documentation of the time stamp ordering.
  */
 u64 ktime_get_real_fast_ns(void)
 {

