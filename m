Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256B25BB454
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIPWPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiIPWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:15:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1EE4D804
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663366543; x=1694902543;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UHJsERHXZmCJuMqj/1wFtspAiClrkU1tTPWBFWPsWRc=;
  b=eQVf7SpFkEE4TSb/EQbP/uLoP87Bkvn0OOSNC3E6D12A0ohtDx55Fgjo
   rxFiFMrUsSCWKNh39Uo/gdS85byJLN9XB+iko9kAI7Mds3JmSH2niEXVC
   jJsYlnC/Mguc8vorldOiO4v8qehZ5hym5/5vQuxQEGWv80+4yRqrimI97
   T2/6sIUB/R3yXp5TjVcD4rBA+YW4hIcOwcaIwJh2NO5a35hKlCXBvzMX0
   UUjgi+q5LNNH/9g/Znlm/QMBbsQfHaSU2TbFAKeXtZp/GiIT8AENZPhzH
   RkqPWij4h/elFvh98Lshnf4ybx/Co8UryPGeEUvvzHFtM5P8YHdVYo5RH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="385382278"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="385382278"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 15:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="568979604"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 15:15:40 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZJca-0002Bm-0l;
        Fri, 16 Sep 2022 22:15:40 +0000
Date:   Sat, 17 Sep 2022 06:14:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko]
 undefined!
Message-ID: <202209170657.86nWuKIN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a335366bad1364a07f49df9da1fdfa6d411a5f39
commit: fc1aabb088860d6cf9dd03612b7a6f0de91ccac2 mips: lantiq: add support for clk_get_parent()
date:   10 months ago
config: mips-buildonly-randconfig-r003-20220917 (https://download.01.org/0day-ci/archive/20220917/202209170657.86nWuKIN-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc1aabb088860d6cf9dd03612b7a6f0de91ccac2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fc1aabb088860d6cf9dd03612b7a6f0de91ccac2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
