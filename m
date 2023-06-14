Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FD772FE12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbjFNMMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244502AbjFNMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:12:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839502110
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:12:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f62b552751so8441303e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744719; x=1689336719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su1O/8G+NEY/y9W3jeuKWn3I4SvZSn/9II7YQB1Uo7A=;
        b=siUuglJ610MvCGUp2hN7/R+TnDrl5vFoKtttyUv0MV4pIkS5i1D6ZuClQiEV3+wPje
         RSPamO3rZpFtWIh/R0RWaGocuM4uSHsmYOyXZbMsn7MZUi8NXuf/Ac5VxUzGfeflsnT+
         irBM1PNQVn/9Lfk7Z13YtKe7YOW1Quo70d7VhrsH33VX9jUUe2so4gCJWXfjhFGIziv8
         D0WYzfvIPR34BIePI1H04eWV5JEym83PDdyKszkk4jE+LIa31gTsnA5XVGUFjr2ONA3p
         6iLnwh1uXV3n+1Cj/WHDiDL8+HbHpp7dLxtcd9AROPSv+hz6QfNbqxIk3ljQ0+Bul2ey
         u4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744719; x=1689336719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su1O/8G+NEY/y9W3jeuKWn3I4SvZSn/9II7YQB1Uo7A=;
        b=Sn7AX5ASTeH1rxM/3o/1/60duxN7do8Oz84BO45LSamu2HyRzyL6NuavLrtH605dF5
         NlnlI/UpAYZSgI3Opphfli8o5g/iWj07hCxHlhoNhF6vcmJ+uwxK3VAunFVTBPWbrYCl
         ubDsmgD/ndQXmli64Pvjvju8YN2uqY0pZX4mfSmu++XZix+YANlrr63kZfhLWFu05Bxy
         3avsNwYY/dm6hTkNOuAAoXyPrxECfBASUvALydD4VxdNuY+0+x4LqNsAGgBHxuotFo0z
         e/WCUEWKQRnhhYntF5/ArfD8ubPKf+lR07F0JNxuk3IQDsCFjqKQ0Qg/BITXGfaJjBv9
         MKdA==
X-Gm-Message-State: AC+VfDwCuUl19t7pcM8LWisf17dtDf3cVEOIfhmSotB9/hkc6JLYJD+Z
        TQB+7QzgpoC0CHKFgxvd/+Fz+Q==
X-Google-Smtp-Source: ACHHUZ7J2peoF6dOFwXHN4OL8HtvxmF58Nf+m8oQBd9LUKiNtAZyjDfLV5ROsb+BqcCFVJsxMsyMBA==
X-Received: by 2002:a19:6402:0:b0:4f6:5068:3c11 with SMTP id y2-20020a196402000000b004f650683c11mr7269507lfb.40.1686744719772;
        Wed, 14 Jun 2023 05:11:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004f24e797c55sm2109793lfq.25.2023.06.14.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:11:59 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 14:11:49 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v1-4-cf88a0bac26c@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686744712; l=3205;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1zgJzi0lueLgpAeV9ifSlI/3hHdlL1ZQj1ZG7GOA1qs=;
 b=0fsvZEDoDfIjQTVta1gCstx2qgONUqi9iWUR47T413TXK47hK/Bvw7jvn84UhlZd/HL5Pc4Ji
 BgNf6SW979vBeMKxJCjg71GIdtDwdsymEb9e7dYrDqRudLkga/Kxd/D
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up the corresponding GPIOs properly and add the leftover hardware
buttons to mark this piece of the puzzle complete.

Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 10 ++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi      | 54 +++++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index ea4571bf4fbf..58a521046f5f 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -20,6 +20,8 @@ &framebuffer {
 };
 
 &gpio_keys {
+	pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
+
 	g-assist-key {
 		label = "Google Assistant Key";
 		linux,code = <KEY_LEFTMETA>;
@@ -48,6 +50,14 @@ &pm8150_gpios {
 			  "SP_ARI_PWR_ALARM",
 			  "NC",
 			  "NC"; /* GPIO_10 */
+
+	g_assist_n: g-assist-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
 };
 
 &pm8150b_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 9f9e7e9784fe..e55a94e5ff08 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -50,12 +50,26 @@ framebuffer: framebuffer@9c000000 {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		/*
-		 * Camera focus (light press) and camera snapshot (full press)
-		 * seem not to work properly.. Adding the former one stalls the CPU
-		 * and the latter kills the volume down key for whatever reason. In any
-		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
-		 */
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+		pinctrl-names = "default";
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
 
 		key-vol-down {
 			label = "Volume Down";
@@ -543,6 +557,34 @@ &pcie2_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pm8150_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8150b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio2";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.41.0

