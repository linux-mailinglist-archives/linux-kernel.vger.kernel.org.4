Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B6734D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFSIIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjFSIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D1139
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b4725e9917so15208041fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162043; x=1689754043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EexqmhtANLi6ES9tRfPf7+kAJ9pZLmkSwbWekIJckOU=;
        b=dyftOPPlVlvJsh/FgH+Ftvc+V1/toEOgrCBPBWBO0TfvZlQx1N86fQ9hZvN6N6ft7u
         sdGeJWl4Iqg9Ws36vvbZCLMPqbUkZ7UBweyUq3NRDsaobKpHbBlae++Gr5qc18bgkUAB
         6LT/n22JQLdpzJA6HdjXwWQvZnM4eQMFLrNX6gAtHmvYAp6I5eMT4BVi3axOFIaL4p+c
         MqQ3bJBKL9r99G0l3LDu0ORtuejw8eTsbcIrjvyyk0YFws/2r3+tIqAcuY2rgH1pp6pI
         g12NR6WuS3izP9myy/WEvWPjX+41B7Vr/Kz2rax8Iy9Kt9lq9JVk8Uyxyn1dFwhBrGJs
         RJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162043; x=1689754043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EexqmhtANLi6ES9tRfPf7+kAJ9pZLmkSwbWekIJckOU=;
        b=H2zNRyRpPAcUTEvvS876ZBSmJLGv1MaH0GzN5FhTfcYfbUi/GHaPins15RLpPHt+LU
         SUZGr6PawuLPOFPW7T9vX04wly7uFInHN+9PgMqaK+3lTnhN1IBW3jDD4gMCE7ZKPfAj
         bSsB+CQZ3mUO03eC+mzkGfiMMGIdtoRkK0U0yDZaNyhg8lC6Hs0tqoP0t4/o/dF6ubDZ
         qYdcSWEL8fxXqlR4XbtK2TZw+UiMFYBdbQHUOO609bItdc8haUwsFHVty7o1XU2+Zadu
         0Q1qzeZV2W8nXSHJx09DdKUlyTg8g9tSGa1DwEfgL/ZDoSpEBhILkSk2Femracu3QRMR
         kPMg==
X-Gm-Message-State: AC+VfDzDN1WU9CUuGRAFEpMhRrouKIbLPAOuk4NA+wMilA6NEjuUjPK2
        pwR89EiU/caOWgeI1T13R8V//g==
X-Google-Smtp-Source: ACHHUZ4NIsxkJM05hOTVJejZpX5Dqa9TKmwenHxJviLEWdZo5xU+XXtzRMzcT0x/mK4SSbOYUkvZgA==
X-Received: by 2002:a2e:3508:0:b0:2b4:5b9c:a019 with SMTP id z8-20020a2e3508000000b002b45b9ca019mr4444167ljz.8.1687162043379;
        Mon, 19 Jun 2023 01:07:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:18 +0200
Subject: [PATCH v5 6/6] arm64: dts: qcom: sm8550-qrd: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-6-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nZ+RqvCicPSHIWr4vNG/sq0pcfvomc8+0/2iPG1Su3c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAy0a7fAGhPw4PfnjIOjpXYpqrzb+eP23WHL2CyY
 YQzz+X6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMtAAKCRB33NvayMhJ0b/mD/
 43suWirVfqNPZ1vPQt2U7ZHxdqAcAA8ZEyOEb9sY69a6sqj+CkWHzrGSRLovDDymO6BsxxD3W8vTS2
 Yt8ly8YOkeZRNfejxU5xkLUTfsxRMPhy1pGLxH24w68y6a3WwwG8BtTnUnUbU5F1lRwpuHLDGrUv6b
 AKDDAFsP2AvXJyrY6yrZxbMtY14VpWzGB/CN1Lzap9qNfGycVTyg4GMDSOiNTN/nxH0xzLtXBq8JI+
 G2hjMd+DZ96mEW1ppW6pqzqLPDiKIujpZPo03GEQRDAVnrXkIc/fAd2CyXPTXomDu7eEYO7YAU8pyX
 CBB0zdns0hhoyukeZ/q2cJt/JGoaR1UX5GLHRCfm+qCeLvwHBlb+/xvutnNi5mBIIKNUOiD6HUajgc
 W8FaRxjXpD4IRmiHMf9THsL/YL5yZbSCmXRues007aVbZ0fa2hbVIDUoH4zNNiDyYxL9PSfJR4YSDV
 74/CO3yZ+R8K71VT0yAMo45AwnL+cR6/H/WsuA/sLniHyY4i6/M5gJz+HvfpyxcYSFOEkMeWE4r08k
 8ZLmjkaYL3Bo7FDy14blgS2HmYYt2up1N22ePYyyBuuZRLFH8gPKkpvhfqlDud8Oia8JJ6FjbYEHuQ
 tFmKa5QERvjScJ0d7sCrwAVaXp8e6jNCv7KVahywXtWgN+m40n/lNEQH6Lmw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to support Type-C USB/DP functionality.

On this platform, a Type-C redriver is added to the
SuperSpeed graph.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 91 ++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index ec4feee6837d..efcc2559b3e1 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -97,7 +97,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&redriver_ss_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
 					};
 				};
 			};
@@ -517,6 +525,62 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c_hub_2 {
+	status = "okay";
+
+	typec-retimer@1c {
+		compatible = "onnn,nb7vpq904m";
+		reg = <0x1c>;
+
+		vcc-supply = <&vreg_l15b_1p8>;
+
+		retimer-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				redriver_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				redriver_ss_in: endpoint {
+					data-lanes = <3 2 1 0>;
+					remote-endpoint = <&usb_dp_qmpphy_out>;
+				};
+			};
+		};
+	};
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		vcc-supply = <&vreg_bob1>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
+			};
+		};
+	};
+};
+
 &gcc {
 	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
 		 <&pcie0_phy>,
@@ -586,6 +650,15 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
 &pcie_1_phy_aux_clk {
 	status = "disabled";
 };
@@ -842,7 +915,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -858,9 +931,23 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p88>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&redriver_ss_in>;
+};
+
+&usb_dp_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
 &xo_board {
 	clock-frequency = <76800000>;
 };

-- 
2.34.1

