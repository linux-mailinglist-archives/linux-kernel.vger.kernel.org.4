Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2702677246
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjAVUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjAVUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:19:42 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483D15574
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674418781; x=1705954781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aVN4WAdVuORrLYzOOlNRUjKcILqDXNLlLBns0F6GjBU=;
  b=RVYnui5kuMylQNqGNyqvwpTyLAEC3lBnzVp2wHPtjQvz/TQ4xRIhy3dk
   SBs7/lRk/0w0FH+qNatRLbJaioRCC0+U7B2itjpWH3z6iNn/9k3cVu62e
   a4sGKRBOjGM3ucgFmhtDZ1dMk3j62bdgHeG6TKHbQzCudpedARYjp6+9j
   JfVy6olMkodYxRW22mDZHqnBjIWJnlsWTYhhRfl9qp95QtST2QggpsDhd
   6ApPHXHT0BNugjptVJhhsJ8ILj7atubcF1ciqm3vvXMtSXDgfFUezoOyO
   qq6mdjD5oOg0WfxUFVdh83Xy4cGNtgSnV7pQVgLuVAGXHaI1ydb0kqNjJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="313831108"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="313831108"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2023 12:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="729953753"
X-IronPort-AV: E=Sophos;i="5.97,237,1669104000"; 
   d="scan'208";a="729953753"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jan 2023 12:19:38 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJgoT-0005E8-37;
        Sun, 22 Jan 2023 20:19:37 +0000
Date:   Mon, 23 Jan 2023 04:19:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>
Subject: drivers/ufs/host/ufs-hisi.c:561:34: warning: 'ufs_hisi_of_match'
 defined but not used
Message-ID: <202301230411.IWKP8ESQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
commit: dd11376b9f1b73aca3f8c6eb541486bbb6996f05 scsi: ufs: Split the drivers/scsi/ufs directory
date:   8 months ago
config: x86_64-buildonly-randconfig-r002-20230123 (https://download.01.org/0day-ci/archive/20230123/202301230411.IWKP8ESQ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/ufs-hisi.c:561:34: warning: 'ufs_hisi_of_match' defined but not used [-Wunused-const-variable=]
     561 | static const struct of_device_id ufs_hisi_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~


vim +/ufs_hisi_of_match +561 drivers/ufs/host/ufs-hisi.c

653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  560  
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05 @561  static const struct of_device_id ufs_hisi_of_match[] = {
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  562  	{ .compatible = "hisilicon,hi3660-ufs", .data = &ufs_hba_hi3660_vops },
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  563  	{ .compatible = "hisilicon,hi3670-ufs", .data = &ufs_hba_hi3670_vops },
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  564  	{},
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  565  };
653fcb07d95eda drivers/scsi/ufs/ufs-hisi.c Manivannan Sadhasivam 2019-01-05  566  

:::::: The code at line 561 was first introduced by commit
:::::: 653fcb07d95eda58b72a5e715230b582c4d6d69e scsi: ufs: Add HI3670 SoC UFS driver support

:::::: TO: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
