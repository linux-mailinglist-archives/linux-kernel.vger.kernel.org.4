Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDCA60B39F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiJXRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiJXRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:12:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD7CA99C4;
        Mon, 24 Oct 2022 08:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A1FECE1894;
        Mon, 24 Oct 2022 15:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A04C433D6;
        Mon, 24 Oct 2022 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625922;
        bh=/8jDtxqnl7niHxk1zz2MXK8dHL5Pq5bCc9LHkJNr30I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4FcPe6GRX0jivqFMD74XeNvnwFNiURs8fNiV/vKYaFgx7vYR3WEBPSCLEgkNbvWO
         491qzoeG+G9I6/y0D6lm0ICTd0SDmVzUFY/1lZZhEHJUQXXdq5hHblk9XmRanZODoD
         3nw6/wo9CRw2fvrAwxpr2hqnwbxIVjzcd5iMbyPpt5rVP3SPMft7sgPgSQF+wpwZa9
         47Y1anE6NSBnPC0AbK2x4XCOLiWGDT4ZGCZ1wDwsDOZauKsKjpXuyUqAX+dxTZCI59
         VJeq7z9Y8OBQVeN52BbSJfjmzZkyMMLWSxE7eo/SSlNSECCGQ7ybIs06+siLIUN4hT
         X+1RZqHhEMsPg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/10] ARM: omap2: make functions static
Date:   Mon, 24 Oct 2022 17:38:14 +0200
Message-Id: <20221024153814.254652-11-arnd@kernel.org>
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

A number of functions are only called from the file they
are defined in, so remove the extern declarations and
make them local to those files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/board-n8x0.c                   |  2 +-
 arch/arm/mach-omap2/clockdomain.c                  |  4 ++--
 arch/arm/mach-omap2/clockdomain.h                  |  2 --
 arch/arm/mach-omap2/cm2xxx.c                       |  4 ++--
 arch/arm/mach-omap2/cm2xxx.h                       |  2 --
 arch/arm/mach-omap2/common.h                       |  2 --
 arch/arm/mach-omap2/id.c                           |  2 +-
 arch/arm/mach-omap2/id.h                           |  2 --
 arch/arm/mach-omap2/io.c                           |  2 +-
 arch/arm/mach-omap2/omap-secure.c                  |  2 +-
 arch/arm/mach-omap2/omap-secure.h                  |  2 --
 arch/arm/mach-omap2/omap_device.c                  | 14 ++++++++++----
 arch/arm/mach-omap2/omap_device.h                  |  9 ---------
 arch/arm/mach-omap2/omap_hwmod.c                   |  4 +++-
 arch/arm/mach-omap2/omap_hwmod.h                   |  1 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  6 +++---
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |  4 ----
 arch/arm/mach-omap2/pm.c                           |  2 +-
 arch/arm/mach-omap2/powerdomain.c                  |  8 ++++----
 arch/arm/mach-omap2/powerdomain.h                  |  3 ---
 arch/arm/mach-omap2/prcm-common.h                  |  1 -
 arch/arm/mach-omap2/prm.h                          |  1 -
 arch/arm/mach-omap2/prm3xxx.c                      |  5 +++--
 arch/arm/mach-omap2/prm3xxx.h                      |  2 --
 arch/arm/mach-omap2/prm_common.c                   |  4 ++--
 arch/arm/mach-omap2/sdrc.c                         |  2 +-
 arch/arm/mach-omap2/sdrc.h                         |  1 -
 arch/arm/mach-omap2/usb-tusb6010.c                 |  6 ++----
 arch/arm/mach-omap2/voltage.c                      |  2 +-
 arch/arm/mach-omap2/voltage.h                      |  1 -
 include/linux/platform_data/voltage-omap.h         |  1 -
 include/linux/usb/musb.h                           |  2 --
 33 files changed, 39 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 5e86145db0e2..eb21a4cc5e4d 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -505,7 +505,7 @@ static void __init n8x0_mmc_init(void)
 }
 #else
 static struct omap_mmc_platform_data mmc1_data;
-void __init n8x0_mmc_init(void)
+static void __init n8x0_mmc_init(void)
 {
 }
 #endif	/* CONFIG_MMC_OMAP */
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index f4e488e72515..d145e7ac709b 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -831,7 +831,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
  * -EINVAL if @clkdm is NULL or if clockdomain does not support
  * software-initiated sleep; 0 upon success.
  */
