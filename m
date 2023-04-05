Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE36D7876
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjDEJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjDEJeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:34:03 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82959C4;
        Wed,  5 Apr 2023 02:33:41 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so35527280wrp.3;
        Wed, 05 Apr 2023 02:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680687182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m6lntKXuHckes3DfOCLKyfUm4RY1tSieGlGMdRdeCg=;
        b=ovQ3eb1eiAQwqbo5Ec1rsGTce+Hz+32WrCzTCV6aKN7VzI1t4WTQw+oi5Fjm2tx9ED
         U2PLKAiosMdQeR7Kkq4DSD9rqJjesQPtz0iZSEb7eXbSbTNSow2QT+s6rufHSiuQosKa
         BBYiEAEslILdu1TIp0BUOeiJSb1WUTPzbKIV26qCpu4lIhlb/AcewWwRltj5jdlAzBZ5
         /n6V3UzQce7EFM/A/DlgNUEX5Iq0veIkKxpe/lw9Z594oiA4n/TAkEb7ebKyjKkVcFUq
         JcXG+bAOF2T3hOwYu4OUr5B6YAZw0RkrUJEmwBPsQiySJx/lS0eoCWjMoLpGDbByT/Kf
         MxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m6lntKXuHckes3DfOCLKyfUm4RY1tSieGlGMdRdeCg=;
        b=rNLnuUpB06fmSb46eCDhDt960xnc8GfirSmU9ZyK66IJowoPmnMzcMQXRg+8hSf0IW
         f1X3AN33KrEIONSJyV8xaMCDb/9dOS+rrTYxk4ccbQjg0HUa4XvrV+yMqZ5m3YFYX8m9
         AEuzlbhTxD8Snsanhkv+KxROyFELTc/JtmyC8Iq4L9a16jSnCJjLwzcgxdTF6tQLYqxr
         T8Gom7T5OZvvvUpNf8xED4erNLMs+FE0gIZOxQ9f0YNem7ZHMY5NDgEPBrfIce93aOp9
         OrPEMKliV/8foudJm32oxU4SQ3rr3MytzxszJbzkBDnIE28pgW2uDXO9QAarxdzW0Bpg
         2TyA==
X-Gm-Message-State: AAQBX9ebUEJ8btzkT282ffwbHBNYVh2F0dTvda31u5moFDge7ymuCBk/
        DZ+dld3aUqZEB3RsWHguKUQ=
X-Google-Smtp-Source: AKy350bEmXKhbpOLml2JKednF6JyosoF9/Y0Oyj1dYtb90pMMFwBNblSBshHAYOgh5VmCXkMUWMlIQ==
X-Received: by 2002:adf:dc01:0:b0:2cf:9889:8428 with SMTP id t1-20020adfdc01000000b002cf98898428mr3327565wri.35.1680687181685;
        Wed, 05 Apr 2023 02:33:01 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a520.dip0.t-ipconnect.de. [217.229.165.32])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003ede06f3178sm1599550wma.31.2023.04.05.02.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:33:01 -0700 (PDT)
Message-ID: <0c433e15-640e-280f-fcb0-a8fe081d1bcc@gmail.com>
Date:   Wed, 5 Apr 2023 11:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 22/23] platform/surface: Disable for RISC-V
To:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-23-sunilvl@ventanamicro.com>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20230404182037.863533-23-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 20:20, Sunil V L wrote:
> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
> in allmodconfig build. However, RISC-V doesn't support sub-word
> atomics which is used by this driver. Due to this, the build fails
> with below error.
> 
> In function â€˜ssh_seq_nextâ€™,
>      inlined from â€˜ssam_request_write_dataâ€™ at drivers/platform/surface/aggregator/controller.c:1483:8:
> ././include/linux/compiler_types.h:399:45: error: call to â€˜__compiletime_assert_335â€™ declared with attribute error: BUILD_BUG failed
>    399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |                                             ^
> ./include/linux/compiler.h:78:45: note: in definition of macro â€˜unlikelyâ€™
>     78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>        |                                             ^
> ././include/linux/compiler_types.h:387:9: note: in expansion of macro â€˜__compiletime_assertâ€™
>    387 |         __compiletime_assert(condition, msg, prefix, suffix)
>        |         ^~~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:399:9: note: in expansion of macro â€˜_compiletime_assertâ€™
>    399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro â€˜compiletime_assertâ€™
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>        |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:59:21: note: in expansion of macro â€˜BUILD_BUG_ON_MSGâ€™
>     59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>        |                     ^~~~~~~~~~~~~~~~
> ./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro â€˜BUILD_BUGâ€™
>    335 |                 BUILD_BUG();                                            \
>        |                 ^~~~~~~~~
> ./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro â€˜__cmpxchgâ€™
>    344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>        |                              ^~~~~~~~~
> ./include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro â€˜arch_cmpxchgâ€™
>   1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>        |         ^~~~~~~~~~~~
> drivers/platform/surface/aggregator/controller.c:61:32: note: in expansion of macro â€˜cmpxchgâ€™
>     61 |         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
>        |                                ^~~~~~~
> 
> So, disable this driver for RISC-V even when ACPI is enabled for now.

CONFIG_SURFACE_PLATFORMS should be enabled for ARM64 || X86 || COMPILE_TEST only,
so I guess the issue only happens when compiling with the latter enabled?

I'm not aware of any current plans of MS to release RISC-V-based Surface
devices, so you could maybe also just explicitly disable CONFIG_SURFACE_PLATFORMS.
In any case, I don't see any issues with disabling the whole platform/surface
or only individual drivers for RISC-V, so for either solution:

Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>   drivers/platform/surface/aggregator/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
> index c114f9dd5fe1..88afc38ffdc5 100644
> --- a/drivers/platform/surface/aggregator/Kconfig
> +++ b/drivers/platform/surface/aggregator/Kconfig
> @@ -4,7 +4,7 @@
>   menuconfig SURFACE_AGGREGATOR
>   	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
>   	depends on SERIAL_DEV_BUS
> -	depends on ACPI
> +	depends on ACPI && !RISCV
>   	select CRC_CCITT
>   	help
>   	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
