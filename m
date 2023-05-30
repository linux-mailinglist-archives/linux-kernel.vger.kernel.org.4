Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5B715665
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjE3HPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjE3HPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D59AB;
        Tue, 30 May 2023 00:15:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430934; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nf9nMjP48Sd9hcS1tc+v6N/Tmduzaw+BKm0Kdi1x6dyQk2NlWM0DcTVN/VufdOM/op
    nhOCAQ5nr1gI5sGrNrlbWeTq1DByp7xkXAI77mAspvbJtIgILV79nHCapDczdhpdCsfu
    GmfstUqOnuB8MmmXfCqjy8MOxR/6xAagMp4NzRTyJ0UMIeZZCFJjcbhwPrY81hMj4u1m
    ncdi2sIjDoRrBzj+hserjjUz6IOxwaOyV6SmC0bYrca+Fa5wDOoWwUMhWIKRj4RAy8fO
    wHmduvjHKTNohHNPhykl46/3Tx/kRSop53F1gA3qTqBeK2Ja1kYyjlVIn1nlwNLqs+Mi
    2wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Sv7f/uwIQNs4uzL3fXbDn/p3AwUHH+0+SfXLctQcQtw=;
    b=UXzuJgNSnE65crDpFHlRqQeRe2HN7JU1KyCh6y0GoP9BPpqRFmlDDYEVdh9JZm2d1i
    8vl2ivziGt5elEmVeCSOVzNBVQdSuLFUOWs1CQT+tsCI8fO3UaQPJUYTQV58PlPe4joN
    m9UqNprOfJTPuE8zdAIoT3MALcK/+OdaQVWW+6iBl99CyztnTgrQepskljYrB1mnONR6
    aiaXJFMyN8mfBmAHmPTYDhQJYLgYvjWhxdefEUWqOmcmYU9rELGUVviQZco/1GxkkvZo
    E4ffesn33CuJLbQMKG87+cYCfXFP3MjbDaxXFO8oAGvFIVr3o1Tjfoh4XtnhnStO7yPH
    qf5Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Sv7f/uwIQNs4uzL3fXbDn/p3AwUHH+0+SfXLctQcQtw=;
    b=iD6dEVDkJGEIgmXOxcgMj9HBAlHL5hoKkea/FC0CEqtXXpiOtV7vUv/f3UJ5R3h9AU
    +cBteAcvB5d/j62EBbrwqofGO9kRGCis9xNyJXMotNJQu2SON+fTLEDooA57fJd6/JN9
    4YhEOtj5ELrEjuqrP82EKbnd8fUJMFiCZmHuSQ94D+A0FAmYzY1tCEXkELuuC6Gdu609
    OsJXqJ3jCSlS4io0ezQuM3hOkmZoRnbc6hvI7IIZ27rfejI8nG3cj6/B2yput6M3Vkcb
    OFG0SEfmFDaru62kFZCF6v7R4blG5gNLhlq/SlbqXqdfZOAx4fCn10GvLNihKHv7sg6c
    xciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430934;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Sv7f/uwIQNs4uzL3fXbDn/p3AwUHH+0+SfXLctQcQtw=;
    b=aNH2rxSnkpPND6uqAXhoPA5AgqgrYtsvCnAYlMQl0zItA2g+McYOb3UJvDbiArQ0mF
    JIgueBqNb/sj4aDX+ACQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FYgXz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:34 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:22 +0200
Subject: [PATCH 1/6] arm64: dts: qcom: msm8916/39: Fix SD card detect
 pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-1-11f540b51c93@gerhold.net>
