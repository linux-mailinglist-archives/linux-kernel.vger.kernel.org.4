Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A95F5453
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJEMVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJEMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:21:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06C51A20
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:21:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664972483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jnpI5aqm9x+MwM/mZ3qElm8hLJZaatUJv4pipquRg7o=;
        b=muMxmJznRWBsKg+3ZZHPqYSmCzIZSOrMThQx0Y61XpZRVwA0BGlcY8jx9a5eQQSdKT+0ME
        5ORK9trkgysOIAl6XV+c0kGs4rTwMWxc8kQT/8CDKDxpAgHSLyEapmFcrgneesR6aABvj0
        kD/vlTXaLSIXkB3rjPywbpzdn/mWAm93cr+7xhkMBZWuOn4C8q1mwWFAC7yIiDv6Hqvu+v
        YGqaqLTIR0E5OyZXJGQi99yhA/bbFYc2/A6sBv/jIOeUbO9mkcxf4GgMrHuqiNf0EGp4ST
        T8t04ZcRX+hdo1rOCHEhFSXcKkjzx0RXeWcsc6Xr6GluOP/kdQeaTVyiA1RhKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664972483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jnpI5aqm9x+MwM/mZ3qElm8hLJZaatUJv4pipquRg7o=;
        b=bjzwpuNo9+zscfPTc7lmk8BPN9EiR5O5dEJqti7/m6hwwe6JLJyEAMybv+NFQOPNtaCcN8
        eo/UW1THkXmLkLAA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.1-rc1
References: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de>
Message-ID: <166497241295.125841.14779016172298611700.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Wed,  5 Oct 2022 14:21:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-10-05

up to:  6cb5ce13357d: Merge tag 'timers-v6.1-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core


A boring time, timekeeping, timers update:

 - No core code changes

 - No new clocksource/event driver

 - Cleanup of the TI DM clocksource/event driver

 - The usual set of device tree binding updates

 - Small improvement, fixes and cleanups all over the place

Thanks,

	tglx

------------------>
Johnson Wang (1):
      dt-bindings: timer: Add compatible for MediaTek MT8188

Kunkun Jiang (1):
      clocksource/drivers/arm_arch_timer: Fix handling of ARM erratum 858921

Lad Prabhakar (1):
      clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC

Lin Yujun (1):
      clocksource/drivers/timer-gxp: Add missing error handling in gxp_timer_=
probe

Peng Fan (2):
      dt-bindings: timer: nxp,sysctr-timer: add nxp,no-divider property
      clocksource/drivers/imx-sysctr: handle nxp,no-divider property

Tony Lindgren (9):
      clocksource/drivers/timer-ti-dm: Drop unused functions
      clocksource/drivers/timer-ti-dm: Simplify register reads with dmtimer_r=
ead()
      clocksource/drivers/timer-ti-dm: Simplify register writes with dmtimer_=
write()
      clocksource/drivers/timer-ti-dm: Simplify register access further
      clocksource/drivers/timer-ti-dm: Move private defines to the driver
      clocksource/drivers/timer-ti-dm: Use runtime PM directly and check erro=
rs
      clocksource/drivers/timer-ti-dm: Move struct omap_dm_timer fields to dr=
iver
      clocksource/drivers/timer-ti-dm: Add flag to detect omap1
      clocksource/drivers/timer-ti-dm: Get clock in probe with devm_clk_get()

Victor Hassan (1):
      clocksource/drivers/sun4i: Add definition of clear interrupt

Vincent Whitchurch (4):
      dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support
      clocksource/drivers/exynos_mct: Support frc-shared property
      clocksource/drivers/exynos_mct: Support local-timers property
      clocksource/drivers/exynos_mct: Enable building on ARTPEC

Wolfram Sang (1):
      dt-bindings: timer: renesas,tmu: Add r8a779f0 support

Yang Guo (1):
      clocksource/drivers/arm_arch_timer: Fix CNTPCT_LO and CNTVCT_LO value


 .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
 .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +
 .../devicetree/bindings/timer/renesas,tmu.yaml     |   1 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |  26 +
 drivers/clocksource/Kconfig                        |   2 +-
 drivers/clocksource/arm_arch_timer.c               |   6 +-
 drivers/clocksource/exynos_mct.c                   |  83 ++-
 drivers/clocksource/renesas-ostm.c                 |   2 +-
 drivers/clocksource/timer-gxp.c                    |   7 +-
 drivers/clocksource/timer-imx-sysctr.c             |   6 +-
 drivers/clocksource/timer-sun4i.c                  |   3 +-
 drivers/clocksource/timer-ti-dm.c                  | 681 +++++++++++++------=
--
 include/clocksource/timer-ti-dm.h                  | 112 ----
 13 files changed, 553 insertions(+), 381 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b=
/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index f1c848af91d3..8bbb6e94508b 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -25,6 +25,7 @@ Required properties:
 	For those SoCs that use SYST
 	* "mediatek,mt8183-timer" for MT8183 compatible timers (SYST)
 	* "mediatek,mt8186-timer" for MT8186 compatible timers (SYST)
+	* "mediatek,mt8188-timer" for MT8188 compatible timers (SYST)
 	* "mediatek,mt8192-timer" for MT8192 compatible timers (SYST)
 	* "mediatek,mt8195-timer" for MT8195 compatible timers (SYST)
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/=
Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 830211c55b4a..2b9653dafab8 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -32,6 +32,10 @@ properties:
   clock-names:
     const: per
=20
+  nxp,no-divider:
+    description: if present, means there is no internal base clk divider.
+    type: boolean
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index c57169118b68..60f4c059bcff 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,tmu-r8a77990 # R-Car E3
           - renesas,tmu-r8a77995 # R-Car D3
           - renesas,tmu-r8a779a0 # R-Car V3U
+          - renesas,tmu-r8a779f0 # R-Car S4-8
       - const: renesas,tmu
=20
   reg:
diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.y=
aml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 9c81d00b12e0..829bd2227f7c 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -25,6 +25,7 @@ properties:
           - samsung,exynos4412-mct
       - items:
           - enum:
