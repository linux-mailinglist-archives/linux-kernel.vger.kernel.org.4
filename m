Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA016BC88E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjCPINN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCPIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:12:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EE7B370E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bj12so607319pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKGkhNWJDflF9COtN9J2WkrYKMdTvJxqMH/zsSiBzws=;
        b=jFyYU9AbT4nIFgJqbTnP0yx1wmxFYXYVr3UBqNqUw0fGkO49edFDSZXyJh6r7OchJ2
         rXWXII3vg+o6fioikQFADONAwIxbfkcj8I8Fbspc1q3tYxRAovnkc2xNCsOhjtG5BHgI
         sdj7RM85poQbJdUFa0XvIRXvqP5lNzuQI4WTrRKCh2nIXQoltjqRVbyaEFAHg2e4TcYX
         1gQubJ7QB2oL1TE0C7kEt2USwCu7ehwo5OYtdoaQczWSfgbgy8uQjV4qiWdCP0ST4fap
         rNg0Y9/Q9WQmK/5CNbyR/IuLfZT55k0YUFbZXLotW6o59RNOU0gRHT7yoy7L8jv+pkpQ
         xaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKGkhNWJDflF9COtN9J2WkrYKMdTvJxqMH/zsSiBzws=;
        b=zRUxxfZVt4RX7BcxEieNpbVlGJEc55M53qXrPDCs7q3uEGNZEi4cGMSmDeIapfhESY
         SB00x8EJnkwOEEhaLHkL7CM9G71AkEqY3tP9wPGVU7dPhfTZA4oq/xRf3PinUtSrHcxG
         iJHbLWnN51Q/5nPgkkmAa2a24241gYvZMlNrCpzHzibxcRn/4djEMGIUzNETdv9294c/
         gf/lVFJNKWx1r17kttkKZLImGLbnL6WIhQyNHg3DYHzSeyU5TJfobQdURaKCy0CfMj1/
         VcuZ7QCHqnC7HIpQjshuLI5K7ZjnItY8DmDtCkTehJ1RKEnr1/nxeVwHThou1iavMuAD
         LD9g==
X-Gm-Message-State: AO0yUKXsyTj2Ek30jDikw3b3I6ewSx6e+q3nAOTWxYleHmLdL0DV1jzP
        rM0GYAy8R8VJLnqKS58smsW5
X-Google-Smtp-Source: AK7set9o5drc11ruFy3nXJAqLM2G84tp0F80OComMCN68zBy6VIvf3aHChyyKQ/tL5NhzV4KE77V6Q==
X-Received: by 2002:a62:190a:0:b0:625:f582:d46a with SMTP id 10-20020a62190a000000b00625f582d46amr830582pfz.18.1678954335747;
        Thu, 16 Mar 2023 01:12:15 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:15 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 10/19] PCI: qcom: Use bulk clock APIs for handling clocks for IP rev 2.3.3
Date:   Thu, 16 Mar 2023 13:41:08 +0530
Message-Id: <20230316081117.14288-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
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

All the clocks are enabled and disabled at the same time. So the bulk clock
APIs can be used to handle them together. This simplifies the code a lot.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 88 ++++++--------------------
 1 file changed, 20 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0d0d87743cec..42b851bdf1a9 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -169,6 +169,12 @@ struct qcom_pcie_resources_2_3_2 {
 	struct regulator_bulk_data supplies[QCOM_PCIE_2_3_2_MAX_SUPPLY];
 };
 
+#define QCOM_PCIE_2_3_3_MAX_CLOCKS		5
+struct qcom_pcie_resources_2_3_3 {
+	struct clk_bulk_data clks[QCOM_PCIE_2_3_3_MAX_CLOCKS];
+	struct reset_control *rst[7];
+};
+
 #define QCOM_PCIE_2_4_0_MAX_CLOCKS	4
 struct qcom_pcie_resources_2_4_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_4_0_MAX_CLOCKS];
