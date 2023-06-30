Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986837437BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjF3It1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjF3ItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:49:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D11FFA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688114962; x=1719650962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=foIZ/6+yXPObI0e8ZC8E/MW66KSDHlhEW1hYPbizjpU=;
  b=XAf3TaLO4GBA/Iz1dbOo48OWFEiPO9Q7YD/HNnOyuRXX3XHdOzQMBJg3
   gFWmbaZXzz7+6iqgtlutVIPBosG4goXShR/58FNmAzmIf3FOFdvTlNdj4
   NGpnBKd1BSUb64OHO+6uDNrzuNk4wAnuwQCY/Zenu7L/0RX5T7roDtw4/
   EAGqyKqsAUfNrtNrMdIGsev4fpnlZ8Pyp64kMTgSSvXMbM6FGUKRrVxI5
   MUF9fsfbZU98Pfo9o5LaGUbtJr2+vowAxwUqU/9WSxg6a5x53rxcSL8zY
   0Qe5KNp4RasmKryzIAYq/LiO6uluM/7ibbid9HjuibjLbJDfG1GDXgL4r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="448726729"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="448726729"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 01:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841785951"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="841785951"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 01:49:19 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qF9oc-000Ept-2S;
        Fri, 30 Jun 2023 08:49:18 +0000
Date:   Fri, 30 Jun 2023 16:49:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/math-emu/fcmpu.c:15:2: error: variable '_fex' set but
 not used
Message-ID: <202306301631.cFuy7ZmI-lkp@intel.com>
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

Hi Christophe,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e55e5df193d247a38a5e1ac65a5316a0adcc22fa
commit: 7245fc5bb7a966852d5bd7779d1f5855530b461a powerpc/math-emu: Remove -w build flag and fix warnings
date:   10 months ago
config: powerpc-randconfig-r022-20230630 (https://download.01.org/0day-ci/archive/20230630/202306301631.cFuy7ZmI-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230630/202306301631.cFuy7ZmI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306301631.cFuy7ZmI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/math-emu/fcmpu.c:15:2: error: variable '_fex' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
>> arch/powerpc/math-emu/fcmpu.c:13:2: error: variable 'A_c' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_D(A);
           ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
   #define FP_DECL_D(X)            _FP_DECL(2,X)
                                   ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
     _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
                ^
   <scratch space>:161:1: note: expanded from here
   A_c
   ^
>> arch/powerpc/math-emu/fcmpu.c:14:2: error: variable 'B_c' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_D(B);
           ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
   #define FP_DECL_D(X)            _FP_DECL(2,X)
                                   ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
     _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
                ^
   <scratch space>:167:1: note: expanded from here
   B_c
   ^
   arch/powerpc/math-emu/fcmpu.c:11:1: error: no previous prototype for function 'fcmpu' [-Werror,-Wmissing-prototypes]
   fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
   ^
   arch/powerpc/math-emu/fcmpu.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   4 errors generated.
--
>> arch/powerpc/math-emu/fsel.c:14:2: error: variable '_fex' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fsel.c:11:1: error: no previous prototype for function 'fsel' [-Werror,-Wmissing-prototypes]
   fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
   ^
   arch/powerpc/math-emu/fsel.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 errors generated.
--
>> arch/powerpc/math-emu/fctiwz.c:14:2: error: variable '_fex' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fctiwz.c:11:1: error: no previous prototype for function 'fctiwz' [-Werror,-Wmissing-prototypes]
   fctiwz(u32 *frD, void *frB)
   ^
   arch/powerpc/math-emu/fctiwz.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 errors generated.
--
>> arch/powerpc/math-emu/fctiw.c:14:2: error: variable '_fex' set but not used [-Werror,-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fctiw.c:11:1: error: no previous prototype for function 'fctiw' [-Werror,-Wmissing-prototypes]
   fctiw(u32 *frD, void *frB)
   ^
   arch/powerpc/math-emu/fctiw.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 errors generated.


vim +/_fex +15 arch/powerpc/math-emu/fcmpu.c

^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16   9  
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  10  int
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  11  fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  12  {
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 @13  	FP_DECL_D(A);
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16 @14  	FP_DECL_D(B);
d2b194ed820880 arch/powerpc/math-emu/fcmpu.c Kumar Gala     2008-06-04 @15  	FP_DECL_EX;
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  16  	int code[4] = { (1 << 3), (1 << 1), (1 << 2), (1 << 0) };
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  17  	long cmp;
^1da177e4c3f41 arch/ppc/math-emu/fcmpu.c     Linus Torvalds 2005-04-16  18  

:::::: The code at line 15 was first introduced by commit
:::::: d2b194ed820880eb19c43b9c10d9f5f30026ee54 powerpc/math-emu: Use kernel generic math-emu code

:::::: TO: Kumar Gala <galak@kernel.crashing.org>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
