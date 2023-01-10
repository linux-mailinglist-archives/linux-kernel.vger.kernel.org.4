Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66364663B13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjAJIbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjAJIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:30:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B311C3B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:30:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d17so10897773wrs.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkB0focVoU0BhTktXEmIGinKbDdPanj0G9Gm/OHs6Wg=;
        b=dMh/7lEhPYevU/LR5Z/3QZoSihvfYtElLbNq1Fo4FGAQIkXb/XnG7Zhm6/JeuZWT+h
         Zm1Fi49ZYAY1FPoY/KFvS2h8Ba5ENBbl7D+u9BsmBQXzJct1+zaW3xbLNwpYDun49SmW
         IEnLMcUi+RP+wk9rr6lNAGKYTKZdxrZbr7Fl3wyhD03zNzw9WLdP8IcLI5GoSgQDwHbW
         /T5Uowzmqt4KKL9zjmxB4QLKoAjVc+5H9XJAjsXYyVTSr0mNEF6hn6+3ghj9+kPXJtTy
         8RuxbXGwchdgPFJAbe7nJ4CpSGJKMTlkaOV3Ckwo3WY4ltdhbUe/g3QKJwXsA8oyh/fN
         qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkB0focVoU0BhTktXEmIGinKbDdPanj0G9Gm/OHs6Wg=;
        b=CujFlv6L0Xwx+2uKADx2KFJameYnWN7P340i1qC8cJIWhFpkPSUBv0wc+b/gZlIGmu
         gZZsl7p5gkBK1otyM9NZXp7uCawABxLDfdfhOBc0uxcioTTyOALxiKTiS+wQflt5h1Kg
         3G+vq+m0sl7SHDucVoN6fmQpDnKnWTIr/WCJKlz42OMuHCHWVISRkJuUTTGgza3U+13K
         Qyiy9z7FVLxFQe6IRvQVxCIw2zRUqB7kdiHtn7kh0eYjld1xMe2zWI1bo0TnYIFlqcn7
         52qNP4KgV+uRbfyfKhzOX7oK+ct7Ve7e9c002XreDNOVzZVLuOOuTcyAMePx6lHdS7kD
         fwuw==
X-Gm-Message-State: AFqh2kr8NNbmG+AKmcwyZ2YJHXVr4p5DddLlHyHBkO0/pSLa9UJqfGDZ
        l7MnYS/OuQUiNX8CCBxxieu+2A==
X-Google-Smtp-Source: AMrXdXvLIy9HXN5YhV2Cez2g26l2zux8WreLFIc3W8iCiM6nwjy9EpCsfCEk1x7CsfFabjhY1tyQBw==
X-Received: by 2002:adf:e2d2:0:b0:242:4cf5:f385 with SMTP id d18-20020adfe2d2000000b002424cf5f385mr42382901wrj.34.1673339456389;
        Tue, 10 Jan 2023 00:30:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm3402102wrw.29.2023.01.10.00.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 00:30:55 -0800 (PST)
Message-ID: <3f8ae997-b35f-8fa9-73a4-6106d125161e@linaro.org>
Date:   Tue, 10 Jan 2023 09:30:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Content-Language: en-US
To:     Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20230105151740.29436-1-sinthu.raja@ti.com>
 <20230105151740.29436-2-sinthu.raja@ti.com>
 <977b5cce-2501-4d7a-fe24-437df88aee8f@linaro.org>
 <CAEd-yTR=zdg_pt=MzkzceGTY2SkV=16dyhXCtd4EU-KGzP_mAQ@mail.gmail.com>
 <ebb0a452-9ae6-780a-a6ca-d34d0ebbc520@linaro.org>
 <CAEd-yTRzxUGNM6u0SMnVNjM=xrsX9g1JUEYvaUhqa--KcgYfeQ@mail.gmail.com>
 <20230106134102.twg6qzyeh5ivhe46@recopy>
 <CAEd-yTTSC6oFMAA+kH-GwMejPY0S0q8=L43_Sw62nyLrQiAT8Q@mail.gmail.com>
 <CAEd-yTQEM42mJ80Vab8MQkFPiNwesyqTw5YktGCRuEeh_RqSyA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEd-yTQEM42mJ80Vab8MQkFPiNwesyqTw5YktGCRuEeh_RqSyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 08:58, Sinthu Raja M wrote:
> On Fri, Jan 6, 2023 at 7:33 PM Sinthu Raja M
> <sinthu.raja@mistralsolutions.com> wrote:
>>
>> On Fri, Jan 6, 2023 at 7:11 PM Nishanth Menon <nm@ti.com> wrote:
>>>
>>> On 18:47-20230106, Sinthu Raja M wrote:
>>>> On Fri, Jan 6, 2023 at 6:28 PM Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 06/01/2023 13:53, Sinthu Raja M wrote:
>>>>>> On Fri, Jan 6, 2023 at 6:19 PM Krzysztof Kozlowski
>>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>>
>>>>>>> On 05/01/2023 16:17, Sinthu Raja wrote:
>>>>>>>> From: Sinthu Raja <sinthu.raja@ti.com>
>>>>>>>>
>>>>>>>> AM68 Starter Kit is a low cost, small form factor board designed for
>>>>>>>> TI's AM68 SoC which is optimized to provide best in class performance
>>>>>>>> for industrial applications and add binding for the same.
>>>>>>>>
>>>>>>>> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
>>>>>>>
>>>>>>> What happened here?,
>>>>>> Krzysztof
>>>>>> Missed the merge window, so rebased to 6.2rc1 and reposted again.
>>>>>
>>>>> And what was here in v3?
>>>> Krzysztof,
>>>> Are you asking about this tag?
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> When you are re-posting OR updating the series, it is the patch sender's
>>> responsibility to pick up the acks. If you are explicitly not picking up
>>> reviews and acks, you should state in the diffstat why.
>>>
>>> Also see the b4 tricks[1]
>>>
>>> [1] https://www.youtube.com/watch?v=-Vld9aoFPwU
>> Nishanth,
>> Thanks for the information.
>>
>> Krzysztof,
>> Sorry for the errors caused by my oversight. Kindly excuse me. Would
>> you want me to resend the V3 series with the correct subject?
>>>
> Hi Krzysztof,
> Could you please let me know if further action is required from my end?

Please repost with all tags from all people and properly rebased. This
is weird that once you have in patch a tag, in next version it's gone.
it suggest you sent wrong patch, not previous but one older.

Best regards,
Krzysztof

