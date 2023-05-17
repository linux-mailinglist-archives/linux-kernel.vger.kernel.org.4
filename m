Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81168707142
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEQSwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:52:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4CFD2CB;
        Wed, 17 May 2023 11:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JE2a4Q39VW0eBS9d63No9rcptrfd78Cm6kliAwVABGOjR5dZRTUXyOzyK4vEUFi9rW
    MYH7b+gdvfzscwAwYUKOduyOO0XFp5Y5hE9skriOGfAIc6nDu/aA/zN50Wd3jUhoiNPh
    uSmMtWD9vVNmsF/Jrj27bpNLkBinvaHyrPX1R9bikaXRImbYfJQAb3j/HV20H4jtFDhU
    v0bSj7RrFBhQxpihoJHpaYe85EMzG7Rc15U7htZZRmIrJOyFby41rbB6//wKYyJImYwj
    7T8kOQ5iJaMzzM1MlMCzELGUuo3ndcPQnusjoSbHmSRLR3eKtMf3hsYUDF5maTHnb6mL
    IR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X46tblRzBgSr7BihipJNIfc87cSRxLaTk9bOHAuw2I0=;
    b=kSDibsfXvcjxJwPSa/CVD/6nKN31PibjUuNmZSeTZYGLQWHHFFkk6DQy8kiLmXP8uN
    CTXZIJk7dR8BenEmZ7fBZoA5nmUVOigkHwsjGihEEmdlUK6hsEuE8Wws9iIxpv5c1Y8I
    0p1YEMGYnEOj87bqQRIGXqLUpiQEn7gFkmOa3vH76PJVRg0pXz9o+j+W/e9GF3N8OJx4
    ssSCaYX6PldcJuwvG/aJ9mzONHvLgqgj2Qkm1ei4CDahaYXnJbIJfUaaBb6Akbt0XQVU
    iGGG32uhcH6NUtm6S9KKKgbFL6CDHAsFHh3n7JS4G8z6usuWgnWoDCxg7TL/Ml08gCfg
    3caA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X46tblRzBgSr7BihipJNIfc87cSRxLaTk9bOHAuw2I0=;
    b=GFgFhZ1nwokA3Dz5QjEQ+MYK2yVkN+w0pDpRhCcxATBdZsFIpJxUBuMvlq4fwS+t13
    ECAMuZPmvfbHyiIUpl+kYChefB2uJDPNbWIja85/YNznmdBPVxBuDNbt2Coq0r6P8Uyd
    fsW2cPpnrVZeCXb2YfXvCXPxoXRVDZbjEv1uSB2RzWbXaPbUdNlY0nRI8v/txg94a7LB
    Te1WOMUNywVNXVZJPl/luEawwT3t6XfXceqXwt36KWhMpUpB0TO5dbpj8rpqgDTeBbsa
    bbchM3V0A249Zx7CCKu5vss8GEcYOLm0pjiyI69K1+tsczge+xytSpqial68c/j6bkhH
    Ek9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X46tblRzBgSr7BihipJNIfc87cSRxLaTk9bOHAuw2I0=;
    b=eBw36avkcF1NlC9Q+AdC60Ya2duLHm1SSkGCgO+Ot6IewiweDC5FUg8UueKAy5VqPr
    SLoDoKCDF0FjMZdHOlAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HImxBIJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:48:59 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:43 +0200
Subject: [PATCH 4/8] arm64: dts: qcom: msm8916: Disable audio codecs by
 default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-4-54d4960a05fc@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
In-Reply-To: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not every device has something connected to the digital audio codec
in MSM8916 and/or the analog audio codec in PM8916. Disable those by
default so the hardware is only powered up when necessary.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts       | 5 +++++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 5 +++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi          | 1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi           | 1 +
 4 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 3ec449f5cab7..7d7af6406c39 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -310,6 +310,10 @@ &lpass {
 	status = "okay";
 };
 
+&lpass_codec {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -399,6 +403,7 @@ &usb_hs_phy {
 };
 
 &wcd_codec {
+	status = "okay";
 	clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
 	clock-names = "mclk";
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index baa7bb86cdd5..8197710372ad 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -218,6 +218,10 @@ &lpass {
 	status = "okay";
 };
 
+&lpass_codec {
+	status = "okay";
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -302,6 +306,7 @@ &usb_hs_phy {
 };
 
 &wcd_codec {
+	status = "okay";
 	qcom,micbias-lvl = <2800>;
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7e0fa37a3adf..d5081a356288 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1551,6 +1551,7 @@ lpass_codec: audio-codec@771c000 {
 				 <&gcc GCC_CODEC_DIGCODEC_CLK>;
 			clock-names = "ahbix-clk", "mclk";
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 
 		sdhc_1: mmc@7824000 {
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f4fb1a92ab55..33ca1002fb75 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -178,6 +178,7 @@ wcd_codec: audio-codec@f000 {
 			vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
 			vdd-micbias-supply = <&pm8916_l13>;
 			#sound-dai-cells = <1>;
+			status = "disabled";
 		};
 	};
 };

-- 
2.40.1

