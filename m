Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A458E678655
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjAWT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjAWT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:28:45 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27004A24F;
        Mon, 23 Jan 2023 11:28:43 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NG9C8K006267;
        Mon, 23 Jan 2023 11:28:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=QYqBEalRnj5G8hO6nXMYQ36s9REDirGzeChEReC5r44=;
 b=hjLtJYJ2ZMnjVvOAUVaG6Dy0bT++EXAnVL5HLUs0C1SPMZC7V9KQFxJ2aPWbYr4ake4K
 irm3LmiAG0tElbWFyeMGbkJsmra66qXlAhvag4aGN0ZAd433y8AuVcWWBOYKtT7xPAqj
 A8di1zu05DIzhF0RuZxl+gi+YexBZMxXm00IhJVDn9btHxdofZ0LZEKIQiZesypfYgN5
 WowkHexzafx2oAgXk2cz4oiqRfS9JEtt2/JjLhGpRYhTMRFdfePlEM2wgG1xfzQRytW/
 nM3xKsvKrqOL1fNqNWOCIx44xGMHJb9z0yzDz3fCrw870atBBMBKM3n22LVxy4fJ86A3 9g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n8gerbenw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:28:32 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 23 Jan
 2023 11:28:30 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 23 Jan 2023 11:28:30 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 0FAB03F7054;
        Mon, 23 Jan 2023 11:28:30 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2 1/5] drivers: mmc: sdhci-cadence: Reformat the code
Date:   Mon, 23 Jan 2023 11:27:31 -0800
Message-ID: <20230123192735.21136-2-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230123192735.21136-1-pmalgujar@marvell.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: B__CLzQ7P6OslIHGUcfyql8Oex35AKcJ
X-Proofpoint-ORIG-GUID: B__CLzQ7P6OslIHGUcfyql8Oex35AKcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhananjay Kangude <dkangude@cadence.com>

Reformat the code so that further SD6 changes could be
added and it could be isolated from SD4 related code.
Also renamed functions accordingly.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 165 ++++++++++++++++++++-----------
 1 file changed, 110 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a598773879bf339aae8450f63e1251509..cb108ff9abda32767b356bb572abdf8626746cd6 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -15,14 +15,14 @@
 
 #include "sdhci-pltfm.h"
 
-/* HRS - Host Register Set (specific to Cadence) */
+/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
 #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
-#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
-#define   SDHCI_CDNS_HRS04_RD			BIT(25)
-#define   SDHCI_CDNS_HRS04_WR			BIT(24)
-#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
-#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
-#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
+#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
+#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
+#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
+#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
+#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
+#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)
 
 #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
 #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
@@ -38,7 +38,7 @@
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
-/* PHY */
+/* PHY registers for SD4 controller */
 #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
 #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
 #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
@@ -59,24 +59,43 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
-struct sdhci_cdns_phy_param {
+struct sdhci_cdns_priv;
+
+struct sdhci_cdns_sd4_phy_param {
 	u8 addr;
 	u8 data;
 };
 
+struct sdhci_cdns_data {
+	int (*phy_init)(struct sdhci_cdns_priv *priv);
+	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
+};
+
+struct sdhci_cdns_sd4_phy {
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy_param phy_params[];
+};
+
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
-	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
+	const struct sdhci_cdns_data *cdns_data;
+	void *phy;
 };
 
-struct sdhci_cdns_phy_cfg {
+struct sdhci_cdns_sd4_phy_cfg {
 	const char *property;
 	u8 addr;
 };
 
-static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
+struct sdhci_cdns_of_data {
+	const struct sdhci_pltfm_data *pltfm_data;
+	const struct sdhci_cdns_data *cdns_data;
+	int (*phy_probe)(struct platform_device *pdev,
+			 struct sdhci_cdns_priv *priv);
+};
+
+static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
 	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
@@ -90,80 +109,80 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
-static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				    u8 addr, u8 data)
+static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
+					u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
 	int ret;
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 	if (ret)
 		return ret;
 
