Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536F860B41B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJXR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiJXR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:28:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162515FCB;
        Mon, 24 Oct 2022 09:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE3B3B811F8;
        Mon, 24 Oct 2022 15:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BD3C433D7;
        Mon, 24 Oct 2022 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625917;
        bh=jApnP8iKySHZaETbBxPwcRr9cryXnwQ5EJzFYO4cLsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0syD7u4MdQP2EGqpjkGXDJwOT7k2rGH1QsIy2giQlCEQUPRHBFEQ8hWLEvJLF3e+
         72a7/VXgTjxTbQCN8uMF9RlXpAyR3Srjw8s1/wkEUyF00AYBiXVbzRIaENo3pCXn3L
         FEL5BvqS0/Z9XVWqsVb1HaRHUQWmhaNArB/tmq7ByLI4T5p+dc1KeBZj4m9WBUGRdU
         TUjS0H6naXHeYH77t5ZlKQ3wy5FAkJex4YMZVVGjUnSUbxnBVyHqp59pZaWwBQed3Z
         i9TlkNWwohKMZZKrcfjt/LOp64xrXr/YyijayD3tEXYXyy14IzY+TYUu7t5gACGV+P
         I3fFRASxqN04w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/10] ARM: omap2: remove unused functions
Date:   Mon, 24 Oct 2022 17:38:11 +0200
Message-Id: <20221024153814.254652-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

These are a number of individual functions that were either never
used, or that had their last user removed in a prior cleanup.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/clockdomain.c             |  40 -------
 arch/arm/mach-omap2/clockdomain.h             |   2 -
 arch/arm/mach-omap2/common.h                  |   3 -
 arch/arm/mach-omap2/control.c                 |  73 -------------
 arch/arm/mach-omap2/control.h                 |   5 -
 arch/arm/mach-omap2/io.c                      |   6 --
 arch/arm/mach-omap2/omap-secure.c             |   5 -
 arch/arm/mach-omap2/omap-secure.h             |   1 -
 arch/arm/mach-omap2/omap_device.c             |  60 -----------
 arch/arm/mach-omap2/omap_device.h             |   5 -
 arch/arm/mach-omap2/omap_hwmod.c              |  90 ----------------
 arch/arm/mach-omap2/omap_hwmod.h              |   4 -
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   6 --
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |   1 -
 arch/arm/mach-omap2/pm.c                      |   6 --
 arch/arm/mach-omap2/pm.h                      |   4 -
 arch/arm/mach-omap2/powerdomain.c             | 100 ------------------
 arch/arm/mach-omap2/powerdomain.h             |   3 -
 arch/arm/mach-omap2/prcm_mpu44xx.c            |  12 ---
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h      |   2 -
 arch/arm/mach-omap2/prm.h                     |   3 -
 arch/arm/mach-omap2/prm_common.c              |  51 ---------
 arch/arm/mach-omap2/sdrc.c                    |  49 ---------
 arch/arm/mach-omap2/sdrc.h                    |   3 -
 arch/arm/mach-omap2/vc.c                      |  15 ---
 25 files changed, 549 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 1feb0098705e..f4e488e72515 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1043,46 +1043,6 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 	pwrdm_unlock(clkdm->pwrdm.ptr);
 }
 
