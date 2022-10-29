Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15F3612504
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2THt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ2THr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:07:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BD811C31
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:07:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y14so20310395ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxbWFg7iqEwoKAXmvMDJBeHivZgp9qPLv+RGDyqDdNU=;
        b=UwfabeVl7QBRjouAJKyrNYLPkdq8/01Rh2g20BsevZgulVXgLtFhsv+wOgDu6tTKXC
         HWVC/pTsOsPPniBCIqy/bp2+jW50gjsvwsjYNVb8IMKMvB1xO5sjzL+G9xYz52rzVYJ0
         Rwum4bq6nIv1vrNyc53s+d3+EpFKqycVKtYG9YckI6doMs7buBWNrEikyxKZoTs9Xl+6
         QUAlBjEwxY76k8HtyyPzoJSUJPFjqP/HvQNgf1sWytG50QYK34+UahTN2ZmXBOyViCw1
         XUVricdKX03Fg/MlZm+xwgXDKf5cC7CY3wpT4vGNxVKuwEBKiDlX1C1Kmz+zXqvp9wjq
         qRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxbWFg7iqEwoKAXmvMDJBeHivZgp9qPLv+RGDyqDdNU=;
        b=PVQSjEIeU6cJ/+z2Y7QGOz+0WRcGVVF48U3U5zvPWc9zDFkmA3gfI2noBIZlhcoONl
         /ay5P3Zlp+bn8F193+jwXs+QFEg9O6U9qNSLLsCskBFwzZ4BBsiGlWDaDKAVBcxTnzeB
         iumbfBaiJP5Ug2ixaoMCuHvwKnvNEjQCbVbEQcwxSdpgG0gGuDDeRfcd2pTVXiiQoLqz
         Cpc9U1CGJW7RMXYyFDVZPqqJofBH1WOIVCtAsRxmaHpAcRB/iegeb4Dh84YE6IdPD1/1
         EQwZT/RwJL+JbuJz6HK0UNYpV4aOvTXwVRx8C21R+WHfLgtXPW+O8wUSssJXe9UA+I/s
         pMww==
X-Gm-Message-State: ACrzQf2JN4JOwlLq28BMyr28MEoUfa688iEBQxX+uWKdxxly35zbUBGn
        9J6nkKPLIdX4S1PuAd1AcJXywAYkdSYbFZsCeUgnWQ==
X-Google-Smtp-Source: AMsMyM7YXTudD6bbcX4zQ0JMSXBAl+uEW0Ph54C5La2a7prfW4z9+lMWSXkyfnEmvirTIbcMSDNDy/Yt1/3m3cTNG34=
X-Received: by 2002:a17:907:2c72:b0:7a4:a4b4:9fcb with SMTP id
 ib18-20020a1709072c7200b007a4a4b49fcbmr5022245ejc.403.1667070462169; Sat, 29
 Oct 2022 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-13-manivannan.sadhasivam@linaro.org> <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
In-Reply-To: <90b7e0e0-a354-f64d-8c53-aa80df684a3a@somainline.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sat, 29 Oct 2022 14:07:25 -0500
Message-ID: <CAKXuJqhzNvuCh8q0d6F5+X9XxNzx5vOYy490X4-LAXy6WhN49g@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal
 zone support
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 9:29 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
>
> On 29.10.2022 07:14, Manivannan Sadhasivam wrote:
> > Add thermal zone support by making use of the thermistor SYS_THERM6.
> > Based on experiments, this thermistor seems to reflect the actual
> > surface temperature of the laptop.
> >
> > For the cooling device, all BIG CPU cores are throttle down to keep the
> s/throttle/throttled
>
> Is it okay to let the 4xA78C run at full throttle in thermal emergencies though?
> > temperature at a sane level.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 46 +++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > index ca77c19c6d0d..96e2fa72f782 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> > @@ -29,6 +29,52 @@ backlight {
> >               pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> >       };
> >
> > +     thermal-zones {
> > +             skin-temp-thermal {
> > +                     polling-delay-passive = <250>;
> > +                     polling-delay = <0>;
> > +                     thermal-sensors = <&pmk8280_adc_tm 5>;
> > +
> > +                     trips {
> > +                             skin_temp_alert0: trip-point0 {
> > +                                     temperature = <55000>;
> > +                                     hysteresis = <1000>;
> > +                                     type = "passive";
> > +                             };
> > +
> > +                             skin_temp_alert1: trip-point1 {
> > +                                     temperature = <58000>;
> > +                                     hysteresis = <1000>;
> > +                                     type = "passive";
> > +                             };
> > +
> > +                             skin-temp-crit {
> > +                                     temperature = <73000>;
> Ouch, I didn't know we were serving burnt fingers at the cafeteria today :D
>
> Or maybe this just looks scary.. The laptop looks plastic, so maybe it won't cause instant
> burns?
>

Disclaimer: I'm an end user that likes to cosplay as a kernel
developer sometimes...

IMO, it just looks scary.  the skin-temp, afaik, is the temperature of
the shell of the laptop, so once it reaches 73C, it would be crit.  In
practice (I've been testing this patch set for a while), I've never
been able to hit 73C, even with the ambient temperature in my
apartment being 77F and multiple compilations running.  I've also
tested a hack to increase the trips to a little bit higher (65/68/73)
and still not been able to do so.

On the flip side, without this patchset, we do not have any thermal
trips at all, and the machine will quite happily run up to 90C (and
I've not seen it shut down, but I wouldn't use it on my lap when this
is occurring...)

> Konrad
> > +                                     hysteresis = <1000>;
> > +                                     type = "critical";
> > +                             };
> > +                     };
> > +
> > +                     cooling-maps {
> > +                             map0 {
> > +                                     trip = <&skin_temp_alert0>;
> > +                                     cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +
> > +                             map1 {
> > +                                     trip = <&skin_temp_alert1>;
> > +                                     cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +                                                      <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +
> >       vreg_edp_bl: regulator-edp-bl {
> >               compatible = "regulator-fixed";
> >
