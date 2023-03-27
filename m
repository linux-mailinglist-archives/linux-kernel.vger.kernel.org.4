Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CA6C9EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjC0JAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjC0I7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:59:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513B5FFC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:57:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g17so10360873lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679907464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qO70piV6L5co88Z+RIZ+x/s1SHwenabxlhCDD1NSUPA=;
        b=E83RXsk7l6zQ0U5TKuJdTMB6PM7vC3IgyA9euiyfZNFi1FPMEWvptlGoDBZBZLYAp0
         H+Qt/w7lvY8u9jpU15Aedh2F9OG4MiqW6UdQecxZNZkGTBLe5nirWcZE6furimBnIWlL
         0XUFrkcx7baqB8BKCZgt7F2WXwbsn0duPHdqSiDXqyRICaD5r11H3DyDeH1RpPRk1VSX
         RyAxQBVkg91sIHWik56QBip0sI/lm7yMV0UYKjbfxCSPpT4P4AJMJgeqIsJDZ237/ojf
         7Lm+/SdP+QWO81Gozcbj5pBZhvnVmOxP2lOYcKvWKqvB03IMEQIsSvP9sGD/UH8IUZmx
         41QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679907464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qO70piV6L5co88Z+RIZ+x/s1SHwenabxlhCDD1NSUPA=;
        b=JAHNpws7m43tYj5z0rx9+i8tuLZJkxfLktdn34duBEltz6hS0dH5qOxN//4U/rh7xZ
         Jv6OtcfTIagyLI/guNRV9GP+0JKd8g2SQIzXsYg+isSgKvicQ4NHvniVkeqHvGWIK+Sp
         IYPklfZoakJcUVOrSb/o127c+cQECJSDGxVBL/FJAjikiG92csTaJd3wJxQjzPtDKbeB
         nXgHeiV3uwjdkNs0X2WKK+d1af/QYZ3mBtiPCrLxubwPSFQyYAQO/P3t7M7Dt2Fj6Nu5
         JXUBfrio5cWnSOYIA+QQ1vLP1+U9sddeqnPUaqi5rNkqAjJRQL0WMn5n10Tuc5IxLnyF
         Biyg==
X-Gm-Message-State: AAQBX9enqOpaBTcO4zcHbbzOss+SKxdszJ3fGsiAtbbM+XKyVOJmEnLw
        7xqX8FmP8ivgr6rlRhgjnuiFig==
X-Google-Smtp-Source: AKy350bq7PWQ0j+JQ0lJzGuzoliax57NGExzC4FLMTzh59uAlRnHrFWt+qseT5HE34jJbSBYcBnkIA==
X-Received: by 2002:a05:6512:25b:b0:4e9:7d60:7108 with SMTP id b27-20020a056512025b00b004e97d607108mr2871056lfo.53.1679907463889;
        Mon, 27 Mar 2023 01:57:43 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y1-20020a2eb001000000b002986854f27dsm4536171ljk.23.2023.03.27.01.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:57:43 -0700 (PDT)
Message-ID: <d9cd11e1-1d71-e54f-5d3a-f3de54d71f01@linaro.org>
Date:   Mon, 27 Mar 2023 10:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324201528.2540564-1-elder@linaro.org>
 <20230324201528.2540564-2-elder@linaro.org>
 <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
 <f600869e-0fd8-ca19-1baf-d23f7a9103d6@linaro.org>
 <5f825218-c583-7ccd-6845-684a4b166abe@ieee.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5f825218-c583-7ccd-6845-684a4b166abe@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.03.2023 18:04, Alex Elder wrote:
> On 3/25/23 7:12 AM, Konrad Dybcio wrote:
>>
>>
>> On 25.03.2023 12:14, Krzysztof Kozlowski wrote:
>>> On 24/03/2023 21:15, Alex Elder wrote:
>>>> Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
>>>> nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.
>>>>
>>>> Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
>>>> Zone on this platform.
>>>>
>>>> Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>>> ---
>>>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>>>>   arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>>>>   2 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> index ed98c83c141fc..72e25de0db5fc 100644
>>>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>>>>       status = "okay";
>>>>   };
>>>>   +&ipa {
>>>> +    qcom,gsi-loader = "skip";
>>>> +    status = "okay";
>>>> +};
>>>> +
>>>>   &qpic_bam {
>>>>       status = "okay";
>>>>   };
>>>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> index 192f9f94bc8b4..360d6dc144811 100644
>>>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> @@ -11,6 +11,7 @@
>>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>>> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>>>>     / {
>>>>       #address-cells = <1>;
>>>> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>>>>               #hwlock-cells = <1>;
>>>>           };
>>>>   +        ipa: ipa@3e04000 {
>>>> +            compatible = "qcom,sdx65-ipa";
>>>> +
>>>> +            iommus = <&apps_smmu 0x5e0 0x0>,
>>>> +                 <&apps_smmu 0x5e2 0x0>;
>>>> +            reg = <0x3f40000 0x10000>,
>>>> +                  <0x3f50000 0x5000>,
>>>> +                  <0x3e04000 0xfc000>;
>>>> +            reg-names = "ipa-reg",
>>>> +                    "ipa-shared",
>>>> +                    "gsi";
>>>> +
>>>> +            interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
>>>> +                          <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
>>>> +                          <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>>>> +                          <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>>>> +            interrupt-names = "ipa",
>>>> +                       "gsi",
>>>> +                       "ipa-clock-query",
>>>> +                       "ipa-setup-ready";
>>>
>>> These look misaligned.
>>>
>>> With above:
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> With this and moving iommus below interconnect:
> 
> Is there guidance somewhere that states what order should be
> used for these properties?
This is a very slippery topic, but..

 Why should iommus be below
> interconnects?
..everybody agrees iommus shouldn't between compatible and
reg (these two go first hand-in-hand) and most of our DTs
have it somewhere low, often below interconnect.

In a perfect world we'd have a computer taking care of this
but for now it remains an open question.

> 
> As I said to Krzysztof, I *think* all of the IPA nodes look
> like this; should all of them be updated to follow whatever
> the preferred convention is?
This is the ugly part of this, we don't have a solid,
widely-agreed-upon scheme of ordering properties other than
some loose guidelines (e.g. compatible, reg, ...,  status),
so I think it's not worth making extra noise in existing files
until figure it out.

Konrad
> 
> Thanks.
> 
>                     -Alex
> 
> 
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Konrad
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
> 