+              - axis,artpec8-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -45,6 +46,19 @@ properties:
   reg:
     maxItems: 1
=20
+  samsung,frc-shared:
+    type: boolean
+    description: |
+      Indicates that the hardware requires that this processor share the
+      free-running counter with a different (main) processor.
+
+  samsung,local-timers:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 16
+    description: |
+      List of indices of local timers usable from this processor.
+
   interrupts:
     description: |
       Interrupts should be put in specific order. This is, the local timer
@@ -74,6 +88,17 @@ required:
   - reg
=20
 allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - axis,artpec8-mct
+    then:
+      properties:
+        samsung,local-timers: false
+        samsung,frc-shared: false
   - if:
       properties:
         compatible:
@@ -101,6 +126,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - axis,artpec8-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 4f2bb7315b67..4469e7f555e9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -434,7 +434,7 @@ config ATMEL_TCB_CLKSRC
 config CLKSRC_EXYNOS_MCT
 	bool "Exynos multi core timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
-	depends on ARCH_EXYNOS || COMPILE_TEST
+	depends on ARCH_ARTPEC || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  Support for Multi Core Timer controller on Exynos SoCs.
=20
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 9ab8221ee3c6..a7ff77550e17 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -44,8 +44,8 @@
 #define CNTACR_RWVT	BIT(4)
 #define CNTACR_RWPT	BIT(5)
=20
-#define CNTVCT_LO	0x00
-#define CNTPCT_LO	0x08
+#define CNTPCT_LO	0x00
+#define CNTVCT_LO	0x08
 #define CNTFRQ		0x10
 #define CNTP_CVAL_LO	0x20
 #define CNTP_CTL	0x2c
@@ -473,6 +473,8 @@ static const struct arch_timer_erratum_workaround ool_wor=
karounds[] =3D {
 		.desc =3D "ARM erratum 858921",
 		.read_cntpct_el0 =3D arm64_858921_read_cntpct_el0,
 		.read_cntvct_el0 =3D arm64_858921_read_cntvct_el0,
+		.set_next_event_phys =3D erratum_set_next_event_phys,
+		.set_next_event_virt =3D erratum_set_next_event_virt,
 	},
 #endif
 #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index f29c812b70c9..bfd60093ee1c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -33,7 +33,7 @@
 #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
 #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
 #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
-#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
+#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
 #define EXYNOS4_MCT_L_MASK		(0xffffff00)
=20
 #define MCT_L_TCNTB_OFFSET		(0x00)
@@ -66,6 +66,8 @@
 #define MCT_L0_IRQ	4
 /* Max number of IRQ as per DT binding document */
 #define MCT_NR_IRQS	20
