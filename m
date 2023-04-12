Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2BF6DF915
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDLOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDLOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:53:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6E6A68
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t20so15038663lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681311195; x=1683903195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzXitOAB7i9wPsi0RU5jPhBlfKzrQ5/zxTpphCz2cOw=;
        b=kHjLP0f69MHCgc+2DS0cqFj1Oc6/l0E/zz1wpP/iosDA5+4Fb3UjGzu0FI7Be9vZ0u
         JW8/vnc3srHNBA1OZaFu92W53W9pDgKqk7kIE1cTzsuJoUdO/imTOsE3kMnfC+V10Scj
         RI1c8pgxNzyfxCwDNXkdmg829MY9ZAC9GbO1tdnvknofKm4yeDePKHnWV06Ymruyz9ER
         aUblXOsRWKGx85+e02BK4EBgAURy1B3ZiOSGQRg4MinKmcH7LWiaY6Svu+bccxFeYsc7
         a/d/JWf9kALpdw3pauP8ISeNNwqWP/3VwpGupWMrYb63T1sTpuAmPIRhPVaBnAKk+lA6
         opeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681311195; x=1683903195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzXitOAB7i9wPsi0RU5jPhBlfKzrQ5/zxTpphCz2cOw=;
        b=Q5QW8BgicTY22zRzfh5xQ7BoRH7pdBK8bdsngFYG6GJYdDTqmU9baIwLek6Ns6jrUv
         th6EJzdBl9G/g6qhvMsZfbgs+0otR4GFrMrEU6wASmeW/EdfxI5SaR7ucIHvSn2F0uBF
         ZG3zU2pDK+pQf8N77f5stdWVjLL643oY+kBkkSR1qw9GZqGBfXwjhF/rf4jezb3glkfn
         SsvDDUWuJKj8y/veUYG5pyX6UeoojMjccKZwteMWo/gF5pSHoKxgIXjrPVqUsatLa89N
         aZxvXl1MRe9/JAAcb+OXlMBdX8cuxwOJKEqVDfpSHAxg4vqf8GJnYvLA0r9GoJOaZyIH
         olYg==
X-Gm-Message-State: AAQBX9fXm1uYUJQiP1nLHyBGbnzoP6v6JCK16R+FOOGQ10ulxoLyffk5
        05HmTNRDpg9e8AvLyuPWyR7aJQ==
X-Google-Smtp-Source: AKy350bAzp0vsxDGVnboU2R0wJXBJGE/OaQ//CXpJSRoNvxsuoLNlfmlbkMm+tPLjv5hfmbAxjh2xg==
X-Received: by 2002:ac2:5444:0:b0:4eb:274b:a69 with SMTP id d4-20020ac25444000000b004eb274b0a69mr1831189lfn.26.1681311195192;
        Wed, 12 Apr 2023 07:53:15 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id w5-20020ac24425000000b004e95f1c9e7dsm3015367lfl.78.2023.04.12.07.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:53:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 16:53:06 +0200
Subject: [PATCH 2/3] clk: qcom: dispcc-qcm2290: Remove inexistent DSI1PHY
 clk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-qcm_dispcc-v1-2-bf2989a75ae4@linaro.org>
References: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
In-Reply-To: <20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681311191; l=1245;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=5FJ0glA+UfMPhOkTxeP63CncmUlAPOn1NSBFVZ9Bnf0=;
 b=/3Ufj2N/TAX1seIFCdp47zWL0iEhSQFuyc58fzJfbSw5uYaUX0Sp4fwvk2LHwtZ8o9SxOn6bDFJd
 1RB781VIDPpSL8YMBFJbrqvR0PZrTZAapCdxgYwhEH/fZdsb/Uci
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's only one DSI PHY on this SoC. Remove the ghost entry for the
clock produced by a secondary one.

Fixes: cc517ea3333f ("clk: qcom: Add display clock controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/dispcc-qcm2290.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-qcm2290.c b/drivers/clk/qcom/dispcc-qcm2290.c
index 0f516c72e624..ee62aca4e5bb 100644
--- a/drivers/clk/qcom/dispcc-qcm2290.c
+++ b/drivers/clk/qcom/dispcc-qcm2290.c
@@ -28,7 +28,6 @@ enum {
 	P_DISP_CC_PLL0_OUT_MAIN,
 	P_DSI0_PHY_PLL_OUT_BYTECLK,
 	P_DSI0_PHY_PLL_OUT_DSICLK,
-	P_DSI1_PHY_PLL_OUT_DSICLK,
 	P_GPLL0_OUT_MAIN,
 	P_SLEEP_CLK,
 };
@@ -108,13 +107,11 @@ static const struct clk_parent_data disp_cc_parent_data_3[] = {
 static const struct parent_map disp_cc_parent_map_4[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
-	{ P_DSI1_PHY_PLL_OUT_DSICLK, 2 },
 };
 
 static const struct clk_parent_data disp_cc_parent_data_4[] = {
 	{ .fw_name = "bi_tcxo" },
 	{ .fw_name = "dsi0_phy_pll_out_dsiclk" },
-	{ .fw_name = "dsi1_phy_pll_out_dsiclk" },
 };
 
 static const struct parent_map disp_cc_parent_map_5[] = {

-- 
2.40.0

