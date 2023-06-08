Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA96B72893C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjFHUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjFHUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:15:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A1E273E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686255340; x=1717791340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bQ8USvTuPShT41vdizddYIMplKOudOsDiNy8CWhvyUI=;
  b=l6diihRGXhwIGVBy8HIhXGyOwPIGC4jbk27YKmvJVndHe1onNwEU05kQ
   Ep9U61MaLqiUZZO1m4cpIp8C9sFwgJDyjBvGYmMM2vR68kYmQtxHDEmB0
   9Cpda59zKEwti6vnyBMk6KEOGWdLpOoBHlqDrGrwYo1yQ4nkvoTn4Wjl0
   2L4NKLAOwT5tSLTyXX9By4MaWeGvwh/f79MRdRVWe4xQDnq+3lrK2Rm/W
   jWpre8eOkB1CdSG3qgYH05x7Z0xddKwLhOMwlUf+nzZTJaqkP0+GxBJs+
   AmV0ZC5RmP+acuOfpyd55ZSffSLdY4brulnuEkjIK1p7QHyIFO29y+iCv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="357429043"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="357429043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 13:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="739892236"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="739892236"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2023 13:15:37 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7M2j-0008EE-0G;
        Thu, 08 Jun 2023 20:15:37 +0000
Date:   Fri, 9 Jun 2023 04:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: lib/zstd/compress/zstd_opt.c:1324:15: warning: stack frame size
 (2224) exceeds limit (2048) in 'ZSTD_compressBlock_opt0'
Message-ID: <202306090430.17nVObx2-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25041a4c02c7cf774d8b6ed60586fd64f1cdaa81
commit: 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f zstd: import usptream v1.5.2
date:   8 months ago
config: riscv-randconfig-r012-20230608 (https://download.01.org/0day-ci/archive/20230609/202306090430.17nVObx2-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2aa14b1ab2c41a4fe41efae80d58bb77da91f19f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2aa14b1ab2c41a4fe41efae80d58bb77da91f19f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/f2fs/ lib/zstd/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306090430.17nVObx2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/zstd/compress/zstd_opt.c:1324:15: warning: stack frame size (2224) exceeds limit (2048) in 'ZSTD_compressBlock_opt0' [-Wframe-larger-than]
   static size_t ZSTD_compressBlock_opt0(
                 ^
>> lib/zstd/compress/zstd_opt.c:1331:15: warning: stack frame size (2128) exceeds limit (2048) in 'ZSTD_compressBlock_opt2' [-Wframe-larger-than]
   static size_t ZSTD_compressBlock_opt2(
                 ^
   2 warnings generated.


vim +/ZSTD_compressBlock_opt0 +1324 lib/zstd/compress/zstd_opt.c

  1323	
> 1324	static size_t ZSTD_compressBlock_opt0(
  1325	        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
  1326	        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
  1327	{
  1328	    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 0 /* optLevel */, dictMode);
  1329	}
  1330	
> 1331	static size_t ZSTD_compressBlock_opt2(
  1332	        ZSTD_matchState_t* ms, seqStore_t* seqStore, U32 rep[ZSTD_REP_NUM],
  1333	        const void* src, size_t srcSize, const ZSTD_dictMode_e dictMode)
  1334	{
  1335	    return ZSTD_compressBlock_opt_generic(ms, seqStore, rep, src, srcSize, 2 /* optLevel */, dictMode);
  1336	}
  1337	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
