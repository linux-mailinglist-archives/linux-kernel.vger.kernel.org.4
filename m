Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E46D359F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 07:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDBFfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBFfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 01:35:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897B1B368
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 22:35:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q19so23098348wrc.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680413738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zF3oKohIhhLJKd1QNch/n6u1agXLLOguv1dKAbb5oNs=;
        b=Wb9rIRHuELGn/5H8BgxsO7O97HeB5oiDDKs2v2wKk0oXqzmLMP76NQyp03Y9WHn7NM
         uf6O+fP4/BxYcikXrHUwTp6+ZALpBf44S3EgeVbPo3hPbQPx7U9CrrMTuzKDBbRMlD7K
         jxxMD5QA7YFkLycwUYs1+MA0IOsvjZ8hXIt8QsrOA2vKPhq26MLK1OTRRJZkiSc9Bjmp
         oVjiVqMxVR8gDDOejKUTF11OEaVJSxiynd3pk8Zwiltl6JyZBPw36fi5v3eFSFnoGXKx
         jh6CLBvnRsfqC3hK+Vgsux4yIdpCMLWv90KxEMw7OoDEQCbt8q+0QBLNq2F0/A3pBdBx
         nV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680413738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zF3oKohIhhLJKd1QNch/n6u1agXLLOguv1dKAbb5oNs=;
        b=qOBSsYRfdL+nHn99UWW1OP/Dw/CCna5YMbZqCkAqP1j0gijAtO+Euu3gT2Dr9cBTg+
         PVw1+3u7TCkjQjI4QF6QUjeEK31tGtkcWa/qUKANe9Qq/U9iQaDMCCHkI+wB+rzb5w5b
         m/1gybAIxKx1xhQNILOtBsmb55W1Xbx5qnvz7FzF8rFdBg3xYI748xExuoMk68b8ocVq
         Hpllg3EE4VrxXXE+6WeVfNDQYBS9z+5zKwxO65+Y6jX+sY5NL8HbRuioZ/k7HgKB/yPo
         6OoryDtFuK71/kGnHJAJgR+R/6E75UrTkdoRZrE2Ha60E/KL343z/YBX2YqV10Fl8YN2
         JDeg==
X-Gm-Message-State: AAQBX9fK4mIAIFkzzSbalN0bWqfvCtvdRiQ+sxELjDpXcwUg6pjKRTbN
        68HbQjQR0enGZvjToalFw1KGu657exA8QNyWgoZyAQ==
X-Google-Smtp-Source: AKy350Yvj3z/JViDBysPD9wGuatiM+Z9teHEtvB8EXqIgjRI+UzWAYBpYdg92tH0fX0ytHcyXVCOvCmIotcGqT+cz88=
X-Received: by 2002:a05:6000:5c1:b0:2d7:9771:fc4b with SMTP id
 bh1-20020a05600005c100b002d79771fc4bmr4303491wrb.5.1680413738137; Sat, 01 Apr
 2023 22:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230330193303.612475-1-bhupesh.sharma@linaro.org>
 <0ff99bb5-4792-270d-b03e-2638939f160f@linaro.org> <CAH=2NtzPReiUHuEAW8PsQJvNzOYvb71pZ7SWRbThWdLT7_a0ug@mail.gmail.com>
 <e5b758ed-f279-ecc3-3be4-039c5a19b212@linaro.org>
In-Reply-To: <e5b758ed-f279-ecc3-3be4-039c5a19b212@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sun, 2 Apr 2023 11:05:26 +0530
Message-ID: <CAH=2NtzXjgQEaTDVZip6GEHhterker2B3c+w_4A5J4W_LDTctA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
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

