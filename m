Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD83717367
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjEaB45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEaB44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:56:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220EEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685498215; x=1717034215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tOkw6m2VVzV2BZPxty9ha1KSowUGEYzrh7agDrhOgUY=;
  b=n8hc9NKTwE4KWoroqKcFuf+fDmzv/kLdzWwD9OVK9prTNcuD5N75I8Vg
   eYvbDuz4RUMasP+2fwRPm9zjgreesjHrbThjgXJ+lLqq0+fYStv6Bd/lq
   YKkA5ayPfPLwjnzTuANtzjuHW3ybPNQ4eTJ7FyolqtQ0iRMMX5IbSrX6Q
   4oVEvAsqeGjEzm5MuaqfsMPzNsCWuchQ2eDj1A0fwp4RFadK7/i3dPgM7
   F5y4x5MvlIhRcqZGojUSHDmXews791zDCEdSbO1mJhdXC0ZFnakAwsY39
   mWfm2WlvnGbE3aIwUuDYFPmfF/AkuLsK+QJ/zOpG6p+gKmCatKUHnYhwN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344609141"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344609141"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 18:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796495005"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796495005"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 18:56:53 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4B52-0000yi-1I;
        Wed, 31 May 2023 01:56:52 +0000
Date:   Wed, 31 May 2023 09:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: cistpl.c:undefined reference to `ioremap'
Message-ID: <202305310948.KgKox74N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   48b1320a674e1ff5de2fad8606bee38f724594dc
commit: 04b38d012556199ba4c31195940160e0c44c64f0 seccomp: Add missing return in non-void function
date:   2 years, 5 months ago
config: s390-randconfig-c041-20230530 (https://download.01.org/0day-ci/archive/20230531/202305310948.KgKox74N-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04b38d012556199ba4c31195940160e0c44c64f0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04b38d012556199ba4c31195940160e0c44c64f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305310948.KgKox74N-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> s390-linux-ld: warning: drivers/of/unittest-data/testcases.dtb.o: missing .note.GNU-stack section implies executable stack
   s390-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>> s390-linux-ld: warning: drivers/of/unittest-data/testcases.dtb.o: missing .note.GNU-stack section implies executable stack
   s390-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   s390-linux-ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x55c): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x6ca): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0xfb4): undefined reference to `memunmap'
   s390-linux-ld: drivers/phy/ingenic/phy-ingenic-usb.o: in function `ingenic_usb_phy_probe':
   phy-ingenic-usb.c:(.text+0x7f0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
>> cistpl.c:(.text+0x1360): undefined reference to `ioremap'
>> s390-linux-ld: cistpl.c:(.text+0x13fe): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x1476): undefined reference to `iounmap'
>> s390-linux-ld: cistpl.c:(.text+0x14b0): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
>> cistpl.c:(.text+0x20aa): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
