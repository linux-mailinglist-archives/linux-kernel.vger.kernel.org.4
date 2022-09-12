Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEE95B6253
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiILUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiILUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:46:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563843600
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663015592; x=1694551592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AGveGrCcNjwWFCrKWvHPZVGkCURUq/87uGVEcTKbU8s=;
  b=A7ZyYrLbj0O0Bh+sLJZwDz8uorO8ZeTRmnvGqhjHONQWC6Cw45vLFHxR
   40/rdp4yrtw7G96gehhLvYptdfe7AlSgCxkr7ca89Y2SUm9fLwpfJQsuj
   n3fzTXjaoGMhPDKGrVb5pbUipRtXNXw9uTDFqtMituRmAqDhDFGZnJWgd
   1njiuq/kwIlH8U9+9QOpFY/YHQmOzsBv0e+GeuRoFuM1fumejnXjg/cnE
   yvfHn+t6SEYq88wylj6gkh+9OVp5ROCkPeNPoYdVRGBAn+5yxCTJCNZgb
   M7nlvmAi0XZJvDpVa4ZB2Etnmo00lF6dnuHE/yCZ3YcBnsjrBvVJEMHuW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324204725"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324204725"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 13:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="567313760"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 13:46:30 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXqK5-0002qp-26;
        Mon, 12 Sep 2022 20:46:29 +0000
Date:   Tue, 13 Sep 2022 04:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>
Subject: drivers/ufs/host/ufs-hisi.c:561:34: warning: 'ufs_hisi_of_match'
 defined but not used
Message-ID: <202209130456.nAXZs5PG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80e78fcce86de0288793a0ef0f6acf37656ee4cf
commit: dd11376b9f1b73aca3f8c6eb541486bbb6996f05 scsi: ufs: Split the drivers/scsi/ufs directory
date:   4 months ago
config: x86_64-buildonly-randconfig-r004-20220912 (https://download.01.org/0day-ci/archive/20220913/202209130456.nAXZs5PG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/base/power/ drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

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
https://01.org/lkp
