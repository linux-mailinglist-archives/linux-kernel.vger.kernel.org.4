Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C87671F32
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjAROP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAROO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:14:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF25305FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674050151; x=1705586151;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ATQLY5GcAhxWBQxd2i39/Q19S+mjpJkCKAzTmphEH30=;
  b=knq8Z4F6FQ7UPMYZLTiaLZTVFPuChWOWF8MNC20D3/N6XMdZxUqHVxnt
   +WRA+BltxchYYRK/IeF3t3uNw1e3SQtGrjGl1fQokZ2zeFW5Liw8hiZgo
   4SWE8OGL1aCjmoa2MOlJTOEQ9/YIn6qEsANPwOncN+DTrcBcpwnIZpSJm
   V6Wz0U/ZM8S5VmXgnGhPq9FlMYiYpPwBgALGvFskin/WiakvYcFJeY2S2
   MTKQ5HyI5mL7QmFwuHzkyF2eBQvwzS3Gz8uvrkXwN8AO/QmOOwyA8dZGn
   ut8h39MfqK4izXZSPDJbUnmsQjOFX3fDw9P8s0rT9qd6peFShswY4ya4M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="327059705"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327059705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="609656405"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="609656405"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Jan 2023 05:55:49 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI8uq-0000NM-2b;
        Wed, 18 Jan 2023 13:55:48 +0000
Date:   Wed, 18 Jan 2023 21:55:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/rv/monitors/wip/wip.c:20:1: warning: unused function
 'da_handle_start_run_event_wip'
Message-ID: <202301182158.8nHlCmQ9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1649ec55708ae42091a2f1bca1ab49ecd722d55
commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
date:   6 months ago
config: mips-randconfig-r022-20230118 (https://download.01.org/0day-ci/archive/20230118/202301182158.8nHlCmQ9-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10bde81c74863472047f31304064018c40f488ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 10bde81c74863472047f31304064018c40f488ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/trace/rv/ lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/rv/monitors/wip/wip.c:20:1: warning: unused function 'da_handle_start_run_event_wip' [-Wunused-function]
   DECLARE_DA_MON_PER_CPU(wip, unsigned char);
   ^
   include/rv/da_monitor.h:532:48: note: expanded from macro 'DECLARE_DA_MON_PER_CPU'
   DECLARE_DA_MON_INIT_PER_CPU(name, type)                                                         \
                                                                                                   ^
   include/rv/da_monitor.h:434:20: note: expanded from macro '\
   DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT'
   static inline bool da_handle_start_run_event_##name(enum events_##name event)                   \
                      ^
   <scratch space>:174:1: note: expanded from here
   da_handle_start_run_event_wip
   ^
   1 warning generated.


vim +/da_handle_start_run_event_wip +20 kernel/trace/rv/monitors/wip/wip.c

8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  19  struct rv_monitor rv_wip;
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  

:::::: The code at line 20 was first introduced by commit
:::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k

:::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
:::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
