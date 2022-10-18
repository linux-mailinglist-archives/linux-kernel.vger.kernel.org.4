Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8E2602E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiJROcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiJROcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:32:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737F8C8945
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:32:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n7so14025395plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DQuHOwGUgODqyp9uJkpdCpkTdVxYtxWYGviiFxTGCBA=;
        b=F2o7bAmT144UUSkHvQdH+P7SpUWbv2xkaIHPTBcNOmJC6duvr6e7P8RgCAeAiucL1X
         9xS3rlCNpqjUR/uPD4VjNEnJaMVlU1o7WOd4ESG15FsHPtk1yGPLZX78nq2KgJQLBxOl
         F/rUVt2rBozLhB0q9ujix/wjuWthbmyJB9fZYpE5ybYJKbsPQQxaIDPEa2BvxAKBYQ6A
         Kmm1aT3BgJFrp6WP0XRHF+8CkVTU0vO/ATAMTRdde/aMxE33ngH+/92FmXbKXBNY00Sg
         G5pMuKoTyKUwpY+lMpkN3W9EtwSxxdVpY4Qzc54QPTUeRmc/g3n/WBXaUvx3EoCZUK1Y
         EKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQuHOwGUgODqyp9uJkpdCpkTdVxYtxWYGviiFxTGCBA=;
        b=cRbp4tEzFXthj1KcR0UootyHR9aLQWcPkiCClxjdVXxEaVti8Q5SEKP0ci17Sy1THl
         eZsgGvVvKObNqDZTA1Ver+5tP+BTr4NKrsglEQUNUThscVbMoeItojvw+Xz9Q0+W0yCI
         SfIRRHzQzwxAtrFyozofLnGRUjnRtIKO9Ba6asj95wSygD9/layYN7XV0VkDc665ZkUj
         S+ICOL+I+gZfOpSKTnod/Bvc7fTWsINuo+aNd32i5PjR/4f0D9gjRyYGr3SjzxIQJRmc
         RRn2ZKQUv70hGlNyLe/kCwb4cvkbq1j8rQriGgnUOCedolyXSQ0FJNDoX1kKr7XynPNt
         nJtw==
X-Gm-Message-State: ACrzQf0MvnU2ncIr5oXYoCqIiD+wVmT70zXMe2fU+i9u/aexxnLsQ+vs
        D1Ul/1vLbtFhLMqO/TH3D8dJeunTrEKJ1Gd4cOfwUKehd24=
X-Google-Smtp-Source: AMsMyM4hhSUblMcqeKW8A7EDGCzwT7igUrRu1ViuflM+b+udxJSxIpx2FL7YdWE1fpY7tFN98OXiydI9QtnbhnKDhxA=
X-Received: by 2002:a17:902:d714:b0:17f:5813:1df4 with SMTP id
 w20-20020a170902d71400b0017f58131df4mr3450619ply.148.1666103551620; Tue, 18
 Oct 2022 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221017164005.2622934-1-amit.pundir@linaro.org>
 <20221017201654.u7x5vrjsad653kma@bogus> <CAPDyKFqMLHhzFzYZ5wB5xTSaHkesp9pxX3QEhT+8XZictUnUaQ@mail.gmail.com>
 <CAMi1Hd2Ds3-wZ8sUvSFF0ew1WVsj0vrJAQSpV9WG7YrZcRJh1A@mail.gmail.com>
