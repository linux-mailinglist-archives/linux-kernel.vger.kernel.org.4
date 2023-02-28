Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21176A54DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB1Iyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1Iyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:54:36 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F723AB9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:54:29 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id c3so5352807qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb3IIwM5cWKMgUfUae3s9VpNxrsAOzN4EV8qoFX5iTc=;
        b=1JjUOKuAzwrdfQwgPypwEW45YNYGB56YYqK+Ih8SGzPhXe4bFSx5x/X78IDDaUv/qH
         Ag/lgjgxKcMG4ahqSXtx1vD+gaMLVrUsr6kVlcRImQSN+C4x+d5AHz/h/A//pkT1Dw4I
         XXXZYuM7ABVHNGtLf7JZQqq/RsSuiqlNmxbiC98zWmp6ZBm/FQdCrPPS+DY1U6/N/CKm
         a9M+QzL1IgYMu1g2VNp7ZQjjVZV6kCYaxRinmcHveOHasH/MsHpHhHYGeiF+8pjs7OEB
         z3gKEQaXCrOnsykRA4HJ/QhPCN1369EUk4Cg3ptUL7C9oiab0llyEOpK2J3cEk7DaTvR
         xKMA==
X-Gm-Message-State: AO0yUKXJxLLy2dCFTtKGnHBil4bTwSMzcP6ExPs5RYrbj3NGuJwPw2y+
        fxwRvUsaDp2bB9shU6dPrRN7+S5F3oxIKw==
X-Google-Smtp-Source: AK7set/z9DAsRktkE4JFV1QCvXxF2d7N8WkPFvJwPXfde91pZIffHMbjEQ8iMdkFphHdg+EcSeV/Kw==
X-Received: by 2002:ac8:5b85:0:b0:3b9:bc8c:c1fb with SMTP id a5-20020ac85b85000000b003b9bc8cc1fbmr20137502qta.6.1677574468347;
        Tue, 28 Feb 2023 00:54:28 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id j129-20020a37b987000000b0074233b15a72sm6462711qkf.116.2023.02.28.00.54.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:54:28 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-536c2a1cc07so251498957b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:54:27 -0800 (PST)
X-Received: by 2002:a05:6902:50e:b0:967:f8b2:7a42 with SMTP id
 x14-20020a056902050e00b00967f8b27a42mr801424ybs.7.1677574467597; Tue, 28 Feb
 2023 00:54:27 -0800 (PST)
MIME-Version: 1.0
References: <202302280619.kO2cWoIT-lkp@intel.com> <CAMuHMdX0ufx4FaoXR8ai53xeact4DC4HNhA8N6KwoOsw3yUMOg@mail.gmail.com>
In-Reply-To: <CAMuHMdX0ufx4FaoXR8ai53xeact4DC4HNhA8N6KwoOsw3yUMOg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 09:54:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWxROeSg8dNdDUusyWfPQhUpEy5UipZXY9mA2x=weQ=6A@mail.gmail.com>
Message-ID: <CAMuHMdWxROeSg8dNdDUusyWfPQhUpEy5UipZXY9mA2x=weQ=6A@mail.gmail.com>
Subject: Re: include/asm-generic/div64.h:238:36: error: passing argument 1 of
 '__div64_32' from incompatible pointer type
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC new-Bjorn.

On Tue, Feb 28, 2023 at 9:52 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Feb 27, 2023 at 11:33 PM kernel test robot <lkp@intel.com> wrote:
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   982818426a0ffaf93b0621826ed39a84be3d7d62
> > commit: 29e8142b5623b5949587bcc4f591c4e6595c4aca power: supply: Introduce Qualcomm PMIC GLINK power supply
> > date:   2 weeks ago
> > config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230228/202302280619.kO2cWoIT-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29e8142b5623b5949587bcc4f591c4e6595c4aca
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 29e8142b5623b5949587bcc4f591c4e6595c4aca
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202302280619.kO2cWoIT-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from ./arch/arc/include/generated/asm/div64.h:1,
> >                     from include/linux/math.h:6,
> >                     from include/linux/math64.h:6,
> >                     from include/linux/time64.h:5,
> >                     from include/linux/restart_block.h:10,
> >                     from include/linux/thread_info.h:14,
> >                     from include/asm-generic/preempt.h:5,
> >                     from ./arch/arc/include/generated/asm/preempt.h:1,
> >                     from include/linux/preempt.h:78,
> >                     from include/linux/rcupdate.h:27,
> >                     from include/linux/rculist.h:11,
> >                     from include/linux/pid.h:5,
> >                     from include/linux/sched.h:14,
> >                     from include/linux/ratelimit.h:6,
> >                     from include/linux/dev_printk.h:16,
> >                     from include/linux/device.h:15,
> >                     from include/linux/auxiliary_bus.h:11,
> >                     from drivers/power/supply/qcom_battmgr.c:6:
> >    drivers/power/supply/qcom_battmgr.c: In function 'qcom_battmgr_sm8350_callback':
> >    include/asm-generic/div64.h:222:35: warning: comparison of distinct pointer types lacks a cast
> >      222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
> >          |                                   ^~
> >    drivers/power/supply/qcom_battmgr.c:1130:25: note: in expansion of macro 'do_div'
> >     1130 |                         do_div(battmgr->status.percent, 100);
> >          |                         ^~~~~~
> >    In file included from include/linux/dev_printk.h:14:
> >    include/asm-generic/div64.h:234:32: warning: right shift count >= width of type [-Wshift-count-overflow]
> >      234 |         } else if (likely(((n) >> 32) == 0)) {          \
> >          |                                ^~
> >    include/linux/compiler.h:77:45: note: in definition of macro 'likely'
> >       77 | # define likely(x)      __builtin_expect(!!(x), 1)
> >          |                                             ^
> >    drivers/power/supply/qcom_battmgr.c:1130:25: note: in expansion of macro 'do_div'
> >     1130 |                         do_div(battmgr->status.percent, 100);
> >          |                         ^~~~~~
> > >> include/asm-generic/div64.h:238:36: error: passing argument 1 of '__div64_32' from incompatible pointer type [-Werror=incompatible-pointer-types]
> >      238 |                 __rem = __div64_32(&(n), __base);       \
> >          |                                    ^~~~
> >          |                                    |
> >          |                                    unsigned int *
> >    drivers/power/supply/qcom_battmgr.c:1130:25: note: in expansion of macro 'do_div'
> >     1130 |                         do_div(battmgr->status.percent, 100);
> >          |                         ^~~~~~
> >    include/asm-generic/div64.h:213:38: note: expected 'uint64_t *' {aka 'long long unsigned int *'} but argument is of type 'unsigned int *'
> >      213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
> >          |                            ~~~~~~~~~~^~~~~~~~
> >    cc1: some warnings being treated as errors
>
> Fix available for two weeks:
> https://lore.kernel.org/all/20230214132052.1556699-1-arnd@kernel.org

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
