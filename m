Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96386FD976
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbjEJIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBF65255
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f315735514so236223335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707509; x=1686299509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gz9PoM6wCMhgq1ipkD8tgzicWFuKELgpP14GeTMAjVQ=;
        b=dNHKMzMzaeN2IFsjFwLNbmeFlAx4GIl1HoDWivl57wh3YZYBE2Djo2mTuP2MAKM6+d
         rowI5/jRh6BBaoYIyYDsSaiVKSan1a1QTEz1yNZwt5D3h8luyl6T7WdbDBdq0QyuVzf7
         MNZbpwqVZNF4IEj9Plt8Ys5ZR4cicPdsn0vod2yICl1mYrcn+XpICF7pQe55MvPkUTRP
         ykiayZpP9KXhwlqk4XzQ0vPt3fZoXSV/TbI5RpBJ8Vg5YoOs4PKkqIiu/HyGCMq14rfV
         Gjt+gg52ERoEjCyipsUiHifr10d0orP/kjgXjEHummxj1jrTmXJmREDZz9n0Vc2dM9ka
         FFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707509; x=1686299509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gz9PoM6wCMhgq1ipkD8tgzicWFuKELgpP14GeTMAjVQ=;
        b=QV3AI8UarbLewCT+9TMWcyxw4Qs3S0k/EVUS1MW7yoBA457nT7ZJacSKj/b9gbDcco
         XEZ7ZG2PB1soag0uftZ032p2IaUszvVcc+HcMy/nmu01HH54U6zq0ba4qRftaK0OR0z/
         McN+voUtTePpjkZSYaPzN78vSmUemy7qqj1bTjSIh+7gF673hrj7kdwYFOu5GTWw74iw
         GlW5xSNkZ/bhJq9N3PPEeRLk3slMSL1+LEajQzA1TIB30bQjx+jWX8AlLU2zTk58Gkyv
         sjw0LbJoDqopmuNwptAXX9BgLfODe9zqObAobdGCJCVOyLDq+r/ZKfsePcpCtSGvZLe1
         Iwjg==
X-Gm-Message-State: AC+VfDyvZzzbxMgHhNGpeNS9VI4L0JRBPRRfWp8qvvr/JyQD9sctCP2d
        WyAOfaEOJH3VYFRWxfr+V1AlGA==
X-Google-Smtp-Source: ACHHUZ7eauPh1k56NU34IObgTQcXIfG9rsLEO65l6Yh2VmLThV9gvm0tp91lgg3zULEOk1kFXz87yg==
X-Received: by 2002:a5d:61d1:0:b0:306:2be3:6d40 with SMTP id q17-20020a5d61d1000000b003062be36d40mr13354154wrv.35.1683707508914;
        Wed, 10 May 2023 01:31:48 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:48 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 10 May 2023 10:31:41 +0200
Subject: [PATCH v2 3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to
 SuperSpeed graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-3-8acbbe1e9d14@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v2-0-8acbbe1e9d14@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=JgbdY9bKmOSujT9ezh1sLrV7q5szRUTjWe1DK2Hxnmk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1Zv/jKc58Po1MMcgI9/qukbrV425od2+00xuRnd
 VYBJVbaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWbwAKCRB33NvayMhJ0b1fEA
 DNo4wtRhU3d6QZM6ZKpFuU6756+yZXCqQFx958+HzaDjTNfGjgff3y2qoZ5Z4xc/JBNU1H/YqizGeA
 n/qZpjopEr0Zom9R7jgQS/oYkzjWYGxWmCELzRUA+aENezU3q4oaNS4doBUrYxesrL3KBo/GJGW49U
 e46/y0Ge7wsWOCw9HTeustEPVAuRoNJvh/teTIT/irXPVNQ2tRNTTFfsvV29fnbD0mAn2SAunWMoDr
 8Ka498agrWrVkVex2ySg+UQwbXy5r1JHpVdM/YUFDtzYZgNJmNEaIuOtC+WiVU3CNFTl1WAXDYzzMy
 5phHSq6JDrODk9t4WHvGP4Y2vtzIuyslZfEDEGRZT9xfC6xM1R35IFeaeKuUGOWlSEqil5Lw0pnxSw
 ZUSUVEt5s4J45/ugF+eNEz2QY7xHjxSOOnAgFJqI5zDioeYFEpjO9/U/C9AwXzEeWUF47xaQVqLum1
 xT4Fz59Uq4gFNhMMQCneF7SXG043WZMnMYNjxzHyJs7OtpWHjmgTrUnHd7taFhqdzBK9aqGle4ZxJv
 531dYcMYQKHB92ZBCSyR98Pe4gdbLbxv5rKLbpPN9nuk4AWlnNH6ND5gQx+QbiVlbMMTmR4Gqpbt++
 0b0XrsdxtP1Y5EWaR/TJEyOqalD4gbr3Vj0kJ8QWyNYTbOwevgaqb13fk77A==
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

With support for the QMP combo phy to react to USB Type-C switch events,
introduce it as the next hop for the SuperSpeed lanes of the Type-C
connector, and connect the output of the DisplayPort controller
to the QMP combo phy.

This allows the TCPM to perform orientation switching of both USB and
DisplayPort signals.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 76 ++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 2ee1b121686a..d3788bd72ac3 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -58,7 +58,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&usb_1_qmpphy_out>;
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
@@ -326,6 +334,37 @@ zap-shader {
 	};
 };
 
+&i2c13 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	typec-mux@42 {
+		compatible = "fcs,fsa4480";
+		reg = <0x42>;
+
+		interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc-supply = <&vreg_bob>;
+		mode-switch;
+		orientation-switch;
+		svid = /bits/ 16 <0xff01>;
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
 &i2c15 {
 	clock-frequency = <400000>;
 	status = "okay";
@@ -370,6 +409,21 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mdss_dp0_out: endpoint {
+				data-lanes = <0 1>;
+				remote-endpoint = <&usb_1_qmpphy_dp_in>;
+			};
+		};
+	};
+};
+
 &mdss_mdp {
 	status = "okay";
 };
@@ -416,6 +470,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &qupv3_id_2 {
 	status = "okay";
 };
@@ -716,7 +774,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -732,6 +790,20 @@ &usb_1_qmpphy {
 
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p88>;
+
+	orientation-switch;
+};
+
+&usb_1_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_1_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
 };
 
 &usb_2 {

-- 
2.34.1

