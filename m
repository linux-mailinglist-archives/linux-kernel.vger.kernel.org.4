Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408786944DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBMLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBMLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:52:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFFF1284C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676289138; x=1707825138;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=36MqNQw1Ub4qT04YZlIKdGj+rtqZNg2khJWpqXm6ms0=;
  b=FdhhDpTc4mE8K6AomPsyVP1aUR3+NqC74OUBtOk9Cl4gNWPWNwivOtjy
   6gVDEDwyf1q7BWEkVHKYQAu8z2BqT+8kXV6agavqEJyCTKW7NoLq/Y1FV
   PDZUFD4H+bCwNZv7ZP9g8CTTVwHJcE/N8lfMA7Cr/v1BUHOwGSZQJXq9T
   JoVSnjoeinaPnYENHxeKQqhfm/1PuXIyWwA8A7lVpkgTEy7pXNGOZHMDz
   w7MeiBAn4njvUt1c6OvVlLNHgGnB15vEsGEBx3YTmFMee1AsKvfem2oO5
   3EBf++nb9/gt4rz+tzHDKyEHyDy5XXsj16EL2XPgAogRWEAwm/pcM7WfM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="358281975"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="358281975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 03:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="701241945"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="701241945"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Feb 2023 03:52:16 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRXNX-0007iX-1V;
        Mon, 13 Feb 2023 11:52:15 +0000
Date:   Mon, 13 Feb 2023 19:51:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: pahole: .tmp_vmlinux.btf: No such file or directory
Message-ID: <202302131934.6f0mCaxY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceaa837f96adb69c0df0397937cd74991d5d821a
commit: 4e8bb4ba5a558159ffbfa7e60322a1c151c3903c csky: Add jump-label implementation
date:   7 months ago
config: csky-randconfig-r006-20230213 (https://download.01.org/0day-ci/archive/20230213/202302131934.6f0mCaxY-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e8bb4ba5a558159ffbfa7e60322a1c151c3903c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4e8bb4ba5a558159ffbfa7e60322a1c151c3903c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302131934.6f0mCaxY-lkp@intel.com/

All errors (new ones prefixed by >>):

   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   `.exit.text' referenced in section `__jump_table' of drivers/rapidio/switches/idt_gen2.o: defined in discarded section `.exit.text' of drivers/rapidio/switches/idt_gen2.o
   drivers/char/random.o: in function `add_interrupt_randomness':
   drivers/char/random.c:1000:(.text+0x28c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.c:1005:(.text+0x2cc): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.c:1018:(.text+0x2fc): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.o: in function `lockdep_init_map_waits':
   include/linux/lockdep.h:191:(.text+0x338): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.o: in function `random_fasync':
   drivers/char/random.c:1405:(.text+0x352): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.o: in function `__blake2s_init':
   include/crypto/blake2s.h:64:(.text+0x3f4): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.o: in function `blake2s':
   include/crypto/blake2s.h:100:(.text+0x412): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   include/crypto/blake2s.h:101:(.text+0x41a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.o: in function `extract_entropy':
   drivers/char/random.c:604:(.text+0x46c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.c:607:(.text+0x478): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   drivers/char/random.c:607:(.text+0x480): additional relocation overflows omitted from the output
>> pahole: .tmp_vmlinux.btf: No such file or directory
   .btf.vmlinux.bin.o: file not recognized: file format not recognized

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
