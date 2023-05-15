Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A0703213
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242417AbjEOQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbjEOQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:03:09 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EE219D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:03:08 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2bOU004404;
        Mon, 15 May 2023 11:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684166557;
        bh=a5SYVmAok1YJ/oGVJSMi5rZ+H8GMZeDc8MDpgYsIOFo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=x2ziy4UcWjOdjut7GGuQ7suDqO7e/8U5nAx3tE4hSPfZOSdvJjCm2dj/VDJyPuy19
         c627qmKUAfAQFz7Qf75LBih6sOXLks2L/3XJE9FeSCTGg2rp2wZQT7OoWTkJm3K//g
         UkRd9Wa7ODBUDlkhRA+xigcj6h1SHO+pCDEOK+dM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FG2bqp034516
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:02:37 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:02:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:02:37 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FG2ZR2029578;
        Mon, 15 May 2023 11:02:36 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 03/10] ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
Date:   Mon, 15 May 2023 11:02:27 -0500
Message-ID: <20230515160234.289631-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515160234.289631-1-afd@ti.com>
References: <20230515160234.289631-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/Kconfig           | 2 --
 arch/arm/Kconfig.platforms | 8 ++++++++
 arch/arm/mach-rda/Kconfig  | 8 --------
 3 files changed, 8 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-rda/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5a047fd6b12a..62073a43933c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -434,8 +434,6 @@ source "arch/arm/mach-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
-source "arch/arm/mach-rda/Kconfig"
-
 source "arch/arm/mach-realtek/Kconfig"
 
 source "arch/arm/mach-rpc/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index b80a5b49d276..80f5b040e6ef 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -75,3 +75,11 @@ config MACH_ASM9260
 	select ASM9260_TIMER
 	help
 	  Support for Alphascale ASM9260 based platform.
+
+config ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select RDA_INTC
+	select RDA_TIMER
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
deleted file mode 100644
index 4d2e4e046cb3..000000000000
--- a/arch/arm/mach-rda/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_RDA
-	bool "RDA Micro SoCs"
-	depends on ARCH_MULTI_V7
-	select RDA_INTC
-	select RDA_TIMER
-	help
-	  This enables support for the RDA Micro 8810PL SoC family.
-- 
2.39.2

