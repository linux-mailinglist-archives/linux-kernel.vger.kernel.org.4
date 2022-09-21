Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB685BF4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiIUDuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiIUDuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:50:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E3DFE9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663732199; x=1695268199;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z8Ij2dSVCuoeRo80Q37dLQ7slL2CfxnoatINDSHMPAg=;
  b=gKnUwA6NtnnrQmGfnu1A1JX3KMIJBGGEV0VH+B5stphFxr/Mv/uqslRz
   d3qAMV/2Hxfxqr1gk4EJ/ihA8Qi+CdrpMUAW039N+0czuyYmX3osO3bGb
   Eu0N41NGD1MWf23linpndzHsRF4IRG9zrXEvr5UAQUrHHlVnxccorVMn8
   nuGqhHFj83+q0lCosDmNyhQYfk/5RAXs6b5VqEY8aNpEiU2sKHK4TK7NI
   pLTw+cE8CALxOTQD1znnDtsxWBiWf5QFGjGLtkjtRnnZuO7dic0tmwmvP
   lf2WYBdI1wpWKPwVKodNWVVjcRLhhkVs2O+AYR81ry5iZ5nBQhHjDuJth
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="300724928"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="300724928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 20:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="570364324"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2022 20:49:56 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oaqkG-0003CX-0Z;
        Wed, 21 Sep 2022 03:49:56 +0000
Date:   Wed, 21 Sep 2022 11:49:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [tnguy-next-queue:dev-queue 29/32] ice_main.c:undefined reference to
 `ice_gnss_exit'
Message-ID: <202209211139.VPM7En0j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   da202a07465edd94595fc22d9e003b1372b35750
commit: ebfc6a046e7e538beede957403693d49dcbf569d [29/32] ice: use GNSS subsystem instead of TTY
config: csky-buildonly-randconfig-r002-20220921 (https://download.01.org/0day-ci/archive/20220921/202209211139.VPM7En0j-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=ebfc6a046e7e538beede957403693d49dcbf569d
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout ebfc6a046e7e538beede957403693d49dcbf569d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
>> ice_main.c:(.text+0x519c): undefined reference to `ice_gnss_exit'
>> csky-linux-ld: ice_main.c:(.text+0x5210): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
>> ice_main.c:(.text+0x581a): undefined reference to `ice_gnss_init'
>> csky-linux-ld: ice_main.c:(.text+0x5928): undefined reference to `ice_gnss_init'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_remove':
   ice_main.c:(.text+0x9bf8): undefined reference to `ice_gnss_exit'
   csky-linux-ld: ice_main.c:(.text+0x9ca0): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_probe':
   ice_main.c:(.text+0xb596): undefined reference to `ice_gnss_init'
   csky-linux-ld: ice_main.c:(.text+0xb780): undefined reference to `ice_gnss_init'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_lib.o: in function `ice_init_feature_support':
>> (.text+0x4d20): undefined reference to `ice_gnss_is_gps_present'
>> csky-linux-ld: (.text+0x4d64): undefined reference to `ice_gnss_is_gps_present'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
