Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9396DC9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjDJRRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjDJRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6192111;
        Mon, 10 Apr 2023 10:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB0B86160D;
        Mon, 10 Apr 2023 17:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D1BC433D2;
        Mon, 10 Apr 2023 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681147035;
        bh=XAbXp0EbRQZU1hXmWf09pKmM5RRXeqSnlu79jGDc+YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIV8YXyDQ4JVDBq/e3QArmrKEAnskczTds6tSmGj9kFCn6gW/WHpcR7NCW3Prg4oA
         ugHxTDACEIzProTD+TACLVfL5BswAgUYLzs+AZvu+eUQTRvnEviniTOxqFQUMDCavN
         Qmkgb9HvV48y1qHrNS3YPDx/JibaFwd5+et6w9Jv3Vm5sjSqws8nlayvF1+Dx4g1zL
         HfIn7GNSK8vuC+SJPC9vWXkkYFZcQOKqSNy9SPegWbjyw9MiGujG8EwMdsNUq097d2
         m7fWT8/pj+KS+1vKQRH3o5U+RFTz8PtWkcBezNCOxic6puAaG5QVsVO9eVebcYS5OO
         nSQrh5+7kpW9w==
Date:   Mon, 10 Apr 2023 10:17:12 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
Message-ID: <20230410171712.GA177836@dev-arch.thelio-3990X>
References: <20230409145358.2538266-1-masahiroy@kernel.org>
 <202304100319.Wfcfuyqz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304100319.Wfcfuyqz-lkp@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:09:37AM +0800, kernel test robot wrote:
> Hi Masahiro,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on masahiroy-kbuild/for-next]
> [also build test WARNING on masahiroy-kbuild/fixes linus/master v6.3-rc6 next-20230406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-add-CLANG_CFLAGS-to-KBUILD_CPPFLAGS/20230409-225441
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> patch link:    https://lore.kernel.org/r/20230409145358.2538266-1-masahiroy%40kernel.org
> patch subject: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
> config: mips-ip22_defconfig (https://download.01.org/0day-ci/archive/20230410/202304100319.Wfcfuyqz-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/4a97e93c7f8c2aaf7bcca67a061264a1126d0e25
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Masahiro-Yamada/kbuild-add-CLANG_CFLAGS-to-KBUILD_CPPFLAGS/20230409-225441
>         git checkout 4a97e93c7f8c2aaf7bcca67a061264a1126d0e25
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304100319.Wfcfuyqz-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> clang: warning: argument unused during compilation: '-mno-check-zero-division' [-Wunused-command-line-argument]
>    clang: warning: argument unused during compilation: '-mabi=32' [-Wunused-command-line-argument]
> >> clang: warning: argument unused during compilation: '-G 0' [-Wunused-command-line-argument]
> >> clang: warning: argument unused during compilation: '-mno-abicalls' [-Wunused-command-line-argument]
>    error: unknown target CPU 'r5000'
>    note: valid target CPU values are: nocona, core2, penryn, bonnell, atom, silvermont, slm, goldmont, goldmont-plus, tremont, nehalem, corei7, westmere, sandybridge, corei7-avx, ivybridge, core-avx-i, haswell, core-avx2, broadwell, skylake, skylake-avx512, skx, cascadelake, cooperlake, cannonlake, icelake-client, rocketlake, icelake-server, tigerlake, sapphirerapids, alderlake, raptorlake, meteorlake, sierraforest, grandridge, graniterapids, emeraldrapids, knl, knm, k8, athlon64, athlon-fx, opteron, k8-sse3, athlon64-sse3, opteron-sse3, amdfam10, barcelona, btver1, btver2, bdver1, bdver2, bdver3, bdver4, znver1, znver2, znver3, znver4, x86-64, x86-64-v2, x86-64-v3, x86-64-v4

While r5000 is not a valid MIPS CPU for LLVM (as you can see from the
values below), the note here seems to imply that there is a place where
KBUILD_{A,C}FLAGS is used without KBUILD_CPPFLAGS because we are
dropping '--target'. V=1 does not make it obvious where that is
happening though, as I see the error right after syncing the
configuration (is it coming from Kconfig internally?). I can see the
same issue with 32r2_defconfig, which uses an LLVM supported CPU value.

>    scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>    scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>    scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>    error: unknown target CPU 'r5000'
>    note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5, mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2, mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
>    make[2]: *** [scripts/Makefile.build:252: scripts/mod/empty.o] Error 1
>    error: unknown target CPU 'r5000'
>    note: valid target CPU values are: mips1, mips2, mips3, mips4, mips5, mips32, mips32r2, mips32r3, mips32r5, mips32r6, mips64, mips64r2, mips64r3, mips64r5, mips64r6, octeon, octeon+, p5600
>    make[2]: *** [scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
>    make[2]: Target 'scripts/mod/' not remade because of errors.
>    make[1]: *** [Makefile:1285: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:226: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
