Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157256064A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJTPd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJTPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:33:54 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA8C1B65FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:33:51 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w196so23248575oiw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb7wkJsdodj13ALcLKizHm+uIzlavrlwr63btmQUUWM=;
        b=LDpJmRNtfTZTl6bPThW6qW0OA8mlAT1aEHTzGk3+MB9awjN1+LlNL/89KiuCD2V+Cv
         /yyOq+68qRg1091rqP8oHkDUsyLUzH8vANUfuXndSJdVXyYbamlBOtW7Q6m7/dJQPKcM
         ID4j0vUTfiv6S/3TDK3IaDmErf2h5E0Ho3bWRBXmuZmiIow25y2ocSSsAwrUeO5v10Et
         w1U7aBaePb0d7511zpzHPUh1oQ3zoYuSIjPyZFx3Vt4PujCywB6mwYkugO9N8qsVu8kZ
         Zq/YceOk5CB8IY8EBpounD7s47R7k/dqgHDAjEiRqpF2pE3Eb8jsUEXNKmNR1j0PpVHL
         wPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb7wkJsdodj13ALcLKizHm+uIzlavrlwr63btmQUUWM=;
        b=uSfVF7SfK3LqrvkjXbq4I27YaXzJIlLH6/TyxPJVPpXcW8yTcq7+ekJ6O15p11427Y
         47y5rvLlTGYFhycRXuro7kXSN8tPkpamjDp7kDOYSRbvGu3WRpfGeepfT2uXi3ULChwg
         U9Ew4kPF8FiqdMnd8Hgk7EO04wPe6IVN+RiuUZ+m23zjwcUscAWL1D1aCAO01TYsW+Ly
         gwFEkUrStDCI6o9cSQSq1JtT67TNcBTjDGYB2bi4LsnPuUOBBYSEahavjqXkf8Hhct8u
         gU408eW3Bczgq0Zw715XxOp5ZC5VcyHBvADBjpcH9HSpj9z3V4XI2HvEMzpRy+ddLhDz
         1SRw==
X-Gm-Message-State: ACrzQf0qWXJGw6TTHYX1spHt++UwYjlH+hGxt4LyFsAZuuVndsmCzV3Y
        v2pp5XjA0usc4SDlH/Z1Vbav2Kr0rZ+RWnj2F3d2Vw==
X-Google-Smtp-Source: AMsMyM4OVA68IQCay0CdDe0+XNd+vxHWXh/Z106bovGEWGu4Z6EQOF56pVhT9SYEYgCPjDY5RhnWuUJlJlJF+DpomH8=
X-Received: by 2002:a05:6808:3097:b0:355:347e:2df6 with SMTP id
 bl23-20020a056808309700b00355347e2df6mr11804023oib.44.1666280030766; Thu, 20
 Oct 2022 08:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221018145348.4051809-1-amit.pundir@linaro.org>
 <CAPDyKFoBMB9OMUrcoPCV0of1fj2dimEwPyHGW=ydjJ2M0ubM8Q@mail.gmail.com>
 <20221020093057.zrrvxlgghn27bpes@bogus> <CAMi1Hd05PkEJcHqHpQX-X6B2oR4250_pHPjkd2-54JWgKsYx0Q@mail.gmail.com>
 <CAPDyKFo=w-ET62c-B6=qSpkZm-V9LmBuVRy38GzX_UAjQhX6oA@mail.gmail.com>
In-Reply-To: <CAPDyKFo=w-ET62c-B6=qSpkZm-V9LmBuVRy38GzX_UAjQhX6oA@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 20 Oct 2022 21:03:14 +0530
Message-ID: <CAMi1Hd3SeN56a7oRC0RYBTPx0PwWSP4dM=9tHFMa0P4OckXjiA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: Disable cpuidle states
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 at 20:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 20 Oct 2022 at 16:09, Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > On Thu, 20 Oct 2022 at 15:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 01:57:34PM +0200, Ulf Hansson wrote:
> > > > On Tue, 18 Oct 2022 at 16:53, Amit Pundir <amit.pundir@linaro.org> wrote:
> > > > >
> > > > > Disable cpuidle states for RB5. These cpuidle states
> > > > > made the device highly unstable and it runs into the
> > > > > following crash frequently:
> > > > >
> > > > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > > > >
> > > > > Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")
> > > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > index cc003535a3c5..f936c41bfbea 100644
> > > > > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > > @@ -251,6 +251,14 @@ qca639x: qca639x {
> > > > >
> > > > >  };
> > > > >
> > > > > +&LITTLE_CPU_SLEEP_0 {
> > > > > +       status = "disabled";
> > > > > +};
> > > > > +
> > > > > +&BIG_CPU_SLEEP_0 {
> > > > > +       status = "disabled";
> > > > > +};
> > > > > +
> > > > >  &adsp {
> > > > >         status = "okay";
> > > > >         firmware-name = "qcom/sm8250/adsp.mbn";
> > > > > --
> > > > > 2.25.1
> > > >
> > > > Disabling the CPU idlestates, will revert us back to using only the WFI state.
> > > >
> > > > An option that probably works too is to just drop the idlestate for
> > > > the CPU cluster. Would you mind trying the below and see if that works
> > > > too?
> > > >
> > >
> > > Indeed this is was I suggested to check initially. But I was surprised to
> > > see IIUC, Amit just disabled CPU states with above change and got it working.
> > > So it is not cluster state alone causing the issue, is it somehow presence
> > > of both cpu and cluster states ? Am I missing something here.
> > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > index c32227ea40f9..c707a49e8001 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > @@ -700,7 +700,6 @@ CPU_PD7: cpu7 {
> > > >
> > > >                 CLUSTER_PD: cpu-cluster0 {
> > > >                         #power-domain-cells = <0>;
> > > > -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> > >
> > > How about just marking CLUSTER_SLEEP_0 state disabled ? That looks cleaner
> > > than deleting this domain-idle-states property here. Also not sure if DTS
> > > warnings will appear if you delete this ?
> >
> > Hi, I did try disabling CLUSTER_SLEEP_0: cluster-sleep-0 {} in
> > domain-idle-states {} but that didn't help. That's why I end up
> > disabling individual cpu states in idle-states {}.
>
> Yep, this boils down to the fact that genpd doesn't check whether the
> domain-idle-state is disabled by using of_device_is_available(). See
> genpd_iterate_idle_states().
>
> That said, I suggest we go with the above one-line change. It may not
> be as clean as it could be, but certainly easy to revert when the
> support for it has been added in a newer kernel.
>
> Amit, do you want me to post a new patch or do you prefer to re-spin
> your patch? It doesn't matter to me.

Sent. Thanks.

Regards,
Amit Pundir

>
> Kind regards
> Uffe
