Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AF6EAB00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjDUMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjDUMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:55:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D59D974D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682081716; x=1713617716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DpfuyQ75qr+V9Z/606wtHMSQGGLItWQxYexWBYQPNjo=;
  b=gshI2P+QWabVnCgHlUTcWlMynJ1l5PsFNKj4qnSKj9nXD1i3/TnNyRRy
   VbnSIOa5BIQYghlPkXQibmrxi0qsn47GA9B+U8n4Xcm48SHo+dbGSeKkD
   6nFtqUwl5BGAFpVj7rzos7Jr56E0FInI0Etd48vloeasg0eB5nMLhFYVQ
   i7Ax1njgyOP45Uk9HzVad6PPsQPg12jwIb3w2/f9th+9TOAepjaQWr/Cm
   zLmhoaJnzN9/gbGFWPzwUy3vDdPj2TLI0h2tLl+IdhKb3YeuHcowJ8gcg
   +iqv+s61NG7P8ICN7HIHcvq6tr4qyG8xhZaJvaT3kZeLeysbKHIsezzf1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="346003027"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="346003027"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 05:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="692269862"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="692269862"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2023 05:55:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppqID-000gas-23;
        Fri, 21 Apr 2023 12:55:13 +0000
Date:   Fri, 21 Apr 2023 20:54:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: [tip:timers/core 13/13] kernel/time/posix-cpu-timers.c:1310:30:
 error: 'timr' is a pointer; did you mean to use '->'?
Message-ID: <202304212002.oZSoeiXT-lkp@intel.com>
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
head:   2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94
commit: 2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94 [13/13] posix-cpu-timers: Implement the missing timer_wait_running callback
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20230421/202304212002.oZSoeiXT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip timers/core
        git checkout 2aaae4bf41b101f7e58e8b06778b1cd9a1dddf94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304212002.oZSoeiXT-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/posix-cpu-timers.c: In function 'posix_cpu_timer_wait_running_nsleep':
>> kernel/time/posix-cpu-timers.c:1310:30: error: 'timr' is a pointer; did you mean to use '->'?
    1310 |         spin_unlock_irq(&timr.it_lock);
         |                              ^
         |                              ->
   kernel/time/posix-cpu-timers.c:1312:28: error: 'timr' is a pointer; did you mean to use '->'?
    1312 |         spin_lock_irq(&timr.it_lock);
         |                            ^
         |                            ->
   kernel/time/posix-cpu-timers.c:1308:66: warning: parameter 'timr' set but not used [-Wunused-but-set-parameter]
    1308 | static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
         |                                                 ~~~~~~~~~~~~~~~~~^~~~


vim +1310 kernel/time/posix-cpu-timers.c

  1307	
  1308	static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
  1309	{
> 1310		spin_unlock_irq(&timr.it_lock);
  1311		cpu_relax();
  1312		spin_lock_irq(&timr.it_lock);
  1313	}
  1314	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
