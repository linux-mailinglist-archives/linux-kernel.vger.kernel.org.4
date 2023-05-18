Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF764707A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 09:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjERHF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 03:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjERHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 03:05:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850371FFC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:05:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so2948712a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 00:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684393521; x=1686985521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HB3cwJV0mSmYqqN+17Ku1gQOxvoolxHz8jVfs5CGGuY=;
        b=Br4iCjwDzrKp05ZAWSLABuiOx30EM3t05C8aD/R+b3Gt8cMco6WYrPIUrZu7MZe2LX
         gPPDa/BT9PCYVCekVhT1YVT2G5Rg/oEL6RLHEOhg+MCKLm/NhV4KZmmdTRg1qlex2oEX
         PjoU811j6UlBAalG1Qo6GGNx1eEJnwi/tRekUB/DrqpelPMuyI4KPx0qjt93tlO2Et7o
         qI1j6kK4bcaRzSEaw3NVP8b+28vN74iZ1WPb29O3PbTpmj6V51IjxB93v616prV+xo8i
         wM5SJr0FTRHp5EeLhdIv8IB2QH7OyvnRHHmxxBHQ05EspTwvh9SBrQkWU5RuxPmGSn+a
         CxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684393521; x=1686985521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HB3cwJV0mSmYqqN+17Ku1gQOxvoolxHz8jVfs5CGGuY=;
        b=MGE4PQHxoKQeFlygd48ypnI46qeqTasKs8KAK9IbdttpaT9CMd3COKuwmYZNdANg4Y
         cFdkTdPP9AIBu8bzOYTRKBfn3fGjGUMHSZ7MQ8iZG39h02yyryz0IaPIHSG/MlrYOGQg
         foiL2uZYooUhltDHt2Gn0Ckr7yx87zxMMWBDa8lEdk7XFn+hboDr5cOFae+Q3bjBBCPy
         2Usk5KnxPzN+KcbuDKIcXG07+hk5XX/PzGYqj2ICiticfv8W0QIP1+5JGGnLPKE+AL5q
         PN1whMaf0+e5ROYcXxsXqsGfYjfz8iWgW5bgUwJ2l1lxwv7O4cz93dQXg2Q/TFNJIvgm
         Huww==
X-Gm-Message-State: AC+VfDybWs8eMQnhSqqElEpEYhglTiChQZ1T7c9mkpcy7owe1d/Ce+fP
        7J1sEfQfGzkSnU1+e4JTZkKohA==
X-Google-Smtp-Source: ACHHUZ6YGHm2Ye48O/6ou6X1U2dvgx77S0q7J8MRBOF4Mz4C2w69aPtohxBn0ToX9DTg5Zgy77w+HA==
X-Received: by 2002:a17:907:6287:b0:94f:29f0:edc0 with SMTP id nd7-20020a170907628700b0094f29f0edc0mr42034234ejc.44.1684393520981;
        Thu, 18 May 2023 00:05:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a2b:c408:5834:f48e? ([2a02:810d:15c0:828:a2b:c408:5834:f48e])
        by smtp.gmail.com with ESMTPSA id l18-20020a170906a41200b00965a52d2bf6sm567990ejz.88.2023.05.18.00.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 00:05:20 -0700 (PDT)
Message-ID: <c969276f-9e29-9337-44f5-aac445e061eb@linaro.org>
Date:   Thu, 18 May 2023 09:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
To:     Claudiu.Beznea@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Conor.Dooley@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230517094119.2894220-1-claudiu.beznea@microchip.com>
 <20230517094119.2894220-3-claudiu.beznea@microchip.com>
 <83f484ff-f170-6f32-f4b4-9743eb6d0b4c@linaro.org>
 <d115cd4d-2a4f-552c-692c-c69ae49fe21e@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d115cd4d-2a4f-552c-692c-c69ae49fe21e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2023 08:03, Claudiu.Beznea@microchip.com wrote:
> On 17.05.2023 17:21, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 17/05/2023 11:41, Claudiu Beznea wrote:
>>> Convert Atmel PMC documentation to yaml. Along with it clock names
>>> were adapted according to the current available device trees as
>>> different controller versions accept different clock (some of them
>>> have 3 clocks as input, some has 2 clocks as inputs and some with 2
>>> input clocks uses different clock names).
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - atmel,at91rm9200-pmc
>>> +              - atmel,at91sam9260-pmc
>>> +              - atmel,at91sam9g20-pmc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        clock-names:
>>> +          items:
>>> +            - const: slow_xtal
>>> +            - const: main_xtal
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - atmel,sama5d2-pmc
>>> +              - atmel,sama5d3-pmc
>>> +              - atmel,sama5d4-pmc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        clock-names:
>>> +          items:
>>> +            - const: slow_clk
>>> +            - const: main_xtal
>>
>> This and previous if, should be squashed. You have exactly the same then:.
> 
> Clock names are different. Or do you propose to have a if for
> clocks:
>   minItems: 2
>   maxItems: 2
> 
> and 2 ifs for clock names?

Ah, I see, they have different names - xtal -> clk.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

