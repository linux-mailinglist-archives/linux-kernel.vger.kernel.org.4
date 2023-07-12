Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31327508D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGLMzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGLMzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:55:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855D199E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:55:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso111474941fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689166529; x=1691758529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBxmHOlpZaMc8GI4pC8OI8U8ye4KRryJ3hcnoiDNA/E=;
        b=Xks5iI1IpOfxgQoW0/abwCSoqyAAHCnArr6yLJl38bB7X6uxGbHKlEjpCieqMvRnHs
         r4EyNoasuEHdjZNp0u4D38c+BJ4ApLtssv94Ffuw+p3+Lx7R0qqVSIVhec9l46l0GMWh
         FxxzSMZQNIsHxbS3ohMjOJPbOS+nZZS5oBwPteuIXGFPY3QnbH1Noi6kDezuuarWMNap
         h8MtjuWlTLr/YDE8Owz1dyWrawBCyUUqRKpH/gQgrqA4z6zNwZZympDHT7rk53Bkirlx
         +JRnf15LvD20tjejuxcS8WSk8tvGImJz3yuxWAwQn0ZbEO44HPLWx4Oz+1noyDNThRjO
         iBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166529; x=1691758529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBxmHOlpZaMc8GI4pC8OI8U8ye4KRryJ3hcnoiDNA/E=;
        b=IeD0i2jtQzQcPw5rcbHHAuQ3TRtdKLxGZuZMFd+Sr0Ik3o8N1DqaRKKuv6Arjc2+aS
         AcZzjbPP+aytl3RSJZi5TKk3tFxXkYIqsK2bVGTcvyqYn4KLjRAslB+J1OSoYuwQJkx3
         2P4H7gTkYikn8I6MrcmdEdhcXKhY8GMEnccg9bcoPVaa5E+lhFtR8VJjmXLl56ngPqQY
         7dg0tUom9EdrcGMSjX7gTOD61PYecJXls2t07jMENRU3yk92h/MVjmZ7t0f6r2qFki30
         5f+OwO4GuXQLPTgDrDSWT8qMxBvLaNbg1rHYZ3oY9lIvOXTfszpI8LOiDGF1gpLeBVUz
         NBdA==
X-Gm-Message-State: ABy/qLb5vEZzh037mNUGdviy+k+qAaROM7Tke1z+ZpMTDYiX683Nyqik
        9TXQ9Av3snwrRDvGRzTkA+N4vw==
X-Google-Smtp-Source: APBJJlEJS+4iPPt48R/kKnJyxG3Vz4KyXDQgWDFnotbHIrfe7fPuvO1Y7IN9VVvNaEfetFo9ShrIiA==
X-Received: by 2002:a2e:c49:0:b0:2b6:cf18:77e0 with SMTP id o9-20020a2e0c49000000b002b6cf1877e0mr14950795ljd.48.1689166529298;
        Wed, 12 Jul 2023 05:55:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a2e88cb000000b002b6e77e87fcsm923536ljk.68.2023.07.12.05.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 05:55:28 -0700 (PDT)
Message-ID: <2af2c9de-a7da-a154-e6cd-a3f72d0eb331@linaro.org>
Date:   Wed, 12 Jul 2023 15:55:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: ipq5332: Add thermal zone nodes
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230712113539.4029941-1-quic_ipkumar@quicinc.com>
 <20230712113539.4029941-5-quic_ipkumar@quicinc.com>
 <a33368ef-f68c-d7ee-922a-8896a5d1f158@linaro.org>
 <f4bc9c49-3db8-5ca5-7326-413d823e338d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <f4bc9c49-3db8-5ca5-7326-413d823e338d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 15:50, Praveenkumar I wrote:
> 
> On 7/12/2023 5:55 PM, Dmitry Baryshkov wrote:
>> On 12/07/2023 14:35, Praveenkumar I wrote:
>>> This patch adds thermal zone nodes for sensors present in
>>> IPQ5332.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> ---
>>> [v2]:
>>>     Added passive trips and alignment change.
>>>
>>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 78 +++++++++++++++++++++++++++
>>>   1 file changed, 78 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi 
>>> b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> index 0eef77e36609..a1f59af97ee8 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
>>> @@ -480,4 +480,82 @@ timer {
>>>                    <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | 
>>> IRQ_TYPE_LEVEL_LOW)>,
>>>                    <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | 
>>> IRQ_TYPE_LEVEL_LOW)>;
>>>       };
>>> +
>>> +    thermal-zones {
>>> +        rfa-0-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 11>;
>>> +
>>> +            trips {
>>> +                rfa-0-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        rfa-1-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 12>;
>>> +
>>> +            trips {
>>> +                rfa-1-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        misc-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 13>;
>>> +
>>> +            trips {
>>> +                misc-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        cpu-top-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 14>;
>>> +
>>> +            trips {
>>> +                cpu-top-critical {
>>> +                    temperature = <115000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +
>>> +                cpu-passive {
>>> +                    temperature = <105000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "passive";
>>
>> cooling device for this trip point?
> 
> CPU Frequency scaling support is not yet added for IPQ5332. Planning to 
> add the cooling device after that in next set of patches.

Ack, thanks.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> - Praveenkumar
> 
>>
>>> +                };
>>> +            };
>>> +        };
>>> +
>>> +        top-glue-thermal {
>>> +            polling-delay-passive = <0>;
>>> +            polling-delay = <0>;
>>> +            thermal-sensors = <&tsens 15>;
>>> +
>>> +            trips {
>>> +                top-glue-critical {
>>> +                    temperature = <125000>;
>>> +                    hysteresis = <1000>;
>>> +                    type = "critical";
>>> +                };
>>> +            };
>>> +        };
>>> +    };
>>>   };
>>

-- 
With best wishes
Dmitry

