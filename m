Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827C70145F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 06:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEMEiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 00:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjEMEiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 00:38:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3932B40DC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683952687; x=1715488687;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pvHRQZVyOX3HZKiCmVdHbIXAm0jC3Adto9G2qKc1o5U=;
  b=RyVcIT4lpnwqZejdZK71KKhQ9Iohlr8Wa6PlnAKGEZlDIKnEPOB6htee
   WFFf0ZGOCskLUZiRTI6iGErl3KdH2uopp9XtRUq58YN7SnTo9lgTtYTVa
   tiIv7VwMsB9aaSZ+dupJm7fyoioScs8CPfVZ27fhlJl0O9anygs3jCpaH
   OWcum3g70aoSW84dsdGwl+MYwVeYkOcfw5BG+KOUC2vUZl92o0ZT+jP4d
   cKmSozg2sjevHkjk0azBzki83n6Cr4Z67bLqQGWnU7Xtdli07/tsat/Zh
   MXwUMVIqLG9wGKrkPoDagaxLI2LacJdisvP7V1Yfl5jK1H5g69XPHDBLC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="330542634"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="330542634"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 21:38:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="733270094"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="733270094"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2023 21:38:04 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxh19-0005K8-1h;
        Sat, 13 May 2023 04:38:03 +0000
Date:   Sat, 13 May 2023 12:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202305131223.Bdo5IFiE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a48d604672220545d209e9996c2a1edbb5637f6
commit: 437b6b35362b206fdf881fe6dea76720eedb6d25 parisc: Use the generic IO helpers
date:   8 months ago
config: parisc-randconfig-s041-20230513 (https://download.01.org/0day-ci/archive/20230513/202305131223.Bdo5IFiE-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=437b6b35362b206fdf881fe6dea76720eedb6d25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 437b6b35362b206fdf881fe6dea76720eedb6d25
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/infiniband/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305131223.Bdo5IFiE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c: note: in included file:
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
--
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c: note: in included file:
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]

vim +301 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h

29c8d9eba550c6 Adit Ranadive 2016-10-02  298  
29c8d9eba550c6 Adit Ranadive 2016-10-02  299  static inline void pvrdma_write_reg(struct pvrdma_dev *dev, u32 reg, u32 val)
29c8d9eba550c6 Adit Ranadive 2016-10-02  300  {
29c8d9eba550c6 Adit Ranadive 2016-10-02 @301  	writel(cpu_to_le32(val), dev->regs + reg);
29c8d9eba550c6 Adit Ranadive 2016-10-02  302  }
29c8d9eba550c6 Adit Ranadive 2016-10-02  303  

:::::: The code at line 301 was first introduced by commit
:::::: 29c8d9eba550c6d73d17cc1618a9f5f2a7345aa1 IB: Add vmw_pvrdma driver

:::::: TO: Adit Ranadive <aditr@vmware.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
