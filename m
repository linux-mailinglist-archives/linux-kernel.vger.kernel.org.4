Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D28606359
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJTOlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJTOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:40:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21B17938C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:40:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f8-20020a17090a664800b00212464cd49fso1697419pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnLorT9sOQVGySYbQtoiIKTRYgg4ni6wYU90wOW8GYI=;
        b=lJGez5U5n1n3elBo96mfl/fPJ5GX+VRLWs8mTl8HdSedxuPAXXxO7MukmF9IYbTzdU
         PD/lbs08uIOHwskVRvnoe3sFSh2MlEpL4bV6d3SLNiCljwSimJjVn4uLtHYdep5mcIcW
         icXUbnJUJI2l0tY2Mplg+9ojhkywkkTa7bFCIWN9u7a/1SUO1+tlHhDlQL1RHrnO6a/g
         hChhFXYj4OvoI69KiqyLGJbc/KhpriDjxTJRf3venDt0iO5vQwzYYh3/+FdAljum/vrM
         VkvdgFlFt42LqI+PfLJJkUaaCUe9p5hxrHdiReLDHmL3JQT4gC6UVbx4ljyLZ2v/IY6G
         k8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnLorT9sOQVGySYbQtoiIKTRYgg4ni6wYU90wOW8GYI=;
        b=Z94ybs7YgJWV0yKK4Vr/OhIwE6EqV2rjR4pQv/2N2XgfGWP7l3hI/o9KgPTvfoH/0M
         anm36imO1ZnOGvnY1v0gTB9ZhGKSxr80Pb0D3x/+aNzrI7xyfXvJI+mmoA3XJrbGgbvC
         EuZ2uMYYbFptPyBbmacYwPms14EuAMMqW0GSTclXKnZyhQ6bbdIuDmi8HQIkmwYKXeb9
         /g35M5vVvHUjdj+jff668TDcSek25ReZwKwbcQ1DDsChnCk3F5zeuUHNXDcv5u+ZzdAS
         smN5yI2h7e0huCNLNGrKUItEpeqRJCQQKJCdN0lSFqzjcn92c/CfmD3Zai6mpv0as8Is
         1XiA==
X-Gm-Message-State: ACrzQf2ho5TepqBA++OoHfqI9TcgqxrqdJ2iLZmp6d6aAUFQP0cclZJG
        7PX37ISyBWH5jBxbW11nS2StYKPWO/wHjqfmmYot2A==
X-Google-Smtp-Source: AMsMyM5a7FU5KmKrYCS7NyITMK5hLN7jbu9zO7BNjotlJsvRWbq8xR+J4CuOkqqNPZliGMdXTgLbQ1dhQilpFE9P3f8=
X-Received: by 2002:a17:903:246:b0:179:96b5:1ad2 with SMTP id
 j6-20020a170903024600b0017996b51ad2mr14165530plh.37.1666276852874; Thu, 20
 Oct 2022 07:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221018145348.4051809-1-amit.pundir@linaro.org>
 <CAPDyKFoBMB9OMUrcoPCV0of1fj2dimEwPyHGW=ydjJ2M0ubM8Q@mail.gmail.com>
 <20221020093057.zrrvxlgghn27bpes@bogus> <CAMi1Hd05PkEJcHqHpQX-X6B2oR4250_pHPjkd2-54JWgKsYx0Q@mail.gmail.com>
In-Reply-To: <CAMi1Hd05PkEJcHqHpQX-X6B2oR4250_pHPjkd2-54JWgKsYx0Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Oct 2022 16:40:15 +0200
Message-ID: <CAPDyKFo=w-ET62c-B6=qSpkZm-V9LmBuVRy38GzX_UAjQhX6oA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qrb5165-rb5: Disable cpuidle states
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 at 16:09, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Thu, 20 Oct 2022 at 15:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, Oct 19, 2022 at 01:57:34PM +0200, Ulf Hansson wrote:
> > > On Tue, 18 Oct 2022 at 16:53, Amit Pundir <amit.pundir@linaro.org> wrote:
> > > >
> > > > Disable cpuidle states for RB5. These cpuidle states
> > > > made the device highly unstable and it runs into the
> > > > following crash frequently:
> > > >
> > > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > > >
> > > > Fixes: 32bc936d7321 ("arm64: dts: qcom: sm8250: Add cpuidle states")
> > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > index cc003535a3c5..f936c41bfbea 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> > > > @@ -251,6 +251,14 @@ qca639x: qca639x {
> > > >
> > > >  };
> > > >
> > > > +&LITTLE_CPU_SLEEP_0 {
> > > > +       status = "disabled";
> > > > +};
> > > > +
> > > > +&BIG_CPU_SLEEP_0 {
> > > > +       status = "disabled";
> > > > +};
> > > > +
> > > >  &adsp {
> > > >         status = "okay";
> > > >         firmware-name = "qcom/sm8250/adsp.mbn";
> > > > --
> > > > 2.25.1
> > >
> > > Disabling the CPU idlestates, will revert us back to using only the WFI state.
> > >
> > > An option that probably works too is to just drop the idlestate for
> > > the CPU cluster. Would you mind trying the below and see if that works
> > > too?
> > >
> >
> > Indeed this is was I suggested to check initially. But I was surprised to
> > see IIUC, Amit just disabled CPU states with above change and got it working.
> > So it is not cluster state alone causing the issue, is it somehow presence
> > of both cpu and cluster states ? Am I missing something here.
> >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > index c32227ea40f9..c707a49e8001 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > @@ -700,7 +700,6 @@ CPU_PD7: cpu7 {
> > >
> > >                 CLUSTER_PD: cpu-cluster0 {
> > >                         #power-domain-cells = <0>;
> > > -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> >
> > How about just marking CLUSTER_SLEEP_0 state disabled ? That looks cleaner
> > than deleting this domain-idle-states property here. Also not sure if DTS
> > warnings will appear if you delete this ?
>
> Hi, I did try disabling CLUSTER_SLEEP_0: cluster-sleep-0 {} in
> domain-idle-states {} but that didn't help. That's why I end up
> disabling individual cpu states in idle-states {}.

Yep, this boils down to the fact that genpd doesn't check whether the
domain-idle-state is disabled by using of_device_is_available(). See
genpd_iterate_idle_states().

That said, I suggest we go with the above one-line change. It may not
be as clean as it could be, but certainly easy to revert when the
support for it has been added in a newer kernel.

Amit, do you want me to post a new patch or do you prefer to re-spin
your patch? It doesn't matter to me.

Kind regards
Uffe
