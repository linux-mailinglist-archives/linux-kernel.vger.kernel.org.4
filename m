Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9969A7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBQJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjBQJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:07:52 -0500
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7F60A5E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:07:44 -0800 (PST)
Received: by mail-qv1-f47.google.com with SMTP id l4so593377qvv.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uETbKlrc042hse1IeL+66tEEBop9Jun/9u11FjpcZk=;
        b=U5bdszws4xEL+LMorPiJpdciOr71nKjIDdZZJ6oxpEbzJE8ty4Uzw2g1kZxkK/WmBn
         VpyrHqANsrIf5Heeo5X3B8FTG9sHaCFBHiMKt0wrzmrx4QUsq97z0SmqcIvJZ6biyvv0
         rYEpFRpow+5t5j4W8K/84qYrNSbY2qBaxMN3bvDfQSEqbVTfVoO7N7fsBjOXVv6cEvke
         7UV44Kv025uU6vNkpOCGL8tXskrm9GngSCCpTPCDP0DN1AtTWlqr4LWzW2yJYldx5pOY
         lM1AGVsJokHpv8AD98yFuuh0xxgOJ9qmWX+BN3js+yba8AlnXEMrsI1m8k7mm+Z3yyt7
         3iHw==
X-Gm-Message-State: AO0yUKWZrfMr/VB2cF9erk8qOyd2cuRXrLF6cHLGhwRlD7IkhqSTsNnr
        EwDRf+ZpofN3iuCVtmokWb6PJqgnFqI4ux+b
X-Google-Smtp-Source: AK7set8ymch/WaDDDfHhGTo6pLy85NR54Z25HBi3OZfiTvFYQEQ+axbQXyYSFDuVwZ3A0W5gCnB2Ag==
X-Received: by 2002:a05:6214:2526:b0:56e:a39f:f05f with SMTP id gg6-20020a056214252600b0056ea39ff05fmr16735403qvb.37.1676624863257;
        Fri, 17 Feb 2023 01:07:43 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 71-20020a37064a000000b006ff8a122a1asm2901434qkg.78.2023.02.17.01.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 01:07:42 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5338dd2813dso54097197b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:07:42 -0800 (PST)
X-Received: by 2002:a0d:f347:0:b0:4fc:962d:7dc1 with SMTP id
 c68-20020a0df347000000b004fc962d7dc1mr1001435ywf.301.1676624862400; Fri, 17
 Feb 2023 01:07:42 -0800 (PST)
MIME-Version: 1.0
References: <202302171144.sffQigLX-lkp@intel.com>
In-Reply-To: <202302171144.sffQigLX-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Feb 2023 10:07:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX3yhaqYo1bqN_AH3QFfiyMPwZ8TpiwzsAZTYML8ReFww@mail.gmail.com>
Message-ID: <CAMuHMdX3yhaqYo1bqN_AH3QFfiyMPwZ8TpiwzsAZTYML8ReFww@mail.gmail.com>
Subject: Re: drivers/iommu/io-pgtable-arm.c:330:8: error: instruction requires
 the following: RV64I Base Instruction Set
To:     kernel test robot <lkp@intel.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC linux-riscv

On Fri, Feb 17, 2023 at 4:50 AM kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3ac88fa4605ec98e545fb3ad0154f575fda2de5f
> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
> date:   3 months ago
> config: riscv-buildonly-randconfig-r003-20230216 (https://download.01.org/0day-ci/archive/20230217/202302171144.sffQigLX-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/iommu/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302171144.sffQigLX-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/iommu/io-pgtable-arm.c:330:8: error: instruction requires the following: RV64I Base Instruction Set
>            old = cmpxchg64_relaxed(ptep, curr, new);
>                  ^
>    include/linux/atomic/atomic-instrumented.h:1968:2: note: expanded from macro 'cmpxchg64_relaxed'
>            arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:60:32: note: expanded from macro 'arch_cmpxchg64_relaxed'
>    #define arch_cmpxchg64_relaxed arch_cmpxchg64
>                                   ^
>    arch/riscv/include/asm/cmpxchg.h:354:2: note: expanded from macro 'arch_cmpxchg64'
>            arch_cmpxchg((ptr), (o), (n));                                  \
>            ^
>    arch/riscv/include/asm/cmpxchg.h:344:23: note: expanded from macro 'arch_cmpxchg'
>            (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
>                                 ^
>    arch/riscv/include/asm/cmpxchg.h:324:4: note: expanded from macro '__cmpxchg'
>                            "0:     lr.d %0, %2\n"                          \
>                            ^
>    <inline asm>:1:5: note: instantiated into assembly here
>            0:      lr.d s4, 0(s0)
>                    ^

This is a bug in arch/riscv/include/asm/cmpxchg.h, which doesn't
cater for the CONFIG_32BIT=y case.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
