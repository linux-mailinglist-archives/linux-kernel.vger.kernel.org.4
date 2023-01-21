Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B6C6767E8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAUSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 13:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjAUSAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 13:00:37 -0500
X-Greylist: delayed 80 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Jan 2023 10:00:35 PST
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88624658F;
        Sat, 21 Jan 2023 10:00:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674323943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S77AubuYa5OrTV/jgUtcL1ihA4inmRuRojyuL5xTg7c=;
        b=ba970Vb+HajZc+wE0Nq0L8pBg21OWxOfTAkAYIKkdCskIrKZPp9tFSqk/a0sNjv3aboWhP
        7CNKrbBUMYotKfeLJTx4cWS7wgiaw+2TI1Mt15NfXxU3x1uVd23l/rQ3P9a+wjuFDJRuMm
        tbICmVyoCyJxKaVi5O8PEGP107/8+bA=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 3/3] ARM: dts: qcom: msm8974: add correct XO clock source to GCC node
Date:   Sat, 21 Jan 2023 17:58:37 +0000
Message-Id: <20230121175838.755636-4-rayyan@ansari.sh>
In-Reply-To: <20230121175838.755636-1-rayyan@ansari.sh>
References: <20230121175838.755636-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the XO clock in MSM8974's GCC node to point to RPMCC.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 834ad95515b1..31e9721b571d 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1057,7 +1057,7 @@ gcc: clock-controller@fc400000 {
 			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 
-			clocks = <&xo_board>,
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&sleep_clk>;
 			clock-names = "xo",
 				      "sleep_clk";
-- 
2.39.0