+/* Max number of local timers */
+#define MCT_NR_LOCAL	(MCT_NR_IRQS - MCT_L0_IRQ)
=20
 enum {
 	MCT_INT_SPI,
@@ -233,9 +235,16 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
=20
-static int __init exynos4_clocksource_init(void)
+static int __init exynos4_clocksource_init(bool frc_shared)
 {
-	exynos4_mct_frc_start();
+	/*
+	 * When the frc is shared, the main processer should have already
+	 * turned it on and we shouldn't be writing to TCON.
+	 */
+	if (frc_shared)
+		mct_frc.resume =3D NULL;
+	else
+		exynos4_mct_frc_start();
=20
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer =3D &exynos4_read_current_timer;
@@ -449,7 +458,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt =3D &mevt->evt;
=20
-	mevt->base =3D EXYNOS4_MCT_L_BASE(cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
=20
 	evt->name =3D mevt->name;
@@ -520,8 +528,17 @@ static int __init exynos4_timer_resources(struct device_=
node *np)
 	return 0;
 }
=20
+/**
+ * exynos4_timer_interrupts - initialize MCT interrupts
+ * @np: device node for MCT
+ * @int_type: interrupt type, MCT_INT_PPI or MCT_INT_SPI
+ * @local_idx: array mapping CPU numbers to local timer indices
+ * @nr_local: size of @local_idx array
+ */
 static int __init exynos4_timer_interrupts(struct device_node *np,
-					   unsigned int int_type)
+					   unsigned int int_type,
+					   const u32 *local_idx,
+					   size_t nr_local)
 {
 	int nr_irqs, i, err, cpu;
=20
@@ -554,13 +571,21 @@ static int __init exynos4_timer_interrupts(struct devic=
e_node *np,
 	} else {
 		for_each_possible_cpu(cpu) {
 			int mct_irq;
+			unsigned int irq_idx;
 			struct mct_clock_event_device *pcpu_mevt =3D
 				per_cpu_ptr(&percpu_mct_tick, cpu);
=20
+			if (cpu >=3D nr_local) {
+				err =3D -EINVAL;
+				goto out_irq;
+			}
+
+			irq_idx =3D MCT_L0_IRQ + local_idx[cpu];
+
 			pcpu_mevt->evt.irq =3D -1;
-			if (MCT_L0_IRQ + cpu >=3D ARRAY_SIZE(mct_irqs))
+			if (irq_idx >=3D ARRAY_SIZE(mct_irqs))
 				break;
-			mct_irq =3D mct_irqs[MCT_L0_IRQ + cpu];
+			mct_irq =3D mct_irqs[irq_idx];
=20
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
@@ -576,6 +601,17 @@ static int __init exynos4_timer_interrupts(struct device=
_node *np,
 		}
 	}
=20
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt =3D per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		if (cpu >=3D nr_local) {
+			err =3D -EINVAL;
+			goto out_irq;
+		}
+
+		mevt->base =3D EXYNOS4_MCT_L_BASE(local_idx[cpu]);
+	}
+
 	/* Install hotplug callbacks which configure the timer on this CPU */
 	err =3D cpuhp_setup_state(CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 				"clockevents/exynos4/mct_timer:starting",
@@ -605,20 +641,49 @@ static int __init exynos4_timer_interrupts(struct devic=
e_node *np,
=20
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
+	bool frc_shared =3D of_property_read_bool(np, "samsung,frc-shared");
+	u32 local_idx[MCT_NR_LOCAL] =3D {0};
+	int nr_local;
 	int ret;
=20
+	nr_local =3D of_property_count_u32_elems(np, "samsung,local-timers");
+	if (nr_local =3D=3D 0)
+		return -EINVAL;
+	if (nr_local > 0) {
+		if (nr_local > ARRAY_SIZE(local_idx))
+			return -EINVAL;
+
+		ret =3D of_property_read_u32_array(np, "samsung,local-timers",
+						 local_idx, nr_local);
+		if (ret)
+			return ret;
+	} else {
+		int i;
+
+		nr_local =3D ARRAY_SIZE(local_idx);
+		for (i =3D 0; i < nr_local; i++)
+			local_idx[i] =3D i;
+	}
+
 	ret =3D exynos4_timer_resources(np);
 	if (ret)
 		return ret;
=20
-	ret =3D exynos4_timer_interrupts(np, int_type);
+	ret =3D exynos4_timer_interrupts(np, int_type, local_idx, nr_local);
 	if (ret)
 		return ret;
=20
-	ret =3D exynos4_clocksource_init();
+	ret =3D exynos4_clocksource_init(frc_shared);
 	if (ret)
 		return ret;
=20
+	/*
+	 * When the FRC is shared with a main processor, this secondary
+	 * processor cannot use the global comparator.
+	 */
+	if (frc_shared)
+		return ret;
+
 	return exynos4_clockevent_init();
 }
=20
diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas=
-ostm.c
index 21d1392637b8..8da972dc1713 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
=20
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
=20
-#ifdef CONFIG_ARCH_R9A07G044
+#ifdef CONFIG_ARCH_RZG2L
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 8b38b3212388..fe4fa8d7b3f1 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -171,6 +171,7 @@ static int gxp_timer_probe(struct platform_device *pdev)
 {
 	struct platform_device *gxp_watchdog_device;
 	struct device *dev =3D &pdev->dev;
+	int ret;
=20
 	if (!gxp_timer) {
 		pr_err("Gxp Timer not initialized, cannot create watchdog");
@@ -187,7 +188,11 @@ static int gxp_timer_probe(struct platform_device *pdev)
 	gxp_watchdog_device->dev.platform_data =3D gxp_timer->counter;
 	gxp_watchdog_device->dev.parent =3D dev;
=20
-	return platform_device_add(gxp_watchdog_device);
+	ret =3D platform_device_add(gxp_watchdog_device);
+	if (ret)
+		platform_device_put(gxp_watchdog_device);
+
+	return ret;
 }
=20
 static const struct of_device_id gxp_timer_of_match[] =3D {
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/tim=
er-imx-sysctr.c
index 523e37662a6e..5a7a951c4efc 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -134,8 +134,10 @@ static int __init sysctr_timer_init(struct device_node *=
np)
 	if (ret)
 		return ret;
=20
-	/* system counter clock is divided by 3 internally */
-	to_sysctr.of_clk.rate /=3D SYS_CTR_CLK_DIV;
+	if (!of_property_read_bool(np, "nxp,no-divider")) {
+		/* system counter clock is divided by 3 internally */
+		to_sysctr.of_clk.rate /=3D SYS_CTR_CLK_DIV;
+	}
=20
 	sys_ctr_base =3D timer_of_base(&to_sysctr);
 	cmpcr =3D readl(sys_ctr_base + CMPCR);
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-su=
n4i.c
index 94dc6e42e983..e5a70aa1deb4 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -26,6 +26,7 @@
 #define TIMER_IRQ_EN_REG	0x00
 #define TIMER_IRQ_EN(val)		BIT(val)
 #define TIMER_IRQ_ST_REG	0x04
+#define TIMER_IRQ_CLEAR(val)		BIT(val)
 #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
 #define TIMER_CTL_ENABLE		BIT(0)
 #define TIMER_CTL_RELOAD		BIT(1)
@@ -123,7 +124,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
=20
 static void sun4i_timer_clear_interrupt(void __iomem *base)
 {
-	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
+	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
 }
=20
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 469f7c91564b..cad29ded3a48 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -33,6 +33,116 @@
=20
 #include <clocksource/timer-ti-dm.h>
=20
+/*
+ * timer errata flags
+ *
+ * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
+ * errata prevents us from using posted mode on these devices, unless the
+ * timer counter register is never read. For more details please refer to
+ * the OMAP3/4/5 errata documents.
+ */
+#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
+
+/* posted mode types */
+#define OMAP_TIMER_NONPOSTED			0x00
+#define OMAP_TIMER_POSTED			0x01
+
+/* register offsets with the write pending bit encoded */
+#define	WPSHIFT					16
+
+#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
+							| (WP_TCLR << WPSHIFT))
+
+#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
+							| (WP_TCRR << WPSHIFT))
+
+#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
+							| (WP_TLDR << WPSHIFT))
+
+#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
+							| (WP_TTGR << WPSHIFT))
+
+#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
+							| (WP_TMAR << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
+							| (WP_NONE << WPSHIFT))
+
+#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
+							| (WP_TPIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
+							| (WP_TNIR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
+							| (WP_TCVR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
+
+#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
+		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
+
+struct timer_regs {
+	u32 ocp_cfg;
+	u32 tidr;
+	u32 tier;
+	u32 twer;
+	u32 tclr;
+	u32 tcrr;
+	u32 tldr;
+	u32 ttrg;
+	u32 twps;
+	u32 tmar;
+	u32 tcar1;
+	u32 tsicr;
+	u32 tcar2;
+	u32 tpir;
+	u32 tnir;
+	u32 tcvr;
+	u32 tocr;
+	u32 towr;
+};
+
+struct dmtimer {
+	struct omap_dm_timer cookie;
+	int id;
+	int irq;
+	struct clk *fclk;
+
+	void __iomem	*io_base;
+	int		irq_stat;	/* TISR/IRQSTATUS interrupt status */
+	int		irq_ena;	/* irq enable */
+	int		irq_dis;	/* irq disable, only on v2 ip */
+	void __iomem	*pend;		/* write pending */
+	void __iomem	*func_base;	/* function register base */
+
+	atomic_t enabled;
+	unsigned long rate;
+	unsigned reserved:1;
+	unsigned posted:1;
+	unsigned omap1:1;
+	struct timer_regs context;
+	int revision;
+	u32 capability;
+	u32 errata;
+	struct platform_device *pdev;
+	struct list_head node;
+	struct notifier_block nb;
+};
+
 static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
@@ -44,27 +154,56 @@ enum {
 	REQUEST_BY_NODE,
 };
=20
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
+/**
+ * dmtimer_read - read timer registers in posted and non-posted mode
+ * @timer:	timer pointer over which read operation to perform
+ * @reg:	lowest byte holds the register offset
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode, write
+ * pending bit must be checked. Otherwise a read of a non completed write
+ * will produce an error.
+ */
+static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
 {
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+	u16 wp, offset;
+
+	wp =3D reg >> WPSHIFT;
+	offset =3D reg & 0xff;
+
+	/* Wait for a possible write pending bit in posted mode */
+	if (wp && timer->posted)
+		while (readl_relaxed(timer->pend) & wp)
 			cpu_relax();
=20
-	return readl_relaxed(timer->func_base + (reg & 0xff));
+	return readl_relaxed(timer->func_base + offset);
 }
=20
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
+/**
+ * dmtimer_write - write timer registers in posted and non-posted mode
+ * @timer:      timer pointer over which write operation is to perform
+ * @reg:        lowest byte holds the register offset
+ * @value:      data to write into the register
+ *
+ * The posted mode bit is encoded in reg. Note that in posted mode, the write
+ * pending bit must be checked. Otherwise a write on a register which has a
+ * pending write will be lost.
+ */
+static inline void dmtimer_write(struct dmtimer *timer, u32 reg, u32 val)
 {
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+	u16 wp, offset;
+
+	wp =3D reg >> WPSHIFT;
+	offset =3D reg & 0xff;
+
+	/* Wait for a possible write pending bit in posted mode */
+	if (wp && timer->posted)
+		while (readl_relaxed(timer->pend) & wp)
 			cpu_relax();
=20
-	writel_relaxed(val, timer->func_base + (reg & 0xff));
+	writel_relaxed(val, timer->func_base + offset);
 }
=20
-static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
+static inline void __omap_dm_timer_init_regs(struct dmtimer *timer)
 {
 	u32 tidr;
=20
@@ -72,16 +211,16 @@ static inline void __omap_dm_timer_init_regs(struct omap=
_dm_timer *timer)
 	tidr =3D readl_relaxed(timer->io_base);
 	if (!(tidr >> 16)) {
 		timer->revision =3D 1;
-		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_stat =3D OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena =3D OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis =3D OMAP_TIMER_V1_INT_EN_OFFSET;
 		timer->pend =3D timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
 		timer->func_base =3D timer->io_base;
 	} else {
 		timer->revision =3D 2;
-		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->irq_stat =3D OMAP_TIMER_V2_IRQSTATUS - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_ena =3D OMAP_TIMER_V2_IRQENABLE_SET - OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->irq_dis =3D OMAP_TIMER_V2_IRQENABLE_CLR - OMAP_TIMER_V2_FUNC_OFFSET;
 		timer->pend =3D timer->io_base +
 			_OMAP_TIMER_WRITE_PEND_OFFSET +
 				OMAP_TIMER_V2_FUNC_OFFSET;
@@ -99,35 +238,34 @@ static inline void __omap_dm_timer_init_regs(struct omap=
_dm_timer *timer)
  * complete. Enabling this feature can improve performance for writing to the
  * timer registers.
  */
-static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+static inline void __omap_dm_timer_enable_posted(struct dmtimer *timer)
 {
 	if (timer->posted)
 		return;
=20
 	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
 		timer->posted =3D OMAP_TIMER_NONPOSTED;
-		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
+		dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0);
 		return;
 	}
=20
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-			      OMAP_TIMER_CTRL_POSTED, 0);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, OMAP_TIMER_CTRL_POSTED);
 	timer->context.tsicr =3D OMAP_TIMER_CTRL_POSTED;
 	timer->posted =3D OMAP_TIMER_POSTED;
 }
=20
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
+static inline void __omap_dm_timer_stop(struct dmtimer *timer,
+					unsigned long rate)
 {
 	u32 l;
=20
-	l =3D __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (l & OMAP_TIMER_CTRL_ST) {
 		l &=3D ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 #ifdef CONFIG_ARCH_OMAP2PLUS
 		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		/*
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
@@ -137,104 +275,59 @@ static inline void __omap_dm_timer_stop(struct omap_dm=
_timer *timer,
 	}
=20
 	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, OMAP_TIMER_INT_OVERFLOW);
 }
=20
-static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
-						unsigned int value)
+static inline void __omap_dm_timer_int_enable(struct dmtimer *timer,
+					      unsigned int value)
 {
-	writel_relaxed(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+	dmtimer_write(timer, timer->irq_ena, value);
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value);
 }
=20
 static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+__omap_dm_timer_read_counter(struct dmtimer *timer)
 {
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+	return dmtimer_read(timer, OMAP_TIMER_COUNTER_REG);
 }
=20
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
+static inline void __omap_dm_timer_write_status(struct dmtimer *timer,
 						unsigned int value)
 {
-	writel_relaxed(value, timer->irq_stat);
+	dmtimer_write(timer, timer->irq_stat, value);
 }
=20
-/**
- * omap_dm_timer_read_reg - read timer registers in posted and non-posted mo=
de
- * @timer:      timer pointer over which read operation to perform
- * @reg:        lowest byte holds the register offset
- *
- * The posted mode bit is encoded in reg. Note that in posted mode write
- * pending bit must be checked. Otherwise a read of a non completed write
- * will produce an error.
- */
-static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 re=
g)
+static void omap_timer_restore_context(struct dmtimer *timer)
 {
-	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	return __omap_dm_timer_read(timer, reg, timer->posted);
+	dmtimer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, timer->context.ocp_cfg);
+
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, timer->context.twer);
+	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, timer->context.tcrr);
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, timer->context.tldr);
+	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, timer->context.tmar);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, timer->context.tsicr);
+	dmtimer_write(timer, timer->irq_ena, timer->context.tier);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, timer->context.tclr);
 }
