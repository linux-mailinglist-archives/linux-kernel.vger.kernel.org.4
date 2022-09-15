Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5DF5BA124
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIOTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:08:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D26857D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663268924; x=1694804924;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1iuDUReQ5aZ4Di20M9vvIKBhcc8BXBB1AR1RFh4ui9E=;
  b=nSCyI+9VmX8E1TPx987k5NwMHnGa7OrYf4nXiJG2Oe3/nLvNZ+kv/GQl
   3L/TNtgTcvktt3hsCfLuaUFnD7F/QnldA2sMiUmsnQ03f+wJKZSqaIuyR
   vgEBolqTImk+LrF2UmRSQbEYUd1jTBNAVpcqR2LX1jn5CD2YI/SoGE+nH
   3Wx4/IlzuME0slSB24oE4WTn5ljLu+cryG5PW2HgoNxiQvX/SvRUPMi+J
   afRbY4aLbVxFVTBY1TKjOA64gE6skiBqMnx+zv0OyshG7861Oq3MeOZht
   A/ITO5RmnwF4MglRCKOscbCHR/PLkTAg7Uq37id0Iaz2EKO0NSZQ+p8ea
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="298808539"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="298808539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 12:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="594956270"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2022 12:08:41 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYuE5-0000uT-0h;
        Thu, 15 Sep 2022 19:08:41 +0000
Date:   Fri, 16 Sep 2022 03:08:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     kbuild-all@lists.01.org, linux-m68k@lists.linux-m68k.org,
        uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: [gerg-m68knommu:armnommu 3/3]
 arch/arm/include/asm/glue-cache.h:126:2: error: #error Unknown cache
 maintenance model
Message-ID: <202209160332.S6pQG1wV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git armnommu
head:   253950b08a4d5f947c38fc64a13c376831e4040b
commit: 253950b08a4d5f947c38fc64a13c376831e4040b [3/3] ARM: versatile: support configuring versatile machine for no-MMU
config: arm-randconfig-c003-20220915 (https://download.01.org/0day-ci/archive/20220916/202209160332.S6pQG1wV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git/commit/?id=253950b08a4d5f947c38fc64a13c376831e4040b
        git remote add gerg-m68knommu https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
        git fetch --no-tags gerg-m68knommu armnommu
        git checkout 253950b08a4d5f947c38fc64a13c376831e4040b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/list.h:11,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14:
   arch/arm/include/asm/barrier.h: At top level:
   arch/arm/include/asm/barrier.h:9:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
       9 | #if __LINUX_ARM_ARCH__ >= 7 ||          \
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:10:10: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      10 |         (__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
         |          ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:18:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      18 | #if __LINUX_ARM_ARCH__ >= 7
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/barrier.h:28:35: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      28 | #elif defined(CONFIG_CPU_XSC3) || __LINUX_ARM_ARCH__ == 6
         |                                   ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/processor.h:17,
                    from include/linux/prefetch.h:15,
                    from arch/arm/include/asm/atomic.h:12,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11:
   arch/arm/include/asm/vdso/processor.h:10:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      10 | #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/processor.h:110:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     110 | #if __LINUX_ARM_ARCH__ >= 5
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/irqflags.h:16,
                    from arch/arm/include/asm/atomic.h:14:
   arch/arm/include/asm/irqflags.h:22:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      22 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/atomic.h:16:
   arch/arm/include/asm/cmpxchg.h: In function '__xchg':
   arch/arm/include/asm/cmpxchg.h:35:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      35 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cmpxchg.h:42:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      42 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cmpxchg.h: At top level:
   arch/arm/include/asm/cmpxchg.h:124:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     124 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/atomic.h:28:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      28 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/swab.h:19,
                    from include/uapi/linux/swab.h:8,
                    from include/linux/swab.h:5,
                    from arch/arm/include/asm/opcodes.h:86,
                    from arch/arm/include/asm/bug.h:7,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/rcupdate.h:27:
   arch/arm/include/uapi/asm/swab.h:27:29: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      27 | #if !defined(__KERNEL__) || __LINUX_ARM_ARCH__ < 6
         |                             ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/swab.h:21:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      21 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27:
   arch/arm/include/asm/bitops.h:218:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     218 | #if __LINUX_ARM_ARCH__ < 5
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/thread_info.h:13,
                    from include/linux/thread_info.h:60:
   arch/arm/include/asm/fpstate.h:29:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      29 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:703,
                    from arch/arm/kernel/asm-offsets.c:12:
   arch/arm/include/asm/uaccess.h:302:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     302 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/uaccess.h:404:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     404 | #if __LINUX_ARM_ARCH__ >= 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/scatterlist.h:9,
                    from include/linux/dma-mapping.h:10,
                    from arch/arm/kernel/asm-offsets.c:13:
   arch/arm/include/asm/io.h:53:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      53 | #if __LINUX_ARM_ARCH__ < 6
         |     ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/cacheflush.h:12,
                    from arch/arm/kernel/asm-offsets.c:14:
>> arch/arm/include/asm/glue-cache.h:126:2: error: #error Unknown cache maintenance model
     126 | #error Unknown cache maintenance model
         |  ^~~~~
   In file included from arch/arm/include/asm/cacheflush.h:14:
   arch/arm/include/asm/cachetype.h:29:5: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      29 | #if __LINUX_ARM_ARCH__ >= 7
         |     ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cachetype.h:34:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
      34 | #elif __LINUX_ARM_ARCH__ >= 6
         |       ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cacheflush.h:197:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     197 | #elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
         |       ^~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/cacheflush.h:199:7: warning: "__LINUX_ARM_ARCH__" is not defined, evaluates to 0 [-Wundef]
     199 | #elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
         |       ^~~~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/asm-offsets.c:16:
>> arch/arm/include/asm/glue-df.h:96:2: error: #error Unknown data abort handler type
      96 | #error Unknown data abort handler type
         |  ^~~~~
   In file included from arch/arm/kernel/asm-offsets.c:17:
>> arch/arm/include/asm/glue-pf.h:51:2: error: #error Unknown prefetch abort handler type
      51 | #error Unknown prefetch abort handler type
         |  ^~~~~
   make[2]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1205: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +126 arch/arm/include/asm/glue-cache.h

55bdd694116597d Catalin Marinas 2010-05-21  124  
753790e713d80b5 Russell King    2011-02-06  125  #if !defined(_CACHE) && !defined(MULTI_CACHE)
25985edcedea639 Lucas De Marchi 2011-03-30 @126  #error Unknown cache maintenance model
753790e713d80b5 Russell King    2011-02-06  127  #endif
753790e713d80b5 Russell King    2011-02-06  128  

:::::: The code at line 126 was first introduced by commit
:::::: 25985edcedea6396277003854657b5f3cb31a628 Fix common misspellings

:::::: TO: Lucas De Marchi <lucas.demarchi@profusion.mobi>
:::::: CC: Lucas De Marchi <lucas.demarchi@profusion.mobi>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
