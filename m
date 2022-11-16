Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B562B450
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiKPHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiKPHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:54:43 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B210B4B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:54:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so28237887lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmcXTCHKzz3DR46ClTN3tRFjXZaO4YMglWFF7gGQ/G8=;
        b=t3M5YQ0/9r8qNkSYncPQY1AbqnrIE06HFWD0E9iRczDVRHlWm0zOpuJYmhH0VFg/Dq
         jT9BsKwbMU8rKLswklCQnzPXY3OUs1x1GQB8/n6nq8ICb35php7B769e28fAlWB+Kfwk
         KM5dJLp0W+3DKwJN6Ra/cUuZJUFZSzeGpnomKP7B3ZZc6CQzob6TWDP0taK03ERa7Em2
         Zlfw2MJPLHR0i8oXsA8LS7BffHi4nhMGagmCwk4amI660QMVh/iUJzAM88X0mLedu+JM
         2F+Yc7DeIsKYMhaAtoGBIMX8io8+x9vNEVtmbuLD3XFsQCDUBKsJ11mNzkTgW/LQ7BAl
         K/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmcXTCHKzz3DR46ClTN3tRFjXZaO4YMglWFF7gGQ/G8=;
        b=M8QLTRU7G1RmDc4/MWqi9Jh6AXcNyf5lHLUAL2g/vpti1deOgbBJYmAiVTKMvN1ZDo
         +JQny1jjhg8spm+Hy74cWcNr0Gchi+PRpsO9bjT1bapFWZt20fGyj8xhz0otta+Y39Uf
         2wfC4z5caf4CjW4tgYh33Xz8+3OmEjvriU4QA8cnZtOBE8lKTKcvXgXP97vJkGVlSarN
         MNt2qaCoCjxiAQiC+HDYm23znm/ZHYxb15fP6YnIiX6q4XG0hw800MRfObGOBScSdWcc
         Tzxs7+1jtcXPyiIFlISvNaWl6K9rvNuBbDA7LtYF3yKz6LpHGpKkwZPkNZ5Xw+a0Nere
         lkkQ==
X-Gm-Message-State: ANoB5plHjGhoa5eDnD5x+/6wNa3vdatmfqpu/b3eAPH0A7JO8Nom9kaB
        33a1kToDiszLEC607beguV1CIA==
X-Google-Smtp-Source: AA0mqf5x7/6WU/xrYlS2suy3JdSdQNzG8ZLQHmAqV8cjJUYzmDUfoKdg5YuZO+nlI0S3V1/uD740Nw==
X-Received: by 2002:a05:6512:3415:b0:4a2:6df5:edb9 with SMTP id i21-20020a056512341500b004a26df5edb9mr7164379lfr.675.1668585280846;
        Tue, 15 Nov 2022 23:54:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z18-20020a056512371200b00498f77cfa63sm2487286lfr.280.2022.11.15.23.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 23:54:40 -0800 (PST)
Message-ID: <fd108794-5ba0-91c5-b3b6-4376226a6828@linaro.org>
Date:   Wed, 16 Nov 2022 08:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
 <20221115110932.637091-2-Naresh.Solanki@9elements.com>
 <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
 <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 21:30, Naresh Solanki wrote:
> Hi Krzysztof,
> 
> On 15-11-2022 07:34 pm, Krzysztof Kozlowski wrote:
>> On 15/11/2022 12:09, Naresh Solanki wrote:
>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>
>>> The MAX597x is a hot swap controller with configurable fault protection.
>>> It also has 10bit ADC for current & voltage measurements.
>>>
>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
>>>   1 file changed, 154 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>> new file mode 100644
>>> index 000000000000..edf0c23db4ca
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>> @@ -0,0 +1,154 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
>>> +
>>> +maintainers:
>>> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
>>> +
>>> +description: |
>>> +  The smart switch provides no output regulation, but independent fault protection
>>> +  and voltage and current sensing.
>>> +  Programming is done through I2C bus.
>>> +
>>> +  Datasheets:
>>> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>>> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - maxim,max5970
>>> +      - maxim,max5978
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  leds:
>>> +    type: object
>>> +    description:
>>> +      Properties for four LEDS.
>>> +
>>> +    properties:
>>> +      "#address-cells":
>>> +        const: 1
>>> +
>>> +      "#size-cells":
>>> +        const: 0
>>> +
>>> +    patternProperties:
>>> +      "^led@[0-3]$":
>>> +        $ref: /schemas/leds/common.yaml#
>>> +        type: object
>>> +
>>> +    additionalProperties: false
>>> +
>>> +  vss1-supply:
>>> +    description: Supply of the first channel.
>>> +
>>> +  vss2-supply:
>>> +    description: Supply of the second channel.
>>> +
>>> +  regulators:
>>> +    type: object
>>> +    description:
>>> +      Properties for both regulators. Also set value for shunt resistor used.
>>
>> You should explain not the syntax,  but what part of hardware this nodes
>> represents. Therefore "Also set value" does not fit at all. Hardware
>> sets value?
> You mean something like: Properties for power switch
>>
>> I looked at datasheets to figure it out but they do not refer to any
>> configurable regulator, LDO nor "sw0/sw1/sw2". Therefore I have no clue
>> what to expect here...
> Yes this is for power switch part of max5970/8

Nothing in max5970 datasheet about "power switch". "switch" fives two
results, not really related/explaining.

Bindings, your naming and explanation use terms not existing in
datasheet, so it does not look like you are describing hardware.

>>
>>> +
>>> +    patternProperties:
>>> +      "^sw[0-1]$":
>>> +        $ref: /schemas/regulator/regulator.yaml#
>>> +        type: object
>>> +        properties:
>>> +          shunt-resistor-micro-ohms:
>>> +            description: |
>>> +              The value of current sense resistor in microohms.
>>> +
>>> +        required:
>>> +          - shunt-resistor-micro-ohms
>>> +
>>> +      unevaluatedProperties: false
>>
>> I don't think it has proper indentation. Did you test the binding?
> Definitely tested the bindings before I push the patch.

Anyway it is wrong. It must be on the level of properties.


Best regards,
Krzysztof