=20
-/**
- * omap_dm_timer_write_reg - write timer registers in posted and non-posted =
mode
- * @timer:      timer pointer over which write operation is to perform
- * @reg:        lowest byte holds the register offset
- * @value:      data to write into the register
- *
- * The posted mode bit is encoded in reg. Note that in posted mode the write
- * pending bit must be checked. Otherwise a write on a register which has a
- * pending write will be lost.
- */
-static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
-						u32 value)
+static void omap_timer_save_context(struct dmtimer *timer)
 {
-	WARN_ON((reg & 0xff) < _OMAP_TIMER_WAKEUP_EN_OFFSET);
-	__omap_dm_timer_write(timer, reg, value, timer->posted);
-}
-
-static void omap_timer_restore_context(struct omap_dm_timer *timer)
-{
-	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET,
-			      timer->context.ocp_cfg, 0);
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG,
-				timer->context.twer);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG,
-				timer->context.tcrr);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG,
-				timer->context.tldr);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG,
-				timer->context.tmar);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
-				timer->context.tsicr);
-	writel_relaxed(timer->context.tier, timer->irq_ena);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG,
-				timer->context.tclr);
-}
-
-static void omap_timer_save_context(struct omap_dm_timer *timer)
-{
-	timer->context.ocp_cfg =3D
-		__omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
-
-	timer->context.tclr =3D
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	timer->context.twer =3D
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
-	timer->context.tldr =3D
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
-	timer->context.tmar =3D
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
-	timer->context.tier =3D readl_relaxed(timer->irq_ena);
-	timer->context.tsicr =3D
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+	timer->context.ocp_cfg =3D dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
+
+	timer->context.tclr =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.twer =3D dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tldr =3D dmtimer_read(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar =3D dmtimer_read(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.tier =3D dmtimer_read(timer, timer->irq_ena);
+	timer->context.tsicr =3D dmtimer_read(timer, OMAP_TIMER_IF_CTRL_REG);
 }
=20
 static int omap_timer_context_notifier(struct notifier_block *nb,
 				       unsigned long cmd, void *v)
 {
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
=20
-	timer =3D container_of(nb, struct omap_dm_timer, nb);
+	timer =3D container_of(nb, struct dmtimer, nb);
=20
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
@@ -256,18 +349,17 @@ static int omap_timer_context_notifier(struct notifier_=
block *nb,
 	return NOTIFY_OK;
 }
=20
-static int omap_dm_timer_reset(struct omap_dm_timer *timer)
+static int omap_dm_timer_reset(struct dmtimer *timer)
 {
 	u32 l, timeout =3D 100000;
=20
 	if (timer->revision !=3D 1)
 		return -EINVAL;
=20
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+	dmtimer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
=20
 	do {
-		l =3D __omap_dm_timer_read(timer,
-					 OMAP_TIMER_V1_SYS_STAT_OFFSET, 0);
+		l =3D dmtimer_read(timer, OMAP_TIMER_V1_SYS_STAT_OFFSET);
 	} while (!l && timeout--);
=20
 	if (!timeout) {
@@ -276,22 +368,38 @@ static int omap_dm_timer_reset(struct omap_dm_timer *ti=
mer)
 	}
=20
 	/* Configure timer for smart-idle mode */
-	l =3D __omap_dm_timer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET, 0);
+	l =3D dmtimer_read(timer, OMAP_TIMER_OCP_CFG_OFFSET);
 	l |=3D 0x2 << 0x3;
-	__omap_dm_timer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l, 0);
+	dmtimer_write(timer, OMAP_TIMER_OCP_CFG_OFFSET, l);
=20
 	timer->posted =3D 0;
=20
 	return 0;
 }
=20
-static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
+/*
+ * Functions exposed to PWM and remoteproc drivers via platform_data.
+ * Do not use these in the driver, these will get deprecated and will
+ * will be replaced by Linux generic framework functions such as
+ * chained interrupts and clock framework.
+ */
+static struct dmtimer *to_dmtimer(struct omap_dm_timer *cookie)
+{
+	if (!cookie)
+		return NULL;
+
+	return container_of(cookie, struct dmtimer, cookie);
+}
+
+static int omap_dm_timer_set_source(struct omap_dm_timer *cookie, int source)
 {
 	int ret;
 	const char *parent_name;
 	struct clk *parent;
 	struct dmtimer_platform_data *pdata;
+	struct dmtimer *timer;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer) || IS_ERR(timer->fclk))
 		return -EINVAL;