On Sun, 2 Apr 2023 at 01:28, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 01/04/2023 21:26, Bhupesh Sharma wrote:
> > Hi Konrad,
> >
> > On Sat, 1 Apr 2023 at 17:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 30.03.2023 21:33, Bhupesh Sharma wrote:
> >>> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
> >>>
> >>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> >>> ---
> >>> Changes since v1:
> >>> - v1 can be viewed here: https://lore.kernel.org/lkml/e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org
> >>> - Addressed Konrad's comments on v1 and added GDHS and Power Collapse
> >>>    cluster power states.
> >>>
> >>>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 136 +++++++++++++++++++++++++++
> >>>   1 file changed, 136 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> index 2a51c938bbcb..b63395d476ed 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> >>> @@ -45,6 +45,8 @@ CPU0: cpu@0 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_0>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 0>;
> >>> +                     power-domains = <&CPU_PD0>;
> >>> +                     power-domain-names = "psci";
> >>>                        L2_0: l2-cache {
> >>>                                compatible = "cache";
> >>>                                cache-level = <2>;
> >>> @@ -61,6 +63,8 @@ CPU1: cpu@1 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_0>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 0>;
> >>> +                     power-domains = <&CPU_PD1>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                CPU2: cpu@2 {
> >>> @@ -73,6 +77,8 @@ CPU2: cpu@2 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_0>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 0>;
> >>> +                     power-domains = <&CPU_PD2>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                CPU3: cpu@3 {
> >>> @@ -85,6 +91,8 @@ CPU3: cpu@3 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_0>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 0>;
> >>> +                     power-domains = <&CPU_PD3>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                CPU4: cpu@100 {
> >>> @@ -97,6 +105,8 @@ CPU4: cpu@100 {
> >>>                        dynamic-power-coefficient = <282>;
> >>>                        next-level-cache = <&L2_1>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 1>;
> >>> +                     power-domains = <&CPU_PD4>;
> >>> +                     power-domain-names = "psci";
> >>>                        L2_1: l2-cache {
> >>>                                compatible = "cache";
> >>>                                cache-level = <2>;
> >>> @@ -113,6 +123,8 @@ CPU5: cpu@101 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_1>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 1>;
> >>> +                     power-domains = <&CPU_PD5>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                CPU6: cpu@102 {
> >>> @@ -125,6 +137,8 @@ CPU6: cpu@102 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_1>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 1>;
> >>> +                     power-domains = <&CPU_PD6>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                CPU7: cpu@103 {
> >>> @@ -137,6 +151,8 @@ CPU7: cpu@103 {
> >>>                        enable-method = "psci";
> >>>                        next-level-cache = <&L2_1>;
> >>>                        qcom,freq-domain = <&cpufreq_hw 1>;
> >>> +                     power-domains = <&CPU_PD7>;
> >>> +                     power-domain-names = "psci";
> >>>                };
> >>>
> >>>                cpu-map {
> >>> @@ -176,6 +192,68 @@ core3 {
> >>>                                };
> >>>                        };
> >>>                };
> >>> +
> >>> +             idle-states {
> >>> +                     entry-method = "psci";
> >>> +
> >>> +                     LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> >>> +                             compatible = "arm,idle-state";
> >>> +                             idle-state-name = "silver-rail-power-collapse";
> >>> +                             arm,psci-suspend-param = <0x40000003>;
> >>> +                             entry-latency-us = <290>;
> >>> +                             exit-latency-us = <376>;
> >>> +                             min-residency-us = <1182>;
> >>> +                             local-timer-stop;
> >>> +                     };
> >>> +
> >>> +                     BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> >>> +                             compatible = "arm,idle-state";
> >>> +                             idle-state-name = "gold-rail-power-collapse";
> >>> +                             arm,psci-suspend-param = <0x40000003>;
> >>> +                             entry-latency-us = <297>;
> >>> +                             exit-latency-us = <324>;
> >>> +                             min-residency-us = <1110>;
> >>> +                             local-timer-stop;
> >>> +                     };
> >>> +             };
> >>> +
> >>> +             domain-idle-states {
> >>> +                     CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
> >>> +                             /* GDHS */
> >>> +                             compatible = "domain-idle-state";
> >>> +                             arm,psci-suspend-param = <0x40000022>;
> >> This 0x22 ending seems very sus.
> >>
> >> The last nibble represents the core-level power state and the
> >> penultimate one represents the same at cluster level. A value
> >> of 2 in that cluster nibble is actually undefined by the PSCI spec,
> >> whereas the value of 4 (as you have in all of the other idle
> >> states, including D3G for the perf cluster) corresponds to
> >> "Retention", so unless there's a very weird nuance in the
> >> TZ for this SoC, it should probably end in 0x42.
> >>
> >> Otherwise I think this LGTM now!
> >
> > I am also learning by experiment about the exact values to use here,
> > as the only ready reckoner of how these values are calculated, seems
> > to be available via [1].
> >
> > Also it seems the downstream code uses the following approach to
> > calculate the LPM state suspend-param, which for example for
> > CLUSTER_0_SLEEP_1 states turns out to be:
> >
> >      state_id = get_cluster_id(cpu->parent, &affinity_level, from_idle); = 0x40
> >      power_state = (is-reset << 30) = 0x40000000
> >      affinity_level = (affinity level & 0x3) << 24 = 0x1000000
> >      state_id += power_state + affinity_level + psci_id;
> >
> >      = 0x40000000 + 0x1000000 + 0x40 + 0x4 = 0x41000044
> >
> > For the D3G cases as well, I just used the 'qcom,psci-mode = <2>'
> > value as provided in downstream code (see [2]), for the overall
> > calculations.
> >
> > Also, the only usage of D3G state I could find upstream (in qcom dtsi
> > files0 is for 'msm8916' (see [3]), which also uses the value with
> > ending 0x2 -> 'arm,psci-suspend-param = <0x41000032>'
>
> D3G has min-child-idx = 1, so the end PSCI param should be 0x41000023
> D3 is 0x41000043

Ok, let me recheck at my end as well.

Thanks
Bhupesh
