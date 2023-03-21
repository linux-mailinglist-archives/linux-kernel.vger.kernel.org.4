Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276456C3E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCUXKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCUXKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:10:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11100591D0;
        Tue, 21 Mar 2023 16:10:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r5so20099959qtp.4;
        Tue, 21 Mar 2023 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679440203;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xuoSFFtj1/+YE7E3xp2WQrQzEqTdq3903Th6D7zmJeQ=;
        b=XZ5S2zbXob9gLI8kVEZyqevbUqcRYN5BOACBYw6/m92YTbmB9HoSUaRkskpeUpIsH2
         VQnC6sSy04Va3SYjXEb9l8LK0T5815dEh0LaLjg5wdSiTNbUxJhH68Z8SjPXrB5cP4fN
         ++jfTRsx9eYlSr2wuvQXPs7251Gw9rxiqtrTqqPcn9Z8YEK/9LAx0EeM+ezYphcuL4E/
         twvNUKz4cJ/mmJCF1Fbtsln+tPHyKNQ7fv3y3yKk9sVqhBnotkffbWxeb4io2hFwtw8y
         GPy78s55pt+6bqc8HF4Q3IAM9gnTM3nAsczdVojqBXGpBYBeNYd7JPbqPnqNAdk5u7I5
         Pmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679440203;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xuoSFFtj1/+YE7E3xp2WQrQzEqTdq3903Th6D7zmJeQ=;
        b=e0S6JM+2ddES7WakaC99XqrSsFkMXQ9LfU+H5HJ/92lQj1bDVTgnOD5lcEopqMVO+3
         v2XTdjRxODYw/j9tyR0W34wt4RJfG+fxo/al3u9ETVqbcb76jA7oqOd7j1f/0E6g+cpW
         XaO32zLwyP39+6TdPrTxHHc1h78dUe4I0VxX/2PsMeJVr8WzeVQakeZxLNiOSovh2hHj
         K94h5h8oJIlFWGJERBrcAcXXfn4GHVtkIZNyR/cxpXKDBv2aDrabkrAdMhYyCYPfr+ap
         xFhXfPfS4jfu45At4KTyTp8Sy+vCs+n2gqFsQuE4MBzqzr7qPOBHGAE0JvcA+lgX17Eo
         IklQ==
X-Gm-Message-State: AO0yUKXVLzbjoDO5u7Gfp3RqaeOKqrjnCLEr/URDaEl78bgqVVzQleZi
        Hf33AusFJaMljSXJCqjdP1E=
X-Google-Smtp-Source: AK7set8wyB+DkOyuQvT+aOd+5u7iiwzEONKERhJURQEzl+Y2KbaAwPqlKAx4T6AVPUqe3ZuuZvjyTA==
X-Received: by 2002:ac8:5ccc:0:b0:3b6:2e9b:cf2b with SMTP id s12-20020ac85ccc000000b003b62e9bcf2bmr3478243qta.14.1679440203041;
        Tue, 21 Mar 2023 16:10:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 4-20020a05620a048400b007468bf8362esm4429442qkr.66.2023.03.21.16.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:10:02 -0700 (PDT)
Message-ID: <302bb0c4-a31e-7025-26d6-21c8d473f370@gmail.com>
Date:   Tue, 21 Mar 2023 16:09:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset
 driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, william.zhang@broadcom.com,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
 <20230321201022.1052743-5-noltari@gmail.com>
 <3a1d7b271a42324c056d983e1943b386.sboyd@kernel.org>
 <0071fdc1-fa53-e096-19c7-ecd1a9d56e86@gmail.com>
 <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <d06781c905adb23089a85a8d54b94461.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 16:06, Stephen Boyd wrote:
> Quoting Florian Fainelli (2023-03-21 16:00:29)
>> On 3/21/23 15:57, Stephen Boyd wrote:
>>> Quoting Álvaro Fernández Rojas (2023-03-21 13:10:22)
>>>> diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-bcm63268-timer.c
>>>> new file mode 100644
>>>> index 000000000000..6a1fdd193cb5
>>>> --- /dev/null
>>>> +++ b/drivers/clk/bcm/clk-bcm63268-timer.c
>>>> @@ -0,0 +1,232 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * BCM63268 Timer Clock and Reset Controller Driver
>>> [...]
>>>> +
>>>> +static inline struct bcm63268_tclkrst_hw *
>>>> +to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
>>>> +{
>>>> +       return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
>>>> +}
>>>> +
>>>> +static int bcm63268_timer_reset_update(struct reset_controller_dev *rcdev,
>>>> +                               unsigned long id, bool assert)
>>>> +{
>>>> +       struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
>>>> +       unsigned long flags;
>>>> +       uint32_t val;
>>>> +
>>>> +       spin_lock_irqsave(&reset->lock, flags);
>>>> +       val = __raw_readl(reset->regs);
>>>
>>> Use regular ol readl() here, unless you have some need for no barrires
>>> or byte swapping.
>>
>> These SoCs are big-endian, require native endian register access and
>> have no posted writes within their bus logic (UBUS) and require no
>> barriers, hence the use of __raw_readl() and __raw_writel() is adequate.
>>
> 
> Use ioread32be() then?

BCM63xx drivers tend to use __raw_{read,write}l for consistency and to 
make it clear that no barriers, no endian swapping is necessary, I would 
prefer to remain consistent with that convention.
-- 
Florian

