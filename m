Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D526BE5F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjCQJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQJwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:52:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172165A1AA;
        Fri, 17 Mar 2023 02:52:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b20so2749182pfo.6;
        Fri, 17 Mar 2023 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679046761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PsEb3SDGOwkHQaNoHVoDRTOrknkbKKQLzhqYs04kgsY=;
        b=GzPAATDzw6A/6u4KXzA+AaQVvrcynfPngF05VYXSSHt1qVA+U8Jw2pmnHaOPht7al7
         FiPT/neB9YppTRU1zq8840dGabMAccjOZ1U9F4nnPurOVt8ZkY6veTbC62PoHQcIvLuV
         8JcxvnGM+eiATwnE5I+oFZ055GqIYB32qJqyf1Cnc5NR8Gdv4vcql/3hPb8OufYIS+ow
         v0RqEz/BaL3CRuz5pa+uwMTo0443FL4bnVVEfcksR1X+68wruR/HYUL4s3OFA5rww/Tj
         Q2pxI8n2fuWRwTEAznyQVdwoWnPndbqr1x6hF5NbcfAyq+EREkEWBkdDAUeEO4UwoMM7
         bcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679046761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PsEb3SDGOwkHQaNoHVoDRTOrknkbKKQLzhqYs04kgsY=;
        b=2XWN0q9KLpAmVcFEdafSwXX3+8HC1PZDqoE1fEy0r97DIwqPXi9+BSis2J4EgmLmcP
         nAnNUbn4Tg9PNr+OoGe+1nqfg499kRagthlZpz3xdw3ojIRhgWKdh+5KsVyzv1vcYabj
         rsCA1Fpq4Jsifjft++mAeGnhamG2Yy0lN0KoBgoZYytJkN6s6xRi6IzB0xnNFCdAgQCM
         OJDd5AmfQo2PB2I73GWjgw/G+v6wrAY3EzrkUpUmlrn2YHB3Qir9k+y1l4RIrwjFb+Cr
         G6jWS2TNw9TmaI/Lsu+LYKdWwhbbVomMWaze+scIiDEylQdhow/a51QdLMHGgtDdH9iN
         mOtg==
X-Gm-Message-State: AO0yUKXCOzYOyQMyH0bUVOzUshCmtzIW6RNzDSOirjlIgS+paZg9Rqbm
        eGQ6EE9A6nLi+tiL6sZMcUmdKQ8zxEcDhg==
X-Google-Smtp-Source: AK7set/OgS0uPw6yjnZ8+WeGwAa05pV+fzH2wXZANRbFUxJwIlZ3+tq8drWJypCPaCBFMaZyc3mRiw==
X-Received: by 2002:aa7:972c:0:b0:625:ba5a:cadd with SMTP id k12-20020aa7972c000000b00625ba5acaddmr6175348pfg.21.1679046761537;
        Fri, 17 Mar 2023 02:52:41 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b00623f72df4e2sm1132370pfd.203.2023.03.17.02.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:52:41 -0700 (PDT)
Message-ID: <77b713f8-93bd-d0fa-d344-c8a4ec365c50@gmail.com>
Date:   Fri, 17 Mar 2023 17:52:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
 <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
 <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thanks for your advice.

On 2023/3/17 下午 05:13, Krzysztof Kozlowski wrote:
> On 17/03/2023 04:47, Jacky Huang wrote:
>>>> +
>>>> +  nuvoton,pll-mode:
>>>> +    description:
>>>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>>>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>>>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>>>> +      spectrum mode.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>> +    maxItems: 5
>>>> +    items:
>>>> +      minimum: 0
>>>> +      maximum: 2
>>> Why exactly this is suitable for DT?
>> I will use strings instead.
> I have doubts why PLL mode is a property of DT. Is this a board-specific
> property?

CA-PLL has mode 0 only.
DDRPLL, APLL, EPLL, and VPLL have the same PLL design that supports
integer mode, fractional mode, and spread spctrum mode. The PLL mode
is controlled by clock controller register. I think it's not board-specific.

>>>> +
>>>> +  nuvoton,sys:
>>>> +    description:
>>>> +      Phandle to the system management controller.
>>>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>>> Drop quotes.
>>>
>>> You need here constraints, look for existing examples.
>>>
>> I would like to modify this as:
>>
>>
>>     nuvoton,sys:
>>       description:
>>         Use to unlock and lock some clock controller registers. The lock
>>         control register is in system controller.
>>       $ref: /schemas/types.yaml#/definitions/phandle-array
>>       items:
>>         - items:
>>             - description: phandle to the system controller.
> In such case you do not have array. Just make it phandle and drop the items.
>

Thank you.
So, I will rewrite it as

   nuvoton,sys:
     description:
       Use to unlock and lock some clock controller registers. The lock
       control register is in system controller.
     $ref: /schemas/types.yaml#/definitions/phandle


>
> Best regards,
> Krzysztof
>

Best regards,

Jacky Huang

