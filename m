Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A98602DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiJROKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJROKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:10:07 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD766A4A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:10:00 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-132af5e5543so16915312fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFEBNR5Cs6lFyz1sMa6cjqpnxQazEOZFCO9dkP/ZaiQ=;
        b=QZFx9U0TQj5pwsZKzZ61LIvtF6W/Q92yWWbcUS5c+cxRn1tL9yJ6U2hGl+FrGfi7n0
         4RY8LoPkip8d2xVxr/Qa+Wl4FuW4ZM9A8r5eW26MMGV99owH3JU/Ue09mHsUgARDdW7G
         zlT3RG2mkEaaNbg8+ZvD5iwpxAwhZD8yFMOx9N3aPvMvvUt/7+hzAoNRm4w45L4eY3Uc
         kypeWRpYDpTYNNci58O0qdxIdocsQgykQUlH7TLinG3lgAQwofURlRspC54hVu6Q9kfE
         l5EYmYpPQiFjIgcj0HsCIs08Rl5noZcZL/Xp2pT+NakSgFEyL+vop+akot8FWUOb9KNz
         fJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFEBNR5Cs6lFyz1sMa6cjqpnxQazEOZFCO9dkP/ZaiQ=;
        b=q/HjQsKqGj67s0IemyrtudVpCnKoIw7mBysKJUA1OQ2c6B/ce6uYpHWiSpgmh3u4bG
         7Xu4RVaOlK/Oou78Mys7Z3nW35wcmJy9J86BBt3ZNd6q2fEu2ygyYCJqPmzjaVP8KRdO
         5BI8D9e5/VnLH+2V+WLBM9NP/kaGD6QMrKrZ2MxIgO1ADu7XtLCCyoOVKX46rhmiGB1p
         MRhqxEpa1UmW2DmvoyeQaYsdDACpk40RMsDuL9aGBksB+9yvBtrNSWIhVRJfZqxOi68I
         l95UXU2czrTP9RxwHMfPbHavRXsgR8loDHwpW2L7g9K21agb29a4g0pZGitzp5LbV9H0
         /4fQ==
X-Gm-Message-State: ACrzQf1S+dsrVHCMQwRuil+v/Mi1lSjqs0ENcK1vvfRL36NtSJg8mM79
        J9Ki+UdTlja+1b2tCAMmc163rgPVPmenfRx4Zw7mjw==
X-Google-Smtp-Source: AMsMyM5MkE65OUJ+R+5WvfENsxNfj4F8w30eMaL2nOD8ed1Fjw9HxC8M8UQ4CV5Ig535cp4+IJ4IOVMVl8wCiImeGWg=
X-Received: by 2002:a05:6870:4411:b0:136:71ed:c7cd with SMTP id
 u17-20020a056870441100b0013671edc7cdmr1752021oah.108.1666102198983; Tue, 18
 Oct 2022 07:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221017164005.2622934-1-amit.pundir@linaro.org>
 <20221017201654.u7x5vrjsad653kma@bogus> <CAPDyKFqMLHhzFzYZ5wB5xTSaHkesp9pxX3QEhT+8XZictUnUaQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqMLHhzFzYZ5wB5xTSaHkesp9pxX3QEhT+8XZictUnUaQ@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 18 Oct 2022 19:39:22 +0530
