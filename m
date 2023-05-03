Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809B6F58B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjECNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjECNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:10:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048CA4EE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:10:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f95231618aso3197401f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683119442; x=1685711442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrEXFHo0z+j0+RsPq07MS8rtilwRnrT5MogchnZAGhc=;
        b=A2XkIwsa5SnqPiiDy8GQhl1HE6TuFSv10wfyWhHqz5V5GJI9CQJR2sSXvCzO4X5ep6
         9giNt+K4IFwUADEJzSodPTc0eZdE2u+B2NP18NEmTCzGQ3lKA2o5sMvTAeqEivSDjLwr
         j/N5VgvvtG1ocXK0BCfPfEHTuvKjKwM12CsZPVceBmiy4MuTYxyxB1Aid+PxH5hnpNvL
         uTSfQtCmE3lSNeUsci2ee7IiH8DR4wRzZ10avd2LhfzXCbyg9y33FwCKzHdJlkvfOlgS
         +a7unixJlBNqGx7evdlxCvgCHzHhcoJ21sxDC7dxoSkGi5UcGdUGarOvWrkl9U0ysLV3
         lR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683119442; x=1685711442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrEXFHo0z+j0+RsPq07MS8rtilwRnrT5MogchnZAGhc=;
        b=RsjdJ7HJh5x/j2gfwbenWNLL3p9Teg9I1Fj+TiwaT3hYmWEJwyHEbY+bzW9j3GM02n
         rIWg1riKOLUIfQ8xDJxXHzip/z0dWUFERbfCJHgkLRx4cewi/L/YDRFdO/9b2a5607HG
         udIai61pKbwLHo6WMnb3v3fKcUxqVihUDv2yKw3oLQOohF0l17WgUms5xDHKyFSWASCe
         5cx8Xx74ymmcJ9CRQ3JENzFoGJkoXb8eEDb8tAvNcSzJkl8c/SM5nOm+GdOJe5GUa8KM
         AOri9Re/PYlQj2MeiVNsY15t+mK7xhFUdxNOk7feVY8gTl9/H+nIN8ltVPHCdEfA2A0Z
         PEkQ==
X-Gm-Message-State: AC+VfDzE6irCRL5d+8c4ViKza4O8//eW123F9YNCz6NS8EMlCxmxefWI
        E5VSTjSpqUTldamQbcimnyHgFA==
X-Google-Smtp-Source: ACHHUZ6ihzjgdx5x0EmqA45vDl1KqSCXNKhL6MChcWAl+TtTAiI03DjKv1BzIAXmInporDycBuG72w==
X-Received: by 2002:adf:f4c9:0:b0:2dd:11b8:8aa9 with SMTP id h9-20020adff4c9000000b002dd11b88aa9mr35135wrp.15.1683119442346;
        Wed, 03 May 2023 06:10:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb0a000000b00306344eaebfsm5413479wrr.28.2023.05.03.06.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:10:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 03 May 2023 15:10:36 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: sm8450-hdk: Add QMP & DP to
 SuperSpeed graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v1-4-d1ee9397f2a6@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=uhTUIsStzdCJQRhHk+dZA22dSJYnvAZB8z8+Kedv+nE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkUl1MEWaSitA6EIBDjcJ8mttgBjcdKIMzHh3l8tY0
 YbU79SaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFJdTAAKCRB33NvayMhJ0QPwD/
 4zD/5Od4m2v2qYe1840oHq0RHGRd6GnF3m3ELEtmw+DC3JOkb5xwMRiKkOkNzae43ls8do6xBtL8mp
 fi1Oz5sdKM5vNrkyMKmHRVE3dloY5896Tf5QOhBZend3DEwUIL7mVp9ZBimkBSOru3Kz6fQI8iTrwR
 uW/ohY2wK+NojbrEpBwcefssj/hNDKGLyWnRGQNuMNtnySG9Kttl/CDe6n9lHA0H3hrnYRtaMcD3hX
 NbHA8UVVrRoAv0snH9wSDwmbmZw28/fK+bm+yPpd3dxW/c1ASLkKzkkpbdLNPMJ0F4afl7Tx+p9tAd
 A+nILtGSSQjxWFbUb5hD5jmmDPsNbHvoA9/WEQfwCDQadivsEs5V8XV6apY7aJGQoiA5HnJQwXIp+M
 Q0Ly3DEQOsn42GUUGQUpt0wcMIOAwmdd2LXgq3UMKSrsXM8OvDEoqoS4MMDXLCF2Qdu6Gc/qG4M7vW
 AGim/Tp9WTlIrbJ3QFymFG3SHSajCgsWsAu0xZlSeFMrs8Q8oHvwIuP54Y8mf48sg7cKbPei/94LFP
 HPxYYagj5OKc8dLoN7tShuAmdecghVZmMBCOBm2iT8iMM3q/Ul0cZj6l/ug61b42ge9p/5QKIASJiw
 VpSQIIwi00WO+ExKNmTHbWMcJLZJAAQc7rY2zLTXrfmKSBW+yyTkHe9flPlQ==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 71 ++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index e931545a2cac..52a14ae0321b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -114,9 +114,18 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss_in: endpoint {
-						remote-endpoint = <&usb_1_dwc3_ss>;
+						remote-endpoint = <&usb_1_qmpphy_out>;
 					};
 				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&fsa4480_sbu_mux>;
+					};
+				};
+
 			};
 		};
 	};
@@ -494,6 +503,36 @@ lt9611_out: endpoint {
 	};
 };
 
+&i2c5 {
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
 &mdss {
 	status = "okay";
 };
@@ -513,6 +552,20 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
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
@@ -766,7 +819,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -782,6 +835,20 @@ &usb_1_qmpphy {
 
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p91>;
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
 
 &vamacro {

-- 
2.34.1

