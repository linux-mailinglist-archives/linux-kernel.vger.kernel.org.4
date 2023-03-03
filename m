Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED616A8E77
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjCCBDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCCBDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:03:47 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62025974
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:03:45 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so1635058lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 17:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677805423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVcKfKkfVkpqpKWoMU97cJ7wcrQbe2kwbZ0geHYwPfc=;
        b=QfIptf0EvVLQAS5irvExaPpbsnT2YI+ih1T4iT+lGvNWtotDA1u8u+wIYJO5frXD5/
         I1Js74psGIzL0wJtbnefGsfcQzrnWetifYDNn6HlEAiG3W7ytrpH0e+fID+c6NFT0qu1
         whwOvnlPyCx0ibGIUwYFa9qRT5Wb4bud8QHVvnX7Cm9VutGOADcktCXfhiv6tUHHnk5L
         faBbjCs4s+oqk+gwo9h4erPqu8Y4W2K72qZzj170aYcd79izjRHorT/kmujbPC45lBN4
         Ryy4wjap3Pf7bxjE7gksDhbh06/bu+U/DQH87FHFsbFchx9Jvrw/ro/gbtQkTIXEzlww
         ZXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677805423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVcKfKkfVkpqpKWoMU97cJ7wcrQbe2kwbZ0geHYwPfc=;
        b=qlpfo9AnthAo1ctaTSYFpfzqM80V69DmFmQRsOkQKkb7Tyx6zbtiIgGqP3wOQN0JAW
         +IFjmOQDNpD8rCNu/CU7rxFC5zjtfyDkYWTmuM2Bhg24oZLo6PH/VuHaH98PUrOb+c1S
         DHiYYdET7FG+9+O5Exi6XAPajBJlMp4aaztzabK01PIOl17OquPNz7Q/p3nmiMoR9wps
         39oA6SCvzsxbS9mRzpdQ//4v92PJw9w6JKP8C6PyV/TEA7rjs+t+U0i2YYIbCCIM7LsD
         s8c/5XU321cgBU95KiFUfYqRNrRu8pLmX7te+SJxrBqapCL/0C/pWNMMLpEYSYgCk1xc
         RlAg==
X-Gm-Message-State: AO0yUKVXfpbyX8xKmjJDavmmfOJCFXh5jia1cKEN/fQc35Xojy3mh3VY
        h7EPlsiKpMr+gTkqFxHQdvjnEQ==
X-Google-Smtp-Source: AK7set+05kenIZlSMEmN2iofpiRlFp4TiBQqmejCYxCcS7M26TUF6Dopy0EsheSFyDsLRfR/PA8jsQ==
X-Received: by 2002:ac2:546c:0:b0:4dd:ad4b:efd with SMTP id e12-20020ac2546c000000b004ddad4b0efdmr63600lfn.52.1677805423614;
        Thu, 02 Mar 2023 17:03:43 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id y23-20020a197517000000b004db4fa67bf1sm155480lfe.157.2023.03.02.17.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 17:03:43 -0800 (PST)
Message-ID: <e5cda4cf-5c2a-a7ed-9e1d-1fe9f2cbef40@linaro.org>
Date:   Fri, 3 Mar 2023 02:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add CPU idle-states
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230118203428.910992-1-bhupesh.sharma@linaro.org>
 <77fbf01f-58fc-55a2-415b-c39d991e7c96@linaro.org>
 <CAH=2Ntw4hMyV2mqRu1t=WWG24=wKq96PB+eYFtZ4qYQz8dteog@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2Ntw4hMyV2mqRu1t=WWG24=wKq96PB+eYFtZ4qYQz8dteog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.01.2023 21:48, Bhupesh Sharma wrote:
> On Thu, 19 Jan 2023 at 02:10, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 18.01.2023 21:34, Bhupesh Sharma wrote:
>>> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
[...]

>>> +
>>> +             domain-idle-states {
>>> +                     CLUSTER_SLEEP_0: cluster-sleep-0 {
>>> +                             compatible = "domain-idle-state";
>>> +                             idle-state-name = "cluster-power-collapse";
>>> +                             arm,psci-suspend-param = <0x41000043>;
>>> +                             entry-latency-us = <800>;
>>> +                             exit-latency-us = <2118>;
>>> +                             min-residency-us = <7376>;
>> These values vary per cluster, see qcom,pm-cluster-level@2 in the
>> file linked above.. We should either split that, or at least take
>> max() of each value between the two nodes to make sure the sleep
>> state is exited properly on both types of cores.
> 
> Ack to both the above observations. Will send a fixed v2 shortly.
In doing so, please also add support for D3G cluster sleep states
as well, it sounds beneficial to have a middleground between a total
power collapse and a simple wfi.

Konrad
> 
> Thanks,
> Bhupesh
> 
>>> +                     };
>>> +             };
>>>       };
>>>
>>>       firmware {
>>> @@ -191,6 +242,59 @@ pmu {
>>>       psci {
>>>               compatible = "arm,psci-1.0";
>>>               method = "smc";
>>> +
>>> +             CPU_PD0: power-domain-cpu0 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD1: power-domain-cpu1 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD2: power-domain-cpu2 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD3: power-domain-cpu3 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD4: power-domain-cpu4 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD5: power-domain-cpu5 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD6: power-domain-cpu6 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CPU_PD7: power-domain-cpu7 {
>>> +                     #power-domain-cells = <0>;
>>> +                     power-domains = <&CLUSTER_PD>;
>>> +                     domain-idle-states = <&BIG_CPU_SLEEP_0>;
>>> +             };
>>> +
>>> +             CLUSTER_PD: power-domain-cpu-cluster0 {
>>> +                     #power-domain-cells = <0>;
>>> +                     domain-idle-states = <&CLUSTER_SLEEP_0>;
>>> +             };
>>>       };
>>>
>>>       reserved_memory: reserved-memory {
