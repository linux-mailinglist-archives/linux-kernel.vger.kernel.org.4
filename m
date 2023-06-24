Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01673CCBF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 23:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFXVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFXVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 17:13:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1198171A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 14:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687641200; x=1719177200;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cuCjv82KMYnE/rvAlPkCqzGdS0EwUnAzwioM7xu1I5Y=;
  b=JKk2fdvCJPBYcNIW5CDsGnQGJZKMVSS63+P352xWoN/LYp5bZMx360Hh
   QOR60n3NkROqbj/wFUEu9VPJ+60TLFDHIbPIFqWNqCWJ9OxkweFH0lOpW
   0K/rQqYkdHPwh9g2JU+J3U8dEGSC2NbEnTnoHRIGyVl2Vymi0/maKvzDk
   vPVXcjyOXPismNP78BMrfXmHq9ayKC5u4PeATXl3+uJoOK/V1mEUD0ZFl
   acqRqY/MGUtVQZ5096XbQdP/l6wyke9fwhpS4XwRxQw2woHNJYCkQiQUm
   a6NYO7wfZ2D8bUo/V2V/xXe0N86GCCjD9qvWCQzne0DJoJm26JKBZJUuI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="363535469"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="363535469"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 14:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="805567186"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="805567186"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2023 14:13:18 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qDAZJ-0009R7-2G;
        Sat, 24 Jun 2023 21:13:17 +0000
Date:   Sun, 25 Jun 2023 05:12:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: lib/test_bitmap.c:920:2: error: call to __compiletime_assert_372
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202306250533.CBxzOSEh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a92b7d26c743b9dc06d520f863d624e94978a1d9
commit: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
date:   12 months ago
config: x86_64-buildonly-randconfig-r003-20230624 (https://download.01.org/0day-ci/archive/20230625/202306250533.CBxzOSEh-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230625/202306250533.CBxzOSEh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306250533.CBxzOSEh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:920:2: error: call to __compiletime_assert_372 declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
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
   <scratch space>:295:1: note: expanded from here
   __compiletime_assert_372
   ^
   1 error generated.


vim +/error +920 lib/test_bitmap.c

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
