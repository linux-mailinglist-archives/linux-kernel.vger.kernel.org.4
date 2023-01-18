Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C668671FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjAROgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAROgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:36:12 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922C59576
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so34086141wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNO+xStLObefcxKOOqh9tWK7W5JtgOUQOQVnSTs3zSM=;
        b=kmSe9CfVAh5xT8BFcYWHgK7z1oOqlZ0SYoA7E/C6a9zN9oJT1Zyo90IgVhw1Juq5kE
         37KRYnJCRUa9djuKhJh/Tl9x2V1yfseARAPHtkKHkVcs2WMMf+jcKtdeUbpUikGP+yr2
         f8C2J1O+pjAtbiMJYNpyuU/hiyrGhK3Nb5dNYXhlYw/25c4eUEGZHwXAX7ncZSQ7G6yS
         SDyKAOq4gdoTHGfSZ00ZYL5Yh4rSuHnt/sS0I36KLxttt3+kQfsi8nFMyoKM9xVVLvtR
         PA4F2yO6M8w/BjUdtPW/biffVI/v6G14GeICliz/aziU6IbpjQ0OqlMFcKH+R3ChS4PF
         0ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNO+xStLObefcxKOOqh9tWK7W5JtgOUQOQVnSTs3zSM=;
        b=cH2ej01DxwbXvzFEAkHLoAvc8shy6B8eSgAdIx81PMRvOoGUmSsW+5PVS0liP/G/iu
         H5b33c7o3cWGFMzv26faiIgnoiZ+YSqpDMwIU9Ou/pFw6R+5VuiNDUQhWXHVMlrKacf7
         Mm6Y+tyd9GdC5iAcYav5Jq0hrjb//z+tJVQiFvFcbXpKFeH4hiBpsccxXbyBEzYdHLLF
         9vOjJo3VBWBjcPW692JJntOmpsSmPbc+sWDYKWpEohK++DnvF+jveire4fO7OYAY+CPw
         VfbyZcX2a2Y9D83KlVzaxGrVJ9ttVpAdNk8waM8SF92VW7wE/GOSezyCeJCrRQ2VV7NA
         mSzg==
X-Gm-Message-State: AFqh2koR0cioWYbFsRXCtKfMEgkRdcjHWeXYjivaIoKiXs9C8xuZKgTs
        8lllwgxJrXa7QOEh6eZo3arlOA==
X-Google-Smtp-Source: AMrXdXsJ3dHBhvNGTqcmor3Cq+H6QNGzHNMvtLjytY4IRZjEyLY95aKDPlFoL+KJJ/UFw4l7/Zk6tw==
X-Received: by 2002:adf:f342:0:b0:2bb:9106:d09 with SMTP id e2-20020adff342000000b002bb91060d09mr6110376wrp.15.1674051903216;
        Wed, 18 Jan 2023 06:25:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm10612919wrm.66.2023.01.18.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 06:25:02 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 18 Jan 2023 15:24:58 +0100
Subject: [PATCH v4 3/3] arm64: dts: qcom: sm8550-mtp: add DSI panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230104-topic-sm8550-upstream-dts-display-v4-3-1729cfc0e5db@linaro.org>
References: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
In-Reply-To: <20230104-topic-sm8550-upstream-dts-display-v4-0-1729cfc0e5db@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 0dfd1d3db86c..405212940d09 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -370,6 +370,32 @@ &mdss {
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
@@ -415,6 +441,34 @@ &sleep_clk {
 
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
