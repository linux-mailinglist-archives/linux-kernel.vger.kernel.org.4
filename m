Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9465B54E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbjABQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjABQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:50:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BEA1B0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:50:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so42256838lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Hsdkn9Ik2bsrBztjUnz8QbQ+4RQ0dV6PdSxg6F+H8=;
        b=iM/zicdP4fDksBdQClbPeGnvZ2ZdUJzYaVLfEqaCgpyG0mgT8VCI0YUwrizq31W+zb
         aBVvZRBGvjKps55MjEVa1+Vc5rxYutQh45lkayaIT4dvLaJUmFGJTnDaH3q+Tve/lLFq
         hYegFz5B/O3/k+zdtWhWLzGC7UEdtZ9hc3KXyLY6T7OuAmTsTvF9KoZZ+Gk4y734Qa8A
         LOYbnwzZMyoRi9QcHkoMSSBZoYq0CvvXW5EnDGJxlBoJ6hWgw06BMt2Cc1xbprGVk3C8
         VuyMQNZdRQomcF39GFjv2fvTmi3rY85aaD9gZLkTbg4ZmSxblEBESoBA7P4h838WY87y
         Gkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0Hsdkn9Ik2bsrBztjUnz8QbQ+4RQ0dV6PdSxg6F+H8=;
        b=5hXTAR6wekXLgzzfyfn9zJA7e2fopEvT6z1cmijFeuma8aQTintZ8dbURPsTfj57Tx
         hSRmj1AjailBnfaGczFho7rczo27dO/9YaJpWNBcdEjmhiZ5BYKA/y+qiUZURTop5JUN
         0htw1p6N5gGc03kjLNH2dAOgH5zyEfJXWC9tJjxGmOLLpZ1hjB18AMTr19OedfFRZ/Vd
         RzUmXvvT2M84nR0ypZmGiFfjOmPphZFvRk6BtNsjm106LOAsRqM2W5aJga6si2rQSnux
         JiGqZCiW/0bdE6IjHRtRJdNg1yZdsxvLZ89Bk+yl9kJSZlGKlQdbh9UVpLZhf4Mil9JJ
         NwQg==
X-Gm-Message-State: AFqh2kprXj9252zd43HUXgrNMJ7253lFv48tvruol41GdT9/0pkfFJvj
        ZsCLjxeVlyCntLcZIByDWqzzCQ==
X-Google-Smtp-Source: AMrXdXsTRfgOlSc/J+mZZreOlJvJGk9L6RUEAWxCdOrSYW2yM6lIlnuzyn6CFI18QGR66ChJ383ewQ==
X-Received: by 2002:a05:6512:32cb:b0:4c5:38ae:4b1e with SMTP id f11-20020a05651232cb00b004c538ae4b1emr15797405lfg.45.1672678240762;
        Mon, 02 Jan 2023 08:50:40 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id o8-20020ac24348000000b004b49025f96dsm4510491lfl.187.2023.01.02.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 08:50:40 -0800 (PST)
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
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 2/2] soc: qcom: rmtfs: Optionally map RMTFS to NAV VM
Date:   Mon,  2 Jan 2023 17:50:34 +0100
Message-Id: <20230102165034.830620-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102165034.830620-1-konrad.dybcio@linaro.org>
References: <20230102165034.830620-1-konrad.dybcio@linaro.org>
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

From: Loic Poulain <loic.poulain@linaro.org>

Some SoCs require that RMTFS is also mapped to the NAV VM. Trying to
power on the modem without that results in the whole platform crashing
and forces a hard reboot within about 2 seconds.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[Konrad: reword, make conditional, add a define for NAV VMID]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

 drivers/soc/qcom/rmtfs_mem.c | 22 +++++++++++++++-------
 include/linux/qcom_scm.h     |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0feaae357821..999f2c5b49b0 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -171,12 +171,13 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
 static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct qcom_scm_vmperm perms[2];
+	struct qcom_scm_vmperm perms[3];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
+	bool assign_to_nav;
 	u32 client_id;
 	u32 vmid;
-	int ret;
+	int ret, cnt = 0;
 
 	rmem = of_reserved_mem_lookup(node);
 	if (!rmem) {
@@ -191,6 +192,8 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	}
 
+	assign_to_nav = of_property_read_bool(node, "qcom,assign-to-nav");
+
 	rmtfs_mem = kzalloc(sizeof(*rmtfs_mem), GFP_KERNEL);
 	if (!rmtfs_mem)
 		return -ENOMEM;
@@ -236,14 +239,19 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 			goto remove_cdev;
 		}
 
-		perms[0].vmid = QCOM_SCM_VMID_HLOS;
-		perms[0].perm = QCOM_SCM_PERM_RW;
-		perms[1].vmid = vmid;
-		perms[1].perm = QCOM_SCM_PERM_RW;
+		perms[cnt].vmid = QCOM_SCM_VMID_HLOS;
+		perms[cnt++].perm = QCOM_SCM_PERM_RW;
+		perms[cnt].vmid = vmid;
+		perms[cnt++].perm = QCOM_SCM_PERM_RW;
+
+		if (assign_to_nav) {
+			perms[cnt].vmid = QCOM_SCM_VMID_NAV;
+			perms[cnt++].perm = QCOM_SCM_PERM_RW;
+		}
 
 		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
 		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
-					  &rmtfs_mem->perms, perms, 2);
+					  &rmtfs_mem->perms, perms, cnt);
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

