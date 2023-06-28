Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113B07414E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjF1P1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:27:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:10549 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231454AbjF1P1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966068; x=1719502068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s3pAHWHbgTHI2Pri/uRlZesknz1ogXXp0gk7P8LjtiI=;
  b=n7A4yfOcBZn0thOcSqrVOM4hYknFRw3RNgXWMVyJB0yPD/Ie+tULFUNc
   ck2tWD6NaA77S6P627p7zTWPPMuwrrBea9UqgcvNFMTcPcK5ZtGm3jtcF
   wwsYg6bnii5BLM9vxp3jm8skzz9mLyqsCPleDMwYEnXMn3gOTi/D7W5ju
   1rFkgl7c274nabuCeYrfNGDfk/COoDNeSVANHWBlt4TuMBy9kW0CmRy9h
   JyBWrYCbkuF3VZe14xB5FMdeLv/kt1pAbxCJJvA52TvCA9LWOR1S9HBqR
   AZfugJdu8MLUpFpujcFOKYI5gDCEpcEdTFutSmW9JKYfjdlUiaWBuYZQh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360731332"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="360731332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="787081290"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="787081290"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2023 08:27:45 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEX57-000DKf-0H;
        Wed, 28 Jun 2023 15:27:45 +0000
Date:   Wed, 28 Jun 2023 23:27:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: unused variable
 'ops_v0_1'
Message-ID: <202306282315.6mHC7VVw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6aeadf7896bff4ca230702daba8788455e6b866e
commit: 6812d1dfbca99cd5032683354bf50e0002b2aa02 thermal/drivers/qcom/tsens-v0_1: Fix mdm9607 slope values
date:   2 days ago
config: arm-randconfig-r046-20230628 (https://download.01.org/0day-ci/archive/20230628/202306282315.6mHC7VVw-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230628/202306282315.6mHC7VVw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306282315.6mHC7VVw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/tsens-v0_1.c:296:31: warning: unused variable 'ops_v0_1' [-Wunused-const-variable]
     296 | static const struct tsens_ops ops_v0_1 = {
         |                               ^
   1 warning generated.


vim +/ops_v0_1 +296 drivers/thermal/qcom/tsens-v0_1.c

c19970548edc35 Amit Kucheria    2019-03-20  295  
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01 @296  static const struct tsens_ops ops_v0_1 = {
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  297  	.init		= init_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  298  	.calibrate	= tsens_calibrate_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  299  	.get_temp	= get_temp_common,
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  300  };
51d78b8b1beba2 Dmitry Baryshkov 2023-01-01  301  

:::::: The code at line 296 was first introduced by commit
:::::: 51d78b8b1beba247e1e4314420d98acb0732c4b7 thermal/drivers/tsens: Drop single-cell code for mdm9607

:::::: TO: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
:::::: CC: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
