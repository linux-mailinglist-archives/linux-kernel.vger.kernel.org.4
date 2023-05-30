Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BEF715668
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjE3HQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjE3HPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:15:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E0AEA;
        Tue, 30 May 2023 00:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685430935; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iKQrW/LwEUj5g5qWd2T53e2IibjR7kv4AHItSJyYbvxUATRUi/3BdeWHfvqEnGWQON
    1VnLgNXOc8Qx+b5rK8uvUUmIj2IQ0VfdMIm+M+ZYJBMPY34Xg8d2CGRK0ylU020tvTo+
    qkezf8bVJlxtUajdUPZRZvAdudDUZp7bv0kMrL8ysYhaMYdhT6HQzqsiIaC71Y4O9fzY
    F5+4+qDQ+V8IOwSWGt5QAwtUV8m/+yvRlK52TH1Np2RMtMJiUha1r1Fdp3H5dgjhSH9m
    lyvEfyIpzTnkQ+aeTRdLiIZN0Z0f1/wQVf2qOeikfHcu5WC5T2kiCSwnSFcEZlcBAqzf
    TtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FrRqAmlYMs1uqjCYxD7SIqb5+Y+8KCQISt/f7anAssw=;
    b=XHB36zskoz+3KjQkAQ6I0AA6Bo6z/KS0SDe/UwcMYLH5MfOCBzlnVwSnkgJzHdLL3+
    AxnHI79THeDxZNYlktmEFaZ5dw4ZLhP/nuWijMMcdMTHmem1UcfTVGpP4VDF/33b7thQ
    ySJzu9xe3J+OtLHMx8KfFRk1eHlK9f5qXCHCAG2DackNO8Uojq9PWsrL/5LpCvDktYXP
    OybDdzvrIkD7Umy24fccv+pgDPYqDLjHNMm8EeMEXF67MNcjxDoZ/1YHx/6H/1CVQ18N
    2KCyFupFAOc4jH0i3mQmw8Ohp7cZJkBn+F25/AdLfwUWUbIjVvoYANisF/nAiGMAFv4A
    3rOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FrRqAmlYMs1uqjCYxD7SIqb5+Y+8KCQISt/f7anAssw=;
    b=siGcMWLa/hAf4ZK+uDTd4oYFw2MTp+flcL/+Z8LbGciATJomUi0YNxE45vObXJ01Ju
    SLE7w7XIF8KdFIBNGKZyp0jzf/EjAVWUpj4EvXQ2kRsBZd+Zoz2E/nU3aGC+UdsveIws
    V0McDiNM9YlgTcLemPdRR/ZX0CKd/5JrugcMURSVOYx/o8zdwVDaUJFas9BCb2VkAxU9
    SQHpWIO6Yz9/+2BiDO6F9vgGaX+YID05d6oaFFMhO/x4aaSvwkYF/85o4gs2O2Q1Q/AY
    wJJm+ExSxuuUhjNkj87MbfqeDzw+NnYC9YXV4FYE4G0jketG48snO3Chu9QoCBA7LqCv
    H4XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685430935;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=FrRqAmlYMs1uqjCYxD7SIqb5+Y+8KCQISt/f7anAssw=;
    b=q6MgcjQz6fl3KvrU1pB4sgWD/kHqVX6uOg/wugkLIQV+wqB+y7rc0j/GJes0R/9sB8
    Ly/xlSEVEggKPQBahbCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4U7FYgY0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 09:15:34 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 30 May 2023 09:15:23 +0200
Subject: [PATCH 2/6] arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-msm8916-pinctrl-v1-2-11f540b51c93@gerhold.net>
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

MSM8939 has the SDC pinctrl consolidated in two &sdcN_default and
&sdcN_sleep states, while MSM8916 has all pins separated. Make this
consistent by consolidating them for MSM8916 well.

Use this as a chance to define default pinctrl in the SoC.dtsi and only
let boards that add additional definitions (such as cd-gpios) override it.

