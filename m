Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EE9718806
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjEaRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEaRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:05:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F2194;
        Wed, 31 May 2023 10:04:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so7831071a12.2;
        Wed, 31 May 2023 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685552693; x=1688144693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItgjmlwgaPjP4wHyJ733O7/dyXG5xBnA6V2QKEkRMU0=;
        b=Kd4anC3X23dnlVDhbx8F1bdolSDzOlmYUDiJPONeS3X5n7Wfwnbk1VysYxbvvoyZCE
         RvePrIGlZbuBEWYomBAgnAZ1JMkMEfLC+PORMTum8dDfwNvDmPESqAgC3A/n2zFBIvrv
         oIHEjLEI3ANbKTN7WPlcv430Li72dMlgFHqCIHRVgRJW+ExWc+nagMqQzQcJocizr7tw
         4T/POxszZKhuFZTf+KE0zKpRK8xT6paGvHMUIuEumxwAsJ0vOaNFWr70nxxsT/ybcYoA
         RRddtjY/eDHptJX4zwvqh108lFXGvFEJwv2xThpcD0UlmEdlu8QJt+MiOYh7SwPB8Gau
         Y8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552693; x=1688144693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItgjmlwgaPjP4wHyJ733O7/dyXG5xBnA6V2QKEkRMU0=;
        b=MZyytg16Kkkr+EtAwYMJZnZ5W6xDKWRTd+/GOxuJ66sGc6lzaMDPpIVXeKTdwWPWYr
         4UP5bWFicWsgF//TYOR1ipQsDEt5VvkC5Qlv9rulj0Q/s9TszyPPfj+iEul1NdkXqgwe
         X5/HKt+WHv84mMcTGG3GmiY3FmTn5/aSY+gQPGpg+zlqX8MH1Izv/coF6AzuYtwRRmm2
         L22rKf77HxtYkD7Y06IivpErXF8FLVAB/ibznggdyH4mmUu8HoCugpmfN2mUEIDDQ2sH
         8oku7+VmZEqmI45aZYEaOpjR3i6X340IfSbFl9gHc5+bDpSJ0TMdORFFL552KdEPlxB9
         s81g==
X-Gm-Message-State: AC+VfDz8gsAGdVl20zhz6dSXv0J7uGliopn85y+N8jnL2b231kgoXFUC
        KvUzA4M0Lnr3VJD2Wont4KKyMZwbiz8A5Q==
X-Google-Smtp-Source: ACHHUZ6vWDWfy0zkZs76a944F2SHpEHsRKFsfrMiY89pZFOnWVB8OsAHKSW+F+SBvUpZOdQfL73mqQ==
X-Received: by 2002:a17:907:9722:b0:95e:d448:477 with SMTP id jg34-20020a170907972200b0095ed4480477mr6198434ejc.33.1685552693337;
        Wed, 31 May 2023 10:04:53 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810a:9640:26a8:d56e:8fdf:f926:4676])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906118600b0094f282fc29asm9189406eja.207.2023.05.31.10.04.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 31 May 2023 10:04:52 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
X-Google-Original-From: Franziska Naepelt <franziska.naepelt@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     tony@atomide.com, paul@pwsan.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: [PATCH] ARM: omap2: Fix checkpatch issues
Date:   Wed, 31 May 2023 19:04:27 +0200
Message-Id: <20230531170427.42199-1-franziska.naepelt@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch issues have been resolved:

arch/arm/mach-omap2/omap-wakeupgen.c
WARNING: Missing a blank line after declarations

arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
ERROR: space prohibited before that ',' (ctx:WxE)
WARNING: Use lore.kernel.org archive links when possible

arch/arm/mach-omap2/omap_phy_internal.c
WARNING: Block comments should align the * on each line

arch/arm/mach-omap2/sdrc2xxx.c
WARNING: It's generally not useful to have the filename in the file

