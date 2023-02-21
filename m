Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B0C69DD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjBUJkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjBUJke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:40:34 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607532310D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:40:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec43so14059906edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlOXMn0s5AtkjZxxRBnGgPn2rEvNAOj312v73/0i/GA=;
        b=rNF7xkDV9KvqjuTtlM90i/1Wabi8Fba1xKQ5jLA/RxpLHPN4gIwYSg+5wKy3pVaoXq
         1h1eIzGDbf9DHIrAyKYkqEOGagaWLrB2K5Qkvg7xbjR8SKdO19UlbNFoRAlq8aJCo9yZ
         68U25JmgazmQJb9MePyXyRxaPabYVIQEAqmZzCi+FKEb4D3suPak7Bdr7TZlaSSspPM/
         TsIVE4cR5aCOJcPf/f8Q+se1LA7UmLf30TB/XLQfgA/YlSMlxy37EDJ6My4ybXPgZcIj
         lM44zQ9Sip0UtKZAzfJ4SanJ1QqnTwWXKvnfWLoLAwg22c2Q6egtczgzs+HY4ou6dSMT
         ulJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlOXMn0s5AtkjZxxRBnGgPn2rEvNAOj312v73/0i/GA=;
        b=GhSNJaqo7CX7m2z0ZG+4KTjzBTtiC4PTJmP0uL3c6LWS6cyYsVVXgpCDCi4yYmY8sH
         wLf37IJDWvjmSEj7TauDmoqhBZYG5uKpi1L9tNDRrY7sAccd3UJo28+GmZeeoiWrGNcg
         GIc6+kX9kLHFFEK69vTZyEzUKnhdltUmlhh16jyupG70KcPArbNndhTVKE3T80t2kFsn
         KhxiMwulJHW468zkObeYzeAanYHjRPhSijW+lmqWFRm1IaqoaImneAQYmJqGwKsshfxH
         lR7OFBc6x41g7IygbgJaWUgzinpjwDcZ4/xkhm7fNpkrFmKSkbqHOKyLfYFTyyyM3Uj/
         otTA==
X-Gm-Message-State: AO0yUKWmOS9YSIW1i645sSdE4rBEfeLK3XEvnz5J00UM0Hct/vVvyq7h
        JPMQsmP+k+cvmtk3z8Y34re4S6MiITWpVUSL
X-Google-Smtp-Source: AK7set+BhjFYI6p03j8468K6LgAymT0HAgfxPQlMfjKB0N3Nku3bVzLRGM/6PVEmDNus/khqt9NIjA==
X-Received: by 2002:a17:907:6d0a:b0:8af:4418:8700 with SMTP id sa10-20020a1709076d0a00b008af44188700mr16264523ejc.47.1676972431867;
        Tue, 21 Feb 2023 01:40:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t18-20020a170906949200b008bfe95c46c3sm4198861ejx.220.2023.02.21.01.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:40:31 -0800 (PST)
Message-ID: <80d873d4-d813-6c25-8f47-f5ff9af718ec@linaro.org>
Date:   Tue, 21 Feb 2023 10:40:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB527427ADCCD29DFD77FB0EE3F2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
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

On 21/02/2023 03:43, Ryan Chen wrote:
> Hello Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, February 20, 2023 4:35 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
>>
>> On 20/02/2023 07:17, Ryan Chen wrote:
>>> AST2600 support new register set for I2Cv2 controller, add bindings
>>> document to support driver of i2cv2 new register mode controller.
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>>  .../devicetree/bindings/i2c/aspeed,i2cv2.yaml | 83
>>> +++++++++++++++++++
>>>  1 file changed, 83 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
>>
>> New compatible is okay, but as this is the same controller as old one, this
>> should go to old binding.
>>
>> There are several issues anyway here, but I won't reviewing it except few
>> obvious cases.
>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
>>> b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
>>> new file mode 100644
>>> index 000000000000..913fb45d5fbe
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2cv2.yaml
>>> @@ -0,0 +1,83 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/i2c/aspeed,i2cv2.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ASPEED I2Cv2 Controller on the AST26XX SoCs
>>> +
>>> +maintainers:
>>> +  - Ryan Chen <ryan_chen@aspeedtech.com>
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - aspeed,ast2600-i2cv2
>>> +
>>> +  reg:
>>> +    minItems: 1
>>> +    items:
>>> +      - description: address offset and range of register
>>> +      - description: address offset and range of buffer register
>>
>> Why this is optional?
> 
> Will modify minItems: 1 to 2
>>
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description:
>>> +      Reference clock for the I2C bus
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  clock-frequency:
>>> +    description:
>>> +      Desired I2C bus clock frequency in Hz. default 100khz.
>>> +
>>> +  multi-master:
>>> +    type: boolean
>>> +    description:
>>> +      states that there is another master active on this bus
>>
>> Drop description and type. Just :true.
>>
> Since i2c.txt have multi-master will drop it.
>>> +
>>> +  timeout:
>>> +    type: boolean
>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>
>> Why this is property for DT? It's for sure not bool, but proper type coming from
>> units.
> This is i2c controller feature for enable slave mode inactive timeout and
> also master mode sda/scl auto release timeout. 
> So I will modify to 
>   aspeed,timeout:
> 	type: boolean
>     description: I2C bus timeout enable for master/slave mode 

This does not answer my concerns. Why this is board specific?

> 
>>> +
>>> +  byte-mode:
>>> +    type: boolean
>>> +    description: Force i2c driver use byte mode transmit
>>
>> Drop, not a DT property.
>>
>>> +
>>> +  buff-mode:
>>> +    type: boolean
>>> +    description: Force i2c driver use buffer mode transmit
>>
>> Drop, not a DT property.
>>
> The controller support 3 different for transfer.
> Byte mode: it means step by step to issue transfer.
> Example i2c read, each step will issue interrupt then enable next step.
> Sr (start read) | D | D | D | P
> Buffer mode: it means, the data can prepare into buffer register, then
> Trigger transfer. So Sr D D D P, only have only 1 interrupt handling. 
> The DMA mode most like with buffer mode, 
> The differ is data prepare in DRAM, than trigger transfer. 
> 
> So, should I modify to
>   aspeed,byte:
> 	type: boolean
>     description: Enable i2c controller transfer with byte mode
> 
>   aspeed,buff:
> 	type: boolean
>     description: Enable i2c controller transfer with buff mode

1. No, these are not bools but enum in such case.
2. And why exactly this is board-specific?



Best regards,
Krzysztof

