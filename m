Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C674BD9B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGHNUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:20:21 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA6E55;
        Sat,  8 Jul 2023 06:20:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2173147a12.3;
        Sat, 08 Jul 2023 06:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688822415; x=1691414415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pGiPPGrgMXyUfZ0JIsjPCZFX5de582TuoG1HeEgrIbM=;
        b=hZAUH3tJ2mYLaYhq154QLQEbtl8Of36YjQyvajQFNgLEvasqKZFKQf0dM19uaUcovu
         tG7A5mhE0jHsAhRKmHPaGOkvP9Y5kH+VZY79xnPaF/GKI0dgacYxpXV7hDJMp01VMWew
         A9b1zSwuF7kh+R6T5NUqelb16tuOgzhj5za9JohdZ/LUbTeYJ5WQZUPNSDU+EAe2k1Jk
         24E2ofoBe2hI3PalGmFHFhAERvpzvX1LLH+GiSE7V+U+ggvIiT4UiIG/IMgzYBYYNkMC
         qIHR0o2KoHjsNX4c784N+KitG1DvPApzaDlf/Xgs9Lz9GMo7tzXXlmvzeTTWfyi6O5ZO
         3gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688822415; x=1691414415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGiPPGrgMXyUfZ0JIsjPCZFX5de582TuoG1HeEgrIbM=;
        b=cnwoSqapRGtH7jQeeqW2OQRyQ45A8nHZ6ler6ysd5UVgwi23Rny1Yr0cyB/wI6avKk
         39BT/P9/xVvyS2RY9nYghMoCxt6AmJyLUe2J9nKQB3zM+qRet7W9yyCKj63w2xFsKzzJ
         mKdDOeC7ovQC2Wjv5N4+2ePYXLdib3MEYSVpvltwipm4xVTPmSKRESTTefsWTTpnxGhv
         ymethZNlDTvw0k3mjI365x//vhSnbBhUtwXIzTYP5N8JgaNzyz9i4OxbcJKm/INBc40S
         GmwVjuYLb79kYEMZ7R3nJGMogAjR0shT4A4t+CO0sgjPQotgbMJffYdWEO1Ipv97xq98
         6eig==
X-Gm-Message-State: ABy/qLZMKp2H8wUPF/iLb0SY+7wZq7JyvB6tzFa2v+EM0ji5VSl6/6mp
        JdprJn3TRhGIP/4sQe8bDcE=
X-Google-Smtp-Source: APBJJlHThpoc5yJG3pDgg9t8Ee2YRk3IzfqPjX0xysSMkHOpg2nBJwsOM285zcktXooIghw7u1Gb9w==
X-Received: by 2002:a17:90b:1bc4:b0:263:cabe:de5c with SMTP id oa4-20020a17090b1bc400b00263cabede5cmr7782819pjb.34.1688822415053;
        Sat, 08 Jul 2023 06:20:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nh8-20020a17090b364800b00256bbfbabcfsm3074316pjb.48.2023.07.08.06.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 06:20:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <36c1ef3d-603b-574a-ad9d-796964a1410c@roeck-us.net>
Date:   Sat, 8 Jul 2023 06:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/27] locking/atomic: make atomic*_{cmp,}xchg optional
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
References: <20230605070124.3741859-1-mark.rutland@arm.com>
 <20230605070124.3741859-5-mark.rutland@arm.com>
 <32395f1f-19e4-41da-9f67-68c7d21cf9b2@roeck-us.net>
 <a94334d8-0a9a-1cbc-ebfe-1825abfb8307@leemhuis.info>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <a94334d8-0a9a-1cbc-ebfe-1825abfb8307@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/23 06:07, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.06.23 19:07, Guenter Roeck wrote:
>> On Mon, Jun 05, 2023 at 08:01:01AM +0100, Mark Rutland wrote:
>>> Most architectures define the atomic/atomic64 xchg and cmpxchg
>>> operations in terms of arch_xchg and arch_cmpxchg respectfully.
>>>
>>> Add fallbacks for these cases and remove the trivial cases from arch
>>> code. On some architectures the existing definitions are kept as these
>>> are used to build other arch_atomic*() operations.
>>>
>>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> [...]
>>
>> This patch results in:
>>
>> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
>>
>> when trying to build sparc64:allmodconfig.
> 
> Guenter, please correct me if I'm wrong:
> 
> This is fixed by Arnd's patch "sparc: mark __arch_xchg() as
> __always_inline", but that afaics sadly hasn't even reached -next yet.
> https://lore.kernel.org/all/20230628094938.2318171-1-arnd@kernel.org/
> 
> Hence adding it to the tracking now that the end of the merge window is
> near:
> 
> #regzbot ^introduced d12157efc8e083c7
> #regzbot title locking/atomic: build error on sparc64:allmodconfig
> #regzbot ignore-activity
> 

Yes, this is correct.

Guenter


