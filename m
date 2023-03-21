Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C26C3240
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCUNEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCUNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:04:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E111392B0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679403871; x=1710939871;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iNWK/cGtoILVNb9KtfPfPY1jPP0PqVF7f42tRwkSCl8=;
  b=k4C4gCbpGuExEKHDxuERCOGGGzGau9B/yaqkxpV6HgRCeqSK65gATlqv
   xEnOnETLVnGRr9ZK1rufIXxp4a+K4zh5rNXW9GNibyTUCpYrIp7zcgk+3
   byG2zLLbHIcIFUK9y2pp/ppoBi2kq4tUNSQwhxjJBnaOU7rY9wStNhbmw
   ucLuCvIPtXLoCxWM4K1TmvT7bd5lGBxJpfddAdthRcj+Wk4zL4r8CBz5r
   DNLD8g8fxuaDZloZoFZdKAm2UnRsbR1PGJbDK/whf/blRLP7DZF0btbWm
   7oI6U1T8ZbQ0yZJ2GzY7vRrS4rQCb+9XW9HSbJus7TrptVsny1d7M1qYX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341293912"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="341293912"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="855682128"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="855682128"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2023 06:04:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pebfA-000Bw2-1g;
        Tue, 21 Mar 2023 13:04:28 +0000
Date:   Tue, 21 Mar 2023 21:04:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/edac/armada_xp_edac.c:129:47: warning: variable 'cause_msg'
 set but not used
