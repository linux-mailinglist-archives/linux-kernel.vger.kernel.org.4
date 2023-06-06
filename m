Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5013723FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjFFKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjFFKmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:42:21 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E251BDB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:40:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977c88c9021so466200666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686048047; x=1688640047;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLj774D+pz6YB3btZ/z2RD1vhvv9nZxLfJinEPA2x5A=;
        b=hP+B6dClgEY2Qbo3BxxHoolPl488Dk1P3+SkvYr9cN+giOYMeF/zUD6ZhUh/kt3R+S
         bXreUkYm0xrr1Ap2pmeeNBLYwwplyQ6MT6YVZFqMzSuCgmmQ6OIcnBsvhgUie0AcR9ti
         MWN2bfGRoQX2TINwDhPtmOpCOvU3AcaBWiq4yOzV2Vvs53JMuAC3t3vox5iLXDj9/Dua
         64YjbSwjbrfArANmaKVqTOPb+FKqU3DlhSLLX4vYoJVVJvx32Wkvj4j2SwK0fuqug82M
         aSPKLni2klECNNnM3MTppAoY/5Q/2qVnnwIRocgbzjCXYDyG22RSLY+HIgGLsVZC14M9
         ws3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048047; x=1688640047;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HLj774D+pz6YB3btZ/z2RD1vhvv9nZxLfJinEPA2x5A=;
        b=PZIN2hEhso17FWTz5SJpRFlKBHHpINssHg0ZArjA5NxfyRc2XIrcxMGb1ssK9wFnsL
         Z/2iKeamabmPhys4b0ztOuWaRAVQh6hO92sDXmyENMJ3MIbzUK7oah+cR4CKqc/omJg3
         PH9FyRCwfBoVvNcTvvI5Qrk5mAWPv4tilcJj3kI0LEX94warayKsoENg6pf1P7s54fjx
         81So3vvFcZ3KJGiA8iiv6jr7PQBxl/S7vdIn0G1XtSWvD66g6fIO6RtEX4gcyUZ57TeG
         zfum2UcTO4cpJ3jFumdEqV38mcjEnrgDCdnRW6EBcBtxdBzvsgcYpg6BSIHikPl2OXTF
         b9/g==
X-Gm-Message-State: AC+VfDyQT1JT8fl0uRaVf2pAiMxtowZhKsfaRcsPbXjifTCEmFrQj7SH
        07FuFIYkcpDEn4hCRj8wY4R87g==
X-Google-Smtp-Source: ACHHUZ7C1r42ySwDtx7lw0ifHfagwC8YL/zV9fl+XnaVQwq9v2QbktwuXbmkZ3A92llvOeCemuSEvw==
X-Received: by 2002:a17:907:3f24:b0:974:1c99:7d3 with SMTP id hq36-20020a1709073f2400b009741c9907d3mr2303998ejc.25.1686048047487;
        Tue, 06 Jun 2023 03:40:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gr24-20020a170906e2d800b0096f5b48fe43sm5431043ejb.47.2023.06.06.03.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:40:47 -0700 (PDT)
Message-ID: <d0b2cdc5-12fd-9a19-b38c-0653b4147c2b@linaro.org>
Date:   Tue, 6 Jun 2023 12:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <e0d14527-8147-5e8b-6a43-ee043e0d0f8b@linaro.org>
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

On 06/06/2023 12:37, Krzysztof Kozlowski wrote:
> On 06/06/2023 12:28, Miquel Raynal wrote:
>> Hi Krzysztof,
>>
>> krzysztof.kozlowski@linaro.org wrote on Tue, 6 Jun 2023 10:44:34 +0200:
>>
>>> On 06/06/2023 09:48, Miquel Raynal wrote:
>>>>>>>>>> +          it (otherwise it is harmless).
>>>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>>>> +        deprecated: true
>>>>>>>>>> +
>>>>>>>>>> +    additionalProperties: false    
>>>>>>>>> unevaluatedProperties: false    
>>>>>>>> It was hiding by '"^nand@[0-3]$":'. Should I move it here?    
>>>>>>> You cannot have both additionalProps and unevaluatedProps at the same
>>>>>>> time, so we do not talk about same thing or this was never working?    
>>>>>>
>>>>>> Hmm, I'm a little confused then. At various times I've been told to 
>>>>>> put 'additionalProperties: false' or 'unevaluatedProperties: false' 
>>>>>> (although never at the same time). I'm not sure when to use one or the 
>>>>>> other.
>>>>>>
>>>>>> From what I've been able to glean 'additionalProperties: true' 
>>>>>> indicates that the node is expected to have child nodes defined in a 
>>>>>> different schema so I would have thought 'additionalProperties: false' 
>>>>>> would be appropriate for a schema covering a leaf node. 
>>>>>> 'unevaluatedProperties: false' seems to enable stricter checking which 
>>>>>> makes sense when all the properties are described in the schema.    
>>>>>
>>>>> So I think this might be the problem. If I look at qcom,nandc.yaml or 
>>>>> ingenic,nand.yaml which both have a partitions property in their 
>>>>> example. Neither have 'unevaluatedProperties: false' on the nand@... 
>>>>> subnode. If I add it sure enough I start getting complaints about the 
>>>>> 'partitions' node being unexpected.  
>>>>
>>>> Sorry if that was unclear, I think the whole logic around the yaml
>>>> files is to progressively constrain the descriptions, schema after
>>>> schema. IOW, in the marvell binding you should set
>>>> unevaluatedProperties: false for the NAND controller. What is inside
>>>> (NAND chips, partition container, partition parsers, "mtd" properties,
>>>> etc) will be handled by other files. Of course you can constrain a bit
>>>> what can/cannot be used inside these subnodes, but I think you don't
>>>> need to set unevaluatedProperties in these subnodes (the NAND chip in
>>>> this case, or even the partitions) because you already reference
>>>> nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
>>>> partitions.yaml, etc. *they* will make the generic checks and hopefully
>>>> apply stricter checks, when deemed relevant.  
>>>
>>> No, neither nand-controller.yaml nor nand-chip.yaml limit the properties
>>> in this context, so each device schema must have unevaluatedProperties:
>>> false, for which I asked few emails ago.
>>
>> The controller description shall be guarded by unevaluatedProperties:
>> false, we agree. Do you mean the nand chip description in each nand
>> controller binding should also include it at its own level? Because
>> that is not what we enforced so far IIRC. I am totally fine doing so
>> starting from now on if this is a new requirement (which makes sense).
>>
>> If yes, then it means we would need to list *all* the nand
>> chip properties in each schema, which clearly involves a lot of
>> duplication as you would need to define all types of partitions,
>> partition parsers, generic properties, etc in order for the examples to
>> pass all the checks. Only the properties like pinctrl-* would not need
>> to be listed I guess.
> 
> Yes, this is what should be done. Each node should have either

Eh, no, I responded in wrong part of message. My yes was for:

" Do you mean the nand chip description in each nand
controller binding should also include it at its own level?"

Now for actual paragraph:

"If yes, then it means we would need to list *all* the nand chip
properties in each schema,"

No, why? I don't understand. Use the same pattern as all other bindings,
this is not special. Absolutely all have the same behavior, e.g.
mentioned leds. You finish with unevaluatedProps and you're done, which
is what I wrote here long, long time ago.

Best regards,
Krzysztof

