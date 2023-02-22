Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3708169F2C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBVKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBVKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:35:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD76360A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:35:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bt28so567124wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXAec7hdGpC0cRHQxTDiQ7Cz8xMZHNw4itSIlLrTsyc=;
        b=KZympCWq+AhURlwzihrcQwiLUl1W2L3soIq4o/5W3dA/V2bMforhtNlzTdRx4fbw18
         1zDq20qEocY5rGP4/1miHo03jJ2Sahqd0+IK0wIDY1tyRzLzXfHhiF2VZ9is3YBJKDwp
         KvhfOOKbt36Hk9qd0kqIkHxKugYjetc3rUuo5UrkNbEuSH5aiZ4RJk6Pj3CeobA7K5+q
         /PGPbCobacHPEQVhjNxm6Wto1ENZ5vFmIvo6fHPg0VW90GVDoTV5Zl3z7B4c31NMxXux
         UZRkapGSMcFej5spvKCKNTCLjQ3CeruDSWVntxYcJC7jqdJtOB8rZgSMr4rmFeU7GwwR
         XTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXAec7hdGpC0cRHQxTDiQ7Cz8xMZHNw4itSIlLrTsyc=;
        b=RgguR/CYsJWu0Vx2/eDM25UFg9CgLiPWOS6USs93OoWeGMQAC8ILo1e2VliT25ZPIh
         uszZhjBX+RPMhXLi0NE6bBg/GRrAQI/z+8mEVF/nJRC587hq5jJ2o9y0DiF0o/iL3zsp
         Aqy2TMsebHHzcTWoeqfWQJojnke4jsjP6grgNBK7zEyFQ4IDHKv9ZRdV7lG3wuRAv4dZ
         zNXMAVC78AxA04yLVhWR2+tBMnOovdV6kEEisqeVTC27bJxJsBMkE/VoBlbLjcEe1w9l
         dv7ZNR7+LpsdghdO0jp86AgvZsH8Ab7mi7m6tlzi6/LC030W2B7eEj+nbJJsnBAPe/e/
         xdAw==
X-Gm-Message-State: AO0yUKWN8YnRl+ts3Gi7HIX5x3PObgFxx05m0jIxhnY0+rnL1cVWmiFR
        GJ+tVleLTEQx54zKEHmSa+1V0nehaWQg5saO
X-Google-Smtp-Source: AK7set9VBsEoZjd//633dzs89VM3T4hyQYwlcSRCneuZnxRdvzxaQXyvLn9Kk63Y10tFbg3esDnnzA==
X-Received: by 2002:a5d:4e03:0:b0:2c3:dc42:525d with SMTP id p3-20020a5d4e03000000b002c3dc42525dmr6639102wrt.36.1677062137112;
        Wed, 22 Feb 2023 02:35:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d6991000000b002c54911f50bsm7618318wru.84.2023.02.22.02.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 02:35:36 -0800 (PST)
Message-ID: <b7ca24ea-a265-81cb-3da6-19f938b35878@linaro.org>
Date:   Wed, 22 Feb 2023 11:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <676c7777-635c-cc1f-b919-d33e84a45442@linaro.org>
 <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <80d873d4-d813-6c25-8f47-f5ff9af718ec@linaro.org>
 <SEZPR06MB5269502D7CBCD5698B65FF9FF2A59@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <c0ac0ab3-87fc-e74a-b4e2-3cf1b3a8a5e2@linaro.org>
 <SEZPR06MB52698CCA6AE59DDC6C15CBE4F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <94238c42-1250-4d51-86e5-0a960dea0ffc@linaro.org>
 <SEZPR06MB52696835ED8E2709D6A454DAF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB52696835ED8E2709D6A454DAF2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 11:31, Ryan Chen wrote:
>> 	Board B
>>> --------------------------------------------------------
>> 	--------------------------------------------------------
>>> |    i2c bus#1(master/slave)  <--------------------> fingerprint.(can be unplug)
>> <--------------------> i2c bus#x (master/slave) |
>>> |    i2c bus#2(master) -> tmp i2c device     |
>> 	|									|
>>> |    i2c bus#3(master) -> adc i2c device      |					|
>> 								|
>>> --------------------------------------------------------
>> 	--------------------------------------------------------
>>> In this case i2c bus#1 need enable timeout, avoid suddenly unplug the
>> connector. That slave will keep state to drive clock stretching.
>>> So it is specific enable in i2c bus#1. Others is not needed enable timeout.
>>> Does this draw is more clear in scenario?
>>
>> I2C bus #1 works in slave mode? So you always need it for slave work?
> 
> Yes, it is both slave/master mode. It is always dual role. Slave must always work. 
> Due to another board master will send.

I meant that you need this property when it works in slave mode? It
would be then redundant to have in DT as it is implied by the mode.

> 
>>>
>>>>>
>>>>> So in those reason add this timeout design in controller.
>>>>
>>>> You need to justify why DT is correct place for this property. DT is
>>>> not for configuring OS, but to describe hardware. I gave you one
>>>> possibility
>>>> - why different boards would like to set this property. You said it
>>>> is not board specific, thus all boards will have it (or none of them).
>>>> Without any other reason, this is not a DT property. Drop.
>>>>
>>>>>>
>>>>>>>
>>>>>>>>> +
>>>>>>>>> +  byte-mode:
>>>>>>>>> +    type: boolean
>>>>>>>>> +    description: Force i2c driver use byte mode transmit
>>>>>>>>
>>>>>>>> Drop, not a DT property.
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +  buff-mode:
>>>>>>>>> +    type: boolean
>>>>>>>>> +    description: Force i2c driver use buffer mode transmit
>>>>>>>>
>>>>>>>> Drop, not a DT property.
>>>>>>>>
>>>>>>> The controller support 3 different for transfer.
>>>>>>> Byte mode: it means step by step to issue transfer.
>>>>>>> Example i2c read, each step will issue interrupt then enable next step.
>>>>>>> Sr (start read) | D | D | D | P
>>>>>>> Buffer mode: it means, the data can prepare into buffer register,
>>>>>>> then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling.
>>>>>>> The DMA mode most like with buffer mode, The differ is data
>>>>>>> prepare in DRAM, than trigger transfer.
>>>>>>>
>>>>>>> So, should I modify to
>>>>>>>   aspeed,byte:
>>>>>>> 	type: boolean
>>>>>>>     description: Enable i2c controller transfer with byte mode
>>>>>>>
>>>>>>>   aspeed,buff:
>>>>>>> 	type: boolean
>>>>>>>     description: Enable i2c controller transfer with buff mode
>>>>>>
>>>>>> 1. No, these are not bools but enum in such case.
>>>>>
>>>>> Thanks, will modify following.
>>>>> aspeed,xfer_mode:
>>>>>     enum: [0, 1, 2]
>>>>>     description:
>>>>>       0: byte mode, 1: buff_mode, 2: dma_mode
>>>>
>>>> Just keep it text - byte, buffered, dma
>>>>
>>>>>
>>>>>> 2. And why exactly this is board-specific?
>>>>>
>>>>> No, it not depends on board design. It is only for register control
>>>>> for
>>>> controller transfer behave.
>>>>> The controller support 3 different trigger mode for transfer.
>>>>> Assign bus#1 ~ 3 : dma tranfer and assign bus#4 ~ 6 : buffer mode
>>>>> transfer, That can reduce the dram usage.
>>>>
>>>> Then anyway it does not look like property for Devicetree. DT
>>>> describes hardware, not OS behavior.
>>>
>>> The same draw, in this case, i2c bus#1 that is multi-master transfer
>> architecture.
>>> Both will inactive with trunk data. That cane enable i2c#1 use DMA transfer
>> to reduce CPU utilized.
>>> Others (bus#2/3) can keep byte/buff mode.
>>
>> Isn't then current bus configuration for I2C#1 known to the driver?
>> Jeremy asked few other questions around here...
> 
> No, The driver don't know currently board configuration.

It knows whether it is working in multi-master/slave mode.

Best regards,
Krzysztof

