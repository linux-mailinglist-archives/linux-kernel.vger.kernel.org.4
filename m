Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654A85B7E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiINBkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiINBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:39:56 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46198205F1;
        Tue, 13 Sep 2022 18:39:54 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v128so11095151ioe.12;
        Tue, 13 Sep 2022 18:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7GbYCslF48I7fDwOVdzpc0jOBmHVLbyPOHBU4jxAGaA=;
        b=Mzy9+SngTxurwyX3a/RKUi8Nv59x6UcdetgvEGUm0VMbJRdRogKLmxDyl6uplpADvm
         3PrP9O5Y3tO0mQMreyunxJZFUsxAtCxwuTT4SCPibn6moks4ybyf74KRdntV1StLQuOJ
         K/4jhgy+TTXFPioB9pvbauPjZvPCn086lgU28nbxkGienPG73O/65fIpcrc4eSMvfoOB
         iG18bQyyg+/Z14kLG9+mEFrPpUzILTRM2C4s1zdTfhjtB5emTGuyVT8VEtC4Dkyg02i9
         dmSJp+Wns8ABT9DyawMGqT4IbL7ZUMzzed11BsP+eDZGqGpFoUuHkY3P96ga8PtKC9ct
         P3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7GbYCslF48I7fDwOVdzpc0jOBmHVLbyPOHBU4jxAGaA=;
        b=V8bSI7Qk5s7AvUJyNTlbprSjjLPzjlwJbL4H1YJijpMH4FY7GJ1MJ6FoAloSJ4MQzA
         7Bz466RfQv1wqBmzvN1MfpX5q5matDjAPrsQzCvDhvWviBsTELV1UzRfwAb+pyIhKwVH
         gf3JAbzIHl17Z/OFBBJbCRg6dzUeAv25oo0BGd6HZt/nuqa8e57BtO1ST1WDIKxQTsJC
         lL5gehSiKSOiGnsOwwp4NH7/m+Sx3P//uqAZx82mTAAKEd1F/kmmeYyrfv7RAJCGIhGp
         KX2yMNSB0a/56HdcOzg8qy4Snwe1YUPSHtzC0k6ZoqatKhCuZXMInJbdzqir31d+0mKb
         uheg==
X-Gm-Message-State: ACgBeo1hR0hZ3XO/RYD6/7I328YWWOjq9mjnx01amkGKWrMMtQ4tbP/X
        C3smbGy7wFZ8gPFd21oIelptLfW01DA=
X-Google-Smtp-Source: AA6agR5Skygz4lkjc+J4Y/w8/sEGIk1jQJ5azJQ0Jaq9XkLu+aEjC6gn/1kzifGwzcTDAfR3a6ZViw==
X-Received: by 2002:a05:6638:16d6:b0:358:31d8:65d8 with SMTP id g22-20020a05663816d600b0035831d865d8mr16896674jat.137.1663119593201;
        Tue, 13 Sep 2022 18:39:53 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a02cf23000000b0034a6d12aa25sm6345760jar.4.2022.09.13.18.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:39:52 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v4 2/3] clk: qcom: gcc-sdm845: use device tree match data
Date:   Tue, 13 Sep 2022 21:39:21 -0400
Message-Id: <20220914013922.198778-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914013922.198778-1-mailingradian@gmail.com>
References: <20220914013922.198778-1-mailingradian@gmail.com>
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

This driver will support more than one SoC's set of clocks, and set of
GDSCs. This behavior would be unclean with hard-coded static variables.
Support it by grabbing clocks, GDSCs, and BCRs in the match data.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58aa3ec9a7fc..cd6e4e41dc9b 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3574,7 +3574,7 @@ static const struct qcom_cc_desc gcc_sdm845_desc = {
 };
 
 static const struct of_device_id gcc_sdm845_match_table[] = {
-	{ .compatible = "qcom,gcc-sdm845" },
+	{ .compatible = "qcom,gcc-sdm845", .data = &gcc_sdm845_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
@@ -3600,6 +3600,7 @@ static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
 
 static int gcc_sdm845_probe(struct platform_device *pdev)
 {
+	const struct qcom_cc_desc *gcc_desc;
 	struct regmap *regmap;
 	int ret;
 
@@ -3616,7 +3617,8 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
+	gcc_desc = of_device_get_match_data(&pdev->dev);
+	return qcom_cc_really_probe(pdev, gcc_desc, regmap);
 }
 
 static struct platform_driver gcc_sdm845_driver = {
-- 
2.37.3

