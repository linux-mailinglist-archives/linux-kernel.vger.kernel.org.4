Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06766702D65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbjEONEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242095AbjEONEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:04:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D119B7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f139de8cefso65122900e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684155868; x=1686747868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sA9pxSNs0w6vr3YV0vpThuHVdvo3Cg5A6ey/gFP/ZOk=;
        b=TlP0M676RjiiWcBQhumG9PGPSL4eAdpuxgBsmHjMQ3QW/Skra7jpxpO8wS+T9Sx2EB
         NuxqgiPyQjuC8nYOenCI5Xfe4ZFkdTVarr/FEK4UovQCh18rt8UH9RRSCGip8g172hyo
         rWzaHQM4J1hUljKWMLTnXq9zfrlHLyBrLlxSMYxPuU+kuwNHK3NKJMnNIBPZWPix9UQP
         7A30uqGFQUQmQpOo0MnwkrAmeTiHuvUP7+AvlOrC8nwqyR+uVsStCXSVHHQ81T3aAUP2
         n2ie5+cRoL/3oOsbdmMXtRH/9hvw80gCRjO3hV2PKaq7XdbRMu744gmaIlxgeACSZ4QO
         SarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155868; x=1686747868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA9pxSNs0w6vr3YV0vpThuHVdvo3Cg5A6ey/gFP/ZOk=;
        b=AhRprLbFmDQbCnmiKMXM0L+ZnJLVQHjDfiJPHueNltuDVDKZ4vHdkc30Ex9cP8xhfP
         g88iKHYJAIUGEVDemwZxktx7uuKmrbreAtQP4PHN3xfxOoIAPs+iVoFbCGYp/Vy2UnNw
         8E/Xnm+KC/SPZNff8JB/6aYNqw/bTm9OXeSU74HHPrgBxJ1GxWCeDjCQcgoRzmoEf/FX
         X+bzatiXyC4XYpz80YjhZjkbe1q3VTAQSYq5NV0UfP4ExzuRaKeoz0wBeQpxnsLxjpAl
         n4rPhTuisNayQrfh34tv2ohWDHg+2MwkNRejiza5n9QT8c8iB+p2NnD0hsmua8qol/4o
         OELg==
X-Gm-Message-State: AC+VfDzjhQfXWXfCm7J7D2bYhBAOWcXdhGlA5f9mUveM4n8mpJ7IWMXY
        xPrUawEVt0nXHKsgJVc/+jbJiw==
X-Google-Smtp-Source: ACHHUZ4qb3B+rc7WjlH9tVLqeIyZD9AThfiHoAE3mO9i0oJOvtlfHBKashsMCHY4YPwXFtwk23VSuw==
X-Received: by 2002:ac2:50c3:0:b0:4ed:300c:10b6 with SMTP id h3-20020ac250c3000000b004ed300c10b6mr7304771lfm.21.1684155868299;
        Mon, 15 May 2023 06:04:28 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x27-20020ac25ddb000000b004f37a64c90asm785823lfq.303.2023.05.15.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:04:28 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 15 May 2023 15:04:13 +0200
Subject: [PATCH 2/5] arm64: dts: qcom: qrb4210-rb2: Enable display out
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230515-topic-rb2-bits-v1-2-a52d154a639d@linaro.org>
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
In-Reply-To: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684155864; l=2637;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=avvssNTgG0e3S5Kryg79ULmCxgvbqADEkl/jEuLJ6M4=;
 b=weZU+7DXgUJ9tQ8ae/JaYWlwn62DzmanmUnc1lZooL601zypgm81gQOp3Eulc7oCgnUg4JLEi
 N41WnNPI7+BAJ5s6NQg3AUTPqXrgGBTJhaxDoeaXiX9Q0GVGjG3cJew
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RB2 has a HDMI output via an LT9611UXC bridge. Set it up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 88 +++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 80c6b59c8ff6..9b539720f05d 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -19,6 +19,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
 	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VREG_HDMI_OUT_1P2";
@@ -109,6 +120,68 @@ &eud {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+		interrupts-extended = <&tlmm 46 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 41 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_hdmi_out_1p2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-0 = <&lt9611_irq_pin &lt9611_rst_pin>;
+		pinctrl-names = "default";
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l18a_1p232>;
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&lt9611_a>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -312,11 +385,24 @@ &sleep_clk {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
+	gpio-reserved-ranges = <43 2>, <47 1>,
 			       <49 1>, <52 1>, <54 1>,
 			       <56 3>, <61 2>, <64 1>,
 			       <68 1>, <72 8>, <96 1>;
 
+	lt9611_rst_pin: lt9611-rst-state {
+		pins = "gpio41";
+		function = "gpio";
+		input-disable;
+		output-high;
+	};
+
+	lt9611_irq_pin: lt9611-irq-state {
+		pins = "gpio46";
+		function = "gpio";
+		bias-disable;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio88";
 		function = "gpio";

-- 
2.40.1

