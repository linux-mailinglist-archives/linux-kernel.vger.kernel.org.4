Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF996BFF6D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 06:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCSFnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 01:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCSFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 01:43:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E31ADD1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679204584; x=1710740584;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lzL42OaqQrtFfc8bT2UJ/PTeWUK4RO0Lv9BXhWjzuH8=;
  b=cXi2R1mXldBi7Ab8/gODk9Z0r4VrMFY+8VxQm7yRadUM2K9ZtGQ6AZKn
   ZGfYGri4mWiFRId2mKxS3eYhiIZXVkrAcHe99xzaRzHaGnmX7xOsmR7tQ
   N9WouVAAPJlWEJCgXnEvPlG9Vs3cCEjvy5EbT89d6ijRjszba30W4iWZM
   xKnPEsxKFFlas1Tmm5mRQR+SvWL4Ilw0y0vwzkO4IFOX8UHuvn8HKuGnl
   AXvGsLoI423azle7O+5/LC44nnnn6b8zgW8CalpjknACP8bYf6NQt8zyT
   XkRDH1hFf52Zx/yfxi4VmfQJc6ae4Z7+8cjwe9Xz+eq+/OnXLjl1HUkKo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="424759211"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="424759211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 22:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="713185430"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="713185430"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2023 22:43:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdlor-000APq-1t;
        Sun, 19 Mar 2023 05:43:01 +0000
Date:   Sun, 19 Mar 2023 13:42:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/irqchip/irq-ftintc010.c:165:12: warning: no previous
 prototype for function 'ft010_of_init_irq'
Message-ID: <202303191313.6WHJJhVD-lkp@intel.com>
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

Hi Nathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   7 weeks ago
config: arm-moxart_defconfig (https://download.01.org/0day-ci/archive/20230319/202303191313.6WHJJhVD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5eb6e280432ddc9b755193552f3a070da8d7455c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5eb6e280432ddc9b755193552f3a070da8d7455c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191313.6WHJJhVD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-ftintc010.c:128:39: warning: no previous prototype for function 'ft010_irqchip_handle_irq' [-Wmissing-prototypes]
   asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
                                         ^
   drivers/irqchip/irq-ftintc010.c:128:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __exception_irq_entry ft010_irqchip_handle_irq(struct pt_regs *regs)
              ^
              static 
>> drivers/irqchip/irq-ftintc010.c:165:12: warning: no previous prototype for function 'ft010_of_init_irq' [-Wmissing-prototypes]
   int __init ft010_of_init_irq(struct device_node *node,
              ^
   drivers/irqchip/irq-ftintc010.c:165:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __init ft010_of_init_irq(struct device_node *node,
   ^
   static 
   2 warnings generated.


vim +/ft010_of_init_irq +165 drivers/irqchip/irq-ftintc010.c

6ee532e2faa997 Linus Walleij 2017-03-18  164  
6ee532e2faa997 Linus Walleij 2017-03-18 @165  int __init ft010_of_init_irq(struct device_node *node,

:::::: The code at line 165 was first introduced by commit
:::::: 6ee532e2faa9979f0ee00afbfd39cbc034b99153 irqchip/gemini: Refactor Gemini driver to reflect Faraday origin

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
