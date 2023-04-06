Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7526D96E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjDFMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDFMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:16:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AD1985;
        Thu,  6 Apr 2023 05:16:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y7so8065331ljp.2;
        Thu, 06 Apr 2023 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680783389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IfIB4CgIdoIIyXodu7HUJudyaeFt7PNR1j2STXboWE=;
        b=PjE3VN5vfjmZFoDCyQEwJuXQ0gv0EVAHbkR592M7oJgfk5tP52f9uALKeZFQtsQzlv
         Ek2FBKrbZ1v50Ohaedqkb+z+8UzctChMReeSUsjiLrivLemhhedyiaOTnI3IKMdt5x9v
         7RUaJ7jcuOJSEzCFpTpEupGnsVUJgzYjx2GZc8e1+5OxUP0PE7jgK5NCLY/1XrT20KAS
         hXEqlxDQgj3E74u0N1hWMtdKCVh9qRT/1rBlsNJQul6K5Fg8985eVb1j/j1h0UHiK3F0
         oz9OvYu7+QxbrJJsKqF98A2j6i3CxQWnnynBr/vTfai+HcUCdqklCNRdaItoAge999Vd
         JD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680783389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IfIB4CgIdoIIyXodu7HUJudyaeFt7PNR1j2STXboWE=;
        b=ERQELMBURc5cusBqrHLEb3B2+om0rxVWy2iC+MhTHtAN8u1ptMqbfCyclFlzXPoJSa
         2EkUujN5sN6MntSznp8BRxk0hIhybq3qba1RGBHfrumfiaH4dF29bgEGQ2iRgHD1Lkk2
         kR//Y2KkzGK1Nhzx9wg3S+WCS2yLfGK3w5XV2y2APokPZZrFJ1VXzRdgbkxncdNrtL+9
         StCJTdJwJTlNQsCd8tKRGuOmeWjf03ogydOBC1aKm92Yxy0vBKvoBvft5n4QxD0U0QiM
         CDD3p3YQlgl3RPzVU5EA/U4o4U8jMTdZmiG30w7EHEAg9gn/FhntSGMV4hyOOCgqXhrk
         LOTg==
X-Gm-Message-State: AAQBX9d+IUFDwlE5L/eN27vX3N4WXiY3emsXZAygt0zEUmZDxKolDsOU
        HvD1T1lFi/KIYKzCefcR66Q=
X-Google-Smtp-Source: AKy350a3IBC4RwraPM9UF5oE/Awqo6H8CELQGyhpe0qn8vIXsHJaGDKlfV6QnFSy4SWBCiaGx6prGw==
X-Received: by 2002:a2e:86da:0:b0:2a6:16b5:c65b with SMTP id n26-20020a2e86da000000b002a616b5c65bmr3093359ljj.46.1680783388982;
        Thu, 06 Apr 2023 05:16:28 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y6-20020a2e9786000000b00295a8d1ecc7sm263634lji.18.2023.04.06.05.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:16:28 -0700 (PDT)
Message-ID: <fa046d58-a7ee-c205-7162-a1c2914b58df@gmail.com>
Date:   Thu, 6 Apr 2023 15:16:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Content-Language: en-US, en-GB
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
References: <20230406060825.103187-1-andreas@kemnade.info>
 <20230406060825.103187-2-andreas@kemnade.info>
 <f73050b7-3f86-0dcd-5e43-d8a9258afcae@gmail.com>
 <20230406133357.45e48bd3@aktux>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230406133357.45e48bd3@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 14:33, Andreas Kemnade wrote:
> Hi Matti,
> 
> On Thu, 6 Apr 2023 11:32:42 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Andreas,
>>
>> Thanks for the patch! Adding new support for devices is Much Appreciated!
>>
>> On 4/6/23 09:08, Andreas Kemnade wrote:
>>> Document ROHM BD2606MVV LED driver devicetree bindings.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>    .../bindings/leds/rohm,bd2606mvv.yaml         | 76 +++++++++++++++++++
>>>    1 file changed, 76 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
>>> new file mode 100644
>>> index 0000000000000..6d4ddd8d31162
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
>>> @@ -0,0 +1,76 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/leds/rohm,bd2606mvv.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: BD2606MVV LED controller
>>> +
>>> +maintainers:
>>> +  - Andreas Kemnade <andreas@kemnade.info>
>>> +
>>> +description:
>>> +  The BD2606 MVV is a programmable LED controller connected via I2C that can
>>> +  drive 6 separate lines. Each of them can be individually switched on and off
>>> +  but the brightness setting is shared between two of them.
>>
>> Maybe add a link to data-sheet?
>> https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
>>
> Maybe also (because it has the register description):
> https://fscdn.rohm.com/en/products/databook/applinote/ic/power/led_driver/bd2606mvv_tsb_001_ug-e.pdf

I think both documents do contain the register description. Well, the 
eval board user-guide seems to contain the IC information as well as the 
eval board information so I am fine with either of these.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