In-Reply-To: <CAMi1Hd2Ds3-wZ8sUvSFF0ew1WVsj0vrJAQSpV9WG7YrZcRJh1A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 18 Oct 2022 16:31:53 +0200
Message-ID: <CAPDyKFqRU8pdgDWa-o6c3gkeKu8AZ=Zkypd7eUF0qUAkOndCxQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: qcom: sm8250: Add cpuidle states"
To:     Amit Pundir <amit.pundir@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2022 at 16:09, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Tue, 18 Oct 2022 at 16:00, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 17 Oct 2022 at 22:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Mon, Oct 17, 2022 at 10:10:05PM +0530, Amit Pundir wrote:
> > > > This reverts commit 32bc936d732171d48c9c8f96c4fa25ac3ed7e1c7.
> > > >
> > > > This patch was part of a patch series to add APSS RSC to
> > > > Cluster power domain
> > > > https://patchwork.kernel.org/project/linux-pm/cover/1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com/
> > > > but the rest of the patches in this series got NACKed and didn't land.
> > > >
> > > > These cpuidle states made RB5 (sm8250) highly unstable and I run into
> > > > following crash every now and then:
> > > >
> > > > [    T1] vreg_l11c_3p3: failed to enable: -ETIMEDOUT
> > > > [    T1] qcom-rpmh-regulator 18200000.rsc:pm8150l-rpmh-regulators: ldo11: devm_regulator_register() failed, ret=-110
> > > > [    T1] qcom-rpmh-regulator: probe of 18200000.rsc:pm8150l-rpmh-regulators failed with error -110
> > > >
> > > > I reported this breakage earlier this year as well:
> > > > https://lore.kernel.org/all/CAMi1Hd2Sngya_2m2odkjq4fdV8OiiXsFMEX1bb807cWMC7H-sg@mail.gmail.com/
> > > > I can confirm that if I cherry-pick the rest of the patches from the
> > > > series then I can't reproduce this crash, but I'm not sure when the rest
> > > > of the patches are going to land though.
> >
> > I have been talking to Maulik (offlist) about re-posting the series,
> > but apparently she has been too busy to move this forward.
> >
> > I assume a better option, than reverting, is to get the above series
> > merged. If I recall, there were only a few minor comments from me on
> > the genpd patch [1]. That said, let me help out and refresh the
> > series, I will do it asap!
> >
> > > >
> > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > ---
> > > >  arch/arm64/boot/dts/qcom/sm8250.dtsi | 105 ---------------------------
> > > >  1 file changed, 105 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > index a5b62cadb129..a2c15da1a450 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > > > @@ -101,8 +101,6 @@ CPU0: cpu@0 {
> > > >                       capacity-dmips-mhz = <448>;
> > > >                       dynamic-power-coefficient = <205>;
> > > >                       next-level-cache = <&L2_0>;
> > > > -                     power-domains = <&CPU_PD0>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > > >                       operating-points-v2 = <&cpu0_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -125,8 +123,6 @@ CPU1: cpu@100 {
> > > >                       capacity-dmips-mhz = <448>;
> > > >                       dynamic-power-coefficient = <205>;
> > > >                       next-level-cache = <&L2_100>;
> > > > -                     power-domains = <&CPU_PD1>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > > >                       operating-points-v2 = <&cpu0_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -146,8 +142,6 @@ CPU2: cpu@200 {
> > > >                       capacity-dmips-mhz = <448>;
> > > >                       dynamic-power-coefficient = <205>;
> > > >                       next-level-cache = <&L2_200>;
> > > > -                     power-domains = <&CPU_PD2>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > > >                       operating-points-v2 = <&cpu0_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -167,8 +161,6 @@ CPU3: cpu@300 {
> > > >                       capacity-dmips-mhz = <448>;
> > > >                       dynamic-power-coefficient = <205>;
> > > >                       next-level-cache = <&L2_300>;
> > > > -                     power-domains = <&CPU_PD3>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > > >                       operating-points-v2 = <&cpu0_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -188,8 +180,6 @@ CPU4: cpu@400 {
> > > >                       capacity-dmips-mhz = <1024>;
> > > >                       dynamic-power-coefficient = <379>;
> > > >                       next-level-cache = <&L2_400>;
> > > > -                     power-domains = <&CPU_PD4>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > > >                       operating-points-v2 = <&cpu4_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -209,8 +199,6 @@ CPU5: cpu@500 {
> > > >                       capacity-dmips-mhz = <1024>;
> > > >                       dynamic-power-coefficient = <379>;
> > > >                       next-level-cache = <&L2_500>;
> > > > -                     power-domains = <&CPU_PD5>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > > >                       operating-points-v2 = <&cpu4_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -231,8 +219,6 @@ CPU6: cpu@600 {
> > > >                       capacity-dmips-mhz = <1024>;
> > > >                       dynamic-power-coefficient = <379>;
> > > >                       next-level-cache = <&L2_600>;
> > > > -                     power-domains = <&CPU_PD6>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > > >                       operating-points-v2 = <&cpu4_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -252,8 +238,6 @@ CPU7: cpu@700 {
> > > >                       capacity-dmips-mhz = <1024>;
> > > >                       dynamic-power-coefficient = <444>;
> > > >                       next-level-cache = <&L2_700>;
> > > > -                     power-domains = <&CPU_PD7>;
> > > > -                     power-domain-names = "psci";
> > > >                       qcom,freq-domain = <&cpufreq_hw 2>;
> > > >                       operating-points-v2 = <&cpu7_opp_table>;
> > > >                       interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> > > > @@ -300,42 +284,6 @@ core7 {
> > > >                               };
> > > >                       };
> > > >               };
> > > > -
> > > > -             idle-states {
> > > > -                     entry-method = "psci";
> > > > -
> > > > -                     LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > > > -                             compatible = "arm,idle-state";
> > > > -                             idle-state-name = "silver-rail-power-collapse";
> > > > -                             arm,psci-suspend-param = <0x40000004>;
> > > > -                             entry-latency-us = <360>;
> > > > -                             exit-latency-us = <531>;
> > > > -                             min-residency-us = <3934>;
> > > > -                             local-timer-stop;
> > >
> > > If this is temporary fix for some broke firmware or setup, I suggest to
> > > just add status = "disabled" for these states. Also worth checking if keeping
> > > the cpu states is okay and only cluster state is the issue or everything
> > > needs to be disabled. That way it would avoid the churn when re-enabling it.
> >
> > That's a good option, unless we can get the other series (that fixes
> > this issue) merged soon. As stated, I will help to re-spin it and then
> > we can take it from there.
>
> Hi Ulf, I just verified over multiple reboots that disabling the
> cpuidle states, as suggested by Sudeep, does the trick and I no longer
> see the crash.
>
> Do you suggest we wait for the re-spin of the other series or should I
> go ahead and submit that RB5 workaround for the time being?

Yes, that seems like a good idea as the problem needs an easy fix for
6.1 and earlier. Please keep me posted.

In the meantime, I will re-spin and submit the series that fixes the
problem correctly, but let's target that series for 6.2.

Kind regards
Uffe
