Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1850C6DBF01
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 09:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDIHCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 03:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIHCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 03:02:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C91524D;
        Sun,  9 Apr 2023 00:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681023752; x=1712559752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J11a3LKHFUg+rZr7msg9Wtw0US+dnw019wkvKcGQG6w=;
  b=GF0wp178kDVSV84rEDgfqlTJj+3u7pYVTcY8HOoOfrfj5r/WGHDbqTwt
   7AVjL6/XbpT1nzD5WKoJ5NPL181FEiR4FcksqI35E5zIYWOrzR4T735Dv
   gYvbHN6pvB7ingFjVgZN2+Xf7LGaRv0lcU7tyhnZ8iir0dY1m64GdSZ0v
   GwbXxCT48q9OJVT0bR9x6FOwvwvKwqcWS5oOk8iO1RW5OC0ZsT6c4ay5F
   17Ham3fB+Ag+/JEqNoORg1ZLwjFOP6qgq0yf5nhrnDO+xn0M1fW85WbVU
   egScErKereWSYBosVqkm/UTU1nLhVZXiEbJItlFL0RdiODfEpFHhphXtT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="340689355"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="340689355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 00:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="681419525"
X-IronPort-AV: E=Sophos;i="5.98,330,1673942400"; 
   d="scan'208";a="681419525"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2023 00:02:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1plP4C-000UOh-2p;
        Sun, 09 Apr 2023 07:02:24 +0000
Date:   Sun, 9 Apr 2023 15:01:30 +0800
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
Subject: Re: [PATCH v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <202304091444.8AV915DU-lkp@intel.com>
References: <20230408214041.533749-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408214041.533749-3-abel.vesa@linaro.org>
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
[also build test ERROR on jejb-scsi/for-next robh/for-next linus/master v6.3-rc5 next-20230406]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230408214041.533749-3-abel.vesa%40linaro.org
patch subject: [PATCH v7 2/3] scsi: ufs: ufs-qcom: Switch to the new ICE API
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230409/202304091444.8AV915DU-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/496cc31572753aac0d53c5e0666bcc6c3f323938
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/dt-bindings-ufs-qcom-Add-ICE-phandle/20230409-054151
        git checkout 496cc31572753aac0d53c5e0666bcc6c3f323938
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304091444.8AV915DU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/ufs/host/ufs-qcom.c:18:10: fatal error: soc/qcom/ice.h: No such file or directory
      18 | #include <soc/qcom/ice.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.


vim +18 drivers/ufs/host/ufs-qcom.c

    17	
  > 18	#include <soc/qcom/ice.h>
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
