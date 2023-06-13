Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DA872DB50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjFMHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbjFMHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:43:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A261713
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686642164; x=1718178164;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rniLsWnACjZZ6Kmsz9b14uy1hoecAmhH7gTtOx3cOo8=;
  b=CPJi4CO9yc87+n+CU3sm4LOM6RjFK4IzF0DPwP+XNP0kVrlNb2gJNSQh
   AO82jNHttcd3IyizBJHJ36JWDq7kioJKLhlR0xXmX16J652tVrz/CT5tz
   mWCd8q2zL7sUEJ5gzUrd7jpgkCqEIexEC+IheICgHA97NrmThv4fnsnD+
   j+7mBrY2OADNO9ZRuEi5/L720rNPXZVUBqSQ9bfL0nTLatUQpuRoqncPg
   vjj9svkXIM4Bt0ZZEVRd65ZXUImKw/gxL6G8Z5qtzXmwdI/Sq7pvfMKgE
   xmDIXvU+XDE/FDcap8JWZoz5P6QkVDv5rNIF4kRhRe0RhSBzOjtiyagjt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="424139692"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="424139692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 00:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="744601046"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="744601046"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jun 2023 00:42:41 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8yfp-00016Z-0i;
        Tue, 13 Jun 2023 07:42:41 +0000
