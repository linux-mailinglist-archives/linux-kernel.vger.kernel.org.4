Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B036BEF60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCQRRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCQRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:17:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA4C48A8;
        Fri, 17 Mar 2023 10:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679073439; x=1710609439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7Um5WgX0/Ow2OiYnXCvKojE79q9wI7ohWbytUP/Llc=;
  b=mUgpyvmczhsTdb5mLmKFGvuIUCGKr8fBLAVGKjNrR4yDa69StWDoEf5I
   DXPIPPOkh4Is0KDLGCR7x/5lPpeo9gHaWphhgm56dfJm6FCiYjvaWMXBc
   3mgWtFdIIiTcsHLSaHJsUnh4rN5ru63F7cjZgIZ5PXT3cjJgv1cVjgGaU
   WZVATTu8wBTxQqRhV0Pk/Ezjmx1SPXP1a60f4/icuRCQokS+U5cRG7jjX
   gmduxuT8E9IBVxO8vObNfObYxMgb2M8U9AOOQ7dfivwz9fQw9RxJO5ExV
   We7IL9RCu4opc6UoeuFaahhjhMuqXBQYiUFrvZ+0yDF9oxTGhemAQiFCi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="318718293"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="318718293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="712817421"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="712817421"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2023 10:17:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdDhb-0009VG-0Q;
        Fri, 17 Mar 2023 17:17:15 +0000
Date:   Sat, 18 Mar 2023 01:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 5/8] iio: test: test gain-time-scale helpers
Message-ID: <202303180046.bcS0xv8j-lkp@intel.com>
References: <31cf5765078b2d808d9e66eb623cde70ee6478ac.1679062529.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cf5765078b2d808d9e66eb623cde70ee6478ac.1679062529.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

I love your patch! Yet something to improve:

[auto build test ERROR on eeac8ede17557680855031c6f305ece2378af326]

url:    https://github.com/intel-lab-lkp/linux/commits/Matti-Vaittinen/drm-tests-helpers-rename-generic-helpers/20230317-224949
base:   eeac8ede17557680855031c6f305ece2378af326
patch link:    https://lore.kernel.org/r/31cf5765078b2d808d9e66eb623cde70ee6478ac.1679062529.git.mazziesaccount%40gmail.com
patch subject: [PATCH v4 5/8] iio: test: test gain-time-scale helpers
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230318/202303180046.bcS0xv8j-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/37a2c62820ca249a8d3ab9f1b80eaa71e0d5749b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matti-Vaittinen/drm-tests-helpers-rename-generic-helpers/20230317-224949
        git checkout 37a2c62820ca249a8d3ab9f1b80eaa71e0d5749b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/base/test/ drivers/iio/test/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303180046.bcS0xv8j-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/test/iio-test-gts.c:7:10: fatal error: kunit/platform_device.h: No such file or directory
       7 | #include <kunit/platform_device.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/base/test/test_kunit_device.c:11:10: fatal error: kunit/platform_device.h: No such file or directory
      11 | #include <kunit/platform_device.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +7 drivers/iio/test/iio-test-gts.c

   > 7	#include <kunit/platform_device.h>
     8	#include <kunit/test.h>
     9	#include <linux/iio/iio-gts-helper.h>
    10	#include <linux/iio/types.h>
    11	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
