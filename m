Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4465AA4B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjAAPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAAPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:08:02 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E554DFC;
        Sun,  1 Jan 2023 07:08:01 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id r205so23149563oib.9;
        Sun, 01 Jan 2023 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ohd3QbAOCkwNSIdB5MDh3xUS2YPa36qFSrth4hkVgE=;
        b=EdVlnj5bcSTqgjpqbcbTJ7QeNP2svQKCLQmSmMEEhbWT6ogicoL9K4u8l0cgGP3N5f
         p6eSxYjGeRAWkoQSjCpUc+dn0UC38vfMsWOWFZxvu42KQrZFCfPJwI1w2R/2z9mswXyz
         1TPX8GGGapOuU6mIivABPXERv+TBLGQDE9x5bUY+wEJwQA6W2ZMA0IKFbYyRk4nKnVwT
         tRG6PrV6xtz9MTOWaKZpDjyd0XlJDdhZzdtxWZaLB3ELAIzyTkn+DVycVKZp/VuGlY2H
         w3An9EvdnkIXyQIX8Zt6ruRtvywbVlIxxHWTTjRdmLi2s7dNE2l/m92/OS2yCHgBqbk4
         Nc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ohd3QbAOCkwNSIdB5MDh3xUS2YPa36qFSrth4hkVgE=;
        b=ZkbFMPrlv4Q4dltBZOF4JnYlWPqoWWdW1DRp+4kU1+TIJBzO5Rop1He4KrWkK54Lvb
         t8oZIqfT3UW74F4bi4FHiDmVfgfzsMVTaTwyKCnozy5MGWKAgRea+IuBF3GT6kFV7JQh
         5keB6yP/Vk4aQOn6sXyS0udWhcMekVNay2Vtyn1qs3kN+pBYRY/x+opPCQEieinfi5ty
         AWNxgCrd8qqXIwrRs+qb9kEmG0TZv718xJbdphmIqtx3SD0rHNg7Owhacc9/MtpsIQVL
         LJisnSqBV1Ld0Y4txxO43Uf/piJA7GpiJCuGGWELmu2IGAUpTqbO4d+qmfeIEY3LMchG
         285w==
X-Gm-Message-State: AFqh2kq2KHIPumUBC1mZFOU3sScqwSpS2GtWj4SSHEiKQPzVJ/Psnstw
        mVwQPUHxZNmMO7qVO23t3k4=
X-Google-Smtp-Source: AMrXdXtO+inPETn8SZVmPG75DD3/aC/a47fQMoGQAl2A1QTbL0dPxC5UeNJkN2bgNrSfxyqoXpQzqQ==
X-Received: by 2002:a05:6808:19aa:b0:35c:3a6e:bc34 with SMTP id bj42-20020a05680819aa00b0035c3a6ebc34mr25511551oib.57.1672585680399;
        Sun, 01 Jan 2023 07:08:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c20-20020a544e94000000b00360f68d509csm11085822oiy.49.2023.01.01.07.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 07:07:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 Jan 2023 07:07:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Message-ID: <20230101150758.GA2736217@roeck-us.net>
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
 <20221231231451.GD2706156@roeck-us.net>
 <40718555-3c2e-f6b5-889a-0a1817ad39a0@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40718555-3c2e-f6b5-889a-0a1817ad39a0@wanadoo.fr>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 10:35:59AM +0100, Christophe JAILLET wrote:
> Le 01/01/2023 à 00:14, Guenter Roeck a écrit :
> > On Sat, Dec 31, 2022 at 12:07:27PM +0100, Christophe JAILLET wrote:
> > > The devm_clk_get_enabled() helper:
> > >     - calls devm_clk_get()
> > >     - calls clk_prepare_enable() and registers what is needed in order to
> > >       call clk_disable_unprepare() when needed, as a managed resource.
> > > 
> > > This simplifies the code and avoids the need of a dedicated function used
> > > with devm_add_action_or_reset().
> > > 
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Note that I get a compilation error because read_cpuid_id() is not defined
> > > on my system (x86_64).
> > > So I think that a "depends on ARM<something>" in missing in a KConfig file.
> > 
> > It has
> > 
> > 	depends on ARCH_IXP4XX
> > 
> > and CONFIG_IXP4XX_WATCHDOG is not set for me after "make allmodconfig".
> 
> Here is what  do.
> 
> make allmodconfig
> make -j8 drivers/watchdog/ixp4xx_wdt.o
> 
> And I get:
>   DESCEND objtool
>   CALL    scripts/checksyscalls.sh
>   CC      drivers/watchdog/ixp4xx_wdt.o
> drivers/watchdog/ixp4xx_wdt.c: In function ‘ixp4xx_wdt_probe’:
> drivers/watchdog/ixp4xx_wdt.c:122:15: error: implicit declaration of
> function ‘read_cpuid_id’ [-Werror=implicit-function-declaration]
>   122 |         if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
>       |               ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:252 : drivers/watchdog/ixp4xx_wdt.o]
> Erreur 1
> make[2]: *** [scripts/Makefile.build:504 : drivers/watchdog] Erreur 2
> make[1]: *** [scripts/Makefile.build:504 : drivers] Erreur 2
> make: *** [Makefile:2011 : .] Erreur 2
> 
> 
> I do agree with you that:
> 
>    - Kconfig looks fine
> config IXP4XX_WATCHDOG
> 	tristate "IXP4xx Watchdog"
> 	depends on ARCH_IXP4XX
> 
>   - Makefile looks fine
> obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
> 
>   - .config looks fine
> IXP4XX_WATCHDOG is NOT defined
> 
>   - make drivers/watchdog/ looks fine
> No error and ixp4xx_wdt.o is NOT built.
> 
> 
> However, in the past (if I recollect correctly :) ), a "make <something_that
> depends_on_a_config_variable_that_is_not_defined>" returned an error stating
> that no rule existed to build the specified target.
> 

This is not correct. It only applies if the target directory Makefile is
excluded by the make flags, or possibly if the target file is a complex
one build from various source files.

> I sometimes needed to tweak the Kconfig files to force some compilation when
> I didn't have the right tool chain or configuration.
> It was maybe not the best practice, but it worked most of the time.
> 
> 
> Now, with the example above, such a compilation attempt is possible. It is
> maybe normal (because of a change somewhere in the way the kernel is built,
> because of an updated toolchain on my machine, ...)
> This is just fine for me, but looked really surprising.
> 
> That is why I first thought that something was missing in a Kconfig file.
> 
> 
> So my comments are just a surprise to me to something that seems not to
> behave the same as before.
> 
I don't think anything changed. It always worked like that for me.
I would suggest to go back to an older kernel and try it there.
You'll see exactly the same error. Maybe you just never encountered
a file like that.

So, in other words, what you should have said is "not compile tested".
Alternatively, you could install cross compilers and compile test the
patches with those.

Thanks,
Guenter