-int clkdm_sleep_nolock(struct clockdomain *clkdm)
+static int clkdm_sleep_nolock(struct clockdomain *clkdm)
 {
 	int ret;
 
@@ -885,7 +885,7 @@ int clkdm_sleep(struct clockdomain *clkdm)
  * -EINVAL if @clkdm is NULL or if the clockdomain does not support
  * software-controlled wakeup; 0 upon success.
  */
-int clkdm_wakeup_nolock(struct clockdomain *clkdm)
+static int clkdm_wakeup_nolock(struct clockdomain *clkdm)
 {
 	int ret;
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index a6bce3795a32..c36fb2721261 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -204,9 +204,7 @@ void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
 
-int clkdm_wakeup_nolock(struct clockdomain *clkdm);
 int clkdm_wakeup(struct clockdomain *clkdm);
-int clkdm_sleep_nolock(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
 
 int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 17833e0f22f8..1c6d69f4bf49 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -145,8 +145,8 @@ static int omap2xxx_cm_split_idlest_reg(struct clk_omap_reg *idlest_reg,
  * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
  * success or -EBUSY if the module doesn't enable in time.
  */
-int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
-				  u8 idlest_shift)
+static int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
+					 u8 idlest_shift)
 {
 	int ena = 0, i = 0;
 	u8 cm_idlest_reg;
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index ee0cb40691b2..7cbeff15ffb0 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -46,8 +46,6 @@
 extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
 extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
 
-int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
-				  u8 idlest_shift);
 extern int omap2xxx_cm_fclks_active(void);
 extern int omap2xxx_cm_mpu_retention_allowed(void);
 extern u32 omap2xxx_cm_get_core_clk_src(void);
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index ebf0266e1943..08034d589081 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -106,7 +106,6 @@ void omap2420_init_early(void);
 void omap2430_init_early(void);
 void omap3430_init_early(void);
 void omap3630_init_early(void);
-void omap3_init_early(void);	/* Do not use this one */
 void am33xx_init_early(void);
 void am35xx_init_early(void);
 void ti814x_init_early(void);
@@ -120,7 +119,6 @@ void omap4430_init_late(void);
 void ti81xx_init_late(void);
 void am33xx_init_late(void);
 void omap5_init_late(void);
-int omap2_common_pm_late_init(void);
 void dra7xx_init_early(void);
 void dra7xx_init_late(void);
 
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 59755b5a1ad7..98999aa8cc0c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -117,7 +117,7 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
-void omap_get_die_id(struct omap_die_id *odi)
+static void omap_get_die_id(struct omap_die_id *odi)
 {
 	if (soc_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx()) {
 		odi->id_0 = read_tap_reg(OMAP_TAP_DIE_ID_44XX_0);
diff --git a/arch/arm/mach-omap2/id.h b/arch/arm/mach-omap2/id.h
index d1735f4497e3..ded7392f0526 100644
--- a/arch/arm/mach-omap2/id.h
+++ b/arch/arm/mach-omap2/id.h
@@ -14,6 +14,4 @@ struct omap_die_id {
 	u32 id_3;
 };
 
-void omap_get_die_id(struct omap_die_id *odi);
-
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 81cb175c2dbe..14ec3f78000b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -461,7 +461,7 @@ void __init omap2430_init_early(void)
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
 #ifdef CONFIG_ARCH_OMAP3
-void __init omap3_init_early(void)
+static void __init omap3_init_early(void)
 {
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index 41aec5c93a70..29c7350b06ab 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -152,7 +152,7 @@ u32 omap3_save_secure_ram(void *addr, int size)
  * NOTE: rx51_secure_dispatcher differs from omap_secure_dispatcher because
  *       it calling omap_smc3() instead omap_smc2() and param[0] is nargs+1
  */
-u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
+static u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 			   u32 arg1, u32 arg2, u32 arg3, u32 arg4)
 {
 	static u32 param[5];
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 2ce26a86b7bd..2517c4a5a0e2 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -74,8 +74,6 @@ extern int omap_secure_ram_reserve_memblock(void);
 extern u32 save_secure_ram_context(u32 args_pa);
 extern u32 omap3_save_secure_ram(void *save_regs, int size);
 
-extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
-				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
 extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
 
diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 0594aaaa1a98..4afa2f08e668 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -39,6 +39,12 @@
 #include "omap_device.h"
 #include "omap_hwmod.h"
 
+static struct omap_device *omap_device_alloc(struct platform_device *pdev,
+				struct omap_hwmod **ohs, int oh_cnt);
+static void omap_device_delete(struct omap_device *od);
+static struct dev_pm_domain omap_device_fail_pm_domain;
+static struct dev_pm_domain omap_device_pm_domain;
+
 /* Private functions */
 
 static void _add_clkdev(struct omap_device *od, const char *clk_alias,
@@ -296,7 +302,7 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
  *
  * Returns an struct omap_device pointer or ERR_PTR() on error;
  */
-struct omap_device *omap_device_alloc(struct platform_device *pdev,
+static struct omap_device *omap_device_alloc(struct platform_device *pdev,
 					struct omap_hwmod **ohs, int oh_cnt)
 {
 	int ret = -ENOMEM;
@@ -333,7 +339,7 @@ struct omap_device *omap_device_alloc(struct platform_device *pdev,
 	return ERR_PTR(ret);
 }
 
-void omap_device_delete(struct omap_device *od)
+static void omap_device_delete(struct omap_device *od)
 {
 	if (!od)
 		return;
@@ -425,14 +431,14 @@ static int _od_resume_noirq(struct device *dev)
 #define _od_resume_noirq NULL
 #endif
 
-struct dev_pm_domain omap_device_fail_pm_domain = {
+static struct dev_pm_domain omap_device_fail_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_fail_runtime_suspend,
 				   _od_fail_runtime_resume, NULL)
 	}
 };
 
-struct dev_pm_domain omap_device_pm_domain = {
+static struct dev_pm_domain omap_device_pm_domain = {
 	.ops = {
 		SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
 				   NULL)
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 455f0a2b43ee..aa8096ecb23c 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -25,9 +25,6 @@
 
 #include "omap_hwmod.h"
 
-extern struct dev_pm_domain omap_device_pm_domain;
-extern struct dev_pm_domain omap_device_fail_pm_domain;
-
 /* omap_device._state values */
 #define OMAP_DEVICE_STATE_UNKNOWN	0
 #define OMAP_DEVICE_STATE_ENABLED	1
@@ -66,12 +63,6 @@ struct omap_device {
 int omap_device_enable(struct platform_device *pdev);
 int omap_device_idle(struct platform_device *pdev);
 
-/* Core code interface */
-
-struct omap_device *omap_device_alloc(struct platform_device *pdev,
-				      struct omap_hwmod **ohs, int oh_cnt);
-void omap_device_delete(struct omap_device *od);
-
 /* Other */
 
 int omap_device_assert_hardreset(struct platform_device *pdev,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b03be626bc99..5a2a9b8e61ed 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3054,6 +3054,8 @@ int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois)
 	return 0;
 }
 
+static int __init omap_hwmod_setup_one(const char *oh_name);
+
 /**
  * _ensure_mpu_hwmod_is_setup - ensure the MPU SS hwmod is init'ed and set up
  * @oh: pointer to the hwmod currently being set up (usually not the MPU)
@@ -3084,7 +3086,7 @@ static void __init _ensure_mpu_hwmod_is_setup(struct omap_hwmod *oh)
  * registered omap_hwmod.  Also calls _setup() on each hwmod.  Returns
  * -EINVAL upon error or 0 upon success.
  */
-int __init omap_hwmod_setup_one(const char *oh_name)
+static int __init omap_hwmod_setup_one(const char *oh_name)
 {
 	struct omap_hwmod *oh;
 
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index b6b53170ad1e..dcab7a01c10e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -615,7 +615,6 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
 
-int __init omap_hwmod_setup_one(const char *name);
 int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 				  struct device_node *np,
 				  struct resource *res);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 2581b8a5f866..67f1f38909d9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -62,7 +62,7 @@ struct omap_hwmod_class iva_hwmod_class = {
 	.name = "iva",
 };
 
-struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
+static struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x14,
 	.syss_offs	= 0x18,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 9ab1d57f8b73..4982e04ead53 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -30,7 +30,7 @@ static struct omap_hwmod_class_sysconfig omap2_dispc_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-struct omap_hwmod_class omap2_dispc_hwmod_class = {
+static struct omap_hwmod_class omap2_dispc_hwmod_class = {
 	.name	= "dispc",
 	.sysc	= &omap2_dispc_sysc,
 };
@@ -47,7 +47,7 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-struct omap_hwmod_class omap2xxx_timer_hwmod_class = {
+static struct omap_hwmod_class omap2xxx_timer_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap2xxx_timer_sysc,
 };
@@ -67,7 +67,7 @@ static struct omap_hwmod_class_sysconfig omap2xxx_wd_timer_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class = {
+static struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap2xxx_wd_timer_sysc,
 	.pre_shutdown	= &omap2_wd_timer_disable,
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index e0d65ad65614..69dddc53e1d8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -84,14 +84,10 @@ extern struct omap_hwmod_class mpu_hwmod_class;
 extern struct omap_hwmod_class iva_hwmod_class;
 extern struct omap_hwmod_class omap2_uart_class;
 extern struct omap_hwmod_class omap2_dss_hwmod_class;
-extern struct omap_hwmod_class omap2_dispc_hwmod_class;
 extern struct omap_hwmod_class omap2_rfbi_hwmod_class;
 extern struct omap_hwmod_class omap2_venc_hwmod_class;
-extern struct omap_hwmod_class_sysconfig omap2_hdq1w_sysc;
 extern struct omap_hwmod_class omap2_hdq1w_class;
 
-extern struct omap_hwmod_class omap2xxx_timer_hwmod_class;
-extern struct omap_hwmod_class omap2xxx_wd_timer_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_gpio_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_mailbox_hwmod_class;
 extern struct omap_hwmod_class omap2xxx_mcspi_class;
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 53a132f11961..700869c9eae1 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -134,7 +134,7 @@ int __maybe_unused omap_pm_nop_init(void)
 
 int (*omap_pm_soc_init)(void);
 
-int __init omap2_common_pm_late_init(void)
+static int __init omap2_common_pm_late_init(void)
 {
 	int error;
 
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 0155a1e57a87..fd974514a7b2 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -37,8 +37,8 @@
 
 #define PWRDM_TRACE_STATES_FLAG	(1<<31)
 
-void pwrdms_save_context(void);
-void pwrdms_restore_context(void);
+static void pwrdms_save_context(void);
+static void pwrdms_restore_context(void);
 
 enum {
 	PWRDM_STATE_NOW = 0,
@@ -1174,12 +1174,12 @@ static int pwrdm_restore_context(struct powerdomain *pwrdm, void *unused)
 	return 0;
 }
 
-void pwrdms_save_context(void)
+static void pwrdms_save_context(void)
 {
 	pwrdm_for_each(pwrdm_save_context, NULL);
 }
 
-void pwrdms_restore_context(void)
+static void pwrdms_restore_context(void)
 {
 	pwrdm_for_each(pwrdm_restore_context, NULL);
 }
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 4c5284d0fd62..fbc89999460b 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -269,7 +269,4 @@ extern struct powerdomain gfx_omap2_pwrdm;
 extern void pwrdm_lock(struct powerdomain *pwrdm);
 extern void pwrdm_unlock(struct powerdomain *pwrdm);
 
-extern void pwrdms_save_context(void);
-extern void pwrdms_restore_context(void);
-
 #endif
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 48e804c93caf..5e3544a63526 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -550,7 +550,6 @@ struct omap_prcm_init_data {
 	struct device_node *np;
 };
 
-extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
 extern int omap_prcm_event_to_irq(const char *event);
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index bad15ba5256c..fc45a7ed09bb 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -16,7 +16,6 @@
 extern struct omap_domain_base prm_base;
 extern u16 prm_features;
 int omap_prcm_init(void);
-int omap2_prm_base_init(void);
 int omap2_prcm_base_init(void);
 # endif
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 63e73e9b82bc..1b5d08f594aa 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -32,6 +32,7 @@ static void omap3xxx_prm_read_pending_irqs(unsigned long *events);
 static void omap3xxx_prm_ocp_barrier(void);
 static void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
 static void omap3xxx_prm_restore_irqen(u32 *saved_mask);
+static void omap3xxx_prm_iva_idle(void);
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -268,7 +269,7 @@ static int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
  * Toggles the reset signal to modem IP block. Required to allow
  * OMAP3430 without stacked modem to idle properly.
  */
-void __init omap3_prm_reset_modem(void)
+static void __init omap3_prm_reset_modem(void)
 {
 	omap2_prm_write_mod_reg(
 		OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
@@ -469,7 +470,7 @@ static u32 omap3xxx_prm_read_reset_sources(void)
  * function forces the IVA2 into idle state so it can go
  * into retention/off and thus allow full-chip retention/off.
  */
-void omap3xxx_prm_iva_idle(void)
+static void omap3xxx_prm_iva_idle(void)
 {
 	/* ensure IVA2 clock is disabled */
 	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index ed7c389aa5a7..ab899e461c62 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -138,8 +138,6 @@ extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 int __init omap3xxx_prm_init(const struct omap_prcm_init_data *data);
-void omap3xxx_prm_iva_idle(void);
-void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
 void omap3_prm_save_scratchpad_contents(u32 *ptr);
 void omap3_prm_init_pm(bool has_uart4, bool has_iva);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 9a27f566612f..fd896f2295a1 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -187,7 +187,7 @@ int omap_prcm_event_to_irq(const char *name)
  *
  * No return value.
  */
-void omap_prcm_irq_cleanup(void)
+static void omap_prcm_irq_cleanup(void)
 {
 	unsigned int irq;
 	int i;
@@ -689,7 +689,7 @@ static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
  * on the DT data. Returns 0 in success, negative error value
  * otherwise.
  */
-int __init omap2_prm_base_init(void)
+static int __init omap2_prm_base_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 9900fc777f39..b1bf9e24d442 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -45,7 +45,7 @@ static struct omap2_sms_regs sms_context;
  *
  * Save SMS registers that need to be restored after off mode.
  */
-void omap2_sms_save_context(void)
+static void omap2_sms_save_context(void)
 {
 	sms_context.sms_sysconfig = sms_read_reg(SMS_SYSCONFIG);
 }
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 07ff33b006a7..45b35422b587 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -80,7 +80,6 @@ static inline void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 					  struct omap_sdrc_params *sdrc_cs1) {};
 #endif
 
-void omap2_sms_save_context(void);
 void omap2_sms_restore_context(void);
 
 struct memory_timings {
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index a0c4c42e56b9..18fa52f828dc 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -97,7 +97,7 @@ static int tusb_set_sync_mode(unsigned sysclk_ps)
 }
 
 /* tusb driver calls this when it changes the chip's clocking */
-int tusb6010_platform_retime(unsigned is_refclk)
+static int tusb6010_platform_retime(unsigned is_refclk)
 {
 	static const char	error[] =
 		KERN_ERR "tusb6010 %s retime error %d\n";
@@ -121,7 +121,6 @@ int tusb6010_platform_retime(unsigned is_refclk)
 done:
 	return status;
 }
-EXPORT_SYMBOL_GPL(tusb6010_platform_retime);
 
 static struct resource tusb_resources[] = {
 	/* Order is significant!  The start/end fields
@@ -154,8 +153,7 @@ static struct platform_device tusb_device = {
 
 
 /* this may be called only from board-*.c setup code */
-int __init
-tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
+int __init tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		unsigned ps_refclk, unsigned waitpin,
 		unsigned async, unsigned sync,
 		unsigned irq, unsigned dmachan)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 0a0c771dbb0a..49e8bc69abdd 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -67,7 +67,7 @@ unsigned long voltdm_get_voltage(struct voltagedomain *voltdm)
  * This API should be called by the kernel to do the voltage scaling
  * for a particular voltage domain during DVFS.
  */
-int voltdm_scale(struct voltagedomain *voltdm,
+static int voltdm_scale(struct voltagedomain *voltdm,
 		 unsigned long target_volt)
 {
 	int ret, i;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 5beb91ce3b38..e610f63a020d 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -163,7 +163,6 @@ extern void omap54xx_voltagedomains_init(void);
 
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
-int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 void voltdm_reset(struct voltagedomain *voltdm);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 #endif
diff --git a/include/linux/platform_data/voltage-omap.h b/include/linux/platform_data/voltage-omap.h
index 43e8da9fb447..6d74e507dbd2 100644
--- a/include/linux/platform_data/voltage-omap.h
+++ b/include/linux/platform_data/voltage-omap.h
@@ -29,7 +29,6 @@ struct omap_volt_data {
 struct voltagedomain;
 
 struct voltagedomain *voltdm_lookup(const char *name);
-int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index fc6c77918481..e4a3ad3c800f 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -143,8 +143,6 @@ extern int __init tusb6010_setup_interface(
 		unsigned async_cs, unsigned sync_cs,
 		unsigned irq, unsigned dmachan);
 
-extern int tusb6010_platform_retime(unsigned is_refclk);
-
 #endif	/* OMAP2 */
 
 #endif /* __LINUX_USB_MUSB_H */
-- 
2.29.2