Message-ID: <202303212140.9cdphwwM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17214b70a159c6547df9ae204a6275d983146f6b
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   12 months ago
config: arm-randconfig-r016-20230321 (https://download.01.org/0day-ci/archive/20230321/202303212140.9cdphwwM-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/edac/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303212140.9cdphwwM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/edac/armada_xp_edac.c: In function 'axp_mc_check':
>> drivers/edac/armada_xp_edac.c:129:47: warning: variable 'cause_msg' set but not used [-Wunused-but-set-variable]
     129 |         uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
         |                                               ^~~~~~~~~
>> drivers/edac/armada_xp_edac.c:129:36: warning: variable 'cause_err' set but not used [-Wunused-but-set-variable]
     129 |         uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
         |                                    ^~~~~~~~~
>> drivers/edac/armada_xp_edac.c:128:26: warning: variable 'data_l' set but not used [-Wunused-but-set-variable]
     128 |         uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
         |                          ^~~~~~
>> drivers/edac/armada_xp_edac.c:128:18: warning: variable 'data_h' set but not used [-Wunused-but-set-variable]
     128 |         uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
         |                  ^~~~~~


vim +/cause_msg +129 drivers/edac/armada_xp_edac.c

7f6998a41257a89 Jan Luebbe         2019-07-12  124  
7f6998a41257a89 Jan Luebbe         2019-07-12  125  static void axp_mc_check(struct mem_ctl_info *mci)
7f6998a41257a89 Jan Luebbe         2019-07-12  126  {
7f6998a41257a89 Jan Luebbe         2019-07-12  127  	struct axp_mc_drvdata *drvdata = mci->pvt_info;
7f6998a41257a89 Jan Luebbe         2019-07-12 @128  	uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
7f6998a41257a89 Jan Luebbe         2019-07-12 @129  	uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
7f6998a41257a89 Jan Luebbe         2019-07-12  130  	uint32_t row_val, col_val, bank_val, addr_val;
7f6998a41257a89 Jan Luebbe         2019-07-12  131  	uint8_t syndrome_val, cs_val;
7f6998a41257a89 Jan Luebbe         2019-07-12  132  	char *msg = drvdata->msg;
7f6998a41257a89 Jan Luebbe         2019-07-12  133  
7f6998a41257a89 Jan Luebbe         2019-07-12  134  	data_h    = readl(drvdata->base + SDRAM_ERR_DATA_H_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  135  	data_l    = readl(drvdata->base + SDRAM_ERR_DATA_L_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  136  	recv_ecc  = readl(drvdata->base + SDRAM_ERR_RECV_ECC_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  137  	calc_ecc  = readl(drvdata->base + SDRAM_ERR_CALC_ECC_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  138  	addr      = readl(drvdata->base + SDRAM_ERR_ADDR_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  139  	cnt_sbe   = readl(drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  140  	cnt_dbe   = readl(drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  141  	cause_err = readl(drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  142  	cause_msg = readl(drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  143  
7f6998a41257a89 Jan Luebbe         2019-07-12  144  	/* clear cause registers */
7f6998a41257a89 Jan Luebbe         2019-07-12  145  	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
7f6998a41257a89 Jan Luebbe         2019-07-12  146  	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  147  	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
7f6998a41257a89 Jan Luebbe         2019-07-12  148  	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  149  
7f6998a41257a89 Jan Luebbe         2019-07-12  150  	/* clear error counter registers */
7f6998a41257a89 Jan Luebbe         2019-07-12  151  	if (cnt_sbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  152  		writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  153  	if (cnt_dbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  154  		writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
7f6998a41257a89 Jan Luebbe         2019-07-12  155  
7f6998a41257a89 Jan Luebbe         2019-07-12  156  	if (!cnt_sbe && !cnt_dbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  157  		return;
7f6998a41257a89 Jan Luebbe         2019-07-12  158  
7f6998a41257a89 Jan Luebbe         2019-07-12  159  	if (!(addr & SDRAM_ERR_ADDR_TYPE_MASK)) {
7f6998a41257a89 Jan Luebbe         2019-07-12  160  		if (cnt_sbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  161  			cnt_sbe--;
7f6998a41257a89 Jan Luebbe         2019-07-12  162  		else
493362dd7b9fe29 Christophe JAILLET 2020-04-13  163  			dev_warn(mci->pdev, "inconsistent SBE count detected\n");
7f6998a41257a89 Jan Luebbe         2019-07-12  164  	} else {
7f6998a41257a89 Jan Luebbe         2019-07-12  165  		if (cnt_dbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  166  			cnt_dbe--;
7f6998a41257a89 Jan Luebbe         2019-07-12  167  		else
493362dd7b9fe29 Christophe JAILLET 2020-04-13  168  			dev_warn(mci->pdev, "inconsistent DBE count detected\n");
7f6998a41257a89 Jan Luebbe         2019-07-12  169  	}
7f6998a41257a89 Jan Luebbe         2019-07-12  170  
7f6998a41257a89 Jan Luebbe         2019-07-12  171  	/* report earlier errors */
7f6998a41257a89 Jan Luebbe         2019-07-12  172  	if (cnt_sbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  173  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
7f6998a41257a89 Jan Luebbe         2019-07-12  174  				     cnt_sbe, /* error count */
7f6998a41257a89 Jan Luebbe         2019-07-12  175  				     0, 0, 0, /* pfn, offset, syndrome */
7f6998a41257a89 Jan Luebbe         2019-07-12  176  				     -1, -1, -1, /* top, mid, low layer */
7f6998a41257a89 Jan Luebbe         2019-07-12  177  				     mci->ctl_name,
7f6998a41257a89 Jan Luebbe         2019-07-12  178  				     "details unavailable (multiple errors)");
7f6998a41257a89 Jan Luebbe         2019-07-12  179  	if (cnt_dbe)
7f6998a41257a89 Jan Luebbe         2019-07-12  180  		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
d9b7748ffc45250 Hans Potsch        2021-10-06  181  				     cnt_dbe, /* error count */
7f6998a41257a89 Jan Luebbe         2019-07-12  182  				     0, 0, 0, /* pfn, offset, syndrome */
7f6998a41257a89 Jan Luebbe         2019-07-12  183  				     -1, -1, -1, /* top, mid, low layer */
7f6998a41257a89 Jan Luebbe         2019-07-12  184  				     mci->ctl_name,
7f6998a41257a89 Jan Luebbe         2019-07-12  185  				     "details unavailable (multiple errors)");
7f6998a41257a89 Jan Luebbe         2019-07-12  186  
7f6998a41257a89 Jan Luebbe         2019-07-12  187  	/* report details for most recent error */
7f6998a41257a89 Jan Luebbe         2019-07-12  188  	cs_val   = (addr & SDRAM_ERR_ADDR_CS_MASK) >> SDRAM_ERR_ADDR_CS_OFFSET;
7f6998a41257a89 Jan Luebbe         2019-07-12  189  	bank_val = (addr & SDRAM_ERR_ADDR_BANK_MASK) >> SDRAM_ERR_ADDR_BANK_OFFSET;
7f6998a41257a89 Jan Luebbe         2019-07-12  190  	row_val  = (calc_ecc & SDRAM_ERR_CALC_ECC_ROW_MASK) >> SDRAM_ERR_CALC_ECC_ROW_OFFSET;
7f6998a41257a89 Jan Luebbe         2019-07-12  191  	col_val  = (addr & SDRAM_ERR_ADDR_COL_MASK) >> SDRAM_ERR_ADDR_COL_OFFSET;
7f6998a41257a89 Jan Luebbe         2019-07-12  192  	syndrome_val = (recv_ecc ^ calc_ecc) & 0xff;
7f6998a41257a89 Jan Luebbe         2019-07-12  193  	addr_val = axp_mc_calc_address(drvdata, cs_val, bank_val, row_val,
7f6998a41257a89 Jan Luebbe         2019-07-12  194  				       col_val);
7f6998a41257a89 Jan Luebbe         2019-07-12  195  	msg += sprintf(msg, "row=0x%04x ", row_val); /* 11 chars */
7f6998a41257a89 Jan Luebbe         2019-07-12  196  	msg += sprintf(msg, "bank=0x%x ", bank_val); /*  9 chars */
7f6998a41257a89 Jan Luebbe         2019-07-12  197  	msg += sprintf(msg, "col=0x%04x ", col_val); /* 11 chars */
7f6998a41257a89 Jan Luebbe         2019-07-12  198  	msg += sprintf(msg, "cs=%d", cs_val);	     /*  4 chars */
7f6998a41257a89 Jan Luebbe         2019-07-12  199  
7f6998a41257a89 Jan Luebbe         2019-07-12  200  	if (!(addr & SDRAM_ERR_ADDR_TYPE_MASK)) {
7f6998a41257a89 Jan Luebbe         2019-07-12  201  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
7f6998a41257a89 Jan Luebbe         2019-07-12  202  				     1,	/* error count */
7f6998a41257a89 Jan Luebbe         2019-07-12  203  				     addr_val >> PAGE_SHIFT,
7f6998a41257a89 Jan Luebbe         2019-07-12  204  				     addr_val & ~PAGE_MASK,
7f6998a41257a89 Jan Luebbe         2019-07-12  205  				     syndrome_val,
7f6998a41257a89 Jan Luebbe         2019-07-12  206  				     cs_val, -1, -1, /* top, mid, low layer */
7f6998a41257a89 Jan Luebbe         2019-07-12  207  				     mci->ctl_name, drvdata->msg);
7f6998a41257a89 Jan Luebbe         2019-07-12  208  	} else {
7f6998a41257a89 Jan Luebbe         2019-07-12  209  		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
7f6998a41257a89 Jan Luebbe         2019-07-12  210  				     1,	/* error count */
7f6998a41257a89 Jan Luebbe         2019-07-12  211  				     addr_val >> PAGE_SHIFT,
7f6998a41257a89 Jan Luebbe         2019-07-12  212  				     addr_val & ~PAGE_MASK,
7f6998a41257a89 Jan Luebbe         2019-07-12  213  				     syndrome_val,
7f6998a41257a89 Jan Luebbe         2019-07-12  214  				     cs_val, -1, -1, /* top, mid, low layer */
7f6998a41257a89 Jan Luebbe         2019-07-12  215  				     mci->ctl_name, drvdata->msg);
7f6998a41257a89 Jan Luebbe         2019-07-12  216  	}
7f6998a41257a89 Jan Luebbe         2019-07-12  217  }
7f6998a41257a89 Jan Luebbe         2019-07-12  218  

:::::: The code at line 129 was first introduced by commit
:::::: 7f6998a41257a8930ee5b6866ba56a25230841ed ARM: 8888/1: EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC

:::::: TO: Jan Luebbe <jlu@pengutronix.de>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
