Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADC70C59F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjEVTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbjEVTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:01:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5464DF4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684782074; x=1716318074;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sM2uaj11psN2Luzn177V6CNeRqQHcsdr13KAfBiWtMU=;
  b=nWpJ6aatz/Co2RTbPqljgalR4hWuxK9ZUgAWUJVQSEYLx2WFU4MQKv0M
   AO2ru8ssctJQWCNEQQLlu4oqdJ5G813NfoMD7jIoYsbk7bEx+ukKRt2UZ
   KdocSNj9KcsWxYWao1KO/ubel0hVvgTr9SwNn5U0auwPC2BbNXUFtzd8O
   LVLbrEgC5QbvD0CxSS3R14pWcW2fLMJLFIQWBKOfPbjHG4DyKZ33NCeju
   d0YRuox6LjU2537M1auRpzOl8cb3gzSEaLg9/A4Ph0YJbTcESL0U7HDVX
   Y2Fz3qs0cc+Gp64O5YdrbhM3bovm6Mg+9lZJgHuGnuaBqkcjI+psuex18
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="355361166"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="355361166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 12:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793444365"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="793444365"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 May 2023 12:01:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1AmO-000D55-3D;
        Mon, 22 May 2023 19:01:13 +0000
Date:   Tue, 23 May 2023 03:00:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set but
 not used
Message-ID: <202305230231.3Wb7Q68G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44c026a73be8038f03dbdeef028b642880cf1511
commit: 7245fc5bb7a966852d5bd7779d1f5855530b461a powerpc/math-emu: Remove -w build flag and fix warnings
date:   9 months ago
config: powerpc-randconfig-r022-20230522 (https://download.01.org/0day-ci/archive/20230523/202305230231.3Wb7Q68G-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7245fc5bb7a966852d5bd7779d1f5855530b461a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7245fc5bb7a966852d5bd7779d1f5855530b461a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/math-emu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305230231.3Wb7Q68G-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/math-emu/fcmpu.c:13:2: warning: variable 'A_c' set but not used [-Wunused-but-set-variable]
           FP_DECL_D(A);
           ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
   #define FP_DECL_D(X)            _FP_DECL(2,X)
                                   ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
     _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
                ^
   <scratch space>:124:1: note: expanded from here
   A_c
   ^
>> arch/powerpc/math-emu/fcmpu.c:14:2: warning: variable 'B_c' set but not used [-Wunused-but-set-variable]
           FP_DECL_D(B);
           ^
   include/math-emu/double.h:73:23: note: expanded from macro 'FP_DECL_D'
   #define FP_DECL_D(X)            _FP_DECL(2,X)
                                   ^
   include/math-emu/op-common.h:28:14: note: expanded from macro '_FP_DECL'
     _FP_I_TYPE X##_c=0, X##_s=0, X##_e=0; \
                ^
   <scratch space>:130:1: note: expanded from here
   B_c
   ^
>> arch/powerpc/math-emu/fcmpu.c:15:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fcmpu.c:11:1: warning: no previous prototype for function 'fcmpu' [-Wmissing-prototypes]
   fcmpu(u32 *ccr, int crfD, void *frA, void *frB)
   ^
   arch/powerpc/math-emu/fcmpu.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   4 warnings generated.
--
>> arch/powerpc/math-emu/fctiw.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fctiw.c:11:1: warning: no previous prototype for function 'fctiw' [-Wmissing-prototypes]
   fctiw(u32 *frD, void *frB)
   ^
   arch/powerpc/math-emu/fctiw.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 warnings generated.
--
>> arch/powerpc/math-emu/fctiwz.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fctiwz.c:11:1: warning: no previous prototype for function 'fctiwz' [-Wmissing-prototypes]
   fctiwz(u32 *frD, void *frB)
   ^
   arch/powerpc/math-emu/fctiwz.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 warnings generated.
--
>> arch/powerpc/math-emu/fsel.c:14:2: warning: variable '_fex' set but not used [-Wunused-but-set-variable]
           FP_DECL_EX;
           ^
   include/math-emu/soft-fp.h:94:24: note: expanded from macro 'FP_DECL_EX'
   #define FP_DECL_EX int _fex = 0
                          ^
   arch/powerpc/math-emu/fsel.c:11:1: warning: no previous prototype for function 'fsel' [-Wmissing-prototypes]
   fsel(u32 *frD, void *frA, u32 *frB, u32 *frC)
   ^
   arch/powerpc/math-emu/fsel.c:10:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
   2 warnings generated.


vim +/A_c +13 arch/powerpc/math-emu/fcmpu.c

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

:::::: The code at line 13 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
