Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE23B6EBE6B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDWKFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 06:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 06:05:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9FBF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682244309; x=1713780309;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gmvNY4fu5Mb4NqFourKixEFkm7gNnLfO+EDYZxX9Ho8=;
  b=naHfzAuxc0uOgEKsZSoiuGEwuTLq8mfyfGwndCbhqCEJ1MGpZ7vGYlo2
   Ol4OQSxZBINDlVj2PrYXj09y19QhafXV4k9wLJgkXrlNdCtL4HMPrYsro
   YfE1n55gU6kbScD+e2onkfIyRKhCZhws1cYD5gSorg3uBJK2lfQmvxAiU
   FiHGHExhYcKfK3Al+cI2MI8yNFZ5wx2m08GY6THA+Bll/hm/sI6BCd5l/
   KfRkbgtW4jcwh6F/AkIciaBsXBbWkp4coqfkkQv6HSpMZa1gQRzh8IN+d
   FxT6guD1wT4MNKbdLNXbxtSPtcm8f8Rnoo1oauZ1euDRWHasqPfrIQbuv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="330477232"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="330477232"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 03:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10688"; a="725349952"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="725349952"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2023 03:05:07 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqWag-000hpc-1A;
        Sun, 23 Apr 2023 10:05:06 +0000
Date:   Sun, 23 Apr 2023 18:04:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [tip:sched/core 5/14] kernel/livepatch/transition.c:17:1: sparse:
 sparse: symbol '__pcpu_scope_klp_stack_entries' was not declared. Should it
 be static?
Message-ID: <202304231758.aIvBHUWI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   f31dcb152a3d0816e2f1deab4e64572336da197d
commit: e92606fa172f63a26054885b9715be86c643229d [5/14] livepatch: Convert stack entries array to percpu
config: s390-randconfig-s052-20230423 (https://download.01.org/0day-ci/archive/20230423/202304231758.aIvBHUWI-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=e92606fa172f63a26054885b9715be86c643229d
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip sched/core
        git checkout e92606fa172f63a26054885b9715be86c643229d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash kernel/livepatch/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304231758.aIvBHUWI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/livepatch/transition.c:17:1: sparse: sparse: symbol '__pcpu_scope_klp_stack_entries' was not declared. Should it be static?

vim +/__pcpu_scope_klp_stack_entries +17 kernel/livepatch/transition.c

    16	
  > 17	#define MAX_STACK_ENTRIES  100
    18	DEFINE_PER_CPU(unsigned long[MAX_STACK_ENTRIES], klp_stack_entries);
    19	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
