Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AA6B0192
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCHIeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCHIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:33:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC926CCB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:33:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r18so14556460wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrjzbycvahC2qWo4+g2dlQgsce4F08+8FUswfvS3fdc=;
        b=vjIMj4YrRtXCIYL0GYTNI06bij3LwCKaY/BhO+GRH0cClgMCxoi7HlBCHXRrt4OwPw
         NchY00cYcr3fQSMs79jfFoUrv8UxI4e8t4ZpnN/76yjxRwLCaDlogZlO79vHQN6Mbwej
         JOCsW0fInPM5mkVLahhl+NA2obrELsJxm6qFrox29jsXXgPVogFDmu5sLqYKhhqwlVkM
         CQQt3Eurjj3Hb1KE1MxDdkuxHWhRVi40iwDoIMdNXFbuWJdzPzDZo2wSXRnzYGNac4Qa
         LCunR9fg2Z4U9iXsJO97RC6mcg8YBtZXmg/zKQ9lk9Q8nKaO50PviyrA63yxBqiEiEbm
         ksAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrjzbycvahC2qWo4+g2dlQgsce4F08+8FUswfvS3fdc=;
        b=M3tRgMdNBfsFn2CrPp8qL0RFCJWdcLF1ywWz0GVtVGvCbFmKJsbPyiYtIH5afuWoKa
         gBkzI4wxrrGXquhTBN42s6WETr8iovubm+Fj8wcC0jStrAJ072iSfWWCgDIkx5CovqdS
         GtQV43Em5D7SnOJWNvji4Q0yYd+xXVIXboyViAeLMqTFdtZzrrZKHmAuFQR4B6mfiSR4
         lzjS+FNSP+frCZOJJkMBjJDkrkLG8Lxn5qSRIFgfbjwBRtsEHkmn68CxwQm7ujEZf4E7
         IQLBUAtscvRhreEiZHr99AfO10yU4RxP6vUUaNeoXfU1qzLo4HnkTtGutZxVWVmSaTs8
         ZWeQ==
X-Gm-Message-State: AO0yUKW5Uuj478Gp2QrRIUkF7NmfOH4Il3XiBBpHrwA63ssFitUDCJup
        R22Nef2Qdp7eUjNuW2SC7Vsw8lnBnIGxfqvUiQtaYw==
X-Google-Smtp-Source: AK7set8oS+rGpxMJbjUjyrLII6bqdfrz7UWEgw0XQcKOu8pVfIoTB543vno3mUILoTr+ZTk2IziWEg==
X-Received: by 2002:adf:f18a:0:b0:2c7:1d20:7743 with SMTP id h10-20020adff18a000000b002c71d207743mr11907012wro.21.1678264380980;
        Wed, 08 Mar 2023 00:33:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n1-20020adffe01000000b002c4084d3472sm14797907wrr.58.2023.03.08.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:32:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 08 Mar 2023 09:32:54 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm8550: misc style fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-sm8550-upstream-dt-fixups-v1-3-595b02067672@linaro.org>
References: <20230308-topic-sm8550-upstream-dt-fixups-v1-0-595b02067672@linaro.org>
In-Reply-To: <20230308-topic-sm8550-upstream-dt-fixups-v1-0-595b02067672@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous DT fixes to remove spurious blank line and enhance readability.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Fixes: d7da51db5b81 ("arm64: dts: qcom: sm8550: add display hardware devices")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index c25c68257412..6208a6196090 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -412,7 +412,6 @@ xbl_sc_mem: xbl-sc-region@d8100000 {
 			no-map;
 		};
 
-
 		hyp_tags_reserved_mem: hyp-tags-reserved-region@811d0000 {
 			reg = <0 0x811d0000 0 0x30000>;
 			no-map;
@@ -2210,7 +2209,8 @@ mdss_dsi0: dsi@ae94000 {
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
-				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 
@@ -2302,8 +2302,10 @@ mdss_dsi1: dsi@ae96000 {
 
 				power-domains = <&rpmhpd SM8550_MMCX>;
 
-				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
-				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>,
+							 <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 
@@ -3171,7 +3173,7 @@ apps_smmu: iommu@15000000 {
 
 		intc: interrupt-controller@17100000 {
 			compatible = "arm,gic-v3";
-			reg = <0 0x17100000 0 0x10000>,	/* GICD */
+			reg = <0 0x17100000 0 0x10000>,		/* GICD */
 			      <0 0x17180000 0 0x200000>;	/* GICR * 8 */
 			ranges;
 			#interrupt-cells = <3>;

-- 
2.34.1

