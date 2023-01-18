Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11604671804
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjARJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjARJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:37:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9E8384F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:55:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b5so12003374wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOKB9Zz+BjKJBFcDfmkLVcFXEHvkL9mnlnuKcHLTRsg=;
        b=E9cUKJNbBt3kwhbAOHI/CKd/4LCSpmmFhwW8qWI/VDUttqRocQCEa9JVuLfay5eBuu
         dGimKeTUO3BOFmsKR+9g29MH2WymQrSi5PuuW7BxhE5z7IZ7GsjRRFfNgd3dQmMhEmqp
         xSzrUBgcuJZLNPvmmz5OkfG645D22DzlfEKEmAdQTvfXTL68bzN/hEgXH4uJ7vuNf19+
         IZxOMtumplXAPfwLx9kc+UWUjt3wGi4NvhbBmTbiuKpiex8nKOf23QrU5elXhviaAj0o
         RfFe1m7jL7CSgYWQ70n47W3pEhfI3iMMYu6ZyMAb+9dHa31qsg4tLhnHJNsTOKsopkF8
         uuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOKB9Zz+BjKJBFcDfmkLVcFXEHvkL9mnlnuKcHLTRsg=;
        b=PINGfd8lVWrI0F+PqyOllGpuEoWDK7HDKaVft/kWGX7Xm9DCXLJfAswikjQ8GXE5nB
         iI3GIjQTZW6n105nxaX4XKeBbnFfbYemaROfBdzzYiRiEs0dQi8lieFycnyr6zcvgi1h
         zbvprEUejQaMgYqldsKtWOHjEnyxf7IXDcD+Fc9aEIL6coh5NIbHeztHJfPmbMDWrhp+
         81KI+HxUP4bGi/WcvYTq7Ri4dApbjtEhjTQzkAnYho+3d1qOb9IOWOGr4tQYN6IaXh2R
         lYorP2ztWiri9+brqrqlWT5zX4l8r1nEQqAtOgo+BLQ3/7hr6fW0uz/haEJLgnJgGBhd
         ZDhQ==
X-Gm-Message-State: AFqh2kpqkPIuLt9rG5sYNqz5rD6zZo4ymnOqON5HODkk9XvV0QdIE6wE
        Te0xOc12kXUZptE41VYBo1qATA==
X-Google-Smtp-Source: AMrXdXs3+kary39VGHJfsY0ACqQEqXjkzDroKWb0MbC0EgxWh8SuFelFrcNCpb6iS7LciKKMe/E9pA==
X-Received: by 2002:a5d:48c7:0:b0:2bb:ed0c:a0d8 with SMTP id p7-20020a5d48c7000000b002bbed0ca0d8mr5192938wrs.53.1674032139930;
        Wed, 18 Jan 2023 00:55:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b002bdd155ca4dsm16480212wrs.48.2023.01.18.00.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:55:39 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 09:55:35 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8550-mtp: add DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v3-3-46f0d4e57752@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v3-0-46f0d4e57752@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v3-0-46f0d4e57752@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the Visionox VTDR6130 found on the SM8550-MTP
device.

TLMM states are also added for the Panel reset GPIO and
Tearing Effect signal for when the panel is running in
DSI Command mode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 0dfd1d3db86c..2de387aa2c2d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -370,6 +370,34 @@ &mdss {
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3e_1p2>;
 	status = "okay";
+
+	panel@0 {
+		compatible = "visionox,vtdr6130";
+		reg = <0>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
+		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p2>;
+
+		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+		status = "okay";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
 };
 
 &mdss_dsi0_phy {
@@ -415,6 +443,34 @@ &sleep_clk {
 
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_suspend: sde-dsi-suspend-state {
+		pins = "gpio133";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active: sde-te-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_suspend: sde-te-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart7 {

-- 
2.34.1
