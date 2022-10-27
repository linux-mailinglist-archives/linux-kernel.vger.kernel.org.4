Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118760FAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiJ0Ovg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbiJ0Ove (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:51:34 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF9C67CA4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:51:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id n18so1471589qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bl3WBdt5Y/ZDiD0ewavcbpoZ58FHnW8LScNVv1rwHFE=;
        b=gqG9/loBZq4cZcaSY39ncOfEA5QP1LgRwg9sSUTuVkPfsQvMsf0X3DnGesW5QwIT/Q
         ler18mmlaNqc9f/04GPKikOFrYjU7PPwlUsOd4CFSWZE8uWPb7697PkfP2oTXSZQXQPN
         s/hFJrdmdR7egolG7JZr/nJDBaj1oFYpdA9ziUsX0FqYZNsJxKPYrLwmN08X+YSfk9bx
         4WriC87fVwmuuCZYOG89lPQz+qSbz7nZ5ZW/kd/EZMkpwOrRbme4iXU4lMti2sucbJhF
         TqWNJBuPR8U/FvGirUgLx7bt4pOcmyvqFRloG6cUmPcJVQc1poR1RV3hSiVys5diLgoS
         jMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl3WBdt5Y/ZDiD0ewavcbpoZ58FHnW8LScNVv1rwHFE=;
        b=wft7i23+CsuCTiVV4K/z/POu+PRQym2eohX6grtLvXa2tG6/k7B/A4MBlPyHrcDNvm
         lyHWnDf9tBVr8MLUT4HDns7QB4H5k2dL2u9R36uiG5nuie9QfBW0vlLIpcivtT/s7kC7
         UxGJ7G1/WVpNfSHHaVKHkpBW7icQPrmuHaPaVBTXfWwUqvFGrHBcjoZRPO7fBYLL1NE1
         sN9WJOyF06vb5Jk+RuGrMkqUTmItmJyV4+9QmiKi0FhcA144pw9lTLtx3RNm800XhOQO
         R6R+IXGsUkV7aXUZL6AkiRdqSbF/WY7FdmZebfmGNH5L/44I/IDjucCrg0lRp1Irc10Z
         8uUg==
X-Gm-Message-State: ACrzQf27eC7eZ4wKqCi8GcG8+hJaht6yREZSRsKKM6PvJvXV/48UgHQM
        HkzQRPyZ3ZwDrztLWQLFIWmeFw==
X-Google-Smtp-Source: AMsMyM68BxduWvWCusoa2A9sUOz3NBVsWe0/j5wqiFpsO3aRR2/VCqvmzSaG7SEs9c89t8SIaTXLGg==
X-Received: by 2002:a0c:cb92:0:b0:4bb:7aa3:d8ce with SMTP id p18-20020a0ccb92000000b004bb7aa3d8cemr15716481qvk.45.1666882292698;
        Thu, 27 Oct 2022 07:51:32 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id bb11-20020a05622a1b0b00b0035d08c1da35sm968603qtb.45.2022.10.27.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 07:51:31 -0700 (PDT)
Message-ID: <683dffbc-744f-80cd-2262-b6deb4200ccc@linaro.org>
Date:   Thu, 27 Oct 2022 10:51:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027155025.7c04774a@xps-13>
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

On 27/10/2022 09:50, Miquel Raynal wrote:
> Hi Krzysztof,
> 
> krzysztof.kozlowski@linaro.org wrote on Thu, 27 Oct 2022 09:24:24 -0400:
> 
>> On 27/10/2022 09:18, Miquel Raynal wrote:
>>> Hi Vadym,
>>>   
>>>>>>> +patternProperties:
>>>>>>> +  "^nand@[0-3]$":
>>>>>>> +    type: object
>>>>>>> +    properties:
>>>>>>> +      reg:
>>>>>>> +        minimum: 0
>>>>>>> +        maximum: 3
>>>>>>> +
>>>>>>> +      nand-rb:
>>>>>>> +        minimum: 0
>>>>>>> +        maximum: 1
>>>>>>> +
>>>>>>> +      nand-ecc-strength:
>>>>>>> +        enum: [1, 4, 8]
>>>>>>> +
>>>>>>> +      nand-on-flash-bbt: true
>>>>>>> +
>>>>>>> +      nand-ecc-mode: true
>>>>>>> +
>>>>>>> +      nand-ecc-algo:
>>>>>>> +        description: |
>>>>>>> +          This property is essentially useful when not using hardware ECC.
>>>>>>> +          Howerver, it may be added when using hardware ECC for clarification
>>>>>>> +          but will be ignored by the driver because ECC mode is chosen depending
>>>>>>> +          on the page size and the strength required by the NAND chip.
>>>>>>> +          This value may be overwritten with nand-ecc-strength property.
>>>>>>> +
>>>>>>> +      nand-ecc-step-size:
>>>>>>> +        description: |
>>>>>>> +          Marvell's NAND flash controller does use fixed strength
>>>>>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>>>>>> +          will shrink or grow in order to fit the required strength.
>>>>>>> +          Step sizes are not completely random for all and follow certain
>>>>>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>>>>>> +
>>>>>>> +      label:
>>>>>>> +        $ref: /schemas/types.yaml#/definitions/string
>>>>>>> +
>>>>>>> +      partitions:
>>>>>>> +        type: object    
>>>>>>
>>>>>> That's not what I asked for. Like four times I asked you to add here
>>>>>> unevaluatedProperties: false and I never said that ref to partition.yaml
>>>>>> should be removed and you... instead remove that ref.
>>>>>>
>>>>>> You need to define here children and specify their ref.
>>>>>>
>>>>>> You must use unevaluatedProperties: false here. So this is fifth time I
>>>>>> am writing this feedback.
>>>>>>
>>>>>>    
>>>>>
>>>>> It is a bit confusing that it is needed to define "partitions" and "label" rules particulary
>>>>> in this nand controller instead of some common place like nand-chip.yaml, these properties
>>>>> are common also for the other nand controllers.    
>>>>
>>>> No one speaks about label, I never commented about label, I think...
>>>>
>>>> If you think the property is really generic and every NAND controller
>>>> bindings implement it, then feel free to include them there, in a
>>>> separate patch. It sounds sensible, but I did not check other bindings.  
>>>
>>> FYI, label is already defined in mtd/mtd.yaml.  
>>
>> Which is not included here and in nand-controller.yaml
> 
> Maybe nand-chip.yaml should?

mtd.yaml looks a bit more than that - also allows nvmem nodes. Maybe
let's just add label to nand-chip?

> 
>>> Partitions do not need to be defined in your binding, just don't put
>>> any in your example and you'll be fine. These partitions are either
>>> static and may be described in the DT (see
>>> mtd/partition/partition.yaml) or there is some dynamic discovery
>>> involved and a proper parser shall be referenced (parsers have their
>>> own binding).  
>>
>> I don't think this is correct. Basically you allow any node to be under
>> partitions as there is no schema validating them (without compatibles).
> 
> Sorry if that was unclear, what I meant is: partitions should not be
> defined in the bindings for Marvell NAND controller because they should
> be defined somewhere else already.

Ah, right. Then it seems reasonable.

> 
> NAND controller subnodes should define the storage devices (the
> flashes themselves) connected to the controller. "nand-chip.yaml"
> describes generic properties for these. Additional subnodes are allowed
> and expected to be partitions (this is not enforced anywhere I think),
> they should use one of the existing compatibles to define the parser.
> The most common parser is named fixed-partitions and has its own
> compatible. Every parser references partitions.yaml.
> 
> There are a few controller bindings however which reference
> partition.yaml anyway, probably to make the examples validation work,
> I'm not sure it should be done like that though:
> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> https://elixir.bootlin.com/linux/v6.0/source/Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml


Yes, so the nand-chip implementation (like Marvell NAND) could reference
the parser and we would be done. If it doesn't, then we must have
generic partitions in the nand-chip.

Best regards,
Krzysztof

