Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7D69471C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBMNdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:33:03 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5891B31F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:33:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qb15so29819038ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CfA+7YWK5fftu9bWm2r5jkUZ+FbbBYidkZ5DdCodcs=;
        b=eGGN3mtx/fmPjOXMZ0l7O/py/cySWsl6E6e1bLUy+i10xNpbSxbpOccpBxZ+KNSkBZ
         q20+rmI+fVqF1SDNup0/AcxJN9puha8bgPizsAptG8qybn1jrzkoqXWYgSE6oWuV6Qh5
         956QCc2xHOiiZXTEYikvJiI3KZrhZQ6ZYiiGyUNxhr8IgmC1FC5pM7uBLBHKfGBK1H1g
         q9uW/bR74VjY/DxL8JxsMF7gxVT/xTFsHqDp49WG4w7QgEm6+w9lRAmI0tbLsVGLJl3H
         eVLpyHsWDMHkTEYq8h62y6hF0JaXjCg51UaHGR6t8nHUriC1ylezPM2GhDSqFLuvb/oL
         2oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CfA+7YWK5fftu9bWm2r5jkUZ+FbbBYidkZ5DdCodcs=;
        b=5lXlHTQHQNyXxGAzIArgfIj3Uyfc9nMI7/s0eLJIpiIHaFuWSQFqLquHVkq/z0lxd9
         0g7rDI73m3mjYMRJovz/DNu+NhYyQ++d/fJplv+nQe++uvoIQY2Ei4cmPI+H0FXxumZe
         D3IVyAJtYtAggPMj1+9YAFcPxOgXEi4b6CleVLjyKE/L9nz65PIRjYnfgskb8jzNZyyg
         ZiwhYN1UwYNO3tUadJiVlBIlq3P9Ulo1F2iDKFZYesfPxbKzyGx/KSf8IWsslvEtUlvc
         BOgHN8nSp1ySKu0XAcsT4QneGtatGkQClV+RMbJ/adD/ArCpuqqvcGIc5Y1tTXLN0yph
         LqiQ==
X-Gm-Message-State: AO0yUKW/Rr7aYAeCG3EgkkGVvgXFHJmx1+qtX+p21EJOeIzVdtVutMfb
        p+zwAPQoCYNRi/R++CL8LlL76A==
X-Google-Smtp-Source: AK7set8/vFnC7Pn5oCi5X3RaHhEwrBd83KL+IGorR5v85xRpe5ndttnsVmSH0IXOEzwDByVYUdZzzg==
X-Received: by 2002:a17:907:9844:b0:888:9693:fb18 with SMTP id jj4-20020a170907984400b008889693fb18mr26220022ejc.37.1676295178730;
        Mon, 13 Feb 2023 05:32:58 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b008aa0305dbe8sm6661180ejx.80.2023.02.13.05.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:32:58 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Feb 2023 14:26:49 +0100
Subject: [PATCH 1/2] arm64: dts: qcom: sm7225-fairphone-fp4: move status
 property down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-fp4-more-i2c-v1-1-5be09dbb5ce6@fairphone.com>
References: <20230213-fp4-more-i2c-v1-0-5be09dbb5ce6@fairphone.com>
In-Reply-To: <20230213-fp4-more-i2c-v1-0-5be09dbb5ce6@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dts contains a mix of status-as-first-property (old qcom
style) and status-as-last-property (new style).

Move all status properties down to the bottom once and for all so that
the style is consistent between different nodes.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index f7602e93121a..86114dd2c0c4 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -110,8 +110,8 @@ active-config0 {
 };
 
 &adsp {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/adsp.mdt";
+	status = "okay";
 };
 
 &apps_rsc {
@@ -355,13 +355,13 @@ &cci1_i2c0 {
 };
 
 &cdsp {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/cdsp.mdt";
+	status = "okay";
 };
 
 &i2c10 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
 
 	haptics@5a {
 		compatible = "awinic,aw8695";
@@ -396,8 +396,8 @@ &ipa {
 };
 
 &mpss {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
+	status = "okay";
 };
 
 &pm6150l_flash {
@@ -423,11 +423,11 @@ led-1 {
 };
 
 &pm6150l_wled {
-	status = "okay";
-
 	qcom,switching-freq = <800>;
 	qcom,current-limit-microamp = <20000>;
 	qcom,num-strings = <2>;
+
+	status = "okay";
 };
 
 &pm6350_gpios {
@@ -441,8 +441,8 @@ gpio_keys_pin: gpio-keys-state {
 };
 
 &pm6350_resin {
-	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pm7250b_adc {
@@ -535,21 +535,21 @@ &uart9 {
 };
 
 &ufs_mem_hc {
-	status = "okay";
-
 	reset-gpios = <&tlmm 156 GPIO_ACTIVE_LOW>;
 
 	vcc-supply = <&vreg_l7e>;
 	vcc-max-microamp = <800000>;
 	vccq2-supply = <&vreg_l12a>;
 	vccq2-max-microamp = <800000>;
+
+	status = "okay";
 };
 
 &ufs_mem_phy {
-	status = "okay";
-
 	vdda-phy-supply = <&vreg_l18a>;
 	vdda-pll-supply = <&vreg_l22a>;
+
+	status = "okay";
 };
 
 &usb_1 {
@@ -562,26 +562,26 @@ &usb_1_dwc3 {
 };
 
 &usb_1_hsphy {
-	status = "okay";
-
 	vdd-supply = <&vreg_l18a>;
 	vdda-pll-supply = <&vreg_l2a>;
 	vdda-phy-dpdm-supply = <&vreg_l3a>;
+
+	status = "okay";
 };
 
 &usb_1_qmpphy {
-	status = "okay";
-
 	vdda-phy-supply = <&vreg_l22a>;
 	vdda-pll-supply = <&vreg_l16a>;
+
+	status = "okay";
 };
 
 &wifi {
-	status = "okay";
-
 	vdd-0.8-cx-mx-supply = <&vreg_l4a>;
 	vdd-1.8-xo-supply = <&vreg_l7a>;
 	vdd-1.3-rfa-supply = <&vreg_l2e>;
 	vdd-3.3-ch0-supply = <&vreg_l10e>;
 	vdd-3.3-ch1-supply = <&vreg_l11e>;
+
+	status = "okay";
 };

-- 
2.39.1

