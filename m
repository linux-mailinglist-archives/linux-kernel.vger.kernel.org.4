Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCED15B5151
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 23:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIKVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 17:21:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897F518B21
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662931271; x=1694467271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0Sf+GBjhkRoF+sqR5wv3WqZ1Cd0NCbnAVLknq9A1cCM=;
  b=iyH+n9Hb1pLVNBTK0cL40+6KyzuMOCYA30vjEDDEcme987q8CDr4v5M1
   GFv+C3NBiBKvq8sF/bs3lHqge6waMAci/nxsaWt9SVtHUQ1tqMVO5Iez9
   4K/X6/B8jr8UPe5catO3mdLb+FkcP03Iqf7Nye7dCfFAEyKJKj5jGReEx
   M7vkv694x+Cqoy7Y/V4ASd5MdzMEd/6OXUY0gTt+SVIMMFyZChfDrds7n
   6MJSIoAP3xVMNBa/hkHieCctG3RQ6U0nsbQ2UOSf9USruP7kl1DMMU3qV
   mdZDhmMw/c2o8uNdTGXizS9BLc4wc7U7xaC67A3KOF3Ow1HN2ybDbDePI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="298553428"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="298553428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 14:21:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="758184900"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2022 14:21:09 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXUO4-0001qP-2P;
        Sun, 11 Sep 2022 21:21:08 +0000
Date:   Mon, 12 Sep 2022 05:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:queue/5.15 62/102] arch/arm/mach-at91/pm.c:370:38:
 error: use of undeclared identifier 'DDR3PHY_ZQ0SR0'
Message-ID: <202209120522.AOuxSu1o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.15
head:   58b6ddd0dfd470c48feef1d58e9151373f59e315
commit: 4e1102de88e91852e109ab98731f9cd1f0c7286f [62/102] ARM: at91: pm: fix DDR recalibration when resuming from backup and self-refresh
config: arm-multi_v5_defconfig (https://download.01.org/0day-ci/archive/20220912/202209120522.AOuxSu1o-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=4e1102de88e91852e109ab98731f9cd1f0c7286f
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.15
        git checkout 4e1102de88e91852e109ab98731f9cd1f0c7286f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mach-at91/pm.c:370:38: error: use of undeclared identifier 'DDR3PHY_ZQ0SR0'
                   tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
                                                      ^
>> arch/arm/mach-at91/pm.c:373:19: error: use of undeclared identifier 'DDR3PHY_ZQ0SR0_PDO_OFF'
                   index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
                                   ^
>> arch/arm/mach-at91/pm.c:377:19: error: use of undeclared identifier 'DDR3PHY_ZQ0SR0_PUO_OFF'
                   index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
                                   ^
>> arch/arm/mach-at91/pm.c:381:19: error: use of undeclared identifier 'DDR3PHY_ZQ0SR0_PDODT_OFF'
                   index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
                                   ^
>> arch/arm/mach-at91/pm.c:385:19: error: use of undeclared identifier 'DDR3PHY_ZQ0SRO_PUODT_OFF'
                   index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
                                   ^
   5 errors generated.


vim +/DDR3PHY_ZQ0SR0 +370 arch/arm/mach-at91/pm.c

   350	
   351	static int at91_suspend_finish(unsigned long val)
   352	{
   353		unsigned char modified_gray_code[] = {
   354			0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
   355			0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
   356			0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
   357			0x10, 0x11,
   358		};
   359		unsigned int tmp, index;
   360		int i;
   361	
   362		if (soc_pm.data.mode == AT91_PM_BACKUP && soc_pm.data.ramc_phy) {
   363			/*
   364			 * Bootloader will perform DDR recalibration and will try to
   365			 * restore the ZQ0SR0 with the value saved here. But the
   366			 * calibration is buggy and restoring some values from ZQ0SR0
   367			 * is forbidden and risky thus we need to provide processed
   368			 * values for these (modified gray code values).
   369			 */
 > 370			tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
   371	
   372			/* Store pull-down output impedance select. */
 > 373			index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
   374			soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
   375	
   376			/* Store pull-up output impedance select. */
 > 377			index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
   378			soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
   379	
   380			/* Store pull-down on-die termination impedance select. */
 > 381			index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
   382			soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
   383	
   384			/* Store pull-up on-die termination impedance select. */
 > 385			index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
   386			soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
   387	
   388			/*
   389			 * The 1st 8 words of memory might get corrupted in the process
   390			 * of DDR PHY recalibration; it is saved here in securam and it
   391			 * will be restored later, after recalibration, by bootloader
   392			 */
   393			for (i = 1; i < BACKUP_DDR_PHY_CALIBRATION; i++)
   394				soc_pm.bu->ddr_phy_calibration[i] =
   395					*((unsigned int *)soc_pm.memcs + (i - 1));
   396		}
   397	
   398		flush_cache_all();
   399		outer_disable();
   400	
   401		at91_suspend_sram_fn(&soc_pm.data);
   402	
   403		return 0;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
