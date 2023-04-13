Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80A6E0D96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDMMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDMMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:42:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928793D1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681389772; x=1712925772;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=VoD4HZCtF2eoEZicpjj2XlYJmJxVn/JnvwmNPYON1x8=;
  b=NzSzO4X1kjn1zmZMAWmbgAIKFk4k5LaQja87Hkae2zcQWBt+K+ImYPwd
   xKp1xPWTwSFfvi3FswfpyBAtcydlQq20cJMKNslU8I0d2bV3mIXy5D1nL
   rcJZW20d5SZzGQ9EaG/eT1Dl+KAJ2X503XsPuwZBRSARkVVBWKvQHj/+T
   MFRf4gsmfvWy2z4u8a54qnjEnjUT1Y+omn3QETbf/9K4qoHkwXnpoPlSl
   Wsslnb5ycKv+kmNDnPuIOyeURNJU9MqZnZ2pFWarUom2QRrhCXPhZCUh6
   IjwQ3hANV0OPyTVVU0dLlPD3I9cXKEGLTyo/YcVvFmAKcSoNE+kYSWJ/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="344166427"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="344166427"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="722041266"
X-IronPort-AV: E=Sophos;i="5.99,193,1677571200"; 
   d="scan'208";a="722041266"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Apr 2023 05:42:49 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmwHo-000Ygc-2P;
        Thu, 13 Apr 2023 12:42:48 +0000
Date:   Thu, 13 Apr 2023 20:42:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/bcm47xx/prom.c:129:6: warning: no previous prototype for
 function 'early_tlb_init'
