Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0910774D50F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjGJMOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGJMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:14:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934F194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:14:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6708214e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688991282; x=1691583282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FIUM80sem4wvBeLJM7gxDVfcq4hFkz0TAKhA7YTlha0=;
        b=CM/h05LBdzNNfatrfLN7zDsRHxIyJPeh8P7N3VasIH7sCErwoKYRQ91NRoDT5golq6
         yOn7zwL2WdLaAv5e6i+XlpCa2l7ihZ+ZZFHumn3zhPG1pvLmVcKk9v8LoVR0RASM4zia
         752kRYDPMnoBOu/DcBTnXFNP2ZS8mmIrd0FUJh1w0qSKsAM/lB92/dJ/lqG8tlhuF7YG
         OEOQ5afhhJ1lRobu64KC9GvqqrjFKqDXF/w0hcc5CcSh3Kk7pA1WzlIWT/q7JIvIZk0E
         SGIiMhNtPZmIVrr5QCvH01XCPBbkzHNmv1b6dVbHDxIu3miA27BXakVo2zqhHL5+cnvF
         Pjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688991282; x=1691583282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIUM80sem4wvBeLJM7gxDVfcq4hFkz0TAKhA7YTlha0=;
        b=BGZw20dfyCSmmt8pEHz/lr0fWW8xGayGJVaAhefnsUhS+/kIHu+30FgXKlGLT/4rkE
         WG4BwWx2/saqtwnKJ8ysFach9rnivWlso1I8NYhscn6QpJwN8GReTjNUUpl8sDFNDHtn
         D8uX2urqQ6m5B6Venf+dzl8FGSTAS/nfRDtyqJydEFAPmFoKEHItlkNTYePCvPc2Fy1L
         iDLVU4U5ayK+yOeHkf9xdNff1835vdo6XmIjwFV1Z1+Jl1K6qwCTexbW5+k7oDK/K+ZJ
         crmV0IJkFZ1aztPX8vvF0AnxVhTT58ckEfz1DK5Bb3IVBfqM3SOx2CJIcYeBT3/7bIyP
         778Q==
X-Gm-Message-State: ABy/qLZnrrP2y8P/u/Qrirj/do8Rbp7+jsdLMO+VoswEmdFsQWYc9Pn2
        cCdZHZzW79akdsKuWpx3wQUPfg==
X-Google-Smtp-Source: APBJJlEggwbPNBYWyFhjvfF6GLwQ/BHHtenN1h2x1ww8Fde/Lb05kPWkKWYva1WKoqvyG5xx6CJVPw==
X-Received: by 2002:a05:6512:239f:b0:4fb:77d6:89c3 with SMTP id c31-20020a056512239f00b004fb77d689c3mr11852649lfv.12.1688991281113;
        Mon, 10 Jul 2023 05:14:41 -0700 (PDT)
Received: from [192.168.1.101] (abxj141.neoplus.adsl.tpnet.pl. [83.9.3.141])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004fb763b5171sm1678441lfn.86.2023.07.10.05.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 05:14:40 -0700 (PDT)
Message-ID: <b1346bc7-4bf0-e885-c3d4-6fac01516bf4@linaro.org>
Date:   Mon, 10 Jul 2023 14:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-6-quic_ipkumar@quicinc.com>
 <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3f6ab4b4-b5f5-5807-0cb4-8ae782bd6044@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.2023 13:23, Dmitry Baryshkov wrote:
> On 10/07/2023 13:37, Praveenkumar I wrote:
>> This patch adds thermal zone nodes for sensors present in
>> IPQ5332.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 72 +++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> index a1e3527178c0..8b276aeca53e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>> @@ -527,4 +527,76 @@ timer {
>>                    <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>       };
>> +
>> +    thermal-zones {
>> +        rfa-0-thermal{
thermal {


>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 11>;
>> +
>> +            trips {
Indentation seems off, tab size for kernel code is 8 spaces.

Konrad
>> +                rfa-0-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        rfa-1-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 12>;
>> +
>> +            trips {
>> +                rfa-1-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        misc-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 13>;
>> +
>> +            trips {
>> +                misc-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +
>> +        cpu-top-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 14>;
>> +
>> +            trips {
>> +                cpu-top-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
> 
> Could you please add a passive cooling devices for the CPU?
> 
>> +        };
>> +
>> +        top-glue-thermal {
>> +            polling-delay-passive = <0>;
>> +            polling-delay = <0>;
>> +            thermal-sensors = <&tsens 15>;
>> +
>> +            trips {
>> +                top-glue-critical {
>> +                    temperature = <125000>;
>> +                    hysteresis = <1000>;
>> +                    type = "critical";
>> +                };
>> +            };
>> +        };
>> +    };
>>   };
> 
