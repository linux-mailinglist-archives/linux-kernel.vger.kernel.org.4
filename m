Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0317149AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjE2Mrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjE2MrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:22 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE7B5;
        Mon, 29 May 2023 05:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364424; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BIuMWY2+8SNTq0bTFPK1Qe6ZfOCTLHRBbT8wiCxGRkjZIgPfNP4OxEhHIxqVi4zj0z
    +2D3vWSDA+bN/Qp+9PygQSgOV2ya7YGngIakGlY8yHnPwMFmAaetz3bAOmlTeBWD/WJM
    YS6Vt/qzzWV9UM1I0o34h70W8L8yDHE7qNh9pWwZw+qFNf08b54lm+mgRuuWxh6DYb2L
    SnLuedCc+bKPmwWT/mHib4eZKKFX1sRx0ZIfgyhb8v7W2lNCGXk2GtV5zPXVQcmBHb+t
    +IKbqqv6MIL/SlZOr9c8XZ60Xv4fsSGb7BKe5UWSaO1NHquiJ30ulPqkBTmz5LNxTTDC
    KSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wzxg7bcXhPYJgolV6k/GYwUK51DPEW4MNFWgMVrEs3w=;
    b=l8m/9ZOFL/S2vW6neoc3BBP3gCBPD4kTZEbIV6RtfLCuKbWe21fVXAv+NdzSDazkMm
    ZjNQ593kIRB3L0ODWjd/YFHOSqUTjy6dec4dmFxFgGspS2hxbS/9v8vwS1pap4qyAyuD
    KxZbB5AzQpiGAu9cm0Ji/zLc3t8lT9tS9Ykoqa1XkYi3J/TFPFCkN3kyP6TQmRoai9St
    fNGF+uN9jhXe9PzNVYOG3V1gylVBx8eIefl2/o5EYa1NVXecwCTuHhI0EKI7GnjoJxEO
    HI5LNQVxvMqnKz3OCplBnOUbGookTUaIOIy33bH2Pt4ZbBTwGiTAAF/6WMvwDlJbyokb
    SuWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wzxg7bcXhPYJgolV6k/GYwUK51DPEW4MNFWgMVrEs3w=;
    b=NVCm9RtlMNGy3zPCjSlutli3y2qnQeDPe5qvFULlX9ChHz02gMP6yd5PQJt7bbn8ED
    +1B9sR5HpPsippEAIk6pdhc8jwZMNw4ThI8uLpisjONdTWanKUjbMpkkjIhs7DtszowO
    Gz+vyop5KUJDdMpYTLATpFtxt8wMardfAg5GQvKTPxyIpXq0UWnXnSu7cBx/mTRpp6Tr
    3n4nd4MARMIgBHxDLZDEzGRCj15T1xcLav6SHiWvJBQ/ODKxBeKCmlXoEMy1hQbnGUhe
    /zdWhkQkOaLJxyrNosJoZwOGea0AyNtHz8m6SkF+PQetMb8sZiROIk4caGv5n7TMl8UP
    ct3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wzxg7bcXhPYJgolV6k/GYwUK51DPEW4MNFWgMVrEs3w=;
    b=GesPLK1wqot/a+5ZYHRqLFy8b5KfF0QfOStoipKPGccFI2BkOQo9DkUnbD7blnRwPK
    O6bO1GUFeFKrvS0quABA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl4f8W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 14:47:00 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: msm8916/39: Use consistent name for
 I2C/SPI pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-msm8916-labels-v1-3-bec0f5fb46fb@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
In-Reply-To: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the labels for the BLSP I2C/SPI pinctrl consistent with the one
used for UART by adding the missing blsp_ prefix. This allows having
them properly grouped together.

