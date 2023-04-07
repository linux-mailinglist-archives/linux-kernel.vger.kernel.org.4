Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA56DAC73
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbjDGL7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjDGL7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:59:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8783F2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:59:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z42so43300608ljq.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680868758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyNciRuuESIaKZEY8Qa86obLOtLCt19xSQ+LjBWVyjQ=;
        b=x6t4GkePT4JZJ8ZgtSOSGs26QhXMjRbSyqg/eMVLLWn4zVRxKrxl5K/BgF+DrHZuds
         s0jW3zyiwUl/LnZAih0GzV/X/1Yps9wU0ws51V8XXiC7LGAh/g4dxNtNwLdb15crQUc0
         UwR7GcC+qebSayaEPaFwBe8FBh3Jko6hrhaUwDVm2EhKHm5yURJALcbFXl+dAbNGkZDO
         c+jEhsEZG1Iq/c/pZdsOrQFyym9+iodZUZXLoUP4tecBl+dCpf2kwvZr3saMHm9UgPNV
         9fBa1sIS11zPyUf5IQC1zSYK/oeWeRX+S/84SWlAYY4BYvnmtQQasWB1j3bKyB6kujM3
         8JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680868758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyNciRuuESIaKZEY8Qa86obLOtLCt19xSQ+LjBWVyjQ=;
        b=cWrhB88dNtcTasD+DyFgCnGxwpAuZuwjeLlRcAY9HeM0mSyAN+7Moocmc+SJVBdinY
         gslAPmCR4Gy0YHbGlGTPQDMSwv6ngDLAzNH5fuwi2V+s+Bj2tGVsgrBv1fYghn8it76j
         022es8ox4KaL29KTsxSjWZ/6lZFMvCoXH2prLQZW/j+w2l5vI9e442WCVMhSaHvRif27
         uYejQ2pBKv7TDmIlWkUGIZbrvxS0vV/LWBDJ8Hj1rjmJDYMF7UusiNa2EULg5u3Ot9qY
         AMdfq/7XNlEMiAw8oHf2Pn7TJAMdJW54omqOANjtGZTDJyYYTdZqr8kr9EW5uFmpy5su
         i1rQ==
X-Gm-Message-State: AAQBX9dOuoxyJx2cJcXQfNJflx2bSPTahnN0F/AP72I3ltcpJekUgbZW
        GVMciWeQIjI4eH1YPx31cXla2g==
X-Google-Smtp-Source: AKy350Y/DseiDOs/iuLqIXCJWd8Opwq/gvW1OI6u7YlYkagveYzVKg33OhOzFmfNjp8MwWfARVgJ4A==
X-Received: by 2002:a05:651c:ba5:b0:2a6:13f:5f6c with SMTP id bg37-20020a05651c0ba500b002a6013f5f6cmr419351ljb.5.1680868757969;
        Fri, 07 Apr 2023 04:59:17 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id b8-20020a2e9888000000b0029571d505a1sm774904ljj.80.2023.04.07.04.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 04:59:17 -0700 (PDT)
Message-ID: <de8d228f-36b9-e35e-2f08-880c96a39267@linaro.org>
Date:   Fri, 7 Apr 2023 13:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 5/5] arm64: dts: qcom: ipq9574: Add cpufreq support
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-6-quic_devipriy@quicinc.com>
 <18eb5708-bf51-26c3-51a0-70a5069ffdbe@linaro.org>
 <c1d916f0-514e-5ad8-d474-4d6fa9842364@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <c1d916f0-514e-5ad8-d474-4d6fa9842364@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 06:53, Devi Priya wrote:
> 
> 
> On 4/7/2023 1:21 AM, Konrad Dybcio wrote:
>>
>>
>> On 6.04.2023 09:00, Devi Priya wrote:
>>> Add cpu freq nodes in the device tree to bump cpu frequency above 800MHz.
>>>
>>> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>   Changes in V3:
>>>     - No change
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 58 +++++++++++++++++++++++++++
>>>   1 file changed, 58 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index 1f9b7529e7ed..cfef87b5fd22 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -6,6 +6,7 @@
>>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>    */
>>>   +#include <dt-bindings/clock/qcom,apss-ipq.h>
>>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>> @@ -37,6 +38,10 @@
>>>               reg = <0x0>;
>>>               enable-method = "psci";
>>>               next-level-cache = <&L2_0>;
>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +            clock-names = "cpu";
>>> +            operating-points-v2 = <&cpu_opp_table>;
>>> +            cpu-supply = <&ipq9574_s1>;
>>>           };
>>>             CPU1: cpu@1 {
>>> @@ -45,6 +50,10 @@
>>>               reg = <0x1>;
>>>               enable-method = "psci";
>>>               next-level-cache = <&L2_0>;
>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +            clock-names = "cpu";
>>> +            operating-points-v2 = <&cpu_opp_table>;
>>> +            cpu-supply = <&ipq9574_s1>;
>>>           };
>>>             CPU2: cpu@2 {
>>> @@ -53,6 +62,10 @@
>>>               reg = <0x2>;
>>>               enable-method = "psci";
>>>               next-level-cache = <&L2_0>;
>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +            clock-names = "cpu";
>>> +            operating-points-v2 = <&cpu_opp_table>;
>>> +            cpu-supply = <&ipq9574_s1>;
>>>           };
>>>             CPU3: cpu@3 {
>>> @@ -61,6 +74,10 @@
>>>               reg = <0x3>;
>>>               enable-method = "psci";
>>>               next-level-cache = <&L2_0>;
>>> +            clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>>> +            clock-names = "cpu";
>>> +            operating-points-v2 = <&cpu_opp_table>;
>>> +            cpu-supply = <&ipq9574_s1>;
>>>           };
>>>             L2_0: l2-cache {
>>> @@ -75,6 +92,47 @@
>>>           reg = <0x0 0x40000000 0x0 0x0>;
>>>       };
>>>   +    cpu_opp_table: opp-table-cpu {
>> This is not sorted properly. It should probably come
>> after memory alphabetically ('o' > 'm')
>>
> Yes, But I see that opp-table-cpu node is already placed after
> memory@40000000

Oh you're right, the diff doesn't really show that very
well and I didn't notice..


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>> Konrad
>>> +        compatible = "operating-points-v2";
>>> +        opp-shared;
>>> +
>>> +        opp-936000000 {
>>> +            opp-hz = /bits/ 64 <936000000>;
>>> +            opp-microvolt = <725000>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +
>>> +        opp-1104000000 {
>>> +            opp-hz = /bits/ 64 <1104000000>;
>>> +            opp-microvolt = <787500>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +
>>> +        opp-1416000000 {
>>> +            opp-hz = /bits/ 64 <1416000000>;
>>> +            opp-microvolt = <862500>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +
>>> +        opp-1488000000 {
>>> +            opp-hz = /bits/ 64 <1488000000>;
>>> +            opp-microvolt = <925000>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +
>>> +        opp-1800000000 {
>>> +            opp-hz = /bits/ 64 <1800000000>;
>>> +            opp-microvolt = <987500>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +
>>> +        opp-2208000000 {
>>> +            opp-hz = /bits/ 64 <2208000000>;
>>> +            opp-microvolt = <1062500>;
>>> +            clock-latency-ns = <200000>;
>>> +        };
>>> +    };
>>> +
>>>       firmware {
>>>           scm {
>>>               compatible = "qcom,scm-ipq9574", "qcom,scm";
> Best Regards,
> Devi Priya
