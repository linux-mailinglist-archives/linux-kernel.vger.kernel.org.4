Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066006FC89C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbjEIOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjEIOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089440C8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 07:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D213262DDD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF6AC433D2;
        Tue,  9 May 2023 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683641695;
        bh=b7qinGsokY9iix4atLNK0hA47cPHGwDgBptezSWregE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HI1Ux9Bf0YNdTwiAsNoW2mmYIKhU96WFqIFw40Jo8kydxgO40LJHjC2VoFRkJqYbr
         bA8hRwqnLuWoNLkZ3ji6q2GFSNGTZm8IW29WJ+ZIn4rcHhC8LJOwrj7PQRcDogwBAv
         N1T3PQcWftHHfqpSFW776Hobm5dUpFDUcYVAs35vDToU+cL5lp4/0KCt9xDnn/LRxn
         EfIf7ZjqHZwvSln5yyGAwedBnUEq2byNhcbvgfVOq7gvOzVC+Khtbn84jIBD7sKPnK
         RTi4tdKfWty+X90MKPM03jI0jFquIpNRZGjrnICTJ2TP1CoLUQ/dNVpOAzf/iJIuet
         yvpaWVbgsbneA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 82F67CE18EF; Tue,  9 May 2023 07:14:54 -0700 (PDT)
Date:   Tue, 9 May 2023 07:14:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.05.08b 71/71]
 include/linux/atomic/atomic-arch-fallback.h:2673:36: error: implicit
 declaration of function 'arch_atomic64_fetch_andnot'; did you mean
 'arch_atomic64_fetch_and'?
