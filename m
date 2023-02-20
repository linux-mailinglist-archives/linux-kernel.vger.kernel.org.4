Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18FB69CF85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBTOhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjBTOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:37:00 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD771C32E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:36:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m7so1883748lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vhlUf4V//EucpeTUzass2zWDgLFr6HdC5bKhDHOf1Y=;
        b=OBGrR5BqSNtEZQM2urjlOlaH1nXZyXQ47IZg0lF9rt5wQqW4Q98NZGvwbZNA+61qz9
         6aU2ev0bXVxpk+9FiZZGYk2ZrG5tGs3Rg8zfLoMxKq0czUtZoY5cul/ECPIsR3FP2a4I
         2Q2vxiSeUP0gfZRTOSPHv8/6ocY8rMx1D5z7TEKaRH4B5ZiLj11rud1u6K/Xr3xrPeBG
         wyjbDuHvneR1ZG6Tv+HUxYPTm/dWMa3j7iqcIpj1/T0JyrCbBkTxQO9oyGqHee5mA5xF
         qpkm/35SQsnPu8uT4s8VC8eWppF9ptD9zlneZ5NcECCaabiUZZYXAYcemCLrmsugsg2w
         hVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vhlUf4V//EucpeTUzass2zWDgLFr6HdC5bKhDHOf1Y=;
        b=PdI3hX9mag5iCqZeFEFKfregh91t+Jv/TIIEBPG3NQNrBDyJIiFEFKNFu6MhEte5rU
         IaaEM1IINGYabPJC+rQx86yNldI9Wcp2NkhO7ctmgT7InXculqF1aI7ARlWulW9xSI4Z
         vaz2S347C/a4Yq2wsceQm5LHMP8VI62v+4xSCUEwgfx1tmyIyeMv27PAanSbbwUTYHyK
         tCvo0g56nkgrjtoMstjtoW/m5p8MDCSAWKrDM3wvvoOkjagUjhzAhemmjx/Pmw2qtsAO
         pAyyGHViuq4m7/ZBA7sivStU4xxRV2JYabSQazN52Hm9fkU0Z19m45ymEwe8j9ukf0im
         ST2g==
X-Gm-Message-State: AO0yUKULC/KwXozK4XKEPk7ZXhycnWRUcxYTrAkfjVakB0Lo7K4gQhom
        XPr7r4L1qX0k1GTso4H/bLYg0w==
X-Google-Smtp-Source: AK7set9Q2QTfNHI8HJ1IzZNKZTNtqZJBo5WDw+FA5rdYPWKoDAvgoATDJjdXykT21cEn90yayQJ4rA==
X-Received: by 2002:a05:6512:1284:b0:4d8:86c1:4782 with SMTP id u4-20020a056512128400b004d886c14782mr837059lfs.23.1676903816529;
        Mon, 20 Feb 2023 06:36:56 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id g21-20020a19ee15000000b004dc4b00a1eesm216242lfb.261.2023.02.20.06.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:36:56 -0800 (PST)
Message-ID: <07342311-33e3-cf7e-38ed-5d54d83b43a3@linaro.org>
Date:   Mon, 20 Feb 2023 15:36:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 5/6] arm64: dts: qcom: ipq9574: Add RPM related nodes
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
References: <20230217142030.16012-1-quic_devipriy@quicinc.com>
 <20230217142030.16012-6-quic_devipriy@quicinc.com>
 <12d23d88-6f42-09ea-3f26-e1b7a0878767@linaro.org>
 <fb576665-7983-d09a-06a6-bfde5793816e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fb576665-7983-d09a-06a6-bfde5793816e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.02.2023 14:53, Devi Priya wrote:
> Hi Konrad,
> 
> Thanks for taking time to review the patch!
I appreciate your gratitude, but please don't toppost (a.k.a
don't reply in the first lines of the email), that's rather
frowned upon on LKML.

> 
> On 2/17/2023 8:20 PM, Konrad Dybcio wrote:
>>
>>
>> On 17.02.2023 15:20, Devi Priya wrote:
>>> Add RPM Glink, RPM message RAM and SMPA1 regulator
>>> nodes to support frequency scaling on IPQ9574
>>>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>>   Changes in V2:
>>>     - Splitted the RPM and CPU Freq changes to individual patches
>>>     - Moved the regulators node to Board DT
>>>     - Dropped the regulator-always-on property
>>>     - Updated the compatible in regulators node with the existing
>>>       mp5496 compatible
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts | 11 +++++++++++
>>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 17 +++++++++++++++++
>>>   2 files changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>> index 21b53f34ce84..8a6caaeb0c4b 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>> @@ -57,6 +57,17 @@
>>>       status = "okay";
>>>   };
>>>   +&rpm_requests {
>>> +    regulators {
>>> +        compatible = "qcom,rpm-mp5496-regulators";
>>> +
>>> +        ipq9574_s1: s1 {
>>> +            regulator-min-microvolt = <587500>;
>>> +            regulator-max-microvolt = <1075000>;
>>> +        };
>>> +    };
>>> +};
>> This belongs in a separate patch.
>>
> Do you recommend to move this change to the below patch in the next spin?
> [PATCH V2 6/6]arm64: dts: qcom: ipq9574: Add cpufreq support
Sounds good

Also, I think you missed a newline before &rpm_requests now that
I look at it.

Konrad
>>> +
>>>   &sdhc_1 {
>>>       pinctrl-0 = <&sdc_default_state>;
>>>       pinctrl-names = "default";
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> index d20f3c7383f5..2f300cbab93e 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>> @@ -133,6 +133,11 @@
>>>           #size-cells = <2>;
>>>           ranges;
>>>   +        rpm_msg_ram: rpm@60000 {
>> Since this is a part of the MMIO region and not a part of DRAM,
>> we generally put this node under /soc with the compatible of
>> qcom,rpm-msg-ram and without no-map.
>>
>> And the node name then should be sram@.
> Sure, okay. Will update this in V3
>>
>>> +            reg = <0x0 0x00060000 0x0 0x6000>;
>>> +            no-map;
>>> +        };
>>> +
>>>           tz_region: tz@4a600000 {
>>>               reg = <0x0 0x4a600000 0x0 0x400000>;
>>>               no-map;
>>> @@ -768,6 +773,18 @@
>>>           };
>>>       };
>>>   +    rpm-glink {
>> Alphabetically this should come before /soc.
> Okay
>>
>> Konrad
>>> +        compatible = "qcom,glink-rpm";
>>> +        interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>>> +        qcom,rpm-msg-ram = <&rpm_msg_ram>;
>>> +        mboxes = <&apcs_glb 0>;
>>> +
>>> +        rpm_requests: glink-channel {
>>> +            compatible = "qcom,rpm-ipq9574";
>>> +            qcom,glink-channels = "rpm_requests";
>>> +        };
>>> +    };
>>> +
>>>       timer {
>>>           compatible = "arm,armv8-timer";
>>>           interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> Best Regards,
> Devi Priya
