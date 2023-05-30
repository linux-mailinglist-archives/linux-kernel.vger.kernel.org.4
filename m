Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79CB716A34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjE3Q6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjE3Q6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:58:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF02A7;
        Tue, 30 May 2023 09:58:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96f50e26b8bso869181266b.2;
        Tue, 30 May 2023 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685465891; x=1688057891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD/k7lu42WU94j/4jyYC1ZkyaWqarmNUB0MS9bMyYOM=;
        b=A9Q494rVLfO+wK0NCAjogfWBJPD2HCpQTz9IQT5E/00M5SKYjDb0KgJtrd6wa/UP0i
         IeCXUinnUnpgEwA9Nkmw2q+sdFP1REJM9VNyKDcjUGwyyT/FItGFrZyiPPEjrbXKfr4/
         BWz6VnCJaGuLBovVGttzaZl7ZUxotMbTBBdq+QZB2DQ4xTKtr67537HS7Z9fl5nn2SbX
         63mMXdZ7wKzpK4sKYFQ/+IDNb0/hs8xIkgScmu28v6wEfg5kTv55a6GOz6eHGyeeMuwH
         mIVO+HOmurywuHINs+bATr+PR1qesFQEivh0VPK7rD2kwmOuB+N7l156e/mRp015TB2q
         Xb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685465891; x=1688057891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD/k7lu42WU94j/4jyYC1ZkyaWqarmNUB0MS9bMyYOM=;
        b=e8htbfbsGJIe0ZeHQKan23SAo2YEGQuDaamdrb6BBOgRWhBL/bE0C1W5koL4rm0YkZ
         IhXOG4mxfBqhyfE+MtbPg5u3Uhum1GdROJ/zlxGnO68WYpxm/Ui3AXelB0IsNRnhLH1u
         dFYdzTw29ZDgCBHs0fq5gdfghJyph0KMH9DjM89TrLC6uZkbPXM6E3Z0BNKgXTR0K1F3
         EdOobUt6X+G8SEfx5dIPV7HxkeuvoDsvKAJk9uejXR64FLmOKfOwHxnZ1QF+8RvvhswG
         whAZGxT5PKu3CT5g/6LsNEMwdAeNai0f8A4/bCfhPRhs705KDp+1pBOONnbjXXJy9Ev+
         YlPg==
X-Gm-Message-State: AC+VfDxnhID/T1JCQciUCcrZ41ygOQwU7otjQQa95G1KuKeOhM0n5AFd
        5jzFjhgpXForw/S06qJa+HY=
X-Google-Smtp-Source: ACHHUZ7/itg05PvkGgCzjBScvKApBuN2uggxHSzYIKrJhbSd35rf+tgzgpJIjshjhgQ72uNy5Z484A==
X-Received: by 2002:a17:907:c12:b0:973:9522:c678 with SMTP id ga18-20020a1709070c1200b009739522c678mr3095986ejc.44.1685465891084;
        Tue, 30 May 2023 09:58:11 -0700 (PDT)
Received: from fedora.. (dh207-97-232.xnet.hr. [88.207.97.232])
        by smtp.googlemail.com with ESMTPSA id c7-20020a17090603c700b0096a68648329sm7546061eja.214.2023.05.30.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:58:10 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for IPQ8064
Date:   Tue, 30 May 2023 18:58:07 +0200
Message-Id: <20230530165807.642084-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530165807.642084-1-robimarko@gmail.com>
References: <20230530165807.642084-1-robimarko@gmail.com>
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

From: Christian Marangi <ansuelsmth@gmail.com>

IPQ8064 comes in 3 families:
* IPQ8062 up to 1.0GHz
* IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
* IPQ8065/IPQ8069 up to 1.7Ghz

So, in order to be able to share one OPP table, add support for
IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
IPQ8064.

Bit are set with the following logic:
* IPQ8062 BIT 0
* IPQ8064/IPQ8066/IPQ8068 BIT 1
* IPQ8065/IPQ8069 BIT 2

speed is never fused, only psv values are fused.
Set speed to the versions to permit a unified opp table following
this named opp:

opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0

Example:
- for ipq8062 psv2
  opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
- for ipq8064 psv2
  opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
- for ipq8065 psv2
  opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ce444b5962f2..c644138680ba 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -34,6 +34,10 @@
 #define IPQ8074_HAWKEYE_VERSION		BIT(0)
 #define IPQ8074_ACORN_VERSION		BIT(1)
 
+#define IPQ8062_VERSION		BIT(0)
+#define IPQ8064_VERSION		BIT(1)
+#define IPQ8065_VERSION		BIT(2)
+
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0;
+	int msm_id, ret = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	switch (len) {
+	case 4:
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
+				       speedbin);
+		break;
+	default:
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		ret = -ENODEV;
+		goto len_error;
+	}
+
+	ret = qcom_smem_get_soc_id(&msm_id);
+	if (ret)
+		return ret;
+
+	switch (msm_id) {
+	case QCOM_ID_IPQ8062:
+		drv->versions = IPQ8062_VERSION;
+		break;
+	case QCOM_ID_IPQ8064:
+	case QCOM_ID_IPQ8066:
+	case QCOM_ID_IPQ8068:
+		drv->versions = IPQ8064_VERSION;
+		break;
+	case QCOM_ID_IPQ8065:
+	case QCOM_ID_IPQ8069:
+		drv->versions = IPQ8065_VERSION;
+		break;
+	default:
+		dev_err(cpu_dev,
+			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
+			msm_id);
+		drv->versions = IPQ8062_VERSION;
+		break;
+	}
+
+	/*
+	 * IPQ8064 speed is never fused. Only psv values are fused.
+	 * Set speed to the versions to permit a unified opp table.
+	 */
+	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
+		 drv->versions, pvs, pvs_ver);
+
+len_error:
+	kfree(speedbin);
+	return ret;
+}
+
 static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
@@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
+	.get_version = qcom_cpufreq_ipq8064_name_version,
+};
+
 static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
 	.get_version = qcom_cpufreq_ipq8074_name_version,
 };
@@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
-	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
-- 
2.40.1

