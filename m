Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D670712D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjEQStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjEQStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18C76BA;
        Wed, 17 May 2023 11:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349339; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yiez2FwUfKE5YcDJD3TJ1RiTTYaROAolh/7BpXVlL53PGsiVl0ELTfp/Tn82uUgCyq
    r2nyIQ9dDZ5WahkI21OjShrtJHsuL1gb8iLU3I/vr4gv/gXvxEHO5qOKhSBw98ntKSqF
    qVisqzinmwe5q/toSX6cddtYsQVGa0juZw16VyhmLC61xNd26FxxOVend1Mo/ptfTXmv
    zSLk4CU6IWREE94uVijpZfSYauYCCS7tvDvTHfz+YAO5vGn+3Fzh0UT2uD23/7EoXFEz
    g3Y9wQi9cJ8F5mkrfI04qMpBg+ke6YnyuAYVzn4zvDffCjMXhhlUkM9DMWaWSZX8Wb0z
    /syA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Q72gAZwrgAyQdwaXPFWfknvMiEMn9jleNzwpNjYRXJI=;
    b=DjOJF8/aJcqJdksbZj/gHTZ7/T169cEYGnwyuOXHRcXtTwdOscsoKHWRy1VqP5IkOy
    z1aD7N0v2krrtIfGwfhASkl3vHnjDeeBdxSlUYjs+VgGgvlEvCD9E9qK4SR4HNnxGMbj
    BNws3Dgc6mpLxZWS8JxeMPqrJWI+8HVFjJKB+gdVZ2bpWY6GUi2FrNjYpianyQcxknYn
    rShDSaS8FLeAvuHxd6bvkJnM4pVchTAlMG2tTG6BtdsHOk4HQVm0Nz/9QoltfHlT/dlb
    Ckj1Eqc14u2xmkW6zlf4c20Ja/ewY0FSj3Jhgukk2WvuU/C8bI+459B1wq5fSb3wklCE
    5Epw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Q72gAZwrgAyQdwaXPFWfknvMiEMn9jleNzwpNjYRXJI=;
    b=XkHgje8nuyn2G+j61Q+t24/8AaQJYiq6pR2yVphDonOpQ5SDy4jIEJizk/KCkKyXUs
    Ybflzpv6znyY0CZIwUPO/+fscnj/Jo9nV5Tcwk3h3lrpoEbPgfDzNO7OolUImxZkY0Pj
    UXSi4OrMBRQZgO9GgXZtbQBySRkn6/8g5SStqtpG0DpDb984U5ECrOl1NIG9I3VUgzYw
    3niZPSI0I0AfwiClU4XmoitfCkCyqri4ioZ5d+bbl90eOYXDqTIQCtKMpHuq3kqnMzsr
    MEgvJV8Fl+Kcr7r41/TOIRnEVHw10i+lUn4p148k8/wVbCmaKr2x2CF6e6DQL+n71S/F
    a4jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Q72gAZwrgAyQdwaXPFWfknvMiEMn9jleNzwpNjYRXJI=;
    b=e5+Uj/LbKfEEVgneV3pW0tHh7M5/ry6Qh2RjxjNZ3pDTdNCG1ZAzDXttglV5NNVkDe
    4bGTJlQaKlXHGotbnpAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HImxBII
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:48:59 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:42 +0200
Subject: [PATCH 3/8] arm64: dts: qcom: msm8916: Fix regulator constraints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-3-54d4960a05fc@gerhold.net>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator constraints for most MSM8916 devices (except DB410c) were
originally taken from Qualcomm's msm-3.10 vendor device tree (for lack
of better documentation). Unfortunately it turns out that Qualcomm's
voltages are slightly off as well and do not match the voltage
constraints applied by the RPM firmware.

This means that we sometimes request a specific voltage but the RPM
firmware actually applies a much lower or higher voltage. This is
particularly critical for pm8916_l11 which is used as SD card VMMC
regulator: The SD card can choose a voltage from the current range of
1.8 - 2.95V. If it chooses to run at 1.8V we pretend that this is fine
but the RPM firmware will still silently end up configuring 2.95V.
This can be easily reproduced with a multimeter or by checking the
SPMI hardware registers of the regulator.

Fix this by making the voltages match the actual "specified range" in
the PM8916 Device Specification which is enforced by the RPM firmware.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts           | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts         | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 12 ++++++------
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi   | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi    | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                  | 14 +++++++-------
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 12 ++++++------
 13 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 13cd9ad167df..0d517804e44e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -159,13 +159,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -199,7 +199,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -209,12 +209,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index fecb69944cfa..ddd64cc46998 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -201,13 +201,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -241,7 +241,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -251,12 +251,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 91284a1d0966..982457503a3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -169,13 +169,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -209,7 +209,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -219,12 +219,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 525ec76efeeb..9584d271c526 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -159,13 +159,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -199,7 +199,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -209,12 +209,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 5b1bac8f5122..baa7bb86cdd5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -322,13 +322,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -372,12 +372,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index f1dd625e1822..68d1b76aaf77 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -273,13 +273,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -313,7 +313,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -323,12 +323,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index b79e80913af9..5ef51d3e9098 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -140,13 +140,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -180,7 +180,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -190,12 +190,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 16d67749960e..b362a76eebc9 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -285,13 +285,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -325,7 +325,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -335,12 +335,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 74ffd04db8d8..4464beeeaab1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -168,13 +168,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -208,7 +208,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -218,12 +218,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index adeee0830e76..6e231e92e675 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -134,13 +134,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -174,7 +174,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -184,12 +184,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 1a41a4db874d..fa5b330aaeae 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -326,13 +326,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -366,7 +366,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -376,12 +376,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 50bae6f214f1..b27896e83a0e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -132,13 +132,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -172,7 +172,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -182,12 +182,12 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index ac56c7595f78..78020a0db4e4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -194,13 +194,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	l1 {
@@ -234,7 +234,7 @@ l7 {
 	};
 
 	l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -244,7 +244,7 @@ l9 {
 	};
 
 	l10 {
-		regulator-min-microvolt = <2700000>;
+		regulator-min-microvolt = <2800000>;
 		regulator-max-microvolt = <2800000>;
 	};
 

-- 
2.40.1

