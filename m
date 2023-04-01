Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA1E6D331F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDAS0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:26:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FA01A47F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:26:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so15778349wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680373579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BmCy6VstbUOc3/xi1baviqGZ3ffqW2yzhLuCH0NJ8cM=;
        b=iRNAbZcnGm4v/2nYJgxYOjSIwf7SFo/i6FI52KvRKcGnrsDxGXxsfOwnqtiknn9QY1
         aKVafJH8a4E/i/kJwX48a/+cpclFy90mcX4WR/9o+wvwL7ihU3jPku+S2hmBfgjdtlz3
         T4Oc+gQnaxV0bgFJL7G1POnMZyxgnMgxQMwGYfxLw7NntnQzKX4c2PJEIur5sAB+Z8sN
         gE9FmaDn3N84PUjXt6hNug1cLfA8T9x2LZEzIPaIRNU3ymkZe2TR/G0kgl4klGPOH2ru
         LII5E6x4GLPdCDWR4vPORkL3+cB57U5XnNjydDabLVo2Ji86LhladCF4xNrLxxpEe4+Z
         clqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680373579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmCy6VstbUOc3/xi1baviqGZ3ffqW2yzhLuCH0NJ8cM=;
        b=ZeuQvE4Phss1u5ZIXDI448QFeHE+m7JH7hfx+Kx+sAHoBFbobabz2Pyih/Mbrya6It
         Z6MVvhqrxZtjYxTIZMIxtLXhDzD0mjwrjFc5zdvKQavmkwXcJmAzyMsBpSjt3OVFd+dc
         11gVPbUy0wqJK+BZvZ4hTPRbcJ3YAGSvS+qOfogJj4RYg84nN8r+AiViBRjfXTXzvLyj
         cMkfb9Zyea25ovcAMdKdQnOs5MPjaYam5Wt6nL59tKNRYGjg+Y8BtpifXvuj/xCokWlG
         CdSwm+rmFCH8fIezHkRWjQGaxfxOAIcJNjPDKCrJstp8t39Q0m3h4YMNkY5FQXYRfmYN
         hGrQ==
X-Gm-Message-State: AO0yUKWpLYDaRp+q+DXzJ97PTfopG9BTWQRAG6Z4n6Wnb7W9tfnkPasC
        FptMeizuYh6RGdq4K1Msg26yI0QS6GKcp8xgRVeUMQ==
X-Google-Smtp-Source: AK7set+Q74Lb+HjO5VFRCckLXBV9Mi5Sr+RT30qJcFIipQMV3ifbubQ+xOe7udGHXnJl3PfLadOPAgA3T7fLi0fBnJE=
X-Received: by 2002:a7b:ce16:0:b0:3ed:6afb:5272 with SMTP id
 m22-20020a7bce16000000b003ed6afb5272mr7198406wmc.8.1680373578974; Sat, 01 Apr
 2023 11:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230330193303.612475-1-bhupesh.sharma@linaro.org> <0ff99bb5-4792-270d-b03e-2638939f160f@linaro.org>
