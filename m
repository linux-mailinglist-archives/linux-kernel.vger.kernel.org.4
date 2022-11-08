Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18FF621E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKHVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiKHVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:17:47 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069160356;
        Tue,  8 Nov 2022 13:17:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so22893544wrt.12;
        Tue, 08 Nov 2022 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JaQ3qz4RAxB0OZvGVNsixJMinEHr+Sa/4oPbj4kqOBA=;
        b=Mxkb/CgpSin7mV3Vzf7xtXQ0c62wTqd7CKX7ftEpwmSr7vrwIteF4BqUjxqqimJfTO
         IdU74fecVdLsD4gBDDKI8JiEM8XHjIkdVyBz6pt+u6SmqZZzNW5yomEbh71H0n55/NtE
         kgoElk2VPcuCzbRSLaodyhNoLS6mT2oHHy76rNhb7rW7LVF3a2+1GVNf1SMrmNxr+UaR
         7P/FDnrDlOS2zM1Bdf1RTnMh0O9o5TF0Dpsbtl6KmRUYSkLSL8eZ6h1/h8MiDqhGAILs
         J5UO8W5IsvH5WUQ9L8vHJUf8IQVxvwuv4xTxRPHk3dkMpaPw9st5uPmQQJVNhPjqAmzQ
         te3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JaQ3qz4RAxB0OZvGVNsixJMinEHr+Sa/4oPbj4kqOBA=;
        b=O5jIoRuwOl76Y+RFl01irGjqcMjobSB7vlZhCRia+/s2NzyliHhB6KvEat9fihCjE2
         pv3IvyZoVKwFMuLV1BnWnzl9iJYfcRtjMqWm6duyWdEHUemhsy7aUqImr/BEhlXjfVNQ
         /jACiGb7jNPiyDT+pjnqo0Sq+LY1V1jEAT3odG9dtugusNs4K0Bl0sseRVO3TrcnK4yM
         p4A1wrc132N6PgJyYu3RJJ/7dZ2sUP0F0sFzhpzrsPWbtzRZRaHJSRfB4LxtEg+5dQz+
         grWC4sGoibky1R7mp+DPAOIRltnZRAfo4SLYLYbhcPvyBW5NcrIYOI/GGMTphogi62JJ
         be3A==
X-Gm-Message-State: ANoB5pmewRM5+PqfvcX/QBFPzuo1Xrf6YriT7hjUmeBtqJcVBjO1KYdb
        JCk7kzednJZ/HJ5Gca46Fz8=
X-Google-Smtp-Source: AA0mqf7mkBlhcgeIAGPGEoDIwmMAx1+Q45J2QmFuenk0lQtrrRcgqL9tIt1S+mF1faiCdr4d3DuoSg==
X-Received: by 2002:a5d:6392:0:b0:23b:4b0d:4591 with SMTP id p18-20020a5d6392000000b0023b4b0d4591mr15899667wru.635.1667942261715;
        Tue, 08 Nov 2022 13:17:41 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id t20-20020a05600c199400b003cf9bf5208esm14337980wmq.19.2022.11.08.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:17:41 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] clk: qcom: kpss-xcc: register it as clk provider
Date:   Tue,  8 Nov 2022 22:17:34 +0100
Message-Id: <20221108211734.3707-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krait-cc use this driver for the secondary mux. Register it as a clk
provider to correctly use this clk in other drivers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/kpss-xcc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index b1b370274ec4..97358c98c6c9 100644
--- a/drivers/clk/qcom/kpss-xcc.c
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -31,12 +31,13 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
 
 static int kpss_xcc_driver_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	void __iomem *base;
 	struct clk_hw *hw;
 	const char *name;
 
-	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
+	id = of_match_device(kpss_xcc_match_table, dev);
 	if (!id)
 		return -ENODEV;
 
@@ -45,7 +46,7 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	if (id->data) {
-		if (of_property_read_string_index(pdev->dev.of_node,
+		if (of_property_read_string_index(dev->of_node,
 						  "clock-output-names",
 						  0, &name))
 			return -ENODEV;
@@ -55,12 +56,16 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
 		base += 0x28;
 	}
 
-	hw = devm_clk_hw_register_mux_parent_data_table(&pdev->dev, name, aux_parents,
+	hw = devm_clk_hw_register_mux_parent_data_table(dev, name, aux_parents,
 							ARRAY_SIZE(aux_parents), 0,
 							base, 0, 0x3,
 							0, aux_parent_map, NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
 
-	return PTR_ERR_OR_ZERO(hw);
+	of_clk_add_hw_provider(dev->of_node, of_clk_hw_simple_get, hw);
+
+	return 0;
 }
 
 static struct platform_driver kpss_xcc_driver = {
-- 
2.37.2