-/**
- * clkdm_in_hwsup - is clockdomain @clkdm have hardware-supervised idle enabled?
- * @clkdm: struct clockdomain *
- *
- * Returns true if clockdomain @clkdm currently has
- * hardware-supervised idle enabled, or false if it does not or if
- * @clkdm is NULL.  It is only valid to call this function after
- * clkdm_init() has been called.  This function does not actually read
- * bits from the hardware; it instead tests an in-memory flag that is
- * changed whenever the clockdomain code changes the auto-idle mode.
- */
-bool clkdm_in_hwsup(struct clockdomain *clkdm)
-{
-	bool ret;
-
-	if (!clkdm)
-		return false;
-
-	ret = (clkdm->_flags & _CLKDM_FLAG_HWSUP_ENABLED) ? true : false;
-
-	return ret;
-}
-
-/**
- * clkdm_missing_idle_reporting - can @clkdm enter autoidle even if in use?
- * @clkdm: struct clockdomain *
- *
- * Returns true if clockdomain @clkdm has the
- * CLKDM_MISSING_IDLE_REPORTING flag set, or false if not or @clkdm is
- * null.  More information is available in the documentation for the
- * CLKDM_MISSING_IDLE_REPORTING macro.
- */
-bool clkdm_missing_idle_reporting(struct clockdomain *clkdm)
-{
-	if (!clkdm)
-		return false;
-
-	return (clkdm->flags & CLKDM_MISSING_IDLE_REPORTING) ? true : false;
-}
-
 /* Public autodep handling functions (deprecated) */
 
 /**
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 68550b23c938..a6bce3795a32 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -203,8 +203,6 @@ void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
 void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
-bool clkdm_in_hwsup(struct clockdomain *clkdm);
-bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
 
 int clkdm_wakeup_nolock(struct clockdomain *clkdm);
 int clkdm_wakeup(struct clockdomain *clkdm);
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index fc041d18809b..415ca353a345 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -120,7 +120,6 @@ static inline void omap5_realtime_timer_init(void)
 void omap2420_init_early(void);
 void omap2430_init_early(void);
 void omap3430_init_early(void);
-void omap35xx_init_early(void);
 void omap3630_init_early(void);
 void omap3_init_early(void);	/* Do not use this one */
 void am33xx_init_early(void);
@@ -133,8 +132,6 @@ void omap4430_init_early(void);
 void omap5_init_early(void);
 void omap3_init_late(void);
 void omap4430_init_late(void);
-void omap2420_init_late(void);
-void omap2430_init_late(void);
 void ti81xx_init_late(void);
 void am33xx_init_late(void);
 void omap5_init_late(void);
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c514a9602269..79860b23030d 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -226,68 +226,7 @@ void omap3_ctrl_write_boot_mode(u8 bootmode)
 
 #endif
 
-/**
- * omap_ctrl_write_dsp_boot_addr - set boot address for a remote processor
- * @bootaddr: physical address of the boot loader
- *
- * Set boot address for the boot loader of a supported processor
- * when a power ON sequence occurs.
- */
-void omap_ctrl_write_dsp_boot_addr(u32 bootaddr)
-{
-	u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
-		     cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTADDR :
-		     cpu_is_omap44xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
-		     soc_is_omap54xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
-		     0;
-
-	if (!offset) {
-		pr_err("%s: unsupported omap type\n", __func__);
-		return;
-	}
-
-	omap_ctrl_writel(bootaddr, offset);
-}
-
-/**
- * omap_ctrl_write_dsp_boot_mode - set boot mode for a remote processor
- * @bootmode: 8-bit value to pass to some boot code
- *
- * Sets boot mode for the boot loader of a supported processor
- * when a power ON sequence occurs.
- */
-void omap_ctrl_write_dsp_boot_mode(u8 bootmode)
-{
-	u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTMOD :
-		     cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTMOD :
-		     0;
-
-	if (!offset) {
-		pr_err("%s: unsupported omap type\n", __func__);
-		return;
-	}
-
-	omap_ctrl_writel(bootmode, offset);
-}
-
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-/*
- * Clears the scratchpad contents in case of cold boot-
- * called during bootup
- */
-void omap3_clear_scratchpad_contents(void)
-{
-	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
-	void __iomem *v_addr;
-	u32 offset = 0;
-
-	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
-	if (omap3xxx_prm_clear_global_cold_reset()) {
-		for ( ; offset <= max_offset; offset += 0x4)
-			writel_relaxed(0x0, (v_addr + offset));
-	}
-}
-
 /* Populate the scratchpad structure with restore structure */
 void omap3_save_scratchpad_contents(void)
 {
@@ -846,15 +785,3 @@ int __init omap_control_init(void)
 	return ret;
 
 }
