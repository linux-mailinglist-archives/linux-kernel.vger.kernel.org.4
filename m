Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BBC73991A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFVIOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFVINv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:13:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6691BE1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:13:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f90b8acefdso44922595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687421625; x=1690013625;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xBt2ekqJ0sia2Hb53NunP8E+iWHCyIXmjcNKrTqEDs0=;
        b=vXOpyrXgdc0xTE+YD7sbBTCml+Y7FYfUb5kKe6yGOZ+9fCW1pfzc0uJ4t797yaiUz0
         2EcVUfIXaSSfZnGHph1InDSAXeKyh6mCvSYUevjm0E4ZM0Z2gZ9v1jHrveof4pcebirh
         tzxX1HPwwNK8uPLVSOeVwTvLKWVLsQiEo/1EANbeC7kDci655dsHmDye99J4WFL/Rtyo
         WPDbg2J28IKCkFDzf2J2GUs6c3+YXrOJ8nrRM+6x0h8Nn2KZVILHNu56t5O8Ik9ZtqjU
         EMe+mChVF9ddkvlMVwdJIgyFEDPo9kh9P0dLSAUCkTZJJ8uqbCCG/dzNCMihAjgeKh+J
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421625; x=1690013625;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBt2ekqJ0sia2Hb53NunP8E+iWHCyIXmjcNKrTqEDs0=;
        b=hjgjnJQTbW+e06LNXju28pZvhGBWr4qS/k51uFxt8DFta2JoFSXyW+1OeKFogBoaGH
         zxNRpgLtyjNSlsdTEY20KfYq+DFx/NItg9KJPsw0Z5JQq5OAHqPevZa6l50f7ZGFctZE
         MCymrqzk2sTxoHcyEDQl9vyL4HYOawYEeQ9t4rDyaWhiilr6N0D3WNXHzNEDBtcrgRsE
         pwRbEQud6zh+CQc4CbCRJCj5dTPR1HniqJ31hIcQkcho20yHclk1mU682V6+SEJf/8eG
         WkaZH7u4x4FvYRX7ecU3gdhDJnBRcojoTG3AZXNSIWxtUktKNTqdyXhfWRdYyjDt48LX
         UFgg==
X-Gm-Message-State: AC+VfDy37d7zeuYi2s1vSnwAs2d0JXuY6cb8oEsoZwpfJiEtKdEdbdv8
        2g7oplHJJSraWy26G176xHqaSQ==
X-Google-Smtp-Source: ACHHUZ475XXZXU/6F2syTDxBr5VRodl+0PPu8YxpHRhgZXoJQaySn7JsPy29tk9ZpN3gB14L12m/0A==
X-Received: by 2002:a05:600c:2945:b0:3f9:b31d:5689 with SMTP id n5-20020a05600c294500b003f9b31d5689mr6828378wmd.36.1687421625062;
        Thu, 22 Jun 2023 01:13:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f692:a800:4794:385? ([2a01:e0a:982:cbb0:f692:a800:4794:385])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c285300b003f605566610sm17944436wmb.13.2023.06.22.01.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:13:44 -0700 (PDT)
Message-ID: <2fe41e89-9a26-e7ba-6ef6-2c9262bda43d@linaro.org>
Date:   Thu, 22 Jun 2023 10:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Content-Language: en-US
To:     tanure@linux.com, Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230621133215.109254-1-tanure@linux.com>
 <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
 <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
 <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org>
 <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
 <20230622-hardhat-elitism-26f0d0df204f@wendy>
 <CAJX_Q+3+bdXd-NrsQymXerpWZuj3zb8CKHcZRNM_iLSZcp2Mfg@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAJX_Q+3+bdXd-NrsQymXerpWZuj3zb8CKHcZRNM_iLSZcp2Mfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2023 09:36, Lucas Tanure wrote:
