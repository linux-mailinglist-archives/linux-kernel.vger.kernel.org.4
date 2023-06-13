Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DE72DBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjFMH5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240723AbjFMH4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AB19B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso6380903e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642975; x=1689234975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4K7kTQtIrV7AYfghnPwr2i8OE9ZNp1mkYN+KZLG/2w=;
        b=H8sFXW/omLrIB54UrajgwFhbp5yT17lWzycM2YgbHyOIwSWQV+eYk3JJ8jqEpI5YPu
         k6w3xAnUzhw7zgWYr3y/SVNf5tJx+HgpCE8OflWa+/RXHNk6QeW6JpoF5oWI+AeoDDtG
         Z+O4LASpaN/puMf0lKwexhrW8xGRmP2IcBaa8LD1BeniSHNMurUivdEcc9UK2PKpeULt
         WwJ0UjLXmbjzKoXAz7e5p7je/QKqbsPNwoblIo34gcNEbJtIfcJgoKhckV6S9a27P+cR
         8q+txzA/bWHeJUrjTDM27pc/4ArVJgknBcFfaR4ZK8O9sMftF1pIs2N4Dq/0HhmjskCs
         3MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642975; x=1689234975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4K7kTQtIrV7AYfghnPwr2i8OE9ZNp1mkYN+KZLG/2w=;
        b=OdI7rZev4bhznmtn96o0RXESZrVg4+Lhv5ARWQtAJ2l/uMl92P0vVSb0tvNfqxH3iC
         jcQqsp+rDAA657zz5ClaaM/NdoWp4L0x+2IY20Y1/6nDTBA3MH/GEmvSCroECjRzwASA
         cQ7IE1bNEUp2m11hy8XzH6oZEA9ZufC0VxdqNoTQw5xVRKrlAf8sIJ3vQ2b/S/Id2lNK
         ZqQJCb1K9nMwYM9Xwdu94qDjrrMrpovWDfEveY536PFP95z/MkRTFDI39Kc4XYbURvE9
         pGsIAc/XZtlDMHhb+B+k7bgUJcuozlKzbVM6thpCmO+ejL4kPPlGve0OmaVnQkN6tjat
         X7vA==
X-Gm-Message-State: AC+VfDziVsaeYhCgWNxGFEWsys6mPWglKx0MPOi5VtXCKl7ruhCqRjVF
        AgIKcsXqFHmzBy5FlP/FdUFB3w==
X-Google-Smtp-Source: ACHHUZ7JcmHHsjJMULJFqqIndYRZ9QQrs/gP6T/OMYRCt3kuS5Fxn1f1cn/WtVWKqyPZVEirEtVcnA==
X-Received: by 2002:a05:6512:458:b0:4f3:a0f5:92e5 with SMTP id y24-20020a056512045800b004f3a0f592e5mr5575630lfk.31.1686642974793;
        Tue, 13 Jun 2023 00:56:14 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:56:01 +0200
Subject: [PATCH v3 8/8] arm64: dts: qcom: sm8550-qrd: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-8-22c9973012b6@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Dpn5WYby65WZz8xrANOxqTxyRCrlf2lM9h7YQb2/kkk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCEUdxo6zuTG5Nc48HP5ltUAmD9dDvDZC4r6LqFH
 u/p5+H+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghFAAKCRB33NvayMhJ0QFkEA
 CY/gWxK3m56EazyLvgsQsPf9vJK7NduAyaudylzkInM6AHffKJuSVegL+q+oQlUr3jvLHuS1N3hLwT
 Pb03yFcGDKdlDE3+vaSYEx9sjeVtAlODhx5LY6Q5eXkr6HR4dTkmWp7OXATdC8akWU7o/hXiHKkM2K
 OVeVPSoLO5FC3uvhHZmCnq4zA4z3vb/xo1wiQoRrcsXw777wyoC7OFWQEc0ypW1LolVfx1IHbKBNvk
 Bj0OK3JusXGORirS4So8NEbQbWHm3Q1toN8D6AjoEhLw0K39tPDnqTxAjkEKfH83IObaYWcpZ9I+wt
 NyvLIO1CMnSbys31/LnSIOe7gbLmvAJNuEbJXlSMCTA2xAZc/mEq5oeGY1bflYWmG1T4xBZGQG4Ky3
 WqARJdgObo8JbOMhQ0lO/2SjLsBQJ2llmtOhA62Soxw9s8EoWiM6bOC5g7ZR8tfszG0nUTnHlhWbrC
 aBxTqy0ESFvZ5MrkHaxli/oKF+1XeWsLziJGQIq4AvPXMASAJzawNlFzNE9qDE5y+lp5RIq9i57DdG
 HHcP1TkxSAqOZ1UrdbHSlICBvS4lNqQRLObbx0uuDOfpsxt6fnqmNLGfVGRWVHbrVtUgn5Cn1DgNPs
 ADA3uSH8CzRBdtGqoFgDV3+mlegmfYVL6uP6QdTBAKjGaMuTbG1wbpWfdZ6A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 8669d29144bb..792351c44b46 100644
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