Message-ID: <CAMi1Hd2Ds3-wZ8sUvSFF0ew1WVsj0vrJAQSpV9WG7YrZcRJh1A@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sm8250: Add cpuidle states"
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 16:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 17 Oct 2022 at 22:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Mon, Oct 17, 2022 at 10:10:05PM +0530, Amit Pundir wrote:
> > > This reverts commit 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7.
> > >
> > > This patch was part of a patch series to add APSS RSC to
> > > Cluster power domain
> > > https://patchwork.kernel.org/project/linux-pm/cover/1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com/
> > > but the rest of the patches in this series got NACKed and didn't land.
> > >
> > > These cpuidle states made RB5 (sm8250) highly unstable and I run into
> > > following crash every now and then:
> > >
> > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > >
> > > I reported this breakage earlier this year as well:
> > > https://lore.kernel.org/all/CAMi1Hd2Sngya_2m2odkjq4fdV8OiiXsFMEX1bb807cWMC7H-sg@mail.gmail.com/
> > > I can confirm that if I cherry-pick the rest of the patches from the
> > > series then I can't reproduce this crash, but I'm not sure when the rest
> > > of the patches are going to land though.
>
> I have been talking to Maulik (offlist) about re-posting the series,
> but apparently she has been too busy to move this forward.
>
> I assume a better option, than reverting, is to get the above series
> merged. If I recall, there were only a few minor comments from me on
> the genpd patch [1]. That said, let me help out and refresh the
> series, I will do it asap!
>
> > >
> > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sm8250.dtsi | 105 ---------------------------
> > >  1 file changed, 105 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > index a5b62cadb129..a2c15da1a450 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > @@ -101,8 +101,6 @@ CPU0: cpu@0 {
> > >                       capacity-dmips-mhz = <448>;
> > >                       dynamic-power-coefficient = <205>;
> > >                       next-level-cache = <&L2_0>;
> > > -                     power-domains = <&CPU_PD0>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > >                       operating-points-v2 = <&cpu0_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -125,8 +123,6 @@ CPU1: cpu@100 {
> > >                       capacity-dmips-mhz = <448>;
> > >                       dynamic-power-coefficient = <205>;
> > >                       next-level-cache = <&L2_100>;
> > > -                     power-domains = <&CPU_PD1>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > >                       operating-points-v2 = <&cpu0_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -146,8 +142,6 @@ CPU2: cpu@200 {
> > >                       capacity-dmips-mhz = <448>;
> > >                       dynamic-power-coefficient = <205>;
> > >                       next-level-cache = <&L2_200>;
> > > -                     power-domains = <&CPU_PD2>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > >                       operating-points-v2 = <&cpu0_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -167,8 +161,6 @@ CPU3: cpu@300 {
> > >                       capacity-dmips-mhz = <448>;
> > >                       dynamic-power-coefficient = <205>;
> > >                       next-level-cache = <&L2_300>;
> > > -                     power-domains = <&CPU_PD3>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > >                       operating-points-v2 = <&cpu0_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -188,8 +180,6 @@ CPU4: cpu@400 {
> > >                       capacity-dmips-mhz = <1024>;
> > >                       dynamic-power-coefficient = <379>;
> > >                       next-level-cache = <&L2_400>;
> > > -                     power-domains = <&CPU_PD4>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > >                       operating-points-v2 = <&cpu4_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -209,8 +199,6 @@ CPU5: cpu@500 {
> > >                       capacity-dmips-mhz = <1024>;
> > >                       dynamic-power-coefficient = <379>;
> > >                       next-level-cache = <&L2_500>;
> > > -                     power-domains = <&CPU_PD5>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > >                       operating-points-v2 = <&cpu4_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -231,8 +219,6 @@ CPU6: cpu@600 {
> > >                       capacity-dmips-mhz = <1024>;
> > >                       dynamic-power-coefficient = <379>;
> > >                       next-level-cache = <&L2_600>;
> > > -                     power-domains = <&CPU_PD6>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > >                       operating-points-v2 = <&cpu4_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -252,8 +238,6 @@ CPU7: cpu@700 {
> > >                       capacity-dmips-mhz = <1024>;
> > >                       dynamic-power-coefficient = <444>;
> > >                       next-level-cache = <&L2_700>;
> > > -                     power-domains = <&CPU_PD7>;
> > > -                     power-domain-names = "psci";
> > >                       qcom,freq-domain = <&cpufreq_hw 2>;
> > >                       operating-points-v2 = <&cpu7_opp_table>;
> > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > @@ -300,42 +284,6 @@ core7 {
> > >                               };
> > >                       };
> > >               };
> > > -
> > > -             idle-states {
> > > -                     entry-method = "psci";
> > > -
> > > -                     LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > > -                             compatible = "arm,idle-state";
> > > -                             idle-state-name = "silver-rail-power-collapse";
> > > -                             arm,psci-suspend-param = <0x40000004>;
> > > -                             entry-latency-us = <360>;
> > > -                             exit-latency-us = <531>;
> > > -                             min-residency-us = <3934>;
> > > -                             local-timer-stop;
> >
> > If this is temporary fix for some broke firmware or setup, I suggest to
> > just add status = "disabled" for these states. Also worth checking if keeping
> > the cpu states is okay and only cluster state is the issue or everything
> > needs to be disabled. That way it would avoid the churn when re-enabling it.
>
> That's a good option, unless we can get the other series (that fixes
> this issue) merged soon. As stated, I will help to re-spin it and then
> we can take it from there.

Hi Ulf, I just verified over multiple reboots that disabling the
cpuidle states, as suggested by Sudeep, does the trick and I no longer
see the crash.

Do you suggest we wait for the re-spin of the other series or should I
go ahead and submit that RB5 workaround for the time being?

Regards,
Amit Pundir



>
> >
> > --
> > Regards,
> > Sudeep
>
> Kind regards
> Uffe