Message-ID: <202304132001.mawtrQpw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de4664485abbc0529b1eec44d0061bbfe58a28fb
commit: c434b9f80b0923e6460031b0fd964f8b0bf3c6a6 MIPS: Kconfig: add MIPS_GENERIC_KERNEL symbol
date:   2 years, 7 months ago
config: mips-buildonly-randconfig-r005-20230413 (https://download.01.org/0day-ci/archive/20230413/202304132001.mawtrQpw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c434b9f80b0923e6460031b0fd964f8b0bf3c6a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/bcm47xx/ drivers/gpio/ drivers/mfd/ drivers/regulator/ drivers/soc/mediatek/ drivers/thermal/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304132001.mawtrQpw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/bcm47xx/prom.c:129:6: warning: no previous prototype for function 'early_tlb_init' [-Wmissing-prototypes]
   void early_tlb_init(void)
        ^
   arch/mips/bcm47xx/prom.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void early_tlb_init(void)
   ^
   static 
>> arch/mips/bcm47xx/prom.c:137:13: warning: no previous prototype for function 'bcm47xx_prom_highmem_init' [-Wmissing-prototypes]
   void __init bcm47xx_prom_highmem_init(void)
               ^
   arch/mips/bcm47xx/prom.c:137:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init bcm47xx_prom_highmem_init(void)
   ^
   static 
   2 warnings generated.
--
>> drivers/gpio/gpio-zx.c:275:34: warning: unused variable 'zx_gpio_match' [-Wunused-const-variable]
   static const struct of_device_id zx_gpio_match[] = {
                                    ^
   1 warning generated.
--
>> drivers/mfd/max77686.c:148:34: warning: unused variable 'max77686_pmic_dt_match' [-Wunused-const-variable]
   static const struct of_device_id max77686_pmic_dt_match[] = {
                                    ^
   1 warning generated.
--
>> drivers/regulator/mp886x.c:258:34: warning: unused variable 'mp886x_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mp886x_dt_ids[] = {
                                    ^
   1 warning generated.
--
>> drivers/thermal/thermal_mmio.c:103:34: warning: unused variable 'thermal_mmio_id_table' [-Wunused-const-variable]
   static const struct of_device_id thermal_mmio_id_table[] = {
                                    ^
   1 warning generated.
--
>> drivers/soc/mediatek/mtk-pmic-wrap.c:1842:34: warning: unused variable 'of_slave_match_tbl' [-Wunused-const-variable]
   static const struct of_device_id of_slave_match_tbl[] = {
                                    ^
>> drivers/soc/mediatek/mtk-pmic-wrap.c:1988:34: warning: unused variable 'of_pwrap_match_tbl' [-Wunused-const-variable]
   static const struct of_device_id of_pwrap_match_tbl[] = {
                                    ^
   2 warnings generated.


vim +/early_tlb_init +129 arch/mips/bcm47xx/prom.c

6ee1d93455384ce Rafał Miłecki  2014-07-17  125  
6ee1d93455384ce Rafał Miłecki  2014-07-17  126  /* Stripped version of tlb_init, with the call to build_tlb_refill_handler
6ee1d93455384ce Rafał Miłecki  2014-07-17  127   * dropped. Calling it at this stage causes a hang.
6ee1d93455384ce Rafał Miłecki  2014-07-17  128   */
b1f7e1129097cdb Paul Gortmaker 2015-04-27 @129  void early_tlb_init(void)
6ee1d93455384ce Rafał Miłecki  2014-07-17  130  {
6ee1d93455384ce Rafał Miłecki  2014-07-17  131  	write_c0_pagemask(PM_DEFAULT_MASK);
6ee1d93455384ce Rafał Miłecki  2014-07-17  132  	write_c0_wired(0);
6ee1d93455384ce Rafał Miłecki  2014-07-17  133  	temp_tlb_entry = current_cpu_data.tlbsize - 1;
6ee1d93455384ce Rafał Miłecki  2014-07-17  134  	local_flush_tlb_all();
6ee1d93455384ce Rafał Miłecki  2014-07-17  135  }
6ee1d93455384ce Rafał Miłecki  2014-07-17  136  
6ee1d93455384ce Rafał Miłecki  2014-07-17 @137  void __init bcm47xx_prom_highmem_init(void)
6ee1d93455384ce Rafał Miłecki  2014-07-17  138  {
6ee1d93455384ce Rafał Miłecki  2014-07-17  139  	unsigned long off = (unsigned long)prom_init;
6ee1d93455384ce Rafał Miłecki  2014-07-17  140  	unsigned long extmem = 0;
6ee1d93455384ce Rafał Miłecki  2014-07-17  141  	bool highmem_region = false;
6ee1d93455384ce Rafał Miłecki  2014-07-17  142  
6ee1d93455384ce Rafał Miłecki  2014-07-17  143  	if (WARN_ON(bcm47xx_bus_type != BCM47XX_BUS_TYPE_BCMA))
6ee1d93455384ce Rafał Miłecki  2014-07-17  144  		return;
6ee1d93455384ce Rafał Miłecki  2014-07-17  145  
6ee1d93455384ce Rafał Miłecki  2014-07-17  146  	if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
6ee1d93455384ce Rafał Miłecki  2014-07-17  147  		highmem_region = true;
6ee1d93455384ce Rafał Miłecki  2014-07-17  148  
6ee1d93455384ce Rafał Miłecki  2014-07-17  149  	if (lowmem != 128 << 20 || !highmem_region)
6ee1d93455384ce Rafał Miłecki  2014-07-17  150  		return;
6ee1d93455384ce Rafał Miłecki  2014-07-17  151  
6ee1d93455384ce Rafał Miłecki  2014-07-17  152  	early_tlb_init();
6ee1d93455384ce Rafał Miłecki  2014-07-17  153  
6ee1d93455384ce Rafał Miłecki  2014-07-17  154  	/* Add one temporary TLB entry to map SDRAM Region 2.
6ee1d93455384ce Rafał Miłecki  2014-07-17  155  	 *      Physical        Virtual
6ee1d93455384ce Rafał Miłecki  2014-07-17  156  	 *      0x80000000      0xc0000000      (1st: 256MB)
6ee1d93455384ce Rafał Miłecki  2014-07-17  157  	 *      0x90000000      0xd0000000      (2nd: 256MB)
6ee1d93455384ce Rafał Miłecki  2014-07-17  158  	 */
6ee1d93455384ce Rafał Miłecki  2014-07-17  159  	add_temporary_entry(ENTRYLO(0x80000000),
6ee1d93455384ce Rafał Miłecki  2014-07-17  160  			    ENTRYLO(0x80000000 + (256 << 20)),
6ee1d93455384ce Rafał Miłecki  2014-07-17  161  			    EXTVBASE, PM_256M);
6ee1d93455384ce Rafał Miłecki  2014-07-17  162  
6ee1d93455384ce Rafał Miłecki  2014-07-17  163  	off = EXTVBASE + __pa(off);
6ee1d93455384ce Rafał Miłecki  2014-07-17  164  	for (extmem = 128 << 20; extmem < 512 << 20; extmem <<= 1) {
6ee1d93455384ce Rafał Miłecki  2014-07-17  165  		if (!memcmp(prom_init, (void *)(off + extmem), 16))
6ee1d93455384ce Rafał Miłecki  2014-07-17  166  			break;
6ee1d93455384ce Rafał Miłecki  2014-07-17  167  	}
6ee1d93455384ce Rafał Miłecki  2014-07-17  168  	extmem -= lowmem;
6ee1d93455384ce Rafał Miłecki  2014-07-17  169  
6ee1d93455384ce Rafał Miłecki  2014-07-17  170  	early_tlb_init();
6ee1d93455384ce Rafał Miłecki  2014-07-17  171  
6ee1d93455384ce Rafał Miłecki  2014-07-17  172  	if (!extmem)
6ee1d93455384ce Rafał Miłecki  2014-07-17  173  		return;
6ee1d93455384ce Rafał Miłecki  2014-07-17  174  
6ee1d93455384ce Rafał Miłecki  2014-07-17  175  	pr_warn("Found %lu MiB of extra memory, but highmem is unsupported yet!\n",
6ee1d93455384ce Rafał Miłecki  2014-07-17  176  		extmem >> 20);
6ee1d93455384ce Rafał Miłecki  2014-07-17  177  
6ee1d93455384ce Rafał Miłecki  2014-07-17  178  	/* TODO: Register extra memory */
6ee1d93455384ce Rafał Miłecki  2014-07-17  179  }
6ee1d93455384ce Rafał Miłecki  2014-07-17  180  

:::::: The code at line 129 was first introduced by commit
:::::: b1f7e1129097cdb5cf2d6ef5d365dc94d13e3c76 MIPS: BCM77xx: Remove legacy __cpuinit{,data} sections that crept in

:::::: TO: Paul Gortmaker <paul.gortmaker@windriver.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
