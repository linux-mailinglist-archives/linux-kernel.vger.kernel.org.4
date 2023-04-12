Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBC6DF45C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjDLLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjDLLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:55:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A317D9C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681300511; x=1712836511;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yYkLxF/SmUCDB3kkllNWZh44ZeQ7GIwGXZpUz0asZeY=;
  b=DiLvyCBdXNoHHO0ZYvqUP1rIubsU7kvnyP0/SxqV3f19z2Mrmyqu7vAU
   XcGzO0XXbpQ6NQuT41JlRaoPs6ic869XWqCwufd6VeHLKz4qjsviWymo/
   nF3P0JEMmzQzSeW4TolxKE7lFATB8EQQjMCoR4CLooE8QO9wd1205rOKX
   SgsM40fOs4uDOlHGpCQPSPAVjg+JJ3b1bMiE8dnnxyqZbrh5sdoB8MwQP
   OOIOffy4VEoRc6rUnbuCgMwUxFO9InrnvukSHDFDWP7mq+4zOgk5qc4ij
   jzl1fME3YYNZRnxTW7cxv2rSe/cdihzX4rpNR1zzy2cZXIZbIwi5W9qxB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="430156942"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="430156942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="688931525"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="688931525"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2023 04:55:08 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmZ48-000XhT-0v;
        Wed, 12 Apr 2023 11:55:08 +0000
Date:   Wed, 12 Apr 2023 19:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/rcuref 2/2] arch/sparc/include/asm/cmpxchg_64.h:161:55:
 sparse: sparse: cast truncates bits from constant value (ffffffffe0000000
 becomes 0)
Message-ID: <202304121909.hsRwqwP8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
head:   ee1ee6db07795d9637bc5e8993a8ddcf886541ef
commit: ee1ee6db07795d9637bc5e8993a8ddcf886541ef [2/2] atomics: Provide rcuref - scalable reference counting
config: sparc-randconfig-s053-20230409 (https://download.01.org/0day-ci/archive/20230412/202304121909.hsRwqwP8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304121909.hsRwqwP8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/rcuref.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)

vim +161 arch/sparc/include/asm/cmpxchg_64.h

d550bbd40c0e10 David Howells 2012-03-28  155  
d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
d550bbd40c0e10 David Howells 2012-03-28  158  {
d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
d550bbd40c0e10 David Howells 2012-03-28  166  	}
d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
d550bbd40c0e10 David Howells 2012-03-28  169  }
d550bbd40c0e10 David Howells 2012-03-28  170  

:::::: The code at line 161 was first introduced by commit
:::::: a12ee2349312d7112b9b7c6ac2e70c5ec2ca334e arch/sparc: Introduce cmpxchg_u8 SPARC

:::::: TO: Babu Moger <babu.moger@oracle.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
