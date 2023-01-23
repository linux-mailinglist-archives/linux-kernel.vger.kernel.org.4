Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7041D677521
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 07:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjAWGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 01:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:34:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC13C193EB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674455641; x=1705991641;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cxNxVNpDASesrpSqqUxkWoun0cUE85HT2W/p2X4o1qM=;
  b=nJvS5LOOctkDqwzjm2GE016AThyHDGOeuG+tYe7lrUX5n26ueAlQzKz1
   1VMEl8y+u55DTVNsrgo2ktGXXbFKBCUC2Ng027VuyNesY6/JZZjteaWzg
   6CIIPfe7HhcVaK1EW1mzyQsEjmJFynt1x8ESL9uZyZz90ELJ9uVkOoaii
   7vx5a8dJk+SHQ2hrmCaImHqQ0iGszLS2Gl0UUCfkkn8fcVsW0Kp9IYusx
   uziBDL0DdsVdRf/GKk19PpcrrhstxmDExUehvpcGmUVl7T8xM6g6JyE4I
   5wb+xzXfGuP6epdBySc0WUs0ZOF2zH2LHHnSxw2a1fjkDr+A8Ion2sjK7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="323668862"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="323668862"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 22:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="654782764"
X-IronPort-AV: E=Sophos;i="5.97,238,1669104000"; 
   d="scan'208";a="654782764"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Jan 2023 22:33:59 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJqP0-0005TU-1u;
        Mon, 23 Jan 2023 06:33:58 +0000
Date:   Mon, 23 Jan 2023 14:32:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/mips/bcm47xx/setup.c:undefined reference to `fixed_phy_add'
Message-ID: <202301231443.tZp0eLH6-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2475bf0250dee99b477e0c56d7dc9d7ac3f04117
commit: 61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97 Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
date:   4 months ago
config: mips-randconfig-r015-20230123 (https://download.01.org/0day-ci/archive/20230123/202301231443.tZp0eLH6-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61f2b7c7497ba96cdde5bbaeb9e07f4c48f41f97
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: mipsel-linux-ld: DWARF error: could not find abbrev number 70
   arch/mips/bcm47xx/setup.o: in function `bcm47xx_register_bus_complete':
>> arch/mips/bcm47xx/setup.c:(.init.text+0x130): undefined reference to `fixed_phy_add'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
