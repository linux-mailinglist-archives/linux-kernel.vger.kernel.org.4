Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7516EFB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjDZTrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjDZTrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:47:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41FE2684
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682538432; x=1714074432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MGrpL7HK6COHMivxHoFQzpVgjiCt9Ez13UEVwaEnt9E=;
  b=WBFCGKWRpqRstfcRsrX5YzswwMMybQoD9ExdChyinak7nQY/LFfOWYSw
   dyYToJLfwPdt3rQvct6oCVbMtOu9JNnUzLRwioyQZNeosTQxTA2Yi+zzb
   dGqR2irhTkS/XgW07JN+MtTJooHcnDwZBP4sRQ1NPfhzFoudyRKOerS2y
   ipVaCrFMA3lDuHdqDt3dyEeBWCB6hC5YH0VS4mB1+W4BJkkCRkKfxYB70
   Dv1677C5b0BY5eflQk7cQVmxAWLDHL/VapHa+qTkCDXUCeeTLiIq1zp1b
   9BeX+/BmY9NYGs2YNKiJAhNSzNcb23kex5RfWYoMclR3a7c8htKVP/8wX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327542045"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="327542045"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 12:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="694069596"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="694069596"
Received: from lkp-server01.sh.intel.com (HELO 041f065c1b1b) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2023 12:46:51 -0700
Received: from kbuild by 041f065c1b1b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1prl6J-0000UQ-0Y;
        Wed, 26 Apr 2023 19:46:51 +0000
Date:   Thu, 27 Apr 2023 03:46:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype
 for 'mpc52xx_psc_spi_transfer_one_message'
Message-ID: <202304270332.2o1MDojo-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c7ecada25d2086aee607ff7deb69e77faa4aa92
commit: 145cfc3840e5931a789a8e2e76af841ab4cad44b spi: mpc52xx-psc: Switch to using core message queue
date:   10 months ago
config: powerpc-buildonly-randconfig-r005-20230426 (https://download.01.org/0day-ci/archive/20230427/202304270332.2o1MDojo-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=145cfc3840e5931a789a8e2e76af841ab4cad44b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 145cfc3840e5931a789a8e2e76af841ab4cad44b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304270332.2o1MDojo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype for 'mpc52xx_psc_spi_transfer_one_message' [-Wmissing-prototypes]
     195 | int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
   Selected by [y]:
   - SND_MPC52xx_SOC_EFIKA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_EFIKA [=y]
   WARNING: unmet direct dependencies detected for SND_SOC_STAC9766
   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
   Selected by [y]:
   - SND_MPC52xx_SOC_EFIKA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_POWERPC_SOC [=y] && PPC_EFIKA [=y]


vim +/mpc52xx_psc_spi_transfer_one_message +195 drivers/spi/spi-mpc52xx-psc.c

   194	
 > 195	int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
   196						 struct spi_message *m)
   197	{
   198		struct spi_device *spi;
   199		struct spi_transfer *t = NULL;
   200		unsigned cs_change;
   201		int status;
   202	
   203		spi = m->spi;
   204		cs_change = 1;
   205		status = 0;
   206		list_for_each_entry (t, &m->transfers, transfer_list) {
   207			if (t->bits_per_word || t->speed_hz) {
   208				status = mpc52xx_psc_spi_transfer_setup(spi, t);
   209				if (status < 0)
   210					break;
   211			}
   212	
   213			if (cs_change)
   214				mpc52xx_psc_spi_activate_cs(spi);
   215			cs_change = t->cs_change;
   216	
   217			status = mpc52xx_psc_spi_transfer_rxtx(spi, t);
   218			if (status)
   219				break;
   220			m->actual_length += t->len;
   221	
   222			spi_transfer_delay_exec(t);
   223	
   224			if (cs_change)
   225				mpc52xx_psc_spi_deactivate_cs(spi);
   226		}
   227	
   228		m->status = status;
   229		if (status || !cs_change)
   230			mpc52xx_psc_spi_deactivate_cs(spi);
   231	
   232		mpc52xx_psc_spi_transfer_setup(spi, NULL);
   233	
   234		spi_finalize_current_message(ctlr);
   235	
   236		return 0;
   237	}
   238	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
