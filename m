Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B405B4B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 04:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIKCbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 22:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIKCbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 22:31:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E322AC54
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662863494; x=1694399494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IkLjWxklXKf/XiBtDZgq+baW4+LEnbNp1USQdcVG1Tg=;
  b=My7EAqTkLWg0Xm3jxTuwyO/ylxWeG3OLvPQyWs6h3k659sdQGPcEbm0q
   L7CHkYJ9J1djfVakvYFXTYmzgcbTEAjWR2DyP4Jl4sbEiGo9ps86njX4P
   zBg/ee/orVccDti2sgx/dGYhAbz0zAbgroOAxvOTjyTu+3MzMmbvTRgzf
   FrYv7J0yu2v0wH4maB6uz2TObbXRj4FljQPO7OrB1MgkKv+iwcaVl5Sn/
   qxlKrf6Fyz5wsoI613L1qQBBkicRviTp6lJOFoUkIDVene7/wnoFfVTpL
   ORbJQOom69ABxvg9Zg5UdKAJ9+gDGUIIsUU0cFhqeWbUQj3Rk5Xfj14qt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="299024611"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="299024611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2022 19:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="566789516"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2022 19:31:33 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXCku-0000s5-11;
        Sun, 11 Sep 2022 02:31:32 +0000
Date:   Sun, 11 Sep 2022 10:30:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:tglx/devel/printk 11/29] ERROR: modpost:
 "lockdep_assert_console_lock_held" [drivers/tty/serial/kgdboc.ko] undefined!
Message-ID: <202209111056.DGPVwsnC-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block tglx/devel/printk
head:   f6339cd6dc7f812f822e86bd78d1edbf2bfc730b
commit: 9454437121a00cd2a204f56de9846539ce7b90b4 [11/29] printk: Convert console_drivers list to hlist
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220911/202209111056.DGPVwsnC-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/9454437121a00cd2a204f56de9846539ce7b90b4
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block tglx/devel/printk
        git checkout 9454437121a00cd2a204f56de9846539ce7b90b4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "lockdep_assert_console_lock_held" [drivers/tty/serial/kgdboc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
