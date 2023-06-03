Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4285720ED7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 11:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjFCJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 05:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjFCJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:04:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650C1B5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685783070; x=1717319070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WIApp3OlGSkGOblYByLOHClRSb3CkPt3DE7Ui2gCThE=;
  b=IkuUOsVkj5AtQAbJUgWVKP+5fkDLORAXU7xoNQfdLQmBSgjOEOz8tMBM
   2MHp55phA7BYflPHZVYImInzX7Q6jn7DMS5anlmbROARt1I6+gP/NU+7R
   Vedsb8YK0ApUIV64iJDhn07De+E1MzwCr26a3MGBZ9f95x4fV6RHdhrFf
   1ZsPxypa7nkuNHigFyZ2Y0nwfDXuSQO6KNiP/TMFLpG7OmpauqJcdH3i5
   bXGUcWwQQtKB5hu87vC9HWAzg5LN8rih5lRSnD827WMFq80mLy9QHsvui
   7tqW6m2ugL7RHyGaa/In2I1rcch5nXGvV2Y+GA5LWWjGZWoBun8bOqKIt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="356063979"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="356063979"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 02:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="954771717"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="954771717"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2023 02:04:28 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5NBT-0001TN-2O;
        Sat, 03 Jun 2023 09:04:27 +0000
Date:   Sat, 3 Jun 2023 17:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230602 7/7]
 arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is
 outside array bounds of 'struct tt_entry[1]'
