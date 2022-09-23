Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B285E8258
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiIWTFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIWTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:05:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15CAA3D75
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663959904; x=1695495904;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YkbF167qKa4BtHKOjrejr/KpiaR+fUFgfEok5NmFkLw=;
  b=QFRrCCj3bA960FlIjNzC1AHG/Pcu0IdsjF/SMSVJ8fXh3wxuJK9YAQTE
   ek0RpeyNiqeZbqPWQkvtz8L4PykltdR/fKqysF45mBqTQNPQnyV1Gak7v
   h/HPp4J/WOEEtsOwQet1rG+c/AwYZKJFkemty8fvSHBp7njcUxtlUezSA
   yNIJvN3d8Xfl084XMKpEZyQqXOZ8jUzTX93KBXDLB84VlrFgWFNaqlHrz
   ABPdSSNC7X4HGIDWMdbqTz60c6PMcIIeckbdfTZtx/avtsCHBpX+oW7MS
   OYMW3ef0hlOMRPh1sHSeWj83iBjHd+A4nlgJ/TVh3nFsH9uQD1S+eQXsO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="287791599"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="287791599"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 12:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="949133577"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 12:05:02 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obnyw-0005sS-0N;
        Fri, 23 Sep 2022 19:05:02 +0000
Date:   Sat, 24 Sep 2022 03:04:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [peterz-queue:call-depth-tracking 59/60]
 ./include/generated/asm-offsets.h:81: warning: "TASK_SIZE" redefined
Message-ID: <202209240243.vRVXCjW9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking
head:   856304fc062b9ad34742a604b98cc775846c0cb3
commit: 46f9bf3269a589dc0258ae68c32e064e25a0a149 [59/60] x86/ftrace: Make it call depth tracking aware
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220924/202209240243.vRVXCjW9-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=46f9bf3269a589dc0258ae68c32e064e25a0a149
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue call-depth-tracking
        git checkout 46f9bf3269a589dc0258ae68c32e064e25a0a149
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3846:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3846 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3913:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3913 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/asm-offsets.h:1,
                    from kernel/trace/trace_selftest.c:10,
                    from kernel/trace/trace.c:8672:
   ./include/generated/asm-offsets.h: At top level:
>> ./include/generated/asm-offsets.h:81: warning: "TASK_SIZE" redefined
      81 | #define TASK_SIZE -1342177280 /* TASK_SIZE */
         | 
   In file included from arch/powerpc/include/asm/processor.h:73,
                    from arch/powerpc/include/asm/thread_info.h:46,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
   arch/powerpc/include/asm/task_size_32.h:9: note: this is the location of the previous definition
       9 | #define TASK_SIZE (CONFIG_TASK_SIZE)
         | 
--
   In file included from arch/powerpc/include/asm/asm-offsets.h:1,
                    from kernel/trace/trace_selftest.c:10,
                    from kernel/trace/trace.c:8672:
>> ./include/generated/asm-offsets.h:81: warning: "TASK_SIZE" redefined
      81 | #define TASK_SIZE -1342177280 /* TASK_SIZE */
         | 
   In file included from arch/powerpc/include/asm/processor.h:73,
                    from arch/powerpc/include/asm/thread_info.h:46,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/powerpc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from include/linux/ring_buffer.h:5,
                    from kernel/trace/trace.c:15:
   arch/powerpc/include/asm/task_size_32.h:9: note: this is the location of the previous definition
       9 | #define TASK_SIZE (CONFIG_TASK_SIZE)
         | 

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
