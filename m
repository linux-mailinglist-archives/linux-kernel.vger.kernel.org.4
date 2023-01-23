Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494A677EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjAWPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:07:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A025261
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674486433; x=1706022433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uL0h8wezhGRHJ8EoYAqOQlzRK0snzaGM9Kpd4VRIxNU=;
  b=GWtN2OQxbZJ4qN7T06K76arz2KcIA+IZg65KMekMjuUHKhh/39AylHhX
   cnMyyMEJ7tjqvZUtuNt/Ud2RLbn592gmmHTP6lOjagSy4ZGD5bSCAhHwf
   +YJB/mpSZ8y94VLDHxMiMoJ9D0qe+rN/S1pzEyiUJGwQIy+/VhTWE+fEK
   MmyMy09tIWggda0lIOqxA1rmCtFsW9gVOLbjr2AAB6AgNk+9JnnTRrgTA
   kpgvVsL7FAJ7fQQ438USkh+OJJFKx8ImGzA18wRDNPUepMfoh04pP1jf6
   SEAxKPebRn2CqiROBloRxEeNGjI+w1T3CSw443D6EDiSx75nZ5a8J66dA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="306413937"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="306413937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="990481532"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="990481532"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jan 2023 07:07:11 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJyPf-0005i8-0P;
        Mon, 23 Jan 2023 15:07:11 +0000
Date:   Mon, 23 Jan 2023 23:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/x86/include/asm/atomic64_32.h:110:34: sparse: sparse: cast
 truncates bits from constant value (100000001 becomes 1)
Message-ID: <202301232313.i8GVDJuq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2475bf0250dee99b477e0c56d7dc9d7ac3f04117
commit: 5d7edbc9231ec6b60f9c5b7e7980e9a1cd92e6bb rxrpc: Get rid of the Rx ring
date:   3 months ago
config: i386-randconfig-s003-20230123 (https://download.01.org/0day-ci/archive/20230123/202301232313.i8GVDJuq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d7edbc9231ec6b60f9c5b7e7980e9a1cd92e6bb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d7edbc9231ec6b60f9c5b7e7980e9a1cd92e6bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   net/rxrpc/call_object.c: note: in included file (through arch/x86/include/asm/atomic.h, include/linux/atomic.h, include/linux/cpumask.h, ...):
>> arch/x86/include/asm/atomic64_32.h:110:34: sparse: sparse: cast truncates bits from constant value (100000001 becomes 1)

vim +110 arch/x86/include/asm/atomic64_32.h

1a3b1d89eded68 Brian Gerst   2010-01-07   99  
1a3b1d89eded68 Brian Gerst   2010-01-07  100  /**
8bf705d130396e Dmitry Vyukov 2018-01-29  101   * arch_atomic64_set - set atomic64 variable
a7e926abc3adfb Luca Barbieri 2010-02-24  102   * @v: pointer to type atomic64_t
1f0459780c2849 Philipp Hahn  2012-05-02  103   * @i: value to assign
1a3b1d89eded68 Brian Gerst   2010-01-07  104   *
a7e926abc3adfb Luca Barbieri 2010-02-24  105   * Atomically sets the value of @v to @n.
1a3b1d89eded68 Brian Gerst   2010-01-07  106   */
79c53a83d7a31a Mark Rutland  2019-05-22  107  static inline void arch_atomic64_set(atomic64_t *v, s64 i)
a7e926abc3adfb Luca Barbieri 2010-02-24  108  {
a7e926abc3adfb Luca Barbieri 2010-02-24  109  	unsigned high = (unsigned)(i >> 32);
a7e926abc3adfb Luca Barbieri 2010-02-24 @110  	unsigned low = (unsigned)i;
819165fb34b977 Jan Beulich   2012-01-20  111  	alternative_atomic64(set, /* no output */,
819165fb34b977 Jan Beulich   2012-01-20  112  			     "S" (v), "b" (low), "c" (high)
819165fb34b977 Jan Beulich   2012-01-20  113  			     : "eax", "edx", "memory");
a7e926abc3adfb Luca Barbieri 2010-02-24  114  }
1a3b1d89eded68 Brian Gerst   2010-01-07  115  

:::::: The code at line 110 was first introduced by commit
:::::: a7e926abc3adfbd2e5e20d2b46177adb4e313915 x86-32: Rewrite 32-bit atomic64 functions in assembly

:::::: TO: Luca Barbieri <luca@luca-barbieri.com>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
