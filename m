Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70650724EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbjFFVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbjFFVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:23:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECD1706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:23:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6148f9679so6009867e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686086593; x=1688678593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qm+1lx1YXkD1jHHZgscMNvbufDc9utDAdpArAxBAlyA=;
        b=kmrXSqSh4cW9xvUjFytgwMKOBH4BL4FrdtWsRkD3fN7ns6zhunGx54UTNW+SxsfWZi
         JIQ1T2ZwxsCf6t1ZfZ2w6NBfG6h2Jkz/U4Vk2jvuIZ7w9j7PIj3vfAQJH7EFOtPPvVyv
         S+mK3AXM9X8jK2Ukz8lnIeQ/ZWhoCEZwkfYfiSVPvT4GEE7vnAIupqty8ZJbaMN6iKpW
         w7pMdQQIcNSk7O7Fg+ult4sYwwOhD4Ei0mMc/5IsmTDZ1XNmoAur1XzQxX0ZDQDCKwUG
         ilzc8wft9smotqhT9uJgncQdOocq5p82oyI/dsWlwm+GLhQn35EsCzzZbr8SgzVSPT79
         eAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686086593; x=1688678593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm+1lx1YXkD1jHHZgscMNvbufDc9utDAdpArAxBAlyA=;
        b=E+XxL5Mj9U8TGB98whBPFstvpUvWL3Ml72BhTHraBUb5vC7cElhDNIklZVNIau2mwg
         a0f+JMd9UjxlcGvK/JSdTbDk55Eh1aa3r9BlpjOkHFR9PaDo2E2dtIyK3b3O3SaKPkj9
         bZhVO6yYpYdffnDe6e9eia8XOel1cv2LRnmmPqbSqM4bNo29q49PEyvVdJEqxpiU1Vnu
         +eOzLZNUJhYO2rNz6v3IX6IX4aaU5zxyyy2kvgPkaTTRts0jRt6q/trgSSLOWbLj0MDU
         r79ai5BvXykm26tQMrXmoy/qfuupWlBZHB78a+tZRasFBBJjYE8zGOVgHBJ/9gIaZDXU
         +X8A==
X-Gm-Message-State: AC+VfDzdBs+kPDEYV+VyBzMCRTEwz+HhqVpkDmV6Jrmy5KZN9Ch5FW91
        Z8WaW0M7AAMposowKhrsmkFYAWBvgjCcLFDbQa4=
X-Google-Smtp-Source: ACHHUZ6Cgfa4QzAt71x2+ybGkQOjk0ihlvj0vPwo9qq05LgKH348JxPQdxmBq06Ji+aBNZ74L/JP+A==
X-Received: by 2002:a05:6512:146:b0:4f4:d6d3:33ec with SMTP id m6-20020a056512014600b004f4d6d333ecmr1882831lfo.1.1686086593440;
        Tue, 06 Jun 2023 14:23:13 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id p22-20020ac246d6000000b004f606755537sm1562595lfo.298.2023.06.06.14.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 14:23:13 -0700 (PDT)
Message-ID: <99d3c317-515e-3f1f-b134-a90607846269@linaro.org>
Date:   Tue, 6 Jun 2023 23:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add CPU idle states
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230606-topic-qcm2290_idlestates-v1-1-dd77eef0086e@linaro.org>
 <ZH-Wcxy3aev9hjBU@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZH-Wcxy3aev9hjBU@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.06.2023 22:26, Stephan Gerhold wrote:
> On Tue, Jun 06, 2023 at 06:15:28PM +0200, Konrad Dybcio wrote:
>> Add the (scarce) idle states for the individual CPUs, as well as the
>> whole cluster. This enables deeper-than-WFI cpuidle
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 61 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>> index b29bc4e4b837..a8a1ce58c0b7 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
>> @@ -48,6 +48,8 @@ CPU0: cpu@0 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			power-domains = <&CPU_PD0>;
>> +			power-domain-names = "psci";
>>  			L2_0: l2-cache {
>>  				compatible = "cache";
>>  				cache-level = <2>;
>> @@ -65,6 +67,8 @@ CPU1: cpu@1 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			power-domains = <&CPU_PD1>;
>> +			power-domain-names = "psci";
>>  		};
>>  
>>  		CPU2: cpu@2 {
>> @@ -77,6 +81,8 @@ CPU2: cpu@2 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			power-domains = <&CPU_PD2>;
>> +			power-domain-names = "psci";
>>  		};
>>  
>>  		CPU3: cpu@3 {
>> @@ -89,6 +95,8 @@ CPU3: cpu@3 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			power-domains = <&CPU_PD3>;
>> +			power-domain-names = "psci";
>>  		};
>>  
>>  		cpu-map {
>> @@ -110,6 +118,30 @@ core3 {
>>  				};
>>  			};
>>  		};
>> +
>> +		domain-idle-states {
>> +			CLUSTER_SLEEP: cluster-sleep-0 {
>> +				compatible = "domain-idle-state";
>> +				arm,psci-suspend-param = <0x40000044>;
> 
> Are you sure this is correct? Based on lpm-levels/scuba-pm downstream
> I would expect:
> 
>  - That the CPU mode part (last digit) is equal to the deepest per-CPU
>    state (0x3) and only the cluster mode part (digit before) changes
>  - That you pass the "last in power level" needed for OSI in << 24
0x3 I agree (though by luck it turns out that 0x4 is also implemented!)

BIT(24) - right, the firmware could fail to power off the shared cluster
resources (like Ln$) with that missing.. Thanks for catching this!

Konrad
> 
> Some of the numbers in sm6115.dtsi also look suspicious if you want to
> recheck those...
> 
> Thanks,
> Stephan
