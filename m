Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215B0608EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJVQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJVQtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:49:16 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8189D13B53C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:49:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r19so3470373qtx.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWHwWqM3BXKlqAbT6QrzFF/UUpibvbLYi2O5amk60U4=;
        b=ogCxatazZKWZRhhAUwP+5F6AJ8YlAWU+ohtbMidz6OXm1yNePCRATsxZp5oRVpW+A0
         p9NYEDjH83TE8PMVPOfIkhT6CS6HDkxOGBdeUU/Sl4GpxX/p+bOp+TQ2TviTAGPYfEN7
         Fg5gOOGp+oH8bXUlwYJ6688yOFmDGYpQbO3wjVusgiWYagHvCkKeywXEojgiHQ3WH0k4
         mEi9Y0KzuyjiANtaGM2LmBWL4021SGDvEyZdzGZS/3PWXsSDtZFm0KM8apP73oACp0Nf
         QN1tePmnF5nWKZJUcm8X0JoAeAJOKcdwwdlMY7prETHOllDQoTyKZ9YmXZRR0F2eQm+3
         f6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWHwWqM3BXKlqAbT6QrzFF/UUpibvbLYi2O5amk60U4=;
        b=i0MgzZ1AceeC44g1s/RjM4PXOkb/UZ8Rl6CoMUgAiQrYCBEsBM8uQKD9L6KTlQr0Aw
         P7FCfzjYsFiMdvzJ2ZN5h6sGvGyWt634ZuyZIHPZfEUWPZchvAl8QhdU7SyO7RyXtL4Z
         aIhj9UsuuwwcxTfoeAtDUdr/ee9uTyBTqAYC/PHsO2ng/HlEk7BCCyGWO0dV4iGdM8Gr
         vwWo0tyMFFWqJK1RKmsxrVwDeWtTd1ycLuTFUeQDDOD7vEPsaNGz0dtdk5Y4adK93MaA
         yK1iykWccos2dPiLahLse1jKPBWyuaRncv4hU5xGjxseFlOvVMYauitAlH7y23IqOUaz
         JS0Q==
X-Gm-Message-State: ACrzQf2eWuMP7a2d/Vw7Z3jIPNhFNbJLBqZCyCBZvnYzIUhqLeSLMwuV
        z3Kf2o+0zODgDEhp5MWdg4WGLw==
X-Google-Smtp-Source: AMsMyM7MX1BEUs2JSI2Qn3PmiNnVDugW3rD+1D64oX5nMvP/6Fj64lJHcVW1yUkBKT8ar+TIesapXw==
X-Received: by 2002:ac8:5b10:0:b0:39c:d63a:d88 with SMTP id m16-20020ac85b10000000b0039cd63a0d88mr20932702qtw.682.1666457339565;
        Sat, 22 Oct 2022 09:48:59 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id c25-20020ac81119000000b003996aa171b9sm9752605qtj.97.2022.10.22.09.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:48:58 -0700 (PDT)
Message-ID: <253fc459-c3dc-7710-6f34-0466d5301482@linaro.org>
Date:   Sat, 22 Oct 2022 12:48:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 3/6] dt-bindings: sound: Add sound card bindings for Tesla
 FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        'Rob Herring' <robh@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
 <CGME20221014104901epcas5p1a61ea81c3b1640bd8a064633c0b1e40d@epcas5p1.samsung.com>
 <20221014102151.108539-4-p.rajanbabu@samsung.com>
 <20221014151325.GA1940481-robh@kernel.org>
 <04b901d8e529$573b17e0$05b147a0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04b901d8e529$573b17e0$05b147a0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 04:44, Padmanabhan Rajanbabu wrote:
>> On Fri, Oct 14, 2022 at 03:51:48PM +0530, Padmanabhan Rajanbabu wrote:
>>> Add dt-binding reference document to configure the DAI link for Tesla
>>> FSD sound card driver.
>>
>> The simple-card or graph-card bindings don't work for you?
> Thank you for reviewing the patch.
> 
> The actual reason for having a custom sound card driver lies in the fact
> that the Samsung i2s cpu dai requires configuration of some Samsung
> specific properties like rfs, bfs, codec clock direction and root clock
> source. We do not have flexibility of configuring the same in simple card
> driver (sound/soc/generic/simple-card.c) or audio graph card driver 
> (sound/soc/generic/audio-graph-card.c). The binding has been added to
> support the custom sound card driver.
> 
> I understand from your query that the newly added card has device tree
> nodes and properties which are used in simple card as well, but having a
> different or new prefixes. I believe to address that, we can restructure
> the string names to generic ones. 

You must use generic, existing properties where applicable.

> But I would like to understand, to reuse
> the simple card or audio graph card bindings, can we add secondary
> compatible strings in the simple card dt-binding for the custom sound card
> to probe ?

If you see other vendor compatibles there, then yes... But there aren't
any, right?

