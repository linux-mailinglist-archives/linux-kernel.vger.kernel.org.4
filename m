Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA426FD09F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjEIVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:16:51 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08E198A;
        Tue,  9 May 2023 14:16:50 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BCC68CED2C;
        Tue,  9 May 2023 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683667009; bh=lG1YLFdMOPVJ2F7GFyS2fMzqWjY+cPFGdTsfQNs2tc8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=it1Zm6hgLJcnZN4/m2xwv5+5LuUrmBj1TuNeEsaKO8pbOrQExtgsSgyUEOT3aHrkY
         puf1GVAFBVKnEMsEEP/E/WZ9wNmVtcaVGzK6qi884gdEo0LVRdqYBIamt2FCjML8PH
         WGurMij36F/XTNDpGqpCwwcvHrScvkc/dFAZ5H/o=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 09 May 2023 23:16:35 +0200
Subject: [PATCH 1/3] ARM: dts: qcom: msm8226: Use XO from rpmcc where
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230509-msm8226-mmcc-parents-v1-1-83a2dfc986ab@z3ntu.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=lG1YLFdMOPVJ2F7GFyS2fMzqWjY+cPFGdTsfQNs2tc8=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkWrg970Ak6m7eyWn4rwysuprLFQDhVlQ6GbF7t
 aGrzHOKU8GJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFq4PQAKCRBy2EO4nU3X
 VneHEACvGxKaU63dFjSuFQxhvuadm71Bi4y1YvCaMBB8d3N9rQIpNVdWOhIfqg22fYAUVFJ3JUO
 PS8KziLR9LH/z/aD8LanXYxqPoP//Px/Z9KsOs2e8jqyF/CuOoMSpLet/zgE0UI46SCPmkQEaUS
 9s4QNzgj3QrxWwfC3kf0lOMizAJxO92DfSmZ7FLQFeklRUuIanmDIWwR+da9D9zRXD2Y6XR4jrU
 iDGfSm/cYcvcwo99jO2Q0pDNtVnjtK0YxBvY7QocPfwoVu8qt/gWooWQbls+oej7xRvnwx8WsIF
 Tm+fkm2SMLgIrKH+54c4R+opzcdmrhOvJ4y9aL/msFrguryvSE2bYJ1HetOgtq3MHedRPoy9e6J
 CtMnoEpvG1FB+pm3f3oPR5H2rB1RyDfgDVGdBNSbchFKh3Yovcy1edqDX/45EVKNPEqiZjKU/ip
 ITWEkarNCLN53XtZ6LghMJxprD02ukGNbhXMHP6qA+Hd5eudmmyN20aPER2mm6ZHW8U0Iors1xS
 CnXZGq0dPGTehQP23+bPRtzrHe5BbXIytrZW3exzNrJUtA/odZAa69m+rXyWbfc4DLdT4hyxjd0
 hbvzd4McraKMC2JNijevWuo7hEjKYjFfNd+jNFMHEVOZIjvBPJ3HKmDeAHrT7nT4YvnVHCVerwR
 S/TuExYQZWUDe/A==
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

The xo clock being used everywhere actually goes via the RPM. Since the
rpmcc driver recently got support for this clock we can use this now.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 42acb9ddb8cc..4dd4e26c73a2 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -176,7 +176,7 @@ sdhc_1: mmc@f9824900 {
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&xo_board>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc1_default_state>;
@@ -192,7 +192,7 @@ sdhc_2: mmc@f98a4900 {
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&xo_board>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc2_default_state>;
@@ -208,7 +208,7 @@ sdhc_3: mmc@f9864900 {
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
 				 <&gcc GCC_SDCC3_APPS_CLK>,
-				 <&xo_board>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc3_default_state>;
@@ -362,7 +362,8 @@ usb_hs_phy: phy {
 					compatible = "qcom,usb-hs-phy-msm8226",
 						     "qcom,usb-hs-phy";
 					#phy-cells = <0>;
-					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+					clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+						 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
 					clock-names = "ref", "sleep";
 					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
 					reset-names = "phy", "por";
@@ -617,7 +618,7 @@ adsp: remoteproc@fe200000 {
 			power-domains = <&rpmpd MSM8226_VDDCX>;
 			power-domain-names = "cx";
 
-			clocks = <&xo_board>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "xo";
 
 			memory-region = <&adsp_region>;

-- 
2.40.1

