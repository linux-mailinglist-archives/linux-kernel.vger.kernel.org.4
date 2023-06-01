Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497C271A283
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjFAPZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjFAPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:25:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3931A2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:25:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso128858866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685633124; x=1688225124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucbIFjUd4hbM3kJCf+tCqLtfR1Vug8h2LYP6EwLf5Fg=;
        b=JLwL08/9M1HY17U+bVLnHrRzFxdaFqHDKspfPLW8Q2qarRRTvqcMEDny2U3Gdn5eN8
         DqMkYxH6wrFZsT0XPwYOcpv5k9k56e+CKVlrLdXL3wQAIHw7p2QvcywxNicysEpfRW7M
         tqIT1VG4rkHiUYqeW2OJWFASMBKEYapsoxis42dNc+tQcX3MbTwbxOJnveZIINS7SlXg
         bTnoTEdVRR+X1Ka5RUJksPmOuXR0rPd5w6EHo+VFEB79JiE5SmTqdMK1kKZAjzVNQ/kG
         WExSpV/6bWnnjw3mY2O1wttKDxsUl6IsacvwsNY9S+EfFU09JBPtQhw5066mpObdcis+
         SEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633124; x=1688225124;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucbIFjUd4hbM3kJCf+tCqLtfR1Vug8h2LYP6EwLf5Fg=;
        b=WM9M+r5XbDaLvxQHogLv7kKVURDt35auQkxWpdoc5y/dyF1nfzY5skvNH5kJZjDdOh
         37bR94AHMlcYsm5pXQMaeJRRcbHWEFR+8Meb+TbJwX7vCDZqcffa8IyuMA4Tfl/o6xNZ
         AhZttv87sRx8n4NtPWvSmq4HWL/X07goIxs54bosjyvASrl5bEzEAAcRts35BUEg7bi5
         //GQCA6qW6uvpMy2q4znUw7OMbPUJ/ncAePViomCtK+Bi5EeeEniu/JzSf5CvGapsBvB
         hlOmYwT/QOdran6NSMXhv5VYEWIx5ysx8LhklJEgoq1jDB3q7viYqdFL0hzOo9Y/aWuN
         UTMQ==
X-Gm-Message-State: AC+VfDwWnwi2MKcoJi8HGd3M8+HDwJZfYz4Fa8Z6okRpHjL3DGb+KQ+a
        JnHFyaFm+/ZzE+SAaj844lSEKQ==
X-Google-Smtp-Source: ACHHUZ7OiJxITR7W/hPqXBP5aNipqz217ocgvmsMYUjz1rUXMt7dIpSeu4jJAHWBz+ETZrWtWpLsmw==
X-Received: by 2002:a17:907:97c3:b0:974:b15:fcda with SMTP id js3-20020a17090797c300b009740b15fcdamr9860419ejc.54.1685633124426;
        Thu, 01 Jun 2023 08:25:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709061c9000b00965b0eb7b0csm10649824ejh.103.2023.06.01.08.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:25:24 -0700 (PDT)
Message-ID: <24c2b94a-40de-b214-1931-ec44162f4973@linaro.org>
Date:   Thu, 1 Jun 2023 17:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>, robh+dt@kernel.org,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
 <20230516-footprint-handoff-bcd553ff6146@spud>
 <9B1EE405-77D3-4980-9A13-9D4F87C1A64F@geanix.com>
 <20230523-flaccid-fossil-c9d09838dc64@spud>
 <658510B5-702B-464A-BA55-01E2B315BE39@geanix.com>
 <20230524-ellipse-dagger-72f850253ea0@wendy>
 <24418459-DE19-4575-835B-8673F279993C@geanix.com>
 <b9297205-82fa-8cdf-550e-a53c073e0a9d@linaro.org>
 <4BD5682B-1A36-427A-8BDA-3159182DA057@geanix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4BD5682B-1A36-427A-8BDA-3159182DA057@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 16:05, Sean Nyekjaer wrote:
