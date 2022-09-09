Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461D5B2EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIIG2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIIG2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:28:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627EDB3B2B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662704889; x=1694240889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=och9uNBK6Wby+sDrmXQ9P+rvIjoqoETFEGKB8nhiTv8=;
  b=SHAhtvGWzBDFxZ4csgekXJaUirjGjbPJ4b3On6YxTcxNqDKkrdpBXCNh
   5H7NaA5V6EWDTf+Mdudxs5vUNwv8Dnl+0JjKupTEIZ2UjONvmea5TNG5T
   qG6b8n2khTFJpU4aY5SIw2XM/BHQGGtCOxcYOL80R3337Qv0+0LlwPIC5
   JuSvtVelUTIvhEIfngMxPE0VM17oqo4pDECXHSHLrMbxboPN2sdANKkHP
   NgSTFH/TgQQDrd958VKGKws8Xj4aQGDEBnUH4uE4N/AXIgPOjRZlNSmvF
   2MADdUpHspJCFOb9gd5hV7bMKmpTuTNAi18H6Rpx5H0HDH+OI6hdaNeaW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298746756"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="298746756"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 23:27:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="943662001"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 23:27:53 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWXUW-0000mn-3C;
        Fri, 09 Sep 2022 06:27:52 +0000
Date:   Fri, 9 Sep 2022 14:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for
 'do_softirq_own_stack'
Message-ID: <202209091406.f6EClPti-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block arm64/linux/for-next/misc
head:   2d2f3bb897a3de4190b1b6b296c3429d01327554
commit: 2d2f3bb897a3de4190b1b6b296c3429d01327554 [2/2] arm64: run softirqs on the per-CPU IRQ stack
config: arm64-randconfig-r005-20220907 (https://download.01.org/0day-ci/archive/20220909/202209091406.f6EClPti-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2d2f3bb897a3de4190b1b6b296c3429d01327554
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/misc
        git checkout 2d2f3bb897a3de4190b1b6b296c3429d01327554
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for 'do_softirq_own_stack' [-Wmissing-prototypes]
      81 | void do_softirq_own_stack(void)
         |      ^~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/irq.c:120:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
     120 | void __init init_IRQ(void)
         |             ^~~~~~~~


vim +/do_softirq_own_stack +81 arch/arm64/kernel/irq.c

    80	
  > 81	void do_softirq_own_stack(void)
    82	{
    83		call_on_irq_stack(NULL, ____do_softirq);
    84	}
    85	#endif
    86	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
