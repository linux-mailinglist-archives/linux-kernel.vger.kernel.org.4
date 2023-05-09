Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9036FD268
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjEIWO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEIWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:14:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD723A88
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683670495; x=1715206495;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dANONa1DPO/BbwE8Bny4oBm6ve4Cbsy61v0wAbQU4Og=;
  b=nBp8af6t+ql0eA04Ch5s/bbJP4QGVUDYRLR9tgvwVK86JMDmhLRh/XGL
   fOuWkURlbheeDpqS7LAfGtE2/AF87WSJPWJvwnKPLJ3deCfGnHKV9Fuw8
   ev5JMu3B6isL0kiZVlr95/kH3x0n4s5p6u9NZM8Ird6hsj3OlUHzSOgWO
   XbLxFEOvrFg2FjyLktXgub242SJGTjiF5W5w2pvtKF/27xMSdCONZZFmg
   0aIYBRpu/NeSp6tmjyWm8Jl3RAW9RSnSRXOnszgjgczdy3p4/mUQzjmM6
   gD3RvHnnLTGA4FSLPZ76k6aHT/wuZvSWpQo2EkJIC/JAVnXdDAMoVe54z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="334523734"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="334523734"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 15:14:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="649513029"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="649513029"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 May 2023 15:14:53 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwVbg-0002Yr-2O;
        Tue, 09 May 2023 22:14:52 +0000
Date:   Wed, 10 May 2023 06:14:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/um/drivers/harddog_user.c:6:10: fatal error: stdio.h: No such
 file or directory
Message-ID: <202305100640.HGwVAUIt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16a8829130ca22666ac6236178a6233208d425c3
commit: fc54a4f15988e228cf88f888483e985c5f35031e um: prevent user code in modules
date:   3 weeks ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20230510/202305100640.HGwVAUIt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fc54a4f15988e228cf88f888483e985c5f35031e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fc54a4f15988e228cf88f888483e985c5f35031e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um olddefconfig
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305100640.HGwVAUIt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/um/drivers/harddog_user.c:6:10: fatal error: stdio.h: No such file or directory
       6 | #include <stdio.h>
         |          ^~~~~~~~~
   compilation terminated.


vim +6 arch/um/drivers/harddog_user.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  @6  #include <stdio.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16   7  #include <unistd.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16   8  #include <errno.h>
37185b33240870 Al Viro        2012-10-08   9  #include <os.h>
^1da177e4c3f41 Linus Torvalds 2005-04-16  10  

:::::: The code at line 6 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
