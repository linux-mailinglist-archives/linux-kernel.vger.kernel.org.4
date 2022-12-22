Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61EE6540B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiLVMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiLVMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:08:04 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A130F48
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:59:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so2376310lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHl0N0Gli/0G+EmrA/OrDpD5CHzulngYe1bGgAGE/50=;
        b=sqjiixnGol8RzJdzNOrG9AMlhwT2UCOEdCAb43qF3rph/+DNeUCty327K3rUamv+Q6
         8bjnn9jBa3MA/95xKBhpG2KB43nD3GqMiNrZrcMHR59x7S1BbWgV/cjKYx7qa/R+H1Qq
         5FTyZUjYedhnE1KXNebOXXgHlPz9P8jczmQ7lYiZfqxuPkH72QUUd2z1D3QJWT8/r7ij
         LfdX+gHu+w6Ool3Ndtg67Aj9jZYXNPhACOfMgeVwbcVrhESdAUx7Tc7CuH2fI/wyYkHN
         c5jq42fQTEBdkq511vQvLwvC/uZ/D+8pmxpuPGaloxmodU32JBXDEdZqU8uuV06U8qFV
         CigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHl0N0Gli/0G+EmrA/OrDpD5CHzulngYe1bGgAGE/50=;
        b=faCroXW9sLinNYUxOha5tocG3gwJJpIiNi8MwnlbqOARAuFiSKSCzXw8p/CBefEyb1
         RlZzaZkjVMCI2u1lsG4a81fNTnCMisDLxlW7cxMCYHVt0bwKEPM65A8sYKaQUbcQ25zd
         bd5MyO7fyjGJW9HLoTE4Vaacy6yaL93lgRFKeSQkT18336/8hhqU0ltudoE/aNb6H3Il
         OIuxNqMEwjC1IY15zawVSUCKjdzu+JY2GwCv4VGHEmv2mOqPn8NWyxodD69VKKG/U9Es
         lTikHcP92PZg7g0cn9ouR2hGO517IHedpoMFdaOFEq2xG+rFmrfjB99AJBvCGojTDAnP
         1ASA==
X-Gm-Message-State: AFqh2kpX5VSUESBF8ABt8IHsSBItQ9A05Qid5ZPt+f90sPMgfzPMfg4Q
        Zpp2HSBpwXRksXFGNg6W+uu/Rg==
X-Google-Smtp-Source: AMrXdXv8ngh2PzTydXKYEzob0G+s1fx/J4ItZ3wK4E7wIkVxuJU6mfzYD3YIu31sI8aMBwS9F01VJQ==
X-Received: by 2002:a05:6512:3c88:b0:4b4:e4a1:2fc6 with SMTP id h8-20020a0565123c8800b004b4e4a12fc6mr1982162lfv.68.1671710338852;
        Thu, 22 Dec 2022 03:58:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y6-20020a196406000000b004a03d5c2140sm48932lfb.136.2022.12.22.03.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:58:58 -0800 (PST)
Message-ID: <a8d9a4c1-76e6-905b-4987-d153e7e29ee9@linaro.org>
Date:   Thu, 22 Dec 2022 12:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [EXTERNAL] Re: [PATCH] arm64: dts: ti: k3-j721s2: Add support for
 ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kristo@kernel.org, nm@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20221220101249.46450-1-b-kapoor@ti.com>
 <ff5b09db-4900-0b5b-e821-fa05b8d907a4@linaro.org>
 <a4d11974-eb97-bfa2-790f-3016950ea961@ti.com>
 <79ffe459-3827-ea67-e854-8eef3d9b630b@linaro.org>
 <a22a2c32-3b52-8bdf-f959-c95554125c64@ti.com>
 <5e8d7388-1b2b-cebb-fd09-38b4364c00e1@linaro.org>
 <f89a1758-7cf5-3bb1-e28e-bb01fd6de9d3@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f89a1758-7cf5-3bb1-e28e-bb01fd6de9d3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 12:53, Bhavya Kapoor wrote:
> 
> On 22/12/22 16:16, Krzysztof Kozlowski wrote:
>> On 22/12/2022 11:39, Bhavya Kapoor wrote:
>>> On 21/12/22 13:24, Krzysztof Kozlowski wrote:
>>>> On 21/12/2022 06:42, Bhavya Kapoor wrote:
>>>>> On 20/12/22 16:20, Krzysztof Kozlowski wrote:
>>>>>> On 20/12/2022 11:12, Bhavya Kapoor wrote:
>>>>>>> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
>>>>>>> for 8 channel ADCs for J721s2 SoC.
>>>>>>>
>>>>>>> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
>>>>>>> ---
>>>>>>>     .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>>>>>>>     .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>>>>>>>     2 files changed, 55 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> index a7aa6cf08acd..67593aa69327 100644
>>>>>>> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
>>>>>>> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>>>>>>>     	pinctrl-0 = <&mcu_mcan1_pins_default>;
>>>>>>>     	phys = <&transceiver2>;
>>>>>>>     };
>>>>>>> +
>>>>>>> +&tscadc0 {
>>>>>>> +	status = "okay";
>>>>>>> +	adc {
>>>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>>>> +	};
>>>>>>> +};
>>>>>>> +
>>>>>>> +&tscadc1 {
>>>>>>> +	status = "okay";
>>>>>>> +	adc {
>>>>>>> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
>>>>>>> +	};
>>>>>>> +};
>>>>>>> \ No newline at end of file
>>>>>> This is a friendly reminder during the review process.
>>>>>>
>>>>>> It seems my previous comments were not fully addressed. Maybe my
>>>>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>>>>> Please go back to the previous discussion and either implement all
>>>>>> requested changes or keep discussing them.
>>>>>>
>>>>>> Thank you.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>> Hi , I thought i did addressed the feedback since tscadc is just a
>>>>> wrapper node.
>>>>>
>>>>> The actual adc node is inside of tscadc node.
>>>> Read the feedback, from all emails.
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hi , i have gone through all earlier mails but can't find anything else.
>>> Can you point out again whats the issue.
>> "And this is a v2? Or resend? Or something else?"
>>
>> You miss proper versioning and changelog.
>>
>> Additionally - I commented just before error in your patch. You must fix
>> it, not ignore it, even though I did not point it out before.
>>
>> Best regards,
>> Krzysztof
> 
> Hi, i had replied to that as well earlier. You can check that out 
> https://lore.kernel.org/all/89ce3639-e979-e369-657a-20aea4295970@ti.com/ .
> 
> Maybe you missed out on that.

So this is a duplicate? OK, then this patch can be:
NAK

Best regards,
Krzysztof

