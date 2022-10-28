Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9CA610FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJ1Lbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJ1Lbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:31:44 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ADCAEA27
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:31:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z30so3165190qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFGNTlzJVbGzTlwRhj/VBfk+5tnAHbXEChzttEBCShs=;
        b=KMEUfSaF+5qB5N+7CiySj7HfV/xpdPV1X5P+ow/+vpnjM76CwEF6PtndJUOBYg9WmQ
         pd1rzNjUx/IVQsI9oxWVJoepR7QKcFNdH0Kvk9UJfdvM6GvbciXdpr7SKXL5EiH0LI9g
         G4fk3cDvb7StnlZAng2V+F27NpopjNG6Y0qOtFFp29eEmL7XzvQUw46PxLbnQgSSywUB
         BAfzTVUGWDz4/b2W60OeRk8ALhz2nuje8d8n4E6xxatg4DHIAwyuExvW9SKB/X6Iccid
         R64Vo+9K/CU8Ny7WN3H/GF9Esmf5UC+P5bEd7rOBOGIRuIdXDyEn3hPyOKuom5BaLY+Q
         lvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFGNTlzJVbGzTlwRhj/VBfk+5tnAHbXEChzttEBCShs=;
        b=kwKT/RB7Tzejn+hvq3pLuq7bmuEOzuzt/SFa2a3V/KJJKN7s8bneABUQXBSr6i7g/a
         kGXaRusZ1+D/c0v9tGAPoqPiPkacYAlkZOsGy1eGUC7HFEJEqH9XRVtyx5H+hIQbvZdw
         /s9V5WN+SroS4hkdm3KAX64IIJa2w5stAEISlCC/o4R1xxupBs3jBCOw+7X/1nbgUWuW
         OQUoI6E9oHVwOKKt53yYKalCQQhCgkjWuQHbFRfC+xMaNhSwY3mDcLcngDNDgwV6XK43
         11qk2otO5zcobic7KLjTHKByTJrpeFqR9IDjYi/7TaRbN75FTWI1UqWpVlDW+F2bG9zK
         afxg==
X-Gm-Message-State: ACrzQf1VLKX7fPzZ78aviXdvoNgfdvcyrcnJzmBY4k/ovM8cYij/REkn
        1RH4ZdHKXnbDJs+CJ/QVCmCRX5Zy3E+Omw==
X-Google-Smtp-Source: AMsMyM4P66qNsfOwoP5BdK92GEQsLgzJXa9UvzrxElfIHKx925179DcUnLkD8QGNgb1uuVE5Fb6KLQ==
X-Received: by 2002:a05:620a:17ab:b0:6fa:d45:a749 with SMTP id ay43-20020a05620a17ab00b006fa0d45a749mr600992qkb.194.1666956702331;
        Fri, 28 Oct 2022 04:31:42 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0d9500b006eec09eed39sm2773393qkl.40.2022.10.28.04.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:31:41 -0700 (PDT)
Message-ID: <a98f00bd-013a-a1ce-0054-bbceeaefcefa@linaro.org>
Date:   Fri, 28 Oct 2022 07:31:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221026134545.7146-1-vadym.kochan@plvision.eu>
 <20221026134545.7146-2-vadym.kochan@plvision.eu>
 <33f04b06-dc00-b7ce-6a24-2282608b40dc@linaro.org>
 <VI1P190MB0317C739E2D39427CD2A771D95309@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <10581088-e4ff-76db-3c9b-42a7a9c118ee@linaro.org>
 <20221027151825.166a9255@xps-13>
 <e937b059-4168-3bd4-b294-cbfff0519d1f@linaro.org>
 <20221027155025.7c04774a@xps-13>
 <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
 <20221028094740.3c11f52b@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028094740.3c11f52b@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 03:47, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 10:51:29 -0400:
