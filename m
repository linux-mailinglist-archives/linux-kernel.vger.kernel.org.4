Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE536CF969
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3DEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3DE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:04:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793D45240
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680145467; x=1711681467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9EltCdudEdttZj7/KIfLl6F8Q1jp/dfvDazeWeBsh+Q=;
  b=CYRKDQDbRxaOBgsJePOjy+hUDk8h5/FJMU5g3KtC4hrPcmelHxioetao
   4pt2wSmvdNgeydSpWsNdxUIg9xe/W3H2+3tqW8lX+1pphBJwm841TKpBa
   6T/OAYV7VuQoDyL96czEaQp/YZCq4xfxHJemFv2L+s5e07Rd9N6Ksnq8f
   aIE2d+5wL4Fx613k/R6ajDQdc6acN93SltO3pxuwsVSNtsAjYO2rzZIpm
   NRhmj2q3y/e0qVasNQNItmAdE9u4SC979+aaeexqJn6WQ/VZsigCq0jhU
   lxQtHSk53MUWxwylHlDr/4buv/K1Kwur12jwrpGGwyVBYfUFYMIsxYFAj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341073689"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341073689"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 20:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="930563232"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="930563232"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Mar 2023 20:04:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phiaO-000KFe-1w;
        Thu, 30 Mar 2023 03:04:24 +0000
Date:   Thu, 30 Mar 2023 11:03:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:locking/rcuref 2/2] arch/arm64/include/asm/cmpxchg.h:174:1:
 sparse: sparse: cast truncates bits from constant value (ffffffffe0000000
 becomes 0)
Message-ID: <202303301144.szF9LGFj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rcuref
head:   ee1ee6db07795d9637bc5e8993a8ddcf886541ef
commit: ee1ee6db07795d9637bc5e8993a8ddcf886541ef [2/2] atomics: Provide rcuref - scalable reference counting
config: arm64-randconfig-s041-20230329 (https://download.01.org/0day-ci/archive/20230330/202303301144.szF9LGFj-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip locking/rcuref
        git checkout ee1ee6db07795d9637bc5e8993a8ddcf886541ef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303301144.szF9LGFj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/rcuref.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/linux/rcuref.h):
>> arch/arm64/include/asm/cmpxchg.h:174:1: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)
>> arch/arm64/include/asm/cmpxchg.h:174:1: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)

vim +174 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  171  
305d454aaa292b Will Deacon     2015-10-08  172  __CMPXCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  173  __CMPXCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08 @174  __CMPXCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08  175  __CMPXCHG_GEN(_mb)
10b663aef1c247 Catalin Marinas 2012-03-05  176  

:::::: The code at line 174 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
