Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F526D7B56
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjDEL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjDEL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:29:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478AC358E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:29:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kc4so34097609plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680694171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D4c1T5yq9j98I4xqzpkXy98H9NvOxhgZzRxqtRXXoJ8=;
        b=gEdmzXz0VIfLxJ35ejE+hqigBd3ZlAebMNBtkV6vu61mKZHcpX9p2jnF1isA21YZIM
         3kDnX+jNcaPCNXXmKITQmBn/dZKyUNwjEqTd/EwtALeGgF/kSEnRpv+ERLYe1z/Sfq4G
         u4HXyAkV0wvl89N1Pjd6gFnwZvqzskXqusycuN4RQZWWBu3GWsrLGlxlt/kmUslAQhzo
         LZDC0KFmqiBC7ClzCjU/BA5Meb1jEsNvGHJNi6UCZe/+6l7JHXYHv+W4reUxuL9NXVYv
         QZq4/aMSdFAAiIXiYz/5PEJ0TZ2UhjoODy4m3WsAztl7rAOs2Wo2M77aSaZtWBQpSM6T
         zQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4c1T5yq9j98I4xqzpkXy98H9NvOxhgZzRxqtRXXoJ8=;
        b=I3NGcWTabCBOriPKmM44atqhFembTPR+v+D7+N7qDXNvMU7a0mS2bliqLDv03d9KSP
         GuKZ9UKmBWBPuLgFXIE/l3xsKmSEJhRZ84JdYdA2UvabcpjL4fpEsWyQWVo3cL6fthuH
         hKhYurlayl1p6J3NO1nHGY0RaCQxPh0XGO4l1IkYw2Q4ogF4f3vt70MAHlttwzJc+tmy
         cCOVB+fz/B78mSciHdKc0dGM8ZOIVuHI2t5ehcKqirVnX+zvZ2dV0KAetraSzn5Dzm20
         2Qtn4wIOapWNLOesEFtZa9sqEr0k+URC2iOkncBxj3c+uCmMJWD9AYB2uE6wDbgkUv8L
         S8QA==
X-Gm-Message-State: AAQBX9f8NZSAnsTtcCPPJJ6bkrz6f2RlHmozTVmZnASgQmE/xblUZh8a
        gC7PUvGM5UnJwGqyOF/bFtsw0Q==
X-Google-Smtp-Source: AKy350aEX+UO+F4lAIjzoSB5aZthgg5fu+oXk5GINgl1jGRsgPHII856swqYeTDojSQysuvDeoDPdQ==
X-Received: by 2002:a17:903:244b:b0:1a0:7425:4b73 with SMTP id l11-20020a170903244b00b001a074254b73mr2119520pls.4.1680694170755;
        Wed, 05 Apr 2023 04:29:30 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902bb8a00b001a1d553de0fsm9852768pls.271.2023.04.05.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:29:30 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:59:18 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-acpi@vger.kernel.org, linux-crypto@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, llvm@lists.linux.dev,
        Weili Qian <qianweili@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Rix <trix@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V4 22/23] platform/surface: Disable for RISC-V
Message-ID: <ZC1bjmdMqYqSnIHP@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-23-sunilvl@ventanamicro.com>
 <EAC85F14-B1DA-4358-9042-A607436D582A@jrtc27.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EAC85F14-B1DA-4358-9042-A607436D582A@jrtc27.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jess,

On Wed, Apr 05, 2023 at 05:19:35AM +0100, Jessica Clarke wrote:
> On 4 Apr 2023, at 19:20, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > 
> > With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
> > in allmodconfig build. However, RISC-V doesn't support sub-word
> > atomics which is used by this driver.
> 
> Why not? Compilers and libatomic do, so surely the Linux kernel should
> too.
>
I think you are probably right. But I don't want to combine that
activity with this series. IMO, that should be separate activity.
 
> > Due to this, the build fails
> > with below error.
> > 
> > In function â€˜ssh_seq_nextâ€™,
> >    inlined from â€˜ssam_request_write_dataâ€™ at drivers/platform/surface/aggregator/controller.c:1483:8:
> > ././include/linux/compiler_types.h:399:45: error: call to â€˜__compiletime_assert_335â€™ declared with attribute error: BUILD_BUG failed
> >  399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >      |                                             ^
> > ./include/linux/compiler.h:78:45: note: in definition of macro â€˜unlikelyâ€™
> >   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
> >      |                                             ^
> > ././include/linux/compiler_types.h:387:9: note: in expansion of macro â€˜__compiletime_assertâ€™
> >  387 |         __compiletime_assert(condition, msg, prefix, suffix)
> >      |         ^~~~~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:399:9: note: in expansion of macro â€˜_compiletime_assertâ€™
> >  399 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >      |         ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:39:37: note: in expansion of macro â€˜compiletime_assertâ€™
> >   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >      |                                     ^~~~~~~~~~~~~~~~~~
> > ./include/linux/build_bug.h:59:21: note: in expansion of macro â€˜BUILD_BUG_ON_MSGâ€™
> >   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
> >      |                     ^~~~~~~~~~~~~~~~
> > ./arch/riscv/include/asm/cmpxchg.h:335:17: note: in expansion of macro â€˜BUILD_BUGâ€™
> >  335 |                 BUILD_BUG();                                            \
> >      |                 ^~~~~~~~~
> > ./arch/riscv/include/asm/cmpxchg.h:344:30: note: in expansion of macro â€˜__cmpxchgâ€™
> >  344 |         (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> >      |                              ^~~~~~~~~
> > ./include/linux/atomic/atomic-instrumented.h:1916:9: note: in expansion of macro â€˜arch_cmpxchgâ€™
> > 1916 |         arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
> >      |         ^~~~~~~~~~~~
> > drivers/platform/surface/aggregator/controller.c:61:32: note: in expansion of macro â€˜cmpxchgâ€™
> >   61 |         while (unlikely((ret = cmpxchg(&c->value, old, new)) != old)) {
> >      |                                ^~~~~~~
> > 
> > So, disable this driver for RISC-V even when ACPI is enabled for now.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> > drivers/platform/surface/aggregator/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
> > index c114f9dd5fe1..88afc38ffdc5 100644
> > --- a/drivers/platform/surface/aggregator/Kconfig
> > +++ b/drivers/platform/surface/aggregator/Kconfig
> > @@ -4,7 +4,7 @@
> > menuconfig SURFACE_AGGREGATOR
> > 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
> > 	depends on SERIAL_DEV_BUS
> > -	depends on ACPI
> > +	depends on ACPI && !RISCV
> 
> If you insist on doing this, at least make it some new config variable
> that’s self-documenting and means this automatically gets re-enabled
> when arch/riscv fixes this deficiency? Hard-coding arch lists like this
> seems like a terrible anti-pattern.
> 
I understand your point. But given that this is currently only issue with
a single driver from Microsoft and that too only in COMPILE_TEST builds,
I think introducing a new config variable is overkill. If we support
sub-word atomics in kernel, the option may not be useful much anyway.

There are patterns to disable an architecture for COMPILE_TEST builds.

Thanks,
Sunil
