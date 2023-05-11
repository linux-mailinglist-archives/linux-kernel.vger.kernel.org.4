Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330C6FEB6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjEKF6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEKF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:57:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6DA272A
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683784676; x=1715320676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=esf7Awl5wAqdz1VlrbA/Roc3Np8AvsfoKm6R0aAVP/0=;
  b=EaPKLSXyo3rASJ/cgi8mg5o4hYEm1aCPFh2kH8Sn+ffVogLE+1wdBg6X
   hQTq+8tgwvNTvPIgDe8gz6hySOeYy2CHwy+ktIDb02YNKRH6l6Em6pDsg
   HZp7ZR6zo2R9G91tSYIPs9VE9lhCLLIh2feC7wPkLU+BkkFWz3HAJy4JI
   MlXeTHsQvV5GTRkgnvx7NG1wl0dEYerl05roexdhaRRjylgO4otky5m3A
   Q+nw/t/jRPSixbeozzCYz/L4edL4uWfOCySrGhwCtrKNbVmREi896fJW/
   BRk6/Pbdtnso+vG+lWWcJ7rvZ9/7SXugOYRJ4Ku2lkhtpYueAiDhsnF8a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="415995381"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="415995381"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 22:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="702594632"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="702594632"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 May 2023 22:57:55 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwzJK-0003o4-22;
        Thu, 11 May 2023 05:57:54 +0000
Date:   Thu, 11 May 2023 13:56:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain
 integer as NULL pointer
Message-ID: <202305111301.RAHohdob-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e62bc8487b049696e67ad133c503bf7f6806f7
commit: 3c816d950a494ae6e16b1fa017af29bc53cb7791 ARM: pxa: move clk register definitions to driver
date:   1 year ago
config: arm-randconfig-s053-20230511 (https://download.01.org/0day-ci/archive/20230511/202305111301.RAHohdob-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c816d950a494ae6e16b1fa017af29bc53cb7791
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3c816d950a494ae6e16b1fa017af29bc53cb7791
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash arch/arm/mach-lpc32xx/ arch/arm/mach-orion5x/ arch/arm/mach-spear/ arch/arm/mm/ drivers/clk/pxa/ drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305111301.RAHohdob-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/pxa/clk-pxa3xx.c:167:9: sparse: sparse: Using plain integer as NULL pointer

vim +167 drivers/clk/pxa/clk-pxa3xx.c

   159	
   160	void pxa3xx_clk_update_accr(u32 disable, u32 enable, u32 xclkcfg, u32 mask)
   161	{
   162		u32 accr = readl(clk_regs + ACCR);
   163	
   164		accr &= ~disable;
   165		accr |= enable;
   166	
 > 167		writel(accr, ACCR);
   168		if (xclkcfg)
   169			__asm__("mcr p14, 0, %0, c6, c0, 0\n" : : "r"(xclkcfg));
   170	
   171		while ((readl(clk_regs + ACSR) & mask) != (accr & mask))
   172			cpu_relax();
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
