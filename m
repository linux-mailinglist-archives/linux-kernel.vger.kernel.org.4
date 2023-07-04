Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACB746A5B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGDHNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGDHNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:13:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB01133
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688454829; x=1719990829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=siXw7Hgvg0qvEBA2mPmaJ8uv1VSpnqahj1u53oKb7/s=;
  b=X+2fwQXpm9G18a95BqYQ88emezuIFoI60Kx/rgCiW4G3Nu9JU1VEqOFD
   CK7vG6qcqr59DBXTYqYHfmNBiGaoiPNnmLB+sZPdlvXoLreVEwstmU7dg
   n2nAbHSkLnynm3QN758TSbExfZRtRgovy7tz7K1dxPIrFiQaji+ZebWkv
   L3APVMIdg0Omk7edRKrMmMi5Q4utLpFQZJt1WOshiJGQQ9eg4WRFg5FHl
   m3KYY3YndcsxjQUTn/twWtVccAK8yluRDpsMg5nqQpT/A5NrQqauUnlWm
   mFyjGoqemnW9Xgul1YiuCkAf1q2bYEplOW95jiANO14tPkOB0NDI1Ktuj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="343390779"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="343390779"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 00:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="788772161"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="788772161"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jul 2023 00:13:41 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGaEG-000I45-2L;
        Tue, 04 Jul 2023 07:13:40 +0000
Date:   Tue, 4 Jul 2023 15:13:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: drivers/hid/hid-nvidia-shield.c:59:2: warning: field  within 'struct
 thunderstrike_hostcmd_resp_report' is less aligned than 'union
 thunderstrike_hostcmd_resp_report::(anonymous at
 drivers/hid/hid-nvidia-shield.c:59:2)' and is usually due to 'struct
 thund...
Message-ID: <202307041500.6bKn7nCl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   24be4d0b46bb0c3c1dc7bacd30957d6144a70dfc
commit: 09308562d4afb1abc66366608fa1cb9de783272f HID: nvidia-shield: Initial driver implementation with Thunderstrike support
date:   4 weeks ago
config: arm-randconfig-r014-20230704 (https://download.01.org/0day-ci/archive/20230704/202307041500.6bKn7nCl-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230704/202307041500.6bKn7nCl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307041500.6bKn7nCl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-nvidia-shield.c:59:2: warning: field  within 'struct thunderstrike_hostcmd_resp_report' is less aligned than 'union thunderstrike_hostcmd_resp_report::(anonymous at drivers/hid/hid-nvidia-shield.c:59:2)' and is usually due to 'struct thunderstrike_hostcmd_resp_report' being packed, which can lead to unaligned accesses [-Wunaligned-access]
           union {
           ^
   1 warning generated.


vim +59 drivers/hid/hid-nvidia-shield.c

    53	
    54	struct thunderstrike_hostcmd_resp_report {
    55		u8 report_id; /* THUNDERSTRIKE_HOSTCMD_RESP_REPORT_ID */
    56		u8 cmd_id;
    57		u8 reserved_at_10;
    58	
  > 59		union {
    60			struct thunderstrike_hostcmd_board_info board_info;
    61			struct thunderstrike_hostcmd_haptics motors;
    62			__le16 fw_version;
    63			u8 payload[30];
    64		};
    65	} __packed;
    66	static_assert(sizeof(struct thunderstrike_hostcmd_resp_report) ==
    67		      THUNDERSTRIKE_HOSTCMD_REPORT_SIZE);
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
