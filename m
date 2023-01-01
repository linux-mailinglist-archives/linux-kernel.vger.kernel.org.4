Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C1D65AB32
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjAATb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAATbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:31:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C81D0;
        Sun,  1 Jan 2023 11:31:21 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r205so23507932oib.9;
        Sun, 01 Jan 2023 11:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUsoeI0t+F0M1VicIeLkR8DGI83Y71KjS4VXtx/g3NI=;
        b=hts3Wm8n/WK1pYKdiL3FrX04vC+q8tQUpRqhXr0ztW4WB+usmv6ChqbjKkmO/76521
         rj9/blMBQvHvvR4n/805KqvJD+6lodQeM9oJBT7q7ww0r19bbt9Lp63Xk6Db01dKFf1E
         P4CaIWzc7c8kqAIU1Kvu0ZiCSZtkyNLOihAtaDM51iq5JdMS95V5qqSDPcMmmEfcaak2
         mz4gEEq3HmLfZiogSR7UqeMm6d9WIUaAeTSe/azUc0OkS2v99ylnPd5pkk93zP4b7fjM
         3BLMr974OisdvJ8bJHMZqcrxSbMlGMyKdKtpm/t6FncGTxzFoa4vFYo7vrHVdBc2vjWJ
         xZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUsoeI0t+F0M1VicIeLkR8DGI83Y71KjS4VXtx/g3NI=;
        b=l+AkB0NzlP+C5M3aF31MORSA/QlAIuqsoZMYpQNR9GJakaspqZhcYTe0uk/iqjdtGe
         ZgW2101Cz9h4kopzYu2HE9uQh6rwm2qQODfyPR2tFs4nCkGK93yOcXeCPHlGk9+veeyk
         0e8Z3zFqF3JqYnsqSryN/8lkHP4rBts0DbyDuF9/cwA+rYcnqMbUlsPzrQK45FdFihQl
         SOkD1v3LlyhXGYzFPPxdB23a4YWwgXFPXZt0R7q/707UeQ2oJduiqiDY5H+CVulAFkhd
         FSzeNaZVVc+VlKEnUlqToaqlbxR8hwibGgh+viOzBMNsPJOMcUnEUVvza7FJjPLx+S1p
         4ASA==
X-Gm-Message-State: AFqh2kqrLY9jqLMXGZ709SPOJyoTzyCkhupDHeXdtNohXXOVDOi2Uf80
        uppDAsJ3X3POCIh15kPaf1TS61UJJqw=
X-Google-Smtp-Source: AMrXdXvl4B0hCCQFzARIcVmNWlWCWYFsxyxu/AwNnyDzovJoD5nMsH8TMYWShFZ4ij7asuvXLhzewQ==
X-Received: by 2002:a05:6808:107:b0:360:fce9:a7f7 with SMTP id b7-20020a056808010700b00360fce9a7f7mr16393660oie.45.1672601480721;
        Sun, 01 Jan 2023 11:31:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9-20020a544f09000000b0035aa617156bsm11392294oiy.17.2023.01.01.11.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:31:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 1 Jan 2023 11:31:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] watchdog: ixp4xx: Use devm_clk_get_enabled() helper
Message-ID: <20230101193118.GA2769955@roeck-us.net>
References: <5d04e453a4da5cfafb56695a17157fa3ea296511.1672484831.git.christophe.jaillet@wanadoo.fr>
 <20221231231451.GD2706156@roeck-us.net>
 <40718555-3c2e-f6b5-889a-0a1817ad39a0@wanadoo.fr>
 <20230101150758.GA2736217@roeck-us.net>
 <401d3328-8da0-056b-8b32-d890bd5508b4@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <401d3328-8da0-056b-8b32-d890bd5508b4@wanadoo.fr>
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

