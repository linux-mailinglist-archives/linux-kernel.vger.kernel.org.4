Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3976E2EED
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 05:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjDOD7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 23:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjDOD7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 23:59:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39D3618B;
        Fri, 14 Apr 2023 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681531153; x=1713067153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzogbmSon2s2bEoo/kT0VBE8ZrpEDaGf2zjbhtS2GY0=;
  b=SJSLX+PddiySmK/yjMiilfo3877WvdLNhCXjHx95+r1E9IizqUzGNq0Q
   wzMQEdK+nvQr8vsn34+v8X4QNIrbwAPkxltTu88pX4ba3B8VO4j+NrPYz
   PtYUnSeHoqpG5pR+ibtFZTiVaFurss50Vde6FKW470W6/jXmXIp40NG8W
   7521F+HF1PnJymmSg9rfwMSHRH3bWL4sVgdSXjptb3aD/woffGiIiLXmN
   C2/USkEds45Coq8N2MjPMuRud1kpI/k4RwzXFbdJYHLBUWVuFE1dZJxuX
   wzl2TxUB4BzNUuMF/AvJF2hIIivskDy8NzzuSzxPunYEs5uE2xxZ6dZL9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="328768187"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="328768187"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 20:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="690037658"
X-IronPort-AV: E=Sophos;i="5.99,199,1677571200"; 
   d="scan'208";a="690037658"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2023 20:59:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnX49-000aP1-0x;
        Sat, 15 Apr 2023 03:59:09 +0000
Date:   Sat, 15 Apr 2023 11:59:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Message-ID: <202304151147.xkLFltfQ-lkp@intel.com>
References: <20230414102342.23696-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414102342.23696-2-bbhushan2@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharat,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.3-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bharat-Bhushan/Watchdog-Add-octeontx2-GTI-watchdog-driver/20230414-182508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230414102342.23696-2-bbhushan2%40marvell.com
patch subject: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20230415/202304151147.xkLFltfQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/62fe2733152f0c68369948612f66ca68d43cb6f3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bharat-Bhushan/Watchdog-Add-octeontx2-GTI-watchdog-driver/20230414-182508
        git checkout 62fe2733152f0c68369948612f66ca68d43cb6f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304151147.xkLFltfQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/octeontx2_wdt.c:19:10: fatal error: asm/arch_timer.h: No such file or directory
      19 | #include <asm/arch_timer.h>
         |          ^~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +19 drivers/watchdog/octeontx2_wdt.c

    18	
  > 19	#include <asm/arch_timer.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
