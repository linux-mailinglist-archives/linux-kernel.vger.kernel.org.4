Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91BE60B372
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiJXRFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiJXREV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:04:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C3A50ED;
        Mon, 24 Oct 2022 08:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BDD8B811C2;
        Mon, 24 Oct 2022 15:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E3DC433D6;
        Mon, 24 Oct 2022 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625919;
        bh=X4rAnmFhah1kdNXPF3V+U8K+wcI+iCdD1LhiLBT7mcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IM40F2Kn8KW7Qu7s3UPXy+FWfIPtUCy7+ezMMTPZlSUc1Q1Os9kpNZ05aJa277MfH
         4t+73plmZGQr1TZcV7DsOdqu47DagMowuSo94NzU1/OUJtPVT4QlsSqY0SPeTAJxEI
         L3ddREKv39497rTXG4Ue28+HkIH+FY97ZTdb34d/XE+ofW+RQR1Vug7s5wqB1VRv9b
         RZIljHyMS5AlqCBvD/yS4HtzdlHLfbU+QXo6ba4zJheFBiKpdFOuoIRjwVl/uwGbRt
         qORLmNXL2hKaYvH4pnbcwGqo3kjz3krFRxcG/YLmHZmf7ITTAwKOu3CjFrJtS3U47S
         jNihgJLOANPEw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/10] ARM: omap2: remove unused declarations
Date:   Mon, 24 Oct 2022 17:38:12 +0200
Message-Id: <20221024153814.254652-9-arnd@kernel.org>
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

These functions were removed at some point in the
past, but the extraneous declarations were left behind.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/clock.h                  |  5 -----
 arch/arm/mach-omap2/common.h                 | 11 -----------
 arch/arm/mach-omap2/omap_hwmod.h             |  9 ---------
 arch/arm/mach-omap2/omap_hwmod_common_data.h |  1 -
 arch/arm/mach-omap2/omap_opp_data.h          |  5 -----
 arch/arm/mach-omap2/pm.h                     | 18 ------------------
 arch/arm/mach-omap2/powerdomain.h            |  2 --
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |  3 ---
 arch/arm/mach-omap2/sdrc.h                   |  1 -
 arch/arm/mach-omap2/sram.h                   |  4 ----
 arch/arm/mach-omap2/voltage.h                |  1 -
 11 files changed, 60 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f365614405e8..41391fa1418a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -63,11 +63,6 @@
 
 extern struct ti_clk_ll_ops omap_clk_ll_ops;
 
-extern const struct clkops clkops_omap2_dflt_wait;
-extern const struct clkops clkops_omap2_dflt;
-
-extern struct clk_functions omap2_clk_functions;
-
 int __init omap2_clk_setup_ll_ops(void);
 
 void __init ti_clk_init_features(void);
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 415ca353a345..112e7966107c 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -87,12 +87,6 @@ static inline int amx3_common_pm_init(void)
 }
 #endif
 
-extern void omap2_init_common_infrastructure(void);
-
-extern void omap_init_time(void);
-extern void omap3_secure_sync32k_timer_init(void);
-extern void omap3_gptimer_timer_init(void);
-extern void omap4_local_timer_init(void);
 #ifdef CONFIG_CACHE_L2X0
 int omap_l2_cache_init(void);
 #define OMAP_L2C_AUX_CTRL	(L2C_AUX_CTRL_SHARED_OVERRIDE | \
@@ -229,11 +223,6 @@ void __init ti81xx_map_io(void);
 	}							\
 })
 
-extern struct device *omap2_get_mpuss_device(void);
-extern struct device *omap2_get_iva_device(void);
-extern struct device *omap2_get_l3_device(void);
-extern struct device *omap4_get_dsp_device(void);
-
 void omap_gic_of_init(void);
 
 #ifdef CONFIG_CACHE_L2X0
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 3fa6d217ab83..b6b53170ad1e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -638,11 +638,6 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
 int omap_hwmod_softreset(struct omap_hwmod *oh);
 
