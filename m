Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EC6CB2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC1BEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjC1BEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C41719AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85226B819F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 01:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A9C433EF;
        Tue, 28 Mar 2023 01:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679965445;
        bh=JWSGR4a2icSu2QaXHUWngJJ6THkXtH+tJdpGRgn3Aes=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XEQqMkVr1VnuSEK2k3DZzSTDr89UzY8kMw+Hb9ziMPlO0sRkiIYzQzMhmyowzj7Ju
         V52mlQJ6QJFj1GIv217tAYkdftpMzjGNNLrXYhuNsRGjLMKWC4UOvhKQ6cVMfAplYt
         L6/L5Qbo9wRGxInBM5hGsO3uU03jI3MO2OZK5+xE0VR32zEp+QpruNTrNmT3nzQ+j/
         hZTwsTLmsF7j1r5VBkct7PeUOsEL2glpBHjTRXZLrNFluundYH/Gan745/tRwFapAw
         p6wBESRoXzfBiSyfisdU3oJI00aBHajYd62yj2TnNfZ3beDqKH17m4/O6s/nXQhhWS
         EDXZPLlng35fA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E4730154039B; Mon, 27 Mar 2023 18:04:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:04:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:srcu-cf.2023.03.26a 4/20]
 kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member
 named 'srcu_gp_seq_needed'
Message-ID: <38d0a0c3-2e24-45df-a2d7-861073fd2273@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202303271532.p78iYvzM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303271532.p78iYvzM-lkp@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:39:10PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git srcu-cf.2023.03.26a
> head:   9607cde099a20296cf0234f571d60184f277aa37
> commit: 428843e3b2f64d472d38f68968c532acafe42490 [4/20] srcu: Begin offloading srcu_struct fields to srcu_update
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230327/202303271532.p78iYvzM-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=428843e3b2f64d472d38f68968c532acafe42490
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu srcu-cf.2023.03.26a
>         git checkout 428843e3b2f64d472d38f68968c532acafe42490
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/rcu/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303271532.p78iYvzM-lkp@intel.com/
> 
> Note: the paulmck-rcu/srcu-cf.2023.03.26a HEAD 9607cde099a20296cf0234f571d60184f277aa37 builds fine.
>       It only hurts bisectability.

Good catch!  Branch srcu-cf.2023.03.27b should have this straightened out.

Looks like I squashed some fixes into the wrong commits...

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/list.h:11,
>                     from include/linux/mutex.h:15,
>                     from kernel/rcu/srcutree.c:19:
>    kernel/rcu/srcutree.c: In function 'srcu_module_going':
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    arch/powerpc/include/asm/barrier.h:81:17: note: in definition of macro '__smp_load_acquire'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                 ^
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
>    In file included from <command-line>:
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |                            ^~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
>       36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
>       49 |         compiletime_assert_rwonce_type(x);                              \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:353:27: note: in definition of macro '__unqual_scalar_typeof'
>      353 |                 _Generic((x),                                           \
>          |                           ^
>    include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
>       50 |         __READ_ONCE(x);                                                 \
>          |         ^~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
>    In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>                     from include/linux/compiler.h:247,
>                     from include/linux/build_bug.h:5,
>                     from include/linux/container_of.h:5,
>                     from include/linux/list.h:5:
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
>       44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
>          |                                                                         ^
>    arch/powerpc/include/asm/barrier.h:81:28: note: in expansion of macro 'READ_ONCE'
>       81 |         typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          |                            ^~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |                            ^~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
>       82 |         compiletime_assert_atomic_type(*p);                             \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |                            ^~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
>       82 |         compiletime_assert_atomic_type(*p);                             \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |                            ^~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
>       82 |         compiletime_assert_atomic_type(*p);                             \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
> >> kernel/rcu/srcutree.c:1907:67: error: 'struct srcu_usage' has no member named 'srcu_gp_seq_needed'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                                                   ^~
>    include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
>      377 |                 if (!(condition))                                       \
>          |                       ^~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:9: note: in expansion of macro 'compiletime_assert'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |         ^~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:400:28: note: in expansion of macro '__native_word'
>      400 |         compiletime_assert(__native_word(t),                            \
>          |                            ^~~~~~~~~~~~~
>    arch/powerpc/include/asm/barrier.h:82:9: note: in expansion of macro 'compiletime_assert_atomic_type'
>       82 |         compiletime_assert_atomic_type(*p);                             \
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/asm-generic/barrier.h:176:29: note: in expansion of macro '__smp_load_acquire'
>      176 | #define smp_load_acquire(p) __smp_load_acquire(p)
>          |                             ^~~~~~~~~~~~~~~~~~
>    kernel/rcu/srcutree.c:1907:36: note: in expansion of macro 'smp_load_acquire'
>     1907 |                 if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
>          |                                    ^~~~~~~~~~~~~~~~
>    In file included from arch/powerpc/include/asm/bug.h:159,
>                     from include/linux/bug.h:5,
>                     from include/linux/fortify-string.h:5,
>                     from include/linux/string.h:254,
>                     from include/linux/bitmap.h:11,
>                     from include/linux/cpumask.h:12,
>                     from include/linux/smp.h:13,
>                     from include/linux/lockdep.h:14,
>                     from include/linux/mutex.h:17:
> >> kernel/rcu/srcutree.c:1908:49: error: 'struct srcu_usage' has no member named 'sda_is_static'
>     1908 |                     !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
>          |                                                 ^~
>    include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
>      110 |         int __ret_warn_on = !!(condition);                      \
>          |                                ^~~~~~~~~
> 
> 
> vim +1907 kernel/rcu/srcutree.c
> 
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1897  
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1898  /* Clean up any global-scope srcu_struct structures used by this module. */
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1899  static void srcu_module_going(struct module *mod)
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1900  {
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1901  	int i;
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1902  	struct srcu_struct *ssp;
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1903  	struct srcu_struct **sspp = mod->srcu_struct_ptrs;
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1904  
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1905  	for (i = 0; i < mod->num_srcu_structs; i++) {
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1906  		ssp = *(sspp++);
> 7a8ec79485d274 Paul E. McKenney 2023-03-17 @1907  		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
> 7a8ec79485d274 Paul E. McKenney 2023-03-17 @1908  		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1909  			cleanup_srcu_struct(ssp);
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1910  		free_percpu(ssp->sda);
> 7a8ec79485d274 Paul E. McKenney 2023-03-17  1911  	}
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1912  }
> fe15b50cdeeebd Paul E. McKenney 2019-04-05  1913  
> 
> :::::: The code at line 1907 was first introduced by commit
> :::::: 7a8ec79485d27415fdc6ffb5bcb2d71626e3c8fb srcu: Use static init for statically allocated in-module srcu_struct
> 
> :::::: TO: Paul E. McKenney <paulmck@kernel.org>
> :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
