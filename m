Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5050172F5DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbjFNHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243469AbjFNHQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:29 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5376268E;
        Wed, 14 Jun 2023 00:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726978; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EcE22T1SRQkJWwBvamYpD7K6oBeArzZaAA0KrfgBcbexFMw5bP3N9i3X8c7bV/fyFK
    V6cCsN4BonYNpcezaXhONh3tsO0NkYNYkFgU+03o1nlxC3Fyl84eUX24ZDy/nJz7OM7l
    Tna4ZmiOLD2lNOSQjaS9oD9c7Q+ZDq+IjI2V47zH0yr3UT0fLI+FdBAJIArgkuWXanZm
    haiqktXzCcFGKmziOlCJouVlCrIIWeB/ZheqmqggiA/8ftM2XaKA1pz8u2zGw8QWgxTZ
    mRvlMEtldcYe3OQeG9nVq9sVzv8GRncyFu8Xhx0TsR7O+S6NAZiYM/NMZvg6yvhuNlg+
    t2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=eAj6hVmQDmaa5jtLRmGV91szbVOhkquRc27tXxX5I7o=;
    b=W8Iq/InpT2nqSoyH47vH3wDXQ3jkGEIEq8iRZWVEw72OH7LGCX1mTIeMVQ4VQ5uI6D
    EcgW4GMO84TYJehqJRyzsNmkBh3YhFaSDbPHzyEKo0PGanxypd+PJ0l6TQ6M04chXvMg
    GhY9gXzioCWJAGpCCq8l2zxltyW99BLglbhO2OUSFfXwPHmoInn1fs3qmZey+51RB9mv
    6FiIhb6YXAqYEcMJm5Ae2x1XphLiiWwEbyedaEQfchhAa33Ke6XetyBIjMmtjnBqDZRA
    2tIbgdUBnrdeb+uwWHwZDoBPzUCFkgpXcYheCYOi13SkhDlsV5oF9M2rQrJe0aMD0Xtk
    RRvA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=eAj6hVmQDmaa5jtLRmGV91szbVOhkquRc27tXxX5I7o=;
    b=EYYHHvZGHAXle8fbiaYjQ5p4AhjDD/vPqcCGPnH996yfm49UNZXdF8jKybpbHjhJPh
    kgxbVlN5INCBUTjHtXpO6TQsG55fhTYUvINBLudikPAnqN1n6ejVxcN7zLsUgAs5zZWB
    oJzGEfYnRMPAy0bbTgTKoAyVRmMauSyKx57m4L20CvKN8ZTdEr9GwYwwyvBNuTLQ+z00
    YZEUeLVyzXGAbKMq7EDCYFSrDqXmbv3vVoYYeMkwdPhuPoyTK3g9VzIz33PZiJCV1Pv3
    UMXKPx+aCeSTrj3zsABJWUasPf9tsc9u3FaEdLYYkp3r75m6+LDgIsORGOKv5C2jKNup
    V6EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=eAj6hVmQDmaa5jtLRmGV91szbVOhkquRc27tXxX5I7o=;
    b=0LKYt3KzL1klfKmWt6U8X/1K9oHnqGUOHYdj/xG96CGTZkz2PW/EA59TmhWejfIcvO
    1dvxdqXCxm/XdVU3WuCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GIb2g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:18 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:03 +0200
Subject: [PATCH 5/8] arm64: dts: qcom: msm8939: Fix regulator constraints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-5-a3c3ac833567@gerhold.net>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator constraints for the MSM8939 devices were originally taken
from Qualcomm's msm-3.10 vendor device tree (for lack of better
documentation). Unfortunately it turns out that Qualcomm's voltages are
slightly off as well and do not match the voltage constraints applied
by the RPM firmware.

This means that we sometimes request a specific voltage but the RPM
firmware actually applies a much lower or higher voltage. This is
particularly critical for pm8916_l11 which is used as SD card VMMC
regulator: The SD card can choose a voltage from the current range of
1.8 - 2.95V. If it chooses to run at 1.8V we pretend that this is fine
but the RPM firmware will still silently end up configuring 2.95V.
This can be easily reproduced with a multimeter or by checking the
SPMI hardware registers of the regulator.

Apply the same change as for MSM8916 in commit 355750828c55 ("arm64:
dts: qcom: msm8916: Fix regulator constraints") and make the voltages
match the actual "specified range" in the PM8916 Device Specification
which is enforced by the RPM firmware.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8039-t2.dts                      | 12 ++++++------
 .../arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
index c8442242137a..ceae83b1480b 100644
--- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
+++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
@@ -164,13 +164,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	pm8916_s3: s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	pm8916_s4: s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	/* l1 is fixed to 1225000, but not connected in schematic */
@@ -201,7 +201,7 @@ pm8916_l7: l7 {
 	};
 
 	pm8916_l8: l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -216,7 +216,7 @@ pm8916_l10: l10 {
 	};
 
 	pm8916_l11: l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index 509abcdad287..2905dd8d4bf9 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -64,13 +64,13 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	pm8916_s3: s3 {
-		regulator-min-microvolt = <1200000>;
-		regulator-max-microvolt = <1300000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	pm8916_s4: s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <2100000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 	};
 
 	pm8916_l2: l2 {
@@ -99,7 +99,7 @@ pm8916_l7: l7 {
 	};
 
 	pm8916_l8: l8 {
-		regulator-min-microvolt = <2850000>;
+		regulator-min-microvolt = <2900000>;
 		regulator-max-microvolt = <2900000>;
 	};
 
@@ -114,7 +114,7 @@ pm8916_l10: l10 {
 	};
 
 	pm8916_l11: l11 {
-		regulator-min-microvolt = <1800000>;
+		regulator-min-microvolt = <2950000>;
 		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;

-- 
2.40.1

