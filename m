Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA26DB699
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 00:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDGWkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGWkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:40:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CFCC2C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680907225; x=1712443225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=14cBJo9UK+0qh1NvtGqbCTaR4qD2pZbzWVL8nzWFfhQ=;
  b=gEGGPoJmvUWn6E9883HQIeGMZknMSM4dneGoLbW523zN5q67+B5CJugL
   /cdwkOWDwPBQCDg7ZuibbgF00kIcgmeFxPbnlCoPwFsXW0WMlrRG28AWH
   PZxB5EKcvbVA3JJF/tazFEJRAZ0Tx3oQfSwuRfw6/r4e8W3XZZAE474Vo
   B4hVdrtZl2EeqVySD4w4JBdDFj0Kf4SiZ8VeP+j5tZSfg56z8FfMwwcqt
   GDQAeES0EViBSpMrysUCjlM4nUgzGLZXYnbNN7z9x45wdG5E8zPigAYZL
   A/daoEk71aLibPVx5/8kFP8wQRWHCZ1PQL50Z0IzMSRu6CDMhEGUwTkaL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="405903218"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="405903218"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 15:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="811534766"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="811534766"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Apr 2023 15:40:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkukb-000Swm-0i;
        Fri, 07 Apr 2023 22:40:09 +0000
Date:   Sat, 8 Apr 2023 06:39:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .Level2InterruptVector.text VMA
 [0000000000000180,0000000000000193] overlaps section .data VMA
 [0000000000000000,0000000000140ca7]
Message-ID: <202304080645.S7qi0nDB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2afccfefe7be1f7346564fe619277110d341f9b
commit: c20e1117d9aa22c558646a1060ddd1dd042fb107 xtensa: add kernel ABI selection to Kconfig
date:   1 year, 1 month ago
config: xtensa-randconfig-r032-20230407 (https://download.01.org/0day-ci/archive/20230408/202304080645.S7qi0nDB-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c20e1117d9aa22c558646a1060ddd1dd042fb107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c20e1117d9aa22c558646a1060ddd1dd042fb107
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304080645.S7qi0nDB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .Level2InterruptVector.text VMA [0000000000000180,0000000000000193] overlaps section .data VMA [0000000000000000,0000000000140ca7]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
