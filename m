Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50375B38A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiIINHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiIINGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:06:53 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D1DAF0FD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWl/zu37dQ3kQeRX/9LCCEjFPlvTmtoXtF16amYKab/ppnDoDp8wTzBLtmFNgyNrn2eoZmmFW0OvP2RfllbOkrOiLvi5dnJrNzToaUEBJvy9orCWbtHkuqq2vnDVLeYMSojrTrsGOpcFQfrcV6rZh1MAipg/axUgxjR3m0nUTIeobFHtfU3St0O6zm3iLVwBUr42y4ssVJ1TMEVlW371Z4IiR6CEOA/XDWMhJGkvHYNqLbibZeaGmB5mFbp0/jzg30u3qWzSGiK58m6aySv8JQRS3bQqJuRhoHG21X7WSxX7dyp/mK9PZqLkFpffXeauLG/oiQm64qgRdcDJcn+PWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hNpfkybk4Ei2pru+48vs6+p4coeUZZjc3wt8lLBKQ4=;
 b=LrdCM/i6NYQjKKRUfdGVVCo1QP9SXFDBKVFjcUd5SwE+GfLHzSy5+4PROavFIKnVwTEqjozUdfKPWY/bDCW3DIHYxnMTwAgO5q85thSrRQ3irqBwj7NbMbAI+DWWOqNqd3r8yWtvh5NbVJ64shaqTYlFgKB0MpixHa+P0DxXIEf36fvczUxpYgdeBLh45cwN/POYio55/wIqPOsAEPpoJX9o3H//u4m+rWUVOGLFOyhVEH1cyRvPTgbvYMt0QdG+jtwfu7A7maihXp4k2b2w+44eoZSeuEh7fy9lmGYkB/eM7/Riqm+FWYyqnpmO0odfsyGNwXz8fHPhxziv1mOV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hNpfkybk4Ei2pru+48vs6+p4coeUZZjc3wt8lLBKQ4=;
 b=EeYReJkDIizHm0O9AVLV4++pLEfuXJoNQmYDG2tTKV2AkVxCIMI/pUmgEvfJ39aCoAvyvUmwhDAXgP8cby63nyLbE1aSuIzyqjJB9nnZF1ZDlzLZa1WvtjWI8Tv652GaTGPMXrjfbqjNUoGkJy9heZQ+Yr5L23AvwSiKx7Nxfjs=
Received: from DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 13:05:01 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::d0) by DM6PR14CA0064.outlook.office365.com
 (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 13:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 13:05:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 08:05:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 08:04:59 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 9 Sep 2022 08:04:55 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <vkoul@kernel.org>, <michal.simek@xilinx.com>
CC:     <michal.simek@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] phy: xilinx: phy-zynqmp: dynamic clock support for power-save
Date:   Fri, 9 Sep 2022 18:34:42 +0530
Message-ID: <20220909130442.1337970-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|IA1PR12MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da1e847-c0d1-44a6-db8c-08da9263e767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzkO+3B5ly7oLYLvpAwH8NCPMr6N1R7iR8WJv0G4nVbuuTw/0wQkNSzH0Afbx8et+7Z9W3JgaBmB23utEZlbo1aCiXPqKwWo6vdvSuXS6yxoNofheKHSdJJ9ypHQv8g5r6AH6QVILzI+y97teKSH/5xH+PokEHe4TEkGSjREAGWo8wF6xABpmxsXquKBotU9PifBKpKzOXlmVyxQ6ftOrZZYyRObaDSl41dR+sdoiWkdJb3d0nW0T7/iipA5f5zm8l0DdoW/f+5b22UsqPMsVRbHnlGyddWNi3qzbJLnpUWgAMTkvRDelmQ+KMqq2C8zcyVfSFItXYxErY8DAgroY5IhEPVB/tOq8/SLZRt9woEYGkdeUu+0g7woA7/5N+60R/6JuQi+xjVtHYalteW2T3sFg1oAUWvYN1JZZHY7NKOnm3yycOMPcPd/bldz3WOY+x+QwUFkLias7PgUuGU/tODhEjeOg8DBIKxDNNcYyvjWwxQKJTHYIheCWnvN1dLNioz/wlnRfY7Um5yEeaO4LEGCADu9/ucd4lYAyv2DFJu4K0BL5PVwj8ok1w0mtEDqwugKcElE35EWQM/tbBqiO1ymbem1Wa8h830fUFAf5xdCziZZK/QIVWdqvqooXbL6MedR1T2tA19ZzbNEXwhnjuOk7ctdn8RxkuTTOBZV8rNJRdI++7ltlGSVuQVzJfEkM1rB1BWZpxvdYBho8Y7mUCDQ4y9+BbLbHVrBbPtqUPo/HHDHI8yVoBt2czrkG/eHtPHB2sgcfW47sCFeuLOB44NjsdH/fJa/Km6nYyrAqXGxtz7EzH8w6xjiqLGhKVxX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(36756003)(6666004)(41300700001)(26005)(40460700003)(478600001)(40480700001)(70586007)(82310400005)(2906002)(86362001)(54906003)(316002)(81166007)(110136005)(82740400003)(356005)(70206006)(2616005)(186003)(336012)(426003)(1076003)(47076005)(8676002)(44832011)(8936002)(4326008)(5660300002)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 13:05:00.7169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da1e847-c0d1-44a6-db8c-08da9263e767
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling clock for all the lanes, consuming power even PHY is active or
not.

