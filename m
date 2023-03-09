Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4C6B1FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCIJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:24:03 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 952959E06E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:23:59 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 5CB275E8A4;
        Thu,  9 Mar 2023 10:23:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1678353790;
        bh=sd04NTeCyb0/6E7DEbJMGVnu1ZcGer6SjsSPJ/aAXAg=;
        h=From:To:CC:Subject:Date:From;
        b=JyildWqJkCSXn+K14kV2hkM5TH3gpdJUuLnP9dvRL9NTYyisk7mRSrM1tdf3gai0k
         9sRgwzTgNjSC5SmkzmWSzYl58htBu59gtECAtmnJUf8pjtXixnTm0GtYT4bnjvuzoV
         RBXoYpVF+2vZVWFHp4fTWfu8EgJHjsBgM1a5ahjkEBGq0O8hwb0cTqgmA9DO6crADW
         3nBWg8RRReDdvdZCjUdhTR6oO3YTm/Vb1lEMwUng5YtLrHuncFWUVmWawF2/dTITc5
         g7trOTswK3noRl6oqwo9s9Bo5qu36jUKd1W+qplqJ/I17beX3aok9oZBvuVayz6x/C
         XnwVzZYGeh9Ow==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 10:22:56 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 10:22:56 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 1/3] mfd: da9062: Use MFD_CELL_OF macro
Date:   Thu, 9 Mar 2023 10:22:52 +0100
Message-ID: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use MFD_CELL_OF macro helper instead of plain struct properties, which makes
the code a bit shorter and to have commonly defined MFD cell attributes.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V3: - Add this patch to the series
V4: - Rebase on current next 20230309
    - Add Acked-by tag
---
 drivers/mfd/da9062-core.c | 92 +++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 68 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 40cde51e5719..9418c58c2b06 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -182,34 +182,16 @@ static const struct resource da9061_onkey_resources[] = {
 };
 
 static const struct mfd_cell da9061_devs[] = {
-	{
-		.name		= "da9061-core",
-		.num_resources	= ARRAY_SIZE(da9061_core_resources),
-		.resources	= da9061_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9061_regulators_resources),
-		.resources	= da9061_regulators_resources,
-	},
-	{
-		.name		= "da9061-watchdog",
-		.num_resources	= ARRAY_SIZE(da9061_wdt_resources),
-		.resources	= da9061_wdt_resources,
-		.of_compatible  = "dlg,da9061-watchdog",
-	},
-	{
-		.name		= "da9061-thermal",
-		.num_resources	= ARRAY_SIZE(da9061_thermal_resources),
-		.resources	= da9061_thermal_resources,
-		.of_compatible  = "dlg,da9061-thermal",
-	},
-	{
-		.name		= "da9061-onkey",
-		.num_resources	= ARRAY_SIZE(da9061_onkey_resources),
-		.resources	= da9061_onkey_resources,
-		.of_compatible = "dlg,da9061-onkey",
-	},
+	MFD_CELL_OF("da9061-core", da9061_core_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-regulators", da9061_regulators_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9061-watchdog", da9061_wdt_resources, NULL, 0, 0,
+		    "dlg,da9061-watchdog"),
+	MFD_CELL_OF("da9061-thermal", da9061_thermal_resources, NULL, 0, 0,
+		    "dlg,da9061-thermal"),
+	MFD_CELL_OF("da9061-onkey", da9061_onkey_resources, NULL, 0, 0,
+		    "dlg,da9061-onkey"),
 };
 
 static const struct resource da9062_core_resources[] = {
@@ -246,46 +228,20 @@ static const struct resource da9062_gpio_resources[] = {
 };
 
 static const struct mfd_cell da9062_devs[] = {
-	{
-		.name		= "da9062-core",
-		.num_resources	= ARRAY_SIZE(da9062_core_resources),
-		.resources	= da9062_core_resources,
-	},
-	{
-		.name		= "da9062-regulators",
-		.num_resources	= ARRAY_SIZE(da9062_regulators_resources),
-		.resources	= da9062_regulators_resources,
-	},
-	{
-		.name		= "da9062-watchdog",
-		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
-		.resources	= da9062_wdt_resources,
-		.of_compatible  = "dlg,da9062-watchdog",
-	},
-	{
-		.name		= "da9062-thermal",
-		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
-		.resources	= da9062_thermal_resources,
-		.of_compatible  = "dlg,da9062-thermal",
-	},
-	{
-		.name		= "da9062-rtc",
-		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
-		.resources	= da9062_rtc_resources,
-		.of_compatible  = "dlg,da9062-rtc",
-	},
-	{
-		.name		= "da9062-onkey",
-		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
-		.resources	= da9062_onkey_resources,
-		.of_compatible	= "dlg,da9062-onkey",
-	},
-	{
-		.name		= "da9062-gpio",
-		.num_resources	= ARRAY_SIZE(da9062_gpio_resources),
-		.resources	= da9062_gpio_resources,
-		.of_compatible	= "dlg,da9062-gpio",
-	},
+	MFD_CELL_OF("da9062-core", da9062_core_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-regulators", da9062_regulators_resources, NULL, 0, 0,
+		    NULL),
+	MFD_CELL_OF("da9062-watchdog", da9062_wdt_resources, NULL, 0, 0,
+		    "dlg,da9062-watchdog"),
+	MFD_CELL_OF("da9062-thermal", da9062_thermal_resources, NULL, 0, 0,
+		    "dlg,da9062-thermal"),
+	MFD_CELL_OF("da9062-rtc", da9062_rtc_resources, NULL, 0, 0,
+		    "dlg,da9062-rtc"),
+	MFD_CELL_OF("da9062-onkey", da9062_onkey_resources, NULL, 0, 0,
+		    "dlg,da9062-onkey"),
+	MFD_CELL_OF("da9062-gpio", da9062_gpio_resources, NULL, 0, 0,
+		    "dlg,da9062-gpio"),
 };
 
 static int da9062_clear_fault_log(struct da9062 *chip)
-- 
2.11.0