=20
@@ -316,7 +424,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer =
*timer, int source)
 	 * use the clock framework to set the parent clock. To be removed
 	 * once OMAP1 migrated to using clock framework for dmtimers
 	 */
-	if (pdata && pdata->set_timer_src)
+	if (timer->omap1 && pdata && pdata->set_timer_src)
 		return pdata->set_timer_src(timer->pdev, source);
=20
 #if defined(CONFIG_COMMON_CLK)
@@ -341,44 +449,44 @@ static int omap_dm_timer_set_source(struct omap_dm_time=
r *timer, int source)
 	return ret;
 }
=20
-static void omap_dm_timer_enable(struct omap_dm_timer *timer)
+static void omap_dm_timer_enable(struct omap_dm_timer *cookie)
 {
-	pm_runtime_get_sync(&timer->pdev->dev);
+	struct dmtimer *timer =3D to_dmtimer(cookie);
+	struct device *dev =3D &timer->pdev->dev;
+	int rc;
+
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		dev_err(dev, "could not enable timer\n");
 }
=20
-static void omap_dm_timer_disable(struct omap_dm_timer *timer)
+static void omap_dm_timer_disable(struct omap_dm_timer *cookie)
 {
-	pm_runtime_put_sync(&timer->pdev->dev);
+	struct dmtimer *timer =3D to_dmtimer(cookie);
+	struct device *dev =3D &timer->pdev->dev;
+
+	pm_runtime_put_sync(dev);
 }