In-Reply-To: <0ff99bb5-4792-270d-b03e-2638939f160f@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sat, 1 Apr 2023 23:56:07 +0530
Message-ID: <CAH=2NtzPReiUHuEAW8PsQJvNzOYvb71pZ7SWRbThWdLT7_a0ug@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Sat, 1 Apr 2023 at 17:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 30.03.2023 21:33, Bhupesh Sharma wrote:
> > Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> > Changes since v1:
> > - v1 can be viewed here: https://lore.kernel.org/lkml/e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org
> > - Addressed Konrad's comments on v1 and added GDHS and Power Collapse
> >   cluster power states.
> >
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 136 +++++++++++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 2a51c938bbcb..b63395d476ed 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -45,6 +45,8 @@ CPU0: cpu@0 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > +                     power-domains = <&CPU_PD0>;
> > +                     power-domain-names = "psci";
> >                       L2_0: l2-cache {
> >                               compatible = "cache";
> >                               cache-level = <2>;
> > @@ -61,6 +63,8 @@ CPU1: cpu@1 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > +                     power-domains = <&CPU_PD1>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU2: cpu@2 {
> > @@ -73,6 +77,8 @@ CPU2: cpu@2 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > +                     power-domains = <&CPU_PD2>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU3: cpu@3 {
> > @@ -85,6 +91,8 @@ CPU3: cpu@3 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_0>;
> >                       qcom,freq-domain = <&cpufreq_hw 0>;
> > +                     power-domains = <&CPU_PD3>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU4: cpu@100 {
> > @@ -97,6 +105,8 @@ CPU4: cpu@100 {
> >                       dynamic-power-coefficient = <282>;
> >                       next-level-cache = <&L2_1>;
> >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > +                     power-domains = <&CPU_PD4>;
> > +                     power-domain-names = "psci";
> >                       L2_1: l2-cache {
> >                               compatible = "cache";
> >                               cache-level = <2>;
> > @@ -113,6 +123,8 @@ CPU5: cpu@101 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_1>;
> >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > +                     power-domains = <&CPU_PD5>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU6: cpu@102 {
> > @@ -125,6 +137,8 @@ CPU6: cpu@102 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_1>;
> >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > +                     power-domains = <&CPU_PD6>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               CPU7: cpu@103 {
> > @@ -137,6 +151,8 @@ CPU7: cpu@103 {
> >                       enable-method = "psci";
> >                       next-level-cache = <&L2_1>;
> >                       qcom,freq-domain = <&cpufreq_hw 1>;
> > +                     power-domains = <&CPU_PD7>;
> > +                     power-domain-names = "psci";
> >               };
> >
> >               cpu-map {
> > @@ -176,6 +192,68 @@ core3 {
> >                               };
> >                       };
> >               };
> > +
> > +             idle-states {
> > +                     entry-method = "psci";
> > +
> > +                     LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> > +                             compatible = "arm,idle-state";
> > +                             idle-state-name = "silver-rail-power-collapse";
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                             entry-latency-us = <290>;
> > +                             exit-latency-us = <376>;
> > +                             min-residency-us = <1182>;
> > +                             local-timer-stop;
> > +                     };
> > +
> > +                     BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> > +                             compatible = "arm,idle-state";
> > +                             idle-state-name = "gold-rail-power-collapse";
> > +                             arm,psci-suspend-param = <0x40000003>;
> > +                             entry-latency-us = <297>;
> > +                             exit-latency-us = <324>;
> > +                             min-residency-us = <1110>;
> > +                             local-timer-stop;
> > +                     };
> > +             };
> > +
> > +             domain-idle-states {
> > +                     CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
> > +                             /* GDHS */
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x40000022>;
> This 0x22 ending seems very sus.
>
> The last nibble represents the core-level power state and the
> penultimate one represents the same at cluster level. A value
> of 2 in that cluster nibble is actually undefined by the PSCI spec,
> whereas the value of 4 (as you have in all of the other idle
> states, including D3G for the perf cluster) corresponds to
> "Retention", so unless there's a very weird nuance in the
> TZ for this SoC, it should probably end in 0x42.
>
> Otherwise I think this LGTM now!

I am also learning by experiment about the exact values to use here,
as the only ready reckoner of how these values are calculated, seems
to be available via [1].

Also it seems the downstream code uses the following approach to
calculate the LPM state suspend-param, which for example for
CLUSTER_0_SLEEP_1 states turns out to be:

    state_id = get_cluster_id(cpu->parent, &affinity_level, from_idle); = 0x40
    power_state = (is-reset << 30) = 0x40000000
    affinity_level = (affinity level & 0x3) << 24 = 0x1000000
    state_id += power_state + affinity_level + psci_id;

    = 0x40000000 + 0x1000000 + 0x40 + 0x4 = 0x41000044

For the D3G cases as well, I just used the 'qcom,psci-mode = <2>'
value as provided in downstream code (see [2]), for the overall
calculations.

Also, the only usage of D3G state I could find upstream (in qcom dtsi
files0 is for 'msm8916' (see [3]), which also uses the value with
ending 0x2 -> 'arm,psci-suspend-param = <0x41000032>'

[1]. https://patchwork.kernel.org/project/linux-arm-msm/patch/20201221002907.2870059-3-danny@kdrag0n.dev/#23857409
[2]. https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/tags/android-11.0.0_r0.56/qcom/bengal-pm.dtsi#127
[3]. https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/msm8916.dtsi#L209

Thanks,
Bhupesh

> > +                             entry-latency-us = <360>;
> > +                             exit-latency-us = <421>;
> > +                             min-residency-us = <782>;
> > +                     };
> > +
> > +                     CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
> > +                             /* Power Collapse */
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x41000044>;
> > +                             entry-latency-us = <800>;
> > +                             exit-latency-us = <2118>;
> > +                             min-residency-us = <7376>;
> > +                     };
> > +
> > +                     CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
> > +                             /* GDHS */
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x40000042>;
> > +                             entry-latency-us = <314>;
> > +                             exit-latency-us = <345>;
> > +                             min-residency-us = <660>;
> > +                     };
> > +
> > +                     CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
> > +                             /* Power Collapse */
> > +                             compatible = "domain-idle-state";
> > +                             arm,psci-suspend-param = <0x41000044>;
> > +                             entry-latency-us = <640>;
> > +                             exit-latency-us = <1654>;
> > +                             min-residency-us = <8094>;
> > +                     };
> > +             };
> >       };
> >
> >       firmware {
> > @@ -199,6 +277,64 @@ pmu {
> >       psci {
> >               compatible = "arm,psci-1.0";
> >               method = "smc";
> > +
> > +             CPU_PD0: power-domain-cpu0 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_0_PD>;
> > +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD1: power-domain-cpu1 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_0_PD>;
> > +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD2: power-domain-cpu2 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_0_PD>;
> > +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD3: power-domain-cpu3 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_0_PD>;
> > +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD4: power-domain-cpu4 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_1_PD>;
> > +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD5: power-domain-cpu5 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_1_PD>;
> > +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD6: power-domain-cpu6 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_1_PD>;
> > +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CPU_PD7: power-domain-cpu7 {
> > +                     #power-domain-cells = <0>;
> > +                     power-domains = <&CLUSTER_1_PD>;
> > +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
> > +             };
> > +
> > +             CLUSTER_0_PD: power-domain-cpu-cluster0 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&CLUSTER_0_SLEEP_0>, <&CLUSTER_0_SLEEP_1>;
> > +             };
> > +
> > +             CLUSTER_1_PD: power-domain-cpu-cluster1 {
> > +                     #power-domain-cells = <0>;
> > +                     domain-idle-states = <&CLUSTER_1_SLEEP_0>, <&CLUSTER_1_SLEEP_1>;
> > +             };
> >       };
> >
> >       reserved_memory: reserved-memory {
