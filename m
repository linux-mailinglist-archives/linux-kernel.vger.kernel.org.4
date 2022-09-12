Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385505B58A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiILKo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiILKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:44:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E6192BB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:44:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f14so13167595lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=F5GFWlX5p+iK1uMljz0gi7oHJBPZquU122BFTAsILYU=;
        b=I7I0XbaD3zB7PPPgbSX9itHG4KiBz5coBxZLBl3oHU2imYvQhzYzeLkusK+K8RR2uJ
         mQ2gcpMbYoNuZkCYLhJuT2nqzpwToLAxHOIL+N7PlwUpoKxU+oCwVmYwmvUUzvs3QKsr
         9j/6XZHnm+t5AIJgfwQa0wRYc6razGcbtC+HXOOqfr8cHphk9b2XicS7aUsPnGOxHjHB
         sXO4a0mWXRlSmZStxHBfeHkvx92UTqQFKOHdrEPROXQtDr/C5d5KTXIMB5hIYLyjESsB
         +p+aWcwSQe0MYOlwNSiDiYwoYATAHhm/AYkc0dBH0rC6Lu2Ie20+a33SlQkRhKvTpbfd
         KX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=F5GFWlX5p+iK1uMljz0gi7oHJBPZquU122BFTAsILYU=;
        b=f4VyZr75FbnstSKrZvMWit3syWoBhH4l9nSmgeGTzxDbmMl1gXOeIhRAVysjwvs8OA
         hy0EQPZ+0Cnovwgji9K/gHJI6F3qc7GfsTpNueJi+xDYkKgxxpcHjEAElCdqCECwcWgE
         uE1tpaZdPFfbAPPG0aHolsNJRbgLMpGnpkm8N9TwNFO4dOGY7IdLxL2VqFUiqria8eoA
         Kmt4fNr3QVvrgaWHTp/mxVCQGEydOOv4uVi2Mt2Gs7pbFpgbkQDLhG5QXcKK4meVvrly
         lTBC7CBV1PpKAksl7AmCqltFk2FlWmJG2VEpjHv6Lvj5knAKoWDyygL0IB59F4WzE9He
         H45w==
X-Gm-Message-State: ACgBeo1h0WsVM4Na9g8Ctj4pBUVhNXE3YUyNIipD0k9oxrkfog6Nwj5K
        Qyl/kvQHIJi/MrOWJZOYi+lXTw==
X-Google-Smtp-Source: AA6agR7/0d9DiYev9RCBwIhVGhNfzBFslqnPc8Ij7QZ/jYKPApzGCBOfvtR+jDenXc5T/wt3zdzt3w==
X-Received: by 2002:a05:6512:b15:b0:492:ebc3:80d9 with SMTP id w21-20020a0565120b1500b00492ebc380d9mr9721467lfu.77.1662979462003;
        Mon, 12 Sep 2022 03:44:22 -0700 (PDT)
Received: from [10.129.96.84] ([109.232.243.34])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e7d12000000b00268d84f8db1sm1019944ljc.92.2022.09.12.03.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 03:44:21 -0700 (PDT)
Message-ID: <aa6d8c7d-1723-7674-2142-a5aafe30e570@linaro.org>
Date:   Mon, 12 Sep 2022 12:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Content-Language: en-US
To:     Sergiu.Moga@microchip.com, robh@kernel.org
Cc:     lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, richard.genoud@gmail.com,
        radu_nicolae.pirea@upb.ro, gregkh@linuxfoundation.org,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        jirislaby@kernel.org, admin@hifiphile.com,
        Kavyasree.Kotagiri@microchip.com, Tudor.Ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
 <20220909013644.GA3731620-robh@kernel.org>
 <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b6b044f6-de87-e85b-0b51-e957b90622ab@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 09:45, Sergiu.Moga@microchip.com wrote:
> On 09.09.2022 04:36, Rob Herring wrote:
>> On Thu, Sep 08, 2022 at 03:15:44PM +0000, Sergiu.Moga@microchip.com wrote:
>>> On 08.09.2022 15:30, Krzysztof Kozlowski wrote:
>>>> On 06/09/2022 15:55, Sergiu Moga wrote:
>>>>> Add the AT91SAM9260 serial compatibles to the list of SAM9X60 compatibles
>>>>> in order to highlight the incremental characteristics of the SAM9X60
>>>>> serial IP.
>>>>>
>>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
>>>>> ---
>>>>>
>>>>>
>>>>> v1 -> v2:
>>>>> - Nothing, this patch was not here before
>>>>>
>>>>>
>>>>>    Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>> index b25535b7a4d2..4d80006963c7 100644
>>>>> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>>>>> @@ -26,6 +26,8 @@ properties:
>>>>>          - items:
>>>>>              - const: microchip,sam9x60-dbgu
>>>>>              - const: microchip,sam9x60-usart
>>>>> +          - const: atmel,at91sam9260-dbgu
>>>>> +          - const: atmel,at91sam9260-usart
>>>>
>>>> This is weird. You say in commit msg to "highlight the incremental
>>>> characteristics" but you basically change here existing compatibles.
>>>
>>>
>>> Does "show that they are incremental IP's" sound better then?
>>>
>>>
>>>> This is not enum, but a list.
>>>>
>>>
>>>
>>> What do you mean by this? I know it is a list, I specified so in the
>>> commit message.
>>
>> You are saying that compatible must be exactly the 4 strings above in
>> the order listed. You need another entry with another 'items' list.
>>
>> Rob
> 
> 
> That is what was intended though: a list of the 4 compatibles in that 
> exact order. The 4th patch of this series also ensures that all 9x60 
> nodes have that exact list of 4 compatibles.

The commit msg suggest otherwise - two options, because it is
incremental... But this one is not really incremental - you require this
one, only one, configuration. It's in general fine, but commit msg
should reflect what you are really intend to do here and why you are
doing it.


Best regards,
Krzysztof