> On Thu, Jun 22, 2023 at 8:12 AM Conor Dooley <conor.dooley@microchip.com> wrote:
>>
>> On Thu, Jun 22, 2023 at 07:43:31AM +0100, Lucas Tanure wrote:
>>> On Thu, Jun 22, 2023 at 7:05 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>> On 22/06/2023 07:32, Lucas Tanure wrote:
>>>>> On Wed, Jun 21, 2023 at 7:12 PM Conor Dooley <conor@kernel.org> wrote:
>>>>>> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
>>>>>>> On 21/06/2023 15:32, Lucas Tanure wrote:
>>>>>>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
>>>>>>>> There is no need for an extra compatible line in the driver, but
>>>>>>>> add T7 compatible line for documentation.
>>>>>>>>
>>>>>>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>>>>>>>> ---
>>>>>>>>   .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>>>>>>>>   1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>>>>>> index 01ec45b3b406..860ab58d87b0 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>>>>>>>> @@ -33,6 +33,7 @@ properties:
>>>>>>>>                 - amlogic,meson8b-uart
>>>>>>>>                 - amlogic,meson-gx-uart
>>>>>>>>                 - amlogic,meson-s4-uart
>>>>>>>> +              - amlogic,meson-t7-uart
>>>>>>>>             - const: amlogic,meson-ao-uart
>>>>>>>>         - description: Always-on power domain UART controller on G12A SoCs
>>>>>>>>           items:
>>>>>>>> @@ -46,6 +47,7 @@ properties:
>>>>>>>>             - amlogic,meson8b-uart
>>>>>>>>             - amlogic,meson-gx-uart
>>>>>>>>             - amlogic,meson-s4-uart
>>>>>>>> +          - amlogic,meson-t7-uart
>>>>>>>
>>>>>>> It does not look like you tested the DTS against bindings. Please run
>>>>>>> `make dtbs_check` (see
>>>>>>> Documentation/devicetree/bindings/writing-schema.rst or
>>>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>>>>>> for instructions).
>>>>>>
>>>>>> Check back on the previous version, I should've posted an untested
>>>>>> version of what you need to add.
>>>>> I saw that, but adding a S4 doesn't make sense to me. And you didn't
>>>>> show the entire change, so I can't understand what you want there.
>>>>
>>>> For sure you need something which does not trigger errors. If you claim
>>>> adding S4 as fallback does not make sense, then why did you use it?
>>>> Sending a code which is clearly incorrect does not make sense.
>>>>
>>> Sorry, I think we are talking about different things. It does not make
>>> sense to me to add an S4 line in the documentation when it is already
>>> there. So I could not understand or make sense of the patch Conor sent
>>> in reply to my V2.
>>
>> That is just how it works. You need to spell out exactly which
>> combinations are permitted. The current entry for s4 says that s4 is
>> only permitted in isolation.
>> Since you are adding "amlogic,meson-t7-uart", "amlogic,meson-s4-uart"
>> you need to explicitly allow that combination. You'll notice if you look
>> at the file that the gx uart appears more than once.
>>
>> Given the g12a was the most recently added compatible, it might make
>> sense to follow the pattern that it had set, given the thing your
>> original patch copied the match data from was the g12a. That change to
>> the dt-binding would look like:
>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> index 01ec45b3b406..eae11e87b88a 100644
>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
>> @@ -50,6 +50,13 @@ properties:
>>           items:
>>             - const: amlogic,meson-g12a-uart
>>             - const: amlogic,meson-gx-uart
>> +      - description:
>> +          Everything-Else power domain UART controller on G12A compatible SoCs
>> +        items:
>> +          - enum:
>> +              - amlogic,meson-t7-uart
>> +          - const: amlogic,meson-g12a-uart
>> +          - const: amlogic,meson-gx-uart
>>
>>     reg:
>>       maxItems: 1
>>
>> /I/ don't really care whether you do that, or do the s4 version of it,
>> but following the most recent pattern might make more sense. When I
>> suggested s4, it was because I only looked at the driver patch rather
>> than the code itself.
>>
>>> Krzysztof, I will check again with dtbs_check and re-send.
>>
>> Cheers,
>> Conor.
> I am struggling to understand this. Everything I try fails the check.

I just applied Conor's change on top of v6.4-rc1 and ran:
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml

and the check was successful.

Neil