>>
>>>
>>> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>> ---
>>>  .../bindings/sound/tesla,fsd-card.yaml        | 158 ++++++++++++++++++
>>>  1 file changed, 158 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
>>> b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
>>> new file mode 100644
>>> index 000000000000..4bd590f4ee27
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/tesla,fsd-card.yaml
>>> @@ -0,0 +1,158 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright
>>> +2022 Samsung Electronics Co. Ltd.
>>> +%YAML 1.2
>>> +---
>>> +$id:
>>> +https://protect2.fireeye.com/v1/url?k=4ae54403-157e7d1c-4ae4cf4c-
>> 000b
>>> +abdfecba-9eb398ea304f8ae8&q=1&e=4935bed0-ce62-47dd-8faf-
>> 4750b01e22d3&
>>>
>> +u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fsound%2Ftesla%2Cfsd-
>> card.ya
>>> +ml%23
>>> +$schema:
>>> +https://protect2.fireeye.com/v1/url?k=8c72226e-d3e91b71-8c73a921-
>> 000b
>>> +abdfecba-3ce999f6c052255b&q=1&e=4935bed0-ce62-47dd-8faf-
>> 4750b01e22d3&
>>> +u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>> +
>>> +title: Tesla FSD ASoC sound card driver
>>> +
>>> +maintainers:
>>> +  - Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
>>> +
>>> +description: |
>>> +  This binding describes the node properties and essential DT entries
>>> +of FSD
>>> +  SoC sound card node
>>> +
>>> +select: false
>>
>> Never apply this schema. Why?
> Sorry about it, let me change the select property to true in the next
> patchset

No, just drop it. Look at other bindings or at example-schema

>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - tesla,fsd-sndcard
>>> +
>>> +  model:
>>> +    description: Describes the Name of the sound card
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +  widgets:
>>> +    description: A list of DAPM widgets in the sound card. Each entry
> is a pair
>>> +      of strings, the first being the widget name and the second being
> the
>>> +      widget alias
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +
>>> +  audio-routing:
>>> +    description: A list of the connections between audio components.
> Each entry
>>> +      is a pair of strings, the first being the connection's sink, the
> second
>>> +      being the connection's source
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +
>>> +  dai-tdm-slot-num:
>>> +    description: Enables TDM mode and specifies the number of TDM slots
> to be
>>> +      enabled
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]
>>
>> maximum: 8
> Okay
>>
>>> +    default: 2
>>> +
>>> +  dai-tdm-slot-width:
>>> +    description: Specifies the slot width of each TDm slot enabled
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [8, 16, 24]
>>> +    default: 16
>>
>> All the above have types defined. You should not be redefining the types.
> Okay
>>
>>> +
>>> +  dai-link:
>>> +    description: Holds the DAI link data between CPU, Codec and
> Platform
>>> +    type: object
>>
>>        additionalProperties: false
> okay
>>
>>> +    properties:
>>> +      link-name:
>>> +        description: Specifies the name of the DAI link
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +      dai-format:
>>> +        description: Specifies the serial data format of CPU DAI
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +      tesla,bitclock-master:
>>> +        description: Specifies the phandle of bitclock master DAI
>>> +        $ref: /schemas/types.yaml#/definitions/phandle
>>> +
>>> +      tesla,frame-master:
>>> +        description: Specifies the phandle of frameclock master DAI
>>> +        $ref: /schemas/types.yaml#/definitions/phandle
>>
>> These are common properties. Drop 'tesla'.
> Okay
>>
>>> +
>>> +      cpu:
>>> +        description: Holds the CPU DAI node and instance
>>> +        type: object
>>
>>            additionalProperties: false
> Okay
>>
>>> +        properties:
>>> +          sound-dai:
>>> +            description: Specifies the phandle of CPU DAI node
>>> +            $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +
>>> +        required:
>>> +          - sound-dai
>>> +
>>> +      codec:
>>> +        description: Holds the Codec DAI node and instance
>>> +        type: object
>>
>>            additionalProperties: false
> Okay
>>
>>> +        properties:
>>> +          sound-dai:
>>> +            description: Specifies the phandle of Codec DAI node
>>> +            $ref: /schemas/types.yaml#/definitions/phandle-array
>>
>> Already has a type. Need to define how many entries (maxItems: 1 ?).
> Okay. I'll update in the upcoming patch set
>>
>>> +
>>> +        required:
>>> +          - sound-dai
>>> +
>>> +    required:
>>> +      - link-name
>>> +      - dai-format
>>> +      - tesla,bitclock-master
>>> +      - tesla,frame-master
>>> +      - cpu
>>> +
>>> +dependencies:
>>> +  dai-tdm-slot-width: [ 'dai-tdm-slot-num' ]
>>
>> This should be captured with tdm-slot.txt converted to schema.
> Okay
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - model
>>> +  - dai-link
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    sound {
>>> +        compatible = "tesla,fsd-sndcard";
>>> +        status = "disabled";
>>
>> Why have a disabled example? Other than your example won't pass your
>> schema.
> Thanks for noticing, I'll double check and change the example keeping the
> status 
> as enabled

No, just drop. Start with example-schema instead.

Best regards,
Krzysztof

