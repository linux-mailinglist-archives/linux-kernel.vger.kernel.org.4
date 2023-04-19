Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EDD6E78A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjDSLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjDSLbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:31:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC68118CD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:31:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso2705265e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681903863; x=1684495863;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7UCE8GzO2c65rYrCJp4d+7DvvzyB48DxhH3k91mObY=;
        b=FQt2xR2dcMbRk1kYnBpw/JhzL8174t3yF1k7CgYZjcgnPbKWgvpocUOX+nfnV43ZyU
         Yp+2J+AU9FqoM97XRS+lR4dCQMVSEO7s7NtmMpue+pL/3F+pX2uIcl5mKY1EnP32zEBn
         lUAG5ewl3I68KnQuMpfJLOucbg7VdsA1XVBEJYQzKDbwT41mtLRi9X0/2W65wXbWzZVj
         Szag6Ej+vctVxMPOGIHRataW1PotxJ4+3hqAiSq2lqi6hCc3WV4vMbYe0njLEJvuBHdV
         /jHNm7DdbCeqe2UXhLs5bHbcmRTEP4lvO/l36mmIBsYVUq/aPIXlyKJrAKZGv6DZgKpN
         D5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903863; x=1684495863;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7UCE8GzO2c65rYrCJp4d+7DvvzyB48DxhH3k91mObY=;
        b=FTYhaIwvr4UI7HKUmOB6BoZuHtYccWyQYERuLMYXCEyygBKAJiJ0GaQWOM+WdX1ylh
         0AmKjQPcfjTiGXsW29WyHxy57H3SGi4KxEK1x34UjE7ZYZ//4tZ861YLv8GlcRJXBR+g
         MIAObb79wqsIuQQD9bnyJswYr/ujSzbkA2Q6owA6c3AHK7HOXsY0Kon8IxBKY7tI2Ou2
         2NMi+S82fYb5nZcCUQEWJ1VWCCA6fMbgJDYH+hl5xjJuOZVP4HbRQJNLMucj1IeFV92i
         soQ7EM7CBMQgCjWjLojkG7pi9aWMqsVbl/taEZALn1Wzh9o+/kz8Sc2b8cVhAfGSE0ti
         rHCg==
X-Gm-Message-State: AAQBX9fGxPOlVYaGaI2bDXkkLn0ptuiytUFp7x3sHjDrBCW53Mjw06DW
        vbwJ9nQN2w0Y7lycHDKt+B9VeA==
X-Google-Smtp-Source: AKy350aEn0e9OD1X7a2puiTo3/NeCpeyOKBpGnXQIA2KfNbtpPL6PABCjjk1R4ersu0zuSQM9Uxs2w==
X-Received: by 2002:ac2:47ea:0:b0:4ec:9e4a:f893 with SMTP id b10-20020ac247ea000000b004ec9e4af893mr4115565lfp.56.1681903863040;
        Wed, 19 Apr 2023 04:31:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e98d6000000b002a76c16ad65sm2903450ljj.87.2023.04.19.04.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:31:02 -0700 (PDT)
Message-ID: <6407af2a-18c6-9baf-cc9b-dcf7001812b7@linaro.org>
Date:   Wed, 19 Apr 2023 13:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way to
 enable unused clock cleanup
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
 <ZD2YYrOdQMD3pi7u@gerhold.net>
 <d63d4896afe8a1a901470f88862ce608.sboyd@kernel.org>
 <3873483f-7f7d-a146-cca9-b50f054289d4@linaro.org>
In-Reply-To: <3873483f-7f7d-a146-cca9-b50f054289d4@linaro.org>
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