arch/arm/mach-omap2/ti81xx-restart.c
ERROR: trailing statements should be on next line

Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c       |  1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 11 +++++------
 arch/arm/mach-omap2/omap_phy_internal.c    | 12 ++++++------
 arch/arm/mach-omap2/sdrc2xxx.c             |  2 --
 arch/arm/mach-omap2/ti81xx-restart.c       |  3 ++-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 8d21e3a3c05f..6f0d6120c174 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -374,6 +374,7 @@ static void irq_restore_context(void)
 static void irq_save_secure_context(void)
 {
 	u32 ret;
+
 	ret = omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
 				FLAG_START_CRITICAL,
 				0, 0, 0, 0, 0);
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index cb33f0382a90..5cbdf58ad59f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1851,7 +1851,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi = {
 	.fw = {
 		.omap2 = {
 			.l4_fw_region  = OMAP3_L4_CORE_FW_DSS_RFBI_REGION,
-			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP ,
+			.l4_prot_group = OMAP3_L4_CORE_FW_DSS_PROT_GROUP,
 			.flags	= OMAP_FIREWALL_L4,
 		},
 	},
@@ -2172,7 +2172,7 @@ static struct omap_hwmod am35xx_emac_hwmod = {
 	/*
 	 * According to Mark Greer, the MPU will not return from WFI
 	 * when the EMAC signals an interrupt.
-	 * http://www.spinics.net/lists/arm-kernel/msg174734.html
+	 * https://lore.kernel.org/all/1336770778-23044-3-git-send-email-mgreer@animalcreek.com/
 	 */
 	.flags		= (HWMOD_NO_IDLEST | HWMOD_BLOCK_WFI),
 };
@@ -2346,13 +2346,12 @@ static struct omap_hwmod_ocp_if *omap36xx_sham_hwmod_ocp_ifs[] __initdata = {
 	NULL
 };
 
-
 /*
  * Apparently the SHA/MD5 and AES accelerator IP blocks are
  * only present on some AM35xx chips, and no one knows which
- * ones.  See
- * http://www.spinics.net/lists/arm-kernel/msg215466.html So
- * if you need these IP blocks on an AM35xx, try uncommenting
+ * ones.
+ * See https://lore.kernel.org/all/20130108203853.GB1876@animalcreek.com/
+ * So if you need these IP blocks on an AM35xx, try uncommenting
  * the following lines.
  */
 static struct omap_hwmod_ocp_if *am35xx_sham_hwmod_ocp_ifs[] __initdata = {
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 21c6e7929d37..a1d001170a68 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
-  * This file configures the internal USB PHY in OMAP4430. Used
-  * with TWL6030 transceiver and MUSB on OMAP4430.
-  *
-  * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com
-  * Author: Hema HK <hemahk@ti.com>
-  */
+ * This file configures the internal USB PHY in OMAP4430. Used
+ * with TWL6030 transceiver and MUSB on OMAP4430.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com
+ * Author: Hema HK <hemahk@ti.com>
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 529d46cfdea2..5a275b4fd404 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/arch/arm/mach-omap2/sdrc2xxx.c
- *
  * SDRAM timing related functions for OMAP2xxx
  *
  * Copyright (C) 2005, 2008 Texas Instruments Inc.
diff --git a/arch/arm/mach-omap2/ti81xx-restart.c b/arch/arm/mach-omap2/ti81xx-restart.c
index d6dc518b1dde..5b5fb37caa50 100644
--- a/arch/arm/mach-omap2/ti81xx-restart.c
+++ b/arch/arm/mach-omap2/ti81xx-restart.c
@@ -26,5 +26,6 @@ void ti81xx_restart(enum reboot_mode mode, const char *cmd)
 {
 	omap2_prm_set_mod_reg_bits(TI81XX_GLOBAL_RST_COLD, 0,
 				   TI81XX_PRM_DEVICE_RSTCTRL);
-	while (1);
+	while (1)
+		;
 }

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.39.2 (Apple Git-143)

