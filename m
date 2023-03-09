Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C904B6B1B69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCIGZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCIGZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:25:26 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07797DC0A6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:25:12 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so2894536edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678343110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obHvwV5aXqjiNUz9hYoyhrDzm/kScduQjw98xG7/KEs=;
        b=jjyhv8k5K3ArwZK0nZZ/WsA/r/ggANnLRKe4kZsSNCrO3cFJan2faUjfdbjWNVwVYw
         DO8tgjWkggxbGPjYKnJWoTxo9OTiNe5q3RIiHp/YyF9y0ECatGhOr3Fjfo4fTPGRquLN
         mxVfdrENdtyJmcS0fl2ocCjw5u4btbxhAqhF4Gs6/nSpZPlnDZe6PzBa1bCCkQNF6qU2
         Xun7gbAOeo1P2Ci2cZmPvfe/h5txObZT++E4wcyZfxDgFQ1oqIlyUGyNkWS+5i/IJAjR
         d2Tpfi+2jRln1ACjO/lHp9s2celVf88pL9q3HptOyMC0hvlEyffh2a+3e52C1NuX59Q/
         gZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678343110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obHvwV5aXqjiNUz9hYoyhrDzm/kScduQjw98xG7/KEs=;
        b=ZtEEweme3Grp43qOf87z+Mw5fWMBs4jQ7urLYaRMwQXrMzMQkZeIufMRYoDZfWqVzB
         Fajr8fcYGVWgcgch4Y+Ew8r6wAB2LcXoo2H2tfR6a58+YrMtml4T1fW91Boz1H+rRucD
         JIkMs6IDRi9pu+RwWXVL894ZMzWKWcD3AstrFaCav9KX+OVAWHmzA7x4gy2fgAHskeTG
         a0SUJykjTWN3YgEYAwY1EYfr+bFdIZ09eubk6Ez365mQ8YZppqZXNil7YndGHkyHE6tf
         CeGXdatvqTbERSD5gZRMnWe9bMmmzl3xLt1TpWk7sq6AGTC9k9I7OKCkbhlZHzbHH7mF
         cpAA==
X-Gm-Message-State: AO0yUKVBClmm6qmek1qbFyJyNhVgzPs36+r5NwoWciUKMHThBUijDU5j
        45dTFlbPUkd52ltcx3v+iX8rgQ==
X-Google-Smtp-Source: AK7set9zze89UeNZ2W90utNcsj+V/x1hzYimqzrNLO8URVxOR7jJOwBWfKNoQZyq2b4hy0kN7c27dw==
X-Received: by 2002:a17:906:9f21:b0:884:3707:bd83 with SMTP id fy33-20020a1709069f2100b008843707bd83mr18666390ejc.69.1678343110512;
        Wed, 08 Mar 2023 22:25:10 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709064a8600b008be5b97ca49sm8377544eju.150.2023.03.08.22.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 22:25:10 -0800 (PST)
Message-ID: <882bd054-9c3e-1b26-72a5-89ad92e21a79@linaro.org>
Date:   Thu, 9 Mar 2023 07:25:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 1/2] dt-bindings: clock: add loongson-2 boot clock
 index
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230307115022.12846-1-zhuyinbo@loongson.cn>
 <692a62da-a9a1-fa23-6e24-723d73c3a423@linaro.org>
 <5e9b3bd5-d885-6237-5e14-2becb3c956cc@loongson.cn>
 <31e2a67a-c046-9501-80de-e754ed450195@linaro.org>
 <ace5159b-ebbd-7805-518c-ed3d39e4793e@loongson.cn>
 <b2f9cd15-b303-882a-d4e0-36d1f6d155a8@linaro.org>
 <eca81d44-2513-8002-980d-755af32f36c4@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eca81d44-2513-8002-980d-755af32f36c4@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 02:43, zhuyinbo wrote:
> 
> 在 2023/3/8 下午6:38, Krzysztof Kozlowski 写道:
>> On 08/03/2023 10:24, zhuyinbo wrote:
>>>>>> That's an ABI break and commit msg does not explain it.
>>>>> you meaning is that need add a explanation in commit msg that why
>>>> You need good explanation to break the ABI. I don't understand the
>>>> commit msg, but anyway I could not find there justification for ABI
>>>> break. If you do not have good justification, don't break the ABI,
>>> The commit msg is the patch commit  log,  and I maybe not got it about
>>> break the ABI.  You said about "break the ABI"
>>>
>>> is whether is location issue about "LOONGSON2_BOOT_CLK"?   if yes,   the
>>> LOONGSON2_BOOT_CLK was placed
>>>
>>> after LOONGSON2_PIX1_PLL that is due to their clock parent is same.
>>> and I whether need add this explanation
>>>
>>> in patch commit log description?
>> Unfortunately I do not understand single thing from this.
>>
>> Best regards,
>> Krzysztof
> 
> The patch commit log description is patch desription.  as follows:
> 
> 
> commit 592bc2b4106d787ea166ba16bfde6b3101ab1a8a
> Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> Date:   Tue Mar 7 17:18:32 2023 +0800
> 
>      dt-bindings: clock: add loongson-2 boot clock index
> 
>      The Loongson-2 boot clock was used to spi and lio peripheral and
>      this patch was to add boot clock index number.

I cannot understand this either.

> 
> 
> and your advice is "That's an ABI break and commit msg does not explain it."
> 
> I got it  from your advice that was to add a explanation about 
> LOONGSON2_BOOT_CLK's
> 
> location issue in patch description, right?

ABI break needs justification, why do you think it is fine or who
is/isn't affected etc. Your commit msg does not explain why ABI break is
okay. It doesn't even explain to me why you need it.


Best regards,
Krzysztof