The nodes are only reordered in msm8939.dtsi for now since the pinctrl
definitions in msm8916-pins.dtsi are currently still unordered anyway.
(I will try fixing this in a future patch.)

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts   |   6 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi |  48 +--
 arch/arm64/boot/dts/qcom/msm8916.dtsi      |  48 +--
 arch/arm64/boot/dts/qcom/msm8939.dtsi      | 504 ++++++++++++++---------------
 4 files changed, 303 insertions(+), 303 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 19bf429a973e..4f3d837578fd 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -479,15 +479,15 @@ &wcnss_iris {
  * 2mA drive strength is not enough when connecting multiple
  * I2C devices with different pull up resistors.
  */
-&i2c2_default {
+&blsp_i2c2_default {
 	drive-strength = <16>;
 };
 
-&i2c4_default {
+&blsp_i2c4_default {
 	drive-strength = <16>;
 };
 
-&i2c6_default {
+&blsp_i2c6_default {
 	drive-strength = <16>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 3539d9029bed..1b60d42a13c7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -38,7 +38,7 @@ blsp_uart2_sleep: blsp-uart2-sleep-state {
 		bias-pull-down;
 	};
 
-	spi1_default: spi1-default-state {
+	blsp_spi1_default: blsp-spi1-default-state {
 		spi-pins {
 			pins = "gpio0", "gpio1", "gpio3";
 			function = "blsp_spi1";
@@ -56,7 +56,7 @@ cs-pins {
 		};
 	};
 
-	spi1_sleep: spi1-sleep-state {
+	blsp_spi1_sleep: blsp-spi1-sleep-state {
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "gpio";
 
@@ -64,7 +64,7 @@ spi1_sleep: spi1-sleep-state {
 		bias-pull-down;
 	};
 
-	spi2_default: spi2-default-state {
+	blsp_spi2_default: blsp-spi2-default-state {
 		spi-pins {
 			pins = "gpio4", "gpio5", "gpio7";
 			function = "blsp_spi2";
@@ -82,7 +82,7 @@ cs-pins {
 		};
 	};
 
-	spi2_sleep: spi2-sleep-state {
+	blsp_spi2_sleep: blsp-spi2-sleep-state {
 		pins = "gpio4", "gpio5", "gpio6", "gpio7";
 		function = "gpio";
 
@@ -90,7 +90,7 @@ spi2_sleep: spi2-sleep-state {
 		bias-pull-down;
 	};
 
-	spi3_default: spi3-default-state {
+	blsp_spi3_default: blsp-spi3-default-state {
 		spi-pins {
 			pins = "gpio8", "gpio9", "gpio11";
 			function = "blsp_spi3";
@@ -108,7 +108,7 @@ cs-pins {
 		};
 	};
 
-	spi3_sleep: spi3-sleep-state {
+	blsp_spi3_sleep: blsp-spi3-sleep-state {
 		pins = "gpio8", "gpio9", "gpio10", "gpio11";
 		function = "gpio";
 
@@ -116,7 +116,7 @@ spi3_sleep: spi3-sleep-state {
 		bias-pull-down;
 	};
 
-	spi4_default: spi4-default-state {
+	blsp_spi4_default: blsp-spi4-default-state {
 		spi-pins {
 			pins = "gpio12", "gpio13", "gpio15";
 			function = "blsp_spi4";
@@ -134,7 +134,7 @@ cs-pins {
 		};
 	};
 
-	spi4_sleep: spi4-sleep-state {
+	blsp_spi4_sleep: blsp-spi4-sleep-state {
 		pins = "gpio12", "gpio13", "gpio14", "gpio15";
 		function = "gpio";
 
@@ -142,7 +142,7 @@ spi4_sleep: spi4-sleep-state {
 		bias-pull-down;
 	};
 
-	spi5_default: spi5-default-state {
+	blsp_spi5_default: blsp-spi5-default-state {
 		spi-pins {
 			pins = "gpio16", "gpio17", "gpio19";
 			function = "blsp_spi5";
@@ -160,7 +160,7 @@ cs-pins {
 		};
 	};
 
-	spi5_sleep: spi5-sleep-state {
+	blsp_spi5_sleep: blsp-spi5-sleep-state {
 		pins = "gpio16", "gpio17", "gpio18", "gpio19";
 		function = "gpio";
 
@@ -168,7 +168,7 @@ spi5_sleep: spi5-sleep-state {
 		bias-pull-down;
 	};
 
-	spi6_default: spi6-default-state {
+	blsp_spi6_default: blsp-spi6-default-state {
 		spi-pins {
 			pins = "gpio20", "gpio21", "gpio23";
 			function = "blsp_spi6";
@@ -186,7 +186,7 @@ cs-pins {
 		};
 	};
 
-	spi6_sleep: spi6-sleep-state {
+	blsp_spi6_sleep: blsp-spi6-sleep-state {
 		pins = "gpio20", "gpio21", "gpio22", "gpio23";
 		function = "gpio";
 
@@ -194,7 +194,7 @@ spi6_sleep: spi6-sleep-state {
 		bias-pull-down;
 	};
 
-	i2c1_default: i2c1-default-state {
+	blsp_i2c1_default: blsp-i2c1-default-state {
 		pins = "gpio2", "gpio3";
 		function = "blsp_i2c1";
 
@@ -202,7 +202,7 @@ i2c1_default: i2c1-default-state {
 		bias-disable;
 	};
 
-	i2c1_sleep: i2c1-sleep-state {
+	blsp_i2c1_sleep: blsp-i2c1-sleep-state {
 		pins = "gpio2", "gpio3";
 		function = "gpio";
 
@@ -210,7 +210,7 @@ i2c1_sleep: i2c1-sleep-state {
 		bias-disable;
 	};
 
-	i2c2_default: i2c2-default-state {
+	blsp_i2c2_default: blsp-i2c2-default-state {
 		pins = "gpio6", "gpio7";
 		function = "blsp_i2c2";
 
@@ -218,7 +218,7 @@ i2c2_default: i2c2-default-state {
 		bias-disable;
 	};
 
-	i2c2_sleep: i2c2-sleep-state {
+	blsp_i2c2_sleep: blsp-i2c2-sleep-state {
 		pins = "gpio6", "gpio7";
 		function = "gpio";
 
@@ -226,7 +226,7 @@ i2c2_sleep: i2c2-sleep-state {
 		bias-disable;
 	};
 
-	i2c3_default: i2c3-default-state {
+	blsp_i2c3_default: blsp-i2c3-default-state {
 		pins = "gpio10", "gpio11";
 		function = "blsp_i2c3";
 
@@ -234,7 +234,7 @@ i2c3_default: i2c3-default-state {
 		bias-disable;
 	};
 
-	i2c3_sleep: i2c3-sleep-state {
+	blsp_i2c3_sleep: blsp-i2c3-sleep-state {
 		pins = "gpio10", "gpio11";
 		function = "gpio";
 
@@ -242,7 +242,7 @@ i2c3_sleep: i2c3-sleep-state {
 		bias-disable;
 	};
 
-	i2c4_default: i2c4-default-state {
+	blsp_i2c4_default: blsp-i2c4-default-state {
 		pins = "gpio14", "gpio15";
 		function = "blsp_i2c4";
 
@@ -250,7 +250,7 @@ i2c4_default: i2c4-default-state {
 		bias-disable;
 	};
 
-	i2c4_sleep: i2c4-sleep-state {
+	blsp_i2c4_sleep: blsp-i2c4-sleep-state {
 		pins = "gpio14", "gpio15";
 		function = "gpio";
 
@@ -258,7 +258,7 @@ i2c4_sleep: i2c4-sleep-state {
 		bias-disable;
 	};
 
-	i2c5_default: i2c5-default-state {
+	blsp_i2c5_default: blsp-i2c5-default-state {
 		pins = "gpio18", "gpio19";
 		function = "blsp_i2c5";
 
@@ -266,7 +266,7 @@ i2c5_default: i2c5-default-state {
 		bias-disable;
 	};
 
-	i2c5_sleep: i2c5-sleep-state {
+	blsp_i2c5_sleep: blsp-i2c5-sleep-state {
 		pins = "gpio18", "gpio19";
 		function = "gpio";
 
@@ -274,7 +274,7 @@ i2c5_sleep: i2c5-sleep-state {
 		bias-disable;
 	};
 
-	i2c6_default: i2c6-default-state {
+	blsp_i2c6_default: blsp-i2c6-default-state {
 		pins = "gpio22", "gpio23";
 		function = "blsp_i2c6";
 
@@ -282,7 +282,7 @@ i2c6_default: i2c6-default-state {
 		bias-disable;
 	};
 
-	i2c6_sleep: i2c6-sleep-state {
+	blsp_i2c6_sleep: blsp-i2c6-sleep-state {
 		pins = "gpio22", "gpio23";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8081e2611e3c..7e6a60e6edef 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1637,8 +1637,8 @@ blsp_i2c1: i2c@78b5000 {
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c1_default>;
-			pinctrl-1 = <&i2c1_sleep>;
+			pinctrl-0 = <&blsp_i2c1_default>;
+			pinctrl-1 = <&blsp_i2c1_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1654,8 +1654,8 @@ blsp_spi1: spi@78b5000 {
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi1_default>;
-			pinctrl-1 = <&spi1_sleep>;
+			pinctrl-0 = <&blsp_spi1_default>;
+			pinctrl-1 = <&blsp_spi1_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1671,8 +1671,8 @@ blsp_i2c2: i2c@78b6000 {
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c2_default>;
-			pinctrl-1 = <&i2c2_sleep>;
+			pinctrl-0 = <&blsp_i2c2_default>;
+			pinctrl-1 = <&blsp_i2c2_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1688,8 +1688,8 @@ blsp_spi2: spi@78b6000 {
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi2_default>;
-			pinctrl-1 = <&spi2_sleep>;
+			pinctrl-0 = <&blsp_spi2_default>;
+			pinctrl-1 = <&blsp_spi2_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1705,8 +1705,8 @@ blsp_i2c3: i2c@78b7000 {
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c3_default>;
-			pinctrl-1 = <&i2c3_sleep>;
+			pinctrl-0 = <&blsp_i2c3_default>;
+			pinctrl-1 = <&blsp_i2c3_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1722,8 +1722,8 @@ blsp_spi3: spi@78b7000 {
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi3_default>;
-			pinctrl-1 = <&spi3_sleep>;
+			pinctrl-0 = <&blsp_spi3_default>;
+			pinctrl-1 = <&blsp_spi3_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1739,8 +1739,8 @@ blsp_i2c4: i2c@78b8000 {
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c4_default>;
-			pinctrl-1 = <&i2c4_sleep>;
+			pinctrl-0 = <&blsp_i2c4_default>;
+			pinctrl-1 = <&blsp_i2c4_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1756,8 +1756,8 @@ blsp_spi4: spi@78b8000 {
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi4_default>;
-			pinctrl-1 = <&spi4_sleep>;
+			pinctrl-0 = <&blsp_spi4_default>;
+			pinctrl-1 = <&blsp_spi4_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1773,8 +1773,8 @@ blsp_i2c5: i2c@78b9000 {
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c5_default>;
-			pinctrl-1 = <&i2c5_sleep>;
+			pinctrl-0 = <&blsp_i2c5_default>;
+			pinctrl-1 = <&blsp_i2c5_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1790,8 +1790,8 @@ blsp_spi5: spi@78b9000 {
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi5_default>;
-			pinctrl-1 = <&spi5_sleep>;
+			pinctrl-0 = <&blsp_spi5_default>;
+			pinctrl-1 = <&blsp_spi5_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1807,8 +1807,8 @@ blsp_i2c6: i2c@78ba000 {
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&i2c6_default>;
-			pinctrl-1 = <&i2c6_sleep>;
+			pinctrl-0 = <&blsp_i2c6_default>;
+			pinctrl-1 = <&blsp_i2c6_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1824,8 +1824,8 @@ blsp_spi6: spi@78ba000 {
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&spi6_default>;
-			pinctrl-1 = <&spi6_sleep>;
+			pinctrl-0 = <&blsp_spi6_default>;
+			pinctrl-1 = <&blsp_spi6_sleep>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index a44f7e829513..1196a962897f 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -660,6 +660,234 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			blsp_i2c1_default: blsp-i2c1-default-state {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c1_sleep: blsp-i2c1-sleep-state {
+				pins = "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c2_default: blsp-i2c2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c2_sleep: blsp-i2c2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c3_default: blsp-i2c3-default-state {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c3_sleep: blsp-i2c3-sleep-state {
+				pins = "gpio10", "gpio11";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c4_default: blsp-i2c4-default-state {
+				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c4_sleep: blsp-i2c4-sleep-state {
+				pins = "gpio14", "gpio15";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c5_default: blsp-i2c5-default-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp_i2c5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c5_sleep: blsp-i2c5-sleep-state {
+				pins = "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c6_default: blsp-i2c6-default-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_i2c6_sleep: blsp-i2c6-sleep-state {
+				pins = "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp_spi1_default: blsp-spi1-default-state {
+				spi-pins {
+					pins = "gpio0", "gpio1", "gpio3";
+					function = "blsp_spi1";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio2";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi1_sleep: blsp-spi1-sleep-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_spi2_default: blsp-spi2-default-state {
+				spi-pins {
+					pins = "gpio4", "gpio5", "gpio7";
+					function = "blsp_spi2";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio6";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi2_sleep: blsp-spi2-sleep-state {
+				pins = "gpio4", "gpio5", "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_spi3_default: blsp-spi3-default-state {
+				spi-pins {
+					pins = "gpio8", "gpio9", "gpio11";
+					function = "blsp_spi3";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio10";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi3_sleep: blsp-spi3-sleep-state {
+				pins = "gpio8", "gpio9", "gpio10", "gpio11";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_spi4_default: blsp-spi4-default-state {
+				spi-pins {
+					pins = "gpio12", "gpio13", "gpio15";
+					function = "blsp_spi4";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio14";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi4_sleep: blsp-spi4-sleep-state {
+				pins = "gpio12", "gpio13", "gpio14", "gpio15";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_spi5_default: blsp-spi5-default-state {
+				spi-pins {
+					pins = "gpio16", "gpio17", "gpio19";
+					function = "blsp_spi5";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio18";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi5_sleep: blsp-spi5-sleep-state {
+				pins = "gpio16", "gpio17", "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_spi6_default: blsp-spi6-default-state {
+				spi-pins {
+					pins = "gpio20", "gpio21", "gpio23";
+					function = "blsp_spi6";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio22";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp_spi6_sleep: blsp-spi6-sleep-state {
+				pins = "gpio20", "gpio21", "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			blsp_uart1_default: blsp-uart1-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "blsp_uart1";
@@ -852,90 +1080,6 @@ ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
 				};
 			};
 
-			i2c1_default: i2c1-default-state {
-				pins = "gpio2", "gpio3";
-				function = "blsp_i2c1";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c1_sleep: i2c1-sleep-state {
-				pins = "gpio2", "gpio3";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c2_default: i2c2-default-state {
-				pins = "gpio6", "gpio7";
-				function = "blsp_i2c2";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c2_sleep: i2c2-sleep-state {
-				pins = "gpio6", "gpio7";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c3_default: i2c3-default-state {
-				pins = "gpio10", "gpio11";
-				function = "blsp_i2c3";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c3_sleep: i2c3-sleep-state {
-				pins = "gpio10", "gpio11";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c4_default: i2c4-default-state {
-				pins = "gpio14", "gpio15";
-				function = "blsp_i2c4";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c4_sleep: i2c4-sleep-state {
-				pins = "gpio14", "gpio15";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c5_default: i2c5-default-state {
-				pins = "gpio18", "gpio19";
-				function = "blsp_i2c5";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c5_sleep: i2c5-sleep-state {
-				pins = "gpio18", "gpio19";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c6_default: i2c6-default-state {
-				pins = "gpio22", "gpio23";
-				function = "blsp_i2c6";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
-			i2c6_sleep: i2c6-sleep-state {
-				pins = "gpio22", "gpio23";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-disable;
-			};
-
 			sdc1_default_state: sdc1-default-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -1030,150 +1174,6 @@ cd-pins {
 				};
 			};
 
-			spi1_default: spi1-default-state {
-				spi-pins {
-					pins = "gpio0", "gpio1", "gpio3";
-					function = "blsp_spi1";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio2";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi1_sleep: spi1-sleep-state {
-				pins = "gpio0", "gpio1", "gpio2", "gpio3";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			spi2_default: spi2-default-state {
-				spi-pins {
-					pins = "gpio4", "gpio5", "gpio7";
-					function = "blsp_spi2";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio6";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi2_sleep: spi2-sleep-state {
-				pins = "gpio4", "gpio5", "gpio6", "gpio7";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			spi3_default: spi3-default-state {
-				spi-pins {
-					pins = "gpio8", "gpio9", "gpio11";
-					function = "blsp_spi3";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio10";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi3_sleep: spi3-sleep-state {
-				pins = "gpio8", "gpio9", "gpio10", "gpio11";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			spi4_default: spi4-default-state {
-				spi-pins {
-					pins = "gpio12", "gpio13", "gpio15";
-					function = "blsp_spi4";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio14";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi4_sleep: spi4-sleep-state {
-				pins = "gpio12", "gpio13", "gpio14", "gpio15";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			spi5_default: spi5-default-state {
-				spi-pins {
-					pins = "gpio16", "gpio17", "gpio19";
-					function = "blsp_spi5";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio18";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi5_sleep: spi5-sleep-state {
-				pins = "gpio16", "gpio17", "gpio18", "gpio19";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
-			spi6_default: spi6-default-state {
-				spi-pins {
-					pins = "gpio20", "gpio21", "gpio23";
-					function = "blsp_spi6";
-					drive-strength = <12>;
-					bias-disable;
-				};
-
-				cs-pins {
-					pins = "gpio22";
-					function = "gpio";
-					drive-strength = <16>;
-					bias-disable;
-					output-high;
-				};
-			};
-
-			spi6_sleep: spi6-sleep-state {
-				pins = "gpio20", "gpio21", "gpio22", "gpio23";
-				function = "gpio";
-				drive-strength = <2>;
-				bias-pull-down;
-			};
-
 			wcnss_pin_a: wcnss-active-state {
 				pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
 				function = "wcss_wlan";
@@ -1716,8 +1716,8 @@ blsp_i2c1: i2c@78b5000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c1_default>;
-			pinctrl-1 = <&i2c1_sleep>;
+			pinctrl-0 = <&blsp_i2c1_default>;
+			pinctrl-1 = <&blsp_i2c1_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1733,8 +1733,8 @@ blsp_spi1: spi@78b5000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi1_default>;
-			pinctrl-1 = <&spi1_sleep>;
+			pinctrl-0 = <&blsp_spi1_default>;
+			pinctrl-1 = <&blsp_spi1_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1750,8 +1750,8 @@ blsp_i2c2: i2c@78b6000 {
 			clock-names =  "core", "iface";
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c2_default>;
-			pinctrl-1 = <&i2c2_sleep>;
+			pinctrl-0 = <&blsp_i2c2_default>;
+			pinctrl-1 = <&blsp_i2c2_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1767,8 +1767,8 @@ blsp_spi2: spi@78b6000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi2_default>;
-			pinctrl-1 = <&spi2_sleep>;
+			pinctrl-0 = <&blsp_spi2_default>;
+			pinctrl-1 = <&blsp_spi2_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1784,8 +1784,8 @@ blsp_i2c3: i2c@78b7000 {
 			clock-names =  "core", "iface";
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c3_default>;
-			pinctrl-1 = <&i2c3_sleep>;
+			pinctrl-0 = <&blsp_i2c3_default>;
+			pinctrl-1 = <&blsp_i2c3_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1801,8 +1801,8 @@ blsp_spi3: spi@78b7000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi3_default>;
-			pinctrl-1 = <&spi3_sleep>;
+			pinctrl-0 = <&blsp_spi3_default>;
+			pinctrl-1 = <&blsp_spi3_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1818,8 +1818,8 @@ blsp_i2c4: i2c@78b8000 {
 			clock-names =  "core", "iface";
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c4_default>;
-			pinctrl-1 = <&i2c4_sleep>;
+			pinctrl-0 = <&blsp_i2c4_default>;
+			pinctrl-1 = <&blsp_i2c4_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1835,8 +1835,8 @@ blsp_spi4: spi@78b8000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi4_default>;
-			pinctrl-1 = <&spi4_sleep>;
+			pinctrl-0 = <&blsp_spi4_default>;
+			pinctrl-1 = <&blsp_spi4_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1852,8 +1852,8 @@ blsp_i2c5: i2c@78b9000 {
 			clock-names =  "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c5_default>;
-			pinctrl-1 = <&i2c5_sleep>;
+			pinctrl-0 = <&blsp_i2c5_default>;
+			pinctrl-1 = <&blsp_i2c5_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1869,8 +1869,8 @@ blsp_spi5: spi@78b9000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi5_default>;
-			pinctrl-1 = <&spi5_sleep>;
+			pinctrl-0 = <&blsp_spi5_default>;
+			pinctrl-1 = <&blsp_spi5_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1886,8 +1886,8 @@ blsp_i2c6: i2c@78ba000 {
 			clock-names =  "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&i2c6_default>;
-			pinctrl-1 = <&i2c6_sleep>;
+			pinctrl-0 = <&blsp_i2c6_default>;
+			pinctrl-1 = <&blsp_i2c6_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1903,8 +1903,8 @@ blsp_spi6: spi@78ba000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&spi6_default>;
-			pinctrl-1 = <&spi6_sleep>;
+			pinctrl-0 = <&blsp_spi6_default>;
+			pinctrl-1 = <&blsp_spi6_sleep>;
 			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.40.1

