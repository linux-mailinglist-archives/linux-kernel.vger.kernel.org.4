Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C974A8B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGGB5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGB5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:57:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E719B7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688695070; x=1720231070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=igLQ0X7Rl8Km3Nl0UBI7+/erYSJFcdJXhTbnUTFm/2Y=;
  b=kboPsNR3L6WbJy8EWB+s3H02pHMyQQRFXewmYJ3g0+9QBuZAc/Qx4BHN
   YUlZ8OKwheFSEZwPOO2NPE9E3uF7YOJss3BwCusZZHzV6/Ggup20h5U0m
   3wpYXzXLxVFErg9+OkUaAojZ0VIGyWTJeZKJaN4jY14mdswt4QW9gYKvF
   eSxiko9OCsoreexMaHCqpNWRgHXOzM+v2OFRE9a13hQ1Xwbn8QDAmnkHj
   SPhlOesZdNzZ1wELTzgqsR5o3+2LYub10nlyzysVOrZiNwi56O7UMYa+l
   u+A+twYG2t9np5QEAfouunRbRVhnlQeafrzdnAvRhbB/AEf1DxgkgEM3o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="348573605"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="348573605"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 18:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="669989161"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="669989161"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 18:57:48 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHajD-0001gS-30;
        Fri, 07 Jul 2023 01:57:47 +0000
Date:   Fri, 7 Jul 2023 09:57:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shenghao Ding <13916275206@139.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: include/linux/compiler.h:69:46: warning: 'fw_entry' is used
 uninitialized
Message-ID: <202307070922.doxi1HFc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a452483508d7b70b0f6c69e249ec0b3ea2330b5c
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   3 weeks ago
config: sh-randconfig-r033-20230707 (https://download.01.org/0day-ci/archive/20230707/202307070922.doxi1HFc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307070922.doxi1HFc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307070922.doxi1HFc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/firmware.h:6,
                    from sound/soc/codecs/tas2781-fmwlib.c:10:
   include/linux/compiler.h: In function 'tas2781_load_calibration':
>> include/linux/compiler.h:69:46: warning: 'fw_entry' is used uninitialized [-Wuninitialized]
      69 |                 (__if_trace.miss_hit[1]++,1) :          \
         |                                              ^
   sound/soc/codecs/tas2781-fmwlib.c:1911:32: note: 'fw_entry' was declared here
    1911 |         const struct firmware *fw_entry;
         |                                ^~~~~~~~


vim +/fw_entry +69 include/linux/compiler.h

a15fd609ad53a6 Linus Torvalds 2019-03-20  58  
a15fd609ad53a6 Linus Torvalds 2019-03-20  59  #define __trace_if_value(cond) ({			\
2bcd521a684cc9 Steven Rostedt 2008-11-21  60  	static struct ftrace_branch_data		\
e04462fb82f8dd Miguel Ojeda   2018-09-03  61  		__aligned(4)				\
33def8498fdde1 Joe Perches    2020-10-21  62  		__section("_ftrace_branch")		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  63  		__if_trace = {				\
2bcd521a684cc9 Steven Rostedt 2008-11-21  64  			.func = __func__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  65  			.file = __FILE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  66  			.line = __LINE__,		\
2bcd521a684cc9 Steven Rostedt 2008-11-21  67  		};					\
a15fd609ad53a6 Linus Torvalds 2019-03-20  68  	(cond) ?					\
a15fd609ad53a6 Linus Torvalds 2019-03-20 @69  		(__if_trace.miss_hit[1]++,1) :		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  70  		(__if_trace.miss_hit[0]++,0);		\
a15fd609ad53a6 Linus Torvalds 2019-03-20  71  })
a15fd609ad53a6 Linus Torvalds 2019-03-20  72  

:::::: The code at line 69 was first introduced by commit
:::::: a15fd609ad53a631a927c6680e8fb606f42a712b tracing: Simplify "if" macro code

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