References: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
In-Reply-To: <20230529-msm8916-pinctrl-v1-0-11f540b51c93@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SD card detect pinctrl setup configures bias-pull-up for
the "default" (active) case and bias-disable for the "sleep" case.
Before commit b5c833b703cc ("mmc: sdhci-msm: Set IO pins in low power
state during suspend") the pull up was permanently active. Since then
it is only active when a valid SD card is inserted.

This does not really make sense: For an active-low CD, the pull up is
needed to pull the GPIO high when the card is not inserted. When the
card gets inserted CD is shorted to ground (low). This means right now
the pull-up is removed exactly when it is needed to detect the next
card insertion. Generally, applying different bias for CD does not
really make sense. It should always stay the same so card removals and
insertions can be detected properly.

The reason why card detection still works fine in practice is that most
boards seem to have external pull up on the CD pin. However, this means
that there is no need to configure an internal pull-up at all and we
can keep bias-disable permanently.

There are also some boards with different CD polarity (acer-a1-724) and
with different GPIO number (huawei-g7). All in all this makes it
obvious that the CD pin is board-specific and the pinctrl for it should
be defined in the board DT.

Move it to the boards that need it and use bias-disable permanently for
the boards that seem to have external pull-up. The vendor device tree
for msm8939-sony-xperia-kanuti-tulip suggests that it needs the
internal pull-up permanently [1] so it gets bias-pull-up to be sure.

[1]: https://github.com/sonyxperiadev/kernel/blob/57b5050e340f40a88e1ddb8d16fd9adb44418923/arch/arm/boot/dts/qcom/msm8939-kanuti_tulip.dtsi#L634-L636

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts        | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts    | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts          | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts      | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts          |  6 +++---
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts    | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi              | 17 -----------------
 .../boot/dts/qcom/msm8916-samsung-a2015-common.dtsi     | 11 +++++++++--
 .../arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi | 11 +++++++++--
 .../boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  | 11 +++++++++--
 arch/arm64/boot/dts/qcom/msm8939.dtsi                   | 14 --------------
 13 files changed, 93 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 56dfca61253e..b8537fe576a8 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -380,8 +380,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
@@ -642,6 +642,13 @@ &tlmm {
 		"USR_LED_2_CTRL", /* GPIO 120 */
 		"SB_HS_ID";
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	tlmm_leds: tlmm-leds-state {
 		pins = "gpio21", "gpio120";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 5025c08e4817..9846584daf64 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -142,8 +142,8 @@ &sdhc_1 {
 
 &sdhc_2 {
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 
@@ -184,6 +184,13 @@ gpio_keys_default: gpio-keys-default-state {
 		bias-pull-up;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	touchscreen_default: touchscreen-default-state {
 		reset-pins {
 			pins = "gpio12";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 7b629243ef0d..4ad7d36cf350 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -181,8 +181,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
@@ -276,6 +276,13 @@ proximity_int_default: proximity-int-default-state {
 		bias-pull-up;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	ts_int_reset_default: ts-int-reset-default-state {
 		pins = "gpio13", "gpio100";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index b8c217b04a3b..33ca4e157cd5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -150,8 +150,8 @@ &sdhc_2 {
 	vmmc-supply = <&reg_sd_vmmc>;
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
@@ -205,6 +205,13 @@ sd_vmmc_en_default: sd-vmmc-en-default-state {
 		bias-disable;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	touchscreen_default: touchscreen-default-state {
 		touch-pins {
 			pins = "gpio13";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 56c42b0c9733..0d387d9507c3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -136,8 +136,8 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
@@ -184,6 +184,13 @@ gpio_leds_default: gpio-led-default-state {
 		bias-disable;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	touchscreen_default: touchscreen-default-state {
 		reset-pins {
 			pins = "gpio12";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 175ca011998c..39be7b6b1695 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -270,8 +270,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdhc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdhc2_cd_default>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	/*
 	 * The Huawei device tree sets cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>.
@@ -397,7 +397,7 @@ reg_lcd_en_default: reg-lcd-en-default-state {
 		bias-disable;
 	};
 
-	sdhc2_cd_default: sdhc2-cd-default-state {
+	sdc2_cd_default: sdc2-cd-default-state {
 		pins = "gpio56";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index f23cfb2bf793..04e598a436cb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -135,8 +135,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
@@ -190,6 +190,13 @@ mag_reset_default: mag-reset-default-state {
 		bias-disable;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 1b60d42a13c7..c2149bcf53c4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -380,23 +380,6 @@ sdc2_data_off: data-off-pins {
 		};
 	};
 
-	pmx-sdc2-cd-pin-state {
-		sdc2_cd_on: cd-on-pins {
-			pins = "gpio38";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-pull-up;
-		};
-		sdc2_cd_off: cd-off-pins {
-			pins = "gpio38";
-			function = "gpio";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
 	cdc-pdm-lines-state {
 		cdc_pdm_lines_act: pdm-lines-on-pins {
 			pins = "gpio63", "gpio64", "gpio65", "gpio66",
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 895036fb6eb8..3c145a0aac99 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -273,8 +273,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
@@ -391,6 +391,13 @@ nfc_i2c_default: nfc-i2c-default-state {
 		bias-disable;
 	};
 
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	tkey_default: tkey-default-state {
 		pins = "gpio98";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 94cfb3200496..057ce62c0305 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -143,8 +143,8 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
@@ -199,4 +199,11 @@ gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index f2a5800f1605..36233a31b98b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -107,8 +107,8 @@ &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
@@ -162,4 +162,11 @@ muic_int_default: muic-int-default-state {
 		drive-strength = <2>;
 		bias-disable;
 	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 85a8d8fe212f..80e4f0a6eea1 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -43,6 +43,13 @@ &mdss {
 };
 
 &tlmm {
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	usb_id_default: usb-id-default-state {
 		pins = "gpio110";
 		function = "gpio";
@@ -158,8 +165,8 @@ &sdhc_1 {
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_default_state>;
-	pinctrl-1 = <&sdc2_sleep_state>;
+	pinctrl-0 = <&sdc2_default_state &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep_state &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 0d9f8b951b66..2cbd4baa9b95 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1138,13 +1138,6 @@ data-pins {
 					bias-pull-up;
 					drive-strength = <10>;
 				};
-
-				cd-pins {
-					pins = "gpio38";
-					function = "gpio";
-					drive-strength = <2>;
-					bias-pull-up;
-				};
 			};
 
 			sdc2_sleep_state: sdc2-sleep-state {
@@ -1165,13 +1158,6 @@ data-pins {
 					bias-pull-up;
 					drive-strength = <2>;
 				};
-
-				cd-pins {
-					pins = "gpio38";
-					function = "gpio";
-					drive-strength = <2>;
-					bias-disable;
-				};
 			};
 
 			wcnss_pin_a: wcnss-active-state {

-- 
2.40.1