> 
>> On 27/10/2022 09:50, Miquel Raynal wrote:
>>> Hi Krzysztof,
>>>
>>> krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 09:24:24 -0400:
>>>   
>>>> On 27/10/2022 09:18, Miquel Raynal wrote:  
>>>>> Hi Vadym,
>>>>>     
>>>>>>>>> +patternProperties:
>>>>>>>>> +  "^nand@[0-3]$":
>>>>>>>>> +    type: object
>>>>>>>>> +    properties:
>>>>>>>>> +      reg:
>>>>>>>>> +        minimum: 0
>>>>>>>>> +        maximum: 3
>>>>>>>>> +
>>>>>>>>> +      nand-rb:
>>>>>>>>> +        minimum: 0
>>>>>>>>> +        maximum: 1
>>>>>>>>> +
>>>>>>>>> +      nand-ecc-strength:
>>>>>>>>> +        enum: [1, 4, 8]
>>>>>>>>> +
>>>>>>>>> +      nand-on-flash-bbt: true
>>>>>>>>> +
>>>>>>>>> +      nand-ecc-mode: true
>>>>>>>>> +
>>>>>>>>> +      nand-ecc-algo:
>>>>>>>>> +        description: |
>>>>>>>>> +          This property is essentially useful when not using hardware ECC.
>>>>>>>>> +          Howerver, it may be added when using hardware ECC for clarification
>>>>>>>>> +          but will be ignored by the driver because ECC mode is chosen depending
>>>>>>>>> +          on the page size and the strength required by the NAND chip.
>>>>>>>>> +          This value may be overwritten with nand-ecc-strength property.
>>>>>>>>> +
>>>>>>>>> +      nand-ecc-step-size:
>>>>>>>>> +        description: |
>>>>>>>>> +          Marvell's NAND flash controller does use fixed strength
>>>>>>>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>>>>>>>> +          will shrink or grow in order to fit the required strength.
>>>>>>>>> +          Step sizes are not completely random for all and follow certain
>>>>>>>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>>>>>>>> +
>>>>>>>>> +      label:
>>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>>>>>>> +
>>>>>>>>> +      partitions:
>>>>>>>>> +        type: object      
>>>>>>>>
>>>>>>>> That's not what I asked for. Like four times I asked you to add here
>>>>>>>> unevaluatedProperties: false and I never said that ref to partition.yaml
>>>>>>>> should be removed and you... instead remove that ref.
>>>>>>>>
>>>>>>>> You need to define here children and specify their ref.
>>>>>>>>
>>>>>>>> You must use unevaluatedProperties: false here. So this is fifth time I
>>>>>>>> am writing this feedback.
>>>>>>>>
>>>>>>>>      
>>>>>>>
>>>>>>> It is a bit confusing that it is needed to define "partitions" and "label" rules particulary
>>>>>>> in this nand controller instead of some common place like nand-chip.yaml, these properties
>>>>>>> are common also for the other nand controllers.      
>>>>>>
>>>>>> No one speaks about label, I never commented about label, I think...
>>>>>>
>>>>>> If you think the property is really generic and every NAND controller
>>>>>> bindings implement it, then feel free to include them there, in a
>>>>>> separate patch. It sounds sensible, but I did not check other bindings.    
>>>>>
>>>>> FYI, label is already defined in mtd/mtd.yaml.    
>>>>
>>>> Which is not included here and in nand-controller.yaml  
>>>
>>> Maybe nand-chip.yaml should?  
>>
>> mtd.yaml looks a bit more than that - also allows nvmem nodes. Maybe
>> let's just add label to nand-chip?
> 
> I don't get the reason behind this proposal, mtd.yaml really is
> kind of a definition of generic properties any mtd device might
> have, so duplicating label (or whatever else inside) does not seem
> legitimate to me. The jedec,spi-nor.yaml file already references it for
> instance.

spi-nor is not a NAND chip... By including mtd.yaml in nand-chip you
also allow the NVMEM properties which are not applicable.

> 
>>>>> Partitions do not need to be defined in your binding, just don't put
>>>>> any in your example and you'll be fine. These partitions are either
>>>>> static and may be described in the DT (see
>>>>> mtd/partition/partition.yaml) or there is some dynamic discovery
>>>>> involved and a proper parser shall be referenced (parsers have their
>>>>> own binding).    
>>>>
>>>> I don't think this is correct. Basically you allow any node to be under
>>>> partitions as there is no schema validating them (without compatibles).  
>>>
>>> Sorry if that was unclear, what I meant is: partitions should not be
>>> defined in the bindings for Marvell NAND controller because they should
>>> be defined somewhere else already.  
>>
>> Ah, right. Then it seems reasonable.
>>
>>>
>>> NAND controller subnodes should define the storage devices (the
>>> flashes themselves) connected to the controller. "nand-chip.yaml"
>>> describes generic properties for these. Additional subnodes are allowed
>>> and expected to be partitions (this is not enforced anywhere I think),
>>> they should use one of the existing compatibles to define the parser.
>>> The most common parser is named fixed-partitions and has its own
>>> compatible. Every parser references partitions.yaml.
>>>
>>> There are a few controller bindings however which reference
>>> partition.yaml anyway, probably to make the examples validation work,
>>> I'm not sure it should be done like that though:
>>> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
>>> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml  
>>
>>
>> Yes, so the nand-chip implementation (like Marvell NAND) could reference
>> the parser and we would be done. If it doesn't, then we must have
>> generic partitions in the nand-chip.
> 
> In this case, I am not aware of any parser that would be relevant.
> 
> In the generic case, should we really reference a parser in particular?
> If yes then maybe we should make a yaml file that just gathers all the
> parsers and include it within mtd.yaml (and have it referenced in
> nand-chip.yaml). What do you think?
> 

Not all MTD devices have partitions so putting this into mtd.yaml does
not look correct. Adding it into nand-chip seems fine.

Best regards,
Krzysztof

