Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66A968C7D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjBFUl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBFUlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:41:23 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351213AA3;
        Mon,  6 Feb 2023 12:41:04 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9AA66D1D67;
        Mon,  6 Feb 2023 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675716032; bh=wwgeMDcIHU2HaiqoMeHN+n1sdl7b4K0Q6WOKBKwPojE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=vy5pREk/fikTQRfiOwkkjMnAyalXialldNCDVHDEh5pvCdaXN5RAT1FcoNbVmmTU8
         tTxGIjABPBiqroBUiDTLAYlfBFrDxoSVBfjtAPBRzBWXKbHw5izwOlk6zs/lTf3zsK
         NjMkq32XSCtbzwas9NUkT7Fl9Oa8+AUXW0e/QugE=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 06 Feb 2023 21:40:16 +0100
Subject: [PATCH v2 3/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add volume
 keys and hall sensor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230122-msm8974-bacon-features-v2-3-06bb83c20a58@z3ntu.xyz>
References: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
In-Reply-To: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wwgeMDcIHU2HaiqoMeHN+n1sdl7b4K0Q6WOKBKwPojE=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj4WW9cMsJDffoL5F/nnYd4uHuAG/ALeOzU4xD8
 MEDUHAnmdqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY+FlvQAKCRBy2EO4nU3X
 VsbcD/4lg88Tzlp7dKAurpPvfTwj7bTVWR+VAY9nmRiezofihSk72uyv2hTSRnjFDFEf2M7t2lk
 OyNXW2NgF6wwdRZAHygfNIwnhcpemJ/q8hVcWpAP4NaopRbBMDjzSuGldyC1oGPo8iq7EK4geCb
 oF7RFpKYbGjtti4oE0X58ZsfmiyC6+vEJ4tr75aj2BoSQ2jernw2AaW5P4G45UJHFpp/Zz3m4Of
 B6CLnqcmiNoJQdLrsAHiU7lchGgVnWFcF6TN7JdVok4AuJoy2kM8CavPhUnHSbo2RMmMaebMIg7
 j4LTQXAQ8YBErySNNYpaMZ7vjLsklKIxVi1c8/go51bI5PS9gXlOu7+w6z6TKwc7lbBDusXPI4a
 gloZVsKewIek5R4gmzqJfpuyvAUbvprJmaV+4LN4FwgUR+9Yt5eTXgLeNuSJr1ouAatXKgAI3MT
 kI8Sf1S2kw6U/B2zWIqFXZtWztH7LjRJnEahTHGI4KkF7vKrQ5SncIdKAEzG/jShcDDefM7FI86
 VZggYKnxBVZbrLsIbZUPbJ6ZebDo4VrLexdKnM9XQQCpCDxN/OY/59S0d+0gX4gF10u5kVVKmvb
 Au2XIWg2iXhqNcr426egnQipwMlJK78YsERchCNOB+j+hnNeedVW79MPUa3XGwMZbX2Q5DI9RWy
 yedjJQp14C2C77w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the volume buttons and the hall sensor that are found on
the device.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts b/arch/arm/boot/dts/qcom-msm8974pro-oneplus-bacon.dts
index 63180fe1d292..c4c355533149 100644
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
+		pinctrl-0 = <&gpio_keys_default>, <&gpio_hall_sensor_default>;
+		pinctrl-names = "default";
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
@@ -95,6 +127,16 @@ &pm8941_coincell {
 	status = "okay";
 };
 
+&pm8941_gpios {
+	gpio_keys_default: gpio-keys-active-state {
+		pins = "gpio2", "gpio5";
+		function = "normal";
+		input-enable;
+		bias-disable;
+		power-source = <PM8941_GPIO_S3>;
+	};
+};
+
 &pm8941_vib {
 	status = "okay";
 };
@@ -349,6 +391,13 @@ &sdhc_1 {
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

