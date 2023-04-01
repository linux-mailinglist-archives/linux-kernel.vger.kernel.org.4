Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9026D31E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDAPNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjDAPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:13:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323A2544F;
        Sat,  1 Apr 2023 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680361957; x=1711897957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLApVVMOJ2Css0D7py5ZiNmtjsFz6UxJsp+PhEah9l4=;
  b=OUxBy8TY6cVrFJQHIhDJ+ATICQu5TtkXJSP/aMEGsISW/wO2P6HWnZ4s
   2Yk9R7y25zDBkHZOuuBaHQWaB7K/vBicZ4bBW7nQyZz6MyB3pVoMbKLWg
   2ZH4COJQ+Qg+7Uc82uM/1GiWJyISt5rCrsbFmNEn/C37WaDi/yA1tJQLW
   +KLxNwgk3ecbmbLOzCjI4jqB/zp5OyJWr9uv85vbnEc1P3YOrE6ivyZDb
   ke4CHr2oq3pnGxIWyu0Zo2dwY+4zT6mafnYlpVUyg6T9FTOoadvCwvDMQ
   SKXwe4S8nF8lJRSrq9xQFYIteVi9xM1T3RGAAiidIzAFQvlod7Rc2dJDf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="369459092"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="369459092"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 08:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="796475551"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="796475551"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2023 08:12:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1picu7-000MsF-2s;
        Sat, 01 Apr 2023 15:12:31 +0000
Date:   Sat, 1 Apr 2023 23:11:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        replicant@osuosl.org
Cc:     oe-kbuild-all@lists.linux.dev, Henrik Grimler <henrik@grimler.se>,
        Valentine Iourine <iourine@iourine.msk.su>
Subject: Re: [PATCH v6 2/2] ARM: dts: exynos: add mmc aliases
Message-ID: <202304012305.NdtndVxO-lkp@intel.com>
References: <20230401132134.12887-3-henrik@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401132134.12887-3-henrik@grimler.se>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Henrik,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 0e84f3493a37d50f2f629dbea670135b8a8ee391]

url:    https://github.com/intel-lab-lkp/linux/commits/Henrik-Grimler/ARM-dts-exynos-replace-mshc0-alias-with-mmc-ddr-1_8v-property/20230401-212318
base:   0e84f3493a37d50f2f629dbea670135b8a8ee391
patch link:    https://lore.kernel.org/r/20230401132134.12887-3-henrik%40grimler.se
patch subject: [PATCH v6 2/2] ARM: dts: exynos: add mmc aliases
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230401/202304012305.NdtndVxO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f28175ed67208fd6411a3ce477762d7b032fe52e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Henrik-Grimler/ARM-dts-exynos-replace-mshc0-alias-with-mmc-ddr-1_8v-property/20230401-212318
        git checkout f28175ed67208fd6411a3ce477762d7b032fe52e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304012305.NdtndVxO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/exynos5422-samsung-k3g.dts:26.2-17 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
