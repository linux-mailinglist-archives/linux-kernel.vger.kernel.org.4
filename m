Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14446F3BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjEBCA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjEBCA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:00:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BAE30CF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682992824; x=1714528824;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T0H3VZcvKVdVtiA+qrrlEg6skJDpBsHioXxDDeuyygY=;
  b=lJgG60tytFGq2aU2wfmnvfUcNLiKV3dxj9QVLFp6FnhbZjPlziHfGpwG
   Xq0esgEq+purnKEEeLw6gUGwMkY34BY+Z6XSoO08NH1q+kW2zwDWBoZ0/
   TxRkTtQgjqvkWBYyEgVGHF/voso+rD+ewDwGuNwXw/G4f0lO6/Pg97cuz
   nsnMwAzRcVwbD0cH2JIQLmsO/b5YRcDgYIkeTB4lKBirzAKv/hoJUd5uy
   q5WQRNNkw7AzTo0v2AK/ho22jLNZhHUE/0wvSA5jIVP8sSM+Sg6KmZGWh
   gMJ9pA4YyXppOqHbIEhs3v/+cSftQke0sGNs7r5YTQGYbCNRovjC/kNx+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="332634188"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="332634188"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 19:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="870380014"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="870380014"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2023 19:00:21 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ptfJU-0000lY-1m;
        Tue, 02 May 2023 02:00:20 +0000
Date:   Tue, 2 May 2023 09:59:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/clk-sp7021.c:316:8: warning: result of comparison of
 constant 18446744073709551615 with expression of type 'typeof
 (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0,
 signed char: (unsigned char)0, unsigned short: (unsigne...
Message-ID: <202305020914.hpj0KjkS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   865fdb08197e657c59e74a35fa32362b12397f58
commit: d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2 clk: Add Sunplus SP7021 clock driver
date:   6 weeks ago
config: arm-sp7021_defconfig (https://download.01.org/0day-ci/archive/20230502/202305020914.hpj0KjkS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d54c1fd4a51e8fbc7f9da86b0cd338a4f7cd2bb2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305020914.hpj0KjkS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-sp7021.c:316:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:45:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:397:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:385:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:377:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:317:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:45:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:397:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:385:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:377:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:318:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:45:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:397:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:385:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:377:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:319:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r0 |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:45:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:397:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:385:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:377:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
   drivers/clk/clk-sp7021.c:321:8: warning: result of comparison of constant 18446744073709551615 with expression of type 'typeof (_Generic((_m), char: (unsigned char)0, unsigned char: (unsigned char)0, signed char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned long: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned long long)0, long long: (unsigned long long)0, default: (_m)))' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           r1  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/clk-sp7021.c:45:15: note: expanded from macro 'HWM_FIELD_PREP'
           (_m << 16) | FIELD_PREP(_m, value);     \
                        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: expanded from macro 'FIELD_PREP'
                   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:53: note: expanded from macro '__BF_FIELD_CHECK'
                   BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)


vim +316 drivers/clk/clk-sp7021.c

   309	
   310	static int plltv_set_rate(struct sp_pll *clk)
   311	{
   312		unsigned long flags;
   313		u32 r0, r1, r2;
   314	
   315		r0  = BIT(clk->bp_bit + 16);
 > 316		r0 |= HWM_FIELD_PREP(MASK_SEL_FRA, clk->p[SEL_FRA]);
   317		r0 |= HWM_FIELD_PREP(MASK_SDM_MOD, clk->p[SDM_MOD]);
   318		r0 |= HWM_FIELD_PREP(MASK_PH_SEL, clk->p[PH_SEL]);
   319		r0 |= HWM_FIELD_PREP(MASK_NFRA, clk->p[NFRA]);
   320	
   321		r1  = HWM_FIELD_PREP(MASK_DIVR, clk->p[DIVR]);
   322	
   323		r2  = HWM_FIELD_PREP(MASK_DIVN, clk->p[DIVN] - 1);
   324		r2 |= HWM_FIELD_PREP(MASK_DIVM, clk->p[DIVM] - 1);
   325	
   326		spin_lock_irqsave(&clk->lock, flags);
   327		writel(r0, clk->reg);
   328		writel(r1, clk->reg + 4);
   329		writel(r2, clk->reg + 8);
   330		spin_unlock_irqrestore(&clk->lock, flags);
   331	
   332		return 0;
   333	}
   334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
