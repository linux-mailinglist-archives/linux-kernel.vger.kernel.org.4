Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99BB6B90D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCNK7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCNK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:59:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611312F27
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:59:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a2so16165495plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678791558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esY0PUr3KpLmlyLSgYjmN3E1hSTNbeaUPnE+inbUG44=;
        b=NrBACpRog8R7FKmw5eS8aONTQolQr/MwHR5U0zBM55paV14LD6HMWdBtQqMiqSKRBZ
         SpOYz9v88Xy4YLXeSzX0LX4aSLNDeKZ4hhzmA+IGRT7sM5J+f6FEdksfllw0Dnp3/XBc
         xAlnUop6qEwlxL8IkF2UiOp5DXZ6HB37p7e8Fa2MSAfG6ISOPNVMql+8upLUhNSaYGWs
         UUimxksR24PnGk7Ykr27lFj3lXJsQw9Iy8v91ZdJxAB6uGlAOGZCqbRHaLjopwoRyA93
         9CbC+cwl2HNdFwpA71yzfuoxcsUOs8T1guL4PAFEl8OxDgcZkubXS1gPKwJnTXCO2vPm
         PYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678791558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esY0PUr3KpLmlyLSgYjmN3E1hSTNbeaUPnE+inbUG44=;
        b=bDuw2Sy0LkCb7zae5B5aigpOJ48mSv2lMt6L9GN7W7NFStmAjjIyimPVPC2iTvOTr3
         +5BFtZmUyKlUgPj/9iyy1uIdG3NACKoWzKxBdZsr24ZzFkrtuU8ejXizVZkECA9KHRGS
         LTnEekMCjHH/ThEbCD9IaNvdvDxE5vnRjgTZvmpVb/uzNpxlRzLhRG3PW3OJVnFiFE1f
         aisj84at45vFoImN/DXxrq3uRxGGDL8vaW2vvNedRrc8j10xiTKpCpiVuJ5CJuCp+onl
         fIgg+MiLFAx5rVX0Zd3+ZfiwJ4a9++ZFf17EWzftFLJODj3X8SDddCfQyNPHipskz+d/
         oazw==
X-Gm-Message-State: AO0yUKVPU//or3NTPCvFwQp8jsNwFYH9qCWqFCB0PBad9MHhHu121tD0
        H9K0FPhFMIwCdODN4fAlu2X4
X-Google-Smtp-Source: AK7set9QnpmzQqwH3+zL8nTYZYqNZD9jkBSs6ms001GQpkZrPswrWMuGlAIHQPGNwwFE/PsQxMYPog==
X-Received: by 2002:a17:902:b593:b0:1a0:6c22:ff4d with SMTP id a19-20020a170902b59300b001a06c22ff4dmr1100491pls.16.1678791557954;
        Tue, 14 Mar 2023 03:59:17 -0700 (PDT)
Received: from localhost.localdomain ([117.217.177.49])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0019f39e4f120sm1491894plb.18.2023.03.14.03.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 03:59:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     robin.murphy@arm.com, andersson@kernel.org,
        johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the bypass quirk
Date:   Tue, 14 Mar 2023 16:29:05 +0530
Message-Id: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic used to find the quirky firmware that intercepts the writes to
S2CR register to replace bypass type streams with a fault, and ignore the
fault type, is not working with the firmware on newer SoCs like SC8280XP.

The current logic uses the last stream mapping group (num_mapping_groups
- 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
reports a value of 162 (possibly emulated by the hypervisor) and logic is
not working for stream mapping groups > 128. (Note that the ARM SMMU
architecture specification defines NUMSMRG in the range of 0-127).

So the current logic that checks the (162-1)th S2CR entry fails to detect
the quirky firmware on these devices and SMMU triggers invalid context
fault for bypass streams.

To fix this issue, rework the logic to find the first non-valid (free)
stream mapping register group (SMR) within 128 groups and use that index
to access S2CR for detecting the bypass quirk. If no free groups are
available, then just skip the quirk detection.

While at it, let's move the quirk detection logic to a separate function
and change the local variable name from last_s2cr to free_s2cr.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
* Moved the quirk handling to its own function
* Collected review tag from Bjorn

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..48362d7ef451 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
-	u32 reg;
-	u32 smr;
+	u32 free_s2cr;
+	u32 reg, smr;
 	int i;
 
+	/*
+	 * Find the first non-valid (free) stream mapping register group and
+	 * use that index to access S2CR for detecting the bypass quirk.
+	 *
+	 * Note that only the first 128 stream mapping groups are considered for
+	 * the check. This is because the ARM SMMU architecture specification
+	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
+	 * range of 0-127, but some Qcom platforms emulate more stream mapping
+	 * groups with the help of hypervisor. And those groups don't exhibit
+	 * the quirky behavior.
+	 */
+	for (i = 0; i < 128; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
+			break;
+	}
+
+	/* If no free stream mapping register group is available, skip the check */
+	if (i == 128)
+		return;
+
+	free_s2cr = ARM_SMMU_GR0_S2CR(i);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
-	 * register. Perform a write to S2CR to detect if this is the case and
-	 * if so reserve a context bank to emulate bypass streams.
+	 * register. Perform a write to the first free S2CR to detect if
+	 * this is the case and if so reserve a context bank to emulate
+	 * bypass streams.
 	 */
 	reg = FIELD_PREP(ARM_SMMU_S2CR_TYPE, S2CR_TYPE_BYPASS) |
 	      FIELD_PREP(ARM_SMMU_S2CR_CBNDX, 0xff) |
 	      FIELD_PREP(ARM_SMMU_S2CR_PRIVCFG, S2CR_PRIVCFG_DEFAULT);
-	arm_smmu_gr0_write(smmu, last_s2cr, reg);
-	reg = arm_smmu_gr0_read(smmu, last_s2cr);
+	arm_smmu_gr0_write(smmu, free_s2cr, reg);
+	reg = arm_smmu_gr0_read(smmu, free_s2cr);
 	if (FIELD_GET(ARM_SMMU_S2CR_TYPE, reg) != S2CR_TYPE_BYPASS) {
 		qsmmu->bypass_quirk = true;
 		qsmmu->bypass_cbndx = smmu->num_context_banks - 1;
@@ -296,6 +320,14 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 		reg = FIELD_PREP(ARM_SMMU_CBAR_TYPE, CBAR_TYPE_S1_TRANS_S2_BYPASS);
 		arm_smmu_gr1_write(smmu, ARM_SMMU_GR1_CBAR(qsmmu->bypass_cbndx), reg);
 	}
+}
+
+static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
+{
+	u32 smr;
+	int i;
+
+	qcom_smmu_bypass_quirk(smmu);
 
 	for (i = 0; i < smmu->num_mapping_groups; i++) {
 		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
-- 
2.25.1

