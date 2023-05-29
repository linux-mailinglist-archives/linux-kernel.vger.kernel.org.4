Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F37149A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjE2MrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjE2MrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:17 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4338B5;
        Mon, 29 May 2023 05:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364424; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=taM72ECVkkoHzP+ZVai9Ze2heXH7SrsCcG5An2SLZ9k/eeBfY/MOEFh7XQwTBUftNq
    SO/5WU7gY2Y5nlhY+BcHsvrecdNsFC1+7WSFcbfOlwW6SJE5a9W+/3vp0/YDpQuYoy+i
    /LRO/bFpdJzKHq/80CznpMolCq94wEYL5xUOxzF8zjOvLlDBbdU+fyLImRUVqBtwmVzY
    HHefnPWRRIiibPlNsJ3lPZYNLeHc4m9HXuh5wTRVfuLjGXYrb67VnYvP6fCqmRw+9DFG
    IQSvHRmzGozqNMqewFcmTklGX0/zfkwlixq/7tc1SkCpgkXRyxOOS4p+ACE9HgrpLwFM
    EcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG3Vvxdb6ipyPUNA80D6O5EF3cp8L275oAv71JJ8NZs=;
    b=L3sHf4yI/l28KIrd+AnYV56wnZJdVTLYstg4kY3vfmllpj+lqNFzFD3AdxWAHFWVsT
    vToav4nOhUMH7APX3PuN2Y8tFeXw6bPqMaFNi9PLfZHJurQaRRM1m1+ycurSjJh8Zr3l
    21/5+Le3QsVWEYh/lrarqRBCV8J1V6EcFqn/lveImiXLG51wegbCDWty7paDJSWGa1eH
    Ko8U5T7NxxEcbdsEZGise29tlXWtbMEmy5OyAUqODu5QOaAja3Iw+cum/X9hS31PmiBZ
    kv8H9Qi+cTJ4LXhg5rhjfgO4NfzBW4QtU4clsDGXturyURjj98nuV+jqWS+SFF5pfuK2
    dhuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG3Vvxdb6ipyPUNA80D6O5EF3cp8L275oAv71JJ8NZs=;
    b=bSjCW53ccxJCxDzx+6ZsFuRX+gJq50oEAhr1q7pdCJMW20VZJqgFq3dS+vqG5eZP31
    er+lEM0ROSeVr4gfXrtbjJOfJh4dfFf50EkGLeRGRMST7+hZZo1kSaGR2pSs3zU2BC/I
    DxdlEjt6OMYg2TRj+wSMEw19CDzolt6am92V8E1Wn71RuOkO/v5+i1e9tzMmPhEnQRtf
    2VdRAD7HoJbRwaMG/6vXVWzQEHionEIr4LoCMFj1rh6OJk4wLGPLMm3txKCtJClV93HC
    TCx9urkyBAEXG0cBvIi1i9bmXa1/6x1ROAfKsMDvQb4ymLLKKfQdfXlhbFXL8Wz55XYH
    Y8Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364424;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PG3Vvxdb6ipyPUNA80D6O5EF3cp8L275oAv71JJ8NZs=;
    b=e7U9vI5wW/YX+CoFKhESHy4NwpMr/HsLWm968vpwH2LETGJ2vPbtb4ufz88mqveh4C
    zvm0VnTDsgJ7Apzx1ZBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl4f8V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 14:46:59 +0200
Subject: [PATCH 2/6] arm64: dts: qcom: msm8916/39: Rename &blsp1_uartN ->
 &blsp_uartN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-msm8916-labels-v1-2-bec0f5fb46fb@gerhold.net>
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

For some reason the BLSP UART controllers have a label with a number
behind blsp (&blsp1_uartN) while I2C/SPI are named without (&blsp_i2cN).
This is confusing, especially for proper node ordering in board DTs.

Right now all board DTs are ordered as if the number behind blsp does
not exist (&blsp_i2cN comes before &blsp1_uartN). Strictly speaking
correct ordering would be the other way around ('1' comes before '_').

