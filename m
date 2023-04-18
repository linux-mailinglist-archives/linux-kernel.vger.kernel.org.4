Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4C96E6536
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDRNCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDRNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:01:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8316DC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:01:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso18916511fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681822910; x=1684414910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6YEmcuAerby7c0K4iVTEgn+ogX7Io1YG4cdbzDgjzo=;
        b=meFzbGkQNz+I6DWvPn43dT00bCFSQfO9QNLn/3EE5MvWCVhfpzKkWhYuoJlfBKNHM3
         w4oy2ghW6V3wJmL5NmYYRAiXy3DTgsOmbZOuLS1giEqAzgZN3IrOysriysQ9kCvk8Ul4
         uzknr6M3kStyypqv+tcPhEnbiH+RDrldAsWy5s6CQziKxRVGw2X8EIraopPL7P05XLVO
         MY9uwqa5iH/TLTLXr3FvrSqJ/intfxCtMoCnCGWWYtimquCv5JymTUJq3nG3s4sHJGLD
         H0qXz0blFStPrT2/atQ/RJJwE4b85pXOWHORW6g1pgfF6gWp+TxFO1N10ioApa7PM4B2
         WzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681822910; x=1684414910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6YEmcuAerby7c0K4iVTEgn+ogX7Io1YG4cdbzDgjzo=;
        b=OJZ4qtw+3sd0TiQz9769Mar0IwkySFHdA+KHUfu/v74MTgXU+R8mF0yxcvGyG0lXIs
         WhV2N+dnK+uoRrrosIOdp2Zbw3RHwCyHt4QyVB14ajw20+hMIYnod3wdqpDBAqP/iGW7
         WbyAyzCe5zf/xzOs1UwWWvctN5MPHw57m6dSwJQjjz8sGG1QRuzI0LLtK9wb6W4x7m3n
         eHvHXzjUBehxEdp/cqN60WtXCqSYru2QuHA9IUbfsn9Qm113uv2VaEvCjkRbixIy141F
         h0JF7EUyd3BusUUb4j2pDOIYyRoo9WzEZYoN6C6cIbgxiC35z+A72a4qoRJXcXqFU14T
         vVWw==
X-Gm-Message-State: AAQBX9etR1cmdSIoN5UUHjSJlziLkLBfcPj6lcTeVJwJIWrO3QhC5Ipb
        Rad3q0kVSFBavriioGW7P5Zoww==
X-Google-Smtp-Source: AKy350ZcAJamEpRa7XQusi3NN0l1oRnR5o4ScmhYDAfiTffiIBI+LzXujMXS6hL8CzUVcScc8xvr9Q==
X-Received: by 2002:ac2:414a:0:b0:4ed:b8be:8116 with SMTP id c10-20020ac2414a000000b004edb8be8116mr2201310lfi.20.1681822909457;
        Tue, 18 Apr 2023 06:01:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id z18-20020ac25df2000000b004e83edd8ce8sm2367433lfq.196.2023.04.18.06.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:01:49 -0700 (PDT)
Message-ID: <139ea923-968b-cee2-15e0-3fb8112e15d9@linaro.org>
Date:   Tue, 18 Apr 2023 15:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230418130223.wvsu3bsm62i2gtpp@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 15:02, Bjorn Andersson wrote:
> On Tue, Apr 18, 2023 at 01:56:56PM +0200, Konrad Dybcio wrote:
>> Set up CPU cooling maps to ensure the thermal framework is aware of
>> the connection between the CPUs and the TSENS sensors.
>>
>> All of the maps refer to all 4 CPUs within a given cluster at a time,
>> as that's what can be considered the smallest DVFS target unit - they
>> all share the same voltage line and clock source.
>>
> 
> Generally software based CPU cooling is considered too slow to cope with
> CPU core temperature changes, and the limits hardware working together
> with OSM/EPSS will do a better job maintaining appropriate core
> temperature levels.
> 
> Is there a reason why this can't be used/relied upon on this platform?
I haven't set up LMH yet and the default limits, at least with my dubious
meta build, seem to let the board go to 75degC with just 4 cores working..

Not sure if there's a voltage droop when I let it go full throttle or
something, but pushing it to the limit definitely causes the board to be
(even) less stable..

> 
> 
> PS. Amending this mechanism with software based cooling to keep the
> system at a reasonable/lower temperature is a good idea.
We don't like burned chips around here!

Konrad
> 
> Regards,
> Bjorn
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 137 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 137 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index 631ca327e064..36ff913c1a60 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -12,6 +12,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>  
>>  / {
>>  	interrupt-parent = <&intc>;
>> @@ -47,6 +48,8 @@ CPU0: cpu@0 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			#cooling-cells = <2>;
>> +
>>  			L2_0: l2-cache {
>>  				compatible = "cache";
>>  				cache-level = <2>;
>> @@ -63,6 +66,7 @@ CPU1: cpu@1 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		CPU2: cpu@2 {
>> @@ -75,6 +79,7 @@ CPU2: cpu@2 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		CPU3: cpu@3 {
>> @@ -87,6 +92,7 @@ CPU3: cpu@3 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_0>;
>>  			qcom,freq-domain = <&cpufreq_hw 0>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		CPU4: cpu@100 {
>> @@ -99,6 +105,8 @@ CPU4: cpu@100 {
>>  			dynamic-power-coefficient = <282>;
>>  			next-level-cache = <&L2_1>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			#cooling-cells = <2>;
>> +
>>  			L2_1: l2-cache {
>>  				compatible = "cache";
>>  				cache-level = <2>;
>> @@ -115,6 +123,7 @@ CPU5: cpu@101 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_1>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		CPU6: cpu@102 {
>> @@ -127,6 +136,7 @@ CPU6: cpu@102 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_1>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		CPU7: cpu@103 {
>> @@ -139,6 +149,7 @@ CPU7: cpu@103 {
>>  			enable-method = "psci";
>>  			next-level-cache = <&L2_1>;
>>  			qcom,freq-domain = <&cpufreq_hw 1>;
>> +			#cooling-cells = <2>;
>>  		};
>>  
>>  		cpu-map {
>> @@ -2471,6 +2482,24 @@ cpu4-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 6>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu4_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu4_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu4_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2497,6 +2526,24 @@ cpu5-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 7>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu5_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu5_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu5_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2523,6 +2570,24 @@ cpu6-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 8>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu6_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu6_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu6_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2549,6 +2614,24 @@ cpu7-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 9>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu7_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu7_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu7_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2575,6 +2658,24 @@ cpu45-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 10>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu45_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu45_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu45_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2601,6 +2702,24 @@ cpu67-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 11>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu67_alert0>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu67_alert1>;
>> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu67_alert0: trip-point0 {
>>  					temperature = <90000>;
>> @@ -2627,6 +2746,24 @@ cpu0123-thermal {
>>  			polling-delay = <0>;
>>  			thermal-sensors = <&tsens0 12>;
>>  
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&cpu0123_alert0>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +
>> +				map1 {
>> +					trip = <&cpu0123_alert1>;
>> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +
>>  			trips {
>>  				cpu0123_alert0: trip-point0 {
>>  					temperature = <90000>;
>>
>> ---
>> base-commit: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
>> change-id: 20230418-topic-cool_bengal-2f5f3f47269c
>>
>> Best regards,
>> -- 
>> Konrad Dybcio <konrad.dybcio@linaro.org>
>>
