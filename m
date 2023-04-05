Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E86D7B76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbjDELgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbjDELf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:35:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F41BD7;
        Wed,  5 Apr 2023 04:35:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so35855315wra.9;
        Wed, 05 Apr 2023 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680694553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlvKXsC33Y3r1CipsD3fypO8/mtd2VSfqMY0AAuYEJU=;
        b=lORbIDSoT/048s2YK0Ooqaq76pp9nO16IgSl7E0zcw4519qRfB2EB9bS33CYOOkI5J
         pfTaClxlRxqDfVRYTx2Z+UgdqAZLwhJB9A5pB14jcytveOARMJzLG5xpjgyCQ8NG+8lz
         ev3K604YpC9YuL/r728Z1Y9hLVtLsaw+N/7x4L7nFGT0fiuzIfjnVXthx/T5amkZgCq0
         pEEuVse58fqlV2CyoHyzTOON/kzCpp1NDkIarzhDQElXYaKK062+3PuMCp88nlhfHLQh
         IU1Fh5+UUIInU8suruQpN1cboZlK59YnMqsD0tiYx/ZtqdSFCdDLQzmdD790LguYejUB
         v8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlvKXsC33Y3r1CipsD3fypO8/mtd2VSfqMY0AAuYEJU=;
        b=l1p4Nal/G3l4CLnqG2AoBkxX1vYXVfPVa2Dxx9n0fUj23CuwOHOTca5Gawcr+2oTjl
         fd3k34m2VFQya4eBFtQPIIO6Fb5Zdda4CFW85+2rKoqYn3uo0TzwoFSBrlGdVNy7k58u
         1eaUOeqpk7q8HThRCng7urkBlGLUkx3zZmFqs7xLsycyAav0hCxREP6v4yfUllUCvtJA
         hQyNTk+qI02jC28ofcCxsZRq/li5aKmO0L5AlMwJ0mayXcORX+E1Xy2hfFZx3yRswcmD
         Zo4SIctrFcUsuw/G/HckKXSzAyOvN8ofXFJJC03qIF8rnWbDF8M9zAQtixEFDfA6nUAz
         MAbA==
X-Gm-Message-State: AAQBX9csPRk53vQu36/yGJJSU+UEUA1k0n7+64ld187DVXoUYGLMzZRK
        1hlqfsJKqvesNG3kA9LdVwc=
X-Google-Smtp-Source: AKy350aseZzBCum6L3ZdzJV0ccP/niUOapvEPnQGYI92PSTLWqPEIZgktt6CkrodRO1mno8ot6F6IQ==
X-Received: by 2002:adf:f004:0:b0:2cf:f01f:ed89 with SMTP id j4-20020adff004000000b002cff01fed89mr4390917wro.24.1680694553507;
        Wed, 05 Apr 2023 04:35:53 -0700 (PDT)
Received: from [192.168.237.204] (s-8d3a2aa4.on.site.uni-stuttgart.de. [141.58.42.164])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d4987000000b002ceacff44c7sm14806432wrq.83.2023.04.05.04.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 04:35:53 -0700 (PDT)
Message-ID: <bedd7426-5875-dbd7-38fe-2e943c7109f8@gmail.com>
Date:   Wed, 5 Apr 2023 13:35:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V4 22/23] platform/surface: Disable for RISC-V
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
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
 <0c433e15-640e-280f-fcb0-a8fe081d1bcc@gmail.com>
 <ZC1XUdD3DFnNauQ2@sunil-laptop>
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZC1XUdD3DFnNauQ2@sunil-laptop>
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

On 4/5/23 13:11, Sunil V L wrote:
> On Wed, Apr 05, 2023 at 11:33:00AM +0200, Maximilian Luz wrote:
>> On 4/4/23 20:20, Sunil V L wrote:
>>> With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
>>> in allmodconfig build. However, RISC-V doesn't support sub-word
>>> atomics which is used by this driver. Due to this, the build fails
>>> with below error.
>>>
>>> In function â€˜ssh_seq_nextâ€™,
>>>       inlined from â€˜ssam_request_write_dataâ€™ at drivers/platform/surface/aggregator/controller.c:1483:8:
>>> ././include/linux/compiler_types.h:399:45: error: call to â€˜__compiletime_assert_335â€™ declared with attribute error: BUILD_BUG failed
>>>     399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>         |                                             ^
>>> ./include/linux/compiler.h:78:45: note: in definition of macro â€˜unlikelyâ€™
>>>      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>>>         |                                             ^
>>> ././include/linux/compiler_types.h:387:9: note: in expansion of macro â€˜__compiletime_assertâ€™
>>>     387 |         __compiletime_assert(condition, msg, prefix, suffix)
>>>         |         ^~~~~~~~~~~~~~~~~~~~
>>> ././include/linux/compiler_types.h:399:9: note: in expansion of macro â€˜_compiletime_assertâ€™
>>>     399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>         |         ^~~~~~~~~~~~~~~~~~~
>>> ./include/linux/build_bug.h:39:37: note: in expansion of macro â€˜compiletime_assertâ€™
>>>      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>         |                                     ^~~~~~~~~~~~~~~~~~
>>> ./include/linux/build_bug.h:59:21: note: in expansion of macro â€˜BUILD_BUG_ON_MSGâ€™
>>>      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>>         |                     ^~~~~~~~~~~~~~~~
>>> ./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro â€˜BUILD_BUGâ€™
>>>     335 |                 BUILD_BUG();                                            \
>>>         |                 ^~~~~~~~~
>>> ./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro â€˜__cmpxchgâ€™
>>>     344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>>>         |                              ^~~~~~~~~
>>> ./include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro â€˜arch_cmpxchgâ€™
>>>    1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
>>>         |         ^~~~~~~~~~~~
>>> drivers/platform/surface/aggregator/controller.c:61:32: note: in expansion of macro â€˜cmpxchgâ€™
>>>      61 |         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
>>>         |                                ^~~~~~~
>>>
>>> So, disable this driver for RISC-V even when ACPI is enabled for now.
>>
>> CONFIG_SURFACE_PLATFORMS should be enabled for ARM64 || X86 || COMPILE_TEST only,
>> so I guess the issue only happens when compiling with the latter enabled?
>>
>> I'm not aware of any current plans of MS to release RISC-V-based Surface
>> devices, so you could maybe also just explicitly disable CONFIG_SURFACE_PLATFORMS.
>> In any case, I don't see any issues with disabling the whole platform/surface
>> or only individual drivers for RISC-V, so for either solution:
>>
>> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
>>
> Hi Maximilian,
> 
> Thanks!. Yes, COMPILE_TEST gets enabled for allmodconfig builds. Since
> the whole intention of COMPILE_TEST appears to be able to compile-test
> drivers on a platform than they are supposed to be used, I think it is
> better not to skip whole set of drivers but only that which can not build.
> So, I prefer to keep this change as is.

Hi Sunil,

What I wanted to say with my previous mail: I'm fairly confident that
platform/surface drivers will not be actively used on RISC-V hardware any
time soon (not sure if that came over in this way). But whatever you/others
prefer, I'm happy with either.

Best regards,
Max
