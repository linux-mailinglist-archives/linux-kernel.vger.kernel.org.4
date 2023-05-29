Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C4714FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjE2TWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2TWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:22:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9BCD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685388168; x=1716924168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7xOvPB71Pz15TnZf97YsAhKKe2nSXBqN1iImorpN5tI=;
  b=XUOT9ZNqefrpP1a40003C+KSqClhqWeTyg0w4OI3TmZYqD8r/jV8k3uG
   9p3PURRkjSwK+xtIqgoosnyxa0MTOTVTYr1VXWdZk81TMSmmBE1tfhyLO
   h26GYF072WjetpjinuYXurcOG886Y093BPnR0uO1X+Pc5rvxaL29N4+5U
   +FKdyWDuqVRPMvCyK6BcpjB7RxRFb2mfv32Ci6pu2l1yfeUNNAXDbUo7g
   TII4iZXzjLply806R3toN0OjZyuZKsK5pdYs1SUo0jqc9Mnb89HdRp5a0
   +jR9PuCk9GzPdS3WFWUm0dMNpr8iQbgqt/UDqc15SF3ACU1+m6BeFMHHY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357135984"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="357135984"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 12:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830469581"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="830469581"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 May 2023 12:22:39 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3iRy-000L6U-3A;
        Mon, 29 May 2023 19:22:38 +0000
Date:   Tue, 30 May 2023 03:22:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: undefined reference to `ftrace_likely_update'
Message-ID: <202305300324.O7irARsx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8b817fded42d8fe3a0eb47b1149d907851a3c942
commit: 54d9469bc515dc5fcbc20eecbe19cea868b70d68 fortify: Add run-time WARN for cross-field memcpy()
date:   9 months ago
config: s390-randconfig-r033-20230529 (https://download.01.org/0day-ci/archive/20230530/202305300324.O7irARsx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d9469bc515dc5fcbc20eecbe19cea868b70d68
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 54d9469bc515dc5fcbc20eecbe19cea868b70d68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305300324.O7irARsx-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390x-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
>> (.text+0x23f2): undefined reference to `ftrace_likely_update'
>> s390x-linux-ld: (.text+0x240a): undefined reference to `ftrace_likely_update'
   s390x-linux-ld: (.text+0x2422): undefined reference to `ftrace_likely_update'
   s390x-linux-ld: (.text+0x2ad8): undefined reference to `ftrace_likely_update'
   s390x-linux-ld: (.text+0x2af0): undefined reference to `ftrace_likely_update'
   s390x-linux-ld: arch/s390/purgatory/purgatory:(.text+0x2b08): more undefined references to `ftrace_likely_update' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
