Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCB5B4634
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIJMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIJMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 08:38:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845F032AB4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662813486; x=1694349486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4mY4vCUpQvSoyqu3KWsonVuhhpBXFmmybY/r80KfUb8=;
  b=Bf5nuh4HJES4vzqzL6MsGKuH2BdIsXqUNQLRuTr2uzigqDuuWpToNlsY
   iWMECWidCsPjIqWXihX18qrUC8ACyo5ysZw9IcpkkRjyFzt0THFqp/3oK
   vvGJcMJFeNrs7fgMwCpplJpg5EC19a8KORN1teDFietAoFcHNh6eFHw6e
   t71ossm/Xk4dQ/qKqj5Kps4nWg1Pl4ov5yqkHkpTl2+Czws/b7W/MVnd7
   E6i+9l7njKfJoLPRzZpIsDEApZA20IK8sJypiI6RfM8qadOFATf/LdpLN
   Ju9uACSA2y9FohTZGItlg2gTm7OhIRYyQWHnMc/goXSmPnTqu7lfGDBl+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="298975626"
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="298975626"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 05:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,305,1654585200"; 
   d="scan'208";a="645878241"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2022 05:38:04 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWzkK-00007P-1A;
        Sat, 10 Sep 2022 12:38:04 +0000
Date:   Sat, 10 Sep 2022 20:37:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [spandruvada:idle-inject 5/6] include/linux/idle_inject.h:14:56:
 warning: 'struct cpumask' declared inside parameter list will not be visible
 outside of this definition or declaration
Message-ID: <202209102039.HdOycA8x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/spandruvada/linux-kernel idle-inject
head:   b950e6ec430b3996d5b58f365d094200e106878f
commit: c2ad2f95377b388ffe18d80edf2fc076c83f5b63 [5/6] thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle cooling driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220910/202209102039.HdOycA8x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/spandruvada/linux-kernel/commit/c2ad2f95377b388ffe18d80edf2fc076c83f5b63
        git remote add spandruvada https://github.com/spandruvada/linux-kernel
        git fetch --no-tags spandruvada idle-inject
        git checkout c2ad2f95377b388ffe18d80edf2fc076c83f5b63
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/thermal/intel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/thermal/intel/intel_cpu_idle_cooling.c:14:
>> include/linux/idle_inject.h:14:56: warning: 'struct cpumask' declared inside parameter list will not be visible outside of this definition or declaration
      14 | struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
         |                                                        ^~~~~~~
   drivers/thermal/intel/intel_cpu_idle_cooling.c:21:10: fatal error: asm/cpu_device_id.h: No such file or directory
      21 | #include <asm/cpu_device_id.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +14 include/linux/idle_inject.h

88763a5cf80ca5 Daniel Lezcano      2018-06-26  13  
d3e687037f4c8d Srinivas Pandruvada 2022-09-07 @14  struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
d3e687037f4c8d Srinivas Pandruvada 2022-09-07  15  						int (*idle_inject_begin)(unsigned int cpu, unsigned int idle_duration, unsigned int run_duration),
d3e687037f4c8d Srinivas Pandruvada 2022-09-07  16  						void (*idle_inject_end)(unsigned int cpu));
88763a5cf80ca5 Daniel Lezcano      2018-06-26  17  

:::::: The code at line 14 was first introduced by commit
:::::: d3e687037f4c8d5ab6c71c645e3bb55b2e3fc3c7 powercap: idle_inject: Add begin/end callbacks

:::::: TO: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
:::::: CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
