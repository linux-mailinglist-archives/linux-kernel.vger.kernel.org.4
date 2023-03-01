Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F36A76A4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCAWJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:09:57 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC89B19692
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:09:55 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id f1so10355002qvx.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 14:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m81d3ZLYTA7um9M2BirrsjSwNVFJb6lqEr36j6zjLAk=;
        b=K+4LerK63Mc/rUyaTPH9P95zh5pcpecJ9ALi8IDWd8us+oUEDkQP3KE1ABeI/0Jt5F
         qojwGe10Be/ITsn+4BTwbn6CU+ozh6YYb0CJTL07KVSohZuPNQYaHgQWh4XFYkHMEV7e
         XNPtcQBpNv8cTkABk8B7fiZp9IhJfOA0fhw4Q4jma4Dx73lCcEIhyNNN96Jfy7rqETEl
         IfzTHeZdiRq0FCwvMLx5EkDMgf38j3dUSsHVi+GQSi1aGyr2HA80PNniG1RFTJHL4iW1
         JB9Ln8tVJwl3V9Z99WprMZBFm6WGb0ZBW4NO12q4R83OIL4U68yFb2ukxLZokIFmr6Dg
         a2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m81d3ZLYTA7um9M2BirrsjSwNVFJb6lqEr36j6zjLAk=;
        b=SGSb1z2v3NaOV4d2PyrHvOetLHHbKLmktDe6pmQmckbsOuDVAdmwZchfbl5WKWafdX
         fX09dnlyoEq4YNqQ5oWN9S4Tnmlc+aEl3HmF5lRJ/ybnSJawtsWeKeCBBo/cEUKaXaNy
         nomPxCL1ejWMR5738fCVcbcJlQZ9mQPdfVSw8dsvWnU5tRLeFXNtzsjCW9p8/2ZEk/i/
         Tefq/6SF7FjD+0iJlTlczOthmpcJJO86172olxesGUZ5b+A0ycQnMBWiY7zKR1wyYYFv
         0EaQLjJ5tKXkfRCjRk5cZfUxTxlkOcI+x/g8HEjyHOtnxIEQvTtunG3HmGwHeU+dIzRn
         wu/A==
X-Gm-Message-State: AO0yUKXDNEVY1q38oeps28IdYwm14ANgon/toTYLejgtIv7wyjzf4a+J
        BNQz7P1HA+jG0XasFeyuJ6uf2A==
X-Google-Smtp-Source: AK7set9ymAUBN1sEWxPb8MKa0QRmjnq5/cjk/PQEdLjWWbDzIwRsDvRZf0yOU9nUChJkxsjQCV3R/w==
X-Received: by 2002:ad4:5945:0:b0:53a:bf63:b053 with SMTP id eo5-20020ad45945000000b0053abf63b053mr12607707qvb.45.1677708594508;
        Wed, 01 Mar 2023 14:09:54 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id o134-20020a37418c000000b007429ee9482dsm7618614qka.134.2023.03.01.14.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 14:09:53 -0800 (PST)
Message-ID: <31339d95-a318-ba2e-fdb0-ea7b102fd6fd@sladewatkins.net>
Date:   Wed, 1 Mar 2023 17:09:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.10 00/19] 5.10.171-rc1 review
Content-Language: en-US
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kuniyu@amazon.com, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
References: <20230301180652.316428563@linuxfoundation.org>
 <Y//Lw/zL168J3spQ@duo.ucw.cz>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <Y//Lw/zL168J3spQ@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 17:03, Pavel Machek wrote:
> Hi!
> 
>> This is the start of the stable review cycle for the 5.10.171 release.
>> There are 19 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> 
> AFAICT we should not need this patch -- we don't have b5fc29233d28 in
> 5.10, so the assertion seems to be at the correct place here.

This (b5fc29233d28be7a3322848ebe73ac327559cdb9) appears to be in linux-5.10.y,
though?
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-5.10.y&id=b5fc29233d28be7a3322848ebe73ac327559cdb9

Confused,
-- Slade

> 
>> Kuniyuki Iwashima <kuniyu@amazon.com>
>>     net: Remove WARN_ON_ONCE(sk->sk_forward_alloc) from
>>     sk_stream_kill_queues().
> 
> CIP testing did not find any problems here:                                                             
>                                                                                                         
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-5.10.y                                                                                                                         

