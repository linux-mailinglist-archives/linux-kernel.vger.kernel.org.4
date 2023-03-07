Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF756ADCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjCGK6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCGK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:57:27 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C657D2C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=EgRYxIWHZ7WvvS
        /wukMqhYX6E2H5FLC+31Yzk20AgfI=; b=wjy2rUXe8hyVkU+d3o1cECrY4sCl58
        ydyLd6Tf9l/e4BglMoSu2s5K81W5D9ug8GHUpCe2MX+G9FZ4ZEUy45WvKdovNTrv
        TYEyI0662EDoPSjhlIy/oHQ+rfmailIC6a3DZoeqR+aLkHJx765aAYDuLxR5El4u
        MO922NFjMmYaA=
Received: (qmail 651044 invoked from network); 7 Mar 2023 11:57:09 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 11:57:09 +0100
X-UD-Smtp-Session: l3s3148p1@Q7njRU32ho4gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] soc: renesas: remove r8a77950 arch
Date:   Tue,  7 Mar 2023 11:56:41 +0100
Message-Id: <20230307105645.5285-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Remove the architecture which describes H3 ES1.*.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/configs/defconfig      | 1 -
 drivers/soc/renesas/Kconfig       | 7 -------
 drivers/soc/renesas/renesas-soc.c | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..ef88f86fbfda 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1217,7 +1217,6 @@ CONFIG_QCOM_APR=m
 CONFIG_QCOM_ICC_BWMON=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
-CONFIG_ARCH_R8A77950=y
 CONFIG_ARCH_R8A77951=y
 CONFIG_ARCH_R8A77965=y
 CONFIG_ARCH_R8A77960=y
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 4e8b51ba2266..de31589ed054 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -206,13 +206,6 @@ config ARCH_R8A77990
 	  This enables support for the Renesas R-Car E3 SoC.
 	  This includes different gradings like R-Car E3e.
 
-config ARCH_R8A77950
-	bool "ARM64 Platform support for R-Car H3 ES1.x"
-	select ARCH_RCAR_GEN3
-	select SYSC_R8A7795
-	help
-	  This enables support for the Renesas R-Car H3 SoC (revision 1.x).
-
 config ARCH_R8A77951
 	bool "ARM64 Platform support for R-Car H3 ES2.0+"
 	select ARCH_RCAR_GEN3
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 468ebce1ea88..66ff1c25f85f 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -330,7 +330,7 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7794
 	{ .compatible = "renesas,r8a7794",	.data = &soc_rcar_e2 },
 #endif
-#if defined(CONFIG_ARCH_R8A77950) || defined(CONFIG_ARCH_R8A77951)
+#if defined(CONFIG_ARCH_R8A77951)
 	{ .compatible = "renesas,r8a7795",	.data = &soc_rcar_h3 },
 #endif
 #ifdef CONFIG_ARCH_R8A77951
-- 
2.35.1

