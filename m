Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F906DBE1A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDHX41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHX4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:56:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392157DA9;
        Sat,  8 Apr 2023 16:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680998184; x=1712534184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SBjWLCDduqazACPY0rYViNrxuDYPCkxNDiJwaPS7Jjg=;
  b=O3LmloptMUd9ILc5yPsjWbQHq46Q0V6KmZ8zpGF4sHeNHJGPBcIWSgos
   +rrYz1jRkC1Itl1j1Ic4y86iI67yKF+FpO0olhOgJ+Bc5uJcYW2IXPPDT
   S4KvP7iqC5tcW9tuy1NMiH3V5px1dcwaSWcw/JKHdhTgKKH/u4fdVqbh3
   vK98YxkpoDP9filzIy+W1oc6C+KcGCbh9hPTI+JkuHeU4pqzUPKocRs7E
   01SsdNV3M08p85NK1ng52SYtShOlnkoVp5gDWGvcpbqIPSop1cs0YooHZ
   bXiPnlO8PlwCno1rIra7VUb3Oi4wHGqHS/V6Enm4KXGooH5ov9Tr9kM62
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="345833281"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="345833281"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 16:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="933943627"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="933943627"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2023 16:56:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plIPp-000UDp-1X;
        Sat, 08 Apr 2023 23:56:17 +0000
Date:   Sun, 9 Apr 2023 07:55:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 3/3] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <202304090709.QHt43PE6-lkp@intel.com>
References: <20230408214041.533749-4-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408214041.533749-4-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next robh/for-next linus/master v6.3-rc5 next-20230405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230408214041.533749-4-abel.vesa%40linaro.org
patch subject: [PATCH v7 3/3] mmc: sdhci-msm: Switch to the new ICE API
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230409/202304090709.QHt43PE6-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ec033fe93e3a653b68ee5c28699b7cbe180ff625
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
        git checkout ec033fe93e3a653b68ee5c28699b7cbe180ff625
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090709.QHt43PE6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-msm.c:21:10: fatal error: soc/qcom/ice.h: No such file or directory
      21 | #include <soc/qcom/ice.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.


vim +21 drivers/mmc/host/sdhci-msm.c

    20	
  > 21	#include <soc/qcom/ice.h>
    22	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
