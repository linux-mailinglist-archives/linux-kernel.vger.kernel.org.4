Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C46DBE03
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 01:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDHXg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDHXgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 19:36:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9FA7EE9;
        Sat,  8 Apr 2023 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680996984; x=1712532984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xwiP4VE57FTwb07fPwNW+BJYOxDNqzuKlCX9F6LAa0E=;
  b=bivWk58fL5n4Itp0HikB05KrOW7tK0fjvkmCS3scHTadVMgRD1zL9n8Y
   117+aMAOorCczt36zAYY8XoPZ3pDC7DCg+XstHBCB/m7cx5z3dMYFjVX4
   9WEopSKCMO66M6dgp4gpjGsTBhrmaBkFPeoU73JunJSncaBbW/LuGhJab
   hy5xGuW2Gsb3DQTR6QhgIdpRpwasdjs07pFwBn+kTl3paEZSNch2dMQd8
   CZSIYtnUczKQUki4aXjYDIL/kS+gh7XVqjcnDsDachySqv3mz78R7/3wk
   vrDUNcTDiq+0ZD3L6bAs7jwnUmEE0JPn3VSCaNysLRmjFQYdUelcRw0SI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="344953994"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="344953994"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 16:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="811742432"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="811742432"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Apr 2023 16:36:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plI6T-000UD7-02;
        Sat, 08 Apr 2023 23:36:17 +0000
Date:   Sun, 9 Apr 2023 07:35:18 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <202304090708.EDYvW6wb-lkp@intel.com>
References: <20230408214041.533749-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408214041.533749-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next robh/for-next linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230408214041.533749-3-abel.vesa%40linaro.org
patch subject: [PATCH v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
config: arm-randconfig-r023-20230409 (https://download.01.org/0day-ci/archive/20230409/202304090708.EDYvW6wb-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 2c57868e2e877f73c339796c3374ae660bb77f0d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/496cc31572753aac0d53c5e0666bcc6c3f323938
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
        git checkout 496cc31572753aac0d53c5e0666bcc6c3f323938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304090708.EDYvW6wb-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ufs/host/ufs-qcom.c:18:10: fatal error: 'soc/qcom/ice.h' file not found
   #include <soc/qcom/ice.h>
            ^~~~~~~~~~~~~~~~
   1 error generated.


vim +18 drivers/ufs/host/ufs-qcom.c

    17	
  > 18	#include <soc/qcom/ice.h>
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
