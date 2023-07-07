Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728A74B86F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjGGVEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGGVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:04:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FA71BD2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688763853; x=1720299853;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0lf4CsjZMU8LnsYZKbaFdjeTxKhkqzrAQoTvX3+RECU=;
  b=e76VWmiqdnl6gpTc16gogjDAnXDeB3L+q1PIiSV+Yk/4jBcHiU7uflcY
   c+f1mNxrRzKDnqN7UVhvp+lKFZwNdJoM5ooL6/9b+EI4XzdN9V+PsxND+
   eO1OwbE4xcbqmQgWeM81I7GGVcqMb3fgIcV9XwOR6KNMX/GPM2SO/og+5
   Dwo7wmw4raUuZUFoD0bvYk7vNWpWuZbvcGvaOEaJ/GQF0/v7K79jlu8V8
   dDF3zvsC7N68/ZFbDf5gC3o1GPoYFX6iYVEMwXnWhI2Va3XEgrZxNPhlk
   6aAAA5gI/QZ9dJOsgv728Xpapsl1062nSw7iuy+cpHdGbVvEw3kM0GQgj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="353831013"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="353831013"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:04:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="670288208"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="670288208"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2023 14:04:10 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHscb-0002IG-2Z;
        Fri, 07 Jul 2023 21:04:09 +0000
Date:   Sat, 8 Jul 2023 05:03:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/math-emu/fsel.c:14:2: warning: variable '_fex' set but
 not used
Message-ID: <202307080446.rpYEMqQ2-lkp@intel.com>
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

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4f6b6c2b2f86b7878a770736bf478d8a263ff0bc
commit: 7245fc5bb7a966852d5bd7779d1f5855530b461a powerpc/math-emu: Remove -w build flag and fix warnings
date:   10 months ago
config: powerpc-randconfig-r033-20230708 (https://download.01.org/0day-ci/archive/20230708/202307080446.rpYEMqQ2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230708/202307080446.rpYEMqQ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307080446.rpYEMqQ2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/math-emu/fsel.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
      14 |         FP_DECL_EX;
         |         ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
      94 | #define FP_DECL_EX int _fex = 0
         |                        ^
   arch/powerpc/math-emu/fsel.c:11:1: warning: no previous prototype for function 'fsel' [-Wmissing-prototypes]
      11 | fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
         | ^
   arch/powerpc/math-emu/fsel.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      10 | int
         | ^
         | static 
   2 warnings generated.
--
>> arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set but not used [-Wunused-but-set-variable]
      13 |         FP_DECL_D(A);
         |         ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
      73 | #define FP_DECL_D(X)            _FP_DECL(2,X)
         |                                 ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   <scratch space>:171:1: note: expanded from here
     171 | A_c
         | ^
>> arch/powerpc/math-emu/fcmpu.c:14:2: warning: variable 'B_c' set but not used [-Wunused-but-set-variable]
      14 |         FP_DECL_D(B);
         |         ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
      73 | #define FP_DECL_D(X)            _FP_DECL(2,X)
         |                                 ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
      28 |   _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
         |              ^
   <scratch space>:177:1: note: expanded from here
     177 | B_c
         | ^
>> arch/powerpc/math-emu/fcmpu.c:15:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
      15 |         FP_DECL_EX;
         |         ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
      94 | #define FP_DECL_EX int _fex = 0
         |                        ^
   arch/powerpc/math-emu/fcmpu.c:11:1: warning: no previous prototype for function 'fcmpu' [-Wmissing-prototypes]
      11 | fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
         | ^
   arch/powerpc/math-emu/fcmpu.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      10 | int
         | ^
         | static 
   4 warnings generated.
--
>> arch/powerpc/math-emu/fctiwz.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
      14 |         FP_DECL_EX;
         |         ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
      94 | #define FP_DECL_EX int _fex = 0
         |                        ^
   arch/powerpc/math-emu/fctiwz.c:11:1: warning: no previous prototype for function 'fctiwz' [-Wmissing-prototypes]
      11 | fctiwz(u32 *frD, void *frB)
         | ^
   arch/powerpc/math-emu/fctiwz.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      10 | int
         | ^
         | static 
   2 warnings generated.
--
>> arch/powerpc/math-emu/fctiw.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
      14 |         FP_DECL_EX;
         |         ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
      94 | #define FP_DECL_EX int _fex = 0
         |                        ^
   arch/powerpc/math-emu/fctiw.c:11:1: warning: no previous prototype for function 'fctiw' [-Wmissing-prototypes]
      11 | fctiw(u32 *frD, void *frB)
         | ^
   arch/powerpc/math-emu/fctiw.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      10 | int
         | ^
         | static 
   2 warnings generated.


vim +/_fex +14 arch/powerpc/math-emu/fsel.c

^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16   9  
^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16  10  int
^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16  11  fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16  12  {
^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16  13  	FP_DECL_D(A);
d2b194ed820880 arch/powerpc/math-emu/fsel.c Kumar Gala     2008-06-04 @14  	FP_DECL_EX;
^1da177e4c3f41 arch/ppc/math-emu/fsel.c     Linus Torvalds 2005-04-16  15  

:::::: The code at line 14 was first introduced by commit
:::::: d2b194ed820880eb19c43b9c10d9f5f30026ee54 powerpc/math-emu: Use kernel generic math-emu code

:::::: TO: Kumar Gala <galak@kernel.crashing.org>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
