Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316ED715669
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjE3HQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjE3HPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBDBF1;
        Tue, 30 May 2023 00:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430936; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MfIobGlTg39UQ18AFEDJPOszcFBFgosU09UJdBH7PprcM7zfm4V7x+yA653xzOkVOs
    f0TY6amJE8Owp4LPL2+1dwRmBueCfQwHiatkMjgF8s21JWkh+VUkOqIahwW3Lr3PJpS6
    FA296zXZgreB7Ttx3ChuGhFUkH9NCNJii1l/QOidKAaXOhkUyEUr5mGwwwhHl7JLHFjr
    z/KdmZJ5mmut5HQWAl3KKTkiZVswFwp4vDKC+tqpHq9oc7qQJZzpFRkggFbyV58jsApk
    wCrF6J4JzORwkbtvoOenxhpIyyF5shUMM0qw5y2kDqP1yxz0CrG2bdt+CtE/4Hb29VA1
    ZMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430936;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TP8+wlvdPimNC6OAamMdtLhAdKWn67GjltSLIeq1iLg=;
    b=jaYttKPcipxXARLYoPHqZ7URBKdoapH4cSylulaDTTAbGwsi7zo0+o4cOpdQ2ygMzN
    EDIoCNyYLucIzK8c2Bax95wvwUsPlnHYfnvnEzka43f5t0iRcCFQNlBmt0r4CSIrsU6h
    PhqtAJgLiqDzu3jN9DWzwV8lTP4uNP7LyUJrd+Z8w+mH6RJnYY0dDXrB5Ob3/KJmAE+D
    8MuQiIKEaGN5xl0d/toN8lf/t9PWauIBfzOlcaxzZawAJzQXUOVKABzie51+3ZGeeWs4
    HBfAqP3nRG3kXTYmMsa1okt9T5naYXFXSbbSJyDiIDj0gFKkW0VGVd8uefPqEZ7/l3El
    7AkQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430936;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TP8+wlvdPimNC6OAamMdtLhAdKWn67GjltSLIeq1iLg=;
    b=Md3nEzxGdNULKAuC5KnlQ/sPCKReY7pjLnFiQWs7FJMbPEoAGz8P3VGVWuvSLf0Sw1
    0OCHDpzkJatWjqZF4qgbAoSXLDCqxjQZddM2pxT03FDrm/OmSY+zSabWJ/zH96cL77Vp
    gq1bOJQcnu+oO+EY0UltQr804wcsAlFXv+njEYlUHk5Ypnq1B6bfMhITeiMISg5fT//1
    lfVoMKhGEbWtiFZA+2/AvsgcvoITh8VpfjMGrd8PWifJuM9Ycx5FsEXOHYR1jtMM5cUH
    MIXnyp6Yz+uhf7NX+2+Wd4Xf1Pznk7stDQs5p4lS8lKPe/+n7TrPUSrEb/DwU+hvXrjD
    plZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430936;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=TP8+wlvdPimNC6OAamMdtLhAdKWn67GjltSLIeq1iLg=;
    b=C2EGf9dl66aUeAjD42B2OS+pe4fAZtHQ2tKI+uIClevg6VK9mez0dtMF5U5MbeYOYB
    zPuW7WzOhK8yKVCmQJBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FZgY4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:35 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:27 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: msm8916: Drop msm8916-pins.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-6-11f540b51c93@gerhold.net>
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

MSM8916 and MSM8939 are pin-compatible and should have exactly the same
pinctrl definitions. Still, having pinctrl separated to a -pins.dtsi
is not typical anymore for Qualcomm platforms upstream. Since Bjorn
specifically requested having the MSM8939 pinctrl inside msm8939.dtsi
lets move the MSM8916 definitions to msm8916.dtsi as well to have
a consistent location.

While at it sort the nodes and drop unnecessary empty lines.

Note that in almost all cases changes to MSM8916 pinctrl should also be
applied to MSM8939 pinctrl (and vice versa). Right now they are back in
sync again and completely identical.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
FWIW my personal opinion is that MSM8916 and MSM8939 should use exactly
the same pinctrl, so using msm8916-pins.dtsi from MSM8939 would be also
a valid approach. However, there are also a lot other common
definitions that could be shared which is obviously much more involved.

