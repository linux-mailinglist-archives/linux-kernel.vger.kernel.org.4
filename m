Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF216B9EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCNSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCNSri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:47:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0FB79D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:47:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so6974177pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpiDPV6205M5h8bqVFYHaaAk5mlWpnrzsDJlxhDj4wc=;
        b=oCIgU7JMjQpLn46jQ77R/mhDV9eGuDUoffPrfCIqkdC/ewgl5MGXUwcsQII6Gx9YQx
         1G2aCGdEggBu5LZZxUKbLtU6tIBpQT7TKAS6FbudToJyon/o5E6tblEVKXQ6zZNiNw4u
         wtcdB/WWAoX6wBx17h79kepvv/FYYAwksbUyWssAvwPhrl24fQusChPo3SgosrkFM0YK
         BESclnIzMp/KTA/i6qzeyAmYmWtvlYrnu6+Av+SWD2R3GQiw1lgI2IQzKejxzm/mJl0G
         Dc1oFfaDbYImcm2DqALJNuCs9rs+jeH1IW/k8aNaPHlpSHWf+NsWcpub1OclVMsjPwLv
         HcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpiDPV6205M5h8bqVFYHaaAk5mlWpnrzsDJlxhDj4wc=;
        b=yS4PUtxWvYiNRHauroDU0snoXQuA43lxDlq2biAhI5J4ERDF/RYLADF3+ds06wPf0+
         apKNNfxZxKDYRmESbN4iyBr4d1UIYTKlAey/ti0h9oByBMqdTDeZFrIlusb4neZBlwja
         9bJSDDr3EzQV0beKhQqJ/Yop8+Wg5uGajPlazSKaBnayoS1ST5e34qCsVC1irP31UWQB
         nPdEKss1FOPNcQycVWLmDN0qcGrQbxGoiiLpDXQp8y/Pfdr/uNl3CE9tfIdmfMibJPqN
         zzqW9gUOJt40SUTf4+XEVC7S7/XGo8sldOfjj2bkVTdzfgG2tcu2rnMrhnzPfzcDDxQp
         Vwmw==
X-Gm-Message-State: AO0yUKV7BB6Ctdh7AatU7JLl1Hppy/73gka47E2VbN6QpdiWImZrXwJd
        wRZJro7zh8ar2y/L3g6ukdQF
X-Google-Smtp-Source: AK7set8sgfpF9mOdApPMdOBZ0pPNFxOPsRMsrK4PacGoB22l6tBaUnEkaBRLdNhQm73S/0ueBJwZbw==
X-Received: by 2002:a17:902:740c:b0:19f:2dff:2199 with SMTP id g12-20020a170902740c00b0019f2dff2199mr10106839pll.68.1678819628793;
        Tue, 14 Mar 2023 11:47:08 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id kz11-20020a170902f9cb00b001a0667822c8sm1920782plb.94.2023.03.14.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:47:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     robin.murphy@arm.com, andersson@kernel.org,
        johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3] iommu/arm-smmu-qcom: Rework the logic finding the bypass quirk
Date:   Wed, 15 Mar 2023 00:16:59 +0530
Message-Id: <20230314184659.176473-1-manivannan.sadhasivam@linaro.org>
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
- 1) as an index for finding quirky firmware. But on SC8280XP, NUMSMRG
reports a value of 162 due to emulation and the logic is not working for
stream mapping groups > 128. (Note that the ARM SMMU architecture
specification defines NUMSMRG in the range of 0-127).

So the current logic that checks the (162-1)th S2CR entry fails to detect
the quirky firmware on these devices and SMMU triggers invalid context
fault for bypass streams.

To fix this issue, let's limit "num_mapping_groups" to 128 as per ARM SMMU
spec and rework the logic to find the first non-valid (free) stream mapping
register group (SMR) and use that index to access S2CR for detecting the
bypass quirk. If no free groups are available, then just skip the quirk
detection.

While at it, let's move the quirk detection logic to a separate function
and change the local variable name from last_s2cr to free_s2cr.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v3:

* Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
  check for 128 groups in qcom_smmu_bypass_quirk()
* Reworded the commit message accordingly

Changes in v2:

* Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
* Moved the quirk handling to its own function
* Collected review tag from Bjorn

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 52 ++++++++++++++++++----
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..301396b29024 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -266,25 +266,42 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
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
+	 */
+	for (i = 0; i < smmu->num_mapping_groups; i++) {
+		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
+
+		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
+			break;
+	}
+
+	/* If no free stream mapping register group is available, skip the check */
+	if (i == smmu->num_mapping_groups)
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
@@ -296,6 +313,25 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
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
+	/*
+	 * Limit the number of stream matching groups to 128 as the ARM SMMU architecture
+	 * specification defines NUMSMRG (Number of Stream Mapping Register Groups) in the
+	 * range of 0-127, but some Qcom platforms emulate more stream mapping groups. And
+	 * those groups don't exhibit the same behavior as the architecture supported ones.
+	 */
+	if (smmu->num_mapping_groups > 128) {
+		dev_warn(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+		smmu->num_mapping_groups = 128;
+	}
+
+	qcom_smmu_bypass_quirk(smmu);
 
 	for (i = 0; i < smmu->num_mapping_groups; i++) {
 		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
-- 
2.25.1

