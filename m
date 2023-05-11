Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7206FF3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjEKOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbjEKOT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:19:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EC2109
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683814795; x=1715350795;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3vKeUp1MgKXuPO2KHbni+kKpyIP8A1nYuuHf6QGEErM=;
  b=cKIOfwg7R92o7osl0C6V3Ac2Bngyqm3tob1beVvr4y0cxt4jM57qURY/
   na00UGlZOfIOEvrfCoJDCxds8RRSMwL8X/TwmIYaPNZ3/Q+A6U8bDBFYf
   M7a9fg0F1WZEFzQ/zWqhW7n2dUrY6bNBVCFXRu8Fc+F5STo0dnBqz401N
   vTgqckEcE597CPqPOsw3Y9/P4fjCWsyOyBLppvq+uUFcPtG8lsqTMQ0pu
   vy8qtoXIqMtkv+enikNrKNC+XX/bPiCLk1OqW/eDWPez9owUKFQxVCbs8
   5i/FTseE7PCW4d/12FsygL9QpVPfwNsr8Hc4FZhoxenjfR67NH1zgHi8U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="413863231"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="413863231"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 07:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732592975"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="732592975"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 07:15:28 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1px74p-00042e-2U;
        Thu, 11 May 2023 14:15:27 +0000
Date:   Thu, 11 May 2023 22:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: mm/ksm.c:2439:13: warning: stack frame size (2576) exceeds limit
 (2048) in 'ksm_do_scan'
Message-ID: <202305112201.5lqIyEo4-lkp@intel.com>
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
head:   80e62bc8487b049696e67ad133c503bf7f6806f7
commit: 739100c88f49a67c6487bb2d826b0b5a2ddc80e2 mm: add tracepoints to ksm
date:   6 weeks ago
config: mips-randconfig-r023-20230511 (https://download.01.org/0day-ci/archive/20230511/202305112201.5lqIyEo4-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=739100c88f49a67c6487bb2d826b0b5a2ddc80e2
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 739100c88f49a67c6487bb2d826b0b5a2ddc80e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305112201.5lqIyEo4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/ksm.c:2439:13: warning: stack frame size (2576) exceeds limit (2048) in 'ksm_do_scan' [-Wframe-larger-than]
   static void ksm_do_scan(unsigned int scan_npages)
               ^
   2492/2576 (96.74%) spills, 84/2576 (3.26%) variables
   1 warning generated.


vim +/ksm_do_scan +2439 mm/ksm.c

31dbd01f314364 Izik Eidus       2009-09-21  2434  
31dbd01f314364 Izik Eidus       2009-09-21  2435  /**
31dbd01f314364 Izik Eidus       2009-09-21  2436   * ksm_do_scan  - the ksm scanner main worker function.
b7701a5f2ee8e6 Mike Rapoport    2018-02-06  2437   * @scan_npages:  number of pages we want to scan before we return.
31dbd01f314364 Izik Eidus       2009-09-21  2438   */
31dbd01f314364 Izik Eidus       2009-09-21 @2439  static void ksm_do_scan(unsigned int scan_npages)
31dbd01f314364 Izik Eidus       2009-09-21  2440  {
21fbd59136e077 Qi Zheng         2022-08-31  2441  	struct ksm_rmap_item *rmap_item;
3f649ab728cda8 Kees Cook        2020-06-03  2442  	struct page *page;
31dbd01f314364 Izik Eidus       2009-09-21  2443  
878aee7d6b5504 Andrea Arcangeli 2011-01-13  2444  	while (scan_npages-- && likely(!freezing(current))) {
31dbd01f314364 Izik Eidus       2009-09-21  2445  		cond_resched();
31dbd01f314364 Izik Eidus       2009-09-21  2446  		rmap_item = scan_get_next_rmap_item(&page);
31dbd01f314364 Izik Eidus       2009-09-21  2447  		if (!rmap_item)
31dbd01f314364 Izik Eidus       2009-09-21  2448  			return;
31dbd01f314364 Izik Eidus       2009-09-21  2449  		cmp_and_merge_page(page, rmap_item);
31dbd01f314364 Izik Eidus       2009-09-21  2450  		put_page(page);
31dbd01f314364 Izik Eidus       2009-09-21  2451  	}
31dbd01f314364 Izik Eidus       2009-09-21  2452  }
31dbd01f314364 Izik Eidus       2009-09-21  2453  

:::::: The code at line 2439 was first introduced by commit
:::::: 31dbd01f314364b70c2e026a5793a29a4da8a9dc ksm: Kernel SamePage Merging

:::::: TO: Izik Eidus <ieidus@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