End this confusion by giving the UART controllers consistent labels.
There is just one BLSP on MSM8916/39 so the number is redundant.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts             |  8 ++++----
 arch/arm64/boot/dts/qcom/apq8039-t2.dts              | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts     |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts       |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts   |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts       |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts             |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi           |  8 ++++----
 .../boot/dts/qcom/msm8916-samsung-a2015-common.dtsi  |  4 ++--
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi    |  4 ++--
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi     |  4 ++--
 .../boot/dts/qcom/msm8916-samsung-serranove.dts      |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi            |  4 ++--
 .../arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts |  4 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi                | 12 ++++++------
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts    |  2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi                | 20 ++++++++++----------
 20 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 82f141b55eb3..19bf429a973e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -18,8 +18,8 @@ / {
 	compatible = "qcom,apq8016-sbc", "qcom,apq8016";
 
 	aliases {
-		serial0 = &blsp1_uart2;
-		serial1 = &blsp1_uart1;
+		serial0 = &blsp_uart2;
+		serial1 = &blsp_uart1;
 		usid0 = &pm8916_0;
 		i2c0 = &blsp_i2c2;
 		i2c1 = &blsp_i2c6;
@@ -243,12 +243,12 @@ &blsp_spi5 {
 	label = "LS-SPI0";
 };
 
-&blsp1_uart1 {
+&blsp_uart1 {
 	status = "okay";
 	label = "LS-UART0";
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 	label = "LS-UART1";
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index e75ee34cb014..07f4c6398b41 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -24,8 +24,8 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		mmc1 = &sdhc_2;
-		serial0 = &blsp1_uart1;
-		serial1 = &blsp1_uart2;
+		serial0 = &blsp_uart1;
+		serial1 = &blsp_uart2;
 	};
 
 	bl: backlight {
@@ -115,19 +115,19 @@ &blsp_i2c5 {
 	status = "okay";
 };
 
-&blsp1_uart1 {
+&blsp_uart1 {
 	status = "okay";
 };
 
-&blsp1_uart1_default {
+&blsp_uart1_default {
 	pins = "gpio0", "gpio1";
 };
 
-&blsp1_uart1_sleep {
+&blsp_uart1_sleep {
 	pins = "gpio0", "gpio1";
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 7b77a80f049c..c864ce12c1f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -22,7 +22,7 @@ / {
 	chassis-type = "tablet";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -105,7 +105,7 @@ touchscreen@38 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index d2abbdec5fe6..47580bd243eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -13,7 +13,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -56,7 +56,7 @@ usb_id: usb-id {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index c58a70fdf36f..ad71695652c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -13,7 +13,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -124,7 +124,7 @@ touchscreen@38 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 221db7edec5e..a2be985052a5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -14,7 +14,7 @@ / {
 	chassis-type = "tablet";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -105,7 +105,7 @@ touchscreen@38 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index b02e8f9a8ca0..cbf53de44ef3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -26,7 +26,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -210,7 +210,7 @@ nfc@28 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 56f74a892764..facb44892dd5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -14,7 +14,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -214,7 +214,7 @@ rmi4-f12@12 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index a1208c8e0620..707288b7eca8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -13,7 +13,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -101,7 +101,7 @@ imu@68 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
index 7c0ceb3cff45..438eb1faee1d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "qcom,msm8916-mtp", "qcom,msm8916-mtp/1", "qcom,msm8916";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 		usid0 = &pm8916_0;
 	};
 
@@ -21,6 +21,6 @@ chosen {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 1e07f70768f4..3539d9029bed 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -5,7 +5,7 @@
 
 &tlmm {
 
-	blsp1_uart1_default: blsp1-uart1-default-state {
+	blsp_uart1_default: blsp-uart1-default-state {
 		/* TX, RX, CTS_N, RTS_N */
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "blsp_uart1";
@@ -14,7 +14,7 @@ blsp1_uart1_default: blsp1-uart1-default-state {
 		bias-disable;
 	};
 
-	blsp1_uart1_sleep: blsp1-uart1-sleep-state {
+	blsp_uart1_sleep: blsp-uart1-sleep-state {
 		pins = "gpio0", "gpio1", "gpio2", "gpio3";
 		function = "gpio";
 
@@ -22,7 +22,7 @@ blsp1_uart1_sleep: blsp1-uart1-sleep-state {
 		bias-pull-down;
 	};
 
-	blsp1_uart2_default: blsp1-uart2-default-state {
+	blsp_uart2_default: blsp-uart2-default-state {
 		pins = "gpio4", "gpio5";
 		function = "blsp_uart2";
 
@@ -30,7 +30,7 @@ blsp1_uart2_default: blsp1-uart2-default-state {
 		bias-disable;
 	};
 
-	blsp1_uart2_sleep: blsp1-uart2-sleep-state {
+	blsp_uart2_sleep: blsp-uart2-sleep-state {
 		pins = "gpio4", "gpio5";
 		function = "gpio";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 550ba6b9d4cd..497fc83803ef 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -8,7 +8,7 @@
 
 / {
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -233,7 +233,7 @@ battery@35 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index cb1b6318a246..82d94d62fbe6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -9,7 +9,7 @@
 
 / {
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -111,7 +111,7 @@ accelerometer@1d {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index b2d2bc205ef2..78935205ea9d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -7,7 +7,7 @@
 
 / {
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -84,7 +84,7 @@ muic: extcon@25 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 13a1d8828447..bd1e1e1153c0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -28,7 +28,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -259,7 +259,7 @@ touchscreen@20 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index f5613107ad1f..898722ee86a5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -9,7 +9,7 @@ / {
 	chassis-type = "embedded";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -82,7 +82,7 @@ &bam_dmux_dma {
 	status = "okay";
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 12ce4dc236c6..930318a443a8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -16,7 +16,7 @@ / {
 	chassis-type = "handset";
 
 	aliases {
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
@@ -140,7 +140,7 @@ led@2 {
 	};
 };
 
-&blsp1_uart2 {
+&blsp_uart2 {
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 56f35015746b..8081e2611e3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1599,7 +1599,7 @@ blsp_dma: dma-controller@7884000 {
 			qcom,ee = <0>;
 		};
 
-		blsp1_uart1: serial@78af000 {
+		blsp_uart1: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078af000 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
@@ -1608,12 +1608,12 @@ blsp1_uart1: serial@78af000 {
 			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_uart1_default>;
-			pinctrl-1 = <&blsp1_uart1_sleep>;
+			pinctrl-0 = <&blsp_uart1_default>;
+			pinctrl-1 = <&blsp_uart1_sleep>;
 			status = "disabled";
 		};
 
-		blsp1_uart2: serial@78b0000 {
+		blsp_uart2: serial@78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b0000 0x200>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1622,8 +1622,8 @@ blsp1_uart2: serial@78b0000 {
 			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
 			dma-names = "tx", "rx";
 			pinctrl-names = "default", "sleep";
-			pinctrl-0 = <&blsp1_uart2_default>;
-			pinctrl-1 = <&blsp1_uart2_sleep>;
+			pinctrl-0 = <&blsp_uart2_default>;
+			pinctrl-1 = <&blsp_uart2_sleep>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 951d01674b78..85a8d8fe212f 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -23,7 +23,7 @@ / {
 	aliases {
 		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
 		mmc1 = &sdhc_2; /* SDC2 SD card slot */
-		serial0 = &blsp1_uart2;
+		serial0 = &blsp_uart2;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 778d24c8aee5..a44f7e829513 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -660,28 +660,28 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			blsp1_uart1_default: blsp1-uart1-default-state {
+			blsp_uart1_default: blsp-uart1-default-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "blsp_uart1";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp1_uart1_sleep: blsp1-uart1-sleep-state {
+			blsp_uart1_sleep: blsp-uart1-sleep-state {
 				pins = "gpio0", "gpio1", "gpio2", "gpio3";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-down;
 			};
 
-			blsp1_uart2_default: blsp1-uart2-default-state {
+			blsp_uart2_default: blsp-uart2-default-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
+			blsp_uart2_sleep: blsp-uart2-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "gpio";
 				drive-strength = <2>;
@@ -1679,7 +1679,7 @@ blsp_dma: dma-controller@7884000 {
 			qcom,ee = <0>;
 		};
 
-		blsp1_uart1: serial@78af000 {
+		blsp_uart1: serial@78af000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078af000 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
@@ -1687,13 +1687,13 @@ blsp1_uart1: serial@78af000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&blsp1_uart1_default>;
-			pinctrl-1 = <&blsp1_uart1_sleep>;
+			pinctrl-0 = <&blsp_uart1_default>;
+			pinctrl-1 = <&blsp_uart1_sleep>;
 			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};
 
-		blsp1_uart2: serial@78b0000 {
+		blsp_uart2: serial@78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b0000 0x200>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -1701,8 +1701,8 @@ blsp1_uart2: serial@78b0000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
 			dma-names = "tx", "rx";
-			pinctrl-0 = <&blsp1_uart2_default>;
-			pinctrl-1 = <&blsp1_uart2_sleep>;
+			pinctrl-0 = <&blsp_uart2_default>;
+			pinctrl-1 = <&blsp_uart2_sleep>;
 			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};

-- 
2.40.1

