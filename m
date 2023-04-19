Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C016E81E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjDST1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDST1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:27:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCD55B8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681932424; x=1713468424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZWiNmTCDGpUoboFsO/71XKPs6g4kgDxgWArRXM16kRs=;
  b=gzdDoMi8e8/KyFdbSxZf4l7WVTWf75qAP8Ewf6UCSxcuD0C7pXGo5Bzt
   UEglYwd1hfBPv0FxR8Wnv8QXLoEyAKll0HL0fGIEixekDKW8VyNXynWaE
   CQfeDv8XgZpv0Ui1DEzuYLiYhaw1cMXRdsahpDgDV/EWC/e08qPKRrMlK
   l9EdZSX8qN8ltybvvhmh7EkicNxcAb9I0pKcEP5s3yCX5KR4IS5uIG2Pl
   RidZI22su6zdbs93Ut+fr1mOnKy2JzExWsOcgrY9q6J0X7hdSHvCPrM+3
   itYp0s8TpshyD6eOpCSdaWUWy/L6pipcBTZQfDBv4q5ugMuyI3iWqVDFh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343021788"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="343021788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 12:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="724155517"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="724155517"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2023 12:27:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppDSH-000f7c-1J;
        Wed, 19 Apr 2023 19:27:01 +0000
Date:   Thu, 20 Apr 2023 03:26:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [tip:timers/core 13/13] kernel/time/posix-cpu-timers.c:1310:19:
 error: use of undeclared identifier 'timer'
Message-ID: <202304200309.F6HbUeCE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62
commit: 1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62 [13/13] posix-cpu-timers: Implement the missing timer_wait_running callback
config: arm-randconfig-r046-20230416 (https://download.01.org/0day-ci/archive/20230420/202304200309.F6HbUeCE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip timers/core
        git checkout 1bb5b68fd3aabb6b9d6b9e9bb092bb8f3c2ade62
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200309.F6HbUeCE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/time/posix-cpu-timers.c:1310:19: error: use of undeclared identifier 'timer'
           spin_unlock_irq(&timer.it_lock);
                            ^
   kernel/time/posix-cpu-timers.c:1312:17: error: use of undeclared identifier 'timer'
           spin_lock_irq(&timer.it_lock);
                          ^
   2 errors generated.


vim +/timer +1310 kernel/time/posix-cpu-timers.c

  1307	
  1308	static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
  1309	{
> 1310		spin_unlock_irq(&timer.it_lock);
  1311		cpu_relax();
  1312		spin_lock_irq(&timer.it_lock);
  1313	}
  1314	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
