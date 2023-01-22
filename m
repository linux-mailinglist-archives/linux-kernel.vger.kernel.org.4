Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263A36770CC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAVQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAVQtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:49:39 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB460977F;
        Sun, 22 Jan 2023 08:49:27 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 2D032CD52A;
        Sun, 22 Jan 2023 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674406136; bh=MCYD/uKQXcuXE8zoypcmrFGZUxOYwaOpgwRq/s5nvUg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=YVLytJs541OFZq9By4XMD03QPGYxaFK82j7xt4j+3kTUHeN/6rClGXLMDtWtpBcmV
         94SqW2L3fYCOU35IZPf3Payo2gBQv1dLBA0hoNrl4BPgT0GcBuKVIbHD074RVX8C4u
         kGM1l0fNLe0WjuI0yU/gBbg3487sAi72++GwcRCk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 22 Jan 2023 17:48:34 +0100
Subject: [PATCH 3/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add volume keys
 and hall sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v1-3-4049f565c24c@z3ntu.xyz>
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
In-Reply-To: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=MCYD/uKQXcuXE8zoypcmrFGZUxOYwaOpgwRq/s5nvUg=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBjzWj0K+Sjdz33+q+ZiyEneatD28/kXhatCcKKTvc7
 O0Kdjz2JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY81o9AAKCRBy2EO4nU3XVrGpD/
 4+7bo644DmLWzueuSheIyicxki8irbf8K/fI9kXquRj1+dfJuHK+n+piVA7IpCUSvRSRwK3xe7K4dY
 M+B0x7GAxA+A2YjWsyANk1yh8Ytcl/EVH3eXoa4ZyKYHFsaJudqZgflm7zrWCC9kp9xn4v7rePo9HN
 FXUIuYTCFSqR3UgS7ANYErPY3EoYhzSrLVfgnwSTYMV+esUowhz5TB3u1GRAZuY/n9al2hodE5DzFs
 z6dIPx0NDMim++3P8VgxMrQftXB1FejQW/9OcydUY4hUyf/nVwG8oqTRp860Uffzz6kjAnN5dVoeJu
 MZOFVxe64mOA152KC4nilZUhdHq1+lU1Cy1gsAlE89Uz2o/nFCaLwZt/C9W1H/9uWdHlXn3TjD6w54
 /JP79LY9NVkNSM0jOYS+Su1gf/DYoJWI9I5v93Ct656w/iDW4NcykGipSwkTFPr8/O4TniFF6Zsxxd
 LnPo/6t/KRGQokDoVDvtVdyUtMeZ3mrtnJ/+zlKvjy+o0Xg/uWhFrinxe1vW6LB3OR77g77H0UiEvi
 wWC/dFIf/Vyp2IwhFgo/lSJYZfSVLxhOnAzpT+7vUx2L5BlRlHwN6ACU+MIMJlR8NxIbdZr4uLTi3N
 jlF6QkRnjIS857G8c68QbTuw4iKnCAYaXQQXF1D0m4bTwZwKJDdtC146BjTw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the volume buttons and the hall sensor that are found on
the device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index 63180fe1d292..10ba3c94e26d 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
@@ -19,6 +19,38 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>, <&gpio_hall_sensor_default>;
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&pm8941_gpios 2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&pm8941_gpios 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 68 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			debounce-interval = <150>;
+		};
+	};
 };
 
 &blsp1_i2c1 {
@@ -95,6 +127,17 @@ &pm8941_coincell {
 	status = "okay";
 };
 
+&pm8941_gpios {
+	gpio_keys_default: gpio-keys-active-state {
+		pins = "gpio2", "gpio5";
+		function = "normal";
+
+		input-enable;
+		bias-disable;
+		power-source = <PM8941_GPIO_S3>;
+	};
+};
+
 &pm8941_vib {
 	status = "okay";
 };
@@ -349,6 +392,13 @@ &sdhc_1 {
 };
 
 &tlmm {
+	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
+		pins = "gpio68";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
 	sdc1_on: sdc1-on-state {
 		clk-pins {
 			pins = "sdc1_clk";

-- 
2.39.1
