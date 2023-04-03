Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99396D421C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDCKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjDCKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:33:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA8DBC6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:33:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o20so26881447ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680518028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfUo0fru+wd28kIFWm+j4w66y5teANTbx3Vvk6eQF5U=;
        b=yoohv5e/xezbYEWRo56wL/ynszQm5bdS5XLo/KUPuBZOPPsla64IfOl2RN6zVhz+RD
         En1LMcOxAHTu1RQQdNTSNJp7033t1mdrIqTpvNpADI0shTH6gxJ1ebhEuSpSZXKR1ckh
         pHFvS06oMVmn+QME7LzEjj82B1cAhYRG12xhifmaAe4yXWyak6a817f7RYCiCsror9AE
         T0ipA5YYjeLVA1oS1k5YULHCFEYv9I8hTTKezcFIz7Pb/0VdwJ7CLueSZ7on8ohX8GWR
         QCCGvRJXzsESHdHI+93UQf82ejaZsgXF988e8LxU5D6m6sMnlVO3sl6dmyI4P7MvySiD
         SR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680518028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfUo0fru+wd28kIFWm+j4w66y5teANTbx3Vvk6eQF5U=;
        b=KXz1+5rgs2Od8QG/X/fNSNrEtdPSuLlXS5UKmtzklzCLjrF+eWnp1kA4vo2JQRLC3R
         YVNh/DrmqVF0HIG2znij3Wv6ndjBVGeLoyUdyxkJhQwZG6MOrL0LmGCITCx4Y3C9DBIV
         30bGh7JC7c8faBZbMQsQ6Fx233YARl8P581ZSQyb3ZAoTEqQhTkMqylbGp+IVfr11nSF
         X+7sDasQeRuHdlQpMGOWCSKK+ofI9XEAqdS4OMWSPgl/v+g7344+BqrHtjI1v5HQhduB
         gzsZWrKfvtFmxbUGmDBVSDrC0sZPO2RgNgScIopARWlRmTawkwkyMP+LM09c1xtDTkRI
         vlog==
X-Gm-Message-State: AAQBX9d8EctAR4F27rvjdrcl7Sv/B9wY/iMbryf7687qlYUlnvEsVdq6
        hd75yyKtm6tcSwD3Vu0wxiHXzvXs4WRvv1G5zGE=
X-Google-Smtp-Source: AKy350ar/Ubc0zKI9OpT54QLs4a1MwS2rycinNgMruZXM0+oic2ZCkjMi1NRCACCyCzC8UXkvYz3uQ==
X-Received: by 2002:a2e:95d4:0:b0:29c:9207:d0a7 with SMTP id y20-20020a2e95d4000000b0029c9207d0a7mr10881352ljh.43.1680518028244;
        Mon, 03 Apr 2023 03:33:48 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id m14-20020a2e910e000000b002959d2cc975sm1684870ljg.37.2023.04.03.03.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:33:47 -0700 (PDT)
Message-ID: <9e059c75-2854-45ba-9e0b-df69dd355bbf@linaro.org>
Date:   Mon, 3 Apr 2023 12:33:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND PATCH v2 1/1] arm64: dts: qcom: sm6115: Add CPU
 idle-states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org
References: <20230330193303.612475-1-bhupesh.sharma@linaro.org>
 <0ff99bb5-4792-270d-b03e-2638939f160f@linaro.org>
 <CAH=2NtzPReiUHuEAW8PsQJvNzOYvb71pZ7SWRbThWdLT7_a0ug@mail.gmail.com>
 <e5b758ed-f279-ecc3-3be4-039c5a19b212@linaro.org>
 <CAH=2NtzXjgQEaTDVZip6GEHhterker2B3c+w_4A5J4W_LDTctA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtzXjgQEaTDVZip6GEHhterker2B3c+w_4A5J4W_LDTctA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.04.2023 07:35, Bhupesh Sharma wrote:
