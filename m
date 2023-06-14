Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9745F72F5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbjFNHRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243139AbjFNHQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3092693;
        Wed, 14 Jun 2023 00:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726979; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iwL1ubNluX9p1lXtdbK++kLGzzjqaAPbdWwMj0ITOAp+jjmyDW9SqNlJSnBohlACbM
    DFhZJvbpGVc8YjA35c8wHrgc0CRZ/1DloPZ9WT0ZzSo0tW/AipaiKmTdpklWJWF9G1mC
    NL9lR3p9jviKtrfYNXwERUbmoJOxTfJZaRA/YCchwc7r270vdWewFXX4EU0Ywtzaelts
    DtaVxrPxjtb/WR3WRCF3ZN7rKlU24kyJ1WNszX/ywzAJ1CqI9hYJymV9UAXIux6irdwk
    iEhbtbDcdQ1pSsUcxYK88otoXA3pnpA370EwvewmiymntjPTv7T5hBEuBhHH5SOjMJKh
    11NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=uGcBvgux5Z42TfLlC6oP/lRzzRra2rIpJSo5SSIQARE=;
    b=QAyd7ml+X7KA6UR95iJRUNmhlo2OPsP21rId1ZWxNTQWIq0BBxoRgWUgzU4A+KUWa/
    pawbeoqOfJLdmi7HT4SdAHLzKPU/avyOJnrNo7LsqTzb50qJSaLk23WMzgqaUTrPQHu3
    b6+YpMHedqW7gxAY2vP0f8A6UCLo9cZo4uUMHrSCYpGAwmNMT+3nlqbDn3SKTnXf+q2M
    u1dldNQINKXnAlaADqZ//3AZd6BIuvGU3NJOruPdibR2p+QJHYHSSc4vocXWhWKyYcSz
    G+dBfnjIdBPU5OnEY5QtL9ww6fcV7N/P2i4dxDLmKzIRiSqOiYR6utpm06GTu7Q6Mn32
    CrKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=uGcBvgux5Z42TfLlC6oP/lRzzRra2rIpJSo5SSIQARE=;
    b=jTybxx3kx2G+HjXjwbWFjt+Fj5qSSU2nU1aCFlFfVRfsSZkuWx1g3DmE+NwHiOIqYS
    X1I87ncP0YsXvNjzw1wdghBJz6TFfXlbJJNSqB57a2RjdEZNS6JLC4NKtitzrS5mr83Q
    7dgFqqeDpZY/0DXkN1oS640yguqwI7P+qXttxdVVcK06bR04bd2PyQbOyoU/U+zg46s2
    uUPx/noUNmcg9J9Y5Jb40iIj0kfebrtsXzaTqbBx33nFu8HdgStRNyg4RSp7UIHBk01a
    d6/+exd/xO+3xQPYnAuVFl5N7+oxmbAjLhXtOhvOixUZG6S9hCKfax0sOGPPcB2EkQE7
    nqAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=uGcBvgux5Z42TfLlC6oP/lRzzRra2rIpJSo5SSIQARE=;
    b=wWEWAC6+dfatXLxehGDeTDodApVJH/1Mqe59rISM+bdC7n3DGGRppxHEtYoaQqYo41
    y95MHMybR3UpiXcQfVDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GIb2i
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:18 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:05 +0200
Subject: [PATCH 7/8] arm64: dts: qcom: msm8939: Define regulator
 constraints next to usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-7-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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

Right now each MSM8939 device has a huge block of regulator constraints
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
context of the usage. The current setup in the MSM8939 device trees
makes this quite hard because each device duplicates the standard
voltages for components of the SoC and mixes those with minor
device-specific additions and dummy voltages for completely unused
regulators.

The actual usage of the regulators for the SoC components is in
msm8939-pm8916.dtsi, so it can and should also define the related
voltage constraints. These are not board-specific but defined in the
MSM8939/PM8916 specification. There is no documentation available for
MSM8939 but in practice it's almost identical to MSM8916.

