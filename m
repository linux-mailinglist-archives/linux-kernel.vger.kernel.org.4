Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6711B72DBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbjFMH5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjFMH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:56:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B4199C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8cc04c278so1489565e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686642973; x=1689234973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3XbuYCib/X4piuGwyE4Cdqt8oPGIJ6fhqd+2zqYeRQ=;
        b=fk/ZltC7U0W3foxItlO+DIDLJNgGYkOhIh+zLuogk8HoBq7BpCdOAKCRH5ndkGNsS6
         kfs7p9OijCKazrmqU9tpsIDd2rOu3Nl8UyHPtTDC+s57yFgnkNZGSGIRwPoeu+cs1WjB
         9E4X4Uiz9jD6NkRIrsfli2SaDxtdzGIyLxPonnA+q3XguM1Mwmmd/tzzhCWKFoaIU1iC
         xwFqI/OvgnCoBB4G0T5GSe0ggown9kZ3IoKQpo1Hw6577hxJrc2IFfK3QSPflKIaf29X
         MELWk1gqHf1WyHX5ykeLBX0sNT6hG3ehJ5sm8yQBw/ZUNx1YAl5NlESM7Tu9tV6EfIVP
         uBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642973; x=1689234973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3XbuYCib/X4piuGwyE4Cdqt8oPGIJ6fhqd+2zqYeRQ=;
        b=TXUhG6uBDZgBeRitK7hvpwN0o1+wCQxpeXd0EoMR2keSE9y8zbD6a25EP1n11hVMb7
         HcfDHPsGes+Vz8ioUAaSGi7oGWb3NgTOxO9fTH0/DVczqi7SLas5lfv2YRO/Jfr2gGHy
         f1dIcSgzdvhd56PPb9N06C/Dj9JgTv7yWGM+QHE0YO/qinKoZ7A9SfHe5r86/jXmg6zN
         363ixOkYrAdCbEX/we4FZmHOFlBdVQ1ocrwMPOu6+1NQMaXF6IDTWvAzakPQ3hWMSHe/
         Bz1VbA+NqTWYRskAe98OBQ9HkZB3E3VcY6Fnp5ETixQ0Kgz/XnaxPaAHRmwa1G2mPXnn
         bbww==
X-Gm-Message-State: AC+VfDyjelPSQFj+yNmvKFz0E9Y1lWnrOUZRozzLN8UqCKKcjxrz5LZz
        Vzev96FQnxkxwS5wzVbNqBjeDA==
X-Google-Smtp-Source: ACHHUZ4HkDwgxyrK3mJoSPXlhQbqNyr819oeoW5bm5h60Fdq75gHs1xg7ht1L2FRtARSDSobtWE3xg==
X-Received: by 2002:a7b:ce8d:0:b0:3f7:aad8:4e05 with SMTP id q13-20020a7bce8d000000b003f7aad84e05mr7443306wmj.11.1686642973497;
        Tue, 13 Jun 2023 00:56:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm13662316wmr.5.2023.06.13.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 00:56:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 13 Jun 2023 09:56:00 +0200
Subject: [PATCH v3 7/8] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v3-7-22c9973012b6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=H/7AXCbzplYCwLrFcvSAM2V4UuqlwzmuTO2Cadjb+zM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiCETrGSrWudjRMaiPtx1RTpIt4aoYvnBN/qCrXB4
 IKzjyFmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIghEwAKCRB33NvayMhJ0SMSD/
 9Is7bqsIx4Uk0evm8E5Hl3iK2qy7bULhMzAJpLB/TWMrc1DIEkJa3vRJjd/IpSqqRMgf7OSywB+QQg
 cmUX/wiIS7+YBXdp1yrWfjOk4vEunq52vr8hZXDOvIb3QJoIwvMolfQCXxgTZma5rwC+RPsxuSMHgk
 3nwZkKyvMaJpw94RhH0bRYZjh1vbuPLmkWSSpSvsYm3aB2++yQK6iL+UPk4QJo6cZLM0LmxeNqzlFR
 UGcRlpEgwfEOuBxB/8ZyWygg/+0VIGXcFquAum7112Dy6pNlMZd+QwDHx1BOxs3fZ+Wb9tEtOAkvis
 j41y3QQTrbiokJHRzmn/4YRn+TJmVSjQivv0EiAhcJVRMU9Mnbi2Zkgksc19wvetOBHxmgmHXfPi7e
 xRozZLovMMBrN1PqXhdBb0HCAvpL1h/wkoWa3VSBGCPW4ZpAiE2LL+o2Y9WCrr+RiuSahWQEh1ccu7
 UlDp4vmffteNr6d7DsxNmknd10D9wsjHM5C4XlDlIJkcB+JVI0RhU35Xzc+xZd2zrFXP6RBtFGeREi
 JI9RAkHylpuzEQcmeirKciBLI1wvggvKZ9s7EdMuLlXBBRBN99JbqsgN6qeWJPVmIwEtPtFcMfyfXy
 NfABjFEPczisixi7le7BiFPNy8Uy2BfEj4E+RA55B7QsP9NB5OgIwOgLRxxA==
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

Add nodes to support Type-C USB/DP functionality.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 67 ++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 579f65f52370..92aa67256e8a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -63,6 +63,7 @@ connector@0 {
 			reg = <0>;
 			power-role = "dual";
 			data-role = "dual";
+			orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
 
 			ports {
 				#address-cells = <1>;
@@ -80,7 +81,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&usb_dp_qmpphy_out>;
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
@@ -419,6 +428,37 @@ vreg_l3g_1p2: ldo3 {
 	};
 };
 
+&i2c_master_hub_0 {
+	status = "okay";
+};
+
+&i2c_hub_2 {
+	status = "okay";
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
 &mdss {
 	status = "okay";
 };
@@ -459,6 +499,15 @@ &mdss_dsi0_phy {
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
 	clock-frequency = <1000>;
 };
@@ -652,7 +701,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -668,9 +717,23 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p91>;
 
+	orientation-switch;
+
 	status = "okay";
 };
 
+&usb_dp_qmpphy_dp_in {
+	remote-endpoint = <&mdss_dp0_out>;
+};
+
+&usb_dp_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
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

