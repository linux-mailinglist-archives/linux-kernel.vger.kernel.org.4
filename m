Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C877088D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjERT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:58:16 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A99CC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:58:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso2860184e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684439893; x=1687031893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7HAbP/yq151wuxj+IP3o2G/SsWPNnr8yO3Lll2QflU=;
        b=DTSq9hAGSuIti24AEdzReJdBr1vrJjgdpn4gGUcj3/EucZbTazgXRFGPH03hIhbpNA
         jjtLAlTp//Vd9OkJUIhYvOkMMhcpo4+AXS/eK1VvqzJtCQQkREzHkgEFuGuqq5mVI3VJ
         xvm7IHyX7XMcR+v44VdqRVXkNSE5vxFRy81movPhzYB5b8Z9cS3Q5ExUqvjd/A8kdplr
         SxszdohNGa3IkQqF7S1u+dsOEUorJjKNCS13mqj6gAzZgmjKow5Win55cUCYriv+/VPb
         q6qOmP4n3TJorrx54tTEXoDJ2BmUuwIO+N6oMLEhL7sV4owumcbj9fEC1Lfb1SrECyRY
         R7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439893; x=1687031893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7HAbP/yq151wuxj+IP3o2G/SsWPNnr8yO3Lll2QflU=;
        b=SDtkmdcWkUHWB6m2n66WBmqPmaB2sBs9Wfi9jIDqZUj59qTzFomAU/lGi2roadKxqf
         KlYcDXYPnQsFKjCzcOXY4eRytcwv/6yTQMopjMmr9ftZp1EZ1pGfvLt72QRv/RcUH3jf
         3BX8jHvyhDrT/MY220Ya7XNqqej/dIWMa7wYv0xjNlcOn4J/gzoxNh1gY0ULJ24Tl12E
         3deDq6L5dAA34ZSmXPw5waur0zZpLEp+/PSaJIqsIMUp+qSwhsXk7A4eY7ZI1IBKeiXT
         sT9pqcYOGUZE5UvzSBlGKSI+JCxbHKreA9I7WsZLgpP6fKXusnwTe61stNL2BllN5F5D
         1TMA==
X-Gm-Message-State: AC+VfDwFXH8wTuR1oerJQta0islSYt4r0MaVPVLOnTW97hs7YNuBUUpF
        WGKWuIuh4runqC1I67Pc4sD+oA==
X-Google-Smtp-Source: ACHHUZ6PIs31BhYpHna9WferESkJuodlHAjNNDFI2TSWcN25vzI2dM9FblLCGwlelglTUfb7rC9uMA==
X-Received: by 2002:ac2:4423:0:b0:4f1:47ff:d330 with SMTP id w3-20020ac24423000000b004f147ffd330mr25492lfl.53.1684439893075;
        Thu, 18 May 2023 12:58:13 -0700 (PDT)
Received: from localhost.localdomain (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9490000000b002a93e0605ebsm457727ljh.8.2023.05.18.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 12:58:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, djakov@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9] interconnect: qcom: rpm: Handle interface clocks
Date:   Thu, 18 May 2023 21:58:01 +0200
Message-Id: <20230518195801.2556998-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some (but not all) providers (or their specific nodes) require
specific clocks to be turned on before they can be accessed. Failure
to ensure that results in a seemingly random system crash (which
would usually happen at boot with the interconnect driver built-in),
resulting in the platform not booting up properly.

Limit the number of bus_clocks to 2 (which is the maximum that SMD
RPM interconnect supports anyway) and handle non-scaling clocks
separately. Update MSM8996 and SDM660 drivers to make sure they do
not regress with this change.

This unfortunately has to be done in one patch to prevent either
compile errors or broken bisect.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Resending just this one as per Georgi's request in

https://lore.kernel.org/linux-arm-msm/b1990459-4780-b139-9656-f00f34a2a375@kernel.org/

Changes since v8:
- Iniitalize cds at declaration time

 drivers/interconnect/qcom/icc-rpm.c | 42 ++++++++++++++++++++++-------
 drivers/interconnect/qcom/icc-rpm.h | 14 ++++++++--
 drivers/interconnect/qcom/msm8996.c | 22 +++++++--------
 drivers/interconnect/qcom/sdm660.c  | 16 +++++------
 4 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index d79e508cb717..c34f75703a66 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -409,7 +409,7 @@ int qnoc_probe(struct platform_device *pdev)
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i;
-	const char * const *cds;
+	const char * const *cds = NULL;
 	int cd_num;
 	int ret;
 