Message-ID: <f1d8d2a3-bfa0-4686-82fe-90a552327953@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202305091109.X5CYSNZ4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305091109.X5CYSNZ4-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 11:50:59AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.05.08b
> head:   46be07e0c635f84a3ce3a6d2d841785872bf59c9
> commit: 46be07e0c635f84a3ce3a6d2d841785872bf59c9 [71/71] locking/atomic: Refrain from generating duplicate fallbacks
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230509/202305091109.X5CYSNZ4-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=46be07e0c635f84a3ce3a6d2d841785872bf59c9
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2023.05.08b
>         git checkout 46be07e0c635f84a3ce3a6d2d841785872bf59c9
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305091109.X5CYSNZ4-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>    In file included from <command-line>:
> >> include/linux/compiler_types.h:369:9: error: expected identifier or '(' before 'do'
>      369 |         do {                                                            \
>          |         ^~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~

Hilarious!!!

Will fix, omitting only the kernel-doc.  In this case, I am not seeing
why the earlier definition did not take, but in general, yes, the #ifdefs
might end up needing a later definition, depending on exactly what set
is supplied by the architecture at hand.

							Thanx, Paul

>    include/linux/atomic/atomic-arch-fallback.h:1105:1: note: in expansion of macro 'BUILD_BUG_ON'
>     1105 | BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic_fetch_andnot_acquire().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:1105:1: note: in expansion of macro 'BUILD_BUG_ON'
>     1105 | BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic_fetch_andnot_acquire().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:1110:1: note: in expansion of macro 'BUILD_BUG_ON'
>     1110 | BUILD_BUG_ON(1) // Fallback release omitting duplicate arch_atomic_fetch_andnot_release().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:1115:1: note: in expansion of macro 'BUILD_BUG_ON'
>     1115 | BUILD_BUG_ON(1) // Fallback fence omitting duplicate arch_atomic_fetch_andnot().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:369:9: error: expected identifier or '(' before 'do'
>      369 |         do {                                                            \
>          |         ^~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2662:1: note: in expansion of macro 'BUILD_BUG_ON'
>     2662 | BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic64_fetch_andnot_acquire().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2662:1: note: in expansion of macro 'BUILD_BUG_ON'
>     2662 | BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic64_fetch_andnot_acquire().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2667:1: note: in expansion of macro 'BUILD_BUG_ON'
>     2667 | BUILD_BUG_ON(1) // Fallback release omitting duplicate arch_atomic64_fetch_andnot_release().
>          | ^~~~~~~~~~~~
> >> include/linux/compiler_types.h:379:11: error: expected identifier or '(' before 'while'
>      379 |         } while (0)
>          |           ^~~~~
>    include/linux/compiler_types.h:385:9: note: in expansion of macro '__compiletime_assert'
>      385 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2672:1: note: in expansion of macro 'BUILD_BUG_ON'
>     2672 | BUILD_BUG_ON(1) // Fallback fence omitting duplicate arch_atomic64_fetch_andnot().
>          | ^~~~~~~~~~~~
>    In file included from include/linux/atomic.h:80,
>                     from include/linux/rcupdate.h:25,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from arch/alpha/kernel/asm-offsets.c:10:
>    include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_andnot':
> >> include/linux/atomic/atomic-arch-fallback.h:2673:36: error: implicit declaration of function 'arch_atomic64_fetch_andnot'; did you mean 'arch_atomic64_fetch_and'? [-Werror=implicit-function-declaration]
>     2673 | #define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-long.h:305:16: note: in expansion of macro 'arch_atomic64_fetch_andnot'
>      305 |         return arch_atomic64_fetch_andnot(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_andnot_acquire':
> >> include/linux/atomic/atomic-arch-fallback.h:2663:44: error: implicit declaration of function 'arch_atomic64_fetch_andnot_acquire'; did you mean 'arch_atomic64_fetch_and_acquire'? [-Werror=implicit-function-declaration]
>     2663 | #define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2663:44: note: in definition of macro 'arch_atomic64_fetch_andnot_acquire'
>     2663 | #define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_andnot_release':
> >> include/linux/atomic/atomic-arch-fallback.h:2668:44: error: implicit declaration of function 'arch_atomic64_fetch_andnot_release'; did you mean 'arch_atomic64_fetch_and_release'? [-Werror=implicit-function-declaration]
>     2668 | #define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-arch-fallback.h:2668:44: note: in definition of macro 'arch_atomic64_fetch_andnot_release'
>     2668 | #define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
>          |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-long.h: In function 'arch_atomic_long_fetch_or_acquire':
> >> include/linux/atomic/atomic-arch-fallback.h:2700:40: error: implicit declaration of function 'arch_atomic64_fetch_or_acquire'; did you mean 'arch_atomic64_fetch_xor_acquire'? [-Werror=implicit-function-declaration]
>     2700 | #define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
>          |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-long.h:341:16: note: in expansion of macro 'arch_atomic64_fetch_or_acquire'
>      341 |         return arch_atomic64_fetch_or_acquire(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h: In function 'atomic_fetch_andnot':
> >> include/linux/atomic/atomic-arch-fallback.h:1116:34: error: implicit declaration of function 'arch_atomic_fetch_andnot'; did you mean 'arch_atomic_fetch_and'? [-Werror=implicit-function-declaration]
>     1116 | #define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:370:16: note: in expansion of macro 'arch_atomic_fetch_andnot'
>      370 |         return arch_atomic_fetch_andnot(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h: In function 'atomic_fetch_andnot_acquire':
> >> include/linux/atomic/atomic-arch-fallback.h:1106:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_acquire'; did you mean 'arch_atomic_fetch_and_acquire'? [-Werror=implicit-function-declaration]
>     1106 | #define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
>          |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:377:16: note: in expansion of macro 'arch_atomic_fetch_andnot_acquire'
>      377 |         return arch_atomic_fetch_andnot_acquire(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h: In function 'atomic_fetch_andnot_release':
> >> include/linux/atomic/atomic-arch-fallback.h:1111:42: error: implicit declaration of function 'arch_atomic_fetch_andnot_release'; did you mean 'arch_atomic_fetch_and_release'? [-Werror=implicit-function-declaration]
>     1111 | #define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
>          |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:385:16: note: in expansion of macro 'arch_atomic_fetch_andnot_release'
>      385 |         return arch_atomic_fetch_andnot_release(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h: In function 'atomic_fetch_or_acquire':
> >> include/linux/atomic/atomic-arch-fallback.h:1143:38: error: implicit declaration of function 'arch_atomic_fetch_or_acquire'; did you mean 'arch_atomic_fetch_xor_acquire'? [-Werror=implicit-function-declaration]
>     1143 | #define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
>          |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/atomic/atomic-instrumented.h:414:16: note: in expansion of macro 'arch_atomic_fetch_or_acquire'
>      414 |         return arch_atomic_fetch_or_acquire(i, v);
>          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/alpha/kernel/asm-offsets.c: At top level:
>    arch/alpha/kernel/asm-offsets.c:15:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
>       15 | void foo(void)
>          |      ^~~
>    cc1: some warnings being treated as errors
>    make[2]: *** [scripts/Makefile.build:114: arch/alpha/kernel/asm-offsets.s] Error 1
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:1287: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +2673 include/linux/atomic/atomic-arch-fallback.h
> 
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2660  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2661  #ifndef arch_atomic64_fetch_andnot_acquire
> 46be07e0c635f8 include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-08  2662  BUILD_BUG_ON(1) // Fallback acquire omitting duplicate arch_atomic64_fetch_andnot_acquire().
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24 @2663  #define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2664  #endif
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2665  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2666  #ifndef arch_atomic64_fetch_andnot_release
> 46be07e0c635f8 include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-08  2667  BUILD_BUG_ON(1) // Fallback release omitting duplicate arch_atomic64_fetch_andnot_release().
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24 @2668  #define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2669  #endif
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2670  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2671  #ifndef arch_atomic64_fetch_andnot
> 46be07e0c635f8 include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-08  2672  BUILD_BUG_ON(1) // Fallback fence omitting duplicate arch_atomic64_fetch_andnot().
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24 @2673  #define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2674  #endif
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2675  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2676  #endif /* arch_atomic64_fetch_andnot_relaxed */
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2677  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2678  #ifndef arch_atomic64_fetch_or_relaxed
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2679  #define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2680  #define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2681  #define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2682  #else /* arch_atomic64_fetch_or_relaxed */
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2683  
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2684  #ifndef arch_atomic64_fetch_or_acquire
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2685  /**
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2686   * arch_atomic64_fetch_or_acquire - Atomic or with acquire ordering
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2687   * @i: value to OR
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2688   * @v: pointer of type atomic64_t
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2689   *
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2690   * Atomically OR @i with @v using acquire ordering.
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2691   * Return old value.
> 8148ee76cbe7ad include/linux/atomic/atomic-arch-fallback.h Paul E. McKenney 2023-05-02  2692   */
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2693  static __always_inline s64
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2694  arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2695  {
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2696  	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2697  	__atomic_acquire_fence();
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2698  	return ret;
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2699  }
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24 @2700  #define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2701  #endif
> 37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra   2020-01-24  2702  
> 
> :::::: The code at line 2673 was first introduced by commit
> :::::: 37f8173dd84936ea78000ed1cad24f8b18d48ebb locking/atomics: Flip fallbacks and instrumentation
> 
> :::::: TO: Peter Zijlstra <peterz@infradead.org>
> :::::: CC: Thomas Gleixner <tglx@linutronix.de>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
