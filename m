Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14362BE74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiKPMmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiKPMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:42:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8F6376
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:42:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s8so12150727lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrPGeIjext5JNhSVxUCmWbpHHI7jtSW713ZjQuNCGds=;
        b=WDh3HKx5Bbx3SNMUBfff+9Vn1uQRJCaKUyLSwYr0MaYWIgPJ3aia9Xr5zcIQYdHffi
         hshDECtFkRmWXDDISQHxcyS+m3/vtKPZV2HKpbkqxR8ZRLyxycB2swacTLoQ38i04V3y
         /oM6lEwjBr/KGyiULiiyHX8Pzv2f5tdwv23gYIgynjZJa+zAE8WNNdH16vJgK+mwWhoe
         oNkbQub3hnkOiIzdlZoI3Pmvf4Dg5mZbLzufjPXA1eFuL7bHEaF506kWNYDCXbvMQKTz
         eqSrDTKqQMNeoaP3PGeBZsLiHqx+mHn2Bz1+nkZ924CnIldtts1N7DYrF/1N1L71tHlS
         O2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrPGeIjext5JNhSVxUCmWbpHHI7jtSW713ZjQuNCGds=;
        b=m0+7DXWuOi3eeO/qeFat5gzOXB9YE2yMwxLsw0sQrN1JttToqrN9hY9/RA9DjLGxOK
         XNbkywYoH/Kqh/6W3zFSbYjWy2acrehRszqMWRC5YGyCtkCIEgHdThlpyjkT017fzG6i
         ceGx+WU0zHgRS/FUNtsO6uHlt9yZWzrpW37bCjFr1rsRrFYqnLFY4wR1euV15+jAIkx2
         efHWl5xkE/BxjA1mZ44BDjpoLCYrBOkKbDU7G79x55jJkHfSEnB/iDW2xpf8EYhNAs7c
         zcYUUn8FtN/xCQ0ymJM0OPSCNozl07Spd6sA0HZOPDntppJ/AllkQm9/wN6hz7BmXbtd
         ayqA==
X-Gm-Message-State: ANoB5pn9+8zuzNDNs9WVwFDIWEDJxr0yFEZYlVACc7UqPUj1HBz1rzp6
        wyyM6s87XcCTK3L0hmKWNeBb2w==
X-Google-Smtp-Source: AA0mqf5GIerHpKxp4+yhreyljTRcuU66KevxYftRVwqsSVK/66JE2J4JF24GEpo2o7Oo+9BDksDG5w==
X-Received: by 2002:ac2:530c:0:b0:4b4:aed7:4aa5 with SMTP id c12-20020ac2530c000000b004b4aed74aa5mr1169682lfh.447.1668602553331;
        Wed, 16 Nov 2022 04:42:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e2-20020a056512090200b004ac393ecc34sm2587943lft.302.2022.11.16.04.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:42:32 -0800 (PST)
Message-ID: <aa3234a5-1beb-65ef-90fc-95d16d6730c9@linaro.org>
Date:   Wed, 16 Nov 2022 13:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
 <20221116101314.52887-3-krzysztof.kozlowski@linaro.org>
 <7605af5f-a828-5df7-48b8-b543edb0f9b1@linaro.org>
 <bde68c28-bf4c-405f-ef2a-f56db7654d25@linaro.org>
 <1ce84668-5f21-5e62-6a02-be7c6e79012e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1ce84668-5f21-5e62-6a02-be7c6e79012e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 12:17, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 11:40, Krzysztof Kozlowski wrote:
>> On 16/11/2022 11:20, Konrad Dybcio wrote:
>>>
>>>
>>> On 16/11/2022 11:13, Krzysztof Kozlowski wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
>>>> LPASS pin controller.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> ---
>>>>
>>>> Changes since v2:
>>>> 1. Use lower-case hex.
>>>>
>>>> Changes since v1:
>>>> 1. Whitespace cleanups.
>>>> 2. Correct include - do not use deprecated one.
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>>>>    1 file changed, 295 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index 4b0a1eee8bd9..747440d0445a 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -15,6 +15,7 @@
>>>>    #include <dt-bindings/interconnect/qcom,sm8450.h>
>>>>    #include <dt-bindings/soc/qcom,gpr.h>
>>>>    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>>> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>>>>    #include <dt-bindings/thermal/thermal.h>
>>>>    
>>>>    / {
>>>> @@ -2097,6 +2098,212 @@ compute-cb@3 {
>>>>    			};
>>>>    		};
>>>>    
>>>> +		wsa2macro: codec@31e0000 {
>>>> +			compatible = "qcom,sm8450-lpass-wsa-macro";
>>>> +			reg = <0 0x031e0000 0 0x1000>;
>>>> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>>> +				 <&vamacro>;
>>>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>>>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>>> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>>> +			assigned-clock-rates = <19200000>, <19200000>;
>>>> +
>>>> +			#clock-cells = <0>;
>>>> +			clock-output-names = "wsa2-mclk";
>>>> +			#sound-dai-cells = <1>;
>>> I think I'm being a bit too picky, but #-cells could go as the last
>>> bunch of properties.
>>
>> I was thinking about this as well, but some of other codecs which are
>> very similar (also "macro") do not have pinctrls and this makes them
>> unified with additions at the end.
>>
>> Are you sure you still prefer alphabetical order?
> Thinking about it, IMO it makes sense to add things "roughly where they 
> belong", a.k.a if there was a codec that for whatever reason also 
> required a power domain, we would stick it somewhere in the middle and 
> not at the end..

OK, I'll re-order these.

Best regards,
Krzysztof

