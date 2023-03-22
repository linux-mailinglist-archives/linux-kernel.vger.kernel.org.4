Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A000E6C43DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCVHMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:12:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3355B42D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679469147; x=1711005147;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D310QX447aQ+jVJUFYYiERsxACscwqO2os6J8AHbN8E=;
  b=hqXu+FIhdPZM2U3QsgmvxdTdZmxN6O3gDd2vtY8TDS86xvFOvqeGkGKQ
   fEZ01VX84C761fDHOqOywhUlcRhKq3ztQkMs5w4P55mSyx1WisqzVg1Gj
   h7SwsfDLXrqNj54Rq1fn/UICl5xsseOhGvWDSHHCs9oxPggbtYzTndydt
   TTHvtWQrZi0SZTlEEcXy5mpLDY8T6lcpmCKq0R+/7GfrmslbJMmrPaTIQ
   5Of37jmpBGMXtNUAKja64OiNNWSAOW6sdPSqHVdoK1KT3wZmQCgcFp9Fs
   z24vvwGvbkv3yoktgLxuYOetnwmHFEY6y8zfUGWn4iyZ087uw20HAgDrn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="404028418"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="404028418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 00:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="825278621"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="825278621"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2023 00:12:25 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pese0-000D1g-1v;
        Wed, 22 Mar 2023 07:12:24 +0000
Date:   Wed, 22 Mar 2023 15:11:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/sfc/falcon/selftest.c:43:15: warning: field ip
 within 'struct ef4_loopback_payload' is less aligned than 'struct iphdr' and
 is usually due to 'struct ef4_loopback_payload' being packed, which can lead
 to unaligned accesses
Message-ID: <202303221557.Yc4KdwGu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a1effab7a3a35a837dd9d2b974a1bc4939df1ad5
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   11 months ago
config: arm-randconfig-r023-20230322 (https://download.01.org/0day-ci/archive/20230322/202303221557.Yc4KdwGu-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=250c1a694ff304e5d69e74ab32755eddcc2b8f65
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 250c1a694ff304e5d69e74ab32755eddcc2b8f65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/net/ethernet/sfc/falcon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303221557.Yc4KdwGu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/falcon/selftest.c:43:15: warning: field ip within 'struct ef4_loopback_payload' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           struct iphdr ip;
                        ^
   1 warning generated.


vim +43 drivers/net/ethernet/sfc/falcon/selftest.c

5a6681e22c1409 Edward Cree 2016-11-28  34  
5a6681e22c1409 Edward Cree 2016-11-28  35  /*
5a6681e22c1409 Edward Cree 2016-11-28  36   * Loopback test packet structure
5a6681e22c1409 Edward Cree 2016-11-28  37   *
5a6681e22c1409 Edward Cree 2016-11-28  38   * The self-test should stress every RSS vector, and unfortunately
5a6681e22c1409 Edward Cree 2016-11-28  39   * Falcon only performs RSS on TCP/UDP packets.
5a6681e22c1409 Edward Cree 2016-11-28  40   */
5a6681e22c1409 Edward Cree 2016-11-28  41  struct ef4_loopback_payload {
5a6681e22c1409 Edward Cree 2016-11-28  42  	struct ethhdr header;
5a6681e22c1409 Edward Cree 2016-11-28 @43  	struct iphdr ip;
5a6681e22c1409 Edward Cree 2016-11-28  44  	struct udphdr udp;
5a6681e22c1409 Edward Cree 2016-11-28  45  	__be16 iteration;
5a6681e22c1409 Edward Cree 2016-11-28  46  	char msg[64];
5a6681e22c1409 Edward Cree 2016-11-28  47  } __packed;
5a6681e22c1409 Edward Cree 2016-11-28  48  

:::::: The code at line 43 was first introduced by commit
:::::: 5a6681e22c1409089132085811857d6da828761b sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver

:::::: TO: Edward Cree <ecree@solarflare.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
