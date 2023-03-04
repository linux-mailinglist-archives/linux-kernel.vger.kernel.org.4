Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECCB6AAB9F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCDRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCDRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:39:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC57113CC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677951546; x=1709487546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q/ppXpDMYnXEK2kEYPHDOYa77CFV5Z7lK99ENwKRVEQ=;
  b=ZxSWRI4EWwRzHlcPqtyp2iMoSJhK4eAHjDywjRL2hB8Qp88+0fowOzaj
   /rYRtLOrNGfzXgu4uD+xm3Ng83jmvcYZNStKJxqOv2Myu7Y9KME6StKW4
   woSn7J//7x5IW5YLVUUzQgvYEe9IHRFBA9BdBsXrI7sXPnda6ld1CwB2H
   /zNQ2UIjvw3SSPWNlX9ih5hrAOB15Me8Av8Mqf4b+ok9Z2u5J4/k8+qm/
   tIEqCtNyFLveDyaN4Hxc1Bk+PkFC9AL7zczK8dKXHSyYvEU2P2Znl2HwN
   SrpzVmT9JkAXyuFdCyCtfEetFyosvYOYxfPVvlRQAip/rvMZ/In9jA0pb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="332764914"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="332764914"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 09:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="668997032"
X-IronPort-AV: E=Sophos;i="5.98,234,1673942400"; 
   d="scan'208";a="668997032"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Mar 2023 09:39:02 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYVqY-0002HT-0a;
        Sat, 04 Mar 2023 17:39:02 +0000
Date:   Sun, 5 Mar 2023 01:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rakesh Babu Saladi <rsaladi2@marvell.com>, mark.rutland@arm.com,
        lpieralisi@kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, gcherian@marvell.com, naveenm@marvell.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Rakesh Babu Saladi <rsaladi2@marvell.com>
Subject: Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Message-ID: <202303050132.lgJCOelW-lkp@intel.com>
References: <20230304125850.32687-1-rsaladi2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230304125850.32687-1-rsaladi2@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rakesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on arm/for-next arm/fixes arm64/for-next/core kvmarm/next soc/for-next xilinx-xlnx/master linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rakesh-Babu-Saladi/arm64-smccc-Add-trace-events-to-SMC-calls/20230304-210103
patch link:    https://lore.kernel.org/r/20230304125850.32687-1-rsaladi2%40marvell.com
patch subject: [PATCH] arm64: smccc: Add trace events to SMC calls.
config: parisc-buildonly-randconfig-r003-20230302 (https://download.01.org/0day-ci/archive/20230305/202303050132.lgJCOelW-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ebdc6e981b26c56978d65ad39d650fd2a7862d1a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rakesh-Babu-Saladi/arm64-smccc-Add-trace-events-to-SMC-calls/20230304-210103
        git checkout ebdc6e981b26c56978d65ad39d650fd2a7862d1a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303050132.lgJCOelW-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/usb/host/ohci-at91.o: in function `ohci_at91_port_suspend.isra.0':
>> drivers/usb/host/ohci-at91.c:332: undefined reference to `arm_smccc_smc'
   hppa-linux-ld: drivers/memory/mtk-smi.o: in function `mtk_smi_larb_config_port_gen2_general':
   drivers/memory/mtk-smi.c:269: undefined reference to `arm_smccc_smc'
   hppa-linux-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
   drivers/firmware/qcom_scm-legacy.c:114: undefined reference to `arm_smccc_smc'
   hppa-linux-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   drivers/firmware/qcom_scm-legacy.c:234: undefined reference to `arm_smccc_smc'


vim +332 drivers/usb/host/ohci-at91.c

aa6e52a35d388e Thomas Petazzoni 2011-07-13  322  
1e073e3ed9ff9e Clément Léger    2022-06-07  323  static int ohci_at91_port_suspend(struct ohci_at91_priv *ohci_at91, u8 set)
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  324  {
1e073e3ed9ff9e Clément Léger    2022-06-07  325  	struct regmap *regmap = ohci_at91->sfr_regmap;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  326  	u32 regval;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  327  	int ret;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  328  
1e073e3ed9ff9e Clément Léger    2022-06-07  329  	if (ohci_at91->suspend_smc_id) {
1e073e3ed9ff9e Clément Léger    2022-06-07  330  		struct arm_smccc_res res;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  331  
1e073e3ed9ff9e Clément Léger    2022-06-07 @332  		arm_smccc_smc(ohci_at91->suspend_smc_id, set, 0, 0, 0, 0, 0, 0, &res);
1e073e3ed9ff9e Clément Léger    2022-06-07  333  		if (res.a0)
1e073e3ed9ff9e Clément Léger    2022-06-07  334  			return -EINVAL;
1e073e3ed9ff9e Clément Léger    2022-06-07  335  	} else if (regmap) {
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  336  		ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  337  		if (ret)
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  338  			return ret;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  339  
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  340  		if (set)
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  341  			regval |= AT91_OHCIICR_USB_SUSPEND;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  342  		else
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  343  			regval &= ~AT91_OHCIICR_USB_SUSPEND;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  344  
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  345  		regmap_write(regmap, AT91_SFR_OHCIICR, regval);
1e073e3ed9ff9e Clément Léger    2022-06-07  346  	}
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  347  
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  348  	return 0;
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  349  }
2e2aa1bc7eff90 Wenyou Yang      2016-08-23  350  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
