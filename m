Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EFF6F3F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjEBIkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjEBIjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:39:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87849D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:39:39 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a83e80262so15903947b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683016778; x=1685608778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQYzzCPoXqswlpvIFD6WRnJfdsdZ7oE3ts+Rlv8RaJc=;
        b=JCYSJJycOh3uM3e1Pr69ENYHONt+EDeJ1G0216dirbDHn9z2Sp+bxDrP7VXakiMrXc
         GJbWhGinBB3SufaTvEuBbZghU3g7Ac55Z26LjCBRnr6nkxnxAi+fgQNMrj0n40YKt0IC
         KuzZM2Ww44iMf76utY5TImcOMS5YM0yDt8I6ugtPm12pnf0XhuX6gXmj3+TKzIqchddG
         peVrV07kn7PywtYF5GhN3zfRqdOj3snooHwRTqkHoIDKGaZQgzPvvjtv1D2kTS3By9he
         rtgGrmezHux9aZIytkYPbe5nf8NvKTONiI+arBnjh+DPvf0B8eoFE+QqQETYWeeEnNux
         zK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683016778; x=1685608778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQYzzCPoXqswlpvIFD6WRnJfdsdZ7oE3ts+Rlv8RaJc=;
        b=PJjrdLHHBm3RVcyHwAr+7XsBxasWBrHGfkF/cXJM5dwb2lYVKR4z8sD4p9Wt2Z/tKH
         DEcc7ghGBcFWCgPd2S64z1GydBbZnc9KPbiicDDVTul/qz9ly9kY2THKCdXXpJDKTo21
         pKtp8gx6RCzQYlwKKe/IUZqGDY4p2qK8b/y+nLxIquE1RDdeMFHih4jxpQWUHZJNcdBZ
         7knwJPEzC+wFWryeltVnEh3xmzofZsNBuWuOv2/Yyt2aQLqWlmZuO6KebhQNTXiQ27mm
         b2hWAGo5z1wF1hlWykdsO80CHdiZUhz24EW2LAtEXNY023rNrTuBvMpKiFbTEJVj1RkZ
         Lq7A==
X-Gm-Message-State: AC+VfDw/zorP8hte1e2eSs1wJAHPCtPORLgN7l2UlPQYqx/m68xSerJK
        QapPgQVWbj13uiGUjT/3lkblr1/QBoitQE2OXOx6KA==
X-Google-Smtp-Source: ACHHUZ5iTF/W04H0/7bScMxDWwW9LvBeXxThecO2SmLhQIi3VwlMDIRkkFwvEHZDl2GYHRMgIZ4LdcbNkrrLD1QTe+w=
X-Received: by 2002:a25:6813:0:b0:b9a:63a2:dc6c with SMTP id
 d19-20020a256813000000b00b9a63a2dc6cmr15309161ybc.53.1683016778500; Tue, 02
 May 2023 01:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1682682753.git.quic_varada@quicinc.com> <1bda63e18f7257f60cc1082b423aca129abfa3b0.1682682753.git.quic_varada@quicinc.com>
 <CAA8EJpq0RXGf8_oBa_XF0+nOg31ouMUVJ3LhNRh_HtmgJvCJHQ@mail.gmail.com> <20230502080440.GA26126@varda-linux.qualcomm.com>
In-Reply-To: <20230502080440.GA26126@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 2 May 2023 11:39:27 +0300
Message-ID: <CAA8EJpoHMdNFFu4rX2O_N64TV62uAEj4tZqRLpWP8WZrf-PQhQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: ipq9574: add thermal zone nodes
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 11:04, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Fri, Apr 28, 2023 at 10:49:34PM +0300, Dmitry Baryshkov wrote:
> > On Fri, 28 Apr 2023 at 17:53, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > This patch adds thermal zone nodes for the various
> > > sensors present in IPQ9574
> > >
> > > Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 208 ++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 208 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/=
dts/qcom/ipq9574.dtsi
> > > index 7cd5bdb..a7cb2b4c 100644
> > > --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> > > @@ -947,6 +947,214 @@
> > >                 };
> > >         };
> > >
> > > +       thermal_zones: thermal-zones {
> > > +               tsens_tz_sensor3 {
> >
> > Please provide sensible names for all thermal zones. Please follow the
> > examples in other DT files.
>
> Ok.
>
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 3>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> >
> > Can it really go up to 125 =C2=B0C?
>
> The SoC product requirement is 120=C2=B0C. It is capable of 125=C2=B0C.
> This was tested inside a thermal chamber and ensured that it
> hits 125=C2=B0C and system reboots at that temperature.

ack

>
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> >
> > Please provide also a passive trip point, so that the passive cooling
> > can be engaged.
>
> The linux kernel cannot take any steps to initiate cooling for
> components other than the 4 CPU cores. The f/w that runs on these
> IP blocks have to take steps to initiate cooling. Additionally,
> the passive temperature for the non-cpu sensors are not
> characterised yet and I don't have the values now.
>
> We have these nodes to be able to read the temperature of the
> other blocks via the sysfs entry /sys/devices/virtual/thermal/*/temp
> Have given the critical trip point so that the setup is rebooted
> if the critical temperature is reached.
>
> Have given passive trip point for the CPU core related thermal
> nodes (tsens_tz_sensor10, tsens_tz_sensor11, tsens_tz_sensor12
> and tsens_tz_sensor13).

That's the point why we asked for the logical names for the sensors,
like we have on the other platforms. Otherwise it is very hard to
understand what is going on.

>
> If this is not acceptable, please let me know. Will remove the
> non-cpu nodes and post a patch with just the CPU entries.

This is perfectly fine. Please take a look at other DTSI files.

>
> Thanks
> Varada
>
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor4 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 4>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor5 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 5>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor6 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 6>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor7 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 7>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor8 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 8>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor9 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 9>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor10 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 10>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <120000>;
> > > +                                       hysteresis =3D <10000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +
> > > +                               cpu-passive {
> > > +                                       temperature =3D <110000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor11 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 11>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <120000>;
> > > +                                       hysteresis =3D <10000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +
> > > +                               cpu-passive {
> > > +                                       temperature =3D <110000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor12 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 12>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <120000>;
> > > +                                       hysteresis =3D <10000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +
> > > +                               cpu-passive {
> > > +                                       temperature =3D <110000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor13 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 13>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <120000>;
> > > +                                       hysteresis =3D <10000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +
> > > +                               cpu-passive {
> > > +                                       temperature =3D <110000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "passive";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor14 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 14>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +
> > > +               tsens_tz_sensor15 {
> > > +                       polling-delay-passive =3D <0>;
> > > +                       polling-delay =3D <0>;
> > > +                       thermal-sensors =3D <&tsens 15>;
> > > +
> > > +                       trips {
> > > +                               cpu-critical {
> > > +                                       temperature =3D <125000>;
> > > +                                       hysteresis =3D <1000>;
> > > +                                       type =3D "critical";
> > > +                               };
> > > +                       };
> > > +               };
> > > +       };
> > > +
> > >         timer {
> > >                 compatible =3D "arm,armv8-timer";
> > >                 interrupts =3D <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | I=
RQ_TYPE_LEVEL_LOW)>,
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry
