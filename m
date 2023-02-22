Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C578369F021
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBVIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjBVIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:25:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172722CFF5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:25:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ee7so11998048edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yd2Qwx1nvbdSkpNKN1vXqZLWIMV64pGDxkOP3Z4wAyI=;
        b=xysvr+IjvA1MGFmQYvICHIQWzKYW+rN58cB9ler//9XlFliSLip6yZXcTEMzFwaipL
         81zc/nZ8xWvzpgr0rdP9pLdp9SykNTH3fo4XWMfmh3Bfqq9x0/tVYunJcP4+iI6WGT0S
         PpOiEUQ7IHKk52ArZCvSO5pSTd5ZiC5dSGZZ+zPGyFAqVXrTNFjcJmZ75W1qwp4YuJD7
         4rUGtKYpi94YWfrPTmIO5HloZjHZrnyU99CZat14tw50fJvi0mkObEOMdwri0FJE+5cG
         SdlATfJrnocZZUAsYZ+jIi8JQw3g6E/i1+nuQikkLOYZgrxBs3wScOmvvnXiSb/DUzZI
         e1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd2Qwx1nvbdSkpNKN1vXqZLWIMV64pGDxkOP3Z4wAyI=;
        b=GYNA90taiZCcsYnbTk4okVqOEEaozlfQRGyRsh4tlAh0AX7DUiqkeEMD+qYVodU6XQ
         rx9bDgUzqnujnPuvcB0lU60ZbFPeVRqRHfFAa+NUX3EwllGyBpV4Nx6JlrhkZ9DA/Zm3
         3jGkAq0Wj511qwwPCx0ZJyNwd4kL9ZWINAVDuHH1gmOpcrUBtjj9cPSp2xbngri4POH/
         ltZfZphZs4RaUX2gvKbZswXgVTm6wPCmY3FSLJjVxVgi1nUu06V7dI4xJV7/BFUNBZGq
         A2C+bSA61NT5PhoDp8JguY31ZHyGW/orLezIwawq4Kr0yisS3RRhOUKYBdmtHT+ftsXI
         C5Kw==
X-Gm-Message-State: AO0yUKU8J/cOijB/fb3o0TUrWVMqUosEvfqmqdu1QDzp7V9voAL05zGU
        eVgUYx/5/46W/M5+kj84vpHjk4oArMZJZX49
X-Google-Smtp-Source: AK7set8VOS86U/BfNPLUpdGpMtlK0+oRUELSkdxWxlJBtjecgCYxy/hXwieUmoMkiVaIP/R+3AE6CQ==
X-Received: by 2002:a17:906:86d4:b0:87b:3d29:2982 with SMTP id j20-20020a17090686d400b0087b3d292982mr15367507ejy.11.1677054342574;
        Wed, 22 Feb 2023 00:25:42 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k26-20020a170906579a00b008b2714f4d8asm6869078ejq.181.2023.02.22.00.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:25:42 -0800 (PST)
Message-ID: <94238c42-1250-4d51-86e5-0a960dea0ffc@linaro.org>
Date:   Wed, 22 Feb 2023 09:25:40 +0100
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB52698CCA6AE59DDC6C15CBE4F2AA9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 03:59, Ryan Chen wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Tuesday, February 21, 2023 7:05 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
>>
>> On 21/02/2023 11:42, Ryan Chen wrote:
>>>>>>> +    type: boolean
>>>>>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>>>>>
>>>>>> Why this is property for DT? It's for sure not bool, but proper
>>>>>> type coming from units.
>>>>> This is i2c controller feature for enable slave mode inactive
>>>>> timeout and also master mode sda/scl auto release timeout.
>>>>> So I will modify to
>>>>>   aspeed,timeout:
>>>>> 	type: boolean
>>>>>     description: I2C bus timeout enable for master/slave mode
>>>>
>>>> This does not answer my concerns. Why this is board specific?
>>> Sorry, can’t catch your point.
>>> It is not board specific. It is controller feature.
>>> ASPEED SOC chip is server product, master connect may have fingerprint
>>> connect to another board. And also support hotplug.
>>> For example I2C controller as slave mode, and suddenly disconnected.
>>> Slave state machine will keep waiting for master clock in for rx/tx transfer.
>>> So it need timeout setting to enable timeout unlock controller state.
>>> And in another side. As master mode, slave is clock stretching.
>>> The master will be keep waiting, until slave release cll stretching.
>>
>> OK, thanks for describing the feature. I still do not see how this is DT related.
> 
> Let me draw more about the board-specific. 
> The following is an example about i2c layout in board.
> Board A														Board B
> --------------------------------------------------------							--------------------------------------------------------
> |    i2c bus#1(master/slave)  <--------------------> fingerprint.(can be unplug)    <--------------------> i2c bus#x (master/slave) |
> |    i2c bus#2(master) -> tmp i2c device     |			     		|									|
> |    i2c bus#3(master) -> adc i2c device      |					|									|
> --------------------------------------------------------							--------------------------------------------------------
> In this case i2c bus#1 need enable timeout, avoid suddenly unplug the connector. That slave will keep state to drive clock stretching.
> So it is specific enable in i2c bus#1. Others is not needed enable timeout. 
> Does this draw is more clear in scenario?

I2C bus #1 works in slave mode? So you always need it for slave work?

> 
>>>
>>> So in those reason add this timeout design in controller.
>>
>> You need to justify why DT is correct place for this property. DT is not for
>> configuring OS, but to describe hardware. I gave you one possibility
>> - why different boards would like to set this property. You said it is not board
>> specific, thus all boards will have it (or none of them).
>> Without any other reason, this is not a DT property. Drop.
>>
>>>>
>>>>>
>>>>>>> +
>>>>>>> +  byte-mode:
>>>>>>> +    type: boolean
>>>>>>> +    description: Force i2c driver use byte mode transmit
>>>>>>
>>>>>> Drop, not a DT property.
>>>>>>
>>>>>>> +
>>>>>>> +  buff-mode:
>>>>>>> +    type: boolean
>>>>>>> +    description: Force i2c driver use buffer mode transmit
>>>>>>
>>>>>> Drop, not a DT property.
>>>>>>
>>>>> The controller support 3 different for transfer.
>>>>> Byte mode: it means step by step to issue transfer.
>>>>> Example i2c read, each step will issue interrupt then enable next step.
>>>>> Sr (start read) | D | D | D | P
>>>>> Buffer mode: it means, the data can prepare into buffer register,
>>>>> then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling.
>>>>> The DMA mode most like with buffer mode, The differ is data prepare
>>>>> in DRAM, than trigger transfer.
>>>>>
>>>>> So, should I modify to
>>>>>   aspeed,byte:
>>>>> 	type: boolean
>>>>>     description: Enable i2c controller transfer with byte mode
>>>>>
>>>>>   aspeed,buff:
>>>>> 	type: boolean
>>>>>     description: Enable i2c controller transfer with buff mode
>>>>
>>>> 1. No, these are not bools but enum in such case.
>>>
>>> Thanks, will modify following.
>>> aspeed,xfer_mode:
>>>     enum: [0, 1, 2]
>>>     description:
>>>       0: byte mode, 1: buff_mode, 2: dma_mode
>>
>> Just keep it text - byte, buffered, dma
>>
>>>
>>>> 2. And why exactly this is board-specific?
>>>
>>> No, it not depends on board design. It is only for register control for
>> controller transfer behave.
>>> The controller support 3 different trigger mode for transfer.
>>> Assign bus#1 ~ 3 : dma tranfer and assign bus#4 ~ 6 : buffer mode
>>> transfer, That can reduce the dram usage.
>>
>> Then anyway it does not look like property for Devicetree. DT describes
>> hardware, not OS behavior.
> 
> The same draw, in this case, i2c bus#1 that is multi-master transfer architecture. 
> Both will inactive with trunk data. That cane enable i2c#1 use DMA transfer to reduce CPU utilized.
> Others (bus#2/3) can keep byte/buff mode. 

Isn't then current bus configuration for I2C#1 known to the driver?
Jeremy asked few other questions around here...

Best regards,
Krzysztof