-int omap_hwmod_count_resources(struct omap_hwmod *oh, unsigned long flags);
-int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
-int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
-				   const char *name, struct resource *res);
-
 void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
 
 int omap_hwmod_for_each_by_class(const char *classname,
@@ -672,12 +667,8 @@ omap_hwmod_for_each_by_class(const char *classname,
 extern int omap2420_hwmod_init(void);
 extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
-extern int omap44xx_hwmod_init(void);
-extern int am33xx_hwmod_init(void);
 extern int dm814x_hwmod_init(void);
 extern int dm816x_hwmod_init(void);
-extern int dra7xx_hwmod_init(void);
-int am43xx_hwmod_init(void);
 
 extern int __init omap_hwmod_register_links(struct omap_hwmod_ocp_if **ois);
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index c8eb1e6cc4a9..e0d65ad65614 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -59,7 +59,6 @@ extern struct omap_hwmod_ocp_if omap2_l4_core__uart2;
 extern struct omap_hwmod_ocp_if omap2_l4_core__uart3;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi1;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__mcspi2;
-extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer2;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer3;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer4;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__timer5;
diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap2/omap_opp_data.h
index 88375ab38e31..ed84fe95e857 100644
--- a/arch/arm/mach-omap2/omap_opp_data.h
+++ b/arch/arm/mach-omap2/omap_opp_data.h
@@ -71,11 +71,6 @@ struct omap_opp_def {
 	.vp_errgain	= _errgain				       \
 }
 
-/* Use this to initialize the default table */
-extern int __init omap_init_opp_table(struct omap_opp_def *opp_def,
-		u32 opp_def_size);
-
-
 extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
 extern struct omap_volt_data omap34xx_vddcore_volt_data[];
 extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0c95774a4b8f..90a341b0369c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -32,20 +32,6 @@ extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 
-#if defined(CONFIG_PM_OPP)
-extern int omap3_opp_init(void);
-extern int omap4_opp_init(void);
-#else
-static inline int omap3_opp_init(void)
-{
-	return -EINVAL;
-}
-static inline int omap4_opp_init(void)
-{
-	return -EINVAL;
-}
-#endif
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
@@ -58,9 +44,6 @@ extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #endif /* CONFIG_PM_DEBUG */
 
 /* 24xx */
-extern void omap24xx_idle_loop_suspend(void);
-extern unsigned int omap24xx_idle_loop_suspend_sz;
-
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
 extern unsigned int omap24xx_cpu_suspend_sz;
@@ -120,7 +103,6 @@ static inline int omap_devinit_smartreflex(void)
 #ifdef CONFIG_TWL4030_CORE
 extern int omap3_twl_init(void);
 extern int omap4_twl_init(void);
-extern int omap3_twl_set_sr_bit(bool enable);
 #else
 static inline int omap3_twl_init(void)
 {
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 2eaabd94986f..4c5284d0fd62 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -208,8 +208,6 @@ struct powerdomain *pwrdm_lookup(const char *name);
 
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
 			void *user);
-int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
 
 int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 3d803f7182b9..bc263d564acc 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -104,9 +104,6 @@ int omap2_prm_deassert_hardreset(u8 rst_shift, u8 st_shift, u8 part,
 				 s16 prm_mod, u16 reset_offset,
 				 u16 st_offset);
 
-extern int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
-extern int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
-extern int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm);
 extern int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
 				    u8 pwrst);
 extern int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
index 5a44d64e3fbe..07ff33b006a7 100644
--- a/arch/arm/mach-omap2/sdrc.h
+++ b/arch/arm/mach-omap2/sdrc.h
@@ -92,7 +92,6 @@ struct memory_timings {
 };
 
 extern void omap2xxx_sdrc_init_params(u32 force_lock_to_unlock_mode);
-struct omap_sdrc_params *rx51_get_sdram_timings(void);
 
 u32 omap2xxx_sdrc_dll_is_unlocked(void);
 u32 omap2xxx_sdrc_reprogram(u32 level, u32 force);
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
index 271062f23482..030cabc39821 100644
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -17,10 +17,6 @@ extern int __init omap_sram_init(void);
 
 extern void *omap_sram_push(void *funcp, unsigned long size);
 
-/* Do not use these */
-extern void omap24xx_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
-extern unsigned long omap24xx_sram_reprogram_clock_sz;
-
 extern void omap242x_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 						u32 base_cs, u32 force_unlock);
 extern unsigned long omap242x_sram_ddr_init_sz;
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 4a225f9559a5..5beb91ce3b38 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -163,7 +163,6 @@ extern void omap54xx_voltagedomains_init(void);
 
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
-int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
 int voltdm_scale(struct voltagedomain *voltdm, unsigned long target_volt);
 void voltdm_reset(struct voltagedomain *voltdm);
 unsigned long voltdm_get_voltage(struct voltagedomain *voltdm);
-- 
2.29.2