=20
-static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
+static int omap_dm_timer_prepare(struct dmtimer *timer)
 {
+	struct device *dev =3D &timer->pdev->dev;
 	int rc;
=20
-	/*
-	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
-	 * do not call clk_get() for these devices.
-	 */
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET)) {
-		timer->fclk =3D clk_get(&timer->pdev->dev, "fck");
-		if (WARN_ON_ONCE(IS_ERR(timer->fclk))) {
-			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
-			return -EINVAL;
-		}
-	}
-
-	omap_dm_timer_enable(timer);
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
=20
 	if (timer->capability & OMAP_TIMER_NEEDS_RESET) {
 		rc =3D omap_dm_timer_reset(timer);
 		if (rc) {
-			omap_dm_timer_disable(timer);
+			pm_runtime_put_sync(dev);
 			return rc;
 		}
 	}
=20
 	__omap_dm_timer_enable_posted(timer);
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
=20
 	return 0;
 }
@@ -388,19 +496,9 @@ static inline u32 omap_dm_timer_reserved_systimer(int id)
 	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
 }
=20
-int omap_dm_timer_reserve_systimer(int id)
+static struct dmtimer *_omap_dm_timer_request(int req_type, void *data)
 {
-	if (omap_dm_timer_reserved_systimer(id))
-		return -ENODEV;
-
-	omap_reserved_systimers |=3D (1 << (id - 1));
-
-	return 0;
-}
-
-static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
-{
-	struct omap_dm_timer *timer =3D NULL, *t;
+	struct dmtimer *timer =3D NULL, *t;
 	struct device_node *np =3D NULL;
 	unsigned long flags;
 	u32 cap =3D 0;
@@ -484,11 +582,19 @@ static struct omap_dm_timer *_omap_dm_timer_request(int=
 req_type, void *data)
=20
 static struct omap_dm_timer *omap_dm_timer_request(void)
 {
-	return _omap_dm_timer_request(REQUEST_ANY, NULL);
+	struct dmtimer *timer;
+
+	timer =3D _omap_dm_timer_request(REQUEST_ANY, NULL);
+	if (!timer)
+		return NULL;
+
+	return &timer->cookie;
 }
=20
 static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
 {
+	struct dmtimer *timer;
+
 	/* Requesting timer by ID is not supported when device tree is used */
 	if (of_have_populated_dt()) {
 		pr_warn("%s: Please use omap_dm_timer_request_by_node()\n",
@@ -496,21 +602,11 @@ static struct omap_dm_timer *omap_dm_timer_request_spec=
ific(int id)
 		return NULL;
 	}
=20
-	return _omap_dm_timer_request(REQUEST_BY_ID, &id);
-}
+	timer =3D _omap_dm_timer_request(REQUEST_BY_ID, &id);
+	if (!timer)
+		return NULL;
=20
-/**
- * omap_dm_timer_request_by_cap - Request a timer by capability
- * @cap:	Bit mask of capabilities to match
- *
- * Find a timer based upon capabilities bit mask. Callers of this function
- * should use the definitions found in the plat/dmtimer.h file under the
- * comment "timer capabilities used in hwmod database". Returns pointer to
- * timer handle on success and a NULL pointer on failure.
- */
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
-{
-	return _omap_dm_timer_request(REQUEST_BY_CAP, &cap);
+	return &timer->cookie;
 }
=20
 /**
@@ -522,26 +618,34 @@ struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 =
cap)
  */
 static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_nod=
e *np)
 {
+	struct dmtimer *timer;
+
 	if (!np)
 		return NULL;
=20
-	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
+	timer =3D _omap_dm_timer_request(REQUEST_BY_NODE, np);
+	if (!timer)
+		return NULL;
+
+	return &timer->cookie;
 }
=20
-static int omap_dm_timer_free(struct omap_dm_timer *timer)
+static int omap_dm_timer_free(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	clk_put(timer->fclk);
-
 	WARN_ON(!timer->reserved);
 	timer->reserved =3D 0;
 	return 0;
 }
=20
-int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
+int omap_dm_timer_get_irq(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer =3D to_dmtimer(cookie);
 	if (timer)
 		return timer->irq;
 	return -EINVAL;
@@ -550,7 +654,7 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 #if defined(CONFIG_ARCH_OMAP1)
 #include <linux/soc/ti/omap1-io.h>
=20
-static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *cookie)
 {
 	return NULL;
 }
@@ -562,7 +666,7 @@ static struct clk *omap_dm_timer_get_fclk(struct omap_dm_=
timer *timer)
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
 	int i =3D 0;
-	struct omap_dm_timer *timer =3D NULL;
+	struct dmtimer *timer =3D NULL;
 	unsigned long flags;
=20
 	/* If ARMXOR cannot be idled this function call is unnecessary */
@@ -574,7 +678,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 	list_for_each_entry(timer, &omap_timer_list, node) {
 		u32 l;
=20
-		l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+		l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 		if (l & OMAP_TIMER_CTRL_ST) {
 			if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) =3D=3D 0)
 				inputmask &=3D ~(1 << 1);
@@ -590,8 +694,10 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
=20
 #else
=20
-static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
+static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer =3D to_dmtimer(cookie);
+
 	if (timer && !IS_ERR(timer->fclk))
 		return timer->fclk;
 	return NULL;
@@ -606,95 +712,125 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
=20
 #endif
=20
-int omap_dm_timer_trigger(struct omap_dm_timer *timer)
-{
-	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
-		pr_err("%s: timer not available or enabled.\n", __func__);
-		return -EINVAL;
-	}
-
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	return 0;
-}
-
-static int omap_dm_timer_start(struct omap_dm_timer *timer)
+static int omap_dm_timer_start(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 	u32 l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
+	dev =3D &timer->pdev->dev;
+
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
=20
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (!(l & OMAP_TIMER_CTRL_ST)) {
 		l |=3D OMAP_TIMER_CTRL_ST;
-		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+		dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
 	}
=20
 	return 0;
 }