@@ -187,15 +193,6 @@ struct qcom_pcie_resources_2_4_0 {
 	struct reset_control *phy_ahb_reset;
 };
 
-struct qcom_pcie_resources_2_3_3 {
-	struct clk *iface;
-	struct clk *axi_m_clk;
-	struct clk *axi_s_clk;
-	struct clk *ahb_clk;
-	struct clk *aux_clk;
-	struct reset_control *rst[7];
-};
-
 /* 6 clocks typically, 7 for sm8250 */
 struct qcom_pcie_resources_2_7_0 {
 	struct clk_bulk_data clks[12];
@@ -896,26 +893,17 @@ static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
 				    "axi_m_sticky", "sticky",
 				    "ahb", "sleep", };
+	int ret;
 
-	res->iface = devm_clk_get(dev, "iface");
-	if (IS_ERR(res->iface))
-		return PTR_ERR(res->iface);
-
-	res->axi_m_clk = devm_clk_get(dev, "axi_m");
-	if (IS_ERR(res->axi_m_clk))
-		return PTR_ERR(res->axi_m_clk);
-
-	res->axi_s_clk = devm_clk_get(dev, "axi_s");
-	if (IS_ERR(res->axi_s_clk))
-		return PTR_ERR(res->axi_s_clk);
-
-	res->ahb_clk = devm_clk_get(dev, "ahb");
-	if (IS_ERR(res->ahb_clk))
-		return PTR_ERR(res->ahb_clk);
+	res->clks[0].id = "iface";
+	res->clks[1].id = "axi_m";
+	res->clks[2].id = "axi_s";
+	res->clks[3].id = "ahb";
+	res->clks[4].id = "aux";
 
-	res->aux_clk = devm_clk_get(dev, "aux");
-	if (IS_ERR(res->aux_clk))
-		return PTR_ERR(res->aux_clk);
+	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
+	if (ret < 0)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(rst_names); i++) {
 		res->rst[i] = devm_reset_control_get(dev, rst_names[i]);
@@ -930,11 +918,7 @@ static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 
-	clk_disable_unprepare(res->iface);
-	clk_disable_unprepare(res->axi_m_clk);
-	clk_disable_unprepare(res->axi_s_clk);
-	clk_disable_unprepare(res->ahb_clk);
-	clk_disable_unprepare(res->aux_clk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
 }
 
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
@@ -969,47 +953,15 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	 */
 	usleep_range(2000, 2500);
 
-	ret = clk_prepare_enable(res->iface);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_iface;
-	}
-
-	ret = clk_prepare_enable(res->axi_m_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable core clock\n");
-		goto err_clk_axi_m;
-	}
-
-	ret = clk_prepare_enable(res->axi_s_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable axi slave clock\n");
-		goto err_clk_axi_s;
-	}
-
-	ret = clk_prepare_enable(res->ahb_clk);
-	if (ret) {
-		dev_err(dev, "cannot prepare/enable ahb clock\n");
-		goto err_clk_ahb;
-	}
-
-	ret = clk_prepare_enable(res->aux_clk);
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
 	if (ret) {
-		dev_err(dev, "cannot prepare/enable aux clock\n");
-		goto err_clk_aux;
+		dev_err(dev, "cannot prepare/enable clocks\n");
+		goto err_assert_resets;
 	}
 
 	return 0;
 
-err_clk_aux:
-	clk_disable_unprepare(res->ahb_clk);
-err_clk_ahb:
-	clk_disable_unprepare(res->axi_s_clk);
-err_clk_axi_s:
-	clk_disable_unprepare(res->axi_m_clk);
-err_clk_axi_m:
-	clk_disable_unprepare(res->iface);
-err_clk_iface:
+err_assert_resets:
 	/*
 	 * Not checking for failure, will anyway return
 	 * the original failure in 'ret'.
-- 
2.25.1

