Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D21718560
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjEaOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjEaOzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:55:09 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA6107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:55:05 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f50a8f6dd7so3315402e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685544904; x=1688136904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TqMXVRIcXDpIunz3BCRjGjg2eqs/x79rI3Yc7fWGng=;
        b=tyqHCxP5DW6t2Lb5hpTE4WaI8+vME3wquslqXzoHRsZcu9MbC9TULuaTpvodSVQ59L
         xtl1VSJUorLCcbCtcKRJV/Pi+8rmGD/8r/Y8m4jLyTllj0ehIiQDqcPaxh0T+8cswxvN
         4zamQEi8pnAVZX9WUIecslGJEq2paljCHaWuIrBESv43HbwuG28tq6eRWSwzFSpp88sE
         8d0+jg2z48g2zCqM+f4UOBh2JtlTEj2EmlqWCZz6wiVrYEZkTjpQiAEObvaFahheaau3
         VIsm/HrRLJUKEBHiRkLF4MxZRDAvrf2S1U4ioYHIE2Y5H0DsIf+9vHiuk/TyDmAx2kZ9
         +kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685544904; x=1688136904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TqMXVRIcXDpIunz3BCRjGjg2eqs/x79rI3Yc7fWGng=;
        b=d1H65Dwl9jZIjZr9Bfy81u2sEajSeJy3QqNKCDPdfcqR2N6ggiKHBo3fXmwvHWrMNO
         F6cVcNPWkeTGAjCbQk2ZtRMpKfK+FAuOIDNYgcz2amaLH0x5C4Jz/VM1yIRKYcSmN8ge
         5cUJXiwThJkzWu6uZGouS2ilivMd0/Rp5rDyww9iM6KZpHsCl1eHh5mRaogrG/sRX0cf
         /tcIa9MqQkcxOT0rz3zWnYR2MAHv01HWTMMAPxRcOB+OAUyg40D9rNY9mpRRHmMRHnoA
         B5loMjEiPB83SANTf8o9GYmoElgH73Xfx0tOV+K1y8Gdaj9HtIQLnadLQu1h+Vy6gjZG
         Tj0A==
X-Gm-Message-State: AC+VfDxRtE/4ppzJ+a8aM4/wzvzDD86GTc8VPGjthk9YVwBLHl51Tn00
        RLslFm9WpFNgZYTEMAiq10b0Pw==
X-Google-Smtp-Source: ACHHUZ5YCHMCLR1NSDQmBAizApylsR46k/qxtptQFran2p0NRiyqfvBh5HtMTGmouqHn5bjJfoKCQw==
X-Received: by 2002:a2e:3203:0:b0:2ad:dd7e:6651 with SMTP id y3-20020a2e3203000000b002addd7e6651mr3179661ljy.43.1685544903832;
        Wed, 31 May 2023 07:55:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id o7-20020a2e7307000000b002ad92c2ff54sm3325452ljc.15.2023.05.31.07.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 07:55:03 -0700 (PDT)
Message-ID: <965bc277-b31b-e278-a793-90248615c9d6@linaro.org>
Date:   Wed, 31 May 2023 16:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Set up CPU cooling maps
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418-topic-cool_bengal-v1-1-c5d53814dc74@linaro.org>
 <20230418130223.wvsu3bsm62i2gtpp@ripper>
 <139ea923-968b-cee2-15e0-3fb8112e15d9@linaro.org>
 <20230418155146.3qpin45woex5sbli@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230418155146.3qpin45woex5sbli@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 17:51, Bjorn Andersson wrote:
> On Tue, Apr 18, 2023 at 03:01:47PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 18.04.2023 15:02, Bjorn Andersson wrote:
>>> On Tue, Apr 18, 2023 at 01:56:56PM +0200, Konrad Dybcio wrote:
>>>> Set up CPU cooling maps to ensure the thermal framework is aware of
>>>> the connection between the CPUs and the TSENS sensors.
>>>>
>>>> All of the maps refer to all 4 CPUs within a given cluster at a time,
>>>> as that's what can be considered the smallest DVFS target unit - they
>>>> all share the same voltage line and clock source.
>>>>
>>>
>>> Generally software based CPU cooling is considered too slow to cope with
>>> CPU core temperature changes, and the limits hardware working together
>>> with OSM/EPSS will do a better job maintaining appropriate core
>>> temperature levels.
>>>
>>> Is there a reason why this can't be used/relied upon on this platform?
>> I haven't set up LMH yet and the default limits, at least with my dubious
>> meta build, seem to let the board go to 75degC with just 4 cores working..
>>
>> Not sure if there's a voltage droop when I let it go full throttle or
>> something, but pushing it to the limit definitely causes the board to be
>> (even) less stable..
>>
>>>
>>>
>>> PS. Amending this mechanism with software based cooling to keep the
>>> system at a reasonable/lower temperature is a good idea.
>> We don't like burned chips around here!
>>
> 
> Limits hardware will help you with that, software based cooling will
> help avoid burning the user.
So, are there any reasons not to take this patch?

Konrad
> 
> Regards,
> Bjorn
> 
>> Konrad
>>>
>>> Regards,
>>> Bjorn
>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 137 +++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 137 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> index 631ca327e064..36ff913c1a60 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>>>> @@ -12,6 +12,7 @@
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>>> +#include <dt-bindings/thermal/thermal.h>
>>>>  
>>>>  / {
>>>>  	interrupt-parent = <&intc>;
>>>> @@ -47,6 +48,8 @@ CPU0: cpu@0 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_0>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>>> +			#cooling-cells = <2>;
>>>> +
>>>>  			L2_0: l2-cache {
>>>>  				compatible = "cache";
>>>>  				cache-level = <2>;
>>>> @@ -63,6 +66,7 @@ CPU1: cpu@1 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_0>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		CPU2: cpu@2 {
>>>> @@ -75,6 +79,7 @@ CPU2: cpu@2 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_0>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		CPU3: cpu@3 {
>>>> @@ -87,6 +92,7 @@ CPU3: cpu@3 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_0>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		CPU4: cpu@100 {
>>>> @@ -99,6 +105,8 @@ CPU4: cpu@100 {
>>>>  			dynamic-power-coefficient = <282>;
>>>>  			next-level-cache = <&L2_1>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>>> +			#cooling-cells = <2>;
>>>> +
>>>>  			L2_1: l2-cache {
>>>>  				compatible = "cache";
>>>>  				cache-level = <2>;
>>>> @@ -115,6 +123,7 @@ CPU5: cpu@101 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_1>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		CPU6: cpu@102 {
>>>> @@ -127,6 +136,7 @@ CPU6: cpu@102 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_1>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		CPU7: cpu@103 {
>>>> @@ -139,6 +149,7 @@ CPU7: cpu@103 {
>>>>  			enable-method = "psci";
>>>>  			next-level-cache = <&L2_1>;
>>>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>>>> +			#cooling-cells = <2>;
>>>>  		};
>>>>  
>>>>  		cpu-map {
>>>> @@ -2471,6 +2482,24 @@ cpu4-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 6>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu4_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu4_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu4_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2497,6 +2526,24 @@ cpu5-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 7>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu5_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu5_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu5_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2523,6 +2570,24 @@ cpu6-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 8>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu6_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu6_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu6_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2549,6 +2614,24 @@ cpu7-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 9>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu7_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu7_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu7_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2575,6 +2658,24 @@ cpu45-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 10>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu45_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu45_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu45_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2601,6 +2702,24 @@ cpu67-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 11>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu67_alert0>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu67_alert1>;
>>>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu67_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>> @@ -2627,6 +2746,24 @@ cpu0123-thermal {
>>>>  			polling-delay = <0>;
>>>>  			thermal-sensors = <&tsens0 12>;
>>>>  
>>>> +			cooling-maps {
>>>> +				map0 {
>>>> +					trip = <&cpu0123_alert0>;
>>>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +
>>>> +				map1 {
>>>> +					trip = <&cpu0123_alert1>;
>>>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			trips {
>>>>  				cpu0123_alert0: trip-point0 {
>>>>  					temperature = <90000>;
>>>>
>>>> ---
>>>> base-commit: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
>>>> change-id: 20230418-topic-cool_bengal-2f5f3f47269c
>>>>
>>>> Best regards,
>>>> -- 
>>>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>
