Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB95723AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjFFIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFFIFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:05:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDE811A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686038710; x=1717574710;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d7ZgL+E9tpDkE9SuW+sxEunDxqXp9Mq6RlJTeC0grEw=;
  b=LlyRfgZgLcbT7z3U9VWyWMnebKdybBIesfsl1wQfu7qr9hXK5Jhm8c1V
   4GcaE0od2R5UDTngi+65zyQk00DDQgG44NjhlE3rkvbKM0quk0aiffg03
   8xYfc+vfqkMJ52QFxhLKIcTQ2QkLSI48uVJ/sXzpqRsiY/vzEjfu65H/K
   Qpc9H7g+hXoE/vKESbCUYkzZGfgNDMhuXjoBugXiYR/JXw1Gg0whr1te8
   j3GBwwkXNl/eGA+DMyhtqcI7w4oTIBRigrYbM006+FdvFYOssS+WGeKdh
   Mr1gBCu11IAXIm2wlF/xRmjuDXf1HOl18NIjUlYIEaHZzOZcKXNQp+W62
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341238303"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="341238303"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 01:05:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="1039088317"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="1039088317"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jun 2023 01:05:06 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6Rgg-00050h-06;
        Tue, 06 Jun 2023 08:05:06 +0000
Date:   Tue, 6 Jun 2023 16:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: error: A dwo section may not contain relocations
Message-ID: <202306061557.A6csfwPr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f8dba31b0a826e691949cd4fdfa5c30defaac8c5
commit: 61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97 Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
date:   9 months ago
config: riscv-randconfig-r026-20230606 (https://download.01.org/0day-ci/archive/20230606/202306061557.A6csfwPr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306061557.A6csfwPr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
>> error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1 shuffle=3768112586
   make[2]: Target 'include/generated/vdso-offsets.h' not remade because of errors.
   make[1]: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2 shuffle=3768112586
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2 shuffle=3768112586
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
