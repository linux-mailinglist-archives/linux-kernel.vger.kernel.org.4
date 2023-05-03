Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8E6F58B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjECNKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjECNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2469B4EEB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f1738d0d4cso31866295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119441; x=1685711441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfgHYISiig+/bzLlpt5cc7MXWheyapH8Hed5tG6Rzxk=;
        b=xJAezc8etfaUgcklqSQf0D/aXxx0UWwOGyCkWBiKYFuwj3CPtuZ0z96/VKymJ6GXzF
         TrD3ZzcUzAI7WNP9uZJaSlu57daTzhGdhlvJpOH1de21kE0ZuJdwAqEIN2wJ+TmxbfUR
         w0w1O3s/XExSa1T+5E3JIgcRBJacA1R1rX3CKF9/4cXYFyC+4lJe4G9ztCIs/SJ4EPCi
         8drq/IhZvzyKwJNC1ZyIeGqP0rwgbKXoAlL4FPyeSnoAvvneYyI6iEMXe3c0TeFJrucv
         kM9Rah/mom6+9JHJg1Rzl4JHGT6Oiq1QXvlT3cpQmeJmQY/cYabvXXF7FwfRstYG3a7o
         XAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119441; x=1685711441;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfgHYISiig+/bzLlpt5cc7MXWheyapH8Hed5tG6Rzxk=;
        b=LxQB5FKl221qQILtOZGFwkz5YIkZxbDexmfFwdJU0XK5tA4Dw/Xp70/v16uFfiygTz
         ni82w4FFUX1GvyQNwwrgiyAx/8IWNTxJy87e/DmAis9WOXxexj8MitCFPg0s0hVJDxiJ
         1eUPdCiFrcvcSHq6AT8e9piyu+obAAdezht3sJ1MdE2vYwYdJEsua4ahEY4OJ5LKOMYa
         C15ij2P49Wh4HCFYHZt5lha6PhDLtxe9uAp1ik1yIf2VNq5unbnxRdli15dyJ7JXlrAn
         RnOtIEVuRwN8spn1PZu0dU47lSPhjDgsI/25J7Wc5b9ChPclGmJOdDB4j/UmHh/BBdGe
         brsA==
X-Gm-Message-State: AC+VfDwCcKNMNkL0djoD8U6eMIi7NhCaz3qOUOEPhXr45XP/JC0/hbOb
        vlI/2wCiB2I17qGPXmVnUUw9tw==
X-Google-Smtp-Source: ACHHUZ5TDxtBXd7LA5U6MnlV45ehAowrJgF597L+XVwffzRrCOitukI69M8TNbzSNJeQ0k8bRgPRxg==
X-Received: by 2002:a7b:c407:0:b0:3f3:481a:902e with SMTP id k7-20020a7bc407000000b003f3481a902emr3831836wmi.15.1683119441468;
        Wed, 03 May 2023 06:10:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:35 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to
 SuperSpeed graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OydxxcbIJnoOzeLcxgVxiKj5w5nw3QpdepvVEfrMyUc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1M/KEfSBiWs9KneDrCOYEvnOuFEl3BmElxhvMa
 kyHk+biJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdTAAKCRB33NvayMhJ0TRNEA
 DQIkgrSlaX2sqyCMHt+xf6cdVxXRFdCiKmRB0foMKl1F9mRbGbmG2u+NE00sTalf2XSxXyWsDqhOhz
 XWvchOmSTdWPG0inR4wU95CNo5dte8GsPeQuXjgP3YDS7nCvXfe6l9jFHzwowaMwNWIHLWzZ/sXg3v
 nh/y3NuwXxl9H1LynlNHbmpQeNDmASxRs123U5ajHW4CfN4x28RjEPB1bEUsKcuhGfOl3CLqLKWD3n
 DAnI11Mu8qqGLnVu43oOvNo5UfS22cDpN0tN52NstM2CsHDAcSr6bGFI/I29mL3hQ2bNWRCHg/oTS0
 9N39Jh9i4/CSSU3l0y2F0uCsGXhEaFYTg5bKtaxwgLzy2PN9qEShEHMFKcGe8ktEyBt6HKKzlWqmRn
 0E3rXdOi4a5hPdeD1AkCRcQGS4ASlSw5VoAwKqP/SjKvOLxzMFH+K7Z0Q/aNIhrq5eLH+W/JtXhowG
 OcbAuQpoj0dzj4RJlU08A4jS3nLZQG6RfMO4M3WspCMOC+8gDwQ9B0FzrhcG0+q4xk37XLtKMhOcqX
 Ng0MNNmEMalSwfBZml+7E3GLje3cqp8mawpXz2pBfopNJtfoqdY6/FAwtVg5Sh53/y11sdnbouNdCt
 G8teArzy6WL7Zi+07CjvHe3+CLr6Mj1DHtNsN331IJxiPhouCL1nCjb+oq+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 74 ++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 2ee1b121686a..fa835bdb7408 100644
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
@@ -326,6 +334,36 @@ zap-shader {
 	};
 };
 
+&i2c13 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	fsa4480@42 {
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
@@ -370,6 +408,20 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
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
@@ -416,6 +468,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &qupv3_id_2 {
 	status = "okay";
 };
@@ -716,7 +772,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -732,6 +788,20 @@ &usb_1_qmpphy {
 
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p88>;
+
+	orientation-switch;
+};
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
+
+&usb_1_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_dwc3_ss>;
+};
+
+&usb_1_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
 };
 
 &usb_2 {

-- 
2.34.1

