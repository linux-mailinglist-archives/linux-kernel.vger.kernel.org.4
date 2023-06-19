Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C3734CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFSH7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFSH6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:58:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB237E78
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so27731835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161524; x=1689753524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey93zvDWmAyVYw5EBP9isEy9sNithaduekGNmQfFFGQ=;
        b=N5icVU0PSF41RihqxzsAkvJ9RJVhig286Lb7vj26kCoHesAK1Tup3jpf9ect3qmoR1
         omch3Az7GNXs8T5+w4fTifcol6nxcCfEIEYQ/2AEC65OqyrtHcf0xC+k6qyFf88FKC+1
         6OuVzjOdw9JPZOodboRiHGYNr0fB02HDlqKBs8F0S2wS9sfBjxL2Ak/JY+y2wJwWCsD4
         IPrH8xH5o7xRNWcQYmjBv1Fxsya5ktRlbPI5JQ//N5+GIMbHNeLBhuDz4f7M5AKfVGYo
         CyyZ/C0ZI6RNxAhoMKO7X/9a97EczwfBhwEz71qjDKJk/k+3aOCZP1U8MhUgAo2UjHRT
         7Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161524; x=1689753524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey93zvDWmAyVYw5EBP9isEy9sNithaduekGNmQfFFGQ=;
        b=M7U9YW85955F2c3b4DWoQieORD2AyMMsoPjYUmatbK5AO7vIkjIC94770Fp4T26BQ7
         QXE1tl4fmxpQ+QY1bQB9vS3ZvTiHJwEYrAs3EO00XfG5d3tr0s5QEw7J6u6gD3yGTRp8
         3Td2sod6M5YkwkztV1OX59ZuQ4Q4hxH3NMqqgjpOvkvtSvSO5mwYTpAg3t4yWHtid03y
         A/NGfE9PKF8ENlQEymjjaU684aE7Mt57g5YXhDAbJjdztbqA188rs2jCpO12WnUDQfd4
         AM+BU4yRuhF+9K1Kk0CIE/cHJCxL2zMInZp+kfpF73WhlgHyyjDs/Q/24Qdeuy2W6CAq
         LwxA==
X-Gm-Message-State: AC+VfDz7tFyMvwSCqTZ/eLKRCEXdZiBEKp0r2inME8V+aI+FsrdqDqSF
        nw8bbPmC/BL6IOUZa9N8JcGbEw==
X-Google-Smtp-Source: ACHHUZ7swazqpjf4YIvGKwWPr0yHd4Tdgftum7sW7Y7htMVgRNeSAnWx/NLSyUX7Qgm4kDqLk+sozQ==
X-Received: by 2002:a7b:ca4c:0:b0:3f9:b30f:a013 with SMTP id m12-20020a7bca4c000000b003f9b30fa013mr562627wml.6.1687161524273;
        Mon, 19 Jun 2023 00:58:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm7091491wml.19.2023.06.19.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 00:58:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 09:58:21 +0200
Subject: [PATCH v4 6/6] arm64: dts: qcom: sm8550-qrd: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v4-6-eb2ae960b8dc@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2915;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nQ57g+TpUs6IW4Huo12DlEfzkTqpyQ3GQ6hDouNNOss=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAqtdlOdpbWirg2zesObhYva7aodzC+nAqudDdI9
 M17NY4mJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAKrQAKCRB33NvayMhJ0YERD/
 wJYC4PyTvN17OJNLolK8sGa5KwXiqRlXHYAcxX1z9FA3NVObnZw4smeyEjUAVu8SKJF0r71oP/Hu1i
 t3H3+htr6aIbUz15JOpP2tvzzuqxjgE2iP4jJ7tDAVYf6mCcFbvXNBd9aQrLgnCUrG3BX/BDetGqxg
 htBEKMNyQJXQg4mREQkwLMBRXQBAbkGe9DLyqKFpZiZCVEn+EIdd8zgGnJ4mUW6bHVLJQWnsVWA2ke
 3RiWsF3Q9y2NHn/anpWYm+oTUnivMQzdshhKN23HeUyaBd0APVQjJZlGwPgMkp8LZsGpYgUSTv8xom
 c5Ale+Mm1WCkrf4Cs6cTxr/jl+JswJTLZxmeS+GEMO45eDjr/VZZFFhUPsYNsQb+vn6J86lOsySatk
 oMOXKyAeL5GKX6FhV1pobWbhEiFYzYts6hNHkkdwTTbmD5uDbLlyV4FZ8e6X3KqgTBPXj58By3PQ4p
 PHzMEGT4Pl6Beo12LUwrAWNn5ahXfm9eYEMvo5AiSUW10nse6KrGUv/2ZlWaYf9hNoqFFupchK263y
 /ndErnE6m/+a8bczYksbC1H+8VYUzlfl0MyQcHzig1Ea3EVh5yb9et9XZDH72RlO3MciK5cNl9VquC
 xmvbynXPFUYjGH5Ykw+8ZcFZ2EwvlaD4TwHeD9BcmcSNfG2ycLqEfIjLR3kw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 98 ++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index ec4feee6837d..c921ecccd322 100644
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
@@ -517,6 +525,69 @@ vreg_l3g_1p2: ldo3 {
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
@@ -586,6 +657,15 @@ &mdss_dsi0_phy {
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
@@ -842,7 +922,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -858,9 +938,23 @@ &usb_dp_qmpphy {
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