-	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
-	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
+	tmp = FIELD_PREP(SDHCI_CDNS_SD4_HRS04_WDATA, data) |
+	      FIELD_PREP(SDHCI_CDNS_SD4_HRS04_ADDR, addr);
 	writel(tmp, reg);
 
-	tmp |= SDHCI_CDNS_HRS04_WR;
+	tmp |= SDHCI_CDNS_SD4_HRS04_WR;
 	writel(tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
+	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_SD4_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
-	tmp &= ~SDHCI_CDNS_HRS04_WR;
+	tmp &= ~SDHCI_CDNS_SD4_HRS04_WR;
 	writel(tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 
 	return ret;
 }
 
-static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
+static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
 {
 	unsigned int count = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
-		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++)
+		if (of_property_read_bool(np, sdhci_cdns_sd4_phy_cfgs[i].property))
 			count++;
 
 	return count;
 }
 
-static void sdhci_cdns_phy_param_parse(struct device_node *np,
-				       struct sdhci_cdns_priv *priv)
+static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
+					   struct sdhci_cdns_sd4_phy *phy)
 {
-	struct sdhci_cdns_phy_param *p = priv->phy_params;
+	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++) {
+		ret = of_property_read_u32(np, sdhci_cdns_sd4_phy_cfgs[i].property,
 					   &val);
 		if (ret)
 			continue;
 
-		p->addr = sdhci_cdns_phy_cfgs[i].addr;
+		p->addr = sdhci_cdns_sd4_phy_cfgs[i].addr;
 		p->data = val;
 		p++;
 	}
 }
 
-static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
+	struct sdhci_cdns_sd4_phy *phy = priv->phy;
 
-	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
-					       priv->phy_params[i].data);
+	for (i = 0; i < phy->nr_phy_params; i++) {
+		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
+						   phy->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
-
 	return 0;
 }
 
@@ -202,7 +221,28 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
-static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
+static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
+				    struct sdhci_cdns_priv *priv)
+{
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy *phy;
+	struct device *dev = &pdev->dev;
+
+	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
+	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
+			   GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nr_phy_params = nr_phy_params;
+
+	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
+	priv->phy = phy;
+
+	return 0;
+}
+
+static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
@@ -255,7 +295,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return 0;
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
-		if (sdhci_cdns_set_tune_val(host, i) ||
+		if (sdhci_cdns_sd4_set_tune_val(host, i) ||
 		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
 			cur_streak = 0;
 		} else { /* good */
@@ -272,7 +312,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	return sdhci_cdns_sd4_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
@@ -309,7 +349,7 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_set_uhs_signaling(host, timing);
 }
 
-static const struct sdhci_ops sdhci_cdns_ops = {
+static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -319,12 +359,23 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+	.ops = &sdhci_cdns_sd4_ops,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
+	.ops = &sdhci_cdns_sd4_ops,
+};
+
+static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
+	.phy_init = sdhci_cdns_sd4_phy_init,
+	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
+};
+
+static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
+	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
+	.cdns_data = &sdhci_cdns_sd4_data,
+	.phy_probe = sdhci_cdns_sd4_phy_probe,
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -350,11 +401,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_of_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -368,12 +418,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 		return ret;
 
 	data = of_device_get_match_data(dev);
-	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+	if (!data) {
+		return PTR_ERR(clk);
+		goto disable_clk;
+	}
 
-	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
-				struct_size(priv, phy_params, nr_phy_params));
+	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
@@ -383,9 +433,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
+	priv->cdns_data = data->cdns_data;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
@@ -398,9 +448,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+	ret = data->phy_probe(pdev, priv);
+	if (ret)
+		goto free;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -429,7 +481,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
@@ -455,7 +507,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "socionext,uniphier-sd4hc",
 		.data = &sdhci_cdns_uniphier_pltfm_data,
 	},
-	{ .compatible = "cdns,sd4hc" },
+	{
+		.compatible = "cdns,sd4hc",
+		.data = &sdhci_cdns_sd4_of_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
-- 
2.17.1

