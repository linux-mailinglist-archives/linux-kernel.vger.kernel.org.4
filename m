Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DCD5B8FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiINVNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:13:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97082FA0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663189987; x=1694725987;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tNF5VMNITd4yfX3fKOm9kTIPe91lRZ0YOZ6C7sFSjiI=;
  b=CbBxEuQ9XcR3Poc6ayzTE31SoBrc9IoPqO7K5liRNpT7aQYF4R6Tnh/z
   f1Hdc+Ls0yRIo5Huq9B4NQUguGkjFCGDrIBGAiB+9erFHScgTEPBQ3t6A
   91QKqfkNWEo9x06UN+j1KcxrKEISkLnvHPezQjskclbxtuxD02pGNGcRz
   YCX7nRNk99htGMmlZqw07vXtGnKrA0gd2kbpOLVbEtM/Yu/91DBL4j+zt
   S77heYd/x0ew0VhU0B1/Q1ivf7y1komncbMa1EDDkviXDBrqkKqduOZKs
   YLXy+cD2CnimmnZMom8HvHw0Az96D2/7AHrIH8QducDVh53maLJ39osIi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="285584706"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285584706"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="650220215"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Sep 2022 14:13:02 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYZgs-0000Zo-0Y;
        Wed, 14 Sep 2022 21:13:02 +0000
Date:   Thu, 15 Sep 2022 05:12:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Subject: [steev:c630-6.0.0-rc5-only-batt 2/15]
 drivers/power/supply/yoga-c630-ec.c:225:24: error: implicit declaration of
 function 'FIELD_GET' is invalid in C99
Message-ID: <202209150504.Q9XVY3rZ-lkp@intel.com>
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

tree:   https://github.com/steev/linux c630-6.0.0-rc5-only-batt
head:   f3c03af09a0ea482d28346e1aeb98de01632080c
commit: cf2451d68e7599a6869e1a218a588811d94e4839 [2/15] power: supply: Add Lenovo Yoga C630 EC driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220915/202209150504.Q9XVY3rZ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/cf2451d68e7599a6869e1a218a588811d94e4839
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev c630-6.0.0-rc5-only-batt
        git checkout cf2451d68e7599a6869e1a218a588811d94e4839
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/power/supply/yoga-c630-ec.c:225:24: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
                   ec->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
                                        ^
   drivers/power/supply/yoga-c630-ec.c:391:6: error: implicit declaration of function 'FIELD_GET' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           if (FIELD_GET(LENOVO_EC_USB_EVENT_MUX, event))
               ^
   2 errors generated.


vim +/FIELD_GET +225 drivers/power/supply/yoga-c630-ec.c

   216	
   217	static int yoga_c630_ec_update_adapter_status(struct yoga_c630_ec *ec)
   218	{
   219		int val;
   220	
   221		mutex_lock(&ec->lock);
   222	
   223		val = yoga_c630_ec_read8(ec, LENOVO_EC_ADPT_STATUS);
   224		if (val > 0)
 > 225			ec->adapter_online = FIELD_GET(LENOVO_EC_ADPT_PRESENT, val);
   226	
   227		mutex_unlock(&ec->lock);
   228	
   229		return val;
   230	}
   231	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