-
-/**
- * omap3_control_legacy_iomap_init - legacy iomap init for clock providers
- *
- * Legacy iomap init for clock provider. Needed only by legacy boot mode,
- * where the base addresses are not parsed from DT, but still required
- * by the clock driver to be setup properly.
- */
-void __init omap3_control_legacy_iomap_init(void)
-{
-	omap2_clk_legacy_provider_init(TI_CLKM_SCRM, omap2_ctrl_base);
-}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index c4ca30ba1790..7e7440533bf9 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -512,8 +512,6 @@ extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
 
-extern void omap3_save_scratchpad_contents(void);
-extern void omap3_clear_scratchpad_contents(void);
 extern void omap3_restore(void);
 extern void omap3_restore_es3(void);
 extern void omap3_restore_3630(void);
@@ -521,14 +519,11 @@ extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
 extern void omap3_ctrl_write_boot_mode(u8 bootmode);
-extern void omap_ctrl_write_dsp_boot_addr(u32 bootaddr);
-extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
 int omap2_control_base_init(void);
 int omap_control_init(void);
-void __init omap3_control_legacy_iomap_init(void);
 #else
 #define omap_ctrl_readb(x)		0
 #define omap_ctrl_readw(x)		0
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 375fea35b981..e45a3ce97085 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -494,12 +494,6 @@ void __init omap3430_init_early(void)
 	omap_clk_soc_init = omap3430_dt_clk_init;
 }
 
-void __init omap35xx_init_early(void)
-{
-	omap3_init_early();
-	omap_clk_soc_init = omap3430_dt_clk_init;
-}
-
 void __init omap3630_init_early(void)
 {
 	omap3_init_early();
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index fb9c114b9dd7..41aec5c93a70 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -118,11 +118,6 @@ int __init omap_secure_ram_reserve_memblock(void)
 	return 0;
 }
 
-phys_addr_t omap_secure_ram_mempool_base(void)
-{
-	return omap_secure_memblock_base;
-}
-
 #if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
 u32 omap3_save_secure_ram(void *addr, int size)
 {
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 9e67d4efdd0c..2ce26a86b7bd 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -70,7 +70,6 @@ extern void omap_smccc_smc(u32 fn, u32 arg);
 extern void omap_smc1(u32 fn, u32 arg);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
-extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
 extern u32 save_secure_ram_context(u32 args_pa);
 extern u32 omap3_save_secure_ram(void *save_regs, int size);
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 8b3701901991..0594aaaa1a98 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -285,34 +285,6 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
 
 /* Public functions for use by core code */
 
-/**
- * omap_device_get_context_loss_count - get lost context count
- * @pdev: The platform device to update.
- *
- * Using the primary hwmod, query the context loss count for this
- * device.
- *
- * Callers should consider context for this device lost any time this
- * function returns a value different than the value the caller got
- * the last time it called this function.
- *
- * If any hwmods exist for the omap_device associated with @pdev,
- * return the context loss counter for that hwmod, otherwise return
- * zero.
- */
-int omap_device_get_context_loss_count(struct platform_device *pdev)
-{
-	struct omap_device *od;
-	u32 ret = 0;
-
-	od = to_omap_device(pdev);
-
-	if (od->hwmods_cnt)
-		ret = omap_hwmod_get_context_loss_count(od->hwmods[0]);
-
-	return ret;
-}
-
 /**
  * omap_device_alloc - allocate an omap_device
  * @pdev: platform_device that will be included in this omap_device
@@ -592,38 +564,6 @@ int omap_device_deassert_hardreset(struct platform_device *pdev,
 	return ret;
 }
 
-/**
- * omap_device_get_by_hwmod_name() - convert a hwmod name to
- * device pointer.
- * @oh_name: name of the hwmod device
- *
- * Returns back a struct device * pointer associated with a hwmod
- * device represented by a hwmod_name
- */
-struct device *omap_device_get_by_hwmod_name(const char *oh_name)
-{
-	struct omap_hwmod *oh;
-
-	if (!oh_name) {
-		WARN(1, "%s: no hwmod name!\n", __func__);
-		return ERR_PTR(-EINVAL);
-	}
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		WARN(1, "%s: no hwmod for %s\n", __func__,
-			oh_name);
-		return ERR_PTR(-ENODEV);
-	}
-	if (!oh->od) {
-		WARN(1, "%s: no omap_device for %s\n", __func__,
-			oh_name);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return &oh->od->pdev->dev;
-}
-
 static struct notifier_block platform_nb = {
 	.notifier_call = _omap_device_notifier_call,
 };
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index d607532cf5e0..455f0a2b43ee 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -72,11 +72,6 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 				      struct omap_hwmod **ohs, int oh_cnt);
 void omap_device_delete(struct omap_device *od);
 
