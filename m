Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE47741124
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjF1MgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjF1MgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:36:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AAB30E5;
        Wed, 28 Jun 2023 05:36:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b80f2e6c17so23578135ad.0;
        Wed, 28 Jun 2023 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687955762; x=1690547762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=P9uwE8FV/ivDDO+Z8YzefStQzaFkqx5z6ew9qfbvNn8=;
        b=jTEDyJRMwskUuN3w4IcMMHahRhE3VhVIqr/j/NRpR5FGHr3osT7NE0BRIQltdAcB0l
         WLPKcK7/5tW4mI9NimxfGyGKkD5UT+n++9dW9bSdl6r1p68nrn/XWO79jWN+X0iJcsCR
         zrS7RJQmUb2pzRYnle30jinbnV+fFTwVl4dh1wBT01IsbNoN22U0Ese0Jgfx32cViDJ9
         yWgYWOmnIWEXDowVrahO6fiVXViWP8Gykg8WkWRXjyGX0fxmqNIPasv1YAVSFhl942sI
         631RJ8UnNy7u4y8RDGygB+iEzvEA6Ooyh4hLGx+CM1iLXxiq0xgwa3WBgq0HxVDE//Gv
         u0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687955762; x=1690547762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9uwE8FV/ivDDO+Z8YzefStQzaFkqx5z6ew9qfbvNn8=;
        b=d/u7Cg3ihJWXc9vaD0Fob2Y5jGeTJ7iLggUYXbH/wunI0rLerlzl0MVHPqEz5Vuosk
         Ij6SqD3GwH/pxN4rDHHY/GoYt5TYXy+kYuf9stuwvBGWFGWnuNPcX4SmbuARtSnX4i92
         QBEg8nfPNQskV4mJlt8s/vvD4BRaSC+FAr2s+0ZR6z5+M8Xp2R626I3EngYmq5xPS6T+
         511um9nsJgYfC9PF0EeaMXN6BmXN2r9drbGQwo74J+pv8kutskCskRs7wgXZaOW3ZeRQ
         9l6BGFRl6YkP1gbmykKQWdSwICTAC6JpJTyd92i1QLv87Co9iaJUxpy8FCyaMws/mOEW
         y65g==
X-Gm-Message-State: ABy/qLa/DKJQ6smRu5xMkLrmO07UFMzWsSGk1qNO4FFZnavmGcbLgyie
        CmWofnl286IaE5P91bk1XMQ=
X-Google-Smtp-Source: APBJJlEChZyNGMV0N5RWs86fVhqh4+9fjpQ5sFTfwIKFSfURuvun6qQrr4ThcGV6vVTq3IjsH4CW0g==
X-Received: by 2002:a17:902:d315:b0:1b8:4cd0:e29c with SMTP id b21-20020a170902d31500b001b84cd0e29cmr124200plc.21.1687955762194;
        Wed, 28 Jun 2023 05:36:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001b694140d96sm7600889plb.170.2023.06.28.05.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 05:36:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4eda066a-a56f-583d-84dc-69c1190d1bf7@roeck-us.net>
Date:   Wed, 28 Jun 2023 05:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230628094938.2318171-1-arnd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230628094938.2318171-1-arnd@kernel.org>
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

On 6/28/23 02:49, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An otherwise correct change to the atomic operations uncovered an
> existing bug in the sparc __arch_xchg() function, which is calls
> __xchg_called_with_bad_pointer() when its arguments are unknown at
> compile time:
> 
> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
> 
> This now happens because gcc determines that it's better to not inline the
> function. Avoid this by just marking the function as __always_inline
> to force the compiler to do the right thing here.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice catch.

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/sparc/include/asm/cmpxchg_32.h | 2 +-
>   arch/sparc/include/asm/cmpxchg_64.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
> index 7a1339533d1d7..d0af82c240b73 100644
> --- a/arch/sparc/include/asm/cmpxchg_32.h
> +++ b/arch/sparc/include/asm/cmpxchg_32.h
> @@ -15,7 +15,7 @@
>   unsigned long __xchg_u32(volatile u32 *m, u32 new);
>   void __xchg_called_with_bad_pointer(void);
>   
> -static inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
> +static __always_inline unsigned long __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>   {
>   	switch (size) {
>   	case 4:
> diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
> index 66cd61dde9ec1..3de25262c4118 100644
> --- a/arch/sparc/include/asm/cmpxchg_64.h
> +++ b/arch/sparc/include/asm/cmpxchg_64.h
> @@ -87,7 +87,7 @@ xchg16(__volatile__ unsigned short *m, unsigned short val)
>   	return (load32 & mask) >> bit_shift;
>   }
>   
> -static inline unsigned long
> +static __always_inline unsigned long
>   __arch_xchg(unsigned long x, __volatile__ void * ptr, int size)
>   {
>   	switch (size) {

