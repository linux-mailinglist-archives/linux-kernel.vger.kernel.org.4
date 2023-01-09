Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B64C6621D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjAIJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbjAIJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:39:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE4F64DE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:39:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu8so12058184lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlSrO19imkFWHjtVxLiPaME8EodVCSuJJSxNid8kMXw=;
        b=v0H9MSMl7JeXAJjrf7tfZwVk87wKMAwFZDXnJvk10G6QGBYbbwJWGS410gW0oLJlJ3
         rJdp1p1pXGyxSs+VGNZL4V5wYra49D9x6cRt1dFiwFL8fPZp3Ib8MatgDTouJnCTjnQS
         JyEppg01sGP2rykpmncriog3a8G3EX6kJ7KsX7XLsnPNv7rCS0BU5ATZA8zcpbFHVAKs
         R5UKU8Sh/zydFn1Jb+q49TSgdnhb/WFsAHIi6JwlZz27tm0QZF3p8F6xdkX1vTJQH4xQ
         7IFoOkATexkbYLk6Qc8IwWG0TK87nKl98Y/Kt5nI/xXyrFjj2+ktTRl7wS+x4rE+3Tzx
         UEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlSrO19imkFWHjtVxLiPaME8EodVCSuJJSxNid8kMXw=;
        b=Z5PMXH0HC7jP9Ee4z6+3Oi8H4958V3ujjXO6c4dPuO/nVbodb8SD+oFOPRPLpNl8XQ
         ptf2H2uVM0IF+iCmfBTdd7WP7cEIqliDNJBGAcGuSJCZTv95OU+3v3l69inh0eQDZO7J
         N/CXHidmqcemCjivvwtvHf33i00lyzK7w31Nfjwd1skKhKzBH65iZKmX0uOX6Gn/5Wnv
         UyPfksHAqHMFFpxliKYGWU9Bsxke4fIX4Ubeb15hepKa6UncskoYGxC5GcGGfeqOR+jJ
         ESiD37DU3wUnqh1L35brITICOMUi/vGaSlqiQ2miZQl8nOIMSHZhdjw7yFbx07r+ejH5
         NGxA==
X-Gm-Message-State: AFqh2kqvlwgfqDoKknZmLaPTZLJKYHfYtcIj+R1XnILIWLhWBLdJYca9
        6i+URvII6M+xwtasF2m0ePTiwQ==
X-Google-Smtp-Source: AMrXdXu2EONeoS2PIcFkA507dUo2SiqiY15c4LlXOfOEvggtM71+5brDckb/khEefXYQl/2U1c+1pQ==
X-Received: by 2002:a19:650a:0:b0:4aa:978:32fb with SMTP id z10-20020a19650a000000b004aa097832fbmr21904725lfb.31.1673257193054;
        Mon, 09 Jan 2023 01:39:53 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id b8-20020a056512060800b004cb1de3f487sm1526257lfe.104.2023.01.09.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:39:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 2/3] soc: qcom: rmtfs: Optionally map RMTFS to more VMs
Date:   Mon,  9 Jan 2023 10:39:46 +0100
Message-Id: <20230109093947.83394-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109093947.83394-1-konrad.dybcio@linaro.org>
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

Some SoCs require that RMTFS is also mapped to the NAV VM. Trying to
power on the modem without that results in the whole platform
crashing and forces a hard reboot within about 2 seconds. Add support
for mapping the region to additional VMs, such as NAV to open a path
towards enabling modem on such platforms.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[Konrad: reword, make conditional and flexible, add a define for NAV VMID]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:
Rewrite, make it accept more than just NAV through qcom,vmid

 drivers/soc/qcom/rmtfs_mem.c | 29 ++++++++++++++++++++++-------
 include/linux/qcom_scm.h     |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0feaae357821..9d59ad509a5c 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -17,6 +17,7 @@
 #include <linux/qcom_scm.h>
 
 #define QCOM_RMTFS_MEM_DEV_MAX	(MINORMASK + 1)
+#define NUM_MAX_VMIDS		2
 
 static dev_t qcom_rmtfs_mem_major;
 
@@ -171,12 +172,12 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
 static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct qcom_scm_vmperm perms[2];
+	struct qcom_scm_vmperm perms[NUM_MAX_VMIDS + 1];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
 	u32 client_id;
-	u32 vmid;
-	int ret;
+	u32 num_vmids, vmid[NUM_MAX_VMIDS];
+	int ret, i;
 
 	rmem = of_reserved_mem_lookup(node);
 	if (!rmem) {
@@ -226,7 +227,18 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		goto put_device;
 	}
 
-	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
+	num_vmids = of_property_count_u32_elems(node, "qcom,vmid");
+	if (num_vmids < 0) {
+		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", ret);
+		goto remove_cdev;
+	} else if (num_vmids > NUM_MAX_VMIDS) {
+		dev_warn(&pdev->dev,
+			 "too many VMIDs (%d) specified! Only mapping first %d entries\n",
+			 num_vmids, NUM_MAX_VMIDS);
+		num_vmids = NUM_MAX_VMIDS;
+	}
+
+	ret = of_property_read_u32_array(node, "qcom,vmid", vmid, num_vmids);
 	if (ret < 0 && ret != -EINVAL) {
 		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
 		goto remove_cdev;
@@ -238,12 +250,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 		perms[0].vmid = QCOM_SCM_VMID_HLOS;
 		perms[0].perm = QCOM_SCM_PERM_RW;
-		perms[1].vmid = vmid;
-		perms[1].perm = QCOM_SCM_PERM_RW;
+
+		for (i = 0; i < num_vmids; i++) {
+			perms[i + 1].vmid = vmid[i];
+			perms[i + 1].perm = QCOM_SCM_PERM_RW;
+		}
 
 		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
 		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
-					  &rmtfs_mem->perms, perms, 2);
+					  &rmtfs_mem->perms, perms, num_vmids + 1);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "assign memory failed\n");
 			goto remove_cdev;
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index f8335644a01a..150b72edb879 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -55,6 +55,7 @@ enum qcom_scm_ice_cipher {
 #define QCOM_SCM_VMID_MSS_MSA    0xF
 #define QCOM_SCM_VMID_WLAN       0x18
 #define QCOM_SCM_VMID_WLAN_CE    0x19
+#define QCOM_SCM_VMID_NAV        0x2B
 #define QCOM_SCM_PERM_READ       0x4
 #define QCOM_SCM_PERM_WRITE      0x2
 #define QCOM_SCM_PERM_EXEC       0x1
-- 
2.39.0

