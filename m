Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE66815F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbjA3QHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjA3QHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:07:06 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC031BAEC;
        Mon, 30 Jan 2023 08:07:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so2975802wms.1;
        Mon, 30 Jan 2023 08:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcsOz5l4A5Qt9G01n1NrnH84MH1IPjpME7/fhI2iF0g=;
        b=eSYigaYKAbXI+/QTBx97k8BcDabnYfa4okz2cD3wMfgS1LwSZlwoIJXQQga0Yq6Tze
         pD6ECEV0TbsEkuVqQdBvsFlaM4maHbPpPRAJCU7/6FoczqqVNmLzVOuTmDMHYcNWP7zE
         93wAqq0h0BiRamVPbOVAUyTn6fOr1nu09Ym3FnEcI0wAVTHbPeQOj9i0vMRsLOlsQkup
         oBuy5KjMp6GferCoa4LIfB6hAKRk+ygm33FOGIcvCbkiA0MM8qVicG6B4tctta7QJWFk
         9iJ2gfoMRjmHpTPVtdMe+RHbqJAA9nCUx47EzWa443vmNt/JVLx7g4Weot6oxrc5XCSn
         yGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcsOz5l4A5Qt9G01n1NrnH84MH1IPjpME7/fhI2iF0g=;
        b=V9oEqMeIxIbX3MS2xyhHMxZpJxrwYuKyV+N8UjdVXzNs26Dg0aGidgm9F7psgjFb8c
         eYq3AJCkqSF8LMSBy523ohnaISl5o2WuqIb+j5r8dimzVzDiLj4kdNOlZusO6qG29//B
         JNBNWpMPkPTLx6Di6VLoXSKrHkEnxQYexqIG61D7mh9Fr9iWrjuirHKXmxMDbHMYgxf2
         Hf9dFPqo/3/fWqtwDiZPAqSInJYxp7QYZ6hbG1jIYVDVc1GTwEb2zxTHYR9ySmB8VHD8
         /NPIi1nMaGMhYXK2o+8zxBclSYPuCFRE0r5+TY+k395saOS1z37CFdnUOQMBroNNb8hH
         31HQ==
X-Gm-Message-State: AFqh2ko23HGr6psWkNpTeiWuIoyHfpDYnfO+PahFX8ZBrg97UoJAAuS9
        iQHT8d/6JA/hhxvvV5PBsF4=
X-Google-Smtp-Source: AMrXdXu9HKhEJ2RNPfqy3AnZQ9le/ijXLWlcWwESfIh9wkAl33WqP2J5IwADNa8ByLsmxgSIrJ1SOQ==
X-Received: by 2002:a05:600c:1c2a:b0:3cf:d0b1:8aa1 with SMTP id j42-20020a05600c1c2a00b003cfd0b18aa1mr48413698wms.0.1675094823720;
        Mon, 30 Jan 2023 08:07:03 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05600c1e0600b003db00747fdesm16752584wmb.15.2023.01.30.08.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:07:03 -0800 (PST)
Message-ID: <736e2cc3-4c30-56eb-929f-145437044ade@gmail.com>
Date:   Mon, 30 Jan 2023 17:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
 <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
 <CAGuA+opQboxH8qoNv4GG+raX=ZZAyRVLC9VLjVCzbT_cUQWWTA@mail.gmail.com>
 <b4bec164-5986-718e-b9cc-290dfc995edb@gmail.com>
 <CAGuA+ooSK-rzeqbFoTX3Bnnp_TH=0Uiu7Nxs_1YiTiKK4w5qtw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGuA+ooSK-rzeqbFoTX3Bnnp_TH=0Uiu7Nxs_1YiTiKK4w5qtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2023 13:19, Balsam CHIHI wrote:
> Hi Matthias,
> 
> On Mon, Jan 30, 2023 at 12:18 PM Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>>
>>
>>
>> On 30/01/2023 11:40, Balsam CHIHI wrote:
>>> Hi Krzysztof,
>>>
>>> Thank you for the feedback.
>>>
>>> On Sat, Jan 28, 2023 at 11:48 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 26/01/2023 17:10, bchihi@baylibre.com wrote:
>>>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>>>
>>>>> Add LVTS thermal controllers dt-binding definition for mt8195.
>>>>
>>>> Subject: drop second/last, redundant "dt-binding definition". The
>>>> "dt-bindings" prefix is already stating that these are bindings.
>>>
>>> fixed.
>>> The patch title has been fixed as you suggested :
>>> "dt-bindings: thermal: mediatek: Add LVTS thermal controllers"
>>>
>>>>
>>>> Plus two comments at the end.
>>>>
>>>>>
>>>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>>>> ---
>>>>> Changelog:
>>>>>     v12:
>>>>>        - Fixed subject prefix
>>>>>        - Fixed licences GPL-2.0+ to GPL-2.0
>>>>>        - Added dual licenses
>>>>
>>>>
>>>>> +    };
>>>>> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
>>>>> new file mode 100644
>>>>> index 000000000000..902d5b1e4f43
>>>>> --- /dev/null
>>>>> +++ b/include/dt-bindings/thermal/mediatek-lvts.h
>>>>
>>>> Same filename as bindings.
>>>
>>> fixed.
>>> rename :
>>> include/dt-bindings/thermal/mediatek-lvts.h =>
>>> include/dt-bindings/thermal/mediatek-lvts-thermal.h
>>>
>>
>> I think it should be
>> include/dt-bindings/thermal/mediatek,lvts-thermal.yaml
> 
> OK,
> I will change it like that.
> (".h" and not ".yaml" I believe (just to be sure).).
> 

Yes sure, .h. Sorry for the confusion.

Regards,
Matthias

>>
>> Regards,
>> Matthias
>>
>>>>
>>>>> @@ -0,0 +1,19 @@
>>>>> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
>>>>
>>>> Although this is correct, any reason why not using exactly the same
>>>> license as bindings?
>>>
>>> fixed.
>>> both files are now using the same license :
>>> "SPDX-License-Identifier: (GPL-2.0 or MIT)"
>>>
>>>>
>>>>> +/*
>>>>> + * Copyright (c) 2023 MediaTek Inc.
>>>>> + * Author: Balsam CHIHI <bchihi@baylibre.com>
>>>>> + */
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> I'll send the changes soon.
>>>
>>> Best regards,
>>> Balsam
> 
> Best regards,
> Balsam
