Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECF730490
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFNQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFNQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:06:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1597312A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686758795; x=1718294795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6XGI6lGnKd1aT3SQANVDGiAeUKiU8RX5QWSHPTjV8SI=;
  b=MzU8uZMp6YSyA/FJjH2o8caHz0jCYrfkVbfrpJJK88j0g1o3EDGWAuYZ
   7xHDbTFstivx1IotmaJhEdQuUEO0eTdw8FbjUBTWITn0JHbYfkcrQTqwi
   w9CUaVbqjjIEBtMG8gqXx5RKgpiHwBSqD1jYbIyFKGWiEbBrsSdCG60tG
   4Bg3glJ3ye/eqMAjMc407rW6cheGNZVjJK2wMgxl8Isb7KCzuve6FEjEZ
   ZLSh1YTEALWzTSjkW57HUblATT7yal19HRegJDCTBAliXesOsZ3bDvuX2
   PSIvwysxrgulqwQ3ACU9CzDOtB7ishY6D5KpgXaoe5NmgMdRsrligLGSe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="339006647"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="339006647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 09:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782142261"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782142261"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jun 2023 09:03:32 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9Sxh-0000pU-2t;
        Wed, 14 Jun 2023 16:03:19 +0000
Date:   Thu, 15 Jun 2023 00:02:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:338:45: error: call to
 '__compiletime_assert_255' declared with attribute error: BUILD_BUG_ON
 failed: (24-12) >= 12
Message-ID: <202306142338.zMr0lCD3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b6dad5178ceaf23f369c3711062ce1f2afc33644
commit: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h
date:   2 years, 11 months ago
config: arc-randconfig-r043-20230614 (https://download.01.org/0day-ci/archive/20230614/202306142338.zMr0lCD3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306142338.zMr0lCD3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/huge_memory.c: In function 'hugepage_init':
>> include/linux/compiler_types.h:338:45: error: call to '__compiletime_assert_255' declared with attribute error: BUILD_BUG_ON failed: (24-12) >= 12
     338 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:319:25: note: in definition of macro '__compiletime_assert'
     319 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:338:9: note: in expansion of macro '_compiletime_assert'
     338 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/bug.h:24:25: note: in expansion of macro 'BUILD_BUG_ON'
      24 |                         BUILD_BUG_ON(cond);             \
         |                         ^~~~~~~~~~~~
   mm/huge_memory.c:403:9: note: in expansion of macro 'MAYBE_BUILD_BUG_ON'
     403 |         MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >= MAX_ORDER);
         |         ^~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_255 +338 include/linux/compiler_types.h

   324	
   325	#define _compiletime_assert(condition, msg, prefix, suffix) \
   326		__compiletime_assert(condition, msg, prefix, suffix)
   327	
   328	/**
   329	 * compiletime_assert - break build and emit msg if condition is false
   330	 * @condition: a compile-time constant condition to check
   331	 * @msg:       a message to emit if condition is false
   332	 *
   333	 * In tradition of POSIX assert, this macro will break the build if the
   334	 * supplied condition is *false*, emitting the supplied error message if the
   335	 * compiler has support to do so.
   336	 */
   337	#define compiletime_assert(condition, msg) \
 > 338		_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   339	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
