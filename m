Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E8270712E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjEQSuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjEQStX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:23 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FF69008;
        Wed, 17 May 2023 11:49:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349341; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OV31iI3x0nlwBnbEIpE9MUjiiWqsibIr8j1rn8E3FCDfuvirf/ImBVicPzUKC+If8U
    rDWlTccv/e9Y6iVGRaB8FGlPefKKO2d0e1YIXV1AOpsk9v2VEi4YcTDU3i1wXGFhfa0M
    DzPTh+sAp0LmA4C8mc1bG1NkNaUn68e7BZjHQIX/hvZ6KH2Y0SU48496XwULkcB+LQhL
    +xtJHvZ6pV3lQF4do840pqzKa0q6yFgMcXPzpFsOYlwovgykGj/RsmIx99ED8OZ3DH2H
    zLtXsv553L5765A6pVjiMNi4+6s7xb0cIYcNyuYdv79kInvDg8A0+8rghczgjMxMSlkV
    uSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PXWpZ5tgEqKeOEf/ZUamMeA78U8Yjuz6DbwWWDB6Tcc=;
    b=i5S957B2h+oH5CJaJXGO9OVfN8G24YAzzx/+GbEqLp8SUaTT3On2e6SvGymnQid3p+
    jUoEX1mczoa2OEYjNHZNXANKvfvRi5w02q/WLGLVhPySrD12LQ/+xOBFzPfax8+IHGD1
    LiyQBlW4eS0g+wcait2BteFhTUTyEvgcT+7kgDR6Vq9JWHZHWX7CHva0GmZbP4ygDOnJ
    x6FqQZH71AkxxegCuvsQ+D97SnKkKttIcJ5DPR3DkNqV0DVGXAwrrQ86Y0d4b3nfGjYR
    Plq3rj+TMLtSmudN6JW0XZ0WPFDm4BJvHZAM69qE+6YmAwMwAEmLilPi8zSBYnMOWqA5
    hx7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PXWpZ5tgEqKeOEf/ZUamMeA78U8Yjuz6DbwWWDB6Tcc=;
    b=E8bG6F08JRCmf/mBC9vQMn+pkFLh3H7P8GxMM8vf7ROZzRjX4tsvguQyAlf2xDfQTy
    +pkzQqcWfkRLiCis/r92HupgiMrUaMGR8mgFotRN2Nmto9JLzcpZKORN94uX9MDop8Jv
    76Ai+hyhBdSErbmNc759i3cYZvNIrpF78CjDYiSuSHYKEGX1+HRYZt4HDS9IiUZ/ua4c
    KBeOOYto/AU8f6Fscgn9dyCQKuZTtQmvdAl6VskCkbgsTCqgFoamlXi74paJNwovz8KT
    +1kW7oW1Tt+o2GPC81OKa38yfPYh0UXcc/NTOlHQ3Y+HgFoc13jdnuXeO7L/DMVJ4Xhn
    /WQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=PXWpZ5tgEqKeOEf/ZUamMeA78U8Yjuz6DbwWWDB6Tcc=;
    b=RmoURF0XycPOKiDDofEWa/4jQhruYKrYBMF7pmmRrn+UaYnaJ9GDYkn7VwefPOEnPO
    4Y5JMEesTZ7k008bppDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HIn0BIM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:49:00 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:46 +0200
Subject: [PATCH 7/8] arm64: dts: qcom: msm8916: Define regulator
 constraints next to usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-7-54d4960a05fc@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now each MSM8916 device has a huge block of regulator constraints
with allowed voltages for each regulator. For lack of better
documentation these voltages are often copied as-is from the vendor
device tree, without much extra thought.

Unfortunately, the voltages in the vendor device trees are often
misleading or even wrong, e.g. because:

 - There is a large voltage range allowed and the actual voltage is
   only set somewhere hidden in some messy vendor driver. This is often
   the case for pm8916_{l14,l15,l16} because they have a broad range of
   1.8-3.3V by default.

 - The voltage is actually wrong but thanks to the voltage constraints
   in the RPM firmware it still ends up applying the correct voltage.

