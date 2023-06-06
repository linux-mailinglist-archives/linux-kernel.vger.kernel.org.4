Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF3723C16
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjFFIon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbjFFIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:44:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27250FA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:44:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977d0288fd2so374800466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686041077; x=1688633077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDg6FhswbLnxmS80mCt2IqXJuf8NCtYRpgYnIYW/CqI=;
        b=D+o10JAiGV/K8Dk8o+sTomnICPqQiKXQqiasLdnFHwrRq8AdmQ2PfydvWTEeDP84N/
         dStB8WQGQgAtmYa8scNzeiqDHoprVOcygCaYiDK3wjFU78QB4eHxEmyNDsCakwGUWDQR
         B6p/fW+n3tOogKlmTpCCJTZb4iQzwuOMP4Qluuma4aIBAm/OkXE9Jru0pAomBhb1ZPXJ
         LJb1uYH90Qw4T14XSm0AGDG0+QJl4b+ZCwjJXmEg4VaxZlg65OPOsGT29y29qv2D0xz5
         3rDYnN2DY4C0kwM//FLiQ7UcJFFThl78c6JoWIZWYUvlZI0+xtbnz20IdvLB5ucl+8GT
         te9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686041077; x=1688633077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDg6FhswbLnxmS80mCt2IqXJuf8NCtYRpgYnIYW/CqI=;
        b=kwjUWHNEhn1gh360qXsx0Z6DMQVj77mpn/0N2On4Yk2Z7HNcyuOrkbeVe6xf6urnwU
         skUwzV9LaKdvjySjxq8gqZw/e0pwvq8AtbxjYpgoELA5pbJhYvrU5C6uHUxIekzqopz1
         7WqqiwR+iF4R7W9wb7Hz3CLaWxwBbtEJX6BE7g97KDzM3KREnn70ZJlBHJfX59OphAJk
         twehuvTpiJeQX/7Pxk7tIDioAA8OAXg5QMOvBDpQDagsy2jG4eeDUMVospPCSlvTAhaS
         85Na2ZkUSRQ0Rg7+BlVzol0ZZxAaiEOIrnYtZj1eskb6O6fhLuqhoMe3RL66iUuUgR73
         gGoQ==
X-Gm-Message-State: AC+VfDzRdSxLXJhZv7rXIM2AoemXhPSkvmBCJh+VTMSF6ZAN9HsNUm58
        kYNEp/ku24UoOuCy5czxSbp4UQ==
X-Google-Smtp-Source: ACHHUZ6wAfRnXikBVJbGi1CsiXd+lwR0OYsSoSocIDBbbRBkyIdkfClvyjFYznjWuYv6kxmoRkeiFA==
X-Received: by 2002:a17:907:3ea5:b0:973:9f60:c57e with SMTP id hs37-20020a1709073ea500b009739f60c57emr2012710ejc.2.1686041077566;
        Tue, 06 Jun 2023 01:44:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090694c400b0096f67b55b0csm5265406ejy.115.2023.06.06.01.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 01:44:37 -0700 (PDT)
Message-ID: <845924ba-d9bf-d0ec-e1f2-f721366f43c0@linaro.org>
Date:   Tue, 6 Jun 2023 10:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 3/3] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "richard@nod.at" <richard@nod.at>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606094855.1ab005eb@xps-13>
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

On 06/06/2023 09:48, Miquel Raynal wrote:
>>>>>>> +          it (otherwise it is harmless).
>>>>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>>>>> +        deprecated: true
>>>>>>> +
>>>>>>> +    additionalProperties: false  
>>>>>> unevaluatedProperties: false  
>>>>> It was hiding by '"^nand@[0-3]$":'. Should I move it here?  
>>>> You cannot have both additionalProps and unevaluatedProps at the same
>>>> time, so we do not talk about same thing or this was never working?  
>>>
>>> Hmm, I'm a little confused then. At various times I've been told to 
>>> put 'additionalProperties: false' or 'unevaluatedProperties: false' 
>>> (although never at the same time). I'm not sure when to use one or the 
>>> other.
>>>
>>> From what I've been able to glean 'additionalProperties: true' 
>>> indicates that the node is expected to have child nodes defined in a 
>>> different schema so I would have thought 'additionalProperties: false' 
>>> would be appropriate for a schema covering a leaf node. 
>>> 'unevaluatedProperties: false' seems to enable stricter checking which 
>>> makes sense when all the properties are described in the schema.  
>>
>> So I think this might be the problem. If I look at qcom,nandc.yaml or 
>> ingenic,nand.yaml which both have a partitions property in their 
>> example. Neither have 'unevaluatedProperties: false' on the nand@... 
>> subnode. If I add it sure enough I start getting complaints about the 
>> 'partitions' node being unexpected.
> 
> Sorry if that was unclear, I think the whole logic around the yaml
> files is to progressively constrain the descriptions, schema after
> schema. IOW, in the marvell binding you should set
> unevaluatedProperties: false for the NAND controller. What is inside
> (NAND chips, partition container, partition parsers, "mtd" properties,
> etc) will be handled by other files. Of course you can constrain a bit
> what can/cannot be used inside these subnodes, but I think you don't
> need to set unevaluatedProperties in these subnodes (the NAND chip in
> this case, or even the partitions) because you already reference
> nand-controller.yaml which references nand-chip.yaml, mtd.yaml,
> partitions.yaml, etc. *they* will make the generic checks and hopefully
> apply stricter checks, when deemed relevant.

No, neither nand-controller.yaml nor nand-chip.yaml limit the properties
in this context, so each device schema must have unevaluatedProperties:
false, for which I asked few emails ago.

Best regards,
Krzysztof

