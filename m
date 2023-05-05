Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810F76F8C46
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEEWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjEEWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:12:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A046A6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683324750; x=1714860750;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6w3EnoLYcjYzCP36Z68hnkauw/xTpYgW7xplEoywr+c=;
  b=NtP7uCXanBYBQZoJMSbLPXvQZzAqu6Q9RupEABHbKpRVPUgXbjnultw8
   p7p7iLArIqWrbum/olYnEtfdPGZVCDVCyw+uO5Scs5eUtLBB0icZ3vARh
   0+Dqb6zbh/yi2nRjPP22kU9vEw/4/iYsVSvek4t3Cpt0lm7wFvFjPKyQr
   /fDvDGxW/r85XE0LSboljUxbvd5u3cb3SUl/kuOcaEPI2oLz3Ly6rmG58
   j6H4AEEgvI9/8fwNaMWd5f8PjBHQGM7pbFyi6G6q3O4XGFJNGz8gS035B
   VbLHcXj8bYlbgsmzOIeUbw6JSlrRT1M765vtk5rmgFksPUxwmjSjeqqPT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="329660585"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="329660585"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700631341"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="700631341"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2023 15:12:28 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pv3fA-0000t9-0k;
        Fri, 05 May 2023 22:12:28 +0000
Date:   Sat, 6 May 2023 06:12:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Christopher M. Riedl" <cmr@bluescreens.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: include/linux/compiler_types.h:357:45: error: call to
 '__compiletime_assert_181' declared with attribute error: BUILD_BUG failed
Message-ID: <202305060648.EjkrACfJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7163a2111f6c030ee39635ac3334bfa1a52a3dd3
commit: c28c15b6d28a776538482101522cbcd9f906b15c powerpc/code-patching: Use temporary mm for Radix MMU
date:   5 months ago
config: powerpc-randconfig-r031-20230505 (https://download.01.org/0day-ci/archive/20230506/202305060648.EjkrACfJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c28c15b6d28a776538482101522cbcd9f906b15c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c28c15b6d28a776538482101522cbcd9f906b15c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305060648.EjkrACfJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'local_flush_tlb_page_psize',
       inlined from '__do_patch_instruction_mm' at arch/powerpc/lib/code-patching.c:310:2,
       inlined from 'do_patch_instruction' at arch/powerpc/lib/code-patching.c:355:9,
       inlined from 'patch_instruction' at arch/powerpc/lib/code-patching.c:379:9:
>> include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_181' declared with attribute error: BUILD_BUG failed
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:338:25: note: in definition of macro '__compiletime_assert'
     338 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/book3s/32/tlbflush.h:83:9: note: in expansion of macro 'BUILD_BUG'
      83 |         BUILD_BUG();
         |         ^~~~~~~~~


vim +/__compiletime_assert_181 +357 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  356  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @357  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  358  

:::::: The code at line 357 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
