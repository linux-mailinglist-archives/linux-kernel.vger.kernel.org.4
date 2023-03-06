Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23F6AB581
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCFENe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCFEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:13:03 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303E01C7E9;
        Sun,  5 Mar 2023 20:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIWAMVScxpiMDK9KB5E3DdHo5yH1pVxISXgktrKm5pXPY2Y5TU4YWKgbp/HHvyg3HUmFOQzjVPppSVm3ypk5NzyEGVui50pRWTdFjU96VWjeMeMtMX6w0r3AR4kEHSiXTnjnd7z9dZWoDy7xo6O59kGIDt/AzuUzSYemEBH+POf4CU94w5g8mqsLM5AqBPn0Nh2EFNQ6TVh5mdgvjbKEIrG3UuvsGd+FnlNIcq+0TZlzOGz2XaPOtF57hTB3vetdyK5pIlwoSRyvxy7q96yJtG/ut7Zs28rf1YqKLJDjiHdZ2U9kHCGmrRitOh1sDe5o4nVmi3YpXnnUmE/wah7PpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GciSQkLmO4VXhddOKOKcIhBNLg1zZK+2WBakQCozcSY=;
 b=icHJ6GSdEEpXD9y0y/pDNSxm8fKz5cxOmTfpUNQqXrWrjqMJRX/fVGWYMdI6Mg36fDLZLYV7BpaNzB2Y3VMUCnWMDFlpJNxXIv9hG3BtxqMncluZMZKqhp2yqNMpO/bEz3lE9sjp4+RMCw6NjoFKb+/OgTmd6imTmdlQv0e8mMG2c4NgSveBvv8grM2MszcrYofxqK3Ks8FvQ5kRF+jfIi8H6ADUjCKjCxm+RZrhEOWb15qU2d/5+G3m30ylEnMARt8ihu56Ia+aC/v7l76jrZ7nLCilkcV5XVPTD7q8WyI3nIuqIESaloiKw56E9EHQMqtMOWZTGStbtmbF5FGlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GciSQkLmO4VXhddOKOKcIhBNLg1zZK+2WBakQCozcSY=;
 b=hPL6iJoA1ED0ggRoZ5FxYjUCAVSWSP9qnnZAcAUrBEXyUG2WEqA5ny1oQB6KlRZTKggttmbr2mMtZp/9oBL8d4ksYyTT0SEc+nRjGWhxkhSbFZILYb1ucrl8m7c1saIINtXVaPT/AatT/ZQ+bwflEtSbNI+DwT7NV5Est5EHe1g=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by CH0PR12MB5234.namprd12.prod.outlook.com (2603:10b6:610:d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 04:10:59 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::96) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 04:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:10:59 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:10:55 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Sun, 5 Mar 2023 20:07:38 -0800
Message-ID: <20230306040739.51488-15-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|CH0PR12MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a01e7c-4349-410c-dbe9-08db1df8caaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XygUAMD/XV7m0an1yW1eL9qbXrq+QO3tYh/+n9IV/FJvkup5+Lw2BHGKmZQzI3smYEai30fk/ejnh97Sh3FhUdzyfUvLFl7TFtsiBdvOJvcNVwgBXfQmF+59aFxucwyZLah59eDGtOThjXBQrFR8/MWd4k3kpz5yjUUZr2RTTJO3cZasv88naoaAAl1LIgYPjzidmQpFqKfgkB6DWlfcWfNjxsO0S9dl7fhv39B8ZB3K95qS846VIpTXQ/yGk9vCVA3ivs3ERzBObX83y9Gc9SaEihS0oO+vTxHnoXCadRn26HPEe0BG/ZHYkac/5NzYhlItxiQ08M1mNENUc0+rftaPT4FgTmxJnTrW1sJwtjig7dc6C4nrgTSDFR1v9nzSwVK6Z2tRJsqEKwNfMH0s2a76uuWSVnylDlwP5XkbvGw8znBGYhiWCmI5KaG1lDPjYrT/wsmGDdyKF4axv4uPQmz21PlgCUUecrzc2AFVhf2dsdt+orUckFGCNz1fe2Gu0/AWkjLef4mWvhND0GEJSV7cFb3vZgOnFpOE31sIx+a6fWkOStmmDLrW9GA2GnOxKRIGw9ZtwtASiphBlq0m1UBV9t1P6/exbRwBCiYXgDYVFdisE63F/RSzzscw+zSZOGW4gtYB1ottWSI3537P8IzB5UrXMsfzmhNISH/UulWn76dxyuJUGLPPuL/5vAt/7DEBBhNtA44IPUFCtBTBO2st4XtkJZvaIRAM7XUlIT4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(40460700003)(16526019)(186003)(6666004)(81166007)(356005)(8936002)(36860700001)(4326008)(6916009)(8676002)(41300700001)(82740400003)(2906002)(70586007)(70206006)(5660300002)(7406005)(7416002)(426003)(47076005)(478600001)(2616005)(1076003)(26005)(336012)(316002)(54906003)(36756003)(40480700001)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:10:59.1722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a01e7c-4349-410c-dbe9-08db1df8caaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mmc hardware reset using a reset-controller
that would need to be enabled in the device tree with
a supporting driver.  The default is disabled for all
existing designs.

Signed-off-by: Brad Larson <blarson@amd.com>
---

v9 changes:
- Previously patch 17/17
- Changed delay after reset_control_assert() from 9 to 3 usec
- Renamed sdhci_mmc_hw_reset() to sdhci_cdns_mmc_hw_reset()

---
 drivers/mmc/host/sdhci-cadence.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 31c77d32aa7d..d13081da5e30 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -12,6 +12,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 
 #include "sdhci-pltfm.h"
 
@@ -70,6 +71,7 @@ struct sdhci_cdns_priv {
 	spinlock_t wrlock;	/* write lock */
 	bool enhanced_strobe;
 	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
+	struct reset_control *rst_hw;
 	unsigned int nr_phy_params;
 	struct sdhci_cdns_phy_param phy_params[];
 };
@@ -460,6 +462,22 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					 SDHCI_CDNS_HRS06_MODE_MMC_HS400);
 }
 
+static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+
+	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
+
+	reset_control_assert(priv->rst_hw);
+	/* For eMMC, minimum is 1us but give it 3us for good measure */
+	udelay(3);
+
+	reset_control_deassert(priv->rst_hw);
+	/* For eMMC, minimum is 200us but give it 300us for good measure */
+	usleep_range(300, 1000);
+}
+
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -523,6 +541,15 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
+	if (host->mmc->caps & MMC_CAP_HW_RESET) {
+		priv->rst_hw = devm_reset_control_get_optional_exclusive(dev, "hw");
+		if (IS_ERR(priv->rst_hw))
+			return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->rst_hw),
+					     "reset controller error\n");
+		if (priv->rst_hw)
+			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto free;
-- 
2.17.1

