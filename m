Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A506DB503
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDGUPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDGUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:14:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D459F1BC5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:14:50 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q16so55678061lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680898489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3nsx7fTooCsHlb+iQOPq8i6PDjNQ7J7ivbonnB4f0g=;
        b=Z8vc6jpcWix01rDMGNR5PCpgd+r96K1dnJUCfKV7qM4GZtoljfuq7IBcdUCo8ooyTU
         m09IsKdPTF2AKqu3wDIoxrpIJ8iimjjuBgdfli5PSAJi4Tdz/NzUZ7PAlF7X4whGoxRO
         Sy5JfXLxQdxKeD/S3e7nmrHx6iId8R8ukvPQLr6wNPkms9xuBl8ZMViBwX1TLxVjuI4V
         GALzUti2PrVQRe0isUUqcBJHR7D6pSxQvB9wVtwHSrRLXGb5ga2HrKejmx/ZCkix8ww/
         mMWnEHkPy6gLSUeb74HQOjDfgBZVmINA/OB7JUDSapX6vYWtGqZYoiq30nUyIvIMAej7
         PGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3nsx7fTooCsHlb+iQOPq8i6PDjNQ7J7ivbonnB4f0g=;
        b=DiAHFZVzLLaW7SiXTdjdhsG86LazPn44fDee5aySnIbBcLeizJArITrB7oZy2lQ6xn
         DqvjtJQxuzRCu3lvbZMa2xqZzeEIXjwiJZjadzoZ0xzzYy3yl4f7OQFq2YDlvaadMYF/
         PBOML3g/kTswhAc2LBB7CjgwyQqZzDYS46oMlh84iThJ/9Ds0kVeKOqVh8okvGVVvKrT
         KAmWSj1V/D8TzNusKsLl3EoUz2AyvLtbgKY2G+C5bB4LrP2OPrUHEnGxoed/b10OMHPQ
         iUbqyKEdjV5RBvQIaMWUMcir+bKxWztarNmAs1KTDAWzeGzcLenBZqitsZaEjvY32C94
         4S/A==
X-Gm-Message-State: AAQBX9f8BIGovHx+bT1/qcfMeYxv31FgwzbVD2sRWZ+1ZWQyKbzCCis4
        Ys3Dg2Q+6afZXg8/VOmqlbh0aA==
X-Google-Smtp-Source: AKy350Y7LUK3nfzendnh17J37dDFXjucugtvtpD8fmjaYFzQSoobFRG/vsggjzQ+EbasYiOGKXVpfg==
X-Received: by 2002:ac2:447b:0:b0:4db:4fe8:fd0f with SMTP id y27-20020ac2447b000000b004db4fe8fd0fmr909089lfl.25.1680898489225;
        Fri, 07 Apr 2023 13:14:49 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u3-20020ac243c3000000b004eaf6181a32sm842436lfl.75.2023.04.07.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 13:14:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 22:14:45 +0200
Subject: [PATCH v8 3/8] interconnect: qcom: rpm: Drop unused parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v8-3-ee696a2c15a9@linaro.org>
References: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
In-Reply-To: <20230228-topic-qos-v8-0-ee696a2c15a9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680898484; l=2285;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yBC75Q6TJYtH1vX8QL0awOafuPHjdn2hOETxfU8AhgI=;
 b=/scUAZfnDk4668871iclpkfz/2TI7qD1M2Yecgm/4Pk9iR0T4KISIAjnhu3EULS0UwQUZguCML7F
 1VbPKaQFBp3iVjwy0cty4n9Ihl/9mgDe+MLW6lysH+x5AHLXOnm7
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS-setting functions do not care about the bandwidth values passed.
Drop them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 8dce3dcff8da..7d62c0bf2722 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -50,7 +50,7 @@
 #define NOC_QOS_MODE_FIXED_VAL		0x0
 #define NOC_QOS_MODE_BYPASS_VAL		0x2
 
-static int qcom_icc_set_qnoc_qos(struct icc_node *src, u64 max_bw)
+static int qcom_icc_set_qnoc_qos(struct icc_node *src)
 {
 	struct icc_provider *provider = src->provider;
 	struct qcom_icc_provider *qp = to_qcom_provider(provider);
@@ -95,7 +95,7 @@ static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 				  mask, val);
 }
 
-static int qcom_icc_set_bimc_qos(struct icc_node *src, u64 max_bw)
+static int qcom_icc_set_bimc_qos(struct icc_node *src)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
@@ -150,7 +150,7 @@ static int qcom_icc_noc_set_qos_priority(struct qcom_icc_provider *qp,
 				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
 }
 
-static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
+static int qcom_icc_set_noc_qos(struct icc_node *src)
 {
 	struct qcom_icc_provider *qp;
 	struct qcom_icc_node *qn;
@@ -187,7 +187,7 @@ static int qcom_icc_set_noc_qos(struct icc_node *src, u64 max_bw)
 				  NOC_QOS_MODEn_MASK, mode);
 }
 
-static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
+static int qcom_icc_qos_set(struct icc_node *node)
 {
 	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
 	struct qcom_icc_node *qn = node->data;
@@ -196,11 +196,11 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
 
 	switch (qp->type) {
 	case QCOM_ICC_BIMC:
-		return qcom_icc_set_bimc_qos(node, sum_bw);
+		return qcom_icc_set_bimc_qos(node);
 	case QCOM_ICC_QNOC:
-		return qcom_icc_set_qnoc_qos(node, sum_bw);
+		return qcom_icc_set_qnoc_qos(node);
 	default:
-		return qcom_icc_set_noc_qos(node, sum_bw);
+		return qcom_icc_set_noc_qos(node);
 	}
 }
 

-- 
2.40.0