@@ -424,21 +424,20 @@ int qnoc_probe(struct platform_device *pdev)
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	if (desc->num_bus_clocks) {
-		cds = desc->bus_clocks;
-		cd_num = desc->num_bus_clocks;
+	if (desc->num_intf_clocks) {
+		cds = desc->intf_clocks;
+		cd_num = desc->num_intf_clocks;
 	} else {
-		cds = bus_clocks;
-		cd_num = ARRAY_SIZE(bus_clocks);
+		/* 0 intf clocks is perfectly fine */
+		cd_num = 0;
 	}
 
-	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
-					GFP_KERNEL);
-	if (!qp->bus_clk_rate)
+	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
+	if (!qp->intf_clks)
 		return -ENOMEM;
 
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
@@ -446,6 +445,18 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	qp->num_intf_clks = cd_num;
+	for (i = 0; i < cd_num; i++)
+		qp->intf_clks[i].id = cds[i];
+
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
+	} else {
+		cds = bus_clocks;
+		cd_num = ARRAY_SIZE(bus_clocks);
+	}
+
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_bus_clks = cd_num;
@@ -486,6 +497,10 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
@@ -496,6 +511,11 @@ int qnoc_probe(struct platform_device *pdev)
 
 	icc_provider_init(provider);
 
+	/* If this fails, bus accesses will crash the platform! */
+	ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
@@ -524,6 +544,8 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 	data->num_nodes = num_nodes;
 
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
+
 	ret = icc_provider_register(provider);
 	if (ret)
 		goto err_remove_nodes;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 2436777820a4..b9b63860042f 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -20,24 +20,32 @@ enum qcom_icc_type {
 	QCOM_ICC_QNOC,
 };
 
+#define NUM_BUS_CLKS	2
+
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
  * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
+ * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
+ * @intf_clks: a clk_bulk_data array of interface clocks
+ * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
 	int num_bus_clks;
+	int num_intf_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
-	u64 *bus_clk_rate;
-	struct clk_bulk_data bus_clks[];
+	u64 bus_clk_rate[NUM_BUS_CLKS];
+	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
+	struct clk_bulk_data *intf_clks;
+	bool is_on;
 };
 
 /**
@@ -93,6 +101,8 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	const char * const *bus_clocks;
 	size_t num_bus_clocks;
+	const char * const *intf_clocks;
+	size_t num_intf_clocks;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
 	unsigned int qos_offset;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 21f998cd19f0..9aedfc8de4bf 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -21,21 +21,17 @@
 #include "smd-rpm.h"
 #include "msm8996.h"
 
-static const char * const bus_mm_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const mm_intf_clocks[] = {
 	"iface"
 };
 
-static const char * const bus_a0noc_clocks[] = {
+static const char * const a0noc_intf_clocks[] = {
 	"aggre0_snoc_axi",
 	"aggre0_cnoc_ahb",
 	"aggre0_noc_mpu_cfg"
 };
 
-static const char * const bus_a2noc_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const a2noc_intf_clocks[] = {
 	"aggre2_ufs_axi",
 	"ufs_axi"
 };
@@ -1821,8 +1817,8 @@ static const struct qcom_icc_desc msm8996_a0noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a0noc_nodes,
 	.num_nodes = ARRAY_SIZE(a0noc_nodes),
-	.bus_clocks = bus_a0noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a0noc_clocks),
+	.intf_clocks = a0noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a0noc_intf_clocks),
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
 
@@ -1865,8 +1861,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2004,8 +2000,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(mnoc_nodes),
-	.bus_clocks = bus_mm_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.intf_clocks = mm_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &msm8996_mnoc_regmap_config
 };
 
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index a22ba821efbf..0e8a96f4ce90 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -127,15 +127,11 @@ enum {
 	SDM660_SNOC,
 };
 
-static const char * const bus_mm_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const mm_intf_clocks[] = {
 	"iface",
 };
 
-static const char * const bus_a2noc_clocks[] = {
-	"bus",
-	"bus_a",
+static const char * const a2noc_intf_clocks[] = {
 	"ipa",
 	"ufs_axi",
 	"aggre2_ufs_axi",
@@ -1516,8 +1512,8 @@ static const struct qcom_icc_desc sdm660_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &sdm660_a2noc_regmap_config,
 };
 
@@ -1659,8 +1655,8 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = sdm660_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(sdm660_mnoc_nodes),
-	.bus_clocks = bus_mm_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_mm_clocks),
+	.intf_clocks = mm_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
 };
 
-- 
2.40.1

