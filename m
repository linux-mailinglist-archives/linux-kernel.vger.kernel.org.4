Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE95BB67E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 07:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIQFSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 01:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIQFSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 01:18:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2BC5C362
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 22:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663391927; x=1694927927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=utr81I6cj4zi8yh6K2Vp9lctzjOff2Pad1srisT7Mnw=;
  b=m5v4DDW71kIw9J9jOTbMu5t6RKPsCIP4BlWwjrhoRw8emz651NO8BMMS
   +HTEPbJrTimyp9oiVbgmddU48rki8tpUKN3Tgq1eW3ojQHLoaA4FMqmUz
   b3CVfMQxV8k1twQCz3SVghML12e+2BA+G9I8ELFD+0dE04qZowLpYiX1k
   BHHCiFhZawrCdOUV8ABtCR61M8Dc2zF6Q01Bb9QhdFCjEkaGvVR2ooNDQ
   xL3EIXz4RAXn6q6nam5x1vwi1U2HkS4I5pGBjEmQkvjJA2aTMON1aqhlj
   cOSjFC72m0uURg0JM054TUHhiz9BzP92FR3Gn/1/9KmVhufgn52DUqQ3a
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286167586"
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="286167586"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 22:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,322,1654585200"; 
   d="scan'208";a="648503583"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2022 22:18:45 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZQE0-00001j-2H;
        Sat, 17 Sep 2022 05:18:44 +0000
Date:   Sat, 17 Sep 2022 13:17:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/smbios 2/3]
 drivers/firmware/dmi_scan.c:806:34: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202209172114.34KPDrxX-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/smbios
head:   1f282c3a5674aced9c26d319587135cd0f40ad38
commit: 00ee8ad7ad1c02fa8280c0e609b000fad782f348 [2/3] firmware: dmi: only add dmi buffer to rng once
config: ia64-randconfig-s032-20220916 (https://download.01.org/0day-ci/archive/20220917/202209172114.34KPDrxX-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/00ee8ad7ad1c02fa8280c0e609b000fad782f348
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/smbios
        git checkout 00ee8ad7ad1c02fa8280c0e609b000fad782f348
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/firmware/dmi_scan.c:143:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:143:13: sparse:     expected unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:143:13: sparse:     got void [noderef] __iomem *
   drivers/firmware/dmi_scan.c:149:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
   drivers/firmware/dmi_scan.c:149:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:149:9: sparse:     got unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:774:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dmi_table @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:774:19: sparse:     expected unsigned char [usertype] *dmi_table
   drivers/firmware/dmi_scan.c:774:19: sparse:     got void [noderef] __iomem *
   drivers/firmware/dmi_scan.c:793:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *dmi_table @@
   drivers/firmware/dmi_scan.c:793:19: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:793:19: sparse:     got unsigned char [usertype] *dmi_table
>> drivers/firmware/dmi_scan.c:806:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:806:34: sparse:     expected unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:806:34: sparse:     got void [noderef] __iomem *
   drivers/firmware/dmi_scan.c:811:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
   drivers/firmware/dmi_scan.c:811:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:811:9: sparse:     got unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:1118:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *buf @@     got void [noderef] __iomem * @@
   drivers/firmware/dmi_scan.c:1118:13: sparse:     expected unsigned char [usertype] *buf
   drivers/firmware/dmi_scan.c:1118:13: sparse:     got void [noderef] __iomem *
   drivers/firmware/dmi_scan.c:1124:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *buf @@
   drivers/firmware/dmi_scan.c:1124:19: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/firmware/dmi_scan.c:1124:19: sparse:     got unsigned char [usertype] *buf

vim +806 drivers/firmware/dmi_scan.c

   803	
   804	static void __init dmi_random_walk(void)
   805	{
 > 806		u8 *buf = dmi_early_remap(dmi_base, dmi_len);
   807		if (buf == NULL)
   808			return;
   809	
   810		add_device_randomness(buf, dmi_len);
   811		dmi_early_unmap(buf, dmi_len);
   812	}
   813	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