Note that this commit does not make any functional change. All used
regulators still have the same regulator constraints as before. Unused
regulators do not have regulator constraints anymore because most of
these were too broad or even entirely wrong. They should be added back
with proper voltage constraints when there is an actual usage.

The same changes were already made for MSM8916 in commit b0a8f16ae4a0
("arm64: dts: qcom: msm8916: Define regulator constraints next to usage").

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts            |  98 --------------------
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi       | 100 ++++++++++++++++-----
 .../dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts  |  98 --------------------
 3 files changed, 80 insertions(+), 216 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index ceae83b1480b..40644c242fb7 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -158,104 +158,6 @@ &pm8916_gpios {
 		"PM_GPIO4";
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	pm8916_s3: s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	pm8916_s4: s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	/* l1 is fixed to 1225000, but not connected in schematic */
-
-	pm8916_l2: l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	pm8916_l4: l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	pm8916_l5: l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l6: l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l7: l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l8: l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	pm8916_l9: l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l10: l10 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l11: l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	pm8916_l12: l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	pm8916_l13: l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	pm8916_l14: l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l15: l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l16: l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l17: l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	pm8916_l18: l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &sdhc_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index 3bede1a23603..12538211bc72 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -40,32 +40,92 @@ &pm8916_codec {
 };
 
 &rpm_requests {
-	smd_rpm_regulators: regulators {
+	pm8916_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";
+		vdd_l1_l2_l3-supply = <&pm8916_s3>;
+		vdd_l4_l5_l6-supply = <&pm8916_s4>;
+		vdd_l7-supply = <&pm8916_s4>;
 
 		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
 		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
-		pm8916_s3: s3 {};
-		pm8916_s4: s4 {};
+		pm8916_s3: s3 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1350000>;
+		};
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
 
-		pm8916_l1: l1 {};
-		pm8916_l2: l2 {};
 		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
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
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 2905dd8d4bf9..8613cf93dac5 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -58,104 +58,6 @@ usb_id_default: usb-id-default-state {
 	};
 };
 
-&smd_rpm_regulators {
-	vdd_l1_l2_l3-supply = <&pm8916_s3>;
-	vdd_l4_l5_l6-supply = <&pm8916_s4>;
-	vdd_l7-supply = <&pm8916_s4>;
-
-	pm8916_s3: s3 {
-		regulator-min-microvolt = <1250000>;
-		regulator-max-microvolt = <1350000>;
-	};
-
-	pm8916_s4: s4 {
-		regulator-min-microvolt = <1850000>;
-		regulator-max-microvolt = <2150000>;
-	};
-
-	pm8916_l2: l2 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1200000>;
-	};
-
-	pm8916_l4: l4 {
-		regulator-min-microvolt = <2050000>;
-		regulator-max-microvolt = <2050000>;
-	};
-
-	pm8916_l5: l5 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l6: l6 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l7: l7 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	pm8916_l8: l8 {
-		regulator-min-microvolt = <2900000>;
-		regulator-max-microvolt = <2900000>;
-	};
-
-	pm8916_l9: l9 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l10: l10 {
-		regulator-min-microvolt = <2800000>;
-		regulator-max-microvolt = <2800000>;
-	};
-
-	pm8916_l11: l11 {
-		regulator-min-microvolt = <2950000>;
-		regulator-max-microvolt = <2950000>;
-		regulator-system-load = <200000>;
-		regulator-allow-set-load;
-	};
-
-	pm8916_l12: l12 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2950000>;
-	};
-
-	pm8916_l13: l13 {
-		regulator-min-microvolt = <3075000>;
-		regulator-max-microvolt = <3075000>;
-	};
-
-	pm8916_l14: l14 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l15: l15 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l16: l16 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	pm8916_l17: l17 {
-		regulator-min-microvolt = <2850000>;
-		regulator-max-microvolt = <2850000>;
-	};
-
-	pm8916_l18: l18 {
-		regulator-min-microvolt = <2700000>;
-		regulator-max-microvolt = <2700000>;
-	};
-};
-
 &sdhc_1 {
 	status = "okay";
 };

-- 
2.40.1

