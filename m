Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309546634E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjAIXO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjAIXOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:14:20 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5B53BE81
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:14:19 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r130so8600827oih.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 15:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OnhTMq60ZlyrTxCbX5UG9A3CalsAR+Z2mhuSowyGVrA=;
        b=F4qYwAwEjJiKT0OgPQ7GjcVMsy86D4X2IR+ZQ9RudT8dgmunwrxt4mocX1fBYQBH8y
         GyRdPc29B8gSXqOjYXvsqnYufKLv/k3klNGBDr1HlXdeQg407nQAxDM3UtuFkYgosy2C
         +8Kal/c7ehflkCgmn5tQvys0CYu8zFPybxuaVcd0nWHnY0zRwkpGsoTQQs+AmOKLToeT
         NOh5Cm1o4aghPKZAWhhkghINz8EMONBboewkqsjn1doL9FOYr598W5VB7bjg3zQUufa9
         xqqaSgfU/fqLx2vIFbxmB++PVpm3W2GC6hHw2JAweVB/KCdfnqRmut3bgerY0eYAxbRm
         ZRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnhTMq60ZlyrTxCbX5UG9A3CalsAR+Z2mhuSowyGVrA=;
        b=DaIn5J+HhsYm3kMIgsfnRoIYvrHcYBglnrbR9Kk0W4zyD0YxIOWTYJI3i3TRMb3S7r
         6hctrKllmoHJL1CVE0BThR99tRxBmNP82aTR02yV3lYIL9no83746iD4tqy39LXZ1a6Q
         OyyF+pQTOLNiDrNKIay75V9nwqlPWobEfJROGvjklVPLd9GDI8qRCFeTBmxiVZDqILRz
         WuYeKb+wMzwFqnt5fD1iVQn1Pu88RuwbeyGMSH7jolh5eBrXmPU/zgLUG8QOkGa/c3OI
         TiU9GJhZ29ZtHGL7LlH0B1KpidaG3m6rqAMmtZUMorW4a3dfDzHY2l2Os9ZhaXJKEXM2
         8UpQ==
X-Gm-Message-State: AFqh2kqIVyC1ycLCzas6Q9442bMIOGtG7tuQ5UdRuVNGTQ4sN6rLXCrH
        lXga171syxWVG43/LTdccu6TfOhThfU=
X-Google-Smtp-Source: AMrXdXutmGsgmSr6/qb/dOTYWdXv/XXym7ZoJZBFf4p1X0ltkQvWCd+WYoM4WCKkTNQA2eNv8UjmpA==
X-Received: by 2002:a05:6808:178a:b0:363:b41b:eedd with SMTP id bg10-20020a056808178a00b00363b41beeddmr19520924oib.20.1673306058926;
        Mon, 09 Jan 2023 15:14:18 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t13-20020a9d774d000000b00670523bf1cfsm5272071otl.47.2023.01.09.15.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:14:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2128d543-33aa-b32d-68f6-5d3edad6cb47@roeck-us.net>
Date:   Mon, 9 Jan 2023 15:14:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Linux 6.2-rc3
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <kees@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjwrqFcC9-KkfboqATYwLfJHi_8Z5mTrJh=nf8KT_SjUA@mail.gmail.com>
 <20230109174742.GA1191249@roeck-us.net>
 <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=whC+YpdympyegB0Wr_0_6=LYggdabkMExRus2DtAdsv-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 14:18, Linus Torvalds wrote:
> On Mon, Jan 9, 2023 at 11:47 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
>> include/linux/fortify-string.h:59:33: error: '__builtin_memset' pointer overflow between offset [28, 898293814] and size [-898293787, -1] [-Werror=array-bounds]
> 
> Ok, I guess we'll have to disable this gcc warning for this version
> again. I don't think anybody figured out why it happens. We had
> several people look at it (Kees, Vlastimil, Jaegeuk) and I think
> everybody ended up going "tis looks like a compiler thing".
> 
> Does anybody remember - what was the compiler version again and what
> do we need to disable?
> 

I currently run my build tests with gcc 11.3. There is "config CC_NO_ARRAY_BOUNDS"
which disables it for gcc 12.

Guenter

