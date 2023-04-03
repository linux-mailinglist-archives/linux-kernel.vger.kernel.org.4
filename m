Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407EB6D3C4E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 06:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjDCEKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 00:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjDCEKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 00:10:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FEAF2E
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680494989; x=1712030989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3I1XMcoWzzyg6EtbtGjBzQu82JNz9MTciBhWpBmDwds=;
  b=edg5qW0jLPZraYsaQIaZc+ocjuc96m5p9To0/9M+qmK9HPwpQqI8lMAk
   OlPrEaQPrYidYVNoDSogncf5LHkiO0XJZ+geSaDJruoEIMit1RMZgUsgJ
   vUi6keOyR5/Cl7wtFh48d3BbovqTcXBV92O9zXRRsrsVGp6aO2ABYQASc
   ZLyDHgOidwiVpue6dl7I0UQVmz1EraTAV4lFciRdhQmQJxioldphuQgHd
   WNGXUN0eaqYAv2qG2ajtAeKAtGcOo94CkGmPgyWT4NtNSqippUmtZz210
   7jr+gNLgx8b31d1RQla3DliTbXVGBEBgoLMDudRkWpbunUcyMFY/5kIUm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="321463939"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="321463939"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 21:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="685808954"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="685808954"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2023 21:09:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjBVq-000Nyl-1j;
        Mon, 03 Apr 2023 04:09:46 +0000
Date:   Mon, 3 Apr 2023 12:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/rcuref 2/2] include/asm-generic/cmpxchg-local.h:30:42:
 sparse: sparse: cast truncates bits from constant value (e0000000 becomes 0)
Message-ID: <202304031213.U9LRonKm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
head:   ee1ee6db07795d9637bc5e8993a8ddcf886541ef
commit: ee1ee6db07795d9637bc5e8993a8ddcf886541ef [2/2] atomics: Provide rcuref - scalable reference counting
config: nios2-randconfig-s042-20230402 (https://download.01.org/0day-ci/archive/20230403/202304031213.U9LRonKm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip locking/rcuref
        git checkout ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304031213.U9LRonKm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/rcuref.c: note: in included file (through include/asm-generic/cmpxchg.h, arch/nios2/include/generated/asm/cmpxchg.h, include/asm-generic/atomic.h, ...):
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (e0000000 becomes 0)
   include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (e0000000 becomes 0)

vim +30 include/asm-generic/cmpxchg-local.h

068fbad288a2c1 Mathieu Desnoyers 2008-02-07   7  
aa93685afbefa0 Behan Webster     2012-11-20   8  extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
aa93685afbefa0 Behan Webster     2012-11-20   9  	__noreturn;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  10  
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  11  /*
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  12   * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  13   * long parameter, supporting various types of architectures.
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  14   */
6988631bdfddce Mark Rutland      2021-05-25  15  static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  16  		unsigned long old, unsigned long new, int size)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  17  {
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  18  	unsigned long flags, prev;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  19  
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  20  	/*
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  21  	 * Sanity checking, compile-time.
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  22  	 */
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  23  	if (size == 8 && sizeof(unsigned long) != 8)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  24  		wrong_size_cmpxchg(ptr);
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  25  
5042afe7fe3239 Ingo Molnar       2009-07-03  26  	raw_local_irq_save(flags);
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  27  	switch (size) {
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  28  	case 1: prev = *(u8 *)ptr;
6246541522845a Matt Evans        2023-02-01  29  		if (prev == (u8)old)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07 @30  			*(u8 *)ptr = (u8)new;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  31  		break;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  32  	case 2: prev = *(u16 *)ptr;
6246541522845a Matt Evans        2023-02-01  33  		if (prev == (u16)old)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  34  			*(u16 *)ptr = (u16)new;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  35  		break;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  36  	case 4: prev = *(u32 *)ptr;
6246541522845a Matt Evans        2023-02-01  37  		if (prev == (u32)old)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  38  			*(u32 *)ptr = (u32)new;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  39  		break;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  40  	case 8: prev = *(u64 *)ptr;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  41  		if (prev == old)
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  42  			*(u64 *)ptr = (u64)new;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  43  		break;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  44  	default:
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  45  		wrong_size_cmpxchg(ptr);
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  46  	}
5042afe7fe3239 Ingo Molnar       2009-07-03  47  	raw_local_irq_restore(flags);
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  48  	return prev;
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  49  }
068fbad288a2c1 Mathieu Desnoyers 2008-02-07  50  

:::::: The code at line 30 was first introduced by commit
:::::: 068fbad288a2c18b75b0425fb56d241f018a1cb5 Add cmpxchg_local to asm-generic for per cpu atomic operations

:::::: TO: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
