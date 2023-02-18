Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A769BB16
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBRQ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBRQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:56:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D261716AEB
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 08:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676739370; x=1708275370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FvA7VD4iaiyS1a0+6vSs+Hjg8D6lMuVmS9eO0mywOXA=;
  b=E4urgTjcdgt2JDTRdDPFggj5tXVdHWJHkGD42hYJUADRQk4SQ11R0PZq
   hCOsLyIiS4PlRg38JMTYicql+0zYoL/3lB5qQVo5PHgceQ/PjOA605Cv2
   iIw7dBklQ7hihBDk2/YKozSBDrhQteuRmJRrKZBb1OzpNTt0GfLM8TOKk
   n2Mf8k/9s5L0THZ+1ZIHAZ/iyyl/DOAP2sgUKQDSTrh6OWoHQczM+5qFs
   OrCsaN+h6L6BUONvluJcIr6iEYVPXZ8J5XSqWymz+tyu64q2PF2vwIlzx
   SRSxRMdReL8uHnG1WHIJECmS2lgzWS3bozRAHR4Z1936INZDNuok9UGF6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="394668262"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="394668262"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 08:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="703281521"
X-IronPort-AV: E=Sophos;i="5.97,307,1669104000"; 
   d="scan'208";a="703281521"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2023 08:56:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pTQVL-000Ca1-0B;
        Sat, 18 Feb 2023 16:56:07 +0000
Date:   Sun, 19 Feb 2023 00:55:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Filipe Manana <fdmanana@suse.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: ld.lld: error: assignment to symbol __init_end does not converge
Message-ID: <202302190027.v88X1oBI-lkp@intel.com>
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
head:   38f8ccde04a3fa317b51b05e63c3cb57e1641931
commit: b7af0635c87ff78d6bd523298ab7471f9ffd3ce5 btrfs: print transaction aborted messages with an error level
date:   3 months ago
config: arm64-buildonly-randconfig-r002-20230217 (https://download.01.org/0day-ci/archive/20230219/202302190027.v88X1oBI-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b7af0635c87ff78d6bd523298ab7471f9ffd3ce5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b7af0635c87ff78d6bd523298ab7471f9ffd3ce5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302190027.v88X1oBI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: assignment to symbol __init_end does not converge

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for VIDEO_MEDIATEK_VPU
   Depends on [n]: MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_MEM2MEM_DRIVERS [=n] && VIDEO_DEV [=y] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y])
   Selected by [y]:
   - VIDEO_MEDIATEK_MDP3 [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && (MTK_IOMMU [=y] || COMPILE_TEST [=y]) && VIDEO_DEV [=y] && (ARCH_MEDIATEK [=n] || COMPILE_TEST [=y]) && HAS_DMA [=y] && REMOTEPROC [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
