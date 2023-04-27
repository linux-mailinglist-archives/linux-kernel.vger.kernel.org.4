Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508426EFEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbjD0AqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbjD0AqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:46:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74073AB3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682556359; x=1714092359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GgYBV+T1RD85sNVfYTFaYCw4/IeJBfdVOWA9AZor7Gw=;
  b=Mc2FV2Euelx3KFLtrNJF4IcX2idwDPuRhB5mUt7IM2EO7tY3EoXLUPsn
   vfR3UH70NTD3GCiImrEHDfz4NY1HItHbOC6PTxbnb01A1UQ76cFlIs0Vo
   Uw3/8SGOy/zuAmr0PSp0wdvnJkHRlDj0ffYnlFITU/O4OSs8LX+e+JlvI
   EhDdcNErlvGYIS3/XptOA/o161/MkEcDugbAyytjgUFGovtswEBNCVuKU
   CAkBwT3M6Hr3OXRjvmOlVMPgjSSEEXU/faqN5y+SQw7j/ylsVA35hdQnH
   1IunpxW0YrrrNAkTT2jQ/0fPRCAjHz+33aUYEvlJxXv9MtQbSGKqGPd0T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="336217587"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="336217587"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 17:45:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="696850472"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="696850472"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2023 17:45:57 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prpll-0000c2-05;
        Thu, 27 Apr 2023 00:45:57 +0000
Date:   Thu, 27 Apr 2023 08:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/powerpc/platforms/powermac/nvram.c:304:24: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202304270842.BqclGq6g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e98b09da931a00bf4e0477d0fa52748bf28fcce
commit: 0a2b782a00f33e7d06dc43d099fa071ae97bee77 fortify: Make pointer arguments const
date:   1 year, 2 months ago
config: powerpc-randconfig-s052-20230426 (https://download.01.org/0day-ci/archive/20230427/202304270842.BqclGq6g-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a2b782a00f33e7d06dc43d099fa071ae97bee77
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0a2b782a00f33e7d06dc43d099fa071ae97bee77
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/powermac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270842.BqclGq6g-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/powermac/nvram.c:304:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:480:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:526:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:527:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:534:44: sparse: sparse: dereference of noderef expression

vim +304 arch/powerpc/platforms/powermac/nvram.c

14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  279  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  280  static int sm_erase_bank(int bank)
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  281  {
2d4b971287cbce arch/powerpc/platforms/powermac/nvram.c      Akinobu Mita     2012-01-27  282  	int stat;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  283  	unsigned long timeout;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  284  
af308377e204e2 arch/powerpc/platforms/powermac/nvram.c      Stephen Rothwell 2006-03-23  285  	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  286  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  287         	DBG("nvram: Sharp/Micron Erasing bank %d...\n", bank);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  288  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  289  	out_8(base, SM_FLASH_CMD_ERASE_SETUP);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  290  	out_8(base, SM_FLASH_CMD_ERASE_CONFIRM);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  291  	timeout = 0;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  292  	do {
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  293  		if (++timeout > 1000000) {
35499c0195e46f arch/powerpc/platforms/powermac/nvram.c      Paul Mackerras   2005-10-22  294  			printk(KERN_ERR "nvram: Sharp/Micron flash erase timeout !\n");
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  295  			break;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  296  		}
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  297  		out_8(base, SM_FLASH_CMD_READ_STATUS);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  298  		stat = in_8(base);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  299  	} while (!(stat & SM_FLASH_STATUS_DONE));
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  300  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  301  	out_8(base, SM_FLASH_CMD_CLEAR_STATUS);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  302  	out_8(base, SM_FLASH_CMD_RESET);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  303  
2d4b971287cbce arch/powerpc/platforms/powermac/nvram.c      Akinobu Mita     2012-01-27 @304  	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  305  		printk(KERN_ERR "nvram: Sharp/Micron flash erase failed !\n");
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  306  		return -ENXIO;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  307  	}
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  308  	return 0;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  309  }
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  310  

:::::: The code at line 304 was first introduced by commit
:::::: 2d4b971287cbce16585acda4b76308faa8da0950 powerpc/pmac: Use string library in nvram code

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
