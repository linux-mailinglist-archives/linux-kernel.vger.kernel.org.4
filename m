Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD341700E12
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbjELRoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjELRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:43:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCAC8A4B;
        Fri, 12 May 2023 10:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683913435; x=1715449435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pjbrs8OPQjNCdOcArcy7VvF6XymjWQoxulO2nMIv+oM=;
  b=J1LJRHMQ0Y91AnxR9Dc+0TyeorYjqhA1tH4pmSoZUDzHl6rToVzAh+7M
   W1IDc6S0htkBptXzig254QaJc0OTLz60ssgqq2zSdzKFAMwn5BbV0xV8p
   lVXFPcGkejysJ70DIJH8nQnvfy/asRmpshu/2TwD17Al/V91t4+5piyX0
   LpVBBS/3RPt/YSMYJ8xGvXkUE9zem7ZdBcXxcNM9lIkHUST25DIVCFage
   gZGqgmL0Ds/MXiu2+P5S42tSiqcyen1LX8Kso0dsprDljq1fyqegrDNrN
   TQrHo5sLjyAfZds4AkxnSHCKDe/+/7vxfid7XqnxaVdYw5Z9Uu07UKh9r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331212404"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="331212404"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 10:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694314695"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694314695"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2023 10:43:52 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxWo4-00050q-0e;
        Fri, 12 May 2023 17:43:52 +0000
Date:   Sat, 13 May 2023 01:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liming Sun <limings@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     oe-kbuild-all@lists.linux.dev, Liming Sun <limings@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Message-ID: <202305130116.ynGq0pC5-lkp@intel.com>
References: <20230512122648.223974-1-limings@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512122648.223974-1-limings@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liming,

kernel test robot noticed the following build errors:

[auto build test ERROR on ulf-hansson-mmc-mirror/next]
[also build test ERROR on linus/master v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liming-Sun/mmc-sdhci-of-dwcmshc-Add-runtime-PM-operations/20230512-202948
base:   https://git.linaro.org/people/ulf.hansson/mmc-mirror.git next
patch link:    https://lore.kernel.org/r/20230512122648.223974-1-limings%40nvidia.com
patch subject: [PATCH v3] mmc: sdhci-of-dwcmshc: Add runtime PM operations
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230513/202305130116.ynGq0pC5-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/eb5d4c0702ce24630f3d82a37f39437f52607cbb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liming-Sun/mmc-sdhci-of-dwcmshc-Add-runtime-PM-operations/20230512-202948
        git checkout eb5d4c0702ce24630f3d82a37f39437f52607cbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305130116.ynGq0pC5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_runtime_suspend':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:674:17: error: implicit declaration of function 'dwcmshc_disable_card_clk' [-Werror=implicit-function-declaration]
     674 |                 dwcmshc_disable_card_clk(host);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-of-dwcmshc.c: In function 'dwcmshc_runtime_resume':
>> drivers/mmc/host/sdhci-of-dwcmshc.c:684:9: error: implicit declaration of function 'dwcmshc_enable_card_clk' [-Werror=implicit-function-declaration]
     684 |         dwcmshc_enable_card_clk(host);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dwcmshc_disable_card_clk +674 drivers/mmc/host/sdhci-of-dwcmshc.c

   666	
   667	static int dwcmshc_runtime_suspend(struct device *dev)
   668	{
   669		struct sdhci_host *host = dev_get_drvdata(dev);
   670		int ret = 0;
   671	
   672		ret = sdhci_runtime_suspend_host(host);
   673		if (!ret)
 > 674			dwcmshc_disable_card_clk(host);
   675	
   676		return ret;
   677	}
   678	
   679	static int dwcmshc_runtime_resume(struct device *dev)
   680	{
   681		struct sdhci_host *host = dev_get_drvdata(dev);
   682		int ret = 0;
   683	
 > 684		dwcmshc_enable_card_clk(host);
   685		ret = sdhci_runtime_resume_host(host, 0);
   686	
   687		return ret;
   688	}
   689	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
