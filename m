Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8721B6A2759
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 06:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBYFTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 00:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBYFTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 00:19:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A043456
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 21:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677302360; x=1708838360;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5vjHpxGxqnWA//v6OjUwBNX5IJKbB99pEe49io9ddTo=;
  b=dVVI9BmPwa77CPoch/zrq1A7UAVRjV0XktEtDS2j9gmeaFqEZPoeFLsG
   T1OyUeJkb5PkdV74UKyR5JCc+FKO0XenQUjfKPuV/pTZVbQFTEeQD43u4
   8DYLLP/3nL5uxze8gwY1ztEvM+t/VSAoJnOhDjxeaQ6+D1CTbhfMK3GD2
   RfvTOu/2vVj8lbU4zFbPpaBer1udJkmxJXxEpQfYNVJ8WmOQgtb3emNU3
   Pu4kqHRkPPlFvV2/WnFcIXCD6xHiTkaBCt42yAp4/zkx/FO8P92RwSNcW
   K/HudKspvYDpE4Iik1ZESqRgSUbwTicPYk/fzmKpE46mop1WGgoebqG9s
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="335874308"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="335874308"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 21:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="622951021"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="622951021"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Feb 2023 21:19:18 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVmxq-0002wf-0r;
        Sat, 25 Feb 2023 05:19:18 +0000
Date:   Sat, 25 Feb 2023 13:19:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matt Evans <mev@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: include/asm-generic/cmpxchg-local.h:29:33: sparse: sparse: cast
 truncates bits from constant value (5f0ecafe becomes fe)
Message-ID: <202302251316.oOXZoZwJ-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   489fa31ea873282b41046d412ec741f93946fc2d
commit: 6246541522845a443b7ae4a8f0e16facc5a91198 locking/atomic: cmpxchg: Make __generic_cmpxchg_local compare against zero-extended 'old' value
date:   3 weeks ago
config: csky-randconfig-s053-20230222 (https://download.01.org/0day-ci/archive/20230225/202302251316.oOXZoZwJ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6246541522845a443b7ae4a8f0e16facc5a91198
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6246541522845a443b7ae4a8f0e16facc5a91198
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302251316.oOXZoZwJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/erofs/zdata.c: note: in included file (through include/asm-generic/cmpxchg.h, arch/csky/include/asm/cmpxchg.h, include/asm-generic/atomic.h, ...):
   include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (e0f510cc becomes cc)
   include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (e0f510cc becomes 10cc)
>> include/asm-generic/cmpxchg-local.h:29:33: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>> include/asm-generic/cmpxchg-local.h:33:34: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
>> include/asm-generic/cmpxchg-local.h:29:33: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
   include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
>> include/asm-generic/cmpxchg-local.h:33:34: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
   include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (5f0edead becomes dead)

vim +29 include/asm-generic/cmpxchg-local.h

     7	
     8	extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
     9		__noreturn;
    10	
    11	/*
    12	 * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
    13	 * long parameter, supporting various types of architectures.
    14	 */
    15	static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
    16			unsigned long old, unsigned long new, int size)
    17	{
    18		unsigned long flags, prev;
    19	
    20		/*
    21		 * Sanity checking, compile-time.
    22		 */
    23		if (size == 8 && sizeof(unsigned long) != 8)
    24			wrong_size_cmpxchg(ptr);
    25	
    26		raw_local_irq_save(flags);
    27		switch (size) {
    28		case 1: prev = *(u8 *)ptr;
  > 29			if (prev == (u8)old)
  > 30				*(u8 *)ptr = (u8)new;
    31			break;
    32		case 2: prev = *(u16 *)ptr;
  > 33			if (prev == (u16)old)
    34				*(u16 *)ptr = (u16)new;
    35			break;
    36		case 4: prev = *(u32 *)ptr;
    37			if (prev == (u32)old)
    38				*(u32 *)ptr = (u32)new;
    39			break;
    40		case 8: prev = *(u64 *)ptr;
    41			if (prev == old)
    42				*(u64 *)ptr = (u64)new;
    43			break;
    44		default:
    45			wrong_size_cmpxchg(ptr);
    46		}
    47		raw_local_irq_restore(flags);
    48		return prev;
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
