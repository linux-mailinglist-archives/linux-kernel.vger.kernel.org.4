Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9646E3CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDPX52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 19:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDPX51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 19:57:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773BA1FE0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 16:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681689445; x=1713225445;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AtW0Exung/JYM3fw0t+Uiz+5i9wx0Rg+c2AkNR9dntI=;
  b=h2jFWhcWVLIGm4+u+5V6IBqM5QcBdaW4d+16oEL0Kp3CKd+llwxcfVix
   IbxzYsqriz0WKK6yrLF57PD56xwydngBD7fuBZNRRERHyS40i1VCg3ZGQ
   elcd7bQgjsL0Jn3YUw8qpwXuQaGNV3Bgie1qhDoW49Zh2n6myjhUs7+P9
   0gi4LeMo43i7TGzdwFbDlDKGYMIcqV5oG1ZRISVVBvsJs7O0gQbouDYte
   KR3vdhwUEcp0zDFiqSTfZVlXISfz2MQDQ2cF1a1AeoKVQRUvqNZ2JppyV
   Kxl0+EtQcyRV28cMmjpIMKLRsdgwDCYEf2G3YDXDkOg70pMCZzLH6LmbD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="325116903"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="325116903"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 16:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="814588713"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="814588713"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2023 16:57:23 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poCFG-000bv9-18;
        Sun, 16 Apr 2023 23:57:22 +0000
Date:   Mon, 17 Apr 2023 07:57:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/mips/include/asm/timex.h:75:10: error: instruction requires a
 CPU feature not currently enabled
Message-ID: <202304170748.Fg9VIgGd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6a8f57ae2eb07ab39a6f0ccad60c760743051026
commit: aba5b397cad7d398b385aaf5029f99f41b690466 hamradio: baycom_epp: Do not use x86-specific rdtsc()
date:   4 months ago
config: mips-buildonly-randconfig-r001-20230417 (https://download.01.org/0day-ci/archive/20230417/202304170748.Fg9VIgGd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aba5b397cad7d398b385aaf5029f99f41b690466
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout aba5b397cad7d398b385aaf5029f99f41b690466
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/net/hamradio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304170748.Fg9VIgGd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/hamradio/baycom_epp.c:29:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
                   return read_c0_count();
                          ^
   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
   #define read_c0_count()         __read_32bit_c0_register($9, 0)
                                   ^
   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
           ___read_32bit_c0_register(source, sel, __volatile__)
           ^
   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
                           "mfc0\t%0, " #source "\n\t"                     \
                           ^
   <inline asm>:1:2: note: instantiated into assembly here
           mfc0    $4, $9
           ^
   In file included from drivers/net/hamradio/baycom_epp.c:29:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
                   return read_c0_count();
                          ^
   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
   #define read_c0_count()         __read_32bit_c0_register($9, 0)
                                   ^
   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
           ___read_32bit_c0_register(source, sel, __volatile__)
           ^
   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
                           "mfc0\t%0, " #source "\n\t"                     \
                           ^
   <inline asm>:1:2: note: instantiated into assembly here
           mfc0    $2, $9
           ^
   In file included from drivers/net/hamradio/baycom_epp.c:29:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
                   return read_c0_count();
                          ^
   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
   #define read_c0_count()         __read_32bit_c0_register($9, 0)
                                   ^
   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
           ___read_32bit_c0_register(source, sel, __volatile__)
           ^
   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
                           "mfc0\t%0, " #source "\n\t"                     \
                           ^
   <inline asm>:1:2: note: instantiated into assembly here
           mfc0    $2, $9
           ^
   In file included from drivers/net/hamradio/baycom_epp.c:29:
   In file included from include/linux/module.h:13:
   In file included from include/linux/stat.h:19:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
>> arch/mips/include/asm/timex.h:75:10: error: instruction requires a CPU feature not currently enabled
                   return read_c0_count();
                          ^
   arch/mips/include/asm/mipsregs.h:1712:26: note: expanded from macro 'read_c0_count'
   #define read_c0_count()         __read_32bit_c0_register($9, 0)
                                   ^
   arch/mips/include/asm/mipsregs.h:1453:2: note: expanded from macro '__read_32bit_c0_register'
           ___read_32bit_c0_register(source, sel, __volatile__)
           ^
   arch/mips/include/asm/mipsregs.h:1419:4: note: expanded from macro '___read_32bit_c0_register'
                           "mfc0\t%0, " #source "\n\t"                     \
                           ^
   <inline asm>:1:2: note: instantiated into assembly here
           mfc0    $2, $9
           ^
   4 errors generated.


vim +75 arch/mips/include/asm/timex.h

9c9b415c50bc29 Ralf Baechle       2013-09-12  71  
06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  72  static inline cycles_t get_cycles(void)
06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  73  {
06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  74  	if (can_use_mips_counter(read_c0_prid()))
9c9b415c50bc29 Ralf Baechle       2013-09-12 @75  		return read_c0_count();
06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  76  	else
06947aaaf9bf7d Maciej W. Rozycki  2014-04-06  77  		return 0;	/* no usable counter */
9c9b415c50bc29 Ralf Baechle       2013-09-12  78  }
1c99c6a7c3c599 Jason A. Donenfeld 2022-04-08  79  #define get_cycles get_cycles
9c9b415c50bc29 Ralf Baechle       2013-09-12  80  

:::::: The code at line 75 was first introduced by commit
:::::: 9c9b415c50bc298ac61412dff856eae2f54889ee MIPS: Reimplement get_cycles().

:::::: TO: Ralf Baechle <ralf@linux-mips.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
