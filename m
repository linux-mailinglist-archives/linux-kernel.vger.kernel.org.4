Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F25674B63
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjATEx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjATExS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:53:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD35C13C7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189906; x=1705725906;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sdr2ob7kGV6zr9X4/GlfrIezQAzMTpA9m7zpDp2RQR8=;
  b=A1lfi/eh6YR0MQypE0rnbet1HGBOdlLwP8kcoWq6HYs3iIc76E7CutUD
   jbK1kDfr+y4ls2omP2EIdl/0utLmiN/Jt3c4ujaqfhFEyzvDL0xnYMSSv
   5Kn9yAPWabwyACH4wWnW4rkSki6+z7qY2wygT2HvcMUsjKG9ZFrt3tD2+
   BhTYXgkcj027Qp8UIAYvfdFqxUjTSZqbJ3HlafbXcK4RICOwmxVQjJCez
   oBqToygrbm+f07T6PdllcfA+LO5j7PyJGQb2WgLbG6PjT0E8XC/Q5+j2n
   zkzVRpMUBPDiljhbnQ82SWYZts2Y4P3zX1NE6ED5pqZPmD67LleXiDMXN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387728767"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387728767"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:44:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="834062413"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="834062413"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2023 09:44:03 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIYxH-0001gw-0J;
        Thu, 19 Jan 2023 17:44:03 +0000
Date:   Fri, 20 Jan 2023 01:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: arch/arm64/kernel/alternative.c:267:14: warning: no previous
 prototype for 'alt_cb_patch_nops'
Message-ID: <202301200104.yU4JQ35I-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7287904c8771b77b9504f53623bb477065c19a58
commit: d926079f17bf8aa47485b6a55be1fc0175dbd1db arm64: alternatives: add shared NOP callback
date:   4 months ago
config: arm64-buildonly-randconfig-r001-20230119 (https://download.01.org/0day-ci/archive/20230120/202301200104.yU4JQ35I-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d926079f17bf8aa47485b6a55be1fc0175dbd1db
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d926079f17bf8aa47485b6a55be1fc0175dbd1db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:267:14: warning: no previous prototype for 'alt_cb_patch_nops' [-Wmissing-prototypes]
     267 | noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
         |              ^~~~~~~~~~~~~~~~~


vim +/alt_cb_patch_nops +267 arch/arm64/kernel/alternative.c

   266	
 > 267	noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
