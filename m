Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599EF696710
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjBNOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjBNOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:38:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584462B09A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u21so17726201edv.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnoag2PDXeTodhCC/Jz33tcviOKenSJ94G9E57jsB1Y=;
        b=G32qIIWsfmUdtlTrGXGRdiBZcjkQNRFtnqRKqE1rtT+7qOh1mM3z9TzsexlhcWH32T
         ZAp+ZTfaZZIpLgLDPHOhSfYE/2VUGMkGQIlLDr4dJ1K2WkmgfZe8RF78y/NsuKiyr84B
         oY3/hyFC1gCmJOLtXABf9XUs5M6QWQAWgsW/WokmH/byAjgcUWdXicfQwKInUgEe3GKO
         P5uRO55ylGq9+SFlyeIcS3cHkFX55Qrz2UgPxjw0FCXt8N5PCb6O2NtUwta+x5jfh8ws
         YoCJRNgp6fENEHUX7IenaWXEgscMPFRYw1sO7VRnCIuEOGN+yX6zJJzpDOrQ2IZl5KHg
         BJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnoag2PDXeTodhCC/Jz33tcviOKenSJ94G9E57jsB1Y=;
        b=FO7o98gBXO5vxGtpfOsx8NnUJRhXu6cdmtLaw4buABSEGgnJDWalCMGj865UlWty7W
         qEhE16ZeBgCACJ2lJAVwWqjle0/Ew1JkSeAakRDM5iEFaUBUDFEOsPS/d887m5COq+si
         zS8vWj9I9UOrlYC0+UTLKqJRO8pQEIPq4rBvZc04dM+xe/bMeB9oizOFS3Fv2/FVmj5T
         CVJLdW9IMlEkTsQOTr2+GgaXtJ9SM5ucpoZ3r8vWJH2d42eNPUN18qs2BiuUFlYXJRkK
         Zzni6x03gpdOKq41ep7PzEZGNMmUFt8NN2ypjV4ufqUk1qs68iisV1ubk8DkEMjKpN+k
         +lLw==
X-Gm-Message-State: AO0yUKX9jpA7as7WltFvCFSipZ5rY51ZIGfoqQnKg3RHPio3j9/J1in0
        yXnAe6cFiNIWJkAeRTBzLgUS+w==
X-Google-Smtp-Source: AK7set/n9GDs1MukRRWIZtj7Oq3tBmC4f3ErD143MobPv8CxgwTMwJ1AQ7ND/JAzMYLGwXHJ0FiSdg==
X-Received: by 2002:a50:d741:0:b0:4ac:c612:6d6 with SMTP id i1-20020a50d741000000b004acc61206d6mr2717421edj.13.1676385486848;
        Tue, 14 Feb 2023 06:38:06 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id eg21-20020a056402289500b004acb6189693sm5378052edb.83.2023.02.14.06.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:38:06 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/12] interconnect: qcom: rpm: Handle interface clocks
Date:   Tue, 14 Feb 2023 15:37:14 +0100
Message-Id: <20230214143720.2416762-7-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/icc-rpm.c | 48 ++++++++++++++++++++++-------
 drivers/interconnect/qcom/icc-rpm.h | 10 ++++--
 drivers/interconnect/qcom/msm8996.c | 22 ++++++-------
 drivers/interconnect/qcom/sdm660.c  | 16 ++++------
 4 files changed, 60 insertions(+), 36 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 76e8f660b932..df907ef01d6a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -441,28 +441,43 @@ int qnoc_probe(struct platform_device *pdev)
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
+	qp = devm_kzalloc(dev, struct_size(qp, intf_clks, cd_num), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
-	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
-					GFP_KERNEL);
-	if (!qp->bus_clk_rate)
-		return -ENOMEM;
-
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	for (i = 0; i < cd_num; i++)
+		qp->intf_clks[i].id = cds[i];
+	qp->num_intf_clks = cd_num;
+
+	if (desc->num_bus_clocks) {
+		cds = desc->bus_clocks;
+		cd_num = desc->num_bus_clocks;
+	} else {
+		cds = bus_clocks;
+		cd_num = ARRAY_SIZE(bus_clocks);
+	}
+
+	/*
+	 * This is not realistic, scaling is only possible with an
+	 * always-active and an active-only clock, or at least one
+	 * of them in some very bizzare cases.
+	 */
+	if (WARN_ON(cd_num > 2))
+		cd_num = 2;
+
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
 	qp->num_bus_clks = cd_num;
@@ -503,6 +518,14 @@ int qnoc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
+	if (ret)
+		return ret;
+
 	if (desc->has_bus_pd) {
 		ret = dev_pm_domain_attach(dev, true);
 		if (ret)
@@ -521,6 +544,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
+		clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
@@ -554,6 +578,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
@@ -566,6 +591,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
 	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d4401f35f6d2..729573f0d9fe 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -24,20 +24,24 @@ enum qcom_icc_type {
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
  * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
+ * @num_intf_clks: the total number of intf_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
+ * @intf_clks: the clk_bulk_data table of interface clocks
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
+	u64 bus_clk_rate[2];
+	struct clk_bulk_data bus_clks[2];
+	struct clk_bulk_data intf_clks[];
 };
 
 /**
@@ -93,6 +97,8 @@ struct qcom_icc_desc {
 	size_t num_nodes;
 	const char * const *bus_clocks;
 	size_t num_bus_clocks;
+	const char * const *intf_clocks;
+	size_t num_intf_clocks;
 	bool has_bus_pd;
 	enum qcom_icc_type type;
 	const struct regmap_config *regmap_cfg;
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 69fc50a6fa5c..1a5e0ad36cc4 100644
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
 	.has_bus_pd = true,
 	.regmap_cfg = &msm8996_a0noc_regmap_config
 };
@@ -1866,8 +1862,8 @@ static const struct qcom_icc_desc msm8996_a2noc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = a2noc_nodes,
 	.num_nodes = ARRAY_SIZE(a2noc_nodes),
-	.bus_clocks = bus_a2noc_clocks,
-	.num_bus_clocks = ARRAY_SIZE(bus_a2noc_clocks),
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
 	.regmap_cfg = &msm8996_a2noc_regmap_config
 };
 
@@ -2005,8 +2001,8 @@ static const struct qcom_icc_desc msm8996_mnoc = {
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
2.39.1

