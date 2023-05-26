Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552E97127F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243798AbjEZOD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:03:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE8DF;
        Fri, 26 May 2023 07:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685109831; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hLUup2AF9FjJX3SMqEQuyazTJe76uPhq3N5Y5PXkfpaRiyzM5FpddJu3G6ItAOMuyY
    ifwKgrDEHeAIbEvTzXH4oTYkchscNRd3Ds8temLtjJWEJeJ+TWzcdDlkuXaC0eWTxjhu
    DpLq1TZ+xgGbh+5c2qg5N0/00KTUIgm6H0V+sk6BVsAYyffZhPy+6pHHx6T76v1x3Row
    O2nH+afdd3hRa2VeKwh5AApRy8Vjx5L9JlndeB46Kog6OrXy8ie2VqmzBRVupoUYPYPm
    IMpk/+8dm22Z4ydb3bXTrpwhiPwNtXUNf3MNbgx+9vvnuvIH/qtouG4HnnyzjhPj1yKf
    Sd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685109831;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhOGk10ygmP7nNAqxT0dbqHX7vPqfMWPQJ7k5CUCTa0=;
    b=VGHr/FLlie96uxjg+9EXTHmy+BshFP8VAAxMY7Ld1NWVm57J23rpER/5ju7KeR78Q8
    2AtnPwcg8KavV/Or40kAjYAIx7BTUlpXPgfMc04yMX8jwfd6SSYApsUIuCLtsAN4622d
    zqK3zPaKckiNBcJAz21HwuFjhKx3WdTuMO7cR4ymhDDdHzgNlTiuQ++NBKqhR7w2IRKR
    QeW/EcGLZIQHkiXRSqxvbzy+5EtMOp1fQsDOWprq6XYU8fVXMp1Ac9KnTA9a6uBFyBJD
    wPLcy4UZvR0AF5tDnVnBHSrtUNX84yVS2kJKP3GP3y6wm6IEyGec1fL7ubjOBnBbEHvH
    Z71w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685109831;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhOGk10ygmP7nNAqxT0dbqHX7vPqfMWPQJ7k5CUCTa0=;
    b=f6hJ1FRE/GLVsml2gNyEOZUIjT8T4oSPS0AgMjyaPfwa+twJ2ggOYpzMwQ5UESAlZ/
    3pPfRn4v7WU3a0HtQa7SG52h79FLsn4iDDDecycyEPhxgMdpEDlO/DA8IpKfuC+nibdv
    fMcap24ucTRdEOCyOvstv1RXiW+JgzBiPmF42igCdMJuP9Ojo3KY63gb70zi2FQP5jRA
    sPlTferRFA0jkpZbfvDkuX9eyG4BkAB/WIOW+r6+bOOfgR5WVpt4vLkBMXZ0GK/8pyHU
    Tg+PB+DRJR60gtdCN2zdKki8Gu0jBaOuFULWIpXZi9QSzaeGqgFmo2CCChL2RKMdXZfq
    kadA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685109831;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zhOGk10ygmP7nNAqxT0dbqHX7vPqfMWPQJ7k5CUCTa0=;
    b=enApK+9wIHXRh8zq75pO2ifgtcphtLsDfa/ojSAkLIVBkRi+uv9pjitMcWvUAsx8xe
    FZ1rUG+DdzGOruzhlIAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4QE3obOP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 26 May 2023 16:03:50 +0200 (CEST)
Date:   Fri, 26 May 2023 16:03:42 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/8] arm64: dts: qcom: msm8916: Fix regulator constraints
Message-ID: <ZHC8PhUi0H4o4TUR@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
 <20230510-msm8916-regulators-v1-3-54d4960a05fc@gerhold.net>
 <cae30437-f9bc-6e7a-8371-bba7eeff1e8f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cae30437-f9bc-6e7a-8371-bba7eeff1e8f@linaro.org>
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

