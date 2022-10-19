Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E4604EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiJSR35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJSR3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:29:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BE6C117
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:29:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k9so17475583pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKQx/U9Oi8K1uuimUXOQCwOAtdhTQa9BCE+heeFHVSk=;
        b=llqmXm0CMlRdNxGJQhZzu79UZsKVDaHayVNH4B/+FR4a9XyRxvDx+sElvKdhad4pNv
         mdLaT0+TyxGeqlA5slg0RvPDNxFyAi+/JB2MjN8PttYL66+BXuR2g8J0hhUwFniWn/aF
         BHuDOF4poTYwjD4PiI/xZLXK5T6ND5/qAuzDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKQx/U9Oi8K1uuimUXOQCwOAtdhTQa9BCE+heeFHVSk=;
        b=LolPJAS3uvK3rdZZK3XhevIjMp/ttG6/QPpF3hNuUrk+U+2NVoEuqrI2PwA+KrLxH/
         FaUbCjWm6TeEx9dL/zjbTVqfjzh/2L65FkWaH7T/03VvKAa2GzdaAASU3OXEL31lYxK2
         a5HTd8RVMxObdUQIKuS2pvdAGhchW1AtnhmFR4CgRgS7VSLwx3iEU0Dn50AiAYu2dY93
         IsgQcN3G4u07Gq/OHxvHtatJWirdeLbS6zOYhXWhV8OC0ONw8iaBCYtnfZsMGTbawGIs
         oqQf9ggKkTLCu5l3/V5/8lWy7Wwj3TsTYaj4XzCaw7fl8gXDSbHkB5B6rYAytFKsVtkW
         2Dfg==
X-Gm-Message-State: ACrzQf2Vj4WWz91JrM00cLzBg0347dLPw8RutwngvPblL5+5e1Rcflcb
        TlyFUA3ccdrFmfjONIaw34fqmA==
X-Google-Smtp-Source: AMsMyM75Ysi1bNtlIMQFZXd7UXOoVE+FnIFfAU6AD/yNPktRVFZZYOFMxR3rHB2s2wdxINdFWWXNZw==
X-Received: by 2002:a17:903:2312:b0:185:43a2:3d0e with SMTP id d18-20020a170903231200b0018543a23d0emr9702582plh.118.1666200584506;
        Wed, 19 Oct 2022 10:29:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a16c800b00205d85cfb30sm234077pje.20.2022.10.19.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:29:43 -0700 (PDT)
Date:   Wed, 19 Oct 2022 10:29:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: -Wmacro-redefined in include/linux/fortify-string.h
Message-ID: <202210190930.26BF0CE2@keescook>
References: <Y1AZr01X1wvg5Klu@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AZr01X1wvg5Klu@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:37:19AM -0700, Nathan Chancellor wrote:
> I am seeing the following set of warnings when building an x86_64
> configuration that has CONFIG_FORTIFY_SOURCE=y and CONFIG_KMSAN=y:
> 
>   In file included from scripts/mod/devicetable-offsets.c:3:
>   In file included from ./include/linux/mod_devicetable.h:13:
>   In file included from ./include/linux/uuid.h:12:
>   In file included from ./include/linux/string.h:253:
>   ./include/linux/fortify-string.h:496:9: error: 'memcpy' macro redefined [-Werror,-Wmacro-redefined]
>   #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>           ^
>   ./arch/x86/include/asm/string_64.h:17:9: note: previous definition is here
>   #define memcpy __msan_memcpy
>           ^
>   In file included from scripts/mod/devicetable-offsets.c:3:
>   In file included from ./include/linux/mod_devicetable.h:13:
>   In file included from ./include/linux/uuid.h:12:
>   In file included from ./include/linux/string.h:253:
>   ./include/linux/fortify-string.h:500:9: error: 'memmove' macro redefined [-Werror,-Wmacro-redefined]
>   #define memmove(p, q, s)  __fortify_memcpy_chk(p, q, s,                 \
>           ^
>   ./arch/x86/include/asm/string_64.h:73:9: note: previous definition is here
>   #define memmove __msan_memmove
>           ^
>   2 errors generated.
> 
> I can see that commit ff901d80fff6 ("x86: kmsan: use __msan_ string
> functions where possible.") appears to include a fix up for this warning
> with memset() but not memcpy() or memmove(). If I apply a similar fix up
> like so:
> 
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index 4029fe368a4f..718ee17b31e3 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -493,6 +493,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>   * __struct_size() vs __member_size() must be captured here to avoid
>   * evaluating argument side-effects further into the macro layers.
>   */
> +#ifndef CONFIG_KMSAN
>  #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,			\
>  		__struct_size(p), __struct_size(q),			\
>  		__member_size(p), __member_size(q),			\
> @@ -501,6 +502,7 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
>  		__struct_size(p), __struct_size(q),			\
>  		__member_size(p), __member_size(q),			\
>  		memmove)
> +#endif
>  
>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
>  __FORTIFY_INLINE void *memscan(void * const POS0 p, int c, __kernel_size_t size)
> 
> Then the instances of -Wmacro-redefined disappear but the fortify tests
> no longer pass for somewhat obvious reasons:
> 
>   warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memcpy.c
>   warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
>   warning: unsafe memcpy() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memcpy.c
>   warning: unsafe memmove() usage lacked '__read_overflow2_field' symbol in lib/test_fortify/read_overflow2_field-memmove.c
>   warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
>   warning: unsafe memmove() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memmove.c
>   warning: unsafe memset() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memset.c
>   warning: unsafe memcpy() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memcpy.c
>   warning: unsafe memmove() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memmove.c
>   warning: unsafe memset() usage lacked '__write_overflow_field' symbol in lib/test_fortify/write_overflow_field-memset.c
> 
> Should CONFIG_KMSAN depend on CONFIG_FORTIFY_SOURCE=n like so? It seems
> like the two features are incompatible if I am reading ff901d80fff6
> correctly.
> 
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index b2489dd6503f..6a681621e3c5 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -11,7 +11,7 @@ config HAVE_KMSAN_COMPILER
>  config KMSAN
>  	bool "KMSAN: detector of uninitialized values use"
>  	depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> -	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> +	depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN && !FORTIFY_SOURCE
>  	select STACKDEPOT
>  	select STACKDEPOT_ALWAYS_INIT
>  	help
> 
> or is there a different obvious fix that I am missing?

Hm, why can't KMSAN use the same thing KASAN does, and compose correctly
with FORTIFY? (i.e. redefine the "__underlaying_mem*" macros?)

-- 
Kees Cook
