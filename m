Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF3C6F8485
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjEEOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEEOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:07:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AB12EAF
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:07:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so27519271a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683295652; x=1685887652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mfe37bhZKfVzu7XYhiq7AznCwFGYTw35W2iL7Bje62g=;
        b=YCZRcNQIJMtF4Q0VKYQKCmoy57PhoEcBAs+SZCUZu60gmjEh3QxcKeySIs1wdhFkBj
         hzgX+0f8QcwAO1WtttnkbEIkWvq4Bpl6KrThUjLMexgOcRIwju0IGRXO89ZieROPdZHQ
         UEFkRtaoCXp0HI4sfzlRtdX7wlJuS/MAE1dOfJVXu910/SzjQWvmYTbyeB0rEh2HjlUt
         iMsSyzLziqWjwiU94FTysbqQPw4RVcd+dv8qwLTp6hN9A7MqZcQzMAiC3ilYsLavk9uW
         nE9BNUwUOHfjU9b1yJYLXNjDD7RCv0sQf6TI5MKTtBe747XNSNaEF62lWM2kaxukIYkX
         uF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295652; x=1685887652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfe37bhZKfVzu7XYhiq7AznCwFGYTw35W2iL7Bje62g=;
        b=TTefB2n1yBtrl8/+saKKh8gSSTPZKguyMlRse04540qSJVFvUKbeRGvbO4UpoB68fW
         YuSDkzmQnn5JGPHGh7cBVnJX6i0j3kG0hyiaZEXiR5rGVFe+VfyMs6YP5ENmKIRPYPIC
         pd3YxwO9Oa4jZf/YxE6B/+WAGZSo8FdncoMnwT2ZNY8KJbQnUovHmz+uHuDwS//b01J/
         vLl7Kdz1YdnTnvOWXONLOvchj/LjKlx5+0EQCRUTkNsFz/zU0sqwc1qHFJAozgif7wna
         sURM/JCQtL5d+Thohn5UdoF0Hof42/58sgqbJelw7mobk316sjh0e7R1N+ZlSiGENyTs
         OwOA==
X-Gm-Message-State: AC+VfDxGQ0TddZEBreSDnYYwMRaHjgb5yYZor/rbMIWTLjQLinaBHn+P
        Ujw2TXAdHVZgTBjgPEKMIhzI+w==
X-Google-Smtp-Source: ACHHUZ4GoVgXpiweHDRZdftQNnAgyTrTOi5YGaMTAkEIzK3CS02eT0yzC3NW4C2X1xnIQTBfzsy0vQ==
X-Received: by 2002:a17:907:1690:b0:94f:6316:ce8d with SMTP id hc16-20020a170907169000b0094f6316ce8dmr1960135ejc.34.1683295651914;
        Fri, 05 May 2023 07:07:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id ze15-20020a170906ef8f00b0093a0e5977e2sm973932ejb.225.2023.05.05.07.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 07:07:30 -0700 (PDT)
Message-ID: <27f30e11-c9cf-2e21-bbea-c6f1cd504cfe@linaro.org>
Date:   Fri, 5 May 2023 16:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert to
 yaml
Content-Language: en-US
To:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230504060729.689579-1-claudiu.beznea@microchip.com>
 <20230504060729.689579-3-claudiu.beznea@microchip.com>
 <a964eeef-1db0-0d8a-e2a5-9e4c5fd8b2f0@linaro.org>
 <a7a40eda-9487-833d-8b6a-788812e8b80c@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a7a40eda-9487-833d-8b6a-788812e8b80c@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 14:46, Claudiu.Beznea@microchip.com wrote:
> On 04.05.2023 15:47, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 04/05/2023 08:07, Claudiu Beznea wrote:
>>> Convert Atmel PMC documentation to yaml.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>
>>> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>> new file mode 100644
>>> index 000000000000..c4023c3a85f2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
>>> @@ -0,0 +1,161 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/clock/atmel,at91rm9200-pmc.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>
>> Drop quotes from both.
>>
>>> +
>>> +title: Atmel Power Management Controller (PMC)
>>> +
>>> +maintainers:
>>> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
>>> +
>>> +description:
>>> +  The power management controller optimizes power consumption by controlling all
>>> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
>>> +  to many of the peripherals and to the processor.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - const: atmel,at91sam9260-pmc
>>
>> Why this is separate, not part of bottom enum?
> 
> Current device trees uses the following compatibles (among others):
> - "atmel,at91sam9260-pmc, "syscon" or
> - "atmel,at91sam9g20-pmc", "atmel,at91sam9260-pmc, "syscon"
> 
> I haven't found another way to make dtbs_check happy.
> Is there another way for this?

I mean the enum at the bottom of all compatibles.

>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    pmc: clock-controller@f0018000 {
>>> +        compatible = "atmel,sama5d4-pmc", "syscon";
>>> +        reg = <0xf0018000 0x120>;
>>> +        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>>
>> interrupt looks a bit odd. Are you sure it is correct?
> 
> This example is from SAMA5D4 SoC which uses a vendor specific interrupt
> controller (Atmel AIC) where:
> - 1st cell is the interrupt number
> - 2nd cell is the interrupt type (level/edge sensitive)
> - 3rd cell is the IRQ priority

ok

Best regards,
Krzysztof