On Fri, May 26, 2023 at 02:38:01PM +0100, Bryan O'Donoghue wrote:
> On 17/05/2023 19:48, Stephan Gerhold wrote:
> > The regulator constraints for most MSM8916 devices (except DB410c) were
> > originally taken from Qualcomm's msm-3.10 vendor device tree (for lack
> > of better documentation). Unfortunately it turns out that Qualcomm's
> > voltages are slightly off as well and do not match the voltage
> > constraints applied by the RPM firmware.
> > 
> > This means that we sometimes request a specific voltage but the RPM
> > firmware actually applies a much lower or higher voltage. This is
> > particularly critical for pm8916_l11 which is used as SD card VMMC
> > regulator: The SD card can choose a voltage from the current range of
> > 1.8 - 2.95V. If it chooses to run at 1.8V we pretend that this is fine
> > but the RPM firmware will still silently end up configuring 2.95V.
> > This can be easily reproduced with a multimeter or by checking the
> > SPMI hardware registers of the regulator.
> > 
> > Fix this by making the voltages match the actual "specified range" in
> > the PM8916 Device Specification which is enforced by the RPM firmware.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >   arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts           | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts         | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 12 ++++++------
> >   arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi   | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi    | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                  | 14 +++++++-------
> >   arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 12 ++++++------
> >   13 files changed, 89 insertions(+), 89 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> > index 13cd9ad167df..0d517804e44e 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> > +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> > @@ -159,13 +159,13 @@ &smd_rpm_regulators {
> >   	vdd_l7-supply = <&pm8916_s4>;
> >   	s3 {
> > -		regulator-min-microvolt = <1200000>;
> > -		regulator-max-microvolt = <1300000>;
> > +		regulator-min-microvolt = <1250000>;
> > +		regulator-max-microvolt = <1350000>;
> 
> Where are you getting these 5s from ?
> 

I have two explanations for this, one is "documentation", the other is
"experimental testing". You can choose the one you find more convincing. :)

### Documentation ###

For documentation, the S3 range is defined in "PM8916/PM8916-1 Power
Management ICs - Device Specification - LM80-P0436-35 Rev.C - Table 3-16
Regulator high-level summary". The "Specified Range" for this regulator
is 1.25–1.35V.

Also, if you look at typical schematics (e.g. DB410c) you can see that
PM8916 S3 supplies the VDD_xxx_1P3 rails of the WCN3620/WCN3660/WCN3680
chip. Looking at the defined "Operating conditions" in the datasheets of
those they define "Min: 1.25V, Typ: 1.3V, Max: 1.38V". As such, 1.2V is
not even a valid voltage for the actual usage of this regulator.

### Experimental Testing ###

The reason why it still works in practice is that the RPM firmware does
not let you apply invalid voltages here. With experimental testing
I observed that it keeps the voltage always in the "Specified Range"
of 1.25–1.35V.

You can reproduce this easily by adding the SPMI regulators in
pm8916.dtsi. These represent the actual regulator hardware registers:

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 864bb1cd68db..22ab0f59be4a 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -177,5 +177,9 @@ wcd_codec: audio-codec@f000 {
 			#sound-dai-cells = <1>;
 			status = "disabled";
 		};
+
+		regulators {
+			compatible = "qcom,pm8916-regulators";
+		};
 	};
 };

With this each of the regulators will show up twice in /sys/class/regulator.
Once the RPM version and once the SPMI version. If you check the
/sys/class/regulator/.../microvolts of the SPMI variant you can see the
actual voltage that was applied by the RPM firmware.

For example, if you think that 1.2V is really possible then try:

	s3 {
		regulator-min-microvolt = <1200000>;
		regulator-max-microvolt = <1200000>;
	};

In sysfs you will almost certainly see that the SPMI regulator is
actually configured with 1.25V by the RPM firmware. It does not allow
setting anything lower.

> >   	};
> >   	s4 {
> > -		regulator-min-microvolt = <1800000>;
> > -		regulator-max-microvolt = <2100000>;
> > +		regulator-min-microvolt = <1850000>;
> > +		regulator-max-microvolt = <2150000>;
> >   	};
> >   	l1 {
> > @@ -199,7 +199,7 @@ l7 {
> >   	};
> >   	l8 {
> > -		regulator-min-microvolt = <2850000>;
> > +		regulator-min-microvolt = <2900000>;
> >   		regulator-max-microvolt = <2900000>;
> >   	};
> > @@ -209,12 +209,12 @@ l9 {
> >   	};
> >   	l10 {
> > -		regulator-min-microvolt = <2700000>;
> > +		regulator-min-microvolt = <2800000>;
> >   		regulator-max-microvolt = <2800000>;
> >   	};
> >   	l11 {
> > -		regulator-min-microvolt = <1800000>;
> > +		regulator-min-microvolt = <2950000>;
> 
> Wouldn't 1v8 be the right voltage for eMMC !SD though have you tested eMMC
> instead of SD ?
> 

This is the supply voltage (not I/O voltage) which is also 2.9V for the
eMMC typically. But the point here is that only 2.95V can be set for
this regulator on most RPM firmware versions.

It does not matter what you connect there. I tried setting

	l11 {
		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
	};

but the RPM firmware still applies 2.95V. In this case I even verified
this with a multimeter. The regulator is always 2.95V, even if you ask
the RPM firmware to apply 1.8V.

Thanks,
Stephan