> On Sun, 2 Apr 2023 at 01:28, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 01/04/2023 21:26, Bhupesh Sharma wrote:
>>> Hi Konrad,
>>>
>>> On Sat, 1 Apr 2023 at 17:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 30.03.2023 21:33, Bhupesh Sharma wrote:
>>>>> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
>>>>>
>>>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>>>> ---
>>>>> Changes since v1:
>>>>> - v1 can be viewed here: https://lore.kernel.org/lkml/e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org
>>>>> - Addressed Konrad's comments on v1 and added GDHS and Power Collapse
>>>>>    cluster power states.
>>>>>
>>>>>   arch/arm64/boot/dts/qcom/sm6115.dtsi | 136 +++++++++++++++++++++++++++
>>>>>   1 file changed, 136 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> index 2a51c938bbcb..b63395d476ed 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>>> @@ -45,6 +45,8 @@ CPU0: cpu@0 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_0>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 0>;
>>>>> +                     power-domains = <&CPU_PD0>;
>>>>> +                     power-domain-names = "psci";
>>>>>                        L2_0: l2-cache {
>>>>>                                compatible = "cache";
>>>>>                                cache-level = <2>;
>>>>> @@ -61,6 +63,8 @@ CPU1: cpu@1 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_0>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 0>;
>>>>> +                     power-domains = <&CPU_PD1>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                CPU2: cpu@2 {
>>>>> @@ -73,6 +77,8 @@ CPU2: cpu@2 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_0>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 0>;
>>>>> +                     power-domains = <&CPU_PD2>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                CPU3: cpu@3 {
>>>>> @@ -85,6 +91,8 @@ CPU3: cpu@3 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_0>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 0>;
>>>>> +                     power-domains = <&CPU_PD3>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                CPU4: cpu@100 {
>>>>> @@ -97,6 +105,8 @@ CPU4: cpu@100 {
>>>>>                        dynamic-power-coefficient = <282>;
>>>>>                        next-level-cache = <&L2_1>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 1>;
>>>>> +                     power-domains = <&CPU_PD4>;
>>>>> +                     power-domain-names = "psci";
>>>>>                        L2_1: l2-cache {
>>>>>                                compatible = "cache";
>>>>>                                cache-level = <2>;
>>>>> @@ -113,6 +123,8 @@ CPU5: cpu@101 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_1>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 1>;
>>>>> +                     power-domains = <&CPU_PD5>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                CPU6: cpu@102 {
>>>>> @@ -125,6 +137,8 @@ CPU6: cpu@102 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_1>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 1>;
>>>>> +                     power-domains = <&CPU_PD6>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                CPU7: cpu@103 {
>>>>> @@ -137,6 +151,8 @@ CPU7: cpu@103 {
>>>>>                        enable-method = "psci";
>>>>>                        next-level-cache = <&L2_1>;
>>>>>                        qcom,freq-domain = <&cpufreq_hw 1>;
>>>>> +                     power-domains = <&CPU_PD7>;
>>>>> +                     power-domain-names = "psci";
>>>>>                };
>>>>>
>>>>>                cpu-map {
>>>>> @@ -176,6 +192,68 @@ core3 {
>>>>>                                };
>>>>>                        };
>>>>>                };
>>>>> +
>>>>> +             idle-states {
>>>>> +                     entry-method = "psci";
>>>>> +
>>>>> +                     LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
>>>>> +                             compatible = "arm,idle-state";
>>>>> +                             idle-state-name = "silver-rail-power-collapse";
>>>>> +                             arm,psci-suspend-param = <0x40000003>;
>>>>> +                             entry-latency-us = <290>;
>>>>> +                             exit-latency-us = <376>;
>>>>> +                             min-residency-us = <1182>;
>>>>> +                             local-timer-stop;
>>>>> +                     };
>>>>> +
>>>>> +                     BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
>>>>> +                             compatible = "arm,idle-state";
>>>>> +                             idle-state-name = "gold-rail-power-collapse";
>>>>> +                             arm,psci-suspend-param = <0x40000003>;
>>>>> +                             entry-latency-us = <297>;
>>>>> +                             exit-latency-us = <324>;
>>>>> +                             min-residency-us = <1110>;
>>>>> +                             local-timer-stop;
>>>>> +                     };
>>>>> +             };
>>>>> +
>>>>> +             domain-idle-states {
>>>>> +                     CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
>>>>> +                             /* GDHS */
>>>>> +                             compatible = "domain-idle-state";
>>>>> +                             arm,psci-suspend-param = <0x40000022>;
>>>> This 0x22 ending seems very sus.
>>>>
>>>> The last nibble represents the core-level power state and the
>>>> penultimate one represents the same at cluster level. A value
>>>> of 2 in that cluster nibble is actually undefined by the PSCI spec,
>>>> whereas the value of 4 (as you have in all of the other idle
>>>> states, including D3G for the perf cluster) corresponds to
>>>> "Retention", so unless there's a very weird nuance in the
>>>> TZ for this SoC, it should probably end in 0x42.
>>>>
>>>> Otherwise I think this LGTM now!
>>>
>>> I am also learning by experiment about the exact values to use here,
>>> as the only ready reckoner of how these values are calculated, seems
>>> to be available via [1].
>>>
>>> Also it seems the downstream code uses the following approach to
>>> calculate the LPM state suspend-param, which for example for
>>> CLUSTER_0_SLEEP_1 states turns out to be:
>>>
>>>      state_id = get_cluster_id(cpu->parent, &affinity_level, from_idle); = 0x40
>>>      power_state = (is-reset << 30) = 0x40000000
>>>      affinity_level = (affinity level & 0x3) << 24 = 0x1000000
>>>      state_id += power_state + affinity_level + psci_id;
>>>
>>>      = 0x40000000 + 0x1000000 + 0x40 + 0x4 = 0x41000044
>>>
>>> For the D3G cases as well, I just used the 'qcom,psci-mode = <2>'
>>> value as provided in downstream code (see [2]), for the overall
>>> calculations.>>>
>>> Also, the only usage of D3G state I could find upstream (in qcom dtsi
>>> files0 is for 'msm8916' (see [3]), which also uses the value with
>>> ending 0x2 -> 'arm,psci-suspend-param = <0x41000032>'
Yes, the lowest '2' must be correct. I am concerned about the one above
it (val & 0xf0).

>>
>> D3G has min-child-idx = 1, so the end PSCI param should be 0x41000023
>> D3 is 0x41000043
Not sure what that has to do with it. Looking at ancient kernel doc:

qcom,min-child-idx: The minimum level that a child CPU should be in
	before this level can be chosen. This property is required for all
        non-default level.

And it looks like the downstream code ensures that we don't just jump
from "CPU running" to "CPU [some stage of] power collapse".


So it looks like this patch may be good after all.. Can you verify with
sysfs/debugfs that this idle state is being entered correctly?

Konrad
> 
> Ok, let me recheck at my end as well.
> 
> Thanks
> Bhupesh