-struct device *omap_device_get_by_hwmod_name(const char *oh_name);
-
-/* OMAP PM interface */
-int omap_device_get_context_loss_count(struct platform_device *pdev);
-
 /* Other */
 
 int omap_device_assert_hardreset(struct platform_device *pdev,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 31d1a21f6041..b03be626bc99 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3763,55 +3763,6 @@ int omap_hwmod_shutdown(struct omap_hwmod *oh)
  * IP block data retrieval functions
  */
 
-/**
- * omap_hwmod_get_pwrdm - return pointer to this module's main powerdomain
- * @oh: struct omap_hwmod *
- *
- * Return the powerdomain pointer associated with the OMAP module
- * @oh's main clock.  If @oh does not have a main clk, return the
- * powerdomain associated with the interface clock associated with the
- * module's MPU port. (XXX Perhaps this should use the SDMA port
- * instead?)  Returns NULL on error, or a struct powerdomain * on
- * success.
- */
-struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
-{
-	struct clk *c;
-	struct omap_hwmod_ocp_if *oi;
-	struct clockdomain *clkdm;
-	struct clk_hw_omap *clk;
-	struct clk_hw *hw;
-
-	if (!oh)
-		return NULL;
-
-	if (oh->clkdm)
-		return oh->clkdm->pwrdm.ptr;
-
-	if (oh->_clk) {
-		c = oh->_clk;
-	} else {
-		oi = _find_mpu_rt_port(oh);
-		if (!oi)
-			return NULL;
-		c = oi->_clk;
-	}
-
-	hw = __clk_get_hw(c);
-	if (!hw)
-		return NULL;
-
-	clk = to_clk_hw_omap(hw);
-	if (!clk)
-		return NULL;
-
-	clkdm = clk->clkdm;
-	if (!clkdm)
-		return NULL;
-
-	return clkdm->pwrdm.ptr;
-}
-
 /**
  * omap_hwmod_get_mpu_rt_va - return the module's base address (for the MPU)
  * @oh: struct omap_hwmod *
@@ -3977,32 +3928,6 @@ int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state)
 	return ret;
 }
 
-/**
- * omap_hwmod_get_context_loss_count - get lost context count
- * @oh: struct omap_hwmod *
- *
- * Returns the context loss count of associated @oh
- * upon success, or zero if no context loss data is available.
- *
- * On OMAP4, this queries the per-hwmod context loss register,
- * assuming one exists.  If not, or on OMAP2/3, this queries the
- * enclosing powerdomain context loss count.
- */
-int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
-{
-	struct powerdomain *pwrdm;
-	int ret = 0;
-
-	if (soc_ops.get_context_lost)
-		return soc_ops.get_context_lost(oh);
-
-	pwrdm = omap_hwmod_get_pwrdm(oh);
-	if (pwrdm)
-		ret = pwrdm_get_context_loss_count(pwrdm);
-
-	return ret;
-}
-
 /**
  * omap_hwmod_init - initialize the hwmod code
  *
@@ -4054,18 +3979,3 @@ void __init omap_hwmod_init(void)
 
 	inited = true;
 }
-
-/**
- * omap_hwmod_get_main_clk - get pointer to main clock name
- * @oh: struct omap_hwmod *
- *
- * Returns the main clock name assocated with @oh upon success,
- * or NULL if @oh is NULL.
- */
-const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh)
-{
-	if (!oh)
-		return NULL;
-
-	return oh->main_clk;
-}
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 1bb42f3d2e83..3fa6d217ab83 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -643,7 +643,6 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
 int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 				   const char *name, struct resource *res);
 
-struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
 void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
 
 int omap_hwmod_for_each_by_class(const char *classname,
@@ -652,12 +651,9 @@ int omap_hwmod_for_each_by_class(const char *classname,
 				 void *user);
 
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
-int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 extern void __init omap_hwmod_init(void);
 
-const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
-
 #else	/* CONFIG_OMAP_HWMOD */
 
 static inline int
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 9156f2bfbc8d..9ab1d57f8b73 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -189,12 +189,6 @@ struct omap_hwmod omap2xxx_mpu_hwmod = {
 	.main_clk	= "mpu_ck",
 };
 
-/* IVA2 */
-struct omap_hwmod omap2xxx_iva_hwmod = {
-	.name		= "iva",
-	.class		= &iva_hwmod_class,
-};
-
 /* timer3 */
 struct omap_hwmod omap2xxx_timer3_hwmod = {
 	.name		= "timer3",
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index 0045e6680a63..c8eb1e6cc4a9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -20,7 +20,6 @@ extern struct omap_hwmod omap2xxx_l3_main_hwmod;
 extern struct omap_hwmod omap2xxx_l4_core_hwmod;
 extern struct omap_hwmod omap2xxx_l4_wkup_hwmod;
 extern struct omap_hwmod omap2xxx_mpu_hwmod;
-extern struct omap_hwmod omap2xxx_iva_hwmod;
 extern struct omap_hwmod omap2xxx_timer3_hwmod;
 extern struct omap_hwmod omap2xxx_timer4_hwmod;
 extern struct omap_hwmod omap2xxx_timer5_hwmod;
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index da829a90fe8c..53a132f11961 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -54,12 +54,6 @@ static struct omap2_oscillator oscillator = {
 	.shutdown_time = ULONG_MAX,
 };
 
-void omap_pm_setup_oscillator(u32 tstart, u32 tshut)
-{
-	oscillator.startup_time = tstart;
-	oscillator.shutdown_time = tshut;
-}
-
 void omap_pm_get_oscillator(u32 *tstart, u32 *tshut)
 {
 	if (!tstart || !tshut)
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index f523ca03161f..0c95774a4b8f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -142,13 +142,9 @@ static inline int omap4_cpcap_init(void)
 #endif
 
 #ifdef CONFIG_PM
-extern void omap_pm_setup_oscillator(u32 tstart, u32 tshut);
 extern void omap_pm_get_oscillator(u32 *tstart, u32 *tshut);
-extern void omap_pm_setup_sr_i2c_pcb_length(u32 mm);
 #else
-static inline void omap_pm_setup_oscillator(u32 tstart, u32 tshut) { }
 static inline void omap_pm_get_oscillator(u32 *tstart, u32 *tshut) { *tstart = *tshut = 0; }
-static inline void omap_pm_setup_sr_i2c_pcb_length(u32 mm) { }
 #endif
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2d747f6cffe8..0155a1e57a87 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -1148,82 +1148,6 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 	return ret;
 }
 
-/**
- * pwrdm_get_context_loss_count - get powerdomain's context loss count
- * @pwrdm: struct powerdomain * to wait for
- *
- * Context loss count is the sum of powerdomain off-mode counter, the
- * logic off counter and the per-bank memory off counter.  Returns negative
- * (and WARNs) upon error, otherwise, returns the context loss count.
- */
-int pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
-{
-	int i, count;
-
-	if (!pwrdm) {
-		WARN(1, "powerdomain: %s: pwrdm is null\n", __func__);
-		return -ENODEV;
-	}
-
-	count = pwrdm->state_counter[PWRDM_POWER_OFF];
-	count += pwrdm->ret_logic_off_counter;
-
-	for (i = 0; i < pwrdm->banks; i++)
-		count += pwrdm->ret_mem_off_counter[i];
-
-	/*
-	 * Context loss count has to be a non-negative value. Clear the sign
-	 * bit to get a value range from 0 to INT_MAX.
-	 */
-	count &= INT_MAX;
-
-	pr_debug("powerdomain: %s: context loss count = %d\n",
-		 pwrdm->name, count);
-
-	return count;
-}
-
-/**
- * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
- * @pwrdm: struct powerdomain *
- *
- * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
- * can lose either memory or logic context or if @pwrdm is invalid, or
- * returns 0 otherwise.  This function is not concerned with how the
- * powerdomain registers are programmed (i.e., to go off or not); it's
- * concerned with whether it's ever possible for this powerdomain to
- * go off while some other part of the chip is active.  This function
- * assumes that every powerdomain can go to either ON or INACTIVE.
- */
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
-{
-	int i;
-
-	if (!pwrdm) {
-		pr_debug("powerdomain: %s: invalid powerdomain pointer\n",
-			 __func__);
-		return true;
-	}
-
-	if (pwrdm->pwrsts & PWRSTS_OFF)
-		return true;
-
-	if (pwrdm->pwrsts & PWRSTS_RET) {
-		if (pwrdm->pwrsts_logic_ret & PWRSTS_OFF)
-			return true;
-
-		for (i = 0; i < pwrdm->banks; i++)
-			if (pwrdm->pwrsts_mem_ret[i] & PWRSTS_OFF)
-				return true;
-	}
-
-	for (i = 0; i < pwrdm->banks; i++)
-		if (pwrdm->pwrsts_mem_on[i] & PWRSTS_OFF)
-			return true;
-
-	return false;
-}
-
 /**
  * pwrdm_save_context - save powerdomain registers
  *
@@ -1250,25 +1174,6 @@ static int pwrdm_restore_context(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
-static int pwrdm_lost_power(struct powerdomain *pwrdm, void *unused)
-{
-	int state;
-
-	/*
-	 * Power has been lost across all powerdomains, increment the
-	 * counter.
-	 */
-
-	state = pwrdm_read_pwrst(pwrdm);
-	if (state != PWRDM_POWER_OFF) {
-		pwrdm->state_counter[state]++;
-		pwrdm->state_counter[PWRDM_POWER_OFF]++;
-	}
-	pwrdm->state = state;
-
-	return 0;
-}
-
 void pwrdms_save_context(void)
 {
 	pwrdm_for_each(pwrdm_save_context, NULL);
@@ -1278,8 +1183,3 @@ void pwrdms_restore_context(void)
 {
 	pwrdm_for_each(pwrdm_restore_context, NULL);
 }
-
-void pwrdms_lost_power(void)
-{
-	pwrdm_for_each(pwrdm_lost_power, NULL);
-}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 907cc659f47a..2eaabd94986f 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -243,8 +243,6 @@ int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
 int pwrdm_state_switch(struct powerdomain *pwrdm);
 int pwrdm_pre_transition(struct powerdomain *pwrdm);
 int pwrdm_post_transition(struct powerdomain *pwrdm);
-int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
 
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 state);
 
@@ -276,5 +274,4 @@ extern void pwrdm_unlock(struct powerdomain *pwrdm);
 extern void pwrdms_save_context(void);
 extern void pwrdms_restore_context(void);
 
-extern void pwrdms_lost_power(void);
 #endif
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_mpu44xx.c
index 5add541e3b41..7236c50388a8 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.c
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -35,18 +35,6 @@ void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 reg)
 	writel_relaxed(val, OMAP44XX_PRCM_MPU_REGADDR(inst, reg));
 }
 
