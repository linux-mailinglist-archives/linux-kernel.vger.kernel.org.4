Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6B5BC025
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 23:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiIRVhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiIRVhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:37:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6613FA2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 14:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663537069; x=1695073069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=95KkfjHWiXRejSWlzwU6TZO9wKE70nrE556Ez4rDfwY=;
  b=ndFXFEfuVYeYxuI7oB22cgmJ9dE7lSMbYos6LYUyBgztAnZ+gBHZcTQT
   EBSPdmbVc12PtyQ/qeEdf6N1RrzNAeliotiZpA4YQcp5xH7auQgDtMjb1
   8tDpJbxfR3xbQTJGABt3mB0zgjMqWDk1jvm5O1CTvCe/CSFBVYCGk6kIY
   FIRQrNwqGJ6YhKQHS8bySLPNV+C2pgUGWxWuPS18f2cxQpS8DCKeHoQuv
   icMXia9lGrtT5iDXLe4WSfiR9UdWBov9GIqFumNa5pFuqUwsi0/mkL4rU
   U9r9kOYbQ02gg6LGSLUDn1rIG5irB+RODR1PGYL4fGekcpc9FUbyK2X0j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279649376"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="279649376"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 14:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="569424796"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2022 14:37:47 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oa1z1-0001UB-0E;
        Sun, 18 Sep 2022 21:37:47 +0000
Date:   Mon, 19 Sep 2022 05:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 17/21] efi.c:undefined reference to
 `phys_initrd_start'
Message-ID: <202209190507.99kyBqaO-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   54f3c80676eedf739488a57e3356946ce8d1c091
commit: 498ea7824248d5d0aac3a69546303dae4c75e777 [17/21] efi: libstub: unify initrd loading between architectures
config: riscv-randconfig-r042-20220919 (https://download.01.org/0day-ci/archive/20220919/202209190507.99kyBqaO-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=498ea7824248d5d0aac3a69546303dae4c75e777
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 498ea7824248d5d0aac3a69546303dae4c75e777
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/firmware/efi/efi.o: in function `.L207':
>> efi.c:(.init.text+0xeae): undefined reference to `phys_initrd_start'
>> riscv64-linux-ld: efi.c:(.init.text+0xeb6): undefined reference to `phys_initrd_start'
   riscv64-linux-ld: drivers/firmware/efi/efi.o: in function `.L210':
>> efi.c:(.init.text+0xebc): undefined reference to `phys_initrd_size'
>> riscv64-linux-ld: efi.c:(.init.text+0xec0): undefined reference to `phys_initrd_size'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