=20
-static int omap_dm_timer_stop(struct omap_dm_timer *timer)
+static int omap_dm_timer_stop(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+	struct device *dev;
 	unsigned long rate =3D 0;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	if (!(timer->capability & OMAP_TIMER_NEEDS_RESET))
+	dev =3D &timer->pdev->dev;
+
+	if (!timer->omap1)
 		rate =3D clk_get_rate(timer->fclk);
=20
-	__omap_dm_timer_stop(timer, timer->posted, rate);
+	__omap_dm_timer_stop(timer, rate);
+
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
+static int omap_dm_timer_set_load(struct omap_dm_timer *cookie,
 				  unsigned int load)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	dmtimer_write(timer, OMAP_TIMER_LOAD_REG, load);
+
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
+static int omap_dm_timer_set_match(struct omap_dm_timer *cookie, int enable,
 				   unsigned int match)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 	u32 l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	if (enable)
 		l |=3D OMAP_TIMER_CTRL_CE;
 	else
 		l &=3D ~OMAP_TIMER_CTRL_CE;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_MATCH_REG, match);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
+static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int def_on,
 				 int toggle, int trigger, int autoreload)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 	u32 l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &=3D ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
 	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
 	if (def_on)
@@ -704,57 +840,86 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *=
timer, int def_on,
 	l |=3D trigger << 10;
 	if (autoreload)
 		l |=3D OMAP_TIMER_CTRL_AR;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *timer)
+static int omap_dm_timer_get_pwm_status(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 	u32 l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	omap_dm_timer_disable(timer);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
+
+	pm_runtime_put_sync(dev);
=20
 	return l;
 }
=20
-static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
-					int prescaler)
+static int omap_dm_timer_set_prescaler(struct omap_dm_timer *cookie,
+				       int prescaler)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
 	u32 l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer) || prescaler < -1 || prescaler > 7)
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
+	l =3D dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
 	l &=3D ~(OMAP_TIMER_CTRL_PRE | (0x07 << 2));
 	if (prescaler >=3D 0) {
 		l |=3D OMAP_TIMER_CTRL_PRE;
 		l |=3D prescaler << 2;
 	}
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
+	dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
+
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
+static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
 					unsigned int value)
 {
+	struct dmtimer *timer;
+	struct device *dev;
+	int rc;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
+
 	__omap_dm_timer_int_enable(timer, value);
=20
-	omap_dm_timer_disable(timer);
+	pm_runtime_put_sync(dev);
+
 	return 0;
 }
=20
@@ -765,42 +930,55 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_=
timer *timer,
  *
  * Disables the specified timer interrupts for a timer.
  */
-static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 ma=
sk)
+static int omap_dm_timer_set_int_disable(struct omap_dm_timer *cookie, u32 m=
ask)
 {
+	struct dmtimer *timer;
+	struct device *dev;
 	u32 l =3D mask;
+	int rc;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
 		return -EINVAL;
=20
-	omap_dm_timer_enable(timer);
+	dev =3D &timer->pdev->dev;
+	rc =3D pm_runtime_resume_and_get(dev);
+	if (rc)
+		return rc;
=20
 	if (timer->revision =3D=3D 1)
-		l =3D readl_relaxed(timer->irq_ena) & ~mask;
+		l =3D dmtimer_read(timer, timer->irq_ena) & ~mask;
+
+	dmtimer_write(timer, timer->irq_dis, l);
+	l =3D dmtimer_read(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
+	dmtimer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
=20
-	writel_relaxed(l, timer->irq_dis);
-	l =3D omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
+	pm_runtime_put_sync(dev);
=20
-	omap_dm_timer_disable(timer);
 	return 0;
 }
=20
-static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
 	unsigned int l;
=20
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
=20
-	l =3D readl_relaxed(timer->irq_stat);
+	l =3D dmtimer_read(timer, timer->irq_stat);
=20
 	return l;
 }
=20
-static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned =
int value)
+static int omap_dm_timer_write_status(struct omap_dm_timer *cookie, unsigned=
 int value)
 {
+	struct dmtimer *timer;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled)))
 		return -EINVAL;
=20
@@ -809,49 +987,39 @@ static int omap_dm_timer_write_status(struct omap_dm_ti=
mer *timer, unsigned int
 	return 0;
 }
=20
-static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
+static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *cookie)
 {
+	struct dmtimer *timer;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
 	}
=20
-	return __omap_dm_timer_read_counter(timer, timer->posted);
+	return __omap_dm_timer_read_counter(timer);
 }
=20
-static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned=
 int value)
+static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, unsigne=
d int value)
 {
+	struct dmtimer *timer;
+
+	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
=20
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_COUNTER_REG, value);
+	dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
=20
 	/* Save the context */
 	timer->context.tcrr =3D value;
 	return 0;
 }
