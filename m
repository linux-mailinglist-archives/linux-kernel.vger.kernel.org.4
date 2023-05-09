Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A26FD0A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbjEIVQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjEIVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:16:52 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80830F0;
        Tue,  9 May 2023 14:16:51 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 56067CED2E;
        Tue,  9 May 2023 21:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683667009; bh=zDs3Pv0PWo6YsPN0pHNUEmM5loKt3uLGkVd+dWX4sLg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Dnbpp//WRzqrk0GM9doxMC1cemhomznySmdVef6JUFF5klzIdHkNI+VgcvquY+Tku
         6oGMiFRv/zZBr/uvgSr0drQrdBwjE++d2UznZjcMrxinhKFz3HhaFs+uafSu1vs1SW
         YAhUBkkFN0Ur8l8DLuq0XWim+SdlnATQ89W6j0J0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 09 May 2023 23:16:37 +0200
Subject: [PATCH 3/3] ARM: dts: qcom: msm8226: Provide clocks to mmcc node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-msm8226-mmcc-parents-v1-3-83a2dfc986ab@z3ntu.xyz>
References: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
In-Reply-To: <20230509-msm8226-mmcc-parents-v1-0-83a2dfc986ab@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=zDs3Pv0PWo6YsPN0pHNUEmM5loKt3uLGkVd+dWX4sLg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkWrg/M8WLo2bZlDnuK85MWA3+5ZEUewrWTu8E6
 f94Dverj6CJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFq4PwAKCRBy2EO4nU3X
 Vig8D/4x71FXZmpVMAno2Q1/BEn9LGytWBlHXkUTP3XhfRyxhSvTFqtlhvOx4f2xuTQwLR+P8SD
 EtNBsHEBoVTn6nNzxX+m9GKh6RFbXHfhTmBiNVHmoUTkYRt6dxGVJBAs1L9PpEUQkEfoxgxOlro
 7g1H9yWIRioFPs+AI/9Hnt/EcCmroqVKJ9r3Xs405WbecrDnqJnj+89LRLQ15tf8fdVl0TRMwGb
 2VkOxekPWwBuST9bBVCZsXUcD53EwT9KsqAyyho/Zg57yuf7++86E+4NwVv6VUgQJnvpmZ692Zo
 GJ6zAStZpWslSKHh8M609dxEH4l2aKBU14t84evib71hsrxH+Matv8o4snPmYGjWXKF1JS2/jA+
 GNtnOoG0eL4SdZKnZI0F5z9J2zsxYlsy9YvHDhdBMetY1Eu20gDpWkgbgqhLhMbCqzclhEJXwPg
 6wooSTT07jU5bnEduTwVEQOu2p7jn2d/PXw9Z4wrA4TLXeZgD2dn2Yk0Fss1K0jOnbaWxiO5J7W
 phqKKcS/RnmFh/woFJVRrc71Ycr625JBIVHypvoUdHVpNbSmJj+aq08p3oxNX6dYTZxsbk01FMb
 07NWv4fCEte3a1uAdWVcBQbZ8TTUMvGogN6kphd0T1sipTXS7U7spm6N52ukoM/2ZlQ+xrClM1y
 W8FPGcsM50qjpUQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmcc needs several clocks that are being used as parents. Provide
them in dt.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 4dd4e26c73a2..3187b6853445 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -392,6 +392,21 @@ mmcc: clock-controller@fd8c0000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_MMSS_GPLL0_CLK_SRC>,
+				 <&gcc GPLL0_VOTE>,
+				 <&gcc GPLL1_VOTE>,
+				 <&rpmcc RPM_SMD_GFX3D_CLK_SRC>,
+				 <0>,
+				 <0>;
+			clock-names = "xo",
+				      "mmss_gpll0_vote",
+				      "gpll0_vote",
+				      "gpll1_vote",
+				      "gfx3d_clk_src",
+				      "dsi0pll",
+				      "dsi0pllbyte";
 		};
 
 		tlmm: pinctrl@fd510000 {

-- 
2.40.1

