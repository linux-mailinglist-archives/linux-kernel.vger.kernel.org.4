Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D96695F67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjBNJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjBNJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:39:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365A9421B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:39:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so11099261wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THygiRuxs8VFRu/0SbSjNJKLxf0jtWVPE2Kde3hH/xc=;
        b=IOFRV/edrvwF9c4q81Z4wz4bc1wtIFjlz6Mn0wLQgGk3ErQN0GVVkR/H3EihKO6Okz
         IhP2Q/ubloAkgJCcabD7tnopil56y6JpNh6VbLm1KVVzTj8g6JE7NZ5X5BkapMdCrVio
         NMQS0ZCHyUbnHtPcNVOsybnCV4cMS5rLkbhCCP2tmqb/145duSHPSD+/73UVodcxVChw
         ujTH52MtR8YtCiGXHWCRtDxA0SN8TmGf6thzVdrWZ4aZOMgNMefl7glfemstx2brSQlz
         lDnByTV8InzchXfW43uCElzhmRuqT+dEwvbNSS7fuJMh2Nlk52q6N6uUOB7PITIz4Agq
         c3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THygiRuxs8VFRu/0SbSjNJKLxf0jtWVPE2Kde3hH/xc=;
        b=Sz3hB8GGNWLA5KVD8BszneCVAMnwRcLtjNdcc27BP7+ucwPYVKUmLNkKQ53d/ck+3g
         RvC13o/lHkClDrMj8ct3y/9obzW+yR8pCACMjGHNx6PVUhMVIPjiGw6bmzEpvvfkVkkK
         uladSTYuyUFz/ubc8TB4HnqvwSFJUWr4fONYCYKAH4k7TIyWfWZtUFVWDprcaZTUw938
         SgoaxQwMzO5+oO+bHBo7KZrh/cloNye8GHlQNZF/daqYC6zZKoDJndZYf8bFAfm2pFa1
         ziXAeCs0eGXi0EzjB5O7YHiYSS39TQZI1v55g5RSF0AFqQofU1YTolYqAa5BrQjQ6UBG
         pFCg==
X-Gm-Message-State: AO0yUKVErgn7cmbKG1jhDBiVoSGRO1j4Dj2uWBxfH0R0FdRN47urNPUZ
        DmswFszfZhUSY8MSdHSSTKXMHg==
X-Google-Smtp-Source: AK7set/+iKTim4NOP4D/hREumYohxPZoT4caqB5lh3sHrMC+9HMX/g1IGZQqdbiqnhwVcj4VqC+2GA==
X-Received: by 2002:a05:600c:44c8:b0:3df:30c9:4865 with SMTP id f8-20020a05600c44c800b003df30c94865mr1570277wmo.26.1676367587820;
        Tue, 14 Feb 2023 01:39:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003dc0cb5e3f1sm15557691wmp.46.2023.02.14.01.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:39:47 -0800 (PST)
Message-ID: <af7fb166-64e3-6fcd-c270-6dd53bbe96c0@linaro.org>
Date:   Tue, 14 Feb 2023 10:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/17] dt-bindings: power: apple,pmgr-pwrstate: Add t8112
 compatible
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
 <3287867a-456c-ddc3-adbf-90001950c926@linaro.org>
 <0a33fa04-039f-9a7e-f2a3-2a1a6abc98d4@marcan.st>
 <5ff55f1c-8f02-abec-2320-c2e0b7db8904@linaro.org>
 <391ae107-8c10-b14e-c1ad-0fac74951432@marcan.st>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <391ae107-8c10-b14e-c1ad-0fac74951432@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 09:43, Hector Martin wrote:
> On 14/02/2023 16.50, Krzysztof Kozlowski wrote:
>> On 14/02/2023 03:24, Hector Martin wrote:
>>> On 13/02/2023 20.09, Krzysztof Kozlowski wrote:
>>>> On 12/02/2023 16:41, Janne Grunau wrote:
>>>>> From: Hector Martin <marcan@marcan.st>
>>>>>
>>>>> Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.
>>>>>
>>>>> This goes after t8103. The sort order logic here is having SoC numeric
>>>>> code families in release order, and SoCs within each family in release
>>>>> order:
>>>>>
>>>>> - t8xxx (Apple HxxP/G series, "phone"/"tablet" chips)
>>>>>   - t8103 (Apple H13G/M1)
>>>>>   - t8112 (Apple H14G/M2)
>>>>> - t6xxx (Apple HxxJ series, "desktop" chips)
>>>>>   - t6000 (Apple H13J(S)/M1 Pro)
>>>>>   - t6001 (Apple H13J(C)/M1 Max)
>>>>>   - t6002 (Apple H13J(D)/M1 Ultra)
>>>>>
>>>>> Note that t600[0-2] share the t6000 compatible where the hardware is
>>>>> 100% compatible, which is usually the case in this highly related set
>>>>> of SoCs.
>>>>>
>>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>>>
>>>>
>>>> Missing SoB.
>>>>
>>>
>>> I'd rather get an r-b, since this is going back into my tree ;)
>>
>> Please follow Linux process which requires SoB chain.
> 
> A SoB is not an r-b. I do not upstream patches that are unreviewed. I
> wrote the patch. Someone needs to review it.
> 
> The extra SoB is redundant because this is going back into my tree, I
> wrote it, and I will be the committer when I apply it. It's a one-liner
> patch. I know what I wrote. Sure we could record Janne's SoB as a
> technicality, but it feels silly. What matters more is that the patch
> gets reviewed, not that on a patch series technicality it ended up being
> Janne who sent it to the list. I could just pull the patch from my own
> branch and then it didn't go through Janne so it doesn't need his SoB.
> But it does need someone's review (because I absolutely refuse to merge
> my own patches without review, although not every maintainer has that
> policy unfortunately, which means there's lots of unreviewed code in the
> kernel).
> 
> Please. Let's cut down on the silliness. Please. We're trying to get
> stuff done here. I'm tired of having to explain every little thing over
> and over and over again. I really am.

Listen, I have no clue whether Janne changed the patch or not. She might
have rebased it or not. The chain expects that anyone touching the patch
must leave SoB. I am not providing my reviewes for patches breaking the
process we have clearly described. I also do not see any problem in
following the process we have - adding SoB whenever you play with a
patch and send it. Entire discussion is silly indeed, instead of just
following the process.

Best regards,
Krzysztof

