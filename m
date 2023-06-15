Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53155730F64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbjFOGdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbjFOGc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:32:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B026A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686810770; x=1718346770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gzxZ32ZlhE6/+8VLXm+4b7siOqJhrhIW+gciOZRH2U0=;
  b=eHsrV8yF6yyWt3kmPQAU8JPuMnODzxPHYZVdnCObqRwmV7IcRg7UhHQz
   D4Znsa8Ao/UJ9kOfFudtSMYizRXcTzr+edmef7Qb+DUDYbv4WaDXiU+on
   H7FeJpw8RjLaBZssHFo8wzk0lytK/a9gs8wWK91MBfsfBuRjiE0VCO+9n
   ufpCmtWFzeIWv7d2MUJB+eL/NInEflCJPxL5v+jkZXRlyALu5lAZ7KQ/M
   BSbTiuH8yMYqPfd/6mpWc3kbkbSVyNnKCppj7yfcNpjKx8nr/5ORUxiCQ
   kZf0bpP7KNSbXEsoRKqcvxIgimlX0+XteRnmr1jb25A3X+2SV/CLafdsH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="343527705"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="343527705"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712345894"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="712345894"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2023 23:32:47 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9gXG-0001Yb-2R;
        Thu, 15 Jun 2023 06:32:46 +0000
Date:   Thu, 15 Jun 2023 14:32:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239'
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202306151433.QKcn7ZNn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b6dad5178ceaf23f369c3711062ce1f2afc33644
commit: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
date:   12 months ago
config: arm64-randconfig-r025-20230615 (https://download.01.org/0day-ci/archive/20230615/202306151433.QKcn7ZNn-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dc34d5036692c614eef23c1130ee42a201c316bf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dc34d5036692c614eef23c1130ee42a201c316bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash lib/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306151433.QKcn7ZNn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:920:2: error: call to '__compiletime_assert_239' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
           BUILD_BUG_ON(!__builtin_constant_p(res));
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:352:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:340:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:333:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:185:1: note: expanded from here
   __compiletime_assert_239
   ^
   1 error generated.


vim +920 lib/test_bitmap.c

   871	
   872	static void __init test_bitmap_const_eval(void)
   873	{
   874		DECLARE_BITMAP(bitmap, BITS_PER_LONG);
   875		unsigned long initvar = BIT(2);
   876		unsigned long bitopvar = 0;
   877		unsigned long var = 0;
   878		int res;
   879	
   880		/*
   881		 * Compilers must be able to optimize all of those to compile-time
   882		 * constants on any supported optimization level (-O2, -Os) and any
   883		 * architecture. Otherwise, trigger a build bug.
   884		 * The whole function gets optimized out then, there's nothing to do
   885		 * in runtime.
   886		 */
   887	
   888		/*
   889		 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
   890		 * Clang on s390 optimizes bitops at compile-time as intended, but at
   891		 * the same time stops treating @bitmap and @bitopvar as compile-time
   892		 * constants after regular test_bit() is executed, thus triggering the
   893		 * build bugs below. So, call const_test_bit() there directly until
   894		 * the compiler is fixed.
   895		 */
   896		bitmap_clear(bitmap, 0, BITS_PER_LONG);
   897	#if defined(__s390__) && defined(__clang__)
   898		if (!const_test_bit(7, bitmap))
   899	#else
   900		if (!test_bit(7, bitmap))
   901	#endif
   902			bitmap_set(bitmap, 5, 2);
   903	
   904		/* Equals to `unsigned long bitopvar = BIT(20)` */
   905		__change_bit(31, &bitopvar);
   906		bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
   907	
   908		/* Equals to `unsigned long var = BIT(25)` */
   909		var |= BIT(25);
   910		if (var & BIT(0))
   911			var ^= GENMASK(9, 6);
   912	
   913		/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
   914		res = bitmap_weight(bitmap, 20);
   915		BUILD_BUG_ON(!__builtin_constant_p(res));
   916		BUILD_BUG_ON(res != 2);
   917	
   918		/* !(BIT(31) & BIT(18)) == 1 */
   919		res = !test_bit(18, &bitopvar);
 > 920		BUILD_BUG_ON(!__builtin_constant_p(res));
   921		BUILD_BUG_ON(!res);
   922	
   923		/* BIT(2) & GENMASK(14, 8) == 0 */
   924		res = initvar & GENMASK(14, 8);
   925		BUILD_BUG_ON(!__builtin_constant_p(res));
   926		BUILD_BUG_ON(res);
   927	
   928		/* ~BIT(25) */
   929		BUILD_BUG_ON(!__builtin_constant_p(~var));
   930		BUILD_BUG_ON(~var != ~BIT(25));
   931	}
   932	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
