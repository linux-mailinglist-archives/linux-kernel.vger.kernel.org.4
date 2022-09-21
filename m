Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C235BF596
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIUEv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIUEvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:51:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712057D1F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663735866; x=1695271866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qQODaH30nCexuxzGdRDmgvd2Yn0DUhVfstRv7Lm9h9E=;
  b=N5R6VAZETFLEYdpT5Gkqp8hgQxqNKddP/74T9iytU4sGUpzhqK5CeMpL
   epFuSdTw+xoMh/8FN7XmJtQ1hd1GDMGtc3bQw9ZxLO7ND2WohvVcq1Xo6
   kKD5fKEPgHKbtWqs4WZZq++QvqPHU/boIEJ6KWdk/JTyksvVvTjKaf79c
   xqtUPSTvLIjSGJZDGvNe2Dq7+uv4QGAN6f/UWnecqGzFLXbGc2QaoA32T
   Wy77b0Pby7sFLD1s1lk+bPO+1zSr+jhvOF+9k9t+mlplxrwNTr8xNOjOE
   R4Tg3yolbcb9OwoqrXGq2DWmLfMH40N3jWRa+Dh+HR0PposNgOgBcPDQn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282945194"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="282945194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 21:51:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="596814474"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Sep 2022 21:51:04 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oarhP-0003F6-1v;
        Wed, 21 Sep 2022 04:51:03 +0000
Date:   Wed, 21 Sep 2022 12:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse:
 cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
Message-ID: <202209211209.ikyCliaa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   60891ec99e141b74544d11e897a245ef06263052
commit: e3d18cee258b898017b298b5b93f8134dd62aee3 locking/atomic: centralize generated headers
date:   1 year, 2 months ago
config: ia64-randconfig-s053-20220921 (https://download.01.org/0day-ci/archive/20220921/202209211209.ikyCliaa-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e3d18cee258b898017b298b5b93f8134dd62aee3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e3d18cee258b898017b298b5b93f8134dd62aee3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   lib/atomic64_test.c: note: in included file (through include/linux/atomic.h):
>> include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 37)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (ffffffffaaa31337 becomes 1337)
>> include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:476:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:483:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:490:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 22)
   include/linux/atomic/atomic-instrumented.h:497:16: sparse: sparse: cast truncates bits from constant value (11112222 becomes 2222)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes d00d)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (aaa31337c001d00d becomes c001d00d)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
>> include/linux/atomic/atomic-instrumented.h:1054:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1061:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1068:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes 1)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f001)
   include/linux/atomic/atomic-instrumented.h:1075:16: sparse: sparse: cast truncates bits from constant value (faceabadf00df001 becomes f00df001)

vim +476 include/linux/atomic/atomic-instrumented.h

aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  471  
c020395b6634b7 include/asm-generic/atomic-instrumented.h Marco Elver  2019-11-26  472  static __always_inline int
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  473  atomic_cmpxchg(atomic_t *v, int old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  474  {
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h Marco Elver  2020-07-24  475  	instrument_atomic_read_write(v, sizeof(*v));
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04 @476  	return arch_atomic_cmpxchg(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  477  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  478  
c020395b6634b7 include/asm-generic/atomic-instrumented.h Marco Elver  2019-11-26  479  static __always_inline int
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  480  atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  481  {
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h Marco Elver  2020-07-24  482  	instrument_atomic_read_write(v, sizeof(*v));
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  483  	return arch_atomic_cmpxchg_acquire(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  484  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  485  
c020395b6634b7 include/asm-generic/atomic-instrumented.h Marco Elver  2019-11-26  486  static __always_inline int
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  487  atomic_cmpxchg_release(atomic_t *v, int old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  488  {
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h Marco Elver  2020-07-24  489  	instrument_atomic_read_write(v, sizeof(*v));
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  490  	return arch_atomic_cmpxchg_release(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  491  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  492  
c020395b6634b7 include/asm-generic/atomic-instrumented.h Marco Elver  2019-11-26  493  static __always_inline int
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  494  atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  495  {
3570a1bcf45e9a include/asm-generic/atomic-instrumented.h Marco Elver  2020-07-24  496  	instrument_atomic_read_write(v, sizeof(*v));
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04 @497  	return arch_atomic_cmpxchg_relaxed(v, old, new);
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  498  }
aa525d063851a9 include/asm-generic/atomic-instrumented.h Mark Rutland 2018-09-04  499  

:::::: The code at line 476 was first introduced by commit
:::::: aa525d063851a98e020b827fdd1d7776ae652301 locking/atomics: Switch to generated instrumentation

:::::: TO: Mark Rutland <mark.rutland@arm.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
