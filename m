Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280666363E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiKWPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiKWPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:36:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABDD786C8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:36:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o30so13350284wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIolcY7Gs+PsDlc7bfY9hlM/TZPENVo0vUsEsAX0cvo=;
        b=iIxf37l8b88uHwbIJ1EaCE8cv6EBchOguS5dDQ8K3O3HtMMdQ1Gxj1bNLfmSM+X39b
         mNCnmtvsdk+MeAMuj2JjfBPuVO9Hsg+ASLO4JRxLCYauhdgk+gZ/gkyPRJq3LpGd6nmb
         FLFT1T26WHg7VEIaBhuYqfIFiO3hACO1y/X3KHDbUpVG9NPhE8Ce0XFG4FKjZ46AFerM
         EBhpffAtnB/TEHidtsdWnWxgbKH5T9+WbwSECB75wmaCv6Q4wzSRnWaNyi4Tyynuxi/6
         7q1kn5UfiX/qEwDGob4OSOZVvzju7Ryn81Bv3rlbI/N5kHUr87N2W298n+VRTECEYSuq
         q2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIolcY7Gs+PsDlc7bfY9hlM/TZPENVo0vUsEsAX0cvo=;
        b=lTbz1fdYkGdR1Y2lWvOYpb/U3b2IWO3igo1Cc6r/0+mhX4gnn0tAN4sja2kupwI460
         qBwe2rQJnLMc/NV/zBN+4+M6crRzb9l43VYBk4rJgEOc8Z+qU1c2ojBbuSBrtSQBSvWf
         9OM1uaakwZ4Ln5TAGyTDMI1u0Db785uodTHCIj810VP48V3IUBNsvTE9/4LnzyCH5tqI
         Xcr3u5wqeCgPNZchou1cS86Qb7HGNqJY0sG0nM8aEsPbiUPGf498/5kN89bM1h+7c+AS
         N2QMTt5tgjW1FfR/qN6CbHvGh9JUcL0e52CuNsL3e2lXPguvGS4qJHUc5DhasXiC+gbt
         F4gA==
X-Gm-Message-State: ANoB5pm9akManPlqOofc7cFLGBY/OkdeKSIYJRORpffLDdPJbu6+DK/A
        qZRHa9iM5EQZJwTCHpkml2Ft6J0xoyYFtg==
X-Google-Smtp-Source: AA0mqf6z8+JyGCqRyyb8h2MVhjtcqBpG/IJmcAArjIW+ye0qQ8M1Oh75WKsXpxyYQf5bQv/+TJyA5A==
X-Received: by 2002:a05:600c:5541:b0:3cf:8896:e1d0 with SMTP id iz1-20020a05600c554100b003cf8896e1d0mr10171475wmb.177.1669217812653;
        Wed, 23 Nov 2022 07:36:52 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b00228cbac7a25sm17169833wra.64.2022.11.23.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:36:52 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: qcom-rpmh: Add support for PM8550 regulators
Date:   Wed, 23 Nov 2022 17:36:38 +0200
Message-Id: <20221123153638.721254-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123153638.721254-1-abel.vesa@linaro.org>
References: <20221123153638.721254-1-abel.vesa@linaro.org>
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

Add the rpmh regulators found in PM8550 PMIC and its variants,
along with their compatibles and configuration data. They also
contain some FT-SMPS 525, so add their configuration as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

Changes since v1:
 * Made the commit message describe better the changes
 * Added Konrad's R-b tag

 drivers/regulator/qcom-rpmh-regulator.c | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index f90bcdeecea5..43b5b9377714 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -731,6 +731,24 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps520 = {
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(300000, 0, 267, 4000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
+static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(600000, 0, 267, 8000),
+	.n_voltages = 268,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -987,6 +1005,57 @@ static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,    "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo_lv, "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv, "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,    "vdd-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo,    "vdd-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
+	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
+	RPMH_VREG("bob2",   "bob%s2",  &pmic5_bob,     "vdd-bob2"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,   "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,   "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,   "vdd-l3"),
+	{}
+};
+
+static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
+	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
+	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
+	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
+	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
+	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
+	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
+	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
+	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo,   "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo,   "vdd-l2"),
+	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo,   "vdd-l3"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515, "vdd-s2"),
@@ -1314,6 +1383,18 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pm8450-rpmh-regulators",
 		.data = pm8450_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8550-rpmh-regulators",
+		.data = pm8550_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550ve-rpmh-regulators",
+		.data = pm8550ve_vreg_data,
+	},
+	{
+		.compatible = "qcom,pm8550vs-rpmh-regulators",
+		.data = pm8550vs_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8998-rpmh-regulators",
 		.data = pm8998_vreg_data,
-- 
2.34.1