=20
-int omap_dm_timers_active(void)
-{
-	struct omap_dm_timer *timer;
-
-	list_for_each_entry(timer, &omap_timer_list, node) {
-		if (!timer->reserved)
-			continue;
-
-		if (omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG) &
-		    OMAP_TIMER_CTRL_ST) {
-			return 1;
-		}
-	}
-	return 0;
-}
-
 static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 {
-	struct omap_dm_timer *timer =3D dev_get_drvdata(dev);
+	struct dmtimer *timer =3D dev_get_drvdata(dev);
=20
 	atomic_set(&timer->enabled, 0);
=20
@@ -865,7 +1033,7 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(=
struct device *dev)
=20
 static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
 {
-	struct omap_dm_timer *timer =3D dev_get_drvdata(dev);
+	struct dmtimer *timer =3D dev_get_drvdata(dev);
=20
 	if (!(timer->capability & OMAP_TIMER_ALWON) && timer->func_base)
 		omap_timer_restore_context(timer);
@@ -892,7 +1060,7 @@ static const struct of_device_id omap_timer_match[];
 static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
 	struct device *dev =3D &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -916,7 +1084,6 @@ static int omap_dm_timer_probe(struct platform_device *p=
dev)
 	if (timer->irq < 0)
 		return timer->irq;
=20
-	timer->fclk =3D ERR_PTR(-ENODEV);
 	timer->io_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
@@ -938,6 +1105,17 @@ static int omap_dm_timer_probe(struct platform_device *=
pdev)
 		timer->reserved =3D omap_dm_timer_reserved_systimer(timer->id);
 	}
=20
+	timer->omap1 =3D timer->capability & OMAP_TIMER_NEEDS_RESET;
+
+	/* OMAP1 devices do not yet use the clock framework for dmtimers */
+	if (!timer->omap1) {
+		timer->fclk =3D devm_clk_get(dev, "fck");
+		if (IS_ERR(timer->fclk))
+			return PTR_ERR(timer->fclk);
+	} else {
+		timer->fclk =3D ERR_PTR(-ENODEV);
+	}
+
 	if (!(timer->capability & OMAP_TIMER_ALWON)) {
 		timer->nb.notifier_call =3D omap_timer_context_notifier;
 		cpu_pm_register_notifier(&timer->nb);
@@ -950,11 +1128,11 @@ static int omap_dm_timer_probe(struct platform_device =
*pdev)
 	pm_runtime_enable(dev);
=20
 	if (!timer->reserved) {
-		ret =3D pm_runtime_get_sync(dev);
-		if (ret < 0) {
+		ret =3D pm_runtime_resume_and_get(dev);
+		if (ret) {
 			dev_err(dev, "%s: pm_runtime_get_sync failed!\n",
 				__func__);
-			goto err_get_sync;
+			goto err_disable;
 		}
 		__omap_dm_timer_init_regs(timer);
 		pm_runtime_put(dev);
@@ -969,8 +1147,7 @@ static int omap_dm_timer_probe(struct platform_device *p=
dev)
=20
 	return 0;
=20
-err_get_sync:
-	pm_runtime_put_noidle(dev);
+err_disable:
 	pm_runtime_disable(dev);
 	return ret;
 }
@@ -985,7 +1162,7 @@ static int omap_dm_timer_probe(struct platform_device *p=
dev)
  */
 static int omap_dm_timer_remove(struct platform_device *pdev)
 {
-	struct omap_dm_timer *timer;
+	struct dmtimer *timer;
 	unsigned long flags;
 	int ret =3D -EINVAL;
=20
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti=
-dm.h
index b0f80cfd2a26..77eceeae708c 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -52,10 +52,6 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
=20
-/* posted mode types */
-#define OMAP_TIMER_NONPOSTED			0x00
-#define OMAP_TIMER_POSTED			0x01
-
 /* timer capabilities used in hwmod database */
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
@@ -63,73 +59,13 @@
 #define OMAP_TIMER_NEEDS_RESET				0x10000000
 #define OMAP_TIMER_HAS_DSP_IRQ				0x08000000
=20
-/*
- * timer errata flags
- *
- * Errata i103/i767 impacts all OMAP3/4/5 devices including AM33xx. This
- * errata prevents us from using posted mode on these devices, unless the
- * timer counter register is never read. For more details please refer to
- * the OMAP3/4/5 errata documents.
- */
-#define OMAP_TIMER_ERRATA_I103_I767			0x80000000
-
-struct timer_regs {
-	u32 ocp_cfg;
-	u32 tidr;
-	u32 tier;
-	u32 twer;
-	u32 tclr;
-	u32 tcrr;
-	u32 tldr;
-	u32 ttrg;
-	u32 twps;
-	u32 tmar;
-	u32 tcar1;
-	u32 tsicr;
-	u32 tcar2;
-	u32 tpir;
-	u32 tnir;
-	u32 tcvr;
-	u32 tocr;
-	u32 towr;
-};
-
 struct omap_dm_timer {
-	int id;
-	int irq;
-	struct clk *fclk;
-
-	void __iomem	*io_base;
-	void __iomem	*irq_stat;	/* TISR/IRQSTATUS interrupt status */
-	void __iomem	*irq_ena;	/* irq enable */
-	void __iomem	*irq_dis;	/* irq disable, only on v2 ip */
-	void __iomem	*pend;		/* write pending */
-	void __iomem	*func_base;	/* function register base */
-
-	atomic_t enabled;
-	unsigned long rate;
-	unsigned reserved:1;
-	unsigned posted:1;
-	struct timer_regs context;
-	int revision;
-	u32 capability;
-	u32 errata;
-	struct platform_device *pdev;
-	struct list_head node;
-	struct notifier_block nb;
 };
=20
-int omap_dm_timer_reserve_systimer(int id);
-struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
-
 int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
=20
 u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
=20
-int omap_dm_timer_trigger(struct omap_dm_timer *timer);
-
-int omap_dm_timers_active(void);
-
 /*
  * Do not use the defines below, they are not needed. They should be only
  * used by dmtimer.c and sys_timer related code.
@@ -199,52 +135,4 @@ int omap_dm_timers_active(void);
 #define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
 #define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
=20
-/* register offsets with the write pending bit encoded */
-#define	WPSHIFT					16
-
-#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
-							| (WP_TCLR << WPSHIFT))
-
-#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
-							| (WP_TCRR << WPSHIFT))
-
-#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
-							| (WP_TLDR << WPSHIFT))
-
-#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
-							| (WP_TTGR << WPSHIFT))
-
-#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
-							| (WP_TMAR << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
-							| (WP_TPIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
-							| (WP_TNIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
-							| (WP_TCVR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
-
 #endif /* __CLOCKSOURCE_DMTIMER_H */

