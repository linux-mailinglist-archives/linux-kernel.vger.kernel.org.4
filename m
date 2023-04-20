Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE026E950F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjDTMvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDTMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:51:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218910F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681995103; x=1713531103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DNcxqjV0tgSOBl2vw77/oJ/xpDsWn0w/fRbLCUKeRzI=;
  b=j+WAQpiPMS+TOXlfIEa+KJuo2kCZsLn/M8vszN8/1cJhT2XX1CQR5hz2
   DpZkV7B2L8bsbrwG/qljai47+c7KTgQlXvkFHarludtNb7rl1UuOQBujP
   QyJOegHaLbD3F7qMAcO4PXmpbkO+Eid64kJT3Am7AGJVWMq+C0zyobv+T
   8THhdNdM3U4mFKiqlFHfjGLONQ/rG6gEnnGUvK9qRhnUmVKH73l8sXHSF
   sJn60C97aOF6b34vJYo82kiT8ETiwWCeGmIE0j8IefDytH9pGj26XrmBW
   rJjfPPZQgTYwpmvyOGdAuv0unSKVmq7yOiq6/xVQo/OxMz1nKbd3vR643
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="334557355"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="334557355"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 05:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="816002860"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="816002860"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2023 05:51:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppTlF-000fqE-0f;
        Thu, 20 Apr 2023 12:51:41 +0000
Date:   Thu, 20 Apr 2023 20:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zack Rusin <zackr@vmware.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: Inconsistent kallsyms data
Message-ID: <202304202029.z4wDrmhv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb0856346a60fe3eb837ba5e73588a41f81ac05f
commit: a2a04b515562bbb040e8ae3decae8c1e9ef05327 Merge tag 'drm-misc-fixes-2023-02-16' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
date:   9 weeks ago
config: arm-buildonly-randconfig-r006-20230418 (https://download.01.org/0day-ci/archive/20230420/202304202029.z4wDrmhv-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2a04b515562bbb040e8ae3decae8c1e9ef05327
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a2a04b515562bbb040e8ae3decae8c1e9ef05327
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304202029.z4wDrmhv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Inconsistent kallsyms data
   Try make KALLSYMS_EXTRA_PASS=1 as a workaround

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