On Sun, Jan 01, 2023 at 06:52:35PM +0100, Christophe JAILLET wrote:
[ ... ]
> > > 
> > > Here is what  do.
> > > 
> > > make allmodconfig
> > > make -j8 drivers/watchdog/ixp4xx_wdt.o
> > > 
> > > And I get:
> > >    DESCEND objtool
> > >    CALL    scripts/checksyscalls.sh
> > >    CC      drivers/watchdog/ixp4xx_wdt.o
> > > drivers/watchdog/ixp4xx_wdt.c: In function ‘ixp4xx_wdt_probe’:
> > > drivers/watchdog/ixp4xx_wdt.c:122:15: error: implicit declaration of
> > > function ‘read_cpuid_id’ [-Werror=implicit-function-declaration]
> > >    122 |         if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
> > >        |               ^~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > make[3]: *** [scripts/Makefile.build:252 : drivers/watchdog/ixp4xx_wdt.o]
> > > Erreur 1
> > > make[2]: *** [scripts/Makefile.build:504 : drivers/watchdog] Erreur 2
> > > make[1]: *** [scripts/Makefile.build:504 : drivers] Erreur 2
> > > make: *** [Makefile:2011 : .] Erreur 2
> > > 
> > > 
> > > I do agree with you that:
> > > 
> > >     - Kconfig looks fine
> > > config IXP4XX_WATCHDOG
> > > 	tristate "IXP4xx Watchdog"
> > > 	depends on ARCH_IXP4XX
> > > 
> > >    - Makefile looks fine
> > > obj-$(CONFIG_IXP4XX_WATCHDOG) += ixp4xx_wdt.o
> > > 
> > >    - .config looks fine
> > > IXP4XX_WATCHDOG is NOT defined
> > > 
> > >    - make drivers/watchdog/ looks fine
> > > No error and ixp4xx_wdt.o is NOT built.
> > > 
> > > 
> > > However, in the past (if I recollect correctly :) ), a "make <something_that
> > > depends_on_a_config_variable_that_is_not_defined>" returned an error stating
> > > that no rule existed to build the specified target.
> > > 
> > 
> > This is not correct. It only applies if the target directory Makefile is
> > excluded by the make flags, or possibly if the target file is a complex
> > one build from various source files.
> > 
> > > I sometimes needed to tweak the Kconfig files to force some compilation when
> > > I didn't have the right tool chain or configuration.
> > > It was maybe not the best practice, but it worked most of the time.
> > > 
> > > 
> > > Now, with the example above, such a compilation attempt is possible. It is
> > > maybe normal (because of a change somewhere in the way the kernel is built,
> > > because of an updated toolchain on my machine, ...)
> > > This is just fine for me, but looked really surprising.
> > > 
> > > That is why I first thought that something was missing in a Kconfig file.
> > > 
> > > 
> > > So my comments are just a surprise to me to something that seems not to
> > > behave the same as before.
> > > 
> > I don't think anything changed. It always worked like that for me.
> > I would suggest to go back to an older kernel and try it there.
> > You'll see exactly the same error. Maybe you just never encountered
> > a file like that.
> 
> git reset --hard next-20210111			(randomly chosen date)
> make allmodconfig
> make clean
> make -j7 drivers/watchdog/ixp4xx_wdt.o		(too build most of the needed stuff
> to build a kernel)
> touch drivers/watchdog/ixp4xx_wdt.c
> make -j7 drivers/watchdog/ixp4xx_wdt.o		(too build this file only)
> 
>   DESCEND  objtool
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
> make[3]: *** Aucune règle pour fabriquer la cible «
> drivers/watchdog/ixp4xx_wdt.o ». Arrêt.
> make[2]: *** [scripts/Makefile.build:471 : __build] Erreur 2
> make[1]: *** [scripts/Makefile.build:496 : drivers/watchdog] Erreur 2
> make: *** [Makefile:1805 : drivers] Erreur 2
> 

Turns out the behavior preferred by you was introduced in v5.4 with
commit 394053f4a4b3 ("kbuild: make single targets work more correctly")
and undone with commit cc306abd19e8 ("kbuild: fix and refactor single
target build") in v6.1. As for what is the expected behavior, I can't say.
I for my part had not noticed that the behavior had changed between v5.4
and v6.0.

I would suggest to discuss details with Yamada-san.

Thanks,
Guenter
