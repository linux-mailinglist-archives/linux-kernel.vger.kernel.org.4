Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA072F5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243334AbjFNHRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243462AbjFNHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:28 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835F1FDD;
        Wed, 14 Jun 2023 00:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726978; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ds9G89lxYkSZbNngFT2UU9u/oEkfYQNPTGRVABIg0mKoOekgoKoNgfjs+fDtALOmgQ
    R9UAkktWLnCIE9xZp/TsUafmVZQRDSgv76YHbRwWJtPEvY4jfknnJU79IFTNKlIH8MqJ
    1+FDO66sXmY9TvYlWyLGkEe+UgIinyf89rbYg+U8GEjALveSYr+Q5I9VICehSXiXyXRS
    4oYIyiai0gZKbHHNiI3wutLyOo6S4i9FrIrFacgpRgYL520kY6klrqcXNmsUdd7DW1oM
    +8X1exNW00yD2BAHJHcP7meGO4Eqph1iG+V0KmJ6QGyLdJeY4mVYNz9K03jJrG70eUAr
    wiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=v8HUS+pZdhRpBsfa2DBFbPmZyCwAPxZBJXa80UK4EoA=;
    b=Zj5VJyjsJAYlu0SNJvBqCbABw9wRQeCeNuW+TlG9ypMg2pCi/RppYvsKbZ4JyqTL17
    kExofKD2mrQgZSQxBU21L2YL02+/G9h/k0ypk/67soYpQ1gHxTHM4DULaPfBXLcGlAZC
    TQCUMEmLOXYtgYBJGrakDEf7k5PHirPnsel6K4WBpza1SH/ej4+H7PDPKEyV3wMRbnYu
    83QyjSsYuu0FSZ3ExIaeQqntmwVBkFiB7GHYyYEanGQ1QNUC8g3PPl4eWHxMJ8mUTY7h
    9XctjfZX68p+Lg9PGerOom5djrd6JcAwnt1gmqTgjAJXUFph/EQuyWd8EvPw98JE/Z0j
    gfEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=v8HUS+pZdhRpBsfa2DBFbPmZyCwAPxZBJXa80UK4EoA=;
    b=QpdapDNpUVjlpgfLubLiG4XiqpnDFRRYfG2RlqmCz5qic2cdeQFLfyq1vUMrPraJfG
    3mS8UAUU5LDPayeOA0rc6FU+z1OcZZzfvl3hoSS6oGOwEBMsOVwcgl398D3rmkJf0dRL
    IvQAyecI1yyWe5gm7rCxYPjadSu9CMxlTXOZz+NA4lOZTSwnpY7xqI0R6/e5ucjilqhy
    rlV69C97e/irRxYGjUGoBk47JPOeDpIBRA4xjP4cUitZDFcUmqTYb+eY2xapKCcsES1l
    32CedLDQBh1Jy7J4SdgGeeRSHHvLs3Wlt0oFXWAzxXaNZnyioP3hfwbdj6BG9a2eNejB
    OStw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726978;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=v8HUS+pZdhRpBsfa2DBFbPmZyCwAPxZBJXa80UK4EoA=;
    b=gPU7OJBy/WyZyhF/LhtlyFTzuwYA4EhuL6vOvwhu/ElAbsdW3GXzH3zyGGaMtJY1tP
    IjAXXADKrlAvP5OMPoAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GHb2e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:01 +0200
Subject: [PATCH 3/8] arm64: dts: qcom: msm8939-sony-tulip: Fix l10-l12
 regulator voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-3-a3c3ac833567@gerhold.net>
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

msm8939-sony-xperia-kanuti-tulip.dts has several regulator voltages
that do not quite seem to match what is used in the vendor kernel.
In particular:

 - l10 is fixed at 2.8V [1, 2]
 - l11/l12 are 2.95V max [1]

[1]: https://github.com/sonyxperiadev/kernel/blob/aosp/LA.BR.1.3.3_rb2.14/arch/arm/boot/dts/qcom/msm8939-regulator.dtsi
[2]: https://github.com/sonyxperiadev/kernel/blob/aosp/LA.BR.1.3.3_rb2.14/arch/arm/boot/dts/qcom/msm8939-kanuti_tulip.dtsi#L671C1-L673

Fixes: f1134f738fad ("arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
index a9df8dab5481..dc5b8cd5b9f4 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
@@ -110,20 +110,20 @@ pm8916_l9: l9 {
 	};
 
 	pm8916_l10: l10 {
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
 	};
 
 	pm8916_l11: l11 {
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-max-microvolt = <2950000>;
 		regulator-system-load = <200000>;
 		regulator-allow-set-load;
 	};
 
 	pm8916_l12: l12 {
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-max-microvolt = <2950000>;
 	};
 
 	pm8916_l13: l13 {

-- 
2.40.1

