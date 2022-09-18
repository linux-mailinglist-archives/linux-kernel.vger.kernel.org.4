Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA55BC0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 01:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIRXb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIRXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 19:31:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19492EF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663543913; x=1695079913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=czmpxAPNAOWsEDPU/EqkLvFyBJLiMHpQn8wJHasi29I=;
  b=RwtHAEwCnZeFgBIeRJxIGSMCnU+eu+A/XdXWHVaipnrn3L5E4Ahs/MY6
   36LiYzjq6F+5/tle4ZcFgghg6xCQNRjOpl3yIRiKOp54kDNTt7FM9nVu6
   vKwfSDTc1mA4JbvUwUzJgxqMJSn+XJ2OVbjhJHJ2Hy5rG8FFy1n3XhyD5
   xZvsecLlc7GE9O2X+ZnbAgjsag1pucWiUMFbxBz06yH749xQbFGnXh6BT
   QuYVt7xbxNeaV3/72NR07myBd7g6Yu4g1vMaNViw2pTGWuo9PB8M9Mbtn
   B7h8iqlUSm9aZY/25cfNbw7C/BKNe8zYbVXJfn/Tcop+u5db8OqVtRYER
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="385562009"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="385562009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 16:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569440592"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 16:31:52 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa3lP-0001YE-1y;
        Sun, 18 Sep 2022 23:31:51 +0000
Date:   Mon, 19 Sep 2022 07:31:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 16/22]
 include/asm-generic/pgtable-nop4d.h:11:33: error: 'PGDIR_SHIFT' undeclared;
 did you mean 'PUD_SHIFT'?
Message-ID: <202209190746.tamxmZS8-lkp@intel.com>
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

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   91eb2dbfe9f923835245b3fbd3fb824bb204f4d5
commit: 1e2051e6215765d0f2663480742dd0afdb98c93f [16/22] devdax: Move address_space helpers to the DAX core
config: m68k-amcore_defconfig (https://download.01.org/0day-ci/archive/20220919/202209190746.tamxmZS8-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=1e2051e6215765d0f2663480742dd0afdb98c93f
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 1e2051e6215765d0f2663480742dd0afdb98c93f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/filemap.c:15:
   include/linux/dax.h: In function 'pe_order':
   include/linux/dax.h:324:24: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
     324 |                 return PMD_SHIFT - PAGE_SHIFT;
         |                        ^~~~~~~~~
         |                        PUD_SHIFT
   include/linux/dax.h:324:24: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from arch/m68k/include/asm/pgtable_no.h:5,
                    from arch/m68k/include/asm/pgtable.h:3,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from include/linux/dax.h:6:
>> include/asm-generic/pgtable-nop4d.h:11:33: error: 'PGDIR_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
      11 | #define P4D_SHIFT               PGDIR_SHIFT
         |                                 ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:25: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT       P4D_SHIFT
         |                         ^~~~~~~~~
   include/linux/dax.h:326:24: note: in expansion of macro 'PUD_SHIFT'
     326 |                 return PUD_SHIFT - PAGE_SHIFT;
         |                        ^~~~~~~~~
--
   In file included from fs/binfmt_elf_fdpic.c:37:
   include/linux/dax.h: In function 'pe_order':
   include/linux/dax.h:324:24: error: 'PMD_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
     324 |                 return PMD_SHIFT - PAGE_SHIFT;
         |                        ^~~~~~~~~
         |                        PUD_SHIFT
   include/linux/dax.h:324:24: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/asm-generic/pgtable-nopud.h:7,
                    from arch/m68k/include/asm/pgtable_no.h:5,
                    from arch/m68k/include/asm/pgtable.h:3,
                    from include/linux/pgtable.h:6,
                    from include/linux/mm.h:29,
                    from fs/binfmt_elf_fdpic.c:17:
>> include/asm-generic/pgtable-nop4d.h:11:33: error: 'PGDIR_SHIFT' undeclared (first use in this function); did you mean 'PUD_SHIFT'?
      11 | #define P4D_SHIFT               PGDIR_SHIFT
         |                                 ^~~~~~~~~~~
   include/asm-generic/pgtable-nopud.h:18:25: note: in expansion of macro 'P4D_SHIFT'
      18 | #define PUD_SHIFT       P4D_SHIFT
         |                         ^~~~~~~~~
   include/linux/dax.h:326:24: note: in expansion of macro 'PUD_SHIFT'
     326 |                 return PUD_SHIFT - PAGE_SHIFT;
         |                        ^~~~~~~~~
   fs/binfmt_elf_fdpic.c: In function 'elf_fdpic_map_file':
   fs/binfmt_elf_fdpic.c:748:23: warning: variable 'load_addr' set but not used [-Wunused-but-set-variable]
     748 |         unsigned long load_addr, stop;
         |                       ^~~~~~~~~
   fs/binfmt_elf_fdpic.c: In function 'elf_fdpic_map_file_by_direct_mmap':
   fs/binfmt_elf_fdpic.c:1027:52: warning: variable 'excess1' set but not used [-Wunused-but-set-variable]
    1027 |                 unsigned long maddr, disp, excess, excess1;
         |                                                    ^~~~~~~


vim +11 include/asm-generic/pgtable-nop4d.h

048456dcf2c56a Kirill A. Shutemov 2017-03-09  10  
048456dcf2c56a Kirill A. Shutemov 2017-03-09 @11  #define P4D_SHIFT		PGDIR_SHIFT
048456dcf2c56a Kirill A. Shutemov 2017-03-09  12  #define PTRS_PER_P4D		1
048456dcf2c56a Kirill A. Shutemov 2017-03-09  13  #define P4D_SIZE		(1UL << P4D_SHIFT)
048456dcf2c56a Kirill A. Shutemov 2017-03-09  14  #define P4D_MASK		(~(P4D_SIZE-1))
048456dcf2c56a Kirill A. Shutemov 2017-03-09  15  

:::::: The code at line 11 was first introduced by commit
:::::: 048456dcf2c56ad6f6248e2899dda92fb6a613f6 asm-generic: introduce <asm-generic/pgtable-nop4d.h>

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
