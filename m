Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAAC6C2A70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCUGda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCUGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:33:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6F3B22B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:33:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o12so55597058edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679380380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HtQTr70p9g0PFqB21eWyfcsMG//fwSOn6c9K2QaLZg=;
        b=U0naptLlEpIIIPIujtsOPbCXgtUTGWKYTvhXhVRe0+VrDYAC1jzdgU8unYp+1fWM+a
         K4s9mQWcd9Fn1xPdQhA70P6yAMxmkXr0MKWS/Aeq6WaKV4Xd0zWw+6FaZMyDHg2IjdgI
         xvin3/erA8RN5zf2AGuo20nWq7ptInWL+iZC1Q5WBsSFzunxx8rhuySAhR5YoXqBZ0+q
         xiWd4wr9EGF7jEJRyzJp5ziCZNdy94gtKLqGjvzamsH4wIJFQlZ3DxYWuKrmYz8cGCjp
         Kht/hVbxz/6z0EpfI+bDtXVah7uiYbSF7kNK8IFD6EtVE2vZU05bF6x9RkVkLZISNlFr
         Xy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HtQTr70p9g0PFqB21eWyfcsMG//fwSOn6c9K2QaLZg=;
        b=Q8geUUe5xjfPOjXBVFRWBb2nML3x+kX27EH4aXivCbsUAn3nZgGV0OAMzWzJj8XhJR
         SKcs0ZDN+OsRHDUTfe3KOhweMHuzmaKIOhvTbp6ky2AhvewmEcbgA8ZAe6LOuJr4il6I
         3p5tR59WpTY8cCa8o5/MJNr4d9V8w6lGLppyc1L0zBYWs+mr8LhBAJ6z07NQuv0KE5we
         jY0KGiF9kvAxIfBAAijEJXsgmuePNgSm1pvEMKa88njluZA7gXoKovSbtci+dgSjRWPq
         glg7k+LB9zcJ/qsKnc6ePMg247lQ1gctzjTpd4vkkxFcYz1FO9PPBj0or4Rp0jxl4fB0
         wKww==
X-Gm-Message-State: AO0yUKUs65LzxD+Yzq/Rm884+UcO3H8n9/NMEeaZmpRYsq9H99tnDAkX
        eJh13NBKYzRJXj7VXThU191TVw==
X-Google-Smtp-Source: AK7set+X26OM3FXuIWXm2jm5XGPMTjCpHNvsswvRWpweqJQXypouCjDAycl742Es0v6RCKzFZmHJAw==
X-Received: by 2002:a17:906:86cd:b0:878:545b:e540 with SMTP id j13-20020a17090686cd00b00878545be540mr1633577ejy.51.1679380379982;
        Mon, 20 Mar 2023 23:32:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id a11-20020a17090680cb00b00930d22474dbsm5358277ejx.97.2023.03.20.23.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:32:59 -0700 (PDT)
Message-ID: <39ba681e-5bab-cffc-edf7-4bf86387987c@linaro.org>
Date:   Tue, 21 Mar 2023 07:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 05:34, Sergio Paracuellos wrote:
> On Mon, Mar 20, 2023 at 7:15 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/03/2023 19:09, Arınç ÜNAL wrote:
>>>>> Would mediatek,mtmips-clock.yaml make sense?
>>>>
>>>> More, except:
>>>> 1. This is not clock, but sysc.
>>>
>>> Sergio, beware.
>>
>> I meant, that's what I understood from what Sergio said. :)
> 
> Yes, you understood properly. I will use 'sysc' instead.
> 
>>
>>>
>>>> 2. mips sounds redundant. Do you have rt2xxx and mt7xxx chips which are ARM?
>>>
>>> All of the SoCs, RTXXXX, MT7620, MT7621, MT7628, MT7688 are MIPS. So I
>>> decided to call this platform MTMIPS as I've seen MediaTek use this on
>>> other projects like U-Boot. This is what I did on my pinctrl patch
>>> series as well.
>>
>> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which are
>> ARM, so mediatek,mtmips-sysc would work.
> 
> I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles will
> start with ralink. There are already some existent compatibles for
> mt762x already having ralink as prefix, so to be coherent ralink
> should be maintained as prefix.

The compatibles I mentioned start already with mediatek, so why do you
want to introduce incorrect vendor name for these?

Best regards,
Krzysztof

