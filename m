Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A560CAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiJYLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiJYLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:24:30 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F25C21E17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:24:29 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso4330590fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 04:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ogvOahPNmhpggqBTZ5QbvTn84Q49yePxZeXFmnUqiLs=;
        b=jutuwQxLvlEtjl08GBEDEUQLUX0ZptKv2K4eZi72W8GM7Qc2yUpxRsr+hXwVtu+diN
         ot8DN8Gnd4YFEI/dymIexaiz9CTLFPWzIzIBSFialYercjlsjhqfVBsin1yzJS/QfPXY
         DsqtLyLFDuIE8pg4D5N1ubpMaMp7Jee8dXMncrAAhnYYtVWppvc6lKdxvghxhjb2VrzR
         bE791M9x6DSiICRPPnF8+zvQqI2uSNjPbC3gbnJlMRQnIdgHYdtMteK1hlQI1c4IVmt5
         U2eRg34zVbfoRXm4XnPRpLuMrnnxA8AGxmkhyBhHeNApBLp2GVt8H8duYlxMnS8IBilf
         eSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogvOahPNmhpggqBTZ5QbvTn84Q49yePxZeXFmnUqiLs=;
        b=xzy4qEIE3Ndi7MY4dDIy7+1XPkmG6vW+lnNL6+zWSjxQ43YySXxeWJ+6zYgEX1Bflh
         Cme1wmtvOYHniY29Z2BeFl0bbMJaniJyWvHGy0amYrNlPpwsLv0/wP1tfkNyM5fc7KA4
         Sdqc+imL/F7XXlPU8fxRiREK2+XdcdegH4mbZLYlHGsaMMkfQf6VH6glh0K21OKht26X
         jdpYh1VEuANkkpbPUzls7kZTxli05s9+58fWcIbDy0nzc6YjZX1haPe6BrmQg0HLR2Bz
         2xkV/e0KoZeRZRHv8TOIx10nT/xz8UiWp3ipjk1LD1/yrH+ObriU79JYhExpPb1lXqcV
         67Wg==
X-Gm-Message-State: ACrzQf2xseR2IRc+U1YBGLTL29xnwER61wxnfD0l75JO9EJkXgvaRXqA
        AbJWPM3TIiTh3Tj+mUV5cUOgfjv8hYDpxUugbR5q6g==
X-Google-Smtp-Source: AMsMyM76taCJV+dCGKywuvCZcEk2Xs4M2Rw6lpxM+f0zfnwF1BufrNo2tesNJ4zzfv12nDqHKLnIKsJPPbZDyD77A34=
X-Received: by 2002:a05:6871:7a1:b0:131:946a:7b30 with SMTP id
 o33-20020a05687107a100b00131946a7b30mr40030282oap.67.1666697068405; Tue, 25
 Oct 2022 04:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221018145348.4051809-1-amit.pundir@linaro.org>
 <CAPDyKFoBMB9OMUrcoPCV0of1fj2dimEwPyHGW=ydjJ2M0ubM8Q@mail.gmail.com>
 <20221020093057.zrrvxlgghn27bpes@bogus> <CAMi1Hd05PkEJcHqHpQX-X6B2oR4250_pHPjkd2-54JWgKsYx0Q@mail.gmail.com>
 <CAPDyKFo=w-ET62c-B6=qSpkZm-V9LmBuVRy38GzX_UAjQhX6oA@mail.gmail.com>
 <20221020161628.nyimwuni4zboasjo@bogus> <CAPDyKFonwjh58jPoGc==BEjj6kY-=C97Ws=43hbdAqJMpEAa=g@mail.gmail.com>
