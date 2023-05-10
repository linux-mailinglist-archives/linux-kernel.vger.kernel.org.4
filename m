Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BC46FD977
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbjEJIcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjEJIcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:32:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9967618F
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f4249b7badso33860695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707510; x=1686299510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVvJVxoAZM5+EmVQd/l/6++jnHkUtTB+gGHms/8rEDc=;
        b=kFhjomd4CWS9+YFjwDjm5Gp4QemzNs75rzPKe1SJqvdpquvItFm+X8IKk21IzB2zCr
         KXwtI7in5gCg617o67ZO0xFVwKaZvEsnywOBAu16twQhq5EnmxM8bWFzfGBlBXdov5Kn
         C7Y7Q35mYVYdLsIJnr/xRLqEr7LKVkB9tjxzwusHwXIq56Jzd7T4J7z50NU6r+8/lnmH
         3zbUoKg7JP24u00sLsOczudidcBYNBtjE0V3qdBq3eTJWB5y/FdQkQ9sZvV9hbqmu3r2
         zwZeNFvi6HntAD6OldBMHDC70oPPccJLb6QhGA6ZazZGLyM7Y50mohfnnzwXoWtqITLK
         VVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707510; x=1686299510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVvJVxoAZM5+EmVQd/l/6++jnHkUtTB+gGHms/8rEDc=;
        b=ENfGdM37urj+bPTpcXEYPSQn9uAIHSvWTUwyCiHw9MPYXZnfnQQ7iuYKigKVYjkwaR
         jG80jO4Hn+iffh4sayRLmYMRzaUUlsJBHLVlhfZC7bNLHiJ3SUh+H3aWcjNTC6MlBKcM
         E0fK81DunYBnzj1uA5DhnnEFJGeIBwzYQ+WNRX0sO4B8LjDWwc6Cs53LUC9Mv6eTn//n
         QZYGmxraetq9R2P7cSUSgDWryK6IJqzBv67rKtCYn7BJEDdj0mhZ0srVIvgdj4iSDGmX
         FJ1fSD6oilc0g1EnP1afqLiTx3u11xfqCJT20wauDtkFcAxF+hi5WdO1ST+T+pbo3X0d
         w+7g==
X-Gm-Message-State: AC+VfDwIezHpqS6j0y7Xx+Oav9Eu1m1AwiXUngEv60F6I+3AtVhAO9hI
        bbZhAd/1PdONOeerUzyaimjRFA==
X-Google-Smtp-Source: ACHHUZ4mHGa7p1AdlKS+Tr4xbu5mt/zZ81s9Rd/oYHyGVIpnBJ23e6zQ3NCFzU6toAJW5kCSr1X5oQ==
X-Received: by 2002:a7b:cd0f:0:b0:3f4:23df:c681 with SMTP id f15-20020a7bcd0f000000b003f423dfc681mr7014300wmj.12.1683707509770;
        Wed, 10 May 2023 01:31:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bc5d7000000b003ee74c25f12sm22108737wmk.35.2023.05.10.01.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 01:31:49 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 10 May 2023 10:31:42 +0200
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8450-hdk: Add QMP & DP to
 SuperSpeed graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v2-4-8acbbe1e9d14@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mhqlzFH1ENEoCnsxWClRFARSzrlKXwK9ZxQOza6S9v8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkW1ZvPNCJhwFZm3Iu0LpsWSuQG6JqpVczX2dDCiX4
 gWOJ/a2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZFtWbwAKCRB33NvayMhJ0ZjgD/
 9AyIZ16iEpWKze4J9mVdBPTtEGFfjhvgbl/rxoPNSQggsXdehlCLHAICcaZ96FwO26evFG42DNwFij
 Vd7v11GMFwljkjOqWG1mAUKX+1YnbkCggucfjK3wKDHo1vXeKPd5c+MrhohBxDJG9jVwviO1ybQ9hX
 aHfKRMdd0yPHMnyfhK/v3XDfBj8nqkmxn8xhmnR1FcDm9RRuodayey5viFqNIUFk86ZKpeumStHAFf
 VYQ3T2MLkXKKiw1ys0EPCcp1bTBkIyKomK1oT7KCqNgoaEnDooCrX1+w66CAFr87HGhbZ/vtR7FGwm
 HOfuxV474sghjNkuF3NTNN8Sob8GAcNqVJc6TjMHQ9xKh/q3xKuwY4shnj+l0epKA261HCXVvPI2Wu
 0AgPK51iA6kUyVlwBFwrXXg/ijzFmxWtN3bDnendsA0tPg/UjAdRoJ1NmKqi3xeVc3ogfla+rir6OL
 U1q1KtLd7+CF04ztRKnxDqvW+wcZ3PYSTIJIB0sTBLBOoYqP1D1tRl4YG4C3NgEs2sfEmZeIDCCHUk
 vXzyS3TBQmIsaLvSVANZTDoRX2CQH44W7+9m/5qJuN3x48q22SheCWgXvY6TQ7G60LggtcnJCxXcMO
 NdetqkuNsJ/WAXoq6sZtKVxQgtUtpPvEHSJWQcZKaPS1EMRaFjV/6xQ++lEQ==
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
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 73 ++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index e931545a2cac..d5aeb7319776 100644
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
@@ -494,6 +503,37 @@ lt9611_out: endpoint {
 	};
 };
 
+&i2c5 {
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
 &mdss {
 	status = "okay";
 };
@@ -513,6 +553,21 @@ &mdss_dsi0_phy {
 	status = "okay";
 };
 
+&mdss_dp0 {
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
@@ -766,7 +821,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -782,6 +837,20 @@ &usb_1_qmpphy {
 
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p91>;
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
 
 &vamacro {

-- 
2.34.1

