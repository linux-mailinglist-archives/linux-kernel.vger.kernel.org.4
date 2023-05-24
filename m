Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8A70FBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjEXQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjEXQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:23:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC3912F;
        Wed, 24 May 2023 09:23:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so31010a12.0;
        Wed, 24 May 2023 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684945413; x=1687537413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/ycEJUTtAvi7GqgpK2zlFsLIGEJyRG8499TbrV7bF8=;
        b=AtJCedqw7nCCBMw/v9uxTNYD5Zg9FPuoDc4lUvqOiF4tI/xA5h/bg9eoiNEZF3zZZS
         NaNjRKQ5iiaCXB24tQ+xgnGgSvXsGDdGOzQgUoqqsN3WYanzIt7bpXbMofpXF+jZXWmn
         aLvCrfz3NYQ4k3jAZ8FizXMLfds2/V9DyFWTXP26a00qY2g9xa+vN43uzepu34uGml6C
         6odowDAVKse38OmYmGXKaJy9djuJDZ0ftIUYg4jA69dVghto746pYwCIETg8rspSMqPU
         pGrNg6ycDX2SQGorD4NmWozexz7uAFKYVnqcBEV2lkqm7iriWF4/SeGGXj11rdTnUtAp
         RI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684945413; x=1687537413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/ycEJUTtAvi7GqgpK2zlFsLIGEJyRG8499TbrV7bF8=;
        b=hn5i42675+4gL5QVx4vciS6yCqY1tkVOJ/HgLG2vn3Y8pBFQVkwnAXSseI0OkBdPLO
         LHS/rqJRK8PXgJWrZHyiUzrObPO1b/f9VVFHbyndXm5LTt4/WrT9IPEuxVwBCLNyfEf7
         MHlYYcW+cY8kB5EMGE5Djnz2uJ6RYKW59SHui+1jgbKJAHWawj/BJTs42bakGQxqztyb
         g99/1AgkWOFd+mHetkWuePwFpOV8cscuK21tRYa1SmystNDTbmrOmP6+4NVaAuca9wyv
         GBsBpcrdVQYYYUc07uqvWGMuDFiFiIw+rxsCzh3A8AU5pvxO2RgC4nIuVDnWDMMXw/tu
         Rr3A==
X-Gm-Message-State: AC+VfDzmfcBIwAhOjZM3RSX0Q5NXMPdZ0uhdlbCtDWwLrkCvSZOrYAJx
        kaGlHLSrNaO85+eLo7wzlvo=
X-Google-Smtp-Source: ACHHUZ56ZChcvKAYIQXUlS6gupUgJPC8PLWKayRJD2ZiW+tGr59q4nQy/ARzZvkGOWkpBgfuvtotvQ==
X-Received: by 2002:a17:907:d9f:b0:973:84b0:b077 with SMTP id go31-20020a1709070d9f00b0097384b0b077mr2792885ejc.33.1684945413244;
        Wed, 24 May 2023 09:23:33 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id p19-20020a170906229300b0096f5b48fe43sm5913793eja.47.2023.05.24.09.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:23:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Date:   Wed, 24 May 2023 18:23:27 +0200
Message-Id: <20230524162329.819770-2-robimarko@gmail.com>
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

Introduce a helper to return the SoC SMEM ID, which is used to identify the
exact SoC model as there may be differences in the same SoC family.

Currently, cpufreq-nvmem does this completely in the driver and there has
been more interest expresed for other drivers to use this information so
lets expose a common helper to prevent redoing it in individual drivers
since this field is present on every SMEM table version.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
 include/linux/soc/qcom/smem.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 6be7ea93c78c..0d6ba9bce8cb 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
@@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 }
 EXPORT_SYMBOL(qcom_smem_virt_to_phys);
 
+/**
+ * qcom_smem_get_msm_id() - return the SoC ID
+ *
+ * Look up SoC ID from HW/SW build ID and return it.
+ */
+int qcom_smem_get_msm_id(void)
+{
+	size_t len;
+	struct socinfo *info;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	return __le32_to_cpu(info->id);
+}
+EXPORT_SYMBOL(qcom_smem_get_msm_id);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index 86e1b358688a..6448607239e6 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
 
 phys_addr_t qcom_smem_virt_to_phys(void *p);
 
+int qcom_smem_get_msm_id(void);
+
 #endif
-- 
2.40.1

