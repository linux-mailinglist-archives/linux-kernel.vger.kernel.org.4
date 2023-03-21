Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C985D6C2BE1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCUIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUIEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:04:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080A3B867
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:04:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so56286355edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679385868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6kAibFtUmFQRuVkt3XyxH7xyFCW8XFyaXNZx8x1cuQ=;
        b=HG5ouOwSztWyCZxl76s5Quolbu30q6mLAxcu6SGpRSP14LBk69oEa0EEO0Ab2rKvEk
         zQgWel7OBNYZB8z6ozJV7H9a2NXXFQPtnFd2d3XpJRpX0OLWHvpVKXi6eQGfL5/ZYN8q
         camPhUVeWtUx6nbtBjLdeHBlfytWZ4Gf5xHvmXo3INfq9d4LsiC1sDvv+ZK1vaxtE9oF
         WSCYHpOVlu70n5F10jM3Jh/Od2/V+tvbxJjJFiUt1Q6ZEF2EoD3djskiHQpWcgTzSMpU
         nboV4Yd0+tnZ06ELFNe3xS0EMDkQ3xlrXy26wJF9eR+zvRHIERRKr5ljO4EQW97lExiG
         NvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679385868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6kAibFtUmFQRuVkt3XyxH7xyFCW8XFyaXNZx8x1cuQ=;
        b=nYi/OVJcP6qBXyGfs+HQKd0Ny5Exx3XV9APborzLjNm1Xjiv93ocIPWgQ+hvm1todE
         rO8STXbhnvRux/p4U9ldmKRmvDH8z/KbTtsB4tLgJm5p/TmG8XZJ6UXxLfBvObLTQlr1
         pxEOcHIH2mbBA5vC8kBeHnOMrwvK585mxcHaypTdUbsDzuhggGqP+5YtFKaBq06ytxF9
         i1wnx1qfTnFJgmlpdWaGZubNh0vLllKVK0XFQrrOkuC/MIv1CHHjx2HfoteDW0iuTsjy
         Cwn+wi97zu4UIaf/N07WbuskH41GxoTxcM+EyT6nDkuaO3VUHzzhgAIkl6sTLSVszNde
         ahFQ==
X-Gm-Message-State: AO0yUKVRHKzRglBMzvEX3yg0DBnRkkTpYRO+fxyTDzEwoWYQvWl+Q/QK
        n7HDw2WyKKnrBuORTju8QhD7GQ==
X-Google-Smtp-Source: AK7set8lwvGGzgiMVMHsy9OSuBQEMrKIN0ffIGRRRzlKyRPmOzc7GpCN0/I7GVJb4jCVeLD1qiD2Yw==
X-Received: by 2002:a17:906:8a62:b0:920:7827:302 with SMTP id hy2-20020a1709068a6200b0092078270302mr2618185ejc.18.1679385868234;
        Tue, 21 Mar 2023 01:04:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id p13-20020a1709066a8d00b00932ab7699ffsm4615372ejr.148.2023.03.21.01.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 01:04:27 -0700 (PDT)
Message-ID: <3d2b8a1a-99c9-f53e-4bb3-a8b938e2672f@linaro.org>
Date:   Tue, 21 Mar 2023 09:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <120663a9-aecf-4a43-d1fb-779cd52802c6@arinc9.com>
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

On 21/03/2023 08:39, Arınç ÜNAL wrote:
>>>
>>> arch/mips/ralink/mt7620.c:      rt_sysc_membase =
>>> plat_of_remap_node("ralink,mt7620a-sysc");
>>>
>>> That's the reason I also used prefix ralink for the rest.
>>>
>>> Does it make sense to you to maintain this one as ralink,mt7620a-sysc
>>> and add the following with mediatek prefix?
>>>
>>> mediatek,mt7620-sysc
>>> mediatek,mt7628-sysc
>>> mediatek,mt7688-sysc
>>>
>>> That would be weird IMHO.
>>
>> What exactly would be weird? Did you read the discussion about vendor
>> prefix from Arinc? mt7620 is not a Ralink product, so what would be
>> weird is to use "ralink" vendor prefix. This was never a Ralink. However
>> since there are compatibles using "ralink" for non-ralink devices, we
>> agreed not to change them.
>>
>> These though use at least in one place mediatek, so the above argument
>> does not apply. (and before you say "but they also use ralink and
>> mediatek", it does not matter - it is already inconsistent thus we can
>> choose whatever we want and ralink is not correct).
> 
> My argument was that your point being Ralink is now Mediatek, thus there 
> is no conflict and no issues with different vendor used. It's the next 
> best thing to be able to address the inconsistency, call everything of 
> the MTMIPS platform ralink on the compatible strings.

And how does it help consistency? The mt7620 is used also with mediatek
prefix and adding more variants of realtek does not make the
inconsistency smaller. It's still inconsistent.

> 
> If we take the calling new things mediatek route, we will never get to 
> the bottom of fixing the naming inconsistency.

All new things, so new SoCs, should be called mediatek, because there is
no ralink and mediatek is already used for them. So why some new
Mediatek SoCs are "mediatek" but some other also new SoCs are "ralink"?

You can do nothing (and no actual need) about existing inconsistency...


Best regards,
Krzysztof

