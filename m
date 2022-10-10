Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7513C5F9757
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJJENb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJJEN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:13:27 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A041350055;
        Sun,  9 Oct 2022 21:13:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m14so11901625ljg.2;
        Sun, 09 Oct 2022 21:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfmnCF2JkZ212xJuEQBcv/tw0uOJJMilOQ3nQbPwxvU=;
        b=kdClPiJ/QFimo9CaXWkUw/AJJsojYvRQqSokGBMuvPNppDfZnoHV0cu78Aa48JG1mI
         9LKqf0UF6T5d+9WiGhVBXGB/6Um8ZKdM/kYE3zXfvdf3Shpvg6fJOLPJUDCkHxWgM4D4
         jR4RrqNDKzTqc9ckgaLNW1aHzg8xuJSjPrkW8xjvyXAWKsVcZa0xYlJb//6IQAADp1pg
         8tYI83PH9SXy1lgktSCEZ23cmWux7AgjTBEUTYNJ+GS6FI38bIOZcjKaqeJKq2rtEtjK
         jygzzGrjLH1yKAdyldNlB0P4iD3z2HOySVkR1y/X5RYBoVxn5hS2oh2zEf4aPZpNXxse
         79Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfmnCF2JkZ212xJuEQBcv/tw0uOJJMilOQ3nQbPwxvU=;
        b=fKjmPDTwIcYTYcDHPLMuUqVdad7avcuEBacY9AfHX8pNG+4jhCIkevDJWI21nv/ggg
         Xj7EWBsjg5rX9HggN30kPxl/4p3JLZnfsET+b85FrX9gJmsziHP26PuH0rk1svfUQwTl
         JdU2Ne8nRJC4OLA1hPtL2qPXczEwFZjjs3wxpK1n4RX7fwHKEHjaXDHzUhCBMsARYFUj
         ng8EhpQq/3pbU7CUjdrclyc6RAMwlwafPw2jKFyR+PVXzBrA04bBRyX3e2acswqIDxxO
         2z/sa5a37pQrCPjGX1a02nwgyvMDKeVJ1BME9TxQGbVZyGLHPexqc+LbaJqkHuXK3nf3
         YR9g==
X-Gm-Message-State: ACrzQf3MhaOeO6tNY/i6+0Tbdoq5lS3EqdKlbLFbY4IQuqO6VJI8zGyW
        e2ch9mIGFeGiQaQqKAA7kXgFj0Mc1uI=
X-Google-Smtp-Source: AMsMyM7ZmXHBUd2X3Kq7Q1+PaPvekcA0qVHbEr4eDwDTWuWCAZLWoIgP2aB5UUzLuHJ8C8ia4m8Tqg==
X-Received: by 2002:a2e:9b81:0:b0:26e:190:378c with SMTP id z1-20020a2e9b81000000b0026e0190378cmr5812957lji.66.1665375204525;
        Sun, 09 Oct 2022 21:13:24 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s5-20020a2e1505000000b0026548b59479sm1435233ljd.64.2022.10.09.21.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 21:13:24 -0700 (PDT)
Message-ID: <c25ce92b-ea93-1bd8-11ba-4812b040724d@gmail.com>
Date:   Mon, 10 Oct 2022 07:13:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH v2 1/5] regulator: Add devm helpers for get and enable
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <fa667d6870976a2cf2d60f06e262982872349d74.1665066397.git.mazziesaccount@gmail.com>
 <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Yz7/o1q7p8NmGKMe@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 10/6/22 19:17, Andy Shevchenko wrote:
> On Thu, Oct 06, 2022 at 05:36:52PM +0300, Matti Vaittinen wrote:
>> A few regulator consumer drivers seem to be just getting a regulator,
>> enabling it and registering a devm-action to disable the regulator at
>> the driver detach and then forget about it.
>>
>> We can simplify this a bit by adding a devm-helper for this pattern.
>> Add devm_regulator_get_enable() and devm_regulator_get_enable_optional()
> 
> ...
> 
>> (cherry picked from commit b6058e052b842a19c8bb639798d8692cd0e7589f)
> 
> Not sure:
>   - why this is in the commit message
>   - what it points to, since
> $ git show b6058e052b842a19c8bb639798d8692cd0e7589f
>   fatal: bad object b6058e052b842a19c8bb639798d8692cd0e7589f
> 
>> Already in Mark's regulator tree. Not to be merged. Included just for
>> the sake of the completeness. Will be dropped when series is rebased on
>> top of the 6.1-rc1
> 
> Ah, I see, but does it mean the commit has been rebased or you used wrong SHA?

I did probably cherry-pick this from my local development branch and not 
from Mark's tree. Sorry for the confusion. I thought people would ignore 
these first two patches when reviewing as was requested in cover-letter.

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