For MSM8939 just make the label consistent with the other pinctrl
definitions (they do not have a _state suffix).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |  8 +--
 arch/arm64/boot/dts/qcom/apq8039-t2.dts            |  3 -
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   |  8 +--
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      |  8 +--
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     |  8 +--
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts |  8 +--
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     |  8 +--
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  9 ---
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      |  8 +--
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         | 74 ++++++++++------------
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |  8 +--
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  |  8 +--
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   |  8 +--
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    |  9 ---
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          |  4 --
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |  9 ---
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  6 ++
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |  7 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 14 ++--
 19 files changed, 72 insertions(+), 143 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index b8537fe576a8..23e3b86186ac 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -370,18 +370,14 @@ pm8916_l17: l17 {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index e783b0af355e..107795bf7e5c 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -253,9 +253,6 @@ pm8916_l18: l18 {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_default_state>;
-	pinctrl-1 = <&sdc1_sleep_state>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 9846584daf64..5ad49fe999db 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -133,17 +133,13 @@ &pm8916_vib {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-
 	status = "okay";
 };
 
 &sdhc_2 {
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 4ad7d36cf350..1c43f3d6a0b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -171,18 +171,14 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 33ca4e157cd5..92f695481769 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -139,10 +139,6 @@ pm8916_l17: l17 {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
@@ -150,8 +146,8 @@ &sdhc_2 {
 	vmmc-supply = <&reg_sd_vmmc>;
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 0d387d9507c3..f4dbc515c47a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -128,16 +128,12 @@ &pm8916_vib {
 };
 
 &sdhc_1 {
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-	pinctrl-names = "default", "sleep";
-
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 39be7b6b1695..abd409f10cfe 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -260,18 +260,14 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	/*
 	 * The Huawei device tree sets cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>.
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 9560ba632c6f..97262b8519b3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -242,19 +242,10 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
-
 	non-removable;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 04e598a436cb..9757182fba3e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -125,18 +125,14 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index c2149bcf53c4..cbf0f3d311af 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -290,44 +290,41 @@ blsp_i2c6_sleep: blsp-i2c6-sleep-state {
 		bias-disable;
 	};
 
-	pmx-sdc1-clk-state {
-		sdc1_clk_on: clk-on-pins {
+	sdc1_default: sdc1-default-state {
+		clk-pins {
 			pins = "sdc1_clk";
 
 			bias-disable;
 			drive-strength = <16>;
 		};
-		sdc1_clk_off: clk-off-pins {
-			pins = "sdc1_clk";
-
-			bias-disable;
-			drive-strength = <2>;
-		};
-	};
-
-	pmx-sdc1-cmd-state {
-		sdc1_cmd_on: cmd-on-pins {
+		cmd-pins {
 			pins = "sdc1_cmd";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc1_cmd_off: cmd-off-pins {
-			pins = "sdc1_cmd";
+		data-pins {
+			pins = "sdc1_data";
 
 			bias-pull-up;
-			drive-strength = <2>;
+			drive-strength = <10>;
 		};
 	};
 
-	pmx-sdc1-data-state {
-		sdc1_data_on: data-on-pins {
-			pins = "sdc1_data";
+	sdc1_sleep: sdc1-sleep-state {
+		clk-pins {
+			pins = "sdc1_clk";
+
+			bias-disable;
+			drive-strength = <2>;
+		};
+		cmd-pins {
+			pins = "sdc1_cmd";
 
 			bias-pull-up;
-			drive-strength = <10>;
+			drive-strength = <2>;
 		};
-		sdc1_data_off: data-off-pins {
+		data-pins {
 			pins = "sdc1_data";
 
 			bias-pull-up;
@@ -335,44 +332,41 @@ sdc1_data_off: data-off-pins {
 		};
 	};
 
-	pmx-sdc2-clk-state {
-		sdc2_clk_on: clk-on-pins {
+	sdc2_default: sdc2-default-state {
+		clk-pins {
 			pins = "sdc2_clk";
 
 			bias-disable;
 			drive-strength = <16>;
 		};
-		sdc2_clk_off: clk-off-pins {
-			pins = "sdc2_clk";
-
-			bias-disable;
-			drive-strength = <2>;
-		};
-	};
-
-	pmx-sdc2-cmd-state {
-		sdc2_cmd_on: cmd-on-pins {
+		cmd-pins {
 			pins = "sdc2_cmd";
 
 			bias-pull-up;
 			drive-strength = <10>;
 		};
-		sdc2_cmd_off: cmd-off-pins {
-			pins = "sdc2_cmd";
+		data-pins {
+			pins = "sdc2_data";
 
 			bias-pull-up;
-			drive-strength = <2>;
+			drive-strength = <10>;
 		};
 	};
 
-	pmx-sdc2-data-state {
-		sdc2_data_on: data-on-pins {
-			pins = "sdc2_data";
+	sdc2_sleep: sdc2-sleep-state {
+		clk-pins {
+			pins = "sdc2_clk";
+
+			bias-disable;
+			drive-strength = <2>;
+		};
+		cmd-pins {
+			pins = "sdc2_cmd";
 
 			bias-pull-up;
-			drive-strength = <10>;
+			drive-strength = <2>;
 		};
-		sdc2_data_off: data-off-pins {
+		data-pins {
 			pins = "sdc2_data";
 
 			bias-pull-up;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 3c145a0aac99..019bf73178fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -263,18 +263,14 @@ pm8916_l17: l17 {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 057ce62c0305..7943bb619116 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -135,16 +135,12 @@ &pm8916_usbin {
 };
 
 &sdhc_1 {
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-	pinctrl-names = "default", "sleep";
-
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 36233a31b98b..f4fd5d72b28b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -97,18 +97,14 @@ &pm8916_resin {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
 
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 3637e7d80d0a..15dc246e84e2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -276,19 +276,10 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
-
 	non-removable;
 
 	/*
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index dafa5bd82328..004a129a2ee2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -101,10 +101,6 @@ &pm8916_usbin {
 };
 
 &sdhc_1 {
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
-	pinctrl-names = "default", "sleep";
-
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 733917531218..c94d36b38651 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -173,19 +173,10 @@ &pm8916_vib {
 
 &sdhc_1 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
-	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
 };
 
 &sdhc_2 {
 	status = "okay";
-
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
-	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
-
 	non-removable;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9494b6512d87..c0aa6a53fbca 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1562,6 +1562,9 @@ sdhc_1: mmc@7824900 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			pinctrl-0 = <&sdc1_default>;
+			pinctrl-1 = <&sdc1_sleep>;
+			pinctrl-names = "default", "sleep";
 			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
@@ -1580,6 +1583,9 @@ sdhc_2: mmc@7864900 {
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+			pinctrl-0 = <&sdc2_default>;
+			pinctrl-1 = <&sdc2_sleep>;
+			pinctrl-names = "default", "sleep";
 			bus-width = <4>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 80e4f0a6eea1..a9df8dab5481 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -158,15 +158,12 @@ pm8916_l18: l18 {
 };
 
 &sdhc_1 {
-	pinctrl-0 = <&sdc1_default_state>;
-	pinctrl-1 = <&sdc1_sleep_state>;
-	pinctrl-names = "default", "sleep";
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-0 = <&sdc2_default_state &sdc2_cd_default>;
-	pinctrl-1 = <&sdc2_sleep_state &sdc2_cd_default>;
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
 	pinctrl-names = "default", "sleep";
 	cd-gpios = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 2cbd4baa9b95..1f79444bc250 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1080,7 +1080,7 @@ ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
 				};
 			};
 
-			sdc1_default_state: sdc1-default-state {
+			sdc1_default: sdc1-default-state {
 				clk-pins {
 					pins = "sdc1_clk";
 					bias-disable;
@@ -1100,7 +1100,7 @@ data-pins {
 				};
 			};
 
-			sdc1_sleep_state: sdc1-sleep-state {
+			sdc1_sleep: sdc1-sleep-state {
 				clk-pins {
 					pins = "sdc1_clk";
 					bias-disable;
@@ -1120,7 +1120,7 @@ data-pins {
 				};
 			};
 
-			sdc2_default_state: sdc2-default-state {
+			sdc2_default: sdc2-default-state {
 				clk-pins {
 					pins = "sdc2_clk";
 					bias-disable;
@@ -1140,7 +1140,7 @@ data-pins {
 				};
 			};
 
-			sdc2_sleep_state: sdc2-sleep-state {
+			sdc2_sleep: sdc2-sleep-state {
 				clk-pins {
 					pins = "sdc2_clk";
 					bias-disable;
@@ -1632,6 +1632,9 @@ sdhc_1: mmc@7824900 {
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 			resets = <&gcc GCC_SDCC1_BCR>;
+			pinctrl-0 = <&sdc1_default>;
+			pinctrl-1 = <&sdc1_sleep>;
+			pinctrl-names = "default", "sleep";
 			mmc-ddr-1_8v;
 			bus-width = <8>;
 			non-removable;
@@ -1651,6 +1654,9 @@ sdhc_2: mmc@7864900 {
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names =  "iface", "core", "xo";
 			resets = <&gcc GCC_SDCC2_BCR>;
+			pinctrl-0 = <&sdc2_default>;
+			pinctrl-1 = <&sdc2_sleep>;
+			pinctrl-names = "default", "sleep";
 			bus-width = <4>;
 			status = "disabled";
 		};

-- 
2.40.1

