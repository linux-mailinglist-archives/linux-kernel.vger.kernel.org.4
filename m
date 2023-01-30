Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45148680BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjA3LTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjA3LS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:18:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AEF18B1D;
        Mon, 30 Jan 2023 03:18:55 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o18so1230519wrj.3;
        Mon, 30 Jan 2023 03:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkp4rkyxPgpsD/uKlrIIe9RaCjDd2iGDYMH6lIDGA08=;
        b=abpt2ulPIdGPmIvepxo6Cv91sShFhDssmHfiPZpMNayWwndjSU2xssnbeqLQ452ZYs
         efyDdYOvNXRwFbl2ze3wN5fs9GMKGUAn10MbYcDqP6gBOocekGw6Dja4/4SELwP8OzEG
         3DOPhP0UBdPFQt576Ie3Xo/DmfN6DSDx4Q7dcW00yCdyNyhXziqGbhpI5qB4U9cjMHah
         hSiBoWyMeA7ySx7f/udXhuo1xdGQXmZvYVZ8G8hmUWTaz14qHUQxNg2ywYHlfIOxDfh5
         HEywEtK7v5HbdXj9HPlLmMlp1yxFNrBCEJEYUaS9vCKqAKecmDDKpDwQhLq56pm5raFh
         a18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkp4rkyxPgpsD/uKlrIIe9RaCjDd2iGDYMH6lIDGA08=;
        b=uPLJpbTftC/YXIRWRupnAoCVW32ZzzMFSfFc8vyc09FyyGDK3nBD+gs/nsyMYIdMqC
         Yw7LOXbm2rzWlgrDwyiUWIIlj8WtgUZwK1hQ9nmFPrxqmvQqgVuBNTRsvZ18yCJ89sCy
         km6DSNiREv0szMHYGAF0S+uGsu261a/IpMbRv4epXazN+WKWgoJMVh+y18cWwD+TRLRA
         AhxmhqtsNN9HjIrgFPkHC1CO6J3Xe3IBvK/G26+kkK+W+XGWuihG3oAS6LGfWdsIYGoC
         jEespcBWM8/OFTR//30usDiU4MyBQCEXPcuiEe2yhoXht7GrWgbkXA6zE2jeSdCrt08W
         SLSw==
X-Gm-Message-State: AO0yUKVLXIZqyXAp1TbkcLrYeKfYgOm2a+yuDkGLB1ifTcB3hA7XkW5P
        BK/wgygK1TUBCdRYWQWQJb0=
X-Google-Smtp-Source: AK7set8I9YflWW0cSwJMchVO/4uVYr4AsWm9Ei9TpWsGvGjSY92DMQt+BNMb+NGDgOcDPBrbwEUnug==
X-Received: by 2002:adf:a453:0:b0:2bf:ee61:7daf with SMTP id e19-20020adfa453000000b002bfee617dafmr2022150wra.10.1675077533640;
        Mon, 30 Jan 2023 03:18:53 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w10-20020adfcd0a000000b002bff7caa1c2sm364623wrm.0.2023.01.30.03.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:18:53 -0800 (PST)
Message-ID: <b4bec164-5986-718e-b9cc-290dfc995edb@gmail.com>
Date:   Mon, 30 Jan 2023 12:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
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
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGuA+opQboxH8qoNv4GG+raX=ZZAyRVLC9VLjVCzbT_cUQWWTA@mail.gmail.com>
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



On 30/01/2023 11:40, Balsam CHIHI wrote:
> Hi Krzysztof,
> 
> Thank you for the feedback.
> 
> On Sat, Jan 28, 2023 at 11:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 26/01/2023 17:10, bchihi@baylibre.com wrote:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> Add LVTS thermal controllers dt-binding definition for mt8195.
>>
>> Subject: drop second/last, redundant "dt-binding definition". The
>> "dt-bindings" prefix is already stating that these are bindings.
> 
> fixed.
> The patch title has been fixed as you suggested :
> "dt-bindings: thermal: mediatek: Add LVTS thermal controllers"
> 
>>
>> Plus two comments at the end.
>>
>>>
>>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>>> ---
>>> Changelog:
>>>    v12:
>>>       - Fixed subject prefix
>>>       - Fixed licences GPL-2.0+ to GPL-2.0
>>>       - Added dual licenses
>>
>>
>>> +    };
>>> diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
>>> new file mode 100644
>>> index 000000000000..902d5b1e4f43
>>> --- /dev/null
>>> +++ b/include/dt-bindings/thermal/mediatek-lvts.h
>>
>> Same filename as bindings.
> 
> fixed.
> rename :
> include/dt-bindings/thermal/mediatek-lvts.h =>
> include/dt-bindings/thermal/mediatek-lvts-thermal.h
> 

I think it should be
include/dt-bindings/thermal/mediatek,lvts-thermal.yaml

Regards,
Matthias

>>
>>> @@ -0,0 +1,19 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
>>
>> Although this is correct, any reason why not using exactly the same
>> license as bindings?
> 
> fixed.
> both files are now using the same license :
> "SPDX-License-Identifier: (GPL-2.0 or MIT)"
> 
>>
>>> +/*
>>> + * Copyright (c) 2023 MediaTek Inc.
>>> + * Author: Balsam CHIHI <bchihi@baylibre.com>
>>> + */
>>
>> Best regards,
>> Krzysztof
>>
> 
> I'll send the changes soon.
> 
> Best regards,
> Balsam
