Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1CD716A31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjE3Q6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjE3Q6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:58:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F07B0;
        Tue, 30 May 2023 09:58:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f99222e80so972494566b.1;
        Tue, 30 May 2023 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685465890; x=1688057890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLTf3hfr15WKenKhSV2UjjiJSXXTO9yCrXkiF4BADdg=;
        b=VckK4mND1thc7icOCzwPvSvuE2r30Ewi4wjKx8amLipH58Z3A6+Z9NVubc5jNSMFcP
         8jOU6OqyjDLw3PP/xKMIv4Y89enuRUGyslOci4WGPSjsNzyYYJ3PZOojw8sR+SvBFWoz
         XsuZEPhaNH4wklNI6Dc4pNtABkWfayibFN8Cv6/rNqEQZHsNakAq3AxPKb5ybmqDlebR
         xkKVs6md1mmALhCnS8jXSMAOIHGGvygGDlgwhAQQFZ5aY1X/ApERm4XNJSw/yPHhUnkO
         dsreyZusBi/PlqYQpaMnoGqys+b9ywGKbKUNI24EFg1Szz5fTQ/tgOBaLAogv6uJ7x9p
         dVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465890; x=1688057890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLTf3hfr15WKenKhSV2UjjiJSXXTO9yCrXkiF4BADdg=;
        b=DSugCaUE8nb82WrA9EE+NUtocCkkmw+d6h0r8lu/UGGrFiVE2HhbqM1JH3cfImdLU7
         UXd9NSNfHKzKxiQaAu+vnS1GXDc2Jk4kfvg1p3kz1yvshHSVZPe2CYqO42pcqfiOukVe
         hWFDV0gdn251j+fbVEEYD/3J1MGd3zuA3twjXRl6RKUhl0Hr2IghZaqewIvPC7sT1ULn
         n/MlkzN/aFiTclhzcvEu8to1axYY5el4tSJTFv8IxesJtx7NAg79nfvn6f/SYl13iqUv
         iALBF1GPis2OUicS8eGhu3sHk1yYmiw9ipCLCLMQE8U75Zhk5SXuwEzJMvA0l1QyPCqJ
         uCRg==
X-Gm-Message-State: AC+VfDz+08ngBpwsyCpjnwNQa7ir3OXn0D8OJoonmsF4P2F7F7xjT6PL
        OAZ5YisqcKkVUf7L4hKOTw8=
X-Google-Smtp-Source: ACHHUZ5loRURnFtMU6yNKjsHFOGso5dUT1Lq1GcxnAMQFNQevpEa2N4QRqjZkxTOv29vgDoHJDyt1g==
X-Received: by 2002:a17:907:3da5:b0:973:92a8:f611 with SMTP id he37-20020a1709073da500b0097392a8f611mr12846509ejc.31.1685465889950;
        Tue, 30 May 2023 09:58:09 -0700 (PDT)
Received: from fedora.. (dh207-97-232.xnet.hr. [88.207.97.232])
        by smtp.googlemail.com with ESMTPSA id c7-20020a17090603c700b0096a68648329sm7546061eja.214.2023.05.30.09.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:58:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Tue, 30 May 2023 18:58:06 +0200
Message-Id: <20230530165807.642084-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 comes in 2 families:
* IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
* IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz

So, in order to be able to share one OPP table lets add support for IPQ8074
family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.

IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
will get created by NVMEM CPUFreq driver.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Print an error if SMEM ID is not part of the IPQ8074 family
and restrict the speed to Acorn variant (1.4GHz)
---
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 43 ++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ea86c9f3ed7a..78f6ff933f93 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -170,6 +170,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "ti,am62a7", },
 
 	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a88b6fe5db50..ce444b5962f2 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -31,6 +31,9 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
+#define IPQ8074_HAWKEYE_VERSION		BIT(0)
+#define IPQ8074_ACORN_VERSION		BIT(1)
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -204,6 +207,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	u32 msm_id;
+	int ret;
+	*pvs_name = NULL;
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8070A:
+	case QCOM_ID_IPQ8071A:
+		drv->versions = IPQ8074_ACORN_VERSION;
+		break;
+	case QCOM_ID_IPQ8072A:
+	case QCOM_ID_IPQ8074A:
+	case QCOM_ID_IPQ8076A:
+	case QCOM_ID_IPQ8078A:
+		drv->versions = IPQ8074_HAWKEYE_VERSION;
+		break;
+	default:
+		dev_err(cpu_dev,
+			"SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
+			msm_id);
+		drv->versions = IPQ8074_ACORN_VERSION;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
+	.get_version = qcom_cpufreq_ipq8074_name_version,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -363,6 +405,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
-- 
2.40.1

