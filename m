Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7164A63B3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiK1VED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiK1VD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:03:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF6DD7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A0326145E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F4BC433B5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:03:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h3dsGgch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669669433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Pmv55RPnCG4l2lHUbbHHEDBfETYKEM/AVomrDQabnc=;
        b=h3dsGgch1F/rpHLWyHWx+8XvgOpy8JgRtpYd5s2jk4WGOhUsVTbV2Kx0J9sZ6gMg0RJQK4
        graU2ZEC3/uNAMBuBn7LMPDptbifTcK+yl1Gz2qdIVME4I+JRb0hg2oS3EXFo8cWM7LOu9
        XNDntxhP4YkusZPpSaZXCWHLTMbKPKU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be894ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Nov 2022 21:03:52 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id i11so10913781vsr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:03:52 -0800 (PST)
X-Gm-Message-State: ANoB5pnF6jEA71rQ1oEeLJCfqrcf2yeYnmRMjep9za95exhmsP6maF6S
        Td7oAcSRqo16isbcqtVRk0fopML7PUgAVyDz2UA=
X-Google-Smtp-Source: AA0mqf67tlrT4gkqTiCo80mAyNwqKpHDnqCupuRwJO1sNUNbI0DFNdUR7sH48GdK4BQBFFWlBU8oe//NxMY6q8/hhKQ=
X-Received: by 2002:a67:1d41:0:b0:3aa:3310:174 with SMTP id
 d62-20020a671d41000000b003aa33100174mr20087568vsd.70.1669669431958; Mon, 28
 Nov 2022 13:03:51 -0800 (PST)
MIME-Version: 1.0
References: <202211290400.IuVDsFIm-lkp@intel.com>
In-Reply-To: <202211290400.IuVDsFIm-lkp@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 22:03:41 +0100
X-Gmail-Original-Message-ID: <CAHmME9oO=8hsc4zt_oBrRoGm3sMU03W7cP5PksfC-RFmZumGLQ@mail.gmail.com>
Message-ID: <CAHmME9oO=8hsc4zt_oBrRoGm3sMU03W7cP5PksfC-RFmZumGLQ@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:crng/random/vdso 20/22] include/uapi/asm-generic/unistd.h:890:34:
 error: 'sys_vgetrandom_alloc' undeclared here (not in a function); did you
 mean 'sys_getrandom'?
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Please see below. It would seem that I can't so easily get rid of that
#ifdef __ARCH_HAS afterall?

Jason

On Mon, Nov 28, 2022 at 10:02 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block crng/random/vdso
> head:   8fef976bbd3ca01f0a15981443cc820505b293ba
> commit: f4df2f0833b1fee3096da7fa8d060faeb9f8ba89 [20/22] random: add vgetrandom_alloc() syscall
> config: arc-defconfig
> compiler: arc-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/f4df2f0833b1fee3096da7fa8d060faeb9f8ba89
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block crng/random/vdso
>         git checkout f4df2f0833b1fee3096da7fa8d060faeb9f8ba89
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>          |                                     ^~~~~~~~~
>    include/uapi/asm-generic/unistd.h:863:1: note: in expansion of macro '__SC_COMP'
>      863 | __SC_COMP(__NR_epoll_pwait2, sys_epoll_pwait2, compat_sys_epoll_pwait2)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:865:1: note: in expansion of macro '__SYSCALL'
>      865 | __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[442]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:865:1: note: in expansion of macro '__SYSCALL'
>      865 | __SYSCALL(__NR_mount_setattr, sys_mount_setattr)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:867:1: note: in expansion of macro '__SYSCALL'
>      867 | __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[443]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:867:1: note: in expansion of macro '__SYSCALL'
>      867 | __SYSCALL(__NR_quotactl_fd, sys_quotactl_fd)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:870:1: note: in expansion of macro '__SYSCALL'
>      870 | __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[444]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:870:1: note: in expansion of macro '__SYSCALL'
>      870 | __SYSCALL(__NR_landlock_create_ruleset, sys_landlock_create_ruleset)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:872:1: note: in expansion of macro '__SYSCALL'
>      872 | __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[445]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:872:1: note: in expansion of macro '__SYSCALL'
>      872 | __SYSCALL(__NR_landlock_add_rule, sys_landlock_add_rule)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:874:1: note: in expansion of macro '__SYSCALL'
>      874 | __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[446]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:874:1: note: in expansion of macro '__SYSCALL'
>      874 | __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:881:1: note: in expansion of macro '__SYSCALL'
>      881 | __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[448]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:881:1: note: in expansion of macro '__SYSCALL'
>      881 | __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:884:1: note: in expansion of macro '__SYSCALL'
>      884 | __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[449]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:884:1: note: in expansion of macro '__SYSCALL'
>      884 | __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:887:1: note: in expansion of macro '__SYSCALL'
>      887 | __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[450]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    include/uapi/asm-generic/unistd.h:887:1: note: in expansion of macro '__SYSCALL'
>      887 | __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>          | ^~~~~~~~~
> >> include/uapi/asm-generic/unistd.h:890:34: error: 'sys_vgetrandom_alloc' undeclared here (not in a function); did you mean 'sys_getrandom'?
>      890 | __SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
>          |                                  ^~~~~~~~~~~~~~~~~~~~
>    arch/arc/kernel/sys.c:13:37: note: in definition of macro '__SYSCALL'
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                     ^~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:44:1: note: in expansion of macro '__SYSCALL'
>       44 | __SYSCALL(__NR_cacheflush, sys_cacheflush)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[244]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:44:1: note: in expansion of macro '__SYSCALL'
>       44 | __SYSCALL(__NR_cacheflush, sys_cacheflush)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:45:1: note: in expansion of macro '__SYSCALL'
>       45 | __SYSCALL(__NR_arc_settls, sys_arc_settls)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[245]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:45:1: note: in expansion of macro '__SYSCALL'
>       45 | __SYSCALL(__NR_arc_settls, sys_arc_settls)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:46:1: note: in expansion of macro '__SYSCALL'
>       46 | __SYSCALL(__NR_arc_gettls, sys_arc_gettls)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[246]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:46:1: note: in expansion of macro '__SYSCALL'
>       46 | __SYSCALL(__NR_arc_gettls, sys_arc_gettls)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:47:1: note: in expansion of macro '__SYSCALL'
>       47 | __SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[248]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:47:1: note: in expansion of macro '__SYSCALL'
>       47 | __SYSCALL(__NR_arc_usr_cmpxchg, sys_arc_usr_cmpxchg)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
>       48 | __SYSCALL(__NR_sysfs, sys_sysfs)
>          | ^~~~~~~~~
>    arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[247]')
>       13 | #define __SYSCALL(nr, call) [nr] = (call),
>          |                                    ^
>    arch/arc/include/uapi/asm/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
>       48 | __SYSCALL(__NR_sysfs, sys_sysfs)
>          | ^~~~~~~~~
>
>
> vim +890 include/uapi/asm-generic/unistd.h
>
>    888
>    889  #define __NR_vgetrandom_alloc 451
>  > 890  __SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
>    891
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