Date:   Tue, 13 Jun 2023 15:42:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Seung-Woo Kim <sw0312.kim@samsung.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: lib/test_bitmap.c:926:2: error: call to '__compiletime_assert_190'
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202306131550.LosyU9Kt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb054096aea0576f0c0a61c598e5e9676443ee86
commit: d539fee9f825b0c8eac049732c83562b28a483b5 ARM: 9253/1: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
date:   7 months ago
config: arm-randconfig-r034-20230613 (https://download.01.org/0day-ci/archive/20230613/202306131550.LosyU9Kt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d539fee9f825b0c8eac049732c83562b28a483b5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d539fee9f825b0c8eac049732c83562b28a483b5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306131550.LosyU9Kt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:926:2: error: call to '__compiletime_assert_190' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
     926 |         BUILD_BUG_ON(!__builtin_constant_p(res));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:354:2: note: expanded from macro 'compiletime_assert'
     354 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:342:2: note: expanded from macro '_compiletime_assert'
     342 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:335:4: note: expanded from macro '__compiletime_assert'
     335 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:196:1: note: expanded from here
     196 | __compiletime_assert_190
         | ^
   1 error generated.


vim +926 lib/test_bitmap.c

291f93ca339f5b Barry Song        2021-08-06  877  
dc34d5036692c6 Alexander Lobakin 2022-06-24  878  static void __init test_bitmap_const_eval(void)
dc34d5036692c6 Alexander Lobakin 2022-06-24  879  {
dc34d5036692c6 Alexander Lobakin 2022-06-24  880  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  881  	unsigned long initvar = BIT(2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  882  	unsigned long bitopvar = 0;
dc34d5036692c6 Alexander Lobakin 2022-06-24  883  	unsigned long var = 0;
dc34d5036692c6 Alexander Lobakin 2022-06-24  884  	int res;
dc34d5036692c6 Alexander Lobakin 2022-06-24  885  
dc34d5036692c6 Alexander Lobakin 2022-06-24  886  	/*
dc34d5036692c6 Alexander Lobakin 2022-06-24  887  	 * Compilers must be able to optimize all of those to compile-time
dc34d5036692c6 Alexander Lobakin 2022-06-24  888  	 * constants on any supported optimization level (-O2, -Os) and any
dc34d5036692c6 Alexander Lobakin 2022-06-24  889  	 * architecture. Otherwise, trigger a build bug.
dc34d5036692c6 Alexander Lobakin 2022-06-24  890  	 * The whole function gets optimized out then, there's nothing to do
dc34d5036692c6 Alexander Lobakin 2022-06-24  891  	 * in runtime.
dc34d5036692c6 Alexander Lobakin 2022-06-24  892  	 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  893  
dc34d5036692c6 Alexander Lobakin 2022-06-24  894  	/*
dc34d5036692c6 Alexander Lobakin 2022-06-24  895  	 * Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }`.
dc34d5036692c6 Alexander Lobakin 2022-06-24  896  	 * Clang on s390 optimizes bitops at compile-time as intended, but at
dc34d5036692c6 Alexander Lobakin 2022-06-24  897  	 * the same time stops treating @bitmap and @bitopvar as compile-time
dc34d5036692c6 Alexander Lobakin 2022-06-24  898  	 * constants after regular test_bit() is executed, thus triggering the
dc34d5036692c6 Alexander Lobakin 2022-06-24  899  	 * build bugs below. So, call const_test_bit() there directly until
dc34d5036692c6 Alexander Lobakin 2022-06-24  900  	 * the compiler is fixed.
dc34d5036692c6 Alexander Lobakin 2022-06-24  901  	 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  902  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  903  #if defined(__s390__) && defined(__clang__)
dc34d5036692c6 Alexander Lobakin 2022-06-24  904  	if (!const_test_bit(7, bitmap))
dc34d5036692c6 Alexander Lobakin 2022-06-24  905  #else
dc34d5036692c6 Alexander Lobakin 2022-06-24  906  	if (!test_bit(7, bitmap))
dc34d5036692c6 Alexander Lobakin 2022-06-24  907  #endif
dc34d5036692c6 Alexander Lobakin 2022-06-24  908  		bitmap_set(bitmap, 5, 2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  909  
dc34d5036692c6 Alexander Lobakin 2022-06-24  910  	/* Equals to `unsigned long bitopvar = BIT(20)` */
dc34d5036692c6 Alexander Lobakin 2022-06-24  911  	__change_bit(31, &bitopvar);
dc34d5036692c6 Alexander Lobakin 2022-06-24  912  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  913  
dc34d5036692c6 Alexander Lobakin 2022-06-24  914  	/* Equals to `unsigned long var = BIT(25)` */
dc34d5036692c6 Alexander Lobakin 2022-06-24  915  	var |= BIT(25);
dc34d5036692c6 Alexander Lobakin 2022-06-24  916  	if (var & BIT(0))
dc34d5036692c6 Alexander Lobakin 2022-06-24  917  		var ^= GENMASK(9, 6);
dc34d5036692c6 Alexander Lobakin 2022-06-24  918  
dc34d5036692c6 Alexander Lobakin 2022-06-24  919  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  920  	res = bitmap_weight(bitmap, 20);
dc34d5036692c6 Alexander Lobakin 2022-06-24  921  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  922  	BUILD_BUG_ON(res != 2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  923  
dc34d5036692c6 Alexander Lobakin 2022-06-24  924  	/* !(BIT(31) & BIT(18)) == 1 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  925  	res = !test_bit(18, &bitopvar);
dc34d5036692c6 Alexander Lobakin 2022-06-24 @926  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  927  	BUILD_BUG_ON(!res);
dc34d5036692c6 Alexander Lobakin 2022-06-24  928  
dc34d5036692c6 Alexander Lobakin 2022-06-24  929  	/* BIT(2) & GENMASK(14, 8) == 0 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  930  	res = initvar & GENMASK(14, 8);
dc34d5036692c6 Alexander Lobakin 2022-06-24  931  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  932  	BUILD_BUG_ON(res);
dc34d5036692c6 Alexander Lobakin 2022-06-24  933  
dc34d5036692c6 Alexander Lobakin 2022-06-24  934  	/* ~BIT(25) */
dc34d5036692c6 Alexander Lobakin 2022-06-24  935  	BUILD_BUG_ON(!__builtin_constant_p(~var));
dc34d5036692c6 Alexander Lobakin 2022-06-24  936  	BUILD_BUG_ON(~var != ~BIT(25));
dc34d5036692c6 Alexander Lobakin 2022-06-24  937  }
dc34d5036692c6 Alexander Lobakin 2022-06-24  938  

:::::: The code at line 926 was first introduced by commit
:::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions

:::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
:::::: CC: Yury Norov <yury.norov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
