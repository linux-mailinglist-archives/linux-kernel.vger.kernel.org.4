Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD7B73D051
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjFYLNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:13:41 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B223F8F;
        Sun, 25 Jun 2023 04:13:40 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4E752CEF26;
        Sun, 25 Jun 2023 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1687691589; bh=wI5u0NGeSSUlZf/2J353zgzUWn1fQwb+XGClthQG6Zw=;
        h=From:Date:Subject:To:Cc;
        b=cS2361+bahIAJ5HTwuX2+pZRE9Ogl0KqWJwp3C5YMTUhBBu5MC8h+WGBNl61Rx4Po
         mhVHeiNOcZQFQvVrVioAnRIz7e8N7DJ5BNTgsAurc28L1+KWUgc/v1MlSqFVdoIRVy
         U1SWmJKAyj+TXJyHUmOHhsZ59cLM3UM1A6rX2seM=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 25 Jun 2023 13:13:05 +0200
Subject: [PATCH] arm64: dts: qcom: pm8953: Add thermal zone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230625-pm8953-thermal-v1-1-2b4247d2f769@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAEAhmGQC/x2NzQrCMBAGX6Xs2YWaUP9eRTwk6VezkMayqSKUv
 ruLxxkYZqMGFTS6dRspPtLkVQ2Oh45SDvUJltGYXO98f3IDL/PlOnheM3QOhafkoxsBxHMki2J
 o4KihpmxZfZdiclFM8v1f7o99/wE6MUqqdQAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wI5u0NGeSSUlZf/2J353zgzUWn1fQwb+XGClthQG6Zw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkmCFEYQMMNleZfNMjccn+/aY8Cu4nK/zRDFLKE
 pGl2pTFhGuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZJghRAAKCRBy2EO4nU3X
 VoJREADXdHwoHiJOv1rM6dCwoekWFQXBaztUWM0J7IMKNSE1msVg8ri0tIJdTDb8HVfdtfAEsZd
 Uc14rzItPp/Rl2p+adHViJPfOg1uZ5bvwspPAsenIMhzplTJKBssDxFh9nxALA2ikCxnoe7EHAE
 nV3XaWS2kcnLnzrkUE3fZJQuHI4Po0m0CaSG7+N4QnFUcNOppdLrWWjn2Pjm1bwbkIvxs7u11WF
 905lNwW9HKVlQdaf6y3m5kzV5dKvFa892fpZ5nUUWKQPnus4929VX2cHnbCRwHB1bEvQiq3IVq3
 K4aiDZTMuhJhvJaJCLdpCuYv8P8HF37jmr5P8QaXmLkHj4Wx9MMvH9nURlHA+XA4WdsFw0//bQt
 xfsQ4B9/xKB9wKd50ARi5akqoWM8okQQHasKxVddXefSggzfzqJKsu0iMTl5rOxMsD5Ojq2WVoH
 5AhK/FaeFV1sSEQhQ8gnptMQPPIxLxn9v95kRW9u/isu/WwvJxO2E81jd5jFkXjFym2CDlhWiBI
 0mojQo8VyaCujly/eVyzjz6hhI6Rxqyot/VSB0AHZa7smb+lInBMQaOdn7RRaWEFaS9rc9H8mRy
 /normb31f/ODjpOTD2d1eZMv69gSMdYc/mfZoTNzd9cUhZwK4ZalGOFSR7FJdvkMH8AXk5bhNYs
 mRyqX+TIi+UahEA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the themal zones using the temperature values found in the
downstream 4.9 sources so that the spmi-temp-alarm driver becomes
active.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/pm8953.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 2268daf27fa7..d2dfc1699174 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -6,6 +6,37 @@
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm8953-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8953_temp>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+
+				trip2 {
+					temperature = <145000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pmic@0 {
 		compatible = "qcom,pm8953", "qcom,spmi-pmic";
@@ -36,7 +67,7 @@ pm8953_resin: resin {
 			};
 		};
 
-		temp-alarm@2400 {
+		pm8953_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;

---
base-commit: 8d2be868b42c08290509c60515865f4de24ea704
change-id: 20230625-pm8953-thermal-fc3b2deeeb7b

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