To have proper regulator constraints it is important to review them in
context of the usage. The current setup in the MSM8916 device trees
makes this quite hard because each device duplicates the standard
voltages for components of the SoC and mixes those with minor
device-specific additions and dummy voltages for completely unused
regulators.

The actual usage of the regulators for the SoC components is in
msm8916-pm8916.dtsi, so it can and should also define the related
voltage constraints. These are not board-specific but defined in the
APQ8016E/PM8916 Device Specification. The board DT can then focus on
describing the actual board-specific regulators, which makes it much
easier to review and spot potential mistakes there.

Note that this commit does not make any functional change. All used
regulators still have the same regulator constraints as before. Unused
regulators do not have regulator constraints anymore because most of
these were too broad or even entirely wrong. They should be added back
with proper voltage constraints when there is an actual usage.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           | 153 +++++----------------
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts   | 115 ++--------------
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 110 +--------------
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts     | 110 +--------------
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts | 110 +--------------
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts     | 120 +++-------------
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 110 +--------------
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 110 +--------------
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi       | 102 +++++++++++---
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     | 110 +--------------
 .../boot/dts/qcom/msm8916-samsung-gt5-common.dtsi  | 110 +--------------
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 103 --------------
 .../boot/dts/qcom/msm8916-samsung-serranove.dts    | 103 --------------
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 103 --------------
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     | 119 +++-------------
 15 files changed, 210 insertions(+), 1478 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7d7af6406c39..ab8dfd858025 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -329,6 +329,40 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	/*
+	 * The 96Boards specification expects a 1.8V power rail on the low-speed
+	 * expansion connector that is able to provide at least 0.18W / 100 mA.
+	 * L15/L16 are connected in parallel to provide 55 mA each. A minimum load
+	 * must be specified to ensure the regulators are not put in LPM where they
+	 * would only provide 5 mA.
+	 */
+	pm8916_l15: l15 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
+		regulator-always-on;
+	};
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-system-load = <50000>;
+		regulator-allow-set-load;
+		regulator-always-on;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&pm8916_s4 {
+	regulator-always-on;
+	regulator-boot-on;
+};
+
 &sdhc_1 {
 	status = "okay";
 
@@ -446,125 +480,6 @@ &wcnss_iris {
 &stm { status = "okay"; };
 &tpiu { status = "okay"; };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	/*
-	 * The 96Boards specification expects a 1.8V power rail on the low-speed
-	 * expansion connector that is able to provide at least 0.18W / 100 mA.
-	 * L15/L16 are connected in parallel to provide 55 mA each. A minimum load
-	 * must be specified to ensure the regulators are not put in LPM where they
-	 * would only provide 5 mA.
-	 */
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-system-load = <50000>;
-		regulator-allow-set-load;
-		regulator-always-on;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-system-load = <50000>;
-		regulator-allow-set-load;
-		regulator-always-on;
-	};
-
-	l17 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 /*
  * 2mA drive strength is not enough when connecting multiple
  * I2C devices with different pull up resistors.
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index 0d517804e44e..753413b48751 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -114,6 +114,18 @@ &pm8916_resin {
 	status = "okay";
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -153,109 +165,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-system-load = <200000>;
-		regulator-allow-set-load;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index ddd64cc46998..4bfbad669b1e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -156,6 +156,13 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -195,109 +202,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio31";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index 982457503a3c..37755e885395 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -128,6 +128,13 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 
@@ -163,109 +170,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107", "gpio117";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index 9584d271c526..4a6bf99c755f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -114,6 +114,13 @@ &pm8916_resin {
 	status = "okay";
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -153,109 +160,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-system-load = <200000>;
-		regulator-allow-set-load;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	camera_flash_default: camera-flash-default-state {
 		pins = "gpio31", "gpio32";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 8197710372ad..29aaa35438a3 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -222,11 +222,28 @@ &lpass_codec {
 	status = "okay";
 };
 
+&pm8916_l8 {
+	regulator-min-microvolt = <2950000>;
+	regulator-max-microvolt = <2950000>;
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l16: l16 {
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -321,109 +338,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_irq_default: accel-irq-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index 68d1b76aaf77..b7b1f1ceaf1f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -223,6 +223,13 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_usbin {
 	status = "okay";
 };
@@ -267,109 +274,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio116";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 5ef51d3e9098..d1eb3f2ecf3f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -95,6 +95,13 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -134,109 +141,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	button_backlight_default: button-backlight-default-state {
 		pins = "gpio17";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 29ef46c33350..b38eecbd6253 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -61,30 +61,92 @@ &wcnss_iris {
 };
 
 &rpm_requests {
-	smd_rpm_regulators: regulators {
+	pm8916_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";
+		vdd_l1_l2_l3-supply = <&pm8916_s3>;
+		vdd_l4_l5_l6-supply = <&pm8916_s4>;
+		vdd_l7-supply = <&pm8916_s4>;
 
 		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
-		pm8916_s3: s3 {};
-		pm8916_s4: s4 {};
 
-		pm8916_l1: l1 {};
-		pm8916_l2: l2 {};
+		pm8916_s3: s3 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8916_s4: s4 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <2150000>;
+		};
+
+		/*
+		 * Some of the regulators are unused or managed by another
+		 * processor (e.g. the modem). We should still define nodes for
+		 * them to ensure the vote from the application processor can be
+		 * dropped in case the regulators are already on during boot.
+		 *
+		 * The labels for these nodes are omitted on purpose because
+		 * boards should configure a proper voltage before using them.
+		 */
+		l1 {};
+
+		pm8916_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
 		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
-		pm8916_l4: l4 {};
-		pm8916_l5: l5 {};
-		pm8916_l6: l6 {};
-		pm8916_l7: l7 {};
-		pm8916_l8: l8 {};
-		pm8916_l9: l9 {};
-		pm8916_l10: l10 {};
-		pm8916_l11: l11 {};
-		pm8916_l12: l12 {};
-		pm8916_l13: l13 {};
-		pm8916_l14: l14 {};
-		pm8916_l15: l15 {};
-		pm8916_l16: l16 {};
-		pm8916_l17: l17 {};
-		pm8916_l18: l18 {};
+
+		l4 {};
+
+		pm8916_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8916_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8916_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8916_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8916_l9: l9 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		l10 {};
+
+		pm8916_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8916_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8916_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		l14 {};
+		l15 {};
+		l16 {};
+		l17 {};
+		l18 {};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index b362a76eebc9..37a872949851 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -252,6 +252,13 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 
@@ -279,109 +286,6 @@ &usb_hs_phy {
 	extcon = <&muic>;
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 4464beeeaab1..a49e1641e59b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -120,6 +120,13 @@ &pm8916_resin {
 	status = "okay";
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 /* FIXME: Replace with MAX77849 MUIC when driver is available */
 &pm8916_usbin {
 	status = "okay";
@@ -162,109 +169,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-system-load = <200000>;
-		regulator-allow-set-load;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	accel_int_default: accel-int-default-state {
 		pins = "gpio115";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 6e231e92e675..6192d04a58ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -128,109 +128,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <3000000>;
-		regulator-max-microvolt = <3000000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	gpio_hall_sensor_default: gpio-hall-sensor-default-state {
 		pins = "gpio52";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index fa5b330aaeae..fc4c61c4e1e6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -320,109 +320,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3660b";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	fg_alert_default: fg-alert-default-state {
 		pins = "gpio121";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index b27896e83a0e..c8ea2f6f6b3d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -126,109 +126,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-system-load = <200000>;
-		regulator-allow-set-load;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	/* pins are board-specific */
 	button_default: button-default-state {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 78020a0db4e4..323590598113 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -149,6 +149,22 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l16: l16 {
+		/*
+		 * L16 is only used for AW2013 which is fine with 2.5-3.3V.
+		 * Use the recommended typical voltage of 2.8V as minimum.
+		 */
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <2850000>;
+	};
+};
+
 &pm8916_vib {
 	status = "okay";
 };
@@ -188,109 +204,6 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	l1 {
-		regulator-min-microvolt = <1225000>;
-		regulator-max-microvolt = <1225000>;
-	};
-
-	l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-allow-set-load;
-		regulator-system-load = <200000>;
-	};
-
-	l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l16 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &msmgpio {
 	camera_flash_default: camera-flash-default-state {
 		pins = "gpio31", "gpio32";

-- 
2.40.1

