Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0372249D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFELbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjFELbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:31:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387D8E62
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685964682; x=1717500682;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0ulTHCu0dWlFReX+g9saVyf71DwoFVeM4FyJ+Cin74M=;
  b=UAHjdqyaTWmxznUAaF6aBBjyTOl04SpVgh+7dUvPcmLrFidRerZ6lzOl
   AXggL4t+XmH1JgGpVG77kzskpGWVmveBVkiZFWAvhSDyEQj8ZpWIo5haA
   7dc1k0WqOdoK8onUQB2T1ry1PHBT0uuefEJ4ffB59oGSLmGDk6841dqPN
   L1iwDELeCusDy85xPNM85rVGyc9Y2wEk8mbnizYIQ+nU4mDYbQ2cgeWql
   BKQiyZnsd5wGg2GYtgHFULKdQJc8Ie50FS3UNhCd3OL8FILIQIIjCVWOJ
   tLG7Rf60LoOXWKOx8UYaT4fl1ROq/1TFdCxmgKHQt/3AHG/bds5dso1bi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353837687"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353837687"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 04:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038739942"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038739942"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2023 04:31:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q68QP-00049K-2A;
        Mon, 05 Jun 2023 11:31:01 +0000
Date:   Mon, 5 Jun 2023 19:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/mips/sibyte/sb1250/smp.c:21:9: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202306051900.1PVI95R9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9561de3a55bed6bdd44a12820ba81ec416e705a7
commit: 0345234720ca5601b59f20570f71139f5ad4d229 MIPS: sibyte: Replace BCM1125H with SB1250 option
date:   3 months ago
config: mips-randconfig-s042-20230605 (https://download.01.org/0day-ci/archive/20230605/202306051900.1PVI95R9-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0345234720ca5601b59f20570f71139f5ad4d229
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0345234720ca5601b59f20570f71139f5ad4d229
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/sibyte/sb1250/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306051900.1PVI95R9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/mips/sibyte/sb1250/smp.c:21:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:21:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:21:9: sparse:     got void [noderef] __iomem *
   arch/mips/sibyte/sb1250/smp.c:22:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:22:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:22:9: sparse:     got void [noderef] __iomem *
   arch/mips/sibyte/sb1250/smp.c:26:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:26:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:26:9: sparse:     got void [noderef] __iomem *
   arch/mips/sibyte/sb1250/smp.c:27:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:27:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:27:9: sparse:     got void [noderef] __iomem *
   arch/mips/sibyte/sb1250/smp.c:31:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:31:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:31:9: sparse:     got void [noderef] __iomem *
   arch/mips/sibyte/sb1250/smp.c:32:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/sibyte/sb1250/smp.c:32:9: sparse:     expected void *
   arch/mips/sibyte/sb1250/smp.c:32:9: sparse:     got void [noderef] __iomem *
>> arch/mips/sibyte/sb1250/smp.c:38:6: sparse: sparse: symbol 'sb1250_smp_init' was not declared. Should it be static?
>> arch/mips/sibyte/sb1250/smp.c:58:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/sibyte/sb1250/smp.c:58:61: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sibyte/sb1250/smp.c:58:61: sparse:     got void *
>> arch/mips/sibyte/sb1250/smp.c:155:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/sibyte/sb1250/smp.c:155:45: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sibyte/sb1250/smp.c:155:45: sparse:     got void *
   arch/mips/sibyte/sb1250/smp.c:158:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/sibyte/sb1250/smp.c:158:63: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sibyte/sb1250/smp.c:158:63: sparse:     got void *

vim +21 arch/mips/sibyte/sb1250/smp.c

^1da177e4c3f41 Linus Torvalds    2005-04-16   19  
^1da177e4c3f41 Linus Torvalds    2005-04-16   20  static void *mailbox_set_regs[] = {
65bda1a95d395c Maciej W. Rozycki 2005-02-22  @21  	IOADDR(A_IMR_CPU0_BASE + R_IMR_MAILBOX_SET_CPU),
65bda1a95d395c Maciej W. Rozycki 2005-02-22   22  	IOADDR(A_IMR_CPU1_BASE + R_IMR_MAILBOX_SET_CPU)
^1da177e4c3f41 Linus Torvalds    2005-04-16   23  };
^1da177e4c3f41 Linus Torvalds    2005-04-16   24  
^1da177e4c3f41 Linus Torvalds    2005-04-16   25  static void *mailbox_clear_regs[] = {
65bda1a95d395c Maciej W. Rozycki 2005-02-22   26  	IOADDR(A_IMR_CPU0_BASE + R_IMR_MAILBOX_CLR_CPU),
65bda1a95d395c Maciej W. Rozycki 2005-02-22   27  	IOADDR(A_IMR_CPU1_BASE + R_IMR_MAILBOX_CLR_CPU)
^1da177e4c3f41 Linus Torvalds    2005-04-16   28  };
^1da177e4c3f41 Linus Torvalds    2005-04-16   29  
^1da177e4c3f41 Linus Torvalds    2005-04-16   30  static void *mailbox_regs[] = {
65bda1a95d395c Maciej W. Rozycki 2005-02-22   31  	IOADDR(A_IMR_CPU0_BASE + R_IMR_MAILBOX_CPU),
65bda1a95d395c Maciej W. Rozycki 2005-02-22   32  	IOADDR(A_IMR_CPU1_BASE + R_IMR_MAILBOX_CPU)
^1da177e4c3f41 Linus Torvalds    2005-04-16   33  };
^1da177e4c3f41 Linus Torvalds    2005-04-16   34  
^1da177e4c3f41 Linus Torvalds    2005-04-16   35  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16   36   * SMP init and finish on secondary CPUs
^1da177e4c3f41 Linus Torvalds    2005-04-16   37   */
078a55fc824c16 Paul Gortmaker    2013-06-18  @38  void sb1250_smp_init(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16   39  {
^1da177e4c3f41 Linus Torvalds    2005-04-16   40  	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
^1da177e4c3f41 Linus Torvalds    2005-04-16   41  		STATUSF_IP1 | STATUSF_IP0;
^1da177e4c3f41 Linus Torvalds    2005-04-16   42  
^1da177e4c3f41 Linus Torvalds    2005-04-16   43  	/* Set interrupt mask, but don't enable */
^1da177e4c3f41 Linus Torvalds    2005-04-16   44  	change_c0_status(ST0_IM, imask);
^1da177e4c3f41 Linus Torvalds    2005-04-16   45  }
^1da177e4c3f41 Linus Torvalds    2005-04-16   46  
87353d8ac39c52 Ralf Baechle      2007-11-19   47  /*
87353d8ac39c52 Ralf Baechle      2007-11-19   48   * These are routines for dealing with the sb1250 smp capabilities
87353d8ac39c52 Ralf Baechle      2007-11-19   49   * independent of board/firmware
87353d8ac39c52 Ralf Baechle      2007-11-19   50   */
87353d8ac39c52 Ralf Baechle      2007-11-19   51  
87353d8ac39c52 Ralf Baechle      2007-11-19   52  /*
87353d8ac39c52 Ralf Baechle      2007-11-19   53   * Simple enough; everything is set up, so just poke the appropriate mailbox
87353d8ac39c52 Ralf Baechle      2007-11-19   54   * register, and we should be set
87353d8ac39c52 Ralf Baechle      2007-11-19   55   */
87353d8ac39c52 Ralf Baechle      2007-11-19   56  static void sb1250_send_ipi_single(int cpu, unsigned int action)
87353d8ac39c52 Ralf Baechle      2007-11-19   57  {
87353d8ac39c52 Ralf Baechle      2007-11-19  @58  	__raw_writeq((((u64)action) << 48), mailbox_set_regs[cpu]);
87353d8ac39c52 Ralf Baechle      2007-11-19   59  }
87353d8ac39c52 Ralf Baechle      2007-11-19   60  
48a048fed82a8e Rusty Russell     2009-09-24   61  static inline void sb1250_send_ipi_mask(const struct cpumask *mask,
48a048fed82a8e Rusty Russell     2009-09-24   62  					unsigned int action)
87353d8ac39c52 Ralf Baechle      2007-11-19   63  {
87353d8ac39c52 Ralf Baechle      2007-11-19   64  	unsigned int i;
87353d8ac39c52 Ralf Baechle      2007-11-19   65  
48a048fed82a8e Rusty Russell     2009-09-24   66  	for_each_cpu(i, mask)
87353d8ac39c52 Ralf Baechle      2007-11-19   67  		sb1250_send_ipi_single(i, action);
87353d8ac39c52 Ralf Baechle      2007-11-19   68  }
87353d8ac39c52 Ralf Baechle      2007-11-19   69  
87353d8ac39c52 Ralf Baechle      2007-11-19   70  /*
87353d8ac39c52 Ralf Baechle      2007-11-19   71   * Code to run on secondary just after probing the CPU
87353d8ac39c52 Ralf Baechle      2007-11-19   72   */
078a55fc824c16 Paul Gortmaker    2013-06-18   73  static void sb1250_init_secondary(void)
87353d8ac39c52 Ralf Baechle      2007-11-19   74  {
87353d8ac39c52 Ralf Baechle      2007-11-19   75  	extern void sb1250_smp_init(void);
87353d8ac39c52 Ralf Baechle      2007-11-19   76  
87353d8ac39c52 Ralf Baechle      2007-11-19   77  	sb1250_smp_init();
87353d8ac39c52 Ralf Baechle      2007-11-19   78  }
87353d8ac39c52 Ralf Baechle      2007-11-19   79  
87353d8ac39c52 Ralf Baechle      2007-11-19   80  /*
87353d8ac39c52 Ralf Baechle      2007-11-19   81   * Do any tidying up before marking online and running the idle
87353d8ac39c52 Ralf Baechle      2007-11-19   82   * loop
87353d8ac39c52 Ralf Baechle      2007-11-19   83   */
078a55fc824c16 Paul Gortmaker    2013-06-18   84  static void sb1250_smp_finish(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16   85  {
d527eef5b7f151 Ralf Baechle      2007-10-19   86  	extern void sb1250_clockevent_init(void);
d527eef5b7f151 Ralf Baechle      2007-10-19   87  
d527eef5b7f151 Ralf Baechle      2007-10-19   88  	sb1250_clockevent_init();
^1da177e4c3f41 Linus Torvalds    2005-04-16   89  	local_irq_enable();
^1da177e4c3f41 Linus Torvalds    2005-04-16   90  }
^1da177e4c3f41 Linus Torvalds    2005-04-16   91  
^1da177e4c3f41 Linus Torvalds    2005-04-16   92  /*
87353d8ac39c52 Ralf Baechle      2007-11-19   93   * Setup the PC, SP, and GP of a secondary processor and start it
87353d8ac39c52 Ralf Baechle      2007-11-19   94   * running!
^1da177e4c3f41 Linus Torvalds    2005-04-16   95   */
d595d423d06071 Paul Burton       2017-08-12   96  static int sb1250_boot_secondary(int cpu, struct task_struct *idle)
^1da177e4c3f41 Linus Torvalds    2005-04-16   97  {
87353d8ac39c52 Ralf Baechle      2007-11-19   98  	int retval;
87353d8ac39c52 Ralf Baechle      2007-11-19   99  
87353d8ac39c52 Ralf Baechle      2007-11-19  100  	retval = cfe_cpu_start(cpu_logical_map(cpu), &smp_bootstrap,
87353d8ac39c52 Ralf Baechle      2007-11-19  101  			       __KSTK_TOS(idle),
87353d8ac39c52 Ralf Baechle      2007-11-19  102  			       (unsigned long)task_thread_info(idle), 0);
87353d8ac39c52 Ralf Baechle      2007-11-19  103  	if (retval != 0)
87353d8ac39c52 Ralf Baechle      2007-11-19  104  		printk("cfe_start_cpu(%i) returned %i\n" , cpu, retval);
d595d423d06071 Paul Burton       2017-08-12  105  	return retval;
^1da177e4c3f41 Linus Torvalds    2005-04-16  106  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  107  
87353d8ac39c52 Ralf Baechle      2007-11-19  108  /*
87353d8ac39c52 Ralf Baechle      2007-11-19  109   * Use CFE to find out how many CPUs are available, setting up
0b5f9c005def15 Rusty Russell     2012-03-29  110   * cpu_possible_mask and the logical/physical mappings.
87353d8ac39c52 Ralf Baechle      2007-11-19  111   * XXXKW will the boot CPU ever not be physical 0?
87353d8ac39c52 Ralf Baechle      2007-11-19  112   *
87353d8ac39c52 Ralf Baechle      2007-11-19  113   * Common setup before any secondaries are started
87353d8ac39c52 Ralf Baechle      2007-11-19  114   */
87353d8ac39c52 Ralf Baechle      2007-11-19  115  static void __init sb1250_smp_setup(void)
87353d8ac39c52 Ralf Baechle      2007-11-19  116  {
87353d8ac39c52 Ralf Baechle      2007-11-19  117  	int i, num;
87353d8ac39c52 Ralf Baechle      2007-11-19  118  
0b5f9c005def15 Rusty Russell     2012-03-29  119  	init_cpu_possible(cpumask_of(0));
87353d8ac39c52 Ralf Baechle      2007-11-19  120  	__cpu_number_map[0] = 0;
87353d8ac39c52 Ralf Baechle      2007-11-19  121  	__cpu_logical_map[0] = 0;
87353d8ac39c52 Ralf Baechle      2007-11-19  122  
87353d8ac39c52 Ralf Baechle      2007-11-19  123  	for (i = 1, num = 0; i < NR_CPUS; i++) {
87353d8ac39c52 Ralf Baechle      2007-11-19  124  		if (cfe_cpu_stop(i) == 0) {
0b5f9c005def15 Rusty Russell     2012-03-29  125  			set_cpu_possible(i, true);
87353d8ac39c52 Ralf Baechle      2007-11-19  126  			__cpu_number_map[i] = ++num;
87353d8ac39c52 Ralf Baechle      2007-11-19  127  			__cpu_logical_map[num] = i;
87353d8ac39c52 Ralf Baechle      2007-11-19  128  		}
87353d8ac39c52 Ralf Baechle      2007-11-19  129  	}
87353d8ac39c52 Ralf Baechle      2007-11-19  130  	printk(KERN_INFO "Detected %i available secondary CPU(s)\n", num);
87353d8ac39c52 Ralf Baechle      2007-11-19  131  }
87353d8ac39c52 Ralf Baechle      2007-11-19  132  
87353d8ac39c52 Ralf Baechle      2007-11-19  133  static void __init sb1250_prepare_cpus(unsigned int max_cpus)
87353d8ac39c52 Ralf Baechle      2007-11-19  134  {
87353d8ac39c52 Ralf Baechle      2007-11-19  135  }
87353d8ac39c52 Ralf Baechle      2007-11-19  136  
ff2c8252bfbf06 Matt Redfearn     2017-07-19  137  const struct plat_smp_ops sb_smp_ops = {
87353d8ac39c52 Ralf Baechle      2007-11-19  138  	.send_ipi_single	= sb1250_send_ipi_single,
87353d8ac39c52 Ralf Baechle      2007-11-19  139  	.send_ipi_mask		= sb1250_send_ipi_mask,
87353d8ac39c52 Ralf Baechle      2007-11-19  140  	.init_secondary		= sb1250_init_secondary,
87353d8ac39c52 Ralf Baechle      2007-11-19  141  	.smp_finish		= sb1250_smp_finish,
87353d8ac39c52 Ralf Baechle      2007-11-19  142  	.boot_secondary		= sb1250_boot_secondary,
87353d8ac39c52 Ralf Baechle      2007-11-19  143  	.smp_setup		= sb1250_smp_setup,
87353d8ac39c52 Ralf Baechle      2007-11-19  144  	.prepare_cpus		= sb1250_prepare_cpus,
87353d8ac39c52 Ralf Baechle      2007-11-19  145  };
87353d8ac39c52 Ralf Baechle      2007-11-19  146  
937a801576f954 Ralf Baechle      2006-10-07  147  void sb1250_mailbox_interrupt(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  148  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  149  	int cpu = smp_processor_id();
d2287f5ebea9ff Mike Travis       2009-01-14  150  	int irq = K_INT_MBOX_0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  151  	unsigned int action;
^1da177e4c3f41 Linus Torvalds    2005-04-16  152  
310ff2c87e7220 Thomas Gleixner   2014-02-23  153  	kstat_incr_irq_this_cpu(irq);
^1da177e4c3f41 Linus Torvalds    2005-04-16  154  	/* Load the mailbox register to figure out what we're supposed to do */
65bda1a95d395c Maciej W. Rozycki 2005-02-22 @155  	action = (____raw_readq(mailbox_regs[cpu]) >> 48) & 0xffff;

:::::: The code at line 21 was first introduced by commit
:::::: 65bda1a95d395c256818d1d8129487a4497b29d8 Switch SiByte drivers back to __raw_*() functions.

:::::: TO: Maciej W. Rozycki <macro@linux-mips.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
