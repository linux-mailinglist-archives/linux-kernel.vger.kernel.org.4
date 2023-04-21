Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE56EA800
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjDUKMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDUKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:12:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E8CC1D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 03:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682071925; x=1713607925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4aafpviBjMdmVl1tYI74mrfUxpftsvqb24MJnMScOZQ=;
  b=MEkW8s+bRPJnpDWDSDV/RVWZkBLc1vLXJA8UL9zAkq6ewRLFkboZkYTY
   nH7iNaV4Q5LJBUCa90aZcyIlAaU1tUEWIy/2Iw2oLwYP3e3Gh1Y5pT8Ff
   g2MM9KfZf9qdz1DVDJkJA+2AF2qctKBwxlOsX0h4D9LjQjZ/veZjmSGBq
   uhshJsppGi13r3Njk/s3gnz/MmDvGbB0yvYkwIDXHGqpWgP1/BaofnFmq
   h+66XxdHHHWoh8bYcY/4ykWDtI8xClaOIhFeIebUiJUyPZ1o3wSBpvkfK
   Sj/okK3L1MSD773/Yvz5tdHOCfAlEyQhcwH3Ts/glVqfib7kjw8GJmuAr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="330158026"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="330158026"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 03:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938429236"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="938429236"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2023 03:11:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppnjS-000gWG-2y;
        Fri, 21 Apr 2023 10:11:10 +0000
Date:   Fri, 21 Apr 2023 18:11:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame
 size (1344) exceeds limit (1280) in 'atags_to_fdt'
Message-ID: <202304211812.XJkXpaNm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2af3e53a4dc08657f1b46f97f04ff4a0ab3cad8d
commit: 672513bf583157cc088a32e75bd850dd9f81564c ARM: decompressor: disable stack protector
date:   1 year, 5 months ago
config: arm-randconfig-r046-20230420 (https://download.01.org/0day-ci/archive/20230421/202304211812.XJkXpaNm-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=672513bf583157cc088a32e75bd850dd9f81564c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 672513bf583157cc088a32e75bd850dd9f81564c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304211812.XJkXpaNm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: no previous prototype for function 'atags_to_fdt' [-Wmissing-prototypes]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   arch/arm/boot/compressed/atags_to_fdt.c:129:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
   ^
   static 
>> arch/arm/boot/compressed/atags_to_fdt.c:129:5: warning: stack frame size (1344) exceeds limit (1280) in 'atags_to_fdt' [-Wframe-larger-than]
   int atags_to_fdt(void *atag_list, void *fdt, int total_space)
       ^
   52/1344 (3.87%) spills, 1292/1344 (96.13%) variables
   2 warnings generated.


vim +/atags_to_fdt +129 arch/arm/boot/compressed/atags_to_fdt.c

31d0b9f9982f8e Ben Dooks          2018-10-12  120  
b90b9a38251e9c Nicolas Pitre      2011-09-13  121  /*
b90b9a38251e9c Nicolas Pitre      2011-09-13  122   * Convert and fold provided ATAGs into the provided FDT.
b90b9a38251e9c Nicolas Pitre      2011-09-13  123   *
4716e2e34a22a8 Geert Uytterhoeven 2021-05-19  124   * Return values:
b90b9a38251e9c Nicolas Pitre      2011-09-13  125   *    = 0 -> pretend success
b90b9a38251e9c Nicolas Pitre      2011-09-13  126   *    = 1 -> bad ATAG (may retry with another possible ATAG pointer)
b90b9a38251e9c Nicolas Pitre      2011-09-13  127   *    < 0 -> error from libfdt
b90b9a38251e9c Nicolas Pitre      2011-09-13  128   */
b90b9a38251e9c Nicolas Pitre      2011-09-13 @129  int atags_to_fdt(void *atag_list, void *fdt, int total_space)

:::::: The code at line 129 was first introduced by commit
:::::: b90b9a38251e9c89c34179eccde57411ceb5f1aa ARM: zImage: allow supplementing appended DTB with traditional ATAG data

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Nicolas Pitre <nico@fluxnic.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
