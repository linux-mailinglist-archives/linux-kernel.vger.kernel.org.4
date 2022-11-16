Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B562C912
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKPTjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:39:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F2ACDD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:39:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l6so17481585pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivB+2nw033Stj2pVNCL0uKhxX5EdSjd5bX4qpd43T+Q=;
        b=OBi9QbBGm9GR+xBwie9QsTtxqYrm4cGpPfjDQiKhJrF0dzHHvPfLt7y6jpRac0Q8ZJ
         wGLXLRSts/oBDzvB5VzzP5GGFG6qSAtXxkRMdyW/nrWD4K1eopPud41+wT8ps7B5E/CB
         9RgfCG6U7sBOqhQTwFkNA7uW4mpmwwHEv+uZX19Y/fLdO8Ujd2/RLpjiH0FbApjCt3hR
         BWDk0l7IQ9bbooi0lj3Y97aGn+0Vl1cdUzPK2f7zqn3yta2ppTmsz9UuyZ8Xl06ZFRG9
         G6dMROzGzoDgYgu7dacka+5ZHOdnHYI2GhM592ynYpvE9sxaeP41o91JqE+ShGG3vPxs
         bNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivB+2nw033Stj2pVNCL0uKhxX5EdSjd5bX4qpd43T+Q=;
        b=2hIsEq+HV/8A2hqtyadMXJOQ4aIvyS7BtVr8NdP6IgJHH4sj6EvYfzMZu9aSOQgDtv
         hqkj+XEl/ztlo6Jy5mXjaB8dGMGTP/yUUK7lGiSAKpLW9LK6OBcj/1rpsxPE3RFlNgCa
         fsGLhFl/gTOnhig1L54phE3Z9px3Mh7d5g+s+YikKPb3vz60Hnuc6wkpwMDKj8bh/bem
         QgKo9HMXWKozdZ4oe6DrAv8XN6IHk7HIvkLpTBpe/BIHq0P3mea3T+spnAqfP4Sq7AQa
         vwUhQKrX/+RylxCJ9KFKXLJ9Rvxepuakm40j35S8tX39NCVfkaFhqjpcg947e24VNDNn
         Co+g==
X-Gm-Message-State: ANoB5pkic3eBdZ7gLlkFIcKFi1YGIsTNGHYvkFMpPOBckYzFYoLasuag
        z5FprbXuf2WFBagG2cSMxxsdpg==
X-Google-Smtp-Source: AA0mqf7LImv8/sdfn2Xh27eqxhCzfTU//on3imITBz5F+89sbrfeN2y1RMh5ypY54/hFdAUe9+Al7Q==
X-Received: by 2002:a17:902:6bcc:b0:176:c7d0:ecf0 with SMTP id m12-20020a1709026bcc00b00176c7d0ecf0mr10699599plt.43.1668627569554;
        Wed, 16 Nov 2022 11:39:29 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902d58b00b001868d4600b8sm12623969plh.158.2022.11.16.11.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 11:39:29 -0800 (PST)
Message-ID: <0f812132-120e-ffb5-002e-3798854a3c8b@9elements.com>
Date:   Thu, 17 Nov 2022 01:09:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
 <20221115110932.637091-2-Naresh.Solanki@9elements.com>
 <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
 <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
 <fd108794-5ba0-91c5-b3b6-4376226a6828@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <fd108794-5ba0-91c5-b3b6-4376226a6828@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzystof,

On 16-11-2022 01:24 pm, Krzysztof Kozlowski wrote:
> On 15/11/2022 21:30, Naresh Solanki wrote:
>> Hi Krzysztof,
>>
>> On 15-11-2022 07:34 pm, Krzysztof Kozlowski wrote:
>>> On 15/11/2022 12:09, Naresh Solanki wrote:
>>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>>
>>>> The MAX597x is a hot swap controller with configurable fault protection.
>>>> It also has 10bit ADC for current & voltage measurements.
>>>>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>>> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>>> ---
>>>>    .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
>>>>    1 file changed, 154 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>>> new file mode 100644
>>>> index 000000000000..edf0c23db4ca
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>>> @@ -0,0 +1,154 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
>>>> +
>>>> +maintainers:
>>>> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
>>>> +
>>>> +description: |
>>>> +  The smart switch provides no output regulation, but independent fault protection
>>>> +  and voltage and current sensing.
>>>> +  Programming is done through I2C bus.
>>>> +
>>>> +  Datasheets:
>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>>> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - maxim,max5970
>>>> +      - maxim,max5978
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  leds:
>>>> +    type: object
>>>> +    description:
>>>> +      Properties for four LEDS.
>>>> +
>>>> +    properties:
>>>> +      "#address-cells":
>>>> +        const: 1
>>>> +
>>>> +      "#size-cells":
>>>> +        const: 0
>>>> +
>>>> +    patternProperties:
>>>> +      "^led@[0-3]$":
>>>> +        $ref: /schemas/leds/common.yaml#
>>>> +        type: object
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +  vss1-supply:
>>>> +    description: Supply of the first channel.
>>>> +
>>>> +  vss2-supply:
>>>> +    description: Supply of the second channel.
>>>> +
>>>> +  regulators:
>>>> +    type: object
>>>> +    description:
>>>> +      Properties for both regulators. Also set value for shunt resistor used.
>>>
>>> You should explain not the syntax,  but what part of hardware this nodes
>>> represents. Therefore "Also set value" does not fit at all. Hardware
>>> sets value?
>> You mean something like: Properties for power switch
>>>
>>> I looked at datasheets to figure it out but they do not refer to any
>>> configurable regulator, LDO nor "sw0/sw1/sw2". Therefore I have no clue
>>> what to expect here...
>> Yes this is for power switch part of max5970/8
> 
> Nothing in max5970 datasheet about "power switch". "switch" fives two
> results, not really related/explaining.
In datasheet the term used is hot swap controller & uses external fet.
Although it gives output 1:1 i.e., doesnt steps up/down the input supply.
i.e., regulator driver is used here.
> 
> Bindings, your naming and explanation use terms not existing in
> datasheet, so it does not look like you are describing hardware.
> 
>>>
>>>> +
>>>> +    patternProperties:
>>>> +      "^sw[0-1]$":
>>>> +        $ref: /schemas/regulator/regulator.yaml#
>>>> +        type: object
>>>> +        properties:
>>>> +          shunt-resistor-micro-ohms:
>>>> +            description: |
>>>> +              The value of current sense resistor in microohms.
>>>> +
>>>> +        required:
>>>> +          - shunt-resistor-micro-ohms
>>>> +
>>>> +      unevaluatedProperties: false
>>>
>>> I don't think it has proper indentation. Did you test the binding?
>> Definitely tested the bindings before I push the patch.
> 
> Anyway it is wrong. It must be on the level of properties.
Will update in next version.
> 
> 
> Best regards,
> Krzysztof
> 

Regards,
Naresh