-u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst, s16 reg)
-{
-	u32 v;
-
-	v = omap4_prcm_mpu_read_inst_reg(inst, reg);
-	v &= ~mask;
-	v |= bits;
-	omap4_prcm_mpu_write_inst_reg(v, inst, reg);
-
-	return v;
-}
-
 /**
  * omap2_set_globals_prcm_mpu - set the MPU PRCM base address (for early use)
  * @prcm_mpu: PRCM_MPU base virtual address
diff --git a/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h b/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
index 7c6377566f33..0c519447e790 100644
--- a/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
@@ -26,8 +26,6 @@ extern struct omap_domain_base prcm_mpu_base;
 
 extern u32 omap4_prcm_mpu_read_inst_reg(s16 inst, u16 idx);
 extern void omap4_prcm_mpu_write_inst_reg(u32 val, s16 inst, u16 idx);
-extern u32 omap4_prcm_mpu_rmw_inst_reg_bits(u32 mask, u32 bits, s16 inst,
-					    s16 idx);
 extern void __init omap2_set_globals_prcm_mpu(void __iomem *prcm_mpu);
 #endif
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 08df78810a5e..bad15ba5256c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -15,7 +15,6 @@
 # ifndef __ASSEMBLER__
 extern struct omap_domain_base prm_base;
 extern u16 prm_features;
-extern void omap2_set_globals_prm(void __iomem *prm);
 int omap_prcm_init(void);
 int omap2_prm_base_init(void);
 int omap2_prcm_base_init(void);
@@ -156,12 +155,10 @@ int omap_prm_assert_hardreset(u8 shift, u8 part, s16 prm_mod, u16 offset);
 int omap_prm_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 prm_mod,
 				u16 offset, u16 st_offset);
 int omap_prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset);
-extern u32 prm_read_reset_sources(void);
 extern bool prm_was_any_context_lost_old(u8 part, s16 inst, u16 idx);
 extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
 void omap_prm_reset_system(void);
 
-void omap_prm_reconfigure_io_chain(void);
 int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 
 /*
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index fb2d48cfe756..9a27f566612f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -344,41 +344,6 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 	return -ENOMEM;
 }
 
-/**
- * omap2_set_globals_prm - set the PRM base address (for early use)
- * @prm: PRM base virtual address
- *
- * XXX Will be replaced when the PRM/CM drivers are completed.
- */
-void __init omap2_set_globals_prm(void __iomem *prm)
-{
-	prm_base.va = prm;
-}
-
-/**
- * prm_read_reset_sources - return the sources of the SoC's last reset
- *
- * Return a u32 bitmask representing the reset sources that caused the
- * SoC to reset.  The low-level per-SoC functions called by this
- * function remap the SoC-specific reset source bits into an
- * OMAP-common set of reset source bits, defined in
- * arch/arm/mach-omap2/prm.h.  Returns the standardized reset source
- * u32 bitmask from the hardware upon success, or returns (1 <<
- * OMAP_UNKNOWN_RST_SRC_ID_SHIFT) if no low-level read_reset_sources()
- * function was registered.
- */
-u32 prm_read_reset_sources(void)
-{
-	u32 ret = 1 << OMAP_UNKNOWN_RST_SRC_ID_SHIFT;
-
-	if (prm_ll_data->read_reset_sources)
-		ret = prm_ll_data->read_reset_sources();
-	else
-		WARN_ONCE(1, "prm: %s: no mapping function defined for reset sources\n", __func__);
-
-	return ret;
-}
-
 /**
  * prm_was_any_context_lost_old - was device context lost? (old API)
  * @part: PRM partition ID (e.g., OMAP4430_PRM_PARTITION)
@@ -488,22 +453,6 @@ int omap_prm_is_hardreset_asserted(u8 shift, u8 part, s16 prm_mod, u16 offset)
 	return prm_ll_data->is_hardreset_asserted(shift, part, prm_mod, offset);
 }
 
-/**
- * omap_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
- *
- * Clear any previously-latched I/O wakeup events and ensure that the
- * I/O wakeup gates are aligned with the current mux settings.
- * Calls SoC specific I/O chain reconfigure function if available,
- * otherwise does nothing.
- */
-void omap_prm_reconfigure_io_chain(void)
-{
-	if (!prcm_irq_setup || !prcm_irq_setup->reconfigure_io_chain)
-		return;
-
-	prcm_irq_setup->reconfigure_io_chain();
-}
-
 /**
  * omap_prm_reset_system - trigger global SW reset
  *
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2be4106d0dd6..9900fc777f39 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -60,55 +60,6 @@ void omap2_sms_restore_context(void)
 	sms_write_reg(sms_context.sms_sysconfig, SMS_SYSCONFIG);
 }
 
-/**
- * omap2_sdrc_get_params - return SDRC register values for a given clock rate
- * @r: SDRC clock rate (in Hz)
- * @sdrc_cs0: chip select 0 ram timings **
- * @sdrc_cs1: chip select 1 ram timings **
- *
- * Return pre-calculated values for the SDRC_ACTIM_CTRLA,
- *  SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL and SDRC_MR registers in sdrc_cs[01]
- *  structs,for a given SDRC clock rate 'r'.
- * These parameters control various timing delays in the SDRAM controller
- *  that are expressed in terms of the number of SDRC clock cycles to
- *  wait; hence the clock rate dependency.
- *
- * Supports 2 different timing parameters for both chip selects.
- *
- * Note 1: the sdrc_init_params_cs[01] must be sorted rate descending.
- * Note 2: If sdrc_init_params_cs_1 is not NULL it must be of same size
- *  as sdrc_init_params_cs_0.
- *
- * Fills in the struct omap_sdrc_params * for each chip select.
- * Returns 0 upon success or -1 upon failure.
- */
-int omap2_sdrc_get_params(unsigned long r,
-			  struct omap_sdrc_params **sdrc_cs0,
-			  struct omap_sdrc_params **sdrc_cs1)
-{
-	struct omap_sdrc_params *sp0, *sp1;
-
-	if (!sdrc_init_params_cs0)
-		return -1;
-
-	sp0 = sdrc_init_params_cs0;
-	sp1 = sdrc_init_params_cs1;
-
-	while (sp0->rate && sp0->rate != r) {
-		sp0++;
-		if (sdrc_init_params_cs1)
-			sp1++;
-	}
-
-	if (!sp0->rate)
-		return -1;
-
-	*sdrc_cs0 = sp0;
-	*sdrc_cs1 = sp1;
-	return 0;
-}
-
-
 void __init omap2_set_globals_sdrc(void __iomem *sdrc, void __iomem *sms)
 {
 	omap2_sdrc_base = sdrc;
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 5bdb832665c0..5a44d64e3fbe 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -80,9 +80,6 @@ static inline void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 					  struct omap_sdrc_params *sdrc_cs1) {};
 #endif
 
-int omap2_sdrc_get_params(unsigned long r,
-			  struct omap_sdrc_params **sdrc_cs0,
-			  struct omap_sdrc_params **sdrc_cs1);
 void omap2_sms_save_context(void);
 void omap2_sms_restore_context(void);
 
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index ea02d40405c4..fc26b96a20cc 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -802,21 +802,6 @@ static u8 omap_vc_calc_vsel(struct voltagedomain *voltdm, u32 uvolt)
 	return voltdm->pmic->uv_to_vsel(uvolt);
 }
 
-#ifdef CONFIG_PM
-/**
- * omap_pm_setup_sr_i2c_pcb_length - set length of SR I2C traces on PCB
- * @mm: length of the PCB trace in millimetres
- *
- * Sets the PCB trace length for the I2C channel. By default uses 63mm.
- * This is needed for properly calculating the capacitance value for
- * the PCB trace, and for setting the SR I2C channel timing parameters.
- */
-void __init omap_pm_setup_sr_i2c_pcb_length(u32 mm)
-{
-	sr_i2c_pcb_length = mm;
-}
-#endif
-
 void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 {
 	struct omap_vc_channel *vc = voltdm->vc;
-- 
2.29.2

