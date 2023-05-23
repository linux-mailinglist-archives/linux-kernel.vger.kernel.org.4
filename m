Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C4F70D4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjEWHQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEWHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:16:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A7130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f60410106cso13975025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684826156; x=1687418156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVvJVxoAZM5+EmVQd/l/6++jnHkUtTB+gGHms/8rEDc=;
        b=D8wsahy80pQidhVeP5AEPRi22lQ6QtNR8/YIZSbWGqWoQU2FMamD/QA06ugXNDZv5v
         4bDlIQ/3YYJDE7+Qfj7tFMbktNQfSaX/hdo4jX/Xrum0lxtUuPgmAbTLCDgsR1DT9lR+
         Tu0Gz+NtHCZny89TVS/5VCFzUtRbSnfyOpQzvcTN1AmT/nJNKejQFQthuEQJCYjPb44I
         hjyKpjn+xDoOFw6ev20Y6mBUmXhC64e9d/hmm7kFs7y1MvdNh6lnQdCgk+s/cRRG20yS
         x94/+pa5hK4PApiUnEdU4+jkdwvmwQCyQAvQleN9PNxQg/YP/O3ZFtFItVu2lg3TosWX
         uSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684826156; x=1687418156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVvJVxoAZM5+EmVQd/l/6++jnHkUtTB+gGHms/8rEDc=;
        b=CtAxprc0laNnWZTqKFpf+gqwNg1U9AY86LCj9mycbv5BYoNrBJOSn84oBR4wB0GrTL
         HtUlYj1Leorlub49BZeBgqH4+uAdqlTrwuzgxsK+cI9xLlil/opw3+Lp8+3F/pIsM17v
         OZncgBgonYF5HQa1WgEos0lFxZprbA5nNjtL4b6DnNz89wl4jzVInPKuLE0aKTsnn5dc
         uX6FP+TqEcOpFkPTQuWrQzbJLj+g8AlQstRKMzYuQoePcRBjie+o61xulgGIPP7gKS5G
         H2u0ErT2jl9dCUdeQxK+ZHG0TT8zYa1BwhQbp98uvCcMYUSElJeFMOSWbdQxpC889A/k
         thjA==
X-Gm-Message-State: AC+VfDzuNcA9BDKsk9xXViZnbJU39oU/Hc8twdGi11c9VC1w5FV1aYLz
        pUXZWt14EaXCjjkOykCGYpC+kA==
X-Google-Smtp-Source: ACHHUZ5PRZwh+G9RBlPJO73KsLDO/XqDaET+wtdS90SPM+LYg15ClKSx9CsFyTAhYQjh1zuqY9h5Kw==
X-Received: by 2002:a1c:7516:0:b0:3f4:2365:e5ac with SMTP id o22-20020a1c7516000000b003f42365e5acmr8900523wmc.13.1684826155809;
        Tue, 23 May 2023 00:15:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b00306299be5a2sm10096239wrq.72.2023.05.23.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:15:55 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 23 May 2023 09:15:48 +0200
Subject: [PATCH v3 4/6] arm64: dts: qcom: sm8450-hdk: Add QMP & DP to
 SuperSpeed graph
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-topic-sm8450-graphics-dp-next-v3-4-6c43d293995f@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkbGglcJDQPJmkkBVVbhOcHOme02dCKUKEan/GDGPp
 Pa/1bACJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZGxoJQAKCRB33NvayMhJ0ddZD/
 9ey3oj/A8lMAcjhbekcxhNk3mh/hcVlC6qrkSFs/6Scc41lLrF5fSmYLdcKqG9pogdX+9ulRrnc+tx
 RJCAFel87m9abg90wcfDXZl69H+b4slQnEd7YP6jM8nxHLztDPlAIhZyl97aywKFmxePPvIrQ43ve3
 cYtcdcPzWhhSSqXJ8eH6rjPjOdGQjgsipeFqfA3hGvj6mr/jsbfrq3cTS4cnM+zy/HYWHEhCy39WlD
 i3RwtqaesXE1LBoQST+5CXp3mHdxnsdLD1Oy+kp2W7tjw8Kphbalh8E/Mhal4vgaU7BC7ZrxRJ7Pl2
 Yc1+JU/14k6l0MwoP0dEEJWualD2DIRbaxOTfPbdsZ3XfQE8V+r+CdHohnq5x8qowLDp6S60Za+24D
 ovjKp/kbVN6F0ar+g4QZOb3PZ1N+LfogzGVgCjPiJu+0zISlaK0nOFt59a6viwDg+udUQVWrVsVqMs
 7+5b4Ptmsl4OL/amGgsAqtlIy9vmauBhUsOt2TrJ2ZD7ZTP9SuSgCf5gYxSU/p9LD9iWrnQf1VZvHY
 J2fmtz/3GROfNeB0x2bSqL5Yr+q4eMUFp+uBCZTQ3uw8r1eM4KRkPeKJo5xVVQe5Iv4rJKaH9LY6yY
 UWCl+FFo5jkKVmZZUC0H+MRl+6A10hlZKUf2RFEeXoqypK3pqrPnPns8+W5Q==
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