Message-ID: <202306031638.zmtz006C-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230602
head:   20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
commit: 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8 [7/7] Makefile: Enable -Warray-bounds
config: sparc-randconfig-c043-20230531 (https://download.01.org/0day-ci/archive/20230603/202306031638.zmtz006C-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fam01-next20230602
        git checkout 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306031638.zmtz006C-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/irq_32.c: In function 'sparc_floppy_request_irq':
>> arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     258 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
         |              ^
   arch/sparc/kernel/irq_32.c:272:17: note: in expansion of macro 'INSTANTIATE'
     272 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   In file included from arch/sparc/kernel/irq_32.c:25:
   arch/sparc/kernel/kernel.h:142:24: note: at offset [256, 1264] into object 'trapbase_cpu1' of size 16
     142 | extern struct tt_entry trapbase_cpu1;
         |                        ^~~~~~~~~~~~~
   In file included from arch/sparc/include/asm/traps.h:10,
                    from arch/sparc/kernel/kernel.h:8:
   arch/sparc/kernel/irq_32.c:261:46: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     261 |                              (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/include/uapi/asm/traps.h:27:38: note: in definition of macro 'SPARC_BRANCH'
      27 |           (0x10800000 | (((dest_addr-inst_addr)>>2)&0x3fffff))
         |                                      ^~~~~~~~~
   arch/sparc/kernel/irq_32.c:272:17: note: in expansion of macro 'INSTANTIATE'
     272 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:142:24: note: at offset [256, 1264] into object 'trapbase_cpu1' of size 16
     142 | extern struct tt_entry trapbase_cpu1;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:259:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     259 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
         |              ^
   arch/sparc/kernel/irq_32.c:272:17: note: in expansion of macro 'INSTANTIATE'
     272 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:142:24: note: at offset [256, 1264] into object 'trapbase_cpu1' of size 16
     142 | extern struct tt_entry trapbase_cpu1;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:262:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     262 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
         |              ^
   arch/sparc/kernel/irq_32.c:272:17: note: in expansion of macro 'INSTANTIATE'
     272 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:142:24: note: at offset [256, 1264] into object 'trapbase_cpu1' of size 16
     142 | extern struct tt_entry trapbase_cpu1;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:263:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     263 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
         |              ^
   arch/sparc/kernel/irq_32.c:272:17: note: in expansion of macro 'INSTANTIATE'
     272 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:142:24: note: at offset [256, 1264] into object 'trapbase_cpu1' of size 16
     142 | extern struct tt_entry trapbase_cpu1;
         |                        ^~~~~~~~~~~~~
>> arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     258 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
         |              ^
   arch/sparc/kernel/irq_32.c:274:17: note: in expansion of macro 'INSTANTIATE'
     274 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:143:24: note: at offset [256, 1264] into object 'trapbase_cpu2' of size 16
     143 | extern struct tt_entry trapbase_cpu2;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:261:46: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     261 |                              (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/include/uapi/asm/traps.h:27:38: note: in definition of macro 'SPARC_BRANCH'
      27 |           (0x10800000 | (((dest_addr-inst_addr)>>2)&0x3fffff))
         |                                      ^~~~~~~~~
   arch/sparc/kernel/irq_32.c:274:17: note: in expansion of macro 'INSTANTIATE'
     274 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:143:24: note: at offset [256, 1264] into object 'trapbase_cpu2' of size 16
     143 | extern struct tt_entry trapbase_cpu2;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:259:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     259 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
         |              ^
   arch/sparc/kernel/irq_32.c:274:17: note: in expansion of macro 'INSTANTIATE'
     274 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:143:24: note: at offset [256, 1264] into object 'trapbase_cpu2' of size 16
     143 | extern struct tt_entry trapbase_cpu2;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:262:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     262 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
         |              ^
   arch/sparc/kernel/irq_32.c:274:17: note: in expansion of macro 'INSTANTIATE'
     274 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:143:24: note: at offset [256, 1264] into object 'trapbase_cpu2' of size 16
     143 | extern struct tt_entry trapbase_cpu2;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:263:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     263 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
         |              ^
   arch/sparc/kernel/irq_32.c:274:17: note: in expansion of macro 'INSTANTIATE'
     274 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:143:24: note: at offset [256, 1264] into object 'trapbase_cpu2' of size 16
     143 | extern struct tt_entry trapbase_cpu2;
         |                        ^~~~~~~~~~~~~
>> arch/sparc/kernel/irq_32.c:258:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     258 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
         |              ^
   arch/sparc/kernel/irq_32.c:276:17: note: in expansion of macro 'INSTANTIATE'
     276 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:144:24: note: at offset [256, 1264] into object 'trapbase_cpu3' of size 16
     144 | extern struct tt_entry trapbase_cpu3;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:261:46: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     261 |                              (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/sparc/include/uapi/asm/traps.h:27:38: note: in definition of macro 'SPARC_BRANCH'
      27 |           (0x10800000 | (((dest_addr-inst_addr)>>2)&0x3fffff))
         |                                      ^~~~~~~~~
   arch/sparc/kernel/irq_32.c:276:17: note: in expansion of macro 'INSTANTIATE'
     276 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:144:24: note: at offset [256, 1264] into object 'trapbase_cpu3' of size 16
     144 | extern struct tt_entry trapbase_cpu3;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:259:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     259 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
         |              ^
   arch/sparc/kernel/irq_32.c:276:17: note: in expansion of macro 'INSTANTIATE'
     276 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:144:24: note: at offset [256, 1264] into object 'trapbase_cpu3' of size 16
     144 | extern struct tt_entry trapbase_cpu3;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:262:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     262 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
         |              ^
   arch/sparc/kernel/irq_32.c:276:17: note: in expansion of macro 'INSTANTIATE'
     276 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:144:24: note: at offset [256, 1264] into object 'trapbase_cpu3' of size 16
     144 | extern struct tt_entry trapbase_cpu3;
         |                        ^~~~~~~~~~~~~
   arch/sparc/kernel/irq_32.c:263:14: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]
     263 |         table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
         |              ^
   arch/sparc/kernel/irq_32.c:276:17: note: in expansion of macro 'INSTANTIATE'
     276 |                 INSTANTIATE(trap_table)
         |                 ^~~~~~~~~~~
   arch/sparc/kernel/kernel.h:144:24: note: at offset [256, 1264] into object 'trapbase_cpu3' of size 16
     144 | extern struct tt_entry trapbase_cpu3;
         |                        ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +258 arch/sparc/kernel/irq_32.c

^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  240  
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  241  int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  242  {
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  243  	unsigned int cpu_irq;
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  244  	int err;
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  245  
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  246  
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  247  	err = request_irq(irq, irq_handler, 0, "floppy", NULL);
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  248  	if (err)
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  249  		return -1;
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  250  
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  251  	/* Save for later use in floppy interrupt handler */
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  252  	floppy_irq = irq;
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  253  
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  254  	cpu_irq = (irq & (NR_IRQS - 1));
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  255  
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  256  	/* Dork with trap table if we get this far. */
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  257  #define INSTANTIATE(table) \
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16 @258  	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_one = SPARC_RD_PSR_L0; \
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  259  	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two = \
6baa9b20a68a88 arch/sparc/kernel/irq_32.c Sam Ravnborg   2011-04-18  260  		SPARC_BRANCH((unsigned long) floppy_hardint, \
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  261  			     (unsigned long) &table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_two);\
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  262  	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_three = SPARC_RD_WIM_L3; \
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  263  	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  264  
^1da177e4c3f41 arch/sparc/kernel/irq.c    Linus Torvalds 2005-04-16  265  	INSTANTIATE(sparc_ttable)
b08b5c9c9b35c9 arch/sparc/kernel/irq_32.c Sam Ravnborg   2012-05-25  266  

:::::: The code at line 258 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
