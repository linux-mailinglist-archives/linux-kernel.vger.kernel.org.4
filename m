Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A86C5F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCWGEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWGEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:04:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA5420D3F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 23:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679551454; x=1711087454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lTRLSEdFGde9x79abhgER+3tHOwEFQ63JzOZiJfa8H0=;
  b=WAQxg8OInrS2wbH4r6EmjxauesHC1YSLyNQ3ufeGSjWxv1nJNQVTABMu
   TNrTMlEVhQl+nMtVS2URhtvV3r7FJC2Vnvv64r91yDChTVzl2gI5al21Z
   spVgjHu/5+Gzrxv+7hCvw5xnBijbpwKon3c2369H/0fb0pVvvx/Ue3AXZ
   L1TeaezsYKRA4t3/xygcwqpXMjLx+ju7BvYwQFxOVQ0CMUFY3IbMhAtC2
   qHuvJ80XWjav7kLRftkFXVdEUEH7YVP+Fz1o2D4aWXDyltkHcv87YUdxD
   MJj+00VPCQPCeMdzm14pLAK4NhjuWds1UknDjmyPawcu/PUtuCvxVpSXw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319056595"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319056595"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="714674251"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="714674251"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2023 23:04:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfE3X-000E1o-2H;
        Thu, 23 Mar 2023 06:04:11 +0000
Date:   Thu, 23 Mar 2023 14:03:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fsfa3 17/17] loongarch64-linux-gcc: error:
 unrecognized command-line option '-fstrict-flex-arrays=3'
Message-ID: <202303231323.YNz4H0a3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fsfa3
head:   0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3
commit: 0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3 [17/17] Makefile: Enable -Wstringop-overflow and -Warray-bounds and -fstrict-flex-arrays=3
config: loongarch-randconfig-r021-20230322 (https://download.01.org/0day-ci/archive/20230323/202303231323.YNz4H0a3-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fsfa3
        git checkout 0866a2ea45cdf26bbee3f4b1bd9a840c74de54e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch prepare

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303231323.YNz4H0a3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> loongarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
   make[2]: *** [scripts/Makefile.build:252: scripts/mod/empty.o] Error 1
>> loongarch64-linux-gcc: error: unrecognized command-line option '-fstrict-flex-arrays=3'
   make[2]: *** [scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target 'scripts/mod/' not remade because of errors.
   make[1]: *** [Makefile:1288: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:226: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
