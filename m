Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB370FBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjEXQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233428AbjEXQXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:23:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD2EE9;
        Wed, 24 May 2023 09:23:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f683e8855so164346866b.2;
        Wed, 24 May 2023 09:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684945416; x=1687537416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utXuBuOV4BNhpTKyYQ/PC8Nvs5FwMBOaU9WF5xMzoa4=;
        b=EaXQVjYZpCwsP7gl6z2uzhDQD334YQJXgKyj6QjjAmPRDcEszws+8sHWOWgzsW8e+0
         vE69lzFF93Cls7JebgARoZo/O9GmfjmwRHOYHrq9ORx/RVTqhep6nEXNlk8L0FVua0P5
         eBPZtpZ0bGVkTy7GJeg1VQpYLgkBkljpTafg40iIT0iQF5QNHUqGJqgIGjdaZZtDkmTb
         t3oiKUSX7xAwpdGUksLgYcaWHFG4He6FO5uVM53yvo57HAWT8Mn+Q+qeTXMjDUKJroDM
         n8RRcUhh4Mt20aaamJX/gTv+7ZIqGgzn4c6JcpdzTS6rFhM32z1WetXKJapEQb6Jfejm
         Swmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684945416; x=1687537416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utXuBuOV4BNhpTKyYQ/PC8Nvs5FwMBOaU9WF5xMzoa4=;
        b=E7uFYaQtI2Zninylbx60ITjpuHLNgn8eTNEkIOpnQg5dZetkGdOuhdP2C4Us0N26RC
         kHL4N2DYobHch01fH39izAGa3h5Yb6CPtzDBpLIGaavybsjw51uDZnYUdmjiVto21ooh
         brWer32sfsgodPaOFuhmnOfn2MdfnAg+xcMj3ZjePq2i8LzM7Ag/9YJSn2pNACF3JcIO
         NBdlLKRgaQMzdo41NKDTNv9bCZ0TqbJaT5UFyPQA1tojTeszpBK2peTyxFKzaxHjSFDd
         u3gJddfeUpVXLEcqHQ1z3xxl66ZHPsH0NqQQD35DQBEd6VGqvxFykHJVgY2XIUOTv5Mk
         1gsg==
X-Gm-Message-State: AC+VfDyClVB0sISqbN+FLRPPRtk1WtI30n9itAtk46AKdZ+5BEI+Bk9h
        /ifGoowdOvYGLLlnBRRn8is=
X-Google-Smtp-Source: ACHHUZ4siiTv5Fzmfm6INR4YCNR1UngZT3T3OZwJ/r2h269CsO3xf969qVqHaCT17IyZL2AKFjXRgA==
X-Received: by 2002:a17:907:2ce5:b0:96a:52e:5379 with SMTP id hz5-20020a1709072ce500b0096a052e5379mr17116756ejc.63.1684945415775;
        Wed, 24 May 2023 09:23:35 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id p19-20020a170906229300b0096f5b48fe43sm5913793eja.47.2023.05.24.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:23:35 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/4] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Date:   Wed, 24 May 2023 18:23:29 +0200
Message-Id: <20230524162329.819770-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524162329.819770-1-robimarko@gmail.com>
References: <20230524162329.819770-1-robimarko@gmail.com>
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

Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
into an enum, however there is no reason to do so and we can just match
directly on the SMEM SoC ID as returned by qcom_smem_get_msm_id().

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Utilize helper exported by SMEM instead of refactoring
qcom_cpufreq_get_msm_id()
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 55 +++++-----------------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 60e99be2d3db..4293e2888797 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -29,16 +29,8 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
-#define MSM_ID_SMEM	137
-
 #include <dt-bindings/arm/qcom,ids.h>
 
-enum _msm8996_version {
-	MSM8996_V3,
-	MSM8996_SG,
-	NUM_OF_MSM8996_VERSIONS,
-};
-
 struct qcom_cpufreq_drv;
 
 struct qcom_cpufreq_match_data {
@@ -135,60 +127,31 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
 	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
 }
 
-static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
-{
-	size_t len;
-	u32 *msm_id;
-	enum _msm8996_version version;
-
-	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
-	if (IS_ERR(msm_id))
-		return NUM_OF_MSM8996_VERSIONS;
-
-	/* The first 4 bytes are format, next to them is the actual msm-id */
-	msm_id++;
-
-	switch ((enum _msm_id)*msm_id) {
-	case QCOM_ID_MSM8996:
-	case QCOM_ID_APQ8096:
-		version = MSM8996_V3;
-		break;
-	case QCOM_ID_MSM8996SG:
-	case QCOM_ID_APQ8096SG:
-		version = MSM8996_SG;
-		break;
-	default:
-		version = NUM_OF_MSM8996_VERSIONS;
-	}
-
-	return version;
-}
-
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  char **pvs_name,
 					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
+	int msm_id;
 	u8 *speedbin;
-	enum _msm8996_version msm8996_version;
 	*pvs_name = NULL;
 
-	msm8996_version = qcom_cpufreq_get_msm_id();
-	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
-		dev_err(cpu_dev, "Not Snapdragon 820/821!");
-		return -ENODEV;
-	}
+	msm_id = qcom_smem_get_msm_id();
+	if (msm_id < 0)
+		return msm_id;
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
-	switch (msm8996_version) {
-	case MSM8996_V3:
+	switch (msm_id) {
+	case QCOM_ID_MSM8996:
+	case QCOM_ID_APQ8096:
 		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
-	case MSM8996_SG:
+	case QCOM_ID_MSM8996SG:
+	case QCOM_ID_APQ8096SG:
 		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
 		break;
 	default:
-- 
2.40.1

