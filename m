Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC977297DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjFILJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbjFILJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:09:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067972115
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686308954; x=1717844954;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wVr1kLbtriASKspXcRj+ZyuEM7xKec0xrsttnTYTUqQ=;
  b=FE3iSz7Nq2oO9QnSZmnBd23tO0t1iGt7FiYKprpYc/pbQA8nIM09STkD
   +aOndeEKtRSsptPDlx5fYSSZp0tWseV0Die5gcJ+cXNK9NLicyuAiUTuD
   T5dWZ9roNryC2eeaEZWh5xp9M5PYyZwfAYZK5RGzg5DwfrFVC/VhVDSZ/
   +QXJpsSDdFoMFwyF25BYJkhjwG5YfjCQaJy5SvnlScdk3qcxOoJMPHUIC
   y8yrMJb+KrsrmFe4op1nZ/1a/urKeUD4i8E6taH9qNOH5YiclfQWly9we
   fxOnesldzsplA7X9vuoYmnwhVwVxYILb3FJQ7E9sv2buLtOk+9AEMWMbJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="443942914"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="443942914"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 04:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713477018"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="713477018"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 04:09:07 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7ZzP-0008x1-0f;
        Fri, 09 Jun 2023 11:09:07 +0000
Date:   Fri, 9 Jun 2023 19:08:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 '.L.str'; recompile with -fPIC
Message-ID: <202306091810.x8zmn8Qv-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741 riscv: Fix relocatable kernels with early alternatives using -fno-pie
date:   9 days ago
config: riscv-randconfig-r001-20230609 (https://download.01.org/0day-ci/archive/20230609/202306091810.x8zmn8Qv-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8dc2a7e8027fbeca0c7df81d4c82e735a59b5741
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091810.x8zmn8Qv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:0 (arch/riscv/errata/sifive/errata.c:0)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L__unnamed_4'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L__unnamed_4'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L__unnamed_5'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L__unnamed_5'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L__unnamed_6'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L__unnamed_6'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L__unnamed_7'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L__unnamed_7'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L__unnamed_8'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:66 (arch/riscv/errata/sifive/errata.c:66)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
..

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
