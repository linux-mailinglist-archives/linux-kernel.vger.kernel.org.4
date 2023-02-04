Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A989D68AD54
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBDXHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBDXHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:07:01 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD52202F
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675552020; x=1707088020;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V+OBaKGVX/ZxuLQl6ec+WH3yedGl8skQ6Km5EfEF44A=;
  b=hC7X7IFHkvAMDuwpEBgbBn0dS5J98WZD21iwMS8khaNMLDDe2TxdYIGg
   UrN2Fu17Yi9zSMzJ7Ex17ro1wdA3U5u1ASMiiK1QeT2Ns8cUHnDOb80v0
   JkfoR2g6JkFLn9SNSAXFf/850cYDAthSz/NQ0QQTLbTXwZ1vY23Z23Xoi
   6beB00xq6Cku83c1g2XRz+MH9OW8F0A2XdRP6LqV2YMKK8Kx37aTZUvMV
   +CYeHeHDIeJhj0VXIS0hN9BVDx6rcV07fMdN9gN7b2uSWfEwhVOARoFy9
   DS32lCHb/fZD3yUPSwfTf48WX3dlsySLcJr/RRevezN/d9+IJnlfWPd2i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="326690402"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="326690402"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 15:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="729645004"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="729645004"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2023 15:06:59 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pORcY-0001ZY-2Z;
        Sat, 04 Feb 2023 23:06:58 +0000
Date:   Sun, 5 Feb 2023 07:06:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .start VMA
 [00000000d1000000,00000000d1000007] overlaps section .image VMA
 [00000000d0003000,00000000d15af34b]
Message-ID: <202302050705.X4TzpbYB-lkp@intel.com>
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
head:   0136d86b78522bbd5755f8194c97a987f0586ba5
commit: c633544a6154146a210cf158157a1ae7c55473b6 xtensa: add support for KASAN
date:   5 years ago
config: xtensa-randconfig-r012-20230202 (https://download.01.org/0day-ci/archive/20230205/202302050705.X4TzpbYB-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c633544a6154146a210cf158157a1ae7c55473b6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c633544a6154146a210cf158157a1ae7c55473b6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .start VMA [00000000d1000000,00000000d1000007] overlaps section .image VMA [00000000d0003000,00000000d15af34b]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
