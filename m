Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1FC723FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFFKka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjFFKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:39:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A719B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:37:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97467e06511so694941666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686047859; x=1688639859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QpFJU/IqFR4e+DTduLLpRyhdstc+HgSzigyth1/+/Co=;
        b=Ck/7CWY5+neMVyfUxgW8MYTH/zWqy/Yu7zovm2HHe7oYFPZj6YSxWtOQSKEwxIE/34
         XGw9zpunLOYPQSe9WRiv222R4bEzRt0SSPSAZsdXdFFE4DcakFjJRKeHxorkTNVs/539
         M6GxyivK2L88pUKJ9VQvc+0fsWGlSp5yMoHphFhd7skVWU9tCEJ3a3dFcxbqbTyO6Gyo
         h6C4zO8b3ERxOcZUtQ31hEYgnKB7kTG3KD6kB9S4do1VPdKqd1n2ZfGU4zkpMfLWHpgq
         ZqYObGe7D8sVV8RfMleKxtAcCvwuRhirGrT9Yv7t7QluwMEr1zf+8vAkJGBcC35hswBI
         VPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047859; x=1688639859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpFJU/IqFR4e+DTduLLpRyhdstc+HgSzigyth1/+/Co=;
        b=SP/OVb0DJHA/GUM7o0FGl2g9t0MRqdWMjKrxcIUAgGk49mWZNX/IU5p72/NBETHqOh
         RmcEqn/i7YBZ1uilAyyDYyS3/9MDFRMnnd1NLmtytSt0+pcx00Y6mZXI0FC9Yk+c9pJU
         at0LTmkBWcBfi1GuUA49Of8xc6n7JrW8MNZCxsoj7S/Xi4G6ymB0qH6Qs0pBXNVJz99M
         fPIuLAP/NIegvb5kiqYIoHGGMTqBQ4bwKXftiukTi2twRYoz0KlL6/ct9LkEwr0iLp0V
         2s/RoZdgpkD8gpTDR9fKOzSiiLWRG5nkgvQbN5RYzvMhdVjSMkkWGkT3+Rz85ZZmF60l
         JznA==
X-Gm-Message-State: AC+VfDyltFqIDdEa6Z3Iwr9vH+INg5XAzS3N3zEtG1i9Y4FgbaOOnRq4
        fPWxDYT0Iw9gBGwwI46dozHN6rrBjo26Twsma8MGAQ==
X-Google-Smtp-Source: ACHHUZ7KnV3/A9DLydmlg/VE9hatPc63P79rhG5BvWGL9kzRkq0H7TADwkeZqK2QNk9a2ZBNhPubqQ==
X-Received: by 2002:a17:907:2d0b:b0:974:62d7:1467 with SMTP id gs11-20020a1709072d0b00b0097462d71467mr1985000ejc.5.1686047859225;
        Tue, 06 Jun 2023 03:37:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y26-20020a17090668da00b00947ed087a2csm5365258ejr.154.2023.06.06.03.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:37:38 -0700 (PDT)
Message-ID: <e0d14527-8147-5e8b-6a43-ee043e0d0f8b@linaro.org>
Date:   Tue, 6 Jun 2023 12:37:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606122812.411b223a@xps-13>
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

On 06/06/2023 12:28, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Tue, 6 Jun 2023 10:44:34 +0200:
> 
>> On 06/06/2023 09:48, Miquel Raynal wrote:
>>>>>>>>> +          it (otherwise it is harmless).
>>>>>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>>>>>> +        deprecated: true
>>>>>>>>> +
>>>>>>>>> +    additionalProperties: false    
>>>>>>>> unevaluatedProperties: false    
>>>>>>> It was hiding by '"^nand@[0-3]$":'. Should I move it here?    
>>>>>> You cannot have both additionalProps and unevaluatedProps at the same
>>>>>> time, so we do not talk about same thing or this was never working?    
>>>>>
>>>>> Hmm, I'm a little confused then. At various times I've been told to 
>>>>> put 'additionalProperties: false' or 'unevaluatedProperties: false' 
>>>>> (although never at the same time). I'm not sure when to use one or the 
>>>>> other.
>>>>>
>>>>> From what I've been able to glean 'additionalProperties: true' 
>>>>> indicates that the node is expected to have child nodes defined in a 
>>>>> different schema so I would have thought 'additionalProperties: false' 
>>>>> would be appropriate for a schema covering a leaf node. 
>>>>> 'unevaluatedProperties: false' seems to enable stricter checking which 
>>>>> makes sense when all the properties are described in the schema.    
>>>>
>>>> So I think this might be the problem. If I look at qcom,nandc.yaml or 
>>>> ingenic,nand.yaml which both have a partitions property in their 
>>>> example. Neither have 'unevaluatedProperties: false' on the nand@... 
>>>> subnode. If I add it sure enough I start getting complaints about the 
>>>> 'partitions' node being unexpected.  
>>>
>>> Sorry if that was unclear, I think the whole logic around the yaml
>>> files is to progressively constrain the descriptions, schema after
>>> schema. IOW, in the marvell binding you should set
>>> unevaluatedProperties: false for the NAND controller. What is inside
>>> (NAND chips, partition container, partition parsers, "mtd" properties,
>>> etc) will be handled by other files. Of course you can constrain a bit
>>> what can/cannot be used inside these subnodes, but I think you don't
>>> need to set unevaluatedProperties in these subnodes (the NAND chip in
>>> this case, or even the partitions) because you already reference
>>> nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
>>> partitions.yaml, etc. *they* will make the generic checks and hopefully
>>> apply stricter checks, when deemed relevant.  
>>
>> No, neither nand-controller.yaml nor nand-chip.yaml limit the properties
>> in this context, so each device schema must have unevaluatedProperties:
>> false, for which I asked few emails ago.
> 
> The controller description shall be guarded by unevaluatedProperties:
> false, we agree. Do you mean the nand chip description in each nand
> controller binding should also include it at its own level? Because
> that is not what we enforced so far IIRC. I am totally fine doing so
> starting from now on if this is a new requirement (which makes sense).
> 
> If yes, then it means we would need to list *all* the nand
> chip properties in each schema, which clearly involves a lot of
> duplication as you would need to define all types of partitions,
> partition parsers, generic properties, etc in order for the examples to
> pass all the checks. Only the properties like pinctrl-* would not need
> to be listed I guess.

Yes, this is what should be done. Each node should have either
additional or unevaluatedProperties: false. It might come from
referenced schema or from final (device) schema), but it looks here it
is missing. It's exactly the same in all bindings. You will find plenty
of examples, e.g. individual leds children and common.yaml.


> 
> As Chris was having issues comparing his work with the ingenic and qcom
> yaml files, I gave your input a try and hopefully "fixed" these
> bindings.

Both are wrong in this matter. You can easily test it. Patch like:

diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index a7bdb5d3675c..968c42f6b5a2 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -97,6 +97,8 @@ examples:
                 nand-ecc-mode = "hw";
                 nand-on-flash-bbt;

+                fake-stuff;
+
                 pinctrl-names = "default";
                 pinctrl-0 = <&pins_nemc_cs1>;

should trigger warning as this is clearly fake-stuff. No warning though...

Best regards,
Krzysztof

