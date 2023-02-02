Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B5C6889A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjBBWWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjBBWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:21:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5579B6A327
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675376515; x=1706912515;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ih45qw3GO+A2Jg57523xVsGMRHouyCzrPpg2VyURJ3o=;
  b=U9PqLLgpixX0YyBpeZVky3S+TEhcBY4HAINTO9IhQcBKJxmAeq8DGgFX
   XY8oi0TVz/K25/LPQETQQrRj+duQiwJ0tJCg8SWIkJjc42FL9DAOmZzuJ
   ILRediJP+RT/vsssKl3z7m1ElNsRhOPPqx/Mx4cPy5DABqutbMiLWBEmT
   9iT7kXV0zdiPbGWAWMfv57SLLCAvlehcocWjKrvEscjGnk2KDl0Nc/Dj/
   UPARdByIRhPFbg/bHajr47TCe5ZYAb4qTAnpMm9P+OBEjmnX9zStCv7Sq
   R5skcSjfpVKFeIcABx0kN1oxVsYiH0AYgVCAwIKLoAhQGTi9+97oq5bvL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308927186"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="308927186"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 14:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="729048449"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="729048449"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2023 14:21:53 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNhxp-0006um-0z;
        Thu, 02 Feb 2023 22:21:53 +0000
Date:   Fri, 3 Feb 2023 06:21:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference
 to `physical_memsize'
Message-ID: <202302030625.2g3E98sY-lkp@intel.com>
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
head:   e7368fd30165ced757d64da48e2091c83815ce5c
commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
date:   9 months ago
config: mips-randconfig-r002-20230202 (https://download.01.org/0day-ci/archive/20230203/202302030625.2g3E98sY-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips-linux-ld: arch/mips/kernel/vpe-mt.o: in function `vpe_run':
>> arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x280): undefined reference to `physical_memsize'
>> mips-linux-ld: arch/mips/kernel/vpe-mt.c:(.text.vpe_run+0x284): undefined reference to `physical_memsize'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