At this point I'm also fine if we just make sure (during review) that
these two platforms (and perhaps MSM8909 in the future) stay consistent
and relevant changes are applied to all of them.
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 554 -----------------------------
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 481 ++++++++++++++++++++++++-
 2 files changed, 479 insertions(+), 556 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
deleted file mode 100644
index bf7e664c8350..000000000000
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ /dev/null
@@ -1,554 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
- */
-
-&tlmm {
-
-	blsp_uart1_default: blsp-uart1-default-state {
-		/* TX, RX, CTS_N, RTS_N */
-		pins = "gpio0", "gpio1", "gpio2", "gpio3";
-		function = "blsp_uart1";
-
-		drive-strength = <16>;
-		bias-disable;
-	};
-
-	blsp_uart1_sleep: blsp-uart1-sleep-state {
-		pins = "gpio0", "gpio1", "gpio2", "gpio3";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_uart2_default: blsp-uart2-default-state {
-		pins = "gpio4", "gpio5";
-		function = "blsp_uart2";
-
-		drive-strength = <16>;
-		bias-disable;
-	};
-
-	blsp_uart2_sleep: blsp-uart2-sleep-state {
-		pins = "gpio4", "gpio5";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi1_default: blsp-spi1-default-state {
-		spi-pins {
-			pins = "gpio0", "gpio1", "gpio3";
-			function = "blsp_spi1";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio2";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi1_sleep: blsp-spi1-sleep-state {
-		pins = "gpio0", "gpio1", "gpio2", "gpio3";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi2_default: blsp-spi2-default-state {
-		spi-pins {
-			pins = "gpio4", "gpio5", "gpio7";
-			function = "blsp_spi2";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio6";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi2_sleep: blsp-spi2-sleep-state {
-		pins = "gpio4", "gpio5", "gpio6", "gpio7";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi3_default: blsp-spi3-default-state {
-		spi-pins {
-			pins = "gpio8", "gpio9", "gpio11";
-			function = "blsp_spi3";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio10";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi3_sleep: blsp-spi3-sleep-state {
-		pins = "gpio8", "gpio9", "gpio10", "gpio11";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi4_default: blsp-spi4-default-state {
-		spi-pins {
-			pins = "gpio12", "gpio13", "gpio15";
-			function = "blsp_spi4";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio14";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi4_sleep: blsp-spi4-sleep-state {
-		pins = "gpio12", "gpio13", "gpio14", "gpio15";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi5_default: blsp-spi5-default-state {
-		spi-pins {
-			pins = "gpio16", "gpio17", "gpio19";
-			function = "blsp_spi5";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio18";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi5_sleep: blsp-spi5-sleep-state {
-		pins = "gpio16", "gpio17", "gpio18", "gpio19";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_spi6_default: blsp-spi6-default-state {
-		spi-pins {
-			pins = "gpio20", "gpio21", "gpio23";
-			function = "blsp_spi6";
-
-			drive-strength = <12>;
-			bias-disable;
-		};
-		cs-pins {
-			pins = "gpio22";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-			output-high;
-		};
-	};
-
-	blsp_spi6_sleep: blsp-spi6-sleep-state {
-		pins = "gpio20", "gpio21", "gpio22", "gpio23";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	blsp_i2c1_default: blsp-i2c1-default-state {
-		pins = "gpio2", "gpio3";
-		function = "blsp_i2c1";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c1_sleep: blsp-i2c1-sleep-state {
-		pins = "gpio2", "gpio3";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c2_default: blsp-i2c2-default-state {
-		pins = "gpio6", "gpio7";
-		function = "blsp_i2c2";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c2_sleep: blsp-i2c2-sleep-state {
-		pins = "gpio6", "gpio7";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c3_default: blsp-i2c3-default-state {
-		pins = "gpio10", "gpio11";
-		function = "blsp_i2c3";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c3_sleep: blsp-i2c3-sleep-state {
-		pins = "gpio10", "gpio11";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c4_default: blsp-i2c4-default-state {
-		pins = "gpio14", "gpio15";
-		function = "blsp_i2c4";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c4_sleep: blsp-i2c4-sleep-state {
-		pins = "gpio14", "gpio15";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c5_default: blsp-i2c5-default-state {
-		pins = "gpio18", "gpio19";
-		function = "blsp_i2c5";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c5_sleep: blsp-i2c5-sleep-state {
-		pins = "gpio18", "gpio19";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c6_default: blsp-i2c6-default-state {
-		pins = "gpio22", "gpio23";
-		function = "blsp_i2c6";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	blsp_i2c6_sleep: blsp-i2c6-sleep-state {
-		pins = "gpio22", "gpio23";
-		function = "gpio";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	sdc1_default: sdc1-default-state {
-		clk-pins {
-			pins = "sdc1_clk";
-
-			bias-disable;
-			drive-strength = <16>;
-		};
-		cmd-pins {
-			pins = "sdc1_cmd";
-
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-		data-pins {
-			pins = "sdc1_data";
-
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-	};
-
-	sdc1_sleep: sdc1-sleep-state {
-		clk-pins {
-			pins = "sdc1_clk";
-
-			bias-disable;
-			drive-strength = <2>;
-		};
-		cmd-pins {
-			pins = "sdc1_cmd";
-
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-		data-pins {
-			pins = "sdc1_data";
-
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-	};
-
-	sdc2_default: sdc2-default-state {
-		clk-pins {
-			pins = "sdc2_clk";
-
-			bias-disable;
-			drive-strength = <16>;
-		};
-		cmd-pins {
-			pins = "sdc2_cmd";
-
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-		data-pins {
-			pins = "sdc2_data";
-
-			bias-pull-up;
-			drive-strength = <10>;
-		};
-	};
-
-	sdc2_sleep: sdc2-sleep-state {
-		clk-pins {
-			pins = "sdc2_clk";
-
-			bias-disable;
-			drive-strength = <2>;
-		};
-		cmd-pins {
-			pins = "sdc2_cmd";
-
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-		data-pins {
-			pins = "sdc2_data";
-
-			bias-pull-up;
-			drive-strength = <2>;
-		};
-	};
-
-	cdc_pdm_default: cdc-pdm-default-state {
-		pins = "gpio63", "gpio64", "gpio65", "gpio66",
-		       "gpio67", "gpio68";
-		function = "cdc_pdm0";
-
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	cdc_pdm_sleep: cdc-pdm-sleep-state {
-		pins = "gpio63", "gpio64", "gpio65", "gpio66",
-		       "gpio67", "gpio68";
-		function = "cdc_pdm0";
-
-		drive-strength = <2>;
-		bias-pull-down;
-	};
-
-	pri_mi2s_default: mi2s-pri-default-state {
-		pins = "gpio113", "gpio114", "gpio115", "gpio116";
-		function = "pri_mi2s";
-
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	pri_mi2s_sleep: mi2s-pri-sleep-state {
-		pins = "gpio113", "gpio114", "gpio115", "gpio116";
-		function = "pri_mi2s";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	pri_mi2s_ws_default: mi2s-pri-ws-default-state {
-		pins = "gpio110";
-		function = "pri_mi2s_ws";
-
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	pri_mi2s_ws_sleep: mi2s-pri-ws-sleep-state {
-		pins = "gpio110";
-		function = "pri_mi2s_ws";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	pri_mi2s_mclk_default: mi2s-pri-mclk-default-state {
-		pins = "gpio116";
-		function = "pri_mi2s";
-
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	pri_mi2s_mclk_sleep: mi2s-pri-mclk-sleep-state {
-		pins = "gpio116";
-		function = "pri_mi2s";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	sec_mi2s_default: mi2s-sec-default-state {
-		pins = "gpio112", "gpio117", "gpio118", "gpio119";
-		function = "sec_mi2s";
-
-		drive-strength = <8>;
-		bias-disable;
-	};
-
-	sec_mi2s_sleep: mi2s-sec-sleep-state {
-		pins = "gpio112", "gpio117", "gpio118", "gpio119";
-		function = "sec_mi2s";
-
-		drive-strength = <2>;
-		bias-disable;
-	};
-
-	cdc_dmic_default: cdc-dmic-default-state {
-		clk-pins {
-			pins = "gpio0";
-			function = "dmic0_clk";
-
-			drive-strength = <8>;
-		};
-		data-pins {
-			pins = "gpio1";
-			function = "dmic0_data";
-
-			drive-strength = <8>;
-		};
-	};
-
-	cdc_dmic_sleep: cdc-dmic-sleep-state {
-		clk-pins {
-			pins = "gpio0";
-			function = "dmic0_clk";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-		data-pins {
-			pins = "gpio1";
-			function = "dmic0_data";
-
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
-	wcss_wlan_default: wcss-wlan-default-state {
-		pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
-		function = "wcss_wlan";
-
-		drive-strength = <6>;
-		bias-pull-up;
-	};
-
-	cci0_default: cci0-default-state {
-		pins = "gpio29", "gpio30";
-		function = "cci_i2c";
-
-		drive-strength = <16>;
-		bias-disable;
-	};
-
-	camera_front_default: camera-front-default-state {
-		pwdn-pins {
-			pins = "gpio33";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-		rst-pins {
-			pins = "gpio28";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-		mclk1-pins {
-			pins = "gpio27";
-			function = "cam_mclk1";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	camera_rear_default: camera-rear-default-state {
-		pwdn-pins {
-			pins = "gpio34";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-		rst-pins {
-			pins = "gpio35";
-			function = "gpio";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-		mclk0-pins {
-			pins = "gpio26";
-			function = "cam_mclk0";
-
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e8e6181d4439..7582c7d748fe 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -997,6 +997,485 @@ tlmm: pinctrl@1000000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
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
+			blsp_uart1_default: blsp-uart1-default-state {
+				/* TX, RX, CTS_N, RTS_N */
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "blsp_uart1";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp_uart1_sleep: blsp-uart1-sleep-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp_uart2_default: blsp-uart2-default-state {
+				pins = "gpio4", "gpio5";
+				function = "blsp_uart2";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp_uart2_sleep: blsp-uart2-sleep-state {
+				pins = "gpio4", "gpio5";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			camera_front_default: camera-front-default-state {
+				pwdn-pins {
+					pins = "gpio33";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+				rst-pins {
+					pins = "gpio28";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+				mclk1-pins {
+					pins = "gpio27";
+					function = "cam_mclk1";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			camera_rear_default: camera-rear-default-state {
+				pwdn-pins {
+					pins = "gpio34";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+				rst-pins {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+				mclk0-pins {
+					pins = "gpio26";
+					function = "cam_mclk0";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			cci0_default: cci0-default-state {
+				pins = "gpio29", "gpio30";
+				function = "cci_i2c";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			cdc_dmic_default: cdc-dmic-default-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "dmic0_clk";
+					drive-strength = <8>;
+				};
+				data-pins {
+					pins = "gpio1";
+					function = "dmic0_data";
+					drive-strength = <8>;
+				};
+			};
+
+			cdc_dmic_sleep: cdc-dmic-sleep-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "dmic0_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+				data-pins {
+					pins = "gpio1";
+					function = "dmic0_data";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			cdc_pdm_default: cdc-pdm-default-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				function = "cdc_pdm0";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			cdc_pdm_sleep: cdc-pdm-sleep-state {
+				pins = "gpio63", "gpio64", "gpio65", "gpio66",
+				       "gpio67", "gpio68";
+				function = "cdc_pdm0";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			pri_mi2s_default: mi2s-pri-default-state {
+				pins = "gpio113", "gpio114", "gpio115", "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			pri_mi2s_sleep: mi2s-pri-sleep-state {
+				pins = "gpio113", "gpio114", "gpio115", "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			pri_mi2s_mclk_default: mi2s-pri-mclk-default-state {
+				pins = "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			pri_mi2s_mclk_sleep: mi2s-pri-mclk-sleep-state {
+				pins = "gpio116";
+				function = "pri_mi2s";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			pri_mi2s_ws_default: mi2s-pri-ws-default-state {
+				pins = "gpio110";
+				function = "pri_mi2s_ws";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			pri_mi2s_ws_sleep: mi2s-pri-ws-sleep-state {
+				pins = "gpio110";
+				function = "pri_mi2s_ws";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sec_mi2s_default: mi2s-sec-default-state {
+				pins = "gpio112", "gpio117", "gpio118", "gpio119";
+				function = "sec_mi2s";
+				drive-strength = <8>;
+				bias-disable;
+			};
+
+			sec_mi2s_sleep: mi2s-sec-sleep-state {
+				pins = "gpio112", "gpio117", "gpio118", "gpio119";
+				function = "sec_mi2s";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sdc1_default: sdc1-default-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc1_sleep: sdc1-sleep-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			sdc2_default: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc2_sleep: sdc2-sleep-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+
+			wcss_wlan_default: wcss-wlan-default-state {
+				pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "wcss_wlan";
+				drive-strength = <6>;
+				bias-pull-up;
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -2192,5 +2671,3 @@ timer {
 			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
-
-#include "msm8916-pins.dtsi"

-- 
2.40.1

