Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B896A5A33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB1Nos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjB1Nod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:44:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180932F7BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id n2so13203145lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677591868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMiTxpwM33fLoo3zljfiICDBPzjHi5z55E4EhRlk6DU=;
        b=Rv2uVtNFZx1qdQLUfaqkrs4kShtmKGiOiXAwhtza3pciKtGD1BmHlxhcKTQLlWBo76
         EiIDVlPazD7LtqyfRjeGdQ/bn9Z/yJMvwzkyYg1qdKM+9s/RfM6XQX85NUyr4jRXH3k6
         rH3puDHljW8QIW6Ll3tvMIo5u7/NpAPvxAjWDhl0uekLoC31eRWAMpez4LHLO5S2TH8s
         c6Dc82nPa1OnNk9tWRo7v/8v14Upuehds3F1kNehO9R/yrA0jGVOm/VOpk4dgVfRh3D3
         jkuNaGAfdi2564B3h5L0PHeEljHjbQr6gGzvxiXFsqUM7ymdjj1xx8YgFohaxkb/eZMj
         5HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677591868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMiTxpwM33fLoo3zljfiICDBPzjHi5z55E4EhRlk6DU=;
        b=B3ZuI+Do0a2nI8emwsTwJIsvgMd7qloNcZ29czjxppnoVPk7gUKygXqM4pJVgvmiix
         rUu09rQ0YL4YgrUgBmyTT72LD5SLgbjdT2wdUjA9HFMPGFS3LvXfq1nKXEElDUQPFCgH
         CjTPT4m3eBbhT/TqHaSlb8sn/g1wFaR/grmXm3plX5Pa6V/yukFfxbz3zFxh8K7Ygloa
         w8Z4CFwfQBtnOGxdJ2TQojLq7w02yGG8ms1x6Q6Q4qmAXb5MYSGl0hEVsWHI88+g4qPO
         /0Exi+I4+Zq2kNbu1GJgPcIfz8B3KqHzqeDQV4uTQiq8EwtnXoiA52Y0W4DS6a+vThSi
         CJiw==
X-Gm-Message-State: AO0yUKWUQhFj1Vs+Qr9yXuUbWGDCe1KpqU5mPUTADOwhr+5a6uaYz9uO
        lmTTEjidU1ETlKW9meqLtFSuBA==
X-Google-Smtp-Source: AK7set+PAbXVpQwEQu9t0sSQpQ+lc16KnHWFYdS8RH7M40om9xt7/ZMNqXvsxPQPLMiEWU6vKHS3+A==
X-Received: by 2002:ac2:5ddc:0:b0:4b6:f51e:b8b6 with SMTP id x28-20020ac25ddc000000b004b6f51eb8b6mr696561lfq.56.1677591868306;
        Tue, 28 Feb 2023 05:44:28 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id j20-20020a2e3c14000000b00295a583a20bsm1203975lja.74.2023.02.28.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 05:44:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 28 Feb 2023 14:44:02 +0100
Subject: [PATCH v6 5/9] interconnect: qcom: rpm: Rename icc provider
 num_clocks to num_bus_clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230228-topic-qos-v6-5-3c37a349656f@linaro.org>
References: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
In-Reply-To: <20230228-topic-qos-v6-0-3c37a349656f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677591861; l=3438;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7FqLtMqh4mIUzsD3NmcdtRjn6IINUaYjtwsFkF9J5aM=;
 b=7Ylg7yC4+IMm3JNEtAClcZSbAikiiS+uVO09S/eygmI37u8ZoedL4Gbyme9unThk4epjLNNvExw5
 ducLfHzXCHrV9ONGaxyyslt7FUW1aPnAFLiTTY5neV6Dp//SuBRA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for handling non-scaling clocks that we still have to
enable, rename num_clocks to more descriptive num_bus_clocks.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7a54fe4ccadd..f78c13e6c5ce 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -380,7 +380,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			return ret;
 	}
 
-	for (i = 0; i < qp->num_clks; i++) {
+	for (i = 0; i < qp->num_bus_clks; i++) {
 		/*
 		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
 		 * for other clocks.  If a platform doesn't set interconnect
@@ -465,7 +465,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < cd_num; i++)
 		qp->bus_clks[i].id = cds[i];
-	qp->num_clks = cd_num;
+	qp->num_bus_clks = cd_num;
 
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
@@ -495,11 +495,11 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
+	ret = clk_bulk_prepare_enable(qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
@@ -521,7 +521,7 @@ int qnoc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 		return ret;
 	}
 
@@ -554,7 +554,7 @@ int qnoc_probe(struct platform_device *pdev)
 	return 0;
 err:
 	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
 	return ret;
@@ -566,7 +566,7 @@ int qnoc_remove(struct platform_device *pdev)
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
 
 	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	clk_bulk_disable_unprepare(qp->num_bus_clks, qp->bus_clks);
 	icc_provider_del(&qp->provider);
 
 	return 0;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d6b4c56bf02c..d4401f35f6d2 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -23,7 +23,7 @@ enum qcom_icc_type {
 /**
  * struct qcom_icc_provider - Qualcomm specific interconnect provider
  * @provider: generic interconnect provider
- * @num_clks: the total number of clk_bulk_data entries
+ * @num_bus_clks: the total number of bus_clks clk_bulk_data entries
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
@@ -32,7 +32,7 @@ enum qcom_icc_type {
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	int num_clks;
+	int num_bus_clks;
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;

-- 
2.39.2

