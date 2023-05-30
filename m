Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADEC716A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjE3QyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjE3QyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:54:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4AA7;
        Tue, 30 May 2023 09:54:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fab30d1e1so1509266b.0;
        Tue, 30 May 2023 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685465652; x=1688057652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLTf3hfr15WKenKhSV2UjjiJSXXTO9yCrXkiF4BADdg=;
        b=OdauBByk/4fWn5vdwv9K0Zkj/mCjod7MfPokGyDslcKlskTcDqQde5KqMsFwBrMr+O
         924hSdZ6mh0gqfZgugQLaFyy+8G5ddbSS3zgvUgwJVUXnzZv37jG61HOLHdziWzu53Lt
         XSIwmX0tmpchUi8z0Rc4txEwOx1F0GkPIiYPKC2A//CfBCIDnYD5+2KSwT+UqjjEwI4c
         U7osuFcgKQeMYInjvRGRoVU+OZEa//CLrux9Z41VulErUNUMXNumkqikMe+6lpkv1Rme
         Z8VfoBcSbd1xGSloZS1gpgMJ8fiQsxjGFYYR7OUQSqXJginMJNggjpwpUrraOno21pp7
         admQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465652; x=1688057652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLTf3hfr15WKenKhSV2UjjiJSXXTO9yCrXkiF4BADdg=;
        b=N7PG/7hc58XG8rKo8vGtrGZbM9ZGmXxC2krIM7wdDwcPr8cUQtGwQVTVZ0oqkVJWgA
         qDTUW6TLt0aiFC1h/bVA0MlWXmLy9yrJUFc9Z2BOpza5w+XHSJU1wGZzwWI/j24YdJAq
         aFgR0oFmVMgT1qPyIrmoItLor5Qr4wsE0VDnXOAI1/disHyK7+XtI7ZySYGFFMRiuBQy
         RERSuUwI2REVJcj7ZQzg0uztOnJlDzAFx5lCiN9ASI5oSAc1NqLWUxUd9fsCGyWo+FWK
         xbbvGciwM0LSOHO5ZUK/+eJZpwhuNczG0+Asd/5ErhCAzGGSRhtsRMlSP3J3SZAmStmc
         yLJQ==
X-Gm-Message-State: AC+VfDwP0ANtumhW1pH3V+Wm8SeqqB6uV7fQ5tWtnXh/P9NWOsm9zhg+
        mDhs4ZhOhP4nFCk77PbKON8=
X-Google-Smtp-Source: ACHHUZ7jTc3ye0a75afJFSxP1Ezqnp6f82T1kILzjr4MGO8f0FkvlPx01Dl7zA+qd5oOXYlYSTpDpw==
X-Received: by 2002:a17:907:934b:b0:973:87d3:80d4 with SMTP id bv11-20020a170907934b00b0097387d380d4mr2667275ejc.18.1685465652312;
        Tue, 30 May 2023 09:54:12 -0700 (PDT)
Received: from fedora.. (dh207-97-232.xnet.hr. [88.207.97.232])
        by smtp.googlemail.com with ESMTPSA id d12-20020a17090648cc00b00965e9a23f2bsm7554331ejt.134.2023.05.30.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:54:11 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
Date:   Tue, 30 May 2023 18:54:08 +0200
Message-Id: <20230530165409.641661-1-robimarko@gmail.com>
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

