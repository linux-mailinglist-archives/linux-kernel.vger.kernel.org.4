Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BA691D78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjBJLBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjBJLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:01:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FD5ACC6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676026895; x=1707562895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+Kq6GmTwq50W7xjxGNwYvGxr6JO92IjRDTIAy0kK3dI=;
  b=GwE6DpOgt+MbhCQ8g7NyjcH/y+SMYjEo5lR5KJwy87NVqSN7utOIfS0g
   1A2Gzv3dOIKVYcm9UZWY+i5tb0hIIzEfKlEUsm/RU3dw3kwd2iF11Gusk
   Z2ypXAX+iJAzocFPTzFl/CSnf4hfKlavNKLjGwlD7yH4ee/YbTvlaCKhn
   LQ4+Ae/Dqs/NbxsIaMRImMO3KTlPrN+dlwstTi+gQ+q+Q8Hzczi5jPVii
   8dAlc0TavtCB9rofZ/+MfdG4my5iU2ne6yKWWs66he7qewJflaVqkC0/o
   YwWsjLU/mqsUvOiMQZ3UoBgvIKfSoBZYYSCeC7p9tb9cLTWfgEt9elpEJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329021973"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329021973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 03:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="731685897"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="731685897"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2023 03:01:34 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQR9p-0005ld-1l;
        Fri, 10 Feb 2023 11:01:33 +0000
Date:   Fri, 10 Feb 2023 19:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202302101854.YYJBwUh5-lkp@intel.com>
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
head:   38c1e0c65865426676123cc9a127526fa02bcac6
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   6 months ago
config: loongarch-randconfig-s052-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101854.YYJBwUh5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/infiniband/hw/vmw_pvrdma/ net/core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101854.YYJBwUh5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_cmd.c: note: in included file:
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:301:16: sparse:     got restricted __le32 [usertype]
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:306:16: sparse: sparse: cast to restricted __le32
--
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c: note: in included file:
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