> Hi Krzysztof,
> 
>> On 1 Jun 2023, at 09.12, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/05/2023 12:30, Sean Nyekjaer wrote:
>>>
>>>
>>>> On 24 May 2023, at 12.08, Conor Dooley <conor.dooley@microchip.com> wrote:
>>>>
>>>> On Wed, May 24, 2023 at 10:16:13AM +0200, Sean Nyekjær wrote:
>>>>> Hi Conor,
>>>>>
>>>>>> On 23 May 2023, at 19.29, Conor Dooley <conor@kernel.org> wrote:
>>>>>>
>>>>>> On Tue, May 23, 2023 at 11:55:50AM +0200, Sean Nyekjær wrote:
>>>>>>>> On 16 May 2023, at 20.06, Conor Dooley <conor@kernel.org> wrote:
>>>>>>>> On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
>>>>>>>>> Document the new optional "fsl,pmic-poweroff" property.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>>>>>>>> ---
>>>>>>>>> Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
>>>>>>>>> 1 file changed, 8 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>>> index 9573e4af949e..5183a7c660d2 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>>> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
>>>>>>>>> @@ -26,6 +26,14 @@ properties:
>>>>>>>>>
>>>>>>>>> interrupt-controller: true
>>>>>>>>>
>>>>>>>>> +  st,pmic-poweroff:
>>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>>> +    description: |
>>>>>>>>> +      if present, configure the PMIC to shutdown all power rails when
>>>>>>>>> +      power off sequence have finished.
>>>>>>>>> +      Use this option if the SoC should be powered off by external power management
>>>>>>>>> +      IC (PMIC).
>>>>>>>>
>>>>>>>> Just reading this description, this is sounding quite like a "software
>>>>>>>> behaviour" type of property, which are not permitted, rather than
>>>>>>>> describing some element of the hardware. Clearly you are trying to solve
>>>>>>>> an actual problem though, so try re-phrasing the description (and
>>>>>>>> property name) to focus on what exact hardware configuration it is that
>>>>>>>> you are trying to special-case.
>>>>>>>> Krzysztof suggested that the samsung,s2mps11-acokb-ground property in
>>>>>>>> samsung,s2mps11.yaml is addressing a similar problem, so that could be
>>>>>>>> good to look at.
>>>>>>>
>>>>>>> Better wording?
>>>>>>>    Indicates that the power management IC (PMIC) is used to power off the board.
>>>>>>>    So as the last step in the power off sequence set the SWOFF bit in the
>>>>>>>    main control register (MAIN_CR) register, to shutdown all power rails.
>>>>>>
>>>>>> The description for the property that Krzysztof mentioned is
>>>>>> samsung,s2mps11-acokb-ground:
>>>>>>  description: |
>>>>>>    Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
>>>>>>    the PMIC must manually set PWRHOLD bit in CTRL1 register to turn off the
>>>>>>    power. Usually the ACOKB is pulled up to VBATT so when PWRHOLD pin goes
>>>>>>    low, the rising ACOKB will trigger power off.
>>>>>>
>>>>>> In other words, I am asking what (abnormal?) scenario there is that means
>>>>>> you need the property, rather than what setting the property does.
>>>>>> Or am I totally off, and this is the only way this PMIC works?
>>>>>
>>>>> Indicates that the power management IC (PMIC) turn-off condition is met
>>>>> by setting the SWOFF bit in the main control register (MAIN_CR) register.
>>>>> Turn-off condition can still be reached by the PONKEY input.
>>>>>
>>>>> ?
>>>>>
>>>>> I must admit I’m somewhat lost here :)
>>>>
>>>> Sorry about that. I'm trying to understand what is different about your
>>>> hardware that it needs the property rather than what adding the property
>>>> does. If you look at the samsung one, it describes both the
>>>> configuration of the hardware ("ACOKB pin of S2MPS11 PMIC is connected to
>>>> the ground") and how that is different from normal ("Usually the ACOKB is
>>>> pulled up to VBATT so when PWRHOLD pin goes low, the rising ACOKB will
>>>> trigger power off.")
>>>>
>>>> Looking at your datasheet, you don't have such a pin though - just the
>>>> sw poweroff bit & the PONKEY stuff. My angle is just that I am trying
>>>> to figure out why you need this property when it has not been needed
>>>> before. Or why you would not always want to "shutdown all power rails
>>>> when power-off sequence have finished". I'm sorry if these are silly
>>>> questions.
>>>>
>>>
>>> No silly questions, maybe they trick me to come up with the correct answer :D
>>>
>>> Basically without this, you won’t be able to power off the system
>>> other than hitting the PONKEY.
>>> So it’s a new feature that wasn’t supported before.
>>> Maybe this feature should not be optional?
>>
>> You are still describing what driver should do with registers. What you
>> are missing is describing real cause for this. It's exactly the same
>> case as was with s2mps11.
> 
> I didn’t mention anything with registers in the patch:
> 
> if present, configure the PMIC to shutdown all power rails when
> power off sequence have finished.
> Use this option if the SoC should be powered off by external power management
> IC (PMIC).
> 
> ^^ That’s is exactly what is happening if the option is enabled.
> 
> Do you have a suggestion wording?
> What do you think about removing this option and make it default behaviour?

Again - you write what the driver should do ("configure the PMIC") when
something in Linux happens ("power off sequence have finished"). Exactly
the same case as s2mps11. Look how it was worded there. You need to find
 the real cause, why such actions are required on which board.

Otherwise it does not warrant DT property and just perform it always.

Best regards,
Krzysztof

