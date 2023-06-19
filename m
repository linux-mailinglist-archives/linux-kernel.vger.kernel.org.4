Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE620734D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjFSIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFSIHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:07:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AAEB9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so27817965e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687162042; x=1689754042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP6VTZjk1y8Y2ih01aMJpa2+5nrP0AATdY4kMDgB9U0=;
        b=IgTp/VsPZH+WJfNfVEqfHxjC4+xyGGXvY1SiMmZhV358q8DZGi6OeNAGYfCB6koH56
         gfVxRQVNnWExsqYFi26OXvcZi3Tzdd33nHIZdCtlXDhU3k68mP3h1GDLqNQXUrFolD82
         ebUhEJFIuXyZUrOFL6f83p/72rEkAoOUGh/bXIHMvQziQ/fEZ2TDKaadrUqXCCgJ8RvE
         /AcZZ5G9z35SP9/R79+LoveySM1UwhSXLTh+fIu2YSIv5bRpNLBbZr6mgjUOO5zgsOHh
         WilOhjYshsBBaBS/cep5K5phpZVvepxKFAf9nYm9/2G52RijtnUOBv/zFQPzX6j+WwiW
         ZidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162042; x=1689754042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP6VTZjk1y8Y2ih01aMJpa2+5nrP0AATdY4kMDgB9U0=;
        b=ZpCLuRyD/YiX87fUzyDQVgqWfuop2vniWPmhnlYwMq5SoK3RrkdcVLGeE1AP1OmYM7
         P1COuMiRpwmTsZH0UhxK6IsEF1cdrDb5ONx4dArCh7/FieOYgIWalEglzqJQsDdxvBcI
         HDMjv9ZQfbaBGOTI1iEOpWtNmMLA4kpM4e0k8LO8IymuFHCSU3FoyyZbwpjAAskUJ/yX
         OOdukvjbFTKwlmX/g/iRdolbBUDSigyJHHJgkIXLaBbEX/O3taDwNzOhXmpqOhtZh7oI
         6WsXT1hxwTf52lhhjgiOmpbyOY6fJha5VlJEDDSoNhvY/xamMxa0hUubMDqL8HGcuh+F
         M2BQ==
X-Gm-Message-State: AC+VfDyp0FCXov7EGfyguR437XMUgkUqwZrzht2WA52JwcCKkNOFbFCW
        qv41lU0tSuOYolum0sDNJL3dkw==
X-Google-Smtp-Source: ACHHUZ5DMTJcCEm1RrgR+4GhliBr5oddAlLsSQ7T8osNEBMQHg/5e6RvBU26AZVq227jwYsUPlexpQ==
X-Received: by 2002:a05:600c:ad9:b0:3f6:2ee:6993 with SMTP id c25-20020a05600c0ad900b003f602ee6993mr7460902wmr.4.1687162042427;
        Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bca53000000b003f801c12c58sm9791158wml.43.2023.06.19.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 01:07:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 19 Jun 2023 10:07:17 +0200
Subject: [PATCH v5 5/6] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-type-c-v5-5-9221cd300903@linaro.org>
References: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v5-0-9221cd300903@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=kFtRURsz1oeh0EtjW61UYq9kjQ/AFD5Aq+2wwk6Uat8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkAy0yYCvKq6etkY5BxR/c26e6MJeGzz9gh/3ZUK6
 CmFwPbmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJAMtAAKCRB33NvayMhJ0Vp7D/
 9OSGcTbcww+i/V+wtoTiAKYWoykxYcx7Qf+nrDEafYZUwIXNR5gGb6JWoxS7zOemt+XA1yS55tcypq
 6hzrth6AMEguiKlo/3+QghPrC8sNXZr49SmE7riw032KhfJxLYrbdhKLnAVqC8XabTMjKvXh8UEj22
 lXLvYUc7thdhtd2UuqqvvkKkybd/8tOFKQkMJsO3Ac5U0/zVGHnwAksrxT7hmFh4OEmSdYsliayKrj
 W2YX3a7b14WRN3slbsL+dCEx1LcjsDbn9rARh6dQlnPAI4xoVjTJZntSHEfBc2tpW9UEZMS53mTMts
 bWYCy197m45pYllZj9gENS82h/wYHNuMLhotSPyjDvb7z9tb5N62wWlNw59r2Aq74Ggjae/oqTEImY
 Br77LAdOquJPOKIRdeFjxXlFg8IBoi7tnRW5rHbePpobhyQ5FezBEOlaSxkq/ROXkaGXwvHN7a3yuF
 dnq2ahJSjEY7Z55ub6CnpurBrY8DpPF5j8vstGVjj+pJ6jFAZMyacBo1ON5X3A+kRY9dza2Tf10hj6
 m312Y8NSLcPz16cDvb8m3JFtsiprLjbXoQFmsAYcS4U3KjGiPzasWC6MwgR+v6oMS5oHhfVbxAUEXS
 wX1mTnMUw0ccy6tA4CotVnCfuDjlgfxicfqFk0wHCzm2ic0EEKlQsfO5jP2w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes to support Type-C USB/DP functionality.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 59 +++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index ec86c5f38045..99375f1ceab6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -80,7 +80,15 @@ port@1 {
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
@@ -500,6 +508,30 @@ vreg_l3g_1p2: ldo3 {
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
+		port {
+			fsa4480_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_sbu>;
+			};
+		};
+	};
+};
+
 &lpass_tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio17";
@@ -558,6 +590,15 @@ &mdss_dsi0_phy {
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
@@ -781,7 +822,7 @@ &usb_1_dwc3_hs {
 };
 
 &usb_1_dwc3_ss {
-	remote-endpoint = <&pmic_glink_ss_in>;
+	remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 };
 
 &usb_1_hsphy {
@@ -797,9 +838,23 @@ &usb_dp_qmpphy {
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

