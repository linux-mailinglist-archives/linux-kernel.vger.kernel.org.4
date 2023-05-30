Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15B47156A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjE3HZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjE3HYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:24:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAECE6D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685431416; x=1716967416;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QmE5raCYtoX7Rj64l5U6B0AGowV72uFpfHb/vvgCVaU=;
  b=I67HgO71zDYgxfSyNbiV7mH2ugEuSvwNuPfHOsGJ0LlYTl5OQWibq1/z
   wMNj5PpiVyLzxjuVkNdF9yJdHPCoQY+QLNk2WBJTkWNoQdpfi0cvWcntT
   0w77lg6gz2Gdmg9XMGVYoptIeWBPWJb6yhY0lQem3hIv2H5tMUoqH+a9z
   pWWd0OI65T3mM963MhwG2urbrlMPCeq0ckDkQ9aUY3oUQ80Mvz2ywuLU6
   Ahd0tE0jUvlX2EKlbEKu0FKS9pulvu9nBMLQlswn1ucHcJIpqLrf1lE4O
   fd3LCxpX7PayxOJX/GaLAU4jgP7X6rmGm1YkXS0PTeoZbfij00WgzAUq6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="334460185"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="334460185"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 00:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="706314237"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="706314237"
Received: from lkp-server01.sh.intel.com (HELO fd90924b3b99) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 00:23:13 -0700
Received: from kbuild by fd90924b3b99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3thI-0000Bu-1o;
        Tue, 30 May 2023 07:23:12 +0000
Date:   Tue, 30 May 2023 15:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: loongarch64-linux-gcc: error: unrecognized command-line option
 '-mexplicit-relocs'
Message-ID: <202305301542.s8Ekg4Z0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: 11cd8a648301af0ad6937ed9493519d1e93fd4c8 LoongArch: Adjust symbol addressing for AS_HAS_EXPLICIT_RELOCS
date:   8 months ago
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230530/202305301542.s8Ekg4Z0-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11cd8a648301af0ad6937ed9493519d1e93fd4c8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 11cd8a648301af0ad6937ed9493519d1e93fd4c8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=loongarch prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305301542.s8Ekg4Z0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> loongarch64-linux-gcc: error: unrecognized command-line option '-mexplicit-relocs'
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
>> loongarch64-linux-gcc: error: unrecognized command-line option '-mexplicit-relocs'
>> loongarch64-linux-gcc: error: unrecognized command-line option '-mexplicit-relocs'
>> loongarch64-linux-gcc: error: unrecognized command-line option '-mdirect-extern-access'
   make[2]: *** [scripts/Makefile.build:249: scripts/mod/empty.o] Error 1
>> loongarch64-linux-gcc: error: unrecognized command-line option '-mdirect-extern-access'
   make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1204: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