In-Reply-To: <CAPDyKFonwjh58jPoGc==BEjj6kY-=C97Ws=43hbdAqJMpEAa=g@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 25 Oct 2022 16:53:51 +0530
Message-ID: <CAMi1Hd0B7T=Tkw=P_rBDV9SQSGCXAeYLYPADtVkh=95xf54D8A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: Disable cpuidle states
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 at 18:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 20 Oct 2022 at 18:16, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 20, 2022 at 04:40:15PM +0200, Ulf Hansson wrote:
> > > On Thu, 20 Oct 2022 at 16:09, Amit Pundir <amit.pundir@linaro.org> wrote:
> > > >
> > > > On Thu, 20 Oct 2022 at 15:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > >
> > > > > On Wed, Oct 19, 2022 at 01:57:34PM +0200, Ulf Hansson wrote:
> > > > > > On Tue, 18 Oct 2022 at 16:53, Amit Pundir <amit.pundir@linaro.org> wrote:
> > > > > > >
> > > > > > > Disable cpuidle states for RB5. These cpuidle states
> > > > > > > made the device highly unstable and it runs into the
> > > > > > > following crash frequently:
> > > > > > >
> > > > > > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > > > > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > > > > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > > > > > >
> > > > > > > Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")
> > > > > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 8 ++++++++
> > > > > > >  1 file changed, 8 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > > > index cc003535a3c5..f936c41bfbea 100644
> > > > > > > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > > > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > > > @@ -251,6 +251,14 @@ qca639x: qca639x {
> > > > > > >
> > > > > > >  };
> > > > > > >
> > > > > > > +&LITTLE_CPU_SLEEP_0 {
> > > > > > > +       status = "disabled";
> > > > > > > +};
> > > > > > > +
> > > > > > > +&BIG_CPU_SLEEP_0 {
> > > > > > > +       status = "disabled";
> > > > > > > +};
> > > > > > > +
> > > > > > >  &adsp {
> > > > > > >         status = "okay";
> > > > > > >         firmware-name = "qcom/sm8250/adsp.mbn";
> > > > > > > --
> > > > > > > 2.25.1
> > > > > >
> > > > > > Disabling the CPU idlestates, will revert us back to using only the WFI state.
> > > > > >
> > > > > > An option that probably works too is to just drop the idlestate for
> > > > > > the CPU cluster. Would you mind trying the below and see if that works
> > > > > > too?
> > > > > >
> > > > >
> > > > > Indeed this is was I suggested to check initially. But I was surprised to
> > > > > see IIUC, Amit just disabled CPU states with above change and got it working.
> > > > > So it is not cluster state alone causing the issue, is it somehow presence
> > > > > of both cpu and cluster states ? Am I missing something here.
> > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > > > b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > > > index c32227ea40f9..c707a49e8001 100644
> > > > > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > > > @@ -700,7 +700,6 @@ CPU_PD7: cpu7 {
> > > > > >
> > > > > >                 CLUSTER_PD: cpu-cluster0 {
> > > > > >                         #power-domain-cells = <0>;
> > > > > > -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> > > > >
> > > > > How about just marking CLUSTER_SLEEP_0 state disabled ? That looks cleaner
> > > > > than deleting this domain-idle-states property here. Also not sure if DTS
> > > > > warnings will appear if you delete this ?
> > > >
> > > > Hi, I did try disabling CLUSTER_SLEEP_0: cluster-sleep-0 {} in
> > > > domain-idle-states {} but that didn't help. That's why I end up
> > > > disabling individual cpu states in idle-states {}.
> > >
> > > Yep, this boils down to the fact that genpd doesn't check whether the
> > > domain-idle-state is disabled by using of_device_is_available(). See
> > > genpd_iterate_idle_states().
> > >
> >
> > Yes I found that but can't that be fixed with a simple patch like below ?
>
> Sure, yes it can.
>
> Although, it does complicate things a bit, as we would need two
> patches instead of one, to get things working.
>
> >
> > > That said, I suggest we go with the above one-line change. It may not
> > > be as clean as it could be, but certainly easy to revert when the
> > > support for it has been added in a newer kernel.
> > >
> >
> > I don't like removing the state. It means it doesn't have the state rather
> > than i"it has state but is not working and hence disabled".
> >
> > Will handling the availability of the state cause any issues ?
>
> No, this works fine. It's already been proven by Amit's test.
>
> >
> > Regards,
> > Sudeep
> >
> > -->8
> >
> > diff --git i/drivers/base/power/domain.c w/drivers/base/power/domain.c
> > index ead135c7044c..6471b559230e 100644
> > --- i/drivers/base/power/domain.c
> > +++ w/drivers/base/power/domain.c
> > @@ -2952,6 +2952,10 @@ static int genpd_iterate_idle_states(struct device_node *dn,
> >                 np = it.node;
> >                 if (!of_match_node(idle_state_match, np))
> >                         continue;
> > +
> > +               if (!of_device_is_available(np))
> > +                       continue;
> > +
> >                 if (states) {
> >                         ret = genpd_parse_state(&states[i], np);
> >                         if (ret) {
> >
>
> The above code looks correct to me. Anyone that wants to submit the
> patches? Otherwise I can try to manage it...

Just out of curiosity, I gave this patch a test run and, as Ulf also
mentioned above, this patch alone is not enough to fix the boot
regression I see on RB5.

Regards,
Amit Pundir

>
> Kind regards
> Uffe
