Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF34F6878E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjBBJeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjBBJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:33:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B44B6F70F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675330404; x=1706866404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=srm5w7+BKSkrJk00PeZckd1dPmLrk3ZHtxcul7VIOqw=;
  b=ITxl4VBjuxgqcOo1yUM+RVEpXhV091NEBpq9W6nwAXGG2Ra+gTLuSQ2g
   CmY6ZinAZ1God6s2SD6Qm5Kp9yquTC3Cz+wCcPNPcrXX6FlQGONrcHj8i
   oEZJ5vFtVjQl6xzm30J7jZMkltwFZROqvfr6/++VxJhZuZx2kQJayPsPj
   /8t/QI7bvr/4zmtZV4OqZLTdiT9WjMNaTMZ/1gBBc+gpyTVepgDKq0e7I
   wG6HtRjNoHuA145WVocShnmAoBUoj6b6E7AGaNVCTGKqrE6unDcGim2oo
   lKRBoUaUOpu/hKU4+fkPNF2fwCWEfpNn6e612WVLaj/4a7WAt3D0oFy+X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308742880"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="308742880"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="697626478"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; 
   d="scan'208";a="697626478"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2023 01:33:22 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNVy6-0006O2-0l;
        Thu, 02 Feb 2023 09:33:22 +0000
Date:   Thu, 2 Feb 2023 17:32:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d1527fe7]
Message-ID: <202302021738.V4vXGaiB-lkp@intel.com>
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

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f266ccaa2f5228bfe67ad58a94ca4e0109b954a
commit: 725aea873261e8d986e527838fde2a721f0962d8 xtensa: enable KCSAN
date:   9 months ago
config: xtensa-buildonly-randconfig-r006-20230201 (https://download.01.org/0day-ci/archive/20230202/202302021738.V4vXGaiB-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=725aea873261e8d986e527838fde2a721f0962d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 725aea873261e8d986e527838fde2a721f0962d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d1527fe7]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
