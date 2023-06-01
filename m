Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A9719F32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjFAOHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbjFAOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:07:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FEFE50
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:07:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3094910b150so955660f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685628434; x=1688220434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4orPicnt68KcAk51goo/EZdt5c9EB1sU8JStjJm7IEc=;
        b=ExQKvzEoBSwlAyG1Wemz5LrDsU4TsLGKzctvRbL0HH+OV8JgNX9UeJOFrfAnk0CbZm
         fcECF86KhXQNoTLTTSomLr6QnRtIU/Rz7cwlfCtoHOFqm6ckfZv0RDlegMSNryt8Nd3j
         O9pAeSJj/edIgYY2zA3VouMznMd6D+6paw1WWPrbrR0X9ruq+I4OEmjdiHg6FhIyH6xP
         XxXH/E+Q9n3K4V6LNkhgceHemkuNPi5qk7ZDhEA8/NnCeD39RBgHhl7elEDlm7DBRoBG
         CEYuPgesulwwy3A1Gs3rX7by4QZjohE2Gh6O/1bVJTCcOJjTURFsfyTlQqWEeLQSUH61
         zH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685628434; x=1688220434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4orPicnt68KcAk51goo/EZdt5c9EB1sU8JStjJm7IEc=;
        b=hAoaOmqGFqgQXMRAf27s9DYoT8Eq8VckkZlDooHkHA/ClQmYhmC1VjmCbOhCL7x+Ch
         z4CVvmKplvicVlcn4rnBKKykMoc7Rm4ObIC8XBSZPCbRNUVWjyCaJ8E5Lep3Pqm5nlBk
         K2VS6eLbjvGnraBvHpOxTRboYBCJy1UGrAaGHOd0yL6mXwhd4pYA9XcsttHSHKG2Yhzg
         3PxhAUyf4T17lErk71nQacYkzVlBU5YBdy6dT2fbjnU9dO5t6wC31B02v0eWu4vc+UK2
         g/6fpXHSMpCNo+5oSpfbpCt2MNteA+JPqNErQbbL+zsC8Tv/rCEXMra0M8B0rx1m2uku
         vFdg==
X-Gm-Message-State: AC+VfDxvdxZV+rwqe37q0sR0QCSvhEOBoXKEyczbKxjPhUyfx8um+ETo
        /cYP1bT8lzT6KwzWCptMtapKmA==
X-Google-Smtp-Source: ACHHUZ7rsW88N6lOxdJEgvlQNko6WAiNoPfRl9CKXdC3X0aZFPLtHge3mhbdR9rSridmzH5YyHBkIg==
X-Received: by 2002:a5d:6889:0:b0:306:3204:3633 with SMTP id h9-20020a5d6889000000b0030632043633mr1967387wru.22.1685628433808;
        Thu, 01 Jun 2023 07:07:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k11-20020adfe3cb000000b003078a3f3a24sm10504166wrm.114.2023.06.01.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:07:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 16:07:07 +0200
Subject: [PATCH RFC 7/7] arm64: dts: qcom: sm8550-qrd: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v1-7-d4d97b4d8bab@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v1-0-d4d97b4d8bab@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3104;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2o8Mr95zHAAYTm7V2lzbLu+s4H+9UDeicqA1V3dHXNo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeKYJmAFvc6BjEkKgpghb9tYE0YV5C2eXm9oGCQp7
 R/7e+iaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHimCQAKCRB33NvayMhJ0WooD/
 9/xGvuH88qDBLtFtze9Ine8Ag3ZbydiMNbl2M8Bg8RIl10V68FmzQyCfpMOt33COaeYLHzqcegp/mA
 MJjJ9yX7GFTUbdUWgARFKbeRbDIAKuFnrNcQIt9Kdddfs0CJxwB5K6yo8PYnlInbwsz71P289GFCKn
 gKOoj5I0EJKyxtXfacHYzclDPSaHBc0YumgcuTc1cVsHQ2C+GGewSSAyUAb4h92Al9dNEJAgD6DKi1
 K2gC/jhyP4CrXeJnXfDlNE1iLMX5NZ7T6PjchqaeD6vcJv7bgt6IfY01jfXfWYV3IuJamTbdzH5OSz
 SidVT6thXS9IO5ui6BbNahXnJMnzAybJX8Ip14/WdzLKFWWCcujF3hp2TQ5ztxHq72nfrnqMuJ2ZOo
 IZRoZyzBXtXiPlfSPXo6eRTGml2TpeM/bUmtf/yqW4msaKikzuex2/2YBtHgzRCO7Cx9+bu7jFq9tH
 XzjTB3xoYrv9rWAT3UHCHjIgG0H1wb/tDhZvImtmDQ14Yn/rmskFbMQohuu0dHgCqUtl0R3Bg7QOYB
 osQyUKDdCZ71810TLxgPjca93sxca3T9vRqzPNg4eJnrHbd/v6DmfdVOEaMTkHbixeBt7hUIY+YLDA
 VmjY4Z/mpTr8vn4B49cj2p1g+iR8eF2L7Vt2zSKA1/PZROrIh6xjxkgouNbQ==
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
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 99 ++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 8669d29144bb..edb31efa563a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -64,6 +64,7 @@ connector@0 {
 			reg = <0>;
 			power-role = "dual";
 			data-role = "dual";
+			orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
 
 			ports {
 				#address-cells = <1>;
@@ -81,7 +82,15 @@ port@1 {
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
@@ -420,6 +429,69 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c_hub_2 {
+	status = "okay";
+
+	typec-mux@1c {
+		compatible = "onnn,nb7vpq904m";
+		reg = <0x1c>;
+
+		vcc-supply = <&vreg_l15b_1p8>;
+
+		mode-switch;
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
+					data-lanes = <2 3 0 1>;
+					remote-endpoint = <&usb_dp_qmpphy_out>;
+				};
+			};
+		};
+	};
+
+	fsa4480@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		vcc-supply = <&vreg_bob1>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				fsa4480_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+		};
+	};
+};
+
 &gcc {
 	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
 		 <&pcie0_phy>,
@@ -471,6 +543,15 @@ &mdss_dsi0_phy {
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
@@ -650,7 +731,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -666,9 +747,23 @@ &usb_dp_qmpphy {
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

