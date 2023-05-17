Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A76707126
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjEQStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjEQStS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155687D91;
        Wed, 17 May 2023 11:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349339; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sMJinl9jPPb4B0BSgKyF3YwlV1bEN92U6d5YDe/D8LjXQ3EjrYEfsipwv+StuYIOBd
    T04+0KOCC+9I13rXdxynAvik+xU+q3nyP7XriE2e2OCMoEESkcVZxLIeq9kGfHWc5MG6
    MTz4xFA46x46eTdoDaytPOC93pPh6Mltg2YFppw+Wytrl81cRqHdlrX4wgf4kYQUYPiN
    odP7IIe17O6aPaOwf1YhdglPbrduShJXuWtonSUBoc0w/c7CgqZhrxGDqp9DsY+s0PY3
    UAoQl8PlUKv0CniWC4vGaYeuBCqchvV8x5Gm1Mpu/xxy4X1lsBrWBlrwzitvm9/oylRA
    G4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=I+LZB86CM7vwY0RR16eIEE4ZmY+DpP5PdqtJil83xK0=;
    b=l9iE9VGPppJX17kxbqq5MxvFOS7R0avpW6hvgCqt6UPJA/KKHY6/Vr8zRz+K0qFMed
    7pTm+7+eSkVobMp62NloCAj7SHjwECwaFxoBVFiX8nH66hSIIAUS5bREhIa+ga/nkPQJ
    wwEzHlICEspkr48ntrH7bvWiT1jNuBRi3WCGSqpeRCKS4TXXAQjmmdSw6QUb2pWBEj7x
    CConHBjvIF8EO0eKzzA8sLVjG/5G8BbePBBLfmNwkMoAXCMbDOfB1zrHYWhaIMFe66xc
    kMbFoFDQ0xioFZFrCUhr4h7FeoZySczHeHvb/9UDF6EeZHk8Hd75VCK+G6amiCjaHMfQ
    OTBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=I+LZB86CM7vwY0RR16eIEE4ZmY+DpP5PdqtJil83xK0=;
    b=AvOkLwRa+DIkKGqnFyhmHOhsE9yp51vm4ydLkD7wEXOmq40WuGUWF7QBanAJUWIm8l
    Qy5TJdR1HTGpDHxpVEJvX8flbV7ZQY05l6Uqhu61FhQb6ZUgn8sa5KCpPAKWtuHrXKF8
    +4KjD1jZr8iEjbtYsGcrlaXBJ75JWQ5Wn/jjyU1sOdmUiPjm/qYSW3KMmiBvnnr+2pbv
    d60F5plLbsw0MUsBCzaaBRvr8lOIb4I/QIdwuZ9FKuXWZju6X1hWw++dqoRoKQB82+xc
    Bgj9pULJ5iwPSbDmx9AB09LITdjMf4SIzJGyAOu+qfGGhQIWtc95J/I1Ez1qMyzYHMsp
    idsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349339;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=I+LZB86CM7vwY0RR16eIEE4ZmY+DpP5PdqtJil83xK0=;
    b=ux2jTm9ywx4RFqZbeoAIFtv1/HNAnykX3Cb1jiyy79kSHIsO22H7hOxPtrUUO8lza0
    8KBi76JqA3lw1xxUKIBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HImwBIG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:48:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:40 +0200
Subject: [PATCH 1/8] arm64: dts: qcom: apq8016-sbc: Fix regulator
 constraints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-1-54d4960a05fc@gerhold.net>
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

For some reason DB410c has completely bogus regulator constraints that
actually just correspond to the programmable voltages which are already
provided by the regulator driver. Some of them are not just outside the
recommended operating conditions of the APQ8016E SoC but even exceed
the absolute maximum ratings, potentially risking permanent device
damage.

In practice it's not quite as dangerous thanks to the RPM firmware:
It turns out that it has its own voltage constraints and silently
clamps all regulator requests. For example, requesting 3.3V for L5
(allowed by the current regulator constraints!) still results in 1.8V
being programmed in the actual regulator hardware.

Experimentation with various voltages shows that the internal RPM
voltage constraints roughly correspond to the safe "specified range"
in the PM8916 Device Specification (rather than the "programmable
range" used inside apq8016-sbc.dtsi right now).

Combine those together with some fixed voltages used in the old
msm-3.10 device tree from Qualcomm to give DB410c some actually valid
voltage constraints.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 4c7d53d16d77 ("arm64: dts: apq8016-sbc: add regulators support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 64 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 59860a2223b8..14cb217a13c1 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -447,21 +447,21 @@ &smd_rpm_regulators {
 	vdd_l7-supply = <&pm8916_s4>;
 
 	s3 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1562000>;
+		regulator-min-microvolt = <1250000>;
+		regulator-max-microvolt = <1350000>;
 	};
 
 	s4 {
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <2150000>;
 
 		regulator-always-on;
 		regulator-boot-on;
 	};
 
 	l1 {
-		regulator-min-microvolt = <375000>;
-		regulator-max-microvolt = <1525000>;
+		regulator-min-microvolt = <1225000>;
+		regulator-max-microvolt = <1225000>;
 	};
 
 	l2 {
@@ -470,13 +470,13 @@ l2 {
 	};
 
 	l4 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2050000>;
+		regulator-max-microvolt = <2050000>;
 	};
 
 	l5 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 
 	l6 {
@@ -485,45 +485,45 @@ l6 {
 	};
 
 	l7 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 	};
 
 	l8 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
 	};
 
 	l9 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	l10 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
 	};
 
 	l11 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
 		regulator-allow-set-load;
 		regulator-system-load = <200000>;
 	};
 
 	l12 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
 	};
 
 	l13 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <3075000>;
+		regulator-max-microvolt = <3075000>;
 	};
 
 	l14 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	/**
@@ -531,14 +531,14 @@ l14 {
 	 * for mezzanine boards
 	 */
 	l15 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
 	};
 
 	l16 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
 	};
 
 	l17 {
@@ -547,8 +547,8 @@ l17 {
 	};
 
 	l18 {
-		regulator-min-microvolt = <1750000>;
-		regulator-max-microvolt = <3337000>;
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
 	};
 };
 

-- 
2.40.1

