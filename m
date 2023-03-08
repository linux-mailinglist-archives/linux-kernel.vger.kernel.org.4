Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3306B137A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCHVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHVCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:02:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CFA5FEA2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678309320; x=1709845320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4h+DzKQ2OlM6SP8197YncaUzixfIkTFeYm9PCu84nEQ=;
  b=P8L7dFp2kqKTOZgC9vVRqfAMTvrE/zuQDUIQBzvQ5Sa+lhlgidXvMb60
   4qy4rHhICbdD2haG+DKwxx81h5xgaEFSTJVXBlVxIUwZaw23Ja/7+08nw
   Z5bnQm0KIeTA0Q9ko+qxEv9tINf2Khp3z8TlB7px6goaDXz4qIhGquCqC
   y7RTMDr/7dz7ruLJcYelU47HCRCG3PDNEegQAR75msndcWK5FNkv7TwBk
   a4ZVh+2HuNvxva4vHthJiyg2BBwwtk7wZV+7Czbcr5ZCNGddC4jBGY2lB
   lr4FF/Zal52rUaVd43K9oGsWkApjSLYhDuSNEoH+gHwSIU7jFzfgsqfBk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="315932422"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="315932422"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 13:02:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="627080662"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="627080662"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2023 13:01:58 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pa0v7-0002Or-2B;
        Wed, 08 Mar 2023 21:01:57 +0000
Date:   Thu, 9 Mar 2023 05:01:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: ld.lld: error: undefined symbol: memcpy
Message-ID: <202303090422.ss2Hbm4f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
commit: 36be5cba99f6f9984a9a9f0454f95a38f4184d3e kasan: treat meminstrinsic as builtins in uninstrumented files
date:   6 days ago
config: powerpc-randconfig-r036-20230305 (https://download.01.org/0day-ci/archive/20230309/202303090422.ss2Hbm4f-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36be5cba99f6f9984a9a9f0454f95a38f4184d3e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 36be5cba99f6f9984a9a9f0454f95a38f4184d3e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303090422.ss2Hbm4f-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: memcpy
   >>> referenced by xmon.c:1896 (arch/powerpc/xmon/xmon.c:1896)
   >>>               arch/powerpc/xmon/xmon.o:(prregs) in archive vmlinux.a
   >>> referenced by zstd_compress.c:4814 (lib/zstd/compress/zstd_compress.c:4814)
   >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_createCDict_advanced2) in archive vmlinux.a
   >>> referenced by zstd_compress.c:4910 (lib/zstd/compress/zstd_compress.c:4910)
   >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_initStaticCDict) in archive vmlinux.a
   >>> referenced 5 more times
--
>> ld.lld: error: undefined symbol: memset
   >>> referenced by slab_common.c:579 (mm/slab_common.c:579)
   >>>               mm/slab_common.o:(kmem_dump_obj) in archive vmlinux.a
   >>> referenced by kasan_test.c:558 (mm/kasan/kasan_test.c:558)
   >>>               mm/kasan/kasan_test.o:(kmalloc_oob_in_memset) in archive vmlinux.a
   >>> referenced by kasan_test.c:505 (mm/kasan/kasan_test.c:505)
   >>>               mm/kasan/kasan_test.o:(kmalloc_oob_memset_2) in archive vmlinux.a
   >>> referenced 10 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
