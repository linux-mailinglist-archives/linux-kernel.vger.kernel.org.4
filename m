Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6DA604EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJSRbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:31:17 -0400
X-Greylist: delayed 1226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 10:31:16 PDT
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4925C55;
        Wed, 19 Oct 2022 10:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1666199435; bh=fiH8/vrSyWzjJXKim+s93q4OhgioJqgJk6uvtBkqYH4=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=TQJcgpM+S5tAdRstd32dH3+aeBacBcLfhn1cRFJaoW/48UcB77zEpvDptDQPCj/xm
         A8scgCskoE0EjwrT2QStOEDouUfOfDeT8IkRk4TJFb2IEzuY2hxYO+y1S2WHdRiYaQ
         Wzfv8ZtGfLQjbDDAw16B0Lgf3lym9iiweiZGVmyc=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.207]
        Wed, 19 Oct 2022 19:10:35 +0200 (CEST)
X-EA-Auth: Cd0Ai1B4yfPsr25S8xGnZTRMHsnbsGm6LBkX5tA4skP0zeZIlyWHFa8P24/PvElxhrF9DbtRM3OJZ8ZMhBOcWW/7yMLsDqpXeNdjbAgAvuI=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 2/2] soc: qcom: spm: Add MSM8939 SPM register data
Date:   Wed, 19 Oct 2022 19:10:03 +0200
Message-Id: <20221019171004.1080911-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
References: <20221019171004.1080911-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SPM register information and initialization values for
QCOM MSM8939 SoC.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 drivers/soc/qcom/spm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 484b42b7454e..670775e43f07 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -98,6 +98,17 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
 	.start_index[PM_SLEEP_MODE_SPC] = 5,
 };
 
+static const struct spm_reg_data spm_reg_8939_cpu = {
+	.reg_offset = spm_reg_offset_v3_0,
+	.spm_cfg = 0x1,
+	.spm_dly = 0x3C102800,
+	.seq = { 0x60, 0x03, 0x60, 0x0B, 0x0F, 0x20, 0x50, 0x1B, 0x10, 0x80,
+		0x30, 0x90, 0x5B, 0x60, 0x50, 0x03, 0x60, 0x76, 0x76, 0x0B,
+		0x50, 0x1B, 0x94, 0x5B, 0x80, 0x10, 0x26, 0x30, 0x50, 0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 5,
+};
+
 static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
@@ -211,6 +222,8 @@ static const struct of_device_id spm_match_table[] = {
 	  .data = &spm_reg_8909_cpu },
 	{ .compatible = "qcom,msm8916-saw2-v3.0-cpu",
 	  .data = &spm_reg_8916_cpu },
+	{ .compatible = "qcom,msm8939-saw2-v3.0-cpu",
+	  .data = &spm_reg_8939_cpu },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
-- 
2.37.3



