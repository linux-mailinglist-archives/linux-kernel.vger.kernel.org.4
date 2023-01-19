Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AB5674248
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjASTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjASTHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:07:48 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEC9AABF;
        Thu, 19 Jan 2023 11:06:38 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674155160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ettHXSku5Lnn2pb8UrC2GA3BFBY1curyqA+ekigINh4=;
        b=InlBn1b/ZJnJcs8MwGZFJe0Auk512vXeiGzUP4Gg3DK9rbslCxikFp32NA5Ds5TY9Izlnb
        8mHhui98o7HeLuLyMSXHpn1Cx3ZoqM7aQ5rgTxd/xb61tyYukfwnJklVTKe/qjke4FmEMS
        Yh4aG2DFqILPZ3GVG8C7aiYCdlfwpsw=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: qcom: smd: Add XO RPM clocks for MSM8226/MSM8974
Date:   Thu, 19 Jan 2023 19:05:33 +0000
Message-Id: <20230119190534.317041-2-rayyan@ansari.sh>
In-Reply-To: <20230119190534.317041-1-rayyan@ansari.sh>
References: <20230119190534.317041-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the XO and XO_A clocks to the MSM8974 clock list, which is also
used on MSM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index fea505876855..42ea3bb37f63 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -549,6 +549,8 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8974, cxo_a1_pin, cxo_a1_a_pin, 5, 19200
 DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8974, cxo_a2_pin, cxo_a2_a_pin, 6, 19200000);
 
 static struct clk_smd_rpm *msm8974_clks[] = {
+	[RPM_SMD_XO_CLK_SRC] 		= &sdm660_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC] 		= &sdm660_bi_tcxo_a,
 	[RPM_SMD_PNOC_CLK]		= &msm8916_pcnoc_clk,
 	[RPM_SMD_PNOC_A_CLK]		= &msm8916_pcnoc_a_clk,
 	[RPM_SMD_SNOC_CLK]		= &msm8916_snoc_clk,
-- 
2.39.0

