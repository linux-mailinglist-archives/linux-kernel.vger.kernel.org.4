Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FB6C8CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjCYIj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjCYIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:39:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326214989
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679733479; x=1711269479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/vEruDkudEVBFOAQGWYHztaqUg5m75SWSqz1gK8JLN0=;
  b=EmUZP1pWWy6Le5v1lhO4nQa8LavFI8tY/fibzs0Q2KFiT02OiyqStzbF
   RWjkxMp+GTdOaqbeMJQrLSdZlBtD3L+aUTjxwm/PkpvT6K0mJK80aRp7m
   g8jpPbT+k5oHUgbnnTbINpdL/8W+y4wdIVa6fmICs9dj1BxmPf6mkN7oM
   Y7VEx3VWEQAJK+1K7LWywL8k14ul9La4ggagn2y15SYhpWbK7kAubg80c
   FxfEAcNM7pmOFfQqNrr6MovVJFZgqbVCDC2HtfsqF0vf0kY0Ou5+NWq4Q
   KITVJ3vhGox2MduTsdvUh0EdBiL5FotXVkI8z1KusqUBUDgjPuZHxfiUC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="402550862"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="402550862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 01:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806940287"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="806940287"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2023 01:37:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfzPO-000G71-1g;
        Sat, 25 Mar 2023 08:37:54 +0000
Date:   Sat, 25 Mar 2023 16:37:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3 17/17] include/asm-generic/rwonce.h:44:26:
 error: array subscript 0 is outside array bounds of 'const volatile int[0]'
Message-ID: <202303251631.oyjkxqNQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
head:   2226ddb6a576f7f89a8a06a3f89b68f5109ded53
commit: 2226ddb6a576f7f89a8a06a3f89b68f5109ded53 [17/17] Makefile: Enable -Wstringop-overflow and -Warray-bounds
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230325/202303251631.oyjkxqNQ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3
        git checkout 2226ddb6a576f7f89a8a06a3f89b68f5109ded53
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303251631.oyjkxqNQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/include/asm/rwonce.h:29,
                    from include/linux/compiler.h:247,
                    from include/linux/build_bug.h:5,
                    from include/linux/bits.h:21,
                    from drivers/net/wwan/t7xx/t7xx_state_monitor.c:17:
   In function 'preempt_count',
       inlined from 't7xx_fsm_append_event' at drivers/net/wwan/t7xx/t7xx_state_monitor.c:439:43:
>> include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Werror=array-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 't7xx_fsm_append_event' at drivers/net/wwan/t7xx/t7xx_state_monitor.c:439:43:
>> include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Werror=array-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   In function 'preempt_count',
       inlined from 't7xx_fsm_append_event' at drivers/net/wwan/t7xx/t7xx_state_monitor.c:439:43:
>> include/asm-generic/rwonce.h:44:26: error: array subscript 0 is outside array bounds of 'const volatile int[0]' [-Werror=array-bounds]
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/s390/include/asm/preempt.h:17:16: note: in expansion of macro 'READ_ONCE'
      17 |         return READ_ONCE(S390_lowcore.preempt_count) & ~PREEMPT_NEED_RESCHED;
         |                ^~~~~~~~~
   cc1: all warnings being treated as errors


vim +44 include/asm-generic/rwonce.h

e506ea451254ab1 Will Deacon 2019-10-15  28  
e506ea451254ab1 Will Deacon 2019-10-15  29  /*
e506ea451254ab1 Will Deacon 2019-10-15  30   * Yes, this permits 64-bit accesses on 32-bit architectures. These will
e506ea451254ab1 Will Deacon 2019-10-15  31   * actually be atomic in some cases (namely Armv7 + LPAE), but for others we
e506ea451254ab1 Will Deacon 2019-10-15  32   * rely on the access being split into 2x32-bit accesses for a 32-bit quantity
e506ea451254ab1 Will Deacon 2019-10-15  33   * (e.g. a virtual address) and a strong prevailing wind.
e506ea451254ab1 Will Deacon 2019-10-15  34   */
e506ea451254ab1 Will Deacon 2019-10-15  35  #define compiletime_assert_rwonce_type(t)					\
e506ea451254ab1 Will Deacon 2019-10-15  36  	compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),	\
e506ea451254ab1 Will Deacon 2019-10-15  37  		"Unsupported access size for {READ,WRITE}_ONCE().")
e506ea451254ab1 Will Deacon 2019-10-15  38  
e506ea451254ab1 Will Deacon 2019-10-15  39  /*
e506ea451254ab1 Will Deacon 2019-10-15  40   * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
3c9184109e78ea2 Will Deacon 2019-10-30  41   * atomicity. Note that this may result in tears!
e506ea451254ab1 Will Deacon 2019-10-15  42   */
b78b331a3f5c077 Will Deacon 2019-10-15  43  #ifndef __READ_ONCE
e506ea451254ab1 Will Deacon 2019-10-15 @44  #define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
b78b331a3f5c077 Will Deacon 2019-10-15  45  #endif
e506ea451254ab1 Will Deacon 2019-10-15  46  

:::::: The code at line 44 was first introduced by commit
:::::: e506ea451254ab17e0bf918ca36232fec2a9b10c compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
