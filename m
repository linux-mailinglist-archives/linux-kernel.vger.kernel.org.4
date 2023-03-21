Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584DA6C2C51
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCUI2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjCUI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:27:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6339BB4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:27:46 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so56459747edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679387264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TEoac3zeVJgrljfVa3qI82OfUIQHCkP0Xt4a5FiT+o=;
        b=yoCa7/aGur2BAdLJ0k075LI38fAA5uW/39Bida5ARuhbJngZpq4KmgzY4307Ut8mcl
         5+KBSkPEzkhMAwVC2vJ0La0j1YcVqBeAsxgBRRLyNbnfUihAUfAwg9KJ2SKX/+mmcyBH
         hsxEZrPQyY8MUSaIW44hGOF//5Fz62bZsZINgIUp1HMH0rv86LKAwuVYsB7oanw7OZe7
         EB2/+hQ49iUSD89pX8kSyNdsN/GdaAIRJQ9+i2uojH8Mpy6qRk4E5k8knP27e/ETahjy
         4EcIE96IsWZWZWSWZnCPCz0rTrt4u0mEZOEu7sqJoAWDrYti8/2rKmXD4z1+SoRCjYzh
         Mf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679387264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TEoac3zeVJgrljfVa3qI82OfUIQHCkP0Xt4a5FiT+o=;
        b=5/HkR5cGzcfGMmET/xl/wVikX5VsH4PTNOe8jtw5yRCVht1Zm2B0zSygx78p8BQv0/
         02NB3suvEM463PZKBT275pLlSRlZO6DnBl/kacOd9Ng6pCF2R83qpZqBPTCHiuxa8yla
         JOXyO5hA0RXUOzhLFim1QqTmvtQAvyPCedBhNmhk2xybnAucuS0k6H3/4QNR2BxQbc6w
         EyFESZf5F5uvuMfTqgOTLbRVfRsgk5PvMlGIH6zMZXa1PrcyeM4GaVYxmxyqwIUajdvj
         mlm19zlMRhTTDxHM0l28dMXX+cseHUupg/hqXJndKr5mKfzvKkDLcjzlikPCkpKrUOBE
         k15Q==
X-Gm-Message-State: AO0yUKUaH7UutUtwm7/6pkqv94kk6UOJqNQJkvx0FgEOnNGleQGA/sGM
        rWHv3f+9JNT6n7KaMPgRVzYFcw==
X-Google-Smtp-Source: AK7set/otTGERTl499ZirD8V+i4JpJed1Ipr6PSjOnjMebniqJYVuGKY9sgR9QOB04aOlA+Bn+URmg==
X-Received: by 2002:aa7:c858:0:b0:4fe:9bb7:73a2 with SMTP id g24-20020aa7c858000000b004fe9bb773a2mr2092978edt.38.1679387264161;
        Tue, 21 Mar 2023 01:27:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b004fa268da13esm5985814edi.56.2023.03.21.01.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:27:43 -0700 (PDT)
Message-ID: <82f517b5-6697-3379-8d71-163b0d17735d@linaro.org>
Date:   Tue, 21 Mar 2023 09:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
 <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org>
 <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
 <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
 <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
 <132de602-6467-536c-c66d-657f22a59bd5@arinc9.com>
 <40e3acac-b58a-7af8-b025-3678f84434da@linaro.org>
 <CAMhs-H9AWXvtbg=qz06HN3piUO0E5YF3RmrdRLC7qH2n6KjrSw@mail.gmail.com>
 <d598f5f8-f998-2a31-bb21-97e641793dda@linaro.org>
 <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
 <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
 <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <543ad00d-4171-ed02-0d31-676c6b003e54@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 09:24, Arınç ÜNAL wrote:
>>>
>>> If we take the calling new things mediatek route, we will never get to
>>> the bottom of fixing the naming inconsistency.
>>
>> All new things, so new SoCs, should be called mediatek, because there is
>> no ralink and mediatek is already used for them. So why some new
>> Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?
>>
>> You can do nothing (and no actual need) about existing inconsistency...
> 
> I couldn't change ralink -> mediatek because company acquisitions don't 
> grant the change. I don't see any reason to prevent changing mediatek -> 
> ralink without breaking the ABI on the existing schemas.

You cannot change mediatek->ralink without breaking the ABI for the same
reasons.

Best regards,
Krzysztof

