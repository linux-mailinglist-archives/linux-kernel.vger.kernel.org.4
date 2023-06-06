Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4305572408D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjFFLLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFFLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:11:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C79E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:11:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so8449979a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686049878; x=1688641878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBaQ+qyAEE6Nu7Wl9Fi5tgo0nl2AZwD0vEKIf0f40Co=;
        b=BTrAyNVBqudRxlCRnUGFL10v6+hDZeXyOFVfypBnKh/U7wxqZz2KW18q8NX3kuowZg
         2FhrtkKLSGYUVUe7FarDsOVYJdTMUMxA8GTVzdj/bDnWOh2cXSRCXpySAs/DXZe/docv
         4QruKvICAvStPeDcoYZq4ndlLpRcKa7+zcx9LwweazGQbNoPB00TQpXcTN+ixRT7pYUQ
         qXy2blyO0PBnTVTdnQYeKLaBSgYXNElyV5hmV/vzGyMFsePMygGJxQCEjZzUaFQ188A5
         aZCo6SnBvp6mCffjtLFQbIZJrncYTNNhlJi+/g+W/oPRY10WEOkWEQh85xsbujuUsghW
         tfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686049878; x=1688641878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBaQ+qyAEE6Nu7Wl9Fi5tgo0nl2AZwD0vEKIf0f40Co=;
        b=EMn/svtXagZSH7v2KHSY4W/GbalgshopuoTjYJ9wkGcoxixYdwSVBOP2K+1lWlhhiX
         sDHtvsdS4LPkwNT8HY1McIDJmls8hqSB9K6qSKlY5oetk0RUC/uQJMPk8tRMPYY8kTg6
         r2ZaxSUxUMRmgqbCkwMVa58dL6Aw/7EbKBNH8odsADG4f6TlORZG7hJPEiofqdU3cj16
         ORaND/eYhybSzrqV1ZSOo5/HO0O3pk7Dv6kKGQd4HrM3lbOGJMLRdQRJ9bvkikmluhJ8
         w1kPPuUZ6EuJmAcE+RlRYpREEgQdIW1x+KgxBQYbDEyl2ibG8b1yDWg5NOE0hbvSIiMc
         cyfg==
X-Gm-Message-State: AC+VfDxa3zkF6WAXY9lhjVKNRacr1hayByxuVsDzzadlBxmVPUPbZpPM
        zN5qZcKsq2LenxPy5Gkoxh4idkhiFwN7hsqOg+okLQ==
X-Google-Smtp-Source: ACHHUZ6T7Csa68AUJ5pIXXsEx0PENLKuIfHBfgR7nvZRToDiTbYG9zcF6pepDd9sJKfQ2iB3CHd6kA==
X-Received: by 2002:a05:6402:7d4:b0:50d:9b59:4327 with SMTP id u20-20020a05640207d400b0050d9b594327mr1502370edy.29.1686049878372;
        Tue, 06 Jun 2023 04:11:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402181000b005149cb5ee2dsm4892574edy.82.2023.06.06.04.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:11:17 -0700 (PDT)
Message-ID: <037f5455-35c1-e13d-814c-16317a2a15f3@linaro.org>
Date:   Tue, 6 Jun 2023 13:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "conor@kernel.org" <conor@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
References: <20230531234923.2307013-1-chris.packham@alliedtelesis.co.nz>
 <20230531234923.2307013-4-chris.packham@alliedtelesis.co.nz>
 <a23dd485-a3d9-e31f-be3e-0ab293fcfc4a@linaro.org>
 <785368df-1881-e62e-6172-d902cee814a8@alliedtelesis.co.nz>
 <eaf9d7cf-c9f5-a5d5-67af-c43761c3c6cf@linaro.org>
 <4ea0b16e-0cec-00db-c598-e0364a7edef8@alliedtelesis.co.nz>
 <9fc57052-5049-ed50-ca95-cfd1d0420dd9@alliedtelesis.co.nz>
 <20230606094855.1ab005eb@xps-13>
 <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
 <20230606122812.411b223a@xps-13>
 <e0d14527-8147-5e8b-6a43-ee043e0d0f8b@linaro.org>
 <d0b2cdc5-12fd-9a19-b38c-0653b4147c2b@linaro.org>
 <20230606125724.126a4685@xps-13> <20230606130719.5350174c@xps-13>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606130719.5350174c@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 13:07, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> miquel.raynal@bootlin.com wrote on Tue, 6 Jun 2023 12:57:24 +0200:
> 
>> Hi Krzysztof,
>>
>> krzysztof.kozlowski@linaro.org wrote on Tue, 6 Jun 2023 12:40:45 +0200:
>>
>>> On 06/06/2023 12:37, Krzysztof Kozlowski wrote:
>>>> On 06/06/2023 12:28, Miquel Raynal wrote:  
>>>>> Hi Krzysztof,
>>>>>
>>>>> krzysztof.kozlowski@linaro.org wrote on Tue, 6 Jun 2023 10:44:34 +0200:
>>>>>  
>>>>>> On 06/06/2023 09:48, Miquel Raynal wrote:  
>>>>>>>>>>>>> +          it (otherwise it is harmless).
>>>>>>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>>>>>>> +        deprecated: true
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +    additionalProperties: false      
>>>>>>>>>>>> unevaluatedProperties: false      
>>>>>>>>>>> It was hiding by '"^nand@[0-3]$":'. Should I move it here?      
>>>>>>>>>> You cannot have both additionalProps and unevaluatedProps at the same
>>>>>>>>>> time, so we do not talk about same thing or this was never working?      
>>>>>>>>>
>>>>>>>>> Hmm, I'm a little confused then. At various times I've been told to 
>>>>>>>>> put 'additionalProperties: false' or 'unevaluatedProperties: false' 
>>>>>>>>> (although never at the same time). I'm not sure when to use one or the 
>>>>>>>>> other.
>>>>>>>>>
>>>>>>>>> From what I've been able to glean 'additionalProperties: true' 
>>>>>>>>> indicates that the node is expected to have child nodes defined in a 
>>>>>>>>> different schema so I would have thought 'additionalProperties: false' 
>>>>>>>>> would be appropriate for a schema covering a leaf node. 
>>>>>>>>> 'unevaluatedProperties: false' seems to enable stricter checking which 
>>>>>>>>> makes sense when all the properties are described in the schema.      
>>>>>>>>
>>>>>>>> So I think this might be the problem. If I look at qcom,nandc.yaml or 
>>>>>>>> ingenic,nand.yaml which both have a partitions property in their 
>>>>>>>> example. Neither have 'unevaluatedProperties: false' on the nand@... 
>>>>>>>> subnode. If I add it sure enough I start getting complaints about the 
>>>>>>>> 'partitions' node being unexpected.    
>>>>>>>
>>>>>>> Sorry if that was unclear, I think the whole logic around the yaml
>>>>>>> files is to progressively constrain the descriptions, schema after
>>>>>>> schema. IOW, in the marvell binding you should set
>>>>>>> unevaluatedProperties: false for the NAND controller. What is inside
>>>>>>> (NAND chips, partition container, partition parsers, "mtd" properties,
>>>>>>> etc) will be handled by other files. Of course you can constrain a bit
>>>>>>> what can/cannot be used inside these subnodes, but I think you don't
>>>>>>> need to set unevaluatedProperties in these subnodes (the NAND chip in
>>>>>>> this case, or even the partitions) because you already reference
>>>>>>> nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
>>>>>>> partitions.yaml, etc. *they* will make the generic checks and hopefully
>>>>>>> apply stricter checks, when deemed relevant.    
>>>>>>
>>>>>> No, neither nand-controller.yaml nor nand-chip.yaml limit the properties
>>>>>> in this context, so each device schema must have unevaluatedProperties:
>>>>>> false, for which I asked few emails ago.  
>>>>>
>>>>> The controller description shall be guarded by unevaluatedProperties:
>>>>> false, we agree. Do you mean the nand chip description in each nand
>>>>> controller binding should also include it at its own level? Because
>>>>> that is not what we enforced so far IIRC. I am totally fine doing so
>>>>> starting from now on if this is a new requirement (which makes sense).
>>>>>
>>>>> If yes, then it means we would need to list *all* the nand
>>>>> chip properties in each schema, which clearly involves a lot of
>>>>> duplication as you would need to define all types of partitions,
>>>>> partition parsers, generic properties, etc in order for the examples to
>>>>> pass all the checks. Only the properties like pinctrl-* would not need
>>>>> to be listed I guess.  
>>>>
>>>> Yes, this is what should be done. Each node should have either  
>>>
>>> Eh, no, I responded in wrong part of message. My yes was for:
>>>
>>> " Do you mean the nand chip description in each nand
>>> controller binding should also include it at its own level?"
>>
>> Clear.
>>
>>>
>>> Now for actual paragraph:
>>>
>>> "If yes, then it means we would need to list *all* the nand chip
>>> properties in each schema,"
>>>
>>> No, why? I don't understand. Use the same pattern as all other bindings,
>>> this is not special. Absolutely all have the same behavior, e.g.
>>> mentioned leds. You finish with unevaluatedProps and you're done, which
>>> is what I wrote here long, long time ago.
>>
>> Maybe because so far we did not bother referencing another schema in
>> the NAND chip nodes? For your hint to work I guess we should have, in
>> each controller binding, something along:
>>
>>  patternProperties:
>>    "^nand@[a-f0-9]$":
>>      type: object
>> +    $ref: nand-chip.yaml#
>>      properties:
>>
>> If yes, please ignore the series sent aside, I will work on it again
>> and send a v2.
> 
> Actually I already see a problem, let's the ingenic,nand.yaml example.
> The goal, IIUC, is to do:
> 
>  patternProperties:
>    "^nand@[a-f0-9]$":
>      type: object
> +    $ref: nand-chip.yaml
>      properties:
> 
>        ...
> 
> +    unevaluatedProperties: false
> 
> The example in this file uses a property, nand-on-flash-bbt, which is
> described inside nand-controller.yaml instead of nand-chip.yaml.
> Indeed, the former actually describes many properties which are a bit
> more controller related than chip related. With the above description,
> the example fails because nand-on-flash-bbt is not allowed (it is not
> listed in nand-chip.yaml).
> 
> How would you proceed in this case?
> 
> Maybe I could move all the NAND chip properties which are somehow
> related to NAND controllers (and defined in nand-controller.yaml) in a
> dedicated file and reference it from nand-chip.yaml? Any other idea is
> welcome.

Yes, this would work and seems reasonable. Other way could be to add
unevaluatedProperties:false on this level (so after ref:nand-chip.yaml)
in nand-controller.yaml. This however would not allow any new properties
to be defined in device bindings.

Best regards,
Krzysztof

