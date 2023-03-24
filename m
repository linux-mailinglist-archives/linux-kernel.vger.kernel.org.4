Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF546C8805
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjCXWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjCXWEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:04:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B559166F2;
        Fri, 24 Mar 2023 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679695479; x=1711231479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UpsMcFdSLuC0k1qnpYQORQAhq03qFGs14iwAwWlEtiY=;
  b=iVJIFNyU5ns6SDmEEH+i6IK4l2AvhCjyBPoRKKVIxZAEuNXPPcuCXm97
   Lp2tbHQD/JMBnQyXiRc48McUlppIrMFJKcK4BJQromG+5dLBuckQ6c4iY
   n4HSDUipy7DB21v1APKRvIfU4X0ZAxYJmvde3QET4g6bJm5DEWDMvDS/a
   J/emAlwQ2D+XCQiJGqtSYUFhq6Sez0bIiReX1Kzmw5dRpLRgI+JarbCSn
   klq2zfzpSaNQf3YYiqXuR9u6aONTFHB9LRrMpKmhkSZZCC2Ieuahwi/Ab
   z9JW2ZrBnLKF9CqPWilnPnYuv5+gi/C56aW53sJSYOokz7DnUimMEictS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323776604"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="323776604"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 15:04:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="793598298"
X-IronPort-AV: E=Sophos;i="5.98,289,1673942400"; 
   d="scan'208";a="793598298"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2023 15:04:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfpWU-000Fh5-2j;
        Fri, 24 Mar 2023 22:04:34 +0000
Date:   Sat, 25 Mar 2023 06:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, will@kernel.org, dan.j.williams@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <202303250510.RNVcynwI-lkp@intel.com>
References: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core cxl/next cxl/pending linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230324171313.18448-5-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230325/202303250510.RNVcynwI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
        git checkout a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250510.RNVcynwI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cxl/cpmu.c: In function 'cpmu_parse_caps':
   drivers/cxl/cpmu.c:101:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     101 |         val = readq(base + CPMU_CAP_REG);
         |               ^~~~~
         |               readl
   drivers/cxl/cpmu.c: In function 'cpmu_pmu_enable':
   drivers/cxl/cpmu.c:559:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     559 |                 writeq(0, base + CPMU_FREEZE_REG);
         |                 ^~~~~~
         |                 writel
   In file included from include/linux/bitops.h:6,
                    from drivers/cxl/cpmu.c:24:
   drivers/cxl/cpmu.c: In function 'cpmu_pmu_disable':
>> include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/cxl/cpmu.c:578:24: note: in expansion of macro 'GENMASK'
     578 |                 writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
         |                        ^~~~~~~
   cc1: some warnings being treated as errors


vim +35 include/linux/bits.h

295bcca84916cb Rikard Falkeborn 2020-04-06  32  
295bcca84916cb Rikard Falkeborn 2020-04-06  33  #define __GENMASK(h, l) \
95b980d62d52c4 Masahiro Yamada  2019-07-16  34  	(((~UL(0)) - (UL(1) << (l)) + 1) & \
95b980d62d52c4 Masahiro Yamada  2019-07-16 @35  	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
295bcca84916cb Rikard Falkeborn 2020-04-06  36  #define GENMASK(h, l) \
295bcca84916cb Rikard Falkeborn 2020-04-06  37  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
8bd9cb51daac89 Will Deacon      2018-06-19  38  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
