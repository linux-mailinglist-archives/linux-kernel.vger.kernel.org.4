Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E830D6FD50B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjEJEXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJEXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:23:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85EA1987
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683692591; x=1715228591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GCMFQRenqUmlyXOX63nLKYwZO6SgghHsb1h9Vi4Qu20=;
  b=biL3B+MN0ZdG9lMPPjyCiQZkZhwu69GHbLhp0H/4JmEIJxelYHiL3/68
   kSTBRnZayMiUJbtiKKcqeEjrWTEntzUkfbssfSEoWCmvJlygFNSAYLCGv
   /ufIQaqXtPIdK2z2B1EVhIFIGuNTHYxE6OkpGshfekD4vRjZmpW9KNBY0
   GsEvnyIgEFBqWqfNNNAKdkBgsw41MiJ9dR0mwwX+PTicEKeVPjPoQWK/9
   NXwI/imHlQ1qTa9pkl6eMLiiJLuyFaglDlAxXX8xRlwrdNCeEsVLa3AgN
   Wh8hGnd41jaCNPfjL9Z/WRLLNPc9HsbrGhhXwSsHwGZXsE3epam4yr4vo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436447544"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="436447544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 21:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="843368812"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="843368812"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 May 2023 21:23:10 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwbM5-0002sk-1f;
        Wed, 10 May 2023 04:23:09 +0000
Date:   Wed, 10 May 2023 12:23:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: include/linux/compiler_types.h:357:45: error: call to
 '__compiletime_assert_287' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(priv_tbl->probs) % 16
Message-ID: <202305101209.GBI8gkQ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16a8829130ca22666ac6236178a6233208d425c3
commit: 00c47aa85bb26450edc6059c3d245de062e60b5d media: rkvdec: Add required padding
date:   6 months ago
config: arm-randconfig-r014-20230509 (https://download.01.org/0day-ci/archive/20230510/202305101209.GBI8gkQ6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00c47aa85bb26450edc6059c3d245de062e60b5d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 00c47aa85bb26450edc6059c3d245de062e60b5d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305101209.GBI8gkQ6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/staging/media/rkvdec/rkvdec-vp9.c: In function 'rkvdec_vp9_start':
>> include/linux/compiler_types.h:357:45: error: call to '__compiletime_assert_287' declared with attribute error: BUILD_BUG_ON failed: sizeof(priv_tbl->probs) % 16
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:338:25: note: in definition of macro '__compiletime_assert'
     338 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:357:9: note: in expansion of macro '_compiletime_assert'
     357 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/staging/media/rkvdec/rkvdec-vp9.c:1011:9: note: in expansion of macro 'BUILD_BUG_ON'
    1011 |         BUILD_BUG_ON(sizeof(priv_tbl->probs) % 16); /* ensure probs size is 128-bit aligned */
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_287 +357 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  354   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  356  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @357  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  358  

:::::: The code at line 357 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