To resolve the above issue and power saving,made clock enabled/disabled
based on active PHYs on call of phy_init/phy_exit.

By default clock is disabled for all the lanes. Whenever phy_init called
from USB, SATA, SGMII, or display driver, it enabled the required clock
for requested lane. On phy_exit cycle, it disabled clock for the active
PHYs.

During the suspend/resume cycle, each USB/ SATA/ SGMII/ display driver
called phy_exit/phy_init individually. it disabled clock on exit, and
enabled on initialization for the active PHYs.

Active PHY configuration depends on the peripheral DT node status,
like USB DT node status 'okay' then driver enabled clock for the USB
configured lane.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/phy/xilinx/phy-zynqmp.c | 59 ++++++++-------------------------
 1 file changed, 14 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 9be9535ad7ab..912c4defdf8d 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -572,6 +572,10 @@ static int xpsgtr_phy_init(struct phy *phy)
 
 	mutex_lock(&gtr_dev->gtr_mutex);
 
+	/* Configure and enable the clock when peripheral phy_init call */
+	if (clk_prepare_enable(gtr_dev->clk[gtr_phy->lane]))
+		goto out;
+
 	/* Skip initialization if not required. */
 	if (!xpsgtr_phy_init_required(gtr_phy))
 		goto out;
@@ -616,9 +620,13 @@ static int xpsgtr_phy_init(struct phy *phy)
 static int xpsgtr_phy_exit(struct phy *phy)
 {
 	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
+	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
 
 	gtr_phy->skip_phy_init = false;
 
+	/* Ensure that disable clock only, which configure for lane */
+	clk_disable_unprepare(gtr_dev->clk[gtr_phy->lane]);
+
 	return 0;
 }
 
@@ -824,15 +832,11 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 static int __maybe_unused xpsgtr_suspend(struct device *dev)
 {
 	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
-	unsigned int i;
 
 	/* Save the snapshot ICM_CFG registers. */
 	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
 
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
 	return 0;
 }
 
@@ -842,13 +846,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 	unsigned int icm_cfg0, icm_cfg1;
 	unsigned int i;
 	bool skip_phy_init;
-	int err;
-
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++) {
-		err = clk_prepare_enable(gtr_dev->clk[i]);
-		if (err)
-			goto err_clk_put;
-	}
 
 	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
 	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
@@ -869,12 +866,6 @@ static int __maybe_unused xpsgtr_resume(struct device *dev)
 		gtr_dev->phys[i].skip_phy_init = skip_phy_init;
 
 	return 0;
-
-err_clk_put:
-	while (i--)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
-	return err;
 }
 
 static const struct dev_pm_ops xpsgtr_pm_ops = {
@@ -888,7 +879,6 @@ static const struct dev_pm_ops xpsgtr_pm_ops = {
 static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 {
 	unsigned int refclk;
-	int ret;
 
 	for (refclk = 0; refclk < ARRAY_SIZE(gtr_dev->refclk_sscs); ++refclk) {
 		unsigned long rate;
@@ -899,19 +889,14 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 		snprintf(name, sizeof(name), "ref%u", refclk);
 		clk = devm_clk_get_optional(gtr_dev->dev, name);
 		if (IS_ERR(clk)) {
-			ret = dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
-					    "Failed to get reference clock %u\n",
-					    refclk);
-			goto err_clk_put;
+			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
+					     "Failed to get ref clock %u\n",
+					     refclk);
 		}
 
 		if (!clk)
 			continue;
 
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto err_clk_put;
-
 		gtr_dev->clk[refclk] = clk;
 
 		/*
@@ -931,18 +916,11 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 			dev_err(gtr_dev->dev,
 				"Invalid rate %lu for reference clock %u\n",
 				rate, refclk);
-			ret = -EINVAL;
-			goto err_clk_put;
+			return -EINVAL;
 		}
 	}
 
 	return 0;
-
-err_clk_put:
-	while (refclk--)
-		clk_disable_unprepare(gtr_dev->clk[refclk]);
-
-	return ret;
 }
 
 static int xpsgtr_probe(struct platform_device *pdev)
@@ -951,7 +929,6 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	struct xpsgtr_dev *gtr_dev;
 	struct phy_provider *provider;
 	unsigned int port;
-	unsigned int i;
 	int ret;
 
 	gtr_dev = devm_kzalloc(&pdev->dev, sizeof(*gtr_dev), GFP_KERNEL);
@@ -991,8 +968,7 @@ static int xpsgtr_probe(struct platform_device *pdev)
 		phy = devm_phy_create(&pdev->dev, np, &xpsgtr_phyops);
 		if (IS_ERR(phy)) {
 			dev_err(&pdev->dev, "failed to create PHY\n");
-			ret = PTR_ERR(phy);
-			goto err_clk_put;
+			return PTR_ERR(phy);
 		}
 
 		gtr_phy->phy = phy;
@@ -1003,16 +979,9 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	provider = devm_of_phy_provider_register(&pdev->dev, xpsgtr_xlate);
 	if (IS_ERR(provider)) {
 		dev_err(&pdev->dev, "registering provider failed\n");
-		ret = PTR_ERR(provider);
-		goto err_clk_put;
+		return PTR_ERR(provider);
 	}
 	return 0;
-
-err_clk_put:
-	for (i = 0; i < ARRAY_SIZE(gtr_dev->clk); i++)
-		clk_disable_unprepare(gtr_dev->clk[i]);
-
-	return ret;
 }
 
 static const struct of_device_id xpsgtr_of_match[] = {
-- 
2.25.1