On 18.04.2023 12:33, Konrad Dybcio wrote:
> 
> 
> On 18.04.2023 02:19, Stephen Boyd wrote:
>> Quoting Stephan Gerhold (2023-04-17 12:05:06)
>>> On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
>>>> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
>>>> (or at least most) of the oneline peripherals ask the interconnect
>>>> framework to keep their buses online and guarantee enough bandwidth,
>>>> we're relying on bootloader defaults to keep the said buses alive through
>>>> RPM requests and rate setting on RPM clocks.
>>>>
>>>> Without that in place, the RPM clocks are never enabled in the CCF, which
>>>> qualifies them to be cleaned up, since - as far as Linux is concerned -
>>>> nobody's using them and they're just wasting power. Doing so will end
>>>> tragically, as within miliseconds we'll get *some* access attempt on an
>>>> unlocked bus which will cause a platform crash.
>>>>
>>>> On the other hand, if we want to save power and put well-supported
>>>> platforms to sleep, we should be shutting off at least some of these
>>>> clocks (this time with a clear distinction of which ones are *actually*
>>>> not in use, coming from the interconnect driver).
>>>>
>>>> To differentiate between these two cases while not breaking older DTs,
>>>> introduce an opt-in property to correctly mark RPM clocks as enabled
>>>> after handoff (the initial max freq vote) and hence qualify them for the
>>>> common unused clock cleanup.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>>> index 2a95bf8664f9..386153f61971 100644
>>>> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>>> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
>>>> @@ -58,6 +58,12 @@ properties:
>>>>      minItems: 1
>>>>      maxItems: 2
>>>>  
>>>> +  qcom,clk-disable-unused:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Indicates whether unused RPM clocks can be shut down with the common
>>>> +      unused clock cleanup. Requires a functional interconnect driver.
>>>> +
>>>
>>> I'm surprised that Stephen Boyd did not bring up his usual "rant" here
>>> of moving the interconnect clock voting out of rpmcc into the
>>> interconnect drivers (see [1], [2]). :-)
>>
>> :) I was hoping to get a fix for disabling unused clks during late init
>> at the same time. Shucks!
>>
>>>
>>> I was a bit "cautious" about it back then but at this point I think it
>>> kind of makes sense. Make sure to read Stephen's detailed explanation in
>>> https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657387381953@swboyd.mtv.corp.google.com/
>>>
>>> We keep looking for workarounds to prevent the CCF from "messing" with
>>> interconnect-related clocks. But the CCF cannot mess with "clocks" it
>>> does not manage. The RPM interconnect drivers already talk directly to
>>> the RPM in drivers/interconnect/qcom/smd-rpm.c. I think it should be
>>> quite easy to move the QCOM_SMD_RPM_BUS_CLK relates defines over there
>>> and just bypass the CCF entirely.
>>
>> Please do it!
> Okay, that's a plan..
> 
>>
>>>
>>> For backwards compatibility (for platforms without interconnect drivers)
>>> one could either assume that the bootloader bandwidth votes will be
>>> sufficient and just leave those clocks completely alone. Or the
>>> "icc_smd_rpm" platform device could initially make max votes similar to
>>> the rpmcc device. By coincidence the "icc_smd_rpm" platform device is
>>> always created, no matter how the device tree looks or if the platform
>>> actually has an interconnect driver.
>>>
>>
>> Yeah that's a good plan. Suspend will be broken or burn a lot of power,
> (that's what happens as of today, so sgtm!)
> 
>> but presumably the new DTB will be used fairly quickly. Or you can
>> implement something like clkdev for interconnects that lets you hack up
>> an association between interconnects and consumers for existing DTs and
>> then drop those lookups months later.
> Uh.. let's not.. Let's just contain it in the interconnect driver.
> 
> The buses will be at bearable frequencies coming from the bootloader
> (as RPM, storage etc. are enabled) and boosting them at icc_rpm_smd
> probe sounds sane.
What should we do about the non-bus RPM clocks though? I don't fancy
IPA_CLK running 24/7.. And Stephan Gerhold was able to achieve VDD_MIN
on msm8909 with these clocks shut down (albeit with a very basic dt setup)!

Taking into account the old interconnect-enabled DTs, some of the
clocks would need to be on so that the QoS writes can succeed
(e.g. the MAS_IPA endpoint needs IPA_CLK), it gets complicated again..

I suppose something like this would work-ish:

0. remove clock handles as they're now contained within icc and
   use them as a "legacy marker"
1. add:
	if (qp->bus_clocks)
		// skip qos writes

This will:
- let us add is_enabled so that all RPM clocks bar XO_A will be cleaned up
- save massively on code complexity

at the cost of retroactively removing features (QoS settings) for people
with old DTs and new kernels (don't tell Torvalds!)

This DTB ABI stuff really gets in the way sometimes :/ We're only now
fixing up U-Boot to be able to use upstream Linux DTs and other than
that I think only OpenBSD uses it with 8280.. Wish we could get rid of
all old junk once and then establish immutability but oh well..

Konrad
> 
> Konrad
