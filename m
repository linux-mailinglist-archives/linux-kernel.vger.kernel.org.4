Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266865BE37B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiITKkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiITKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:39:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AD72ECE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663670310; x=1695206310;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aeBrDIrVe8g9dLNlyIy4QoE4kOUNc8aIBq98s8lndEQ=;
  b=PFOavRYfkUkz8NJhAp2erJzR0KZW4+WFml9PIYqVBsjyuLe9EZ5RtSfz
   712TBXQBK/xZdiqO3aHtQDpusnDCKVkPix7D9fpbOs4eijLD9hWxyL8Aj
   aVJ7j6j37v+lCGrrCCYXfQFMpOJCPU7LS6IIr8OpytJB+84N7yDxUeVQB
   ygAMHVnyiSNbezfRuGaq0yPqM8qPezFrTHuddJodqmyN3pzVUGI7opt3s
   gfx9Q90ecwsQSLrwwkiomS3wmmvtrgSx3n9N1MUfhqvWrE3jkZzR/eVzR
   6E93FG7LXnuTG7pv5yXsu/uMqSz4hzKP4KX2t4zhWaTNd/Z430mLXO2Pd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="280039490"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="280039490"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="596466569"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2022 03:38:28 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaae3-0002gH-3D;
        Tue, 20 Sep 2022 10:38:28 +0000
Date:   Tue, 20 Sep 2022 18:38:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [peterz-queue:call-depth-tracking 58/59]
 kernel/trace/trace_selftest.c:790:13: error: expected string literal before
 'CALL_DEPTH_ACCOUNT'
Message-ID: <202209201840.v9c1rxIQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git call-depth-tracking
head:   bc7583c5f43c957cb0b0f3e24d079b91576c1127
commit: 16f591798c7808329b716802f8d494a7bf014ede [58/59] x86/ftrace: Make it call depth tracking aware
config: s390-randconfig-r044-20220919 (https://download.01.org/0day-ci/archive/20220920/202209201840.v9c1rxIQ-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=16f591798c7808329b716802f8d494a7bf014ede
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue call-depth-tracking
        git checkout 16f591798c7808329b716802f8d494a7bf014ede
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/trace.c: In function 'trace_check_vprintf':
   kernel/trace/trace.c:3846:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3846 |                 trace_seq_vprintf(&iter->seq, iter->fmt, ap);
         |                 ^~~~~~~~~~~~~~~~~
   kernel/trace/trace.c:3913:17: warning: function 'trace_check_vprintf' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3913 |                 trace_seq_vprintf(&iter->seq, p, ap);
         |                 ^~~~~~~~~~~~~~~~~
   In file included from kernel/trace/trace.c:8672:
   kernel/trace/trace_selftest.c: In function 'trace_direct_tramp':
>> kernel/trace/trace_selftest.c:790:13: error: expected string literal before 'CALL_DEPTH_ACCOUNT'
     790 |         asm(CALL_DEPTH_ACCOUNT);
         |             ^~~~~~~~~~~~~~~~~~


vim +/CALL_DEPTH_ACCOUNT +790 kernel/trace/trace_selftest.c

   786	
   787	#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
   788	noinline __noclone static void trace_direct_tramp(void)
   789	{
 > 790		asm(CALL_DEPTH_ACCOUNT);
   791	}
   792	#endif
   793	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
