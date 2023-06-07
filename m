Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9365726387
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjFGO6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjFGO6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:58:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FA1BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:57:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-978863fb00fso111271766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686149871; x=1688741871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hS+/6RkZ6WW8ubE3QAHP0j2dfS40b4EPse0M4avR6Ps=;
        b=uV34140YlRXfCTyvwQmF0ygN2KzxxQAFx2aKnrDWJIZ7CcMOMYL6YWxlEG3vPUgamo
         hMKRHuN1w4Xql1XHnJiEM2DV/bubLnxKoX02FpX1gbunk0Gc98ivSkq/LWkuRfMiFWVo
         rU3JnOgO7pjAT6kOjUQWNFW+0UkV3bC1HfBysfaEVx8GuGG5ek1UH1Ik3hZzuEj1XiqS
         ahcwY1J3Sy87DnKEAhnw/zXUK8eicOeo9hkwHBWdixscavmlQGIyufb6HmNWWQmxxWzR
         6JZqWXU0ksGpk6YsMvtRyBOSaXIVX+ob29+odYTk3OmTXvb4xW0aR7QlM3nZjgVFhMOb
         s+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149871; x=1688741871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hS+/6RkZ6WW8ubE3QAHP0j2dfS40b4EPse0M4avR6Ps=;
        b=SWEJPc2SOxmnUAa5+T72KesMBt9za4KhHLf814gC2MT1pi/ERIdz16bj6hUdugWUgi
         vPvyiZTIWIh8CE3fTRfw49TVmPzHw1B5rQT2T1/QdVkBwKigODkntIeB4zeUD9KiVePz
         a7yfeP8HyMd03i4uQJ0aUe3eVM3Io0HW8cgJk0PcL9OGIdOctCoxSezs/7RTHiGBDDB6
         zA/9RNvsFzDn5ItNdzC936NxuzFk9/mVYhUs6wcRZRkpurrEfA5ocEaIiIiu9F/8zf9w
         +Dsi2NMJsgnTQ6hnvTJNicYgq77Kg8CuLVdCIEf8f8EVXQV7er7HIe+XtvD4hIG86piL
         xa9A==
X-Gm-Message-State: AC+VfDyurMDledqKSj1lY1SNrocKZv1vBq4wXTByY4OMDtBNDZeQKCB3
        4OGK+85CvcVAVUSqZbN5rgmiGQ==
X-Google-Smtp-Source: ACHHUZ6q2knYhzj9DI2ztt8RiTkF5mX6pVfy2XZ+pCrakzMPlEg0MFdLvQw8wj2+ZzCvBPEnLNnVAg==
X-Received: by 2002:a17:907:7da6:b0:96a:ee54:9f19 with SMTP id oz38-20020a1709077da600b0096aee549f19mr5777366ejc.48.1686149870940;
        Wed, 07 Jun 2023 07:57:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id rk22-20020a170907215600b00977eda0ea29sm3171344ejb.14.2023.06.07.07.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:57:50 -0700 (PDT)
Message-ID: <881d6357-7190-7ef1-22a3-63a9b8533b4f@linaro.org>
Date:   Wed, 7 Jun 2023 16:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 05/10] dt-bindings: sc16is7xx: Add property to change
 GPIO function
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        jesse.sung@canonical.com, isaac.true@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
References: <20230607140525.833982-1-hugo@hugovil.com>
 <20230607140525.833982-6-hugo@hugovil.com>
 <f5cfc81d-d8ae-d270-f29a-c2b45b07a651@linaro.org>
 <20230607104100.0186b1afc872e583cb9466b8@hugovil.com>
 <a6301c0e-b774-8963-8eb1-8e0948b1468c@linaro.org>
 <20230607105249.6dc95ed226e3578a3c9116aa@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607105249.6dc95ed226e3578a3c9116aa@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 16:52, Hugo Villeneuve wrote:
> On Wed, 7 Jun 2023 16:46:56 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/06/2023 16:41, Hugo Villeneuve wrote:
>>> On Wed, 7 Jun 2023 16:30:26 +0200
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>>> On 07/06/2023 16:05, Hugo Villeneuve wrote:
>>>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>>>
>>>>> Some variants in this series of UART controllers have GPIO pins that
>>>>> are shared between GPIO and modem control lines.
>>>>>
>>>>> The pin mux mode (GPIO or modem control lines) can be set for each
>>>>> ports (channels) supported by the variant.
>>>>>
>>>>> This adds a property to the device tree to set the GPIO pin mux to
>>>>> modem control lines on selected ports if needed.
>>>>>
>>>>> Cc: <stable@vger.kernel.org> # 6.1.x
>>>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
>>>>> ---
>>>>>  .../bindings/serial/nxp,sc16is7xx.txt         | 46 +++++++++++++++++++
>>>>>  1 file changed, 46 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>>>> index 0fa8e3e43bf8..1a7e4bff0456 100644
>>>>> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>>>> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>>>> @@ -23,6 +23,9 @@ Optional properties:
>>>>>      1 = active low.
>>>>>  - irda-mode-ports: An array that lists the indices of the port that
>>>>>  		   should operate in IrDA mode.
>>>>> +- nxp,modem-control-line-ports: An array that lists the indices of the port that
>>>>> +				should have shared GPIO lines configured as
>>>>> +				modem control lines.
>>>>>  
>>>>>  Example:
>>>>>          sc16is750: sc16is750@51 {
>>>>> @@ -35,6 +38,26 @@ Example:
>>>>>                  #gpio-cells = <2>;
>>>>>          };
>>>>>  
>>>>> +	sc16is752: sc16is752@53 {
>>>>
>>>> Since you keep sending new versions, fix the names. nNode names should
>>>> be generic. See also explanation and list of examples in DT specification:
>>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>>
>>> Hi,
>>> by the way, I do not "keep sending new versions" just for the fun of
>>> it...
>>
>> Sure, I know. So when the next version is necessary to send, fix also this.
>>
>>>
>>> Even after reading your link, I cannot see what is wrong with that
>>> name.
>>
>> They are not generic. They are specific.
> 
> What do you mean by "They"? My patch adds only a new property...

Your patch adds multiple new examples. My comment was at appropriate
place to fix, although only the first place. I did not refer to
unrelated pieces or other parts of the code. Specifically - I wrote
nothing about property.

> 
> This patch will not fix old names, but a future patch could do it.

No worries, I asked for new code.

> 
> And what do you mean by "They are not generic. They are specific". Of
> course the property is specific, because it relates to something very
> specific to this chip?

Again, I did not comment under a property. I did not refer to any property.


Best regards,
Krzysztof

