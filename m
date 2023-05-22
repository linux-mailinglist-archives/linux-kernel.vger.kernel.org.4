Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0C70C21D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjEVPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVPPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:15:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122EEBB
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684768550; x=1716304550;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YbgBYsdtBuFOCd5GZnI6XwxkpgWD88RCnAHYhSSWfvM=;
  b=Ydtq9Dwo/1DyP/eMbsDib+mRjnwSOAX1ZQfevfPQBYowNudV1s0aksna
   xBp4e/tgOTyM73oavtXphHJGdcEIPZkbC6tt86wJZurfZ4a2xUAO8Pbxp
   vVgNFH8JDmo5Pl+wG/cksx+x8bETsKpRf2m7JnB/KMu7zKCFKuYieGdNs
   LJ5mmztNKAXOh+nP9Vv9RnNcGVx5UYOCghBXl+lc0ZSktZ3kk2MYYX+U0
   C/FPOCLGZPHBJcZV8PN8SFkQmnVrdhqQxNBv+F8giNjmdFa3/kGVGpAsn
   SccNbWrm/cIv111Z9GkdRVShzaWnYG+G4cT8kjTzh0L2VJ6fke56rGG0I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="337536786"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="337536786"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 08:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="653986578"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="653986578"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 May 2023 08:15:48 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q17GF-000Cwh-0T;
        Mon, 22 May 2023 15:15:47 +0000
Date:   Mon, 22 May 2023 23:14:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d10021a7]
Message-ID: <202305222312.r76CQMCu-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44c026a73be8038f03dbdeef028b642880cf1511
commit: c49731a04e7c14b2ccd146a7fddf92e78ccae143 xtensa: enable KCOV support
date:   10 months ago
config: xtensa-buildonly-randconfig-r002-20230521 (https://download.01.org/0day-ci/archive/20230522/202305222312.r76CQMCu-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c49731a04e7c14b2ccd146a7fddf92e78ccae143
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c49731a04e7c14b2ccd146a7fddf92e78ccae143
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305222312.r76CQMCu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d10021a7]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
