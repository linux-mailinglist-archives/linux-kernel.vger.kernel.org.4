Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699426B66CB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCLNkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCLNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:40:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C31FF1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:39:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso6235229wmp.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678628398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pW3SYoJSfYigvun40dUyfsdJwqphbL/38YBc34ttyCo=;
        b=YhkYASX7a74CAsFNiKpJWvIMR1ENdKDvxrtH595UKIWI4fV6J2X0y6ji3Ri0tSopvV
         NrijF/N2W9Sh7pculPdZ1KQrU7uButTTnkkA2tJ987jNOprgTgbDRcaTDr4xZSBAiOya
         pTdLvhARtdlxSVlBLoBKx/dyaF0/hhcn6BTqs4Rc6AMXywuNhT+yJGirNaFYEEq9hpkv
         qZpYG43aCAsoSqpEBHnuewH0jWWYhVgnGGTOtV5puQZvS/gbqC/pedktrqrWhwucbrlf
         fcQCH0lumhZ7306XmrubeVdBmVsL+89qWNxXR3lrxE3dQfLxx5UqfjtLRxIV79+rw0Cc
         vGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678628398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pW3SYoJSfYigvun40dUyfsdJwqphbL/38YBc34ttyCo=;
        b=UWZhTEFh/g+5jFN92Xub8QDndIFRP92O4l9jraKO9t/E7u6XPpIOZrAQvNB4m4KsuT
         5vnh4FzflSRxwYNDR/lsdvslZuC7aODn25UOgA1eeCpxcTo4uI1jhM8cfAtrEZhptgm2
         ZThRaIgoST1b+LD1NAT0K98NnxADCPMYbfFqMHPi3YDC2niMozUGHgySYFTjtA1PoLpq
         zhApwECNOeIbkjGFqo3yoB8roYwVLR+gzJb0lhHgAElHWDo9CYG7/oZjw2LAF4Nw5mrH
         hLZ3+9WrwBNJGSKPPcPuIFhOYO3wcuq8KWPOBbFhaDbKVbBtAVtmz86fYO56AmR7xXeN
         vO5A==
X-Gm-Message-State: AO0yUKXibZikejRaoW8NxlXaoN0Qro7bu+1vmFQUyOQ8AJDwxkwoL3ZK
        BsHgvdUE/7VcnQvt/0SgQ7Q=
X-Google-Smtp-Source: AK7set/Puwux94bwB+pHKftXFM9AZEJDRXkcO3uxKEjnksL/INtvCvoixKCiQSDWOhfcojHCeYlMTQ==
X-Received: by 2002:a05:600c:1c95:b0:3eb:2b69:c3c6 with SMTP id k21-20020a05600c1c9500b003eb2b69c3c6mr8000944wms.1.1678628398284;
        Sun, 12 Mar 2023 06:39:58 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c294b00b003e21638c0edsm5957737wmd.45.2023.03.12.06.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 06:39:57 -0700 (PDT)
Message-ID: <1e8d503d-decb-e662-3457-19d41c6769e0@gmail.com>
Date:   Sun, 12 Mar 2023 15:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Dan Carpenter <error27@gmail.com>, outreachy@lists.linux.dev,
        pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
 <10d2c15b-ff9f-4634-a013-7640c93435a7@kili.mountain>
 <c9ae27dc-3538-5432-6a6d-3e2ff034f467@gmail.com>
 <alpine.DEB.2.22.394.2303111600330.2802@hadrien>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303111600330.2802@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١١‏/٣‏/٢٠٢٣ ١٧:٠٠, Julia Lawall wrote:
>
> On Sat, 11 Mar 2023, Menna Mahmoud wrote:
>
>> On ١١/٣/٢٠٢٣ ١٦:٠٦, Dan Carpenter wrote:
>>> On Sat, Mar 11, 2023 at 03:59:19PM +0200, Menna Mahmoud wrote:
>>>> " ERROR: Macros with multiple statements should be enclosed in a do -
>>>> while loop"
>>>>
>>>> Reported by checkpath.
>>>>
>>>> do loop with the conditional expression set to a constant
>>>> value of zero (0).This creates a loop that
>>>> will execute exactly one time.This is a coding idiom that
>>>> allows a multi-line macro to be used anywhere
>>>> that a single statement can be used.
>>>>
>>>> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
>>>> fix checkpath error
>>>>
>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>> ---
>>> This breaks the build.  You need to compile the code before sending a
>>> patch.
>>>
>>> regards,
>>> dan carpenter
>>
>> I see, I thought building the file only enough. appreciate your feedback.
> The outreachy tutorial explains how to compile everything in a
> subdirectory.
>
> julia


Thanks Julia, I will check it.

Menna

