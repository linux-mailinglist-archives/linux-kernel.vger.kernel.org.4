Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46565BF9A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiIUIqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiIUIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:46:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A398A1C9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663749976; x=1695285976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OtvwF4Pfps/Yz2EfcPEjnzA4EIdvExd24ETOq4zZfF0=;
  b=gt+v6gy1JjZVsWtacI3W77dSnFvluawGRSiUSa2KztFFJvLIvBsuZ1mE
   6rlMDFfIDBWhHSW40gM75CsW2l5M/zlDewfg4RL3bCR5oDqGlMXTNDRUB
   YhPb8EyN8G3RKHkyV7bkVRmju7UAseDf+3ReGWGCQh9uQTMWMSGLlbP+m
   vkutNMr+8K7PC8qyr7WuuOmE7pH2/CJZ3oUA45JekNejGlmHegR8fsxQy
   NPT7oelX9w5Cip7BtbWKZLSu3xrb4LGX8Utg8n4SyS1dPOE8fIL2aThWB
   5R2df54ow5Rp6CKDm+oCb3UZICxlLcE2RF1Ntd/PtoqH8icXD90TNiS6U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299930174"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="299930174"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 01:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="614725023"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Sep 2022 01:46:12 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oavMy-0003Qh-14;
        Wed, 21 Sep 2022 08:46:12 +0000
Date:   Wed, 21 Sep 2022 16:45:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [intel-tdx:guest-attest-wip 2/3]
 drivers/virt/coco/tdx-guest/tdx-guest.c:129:32: warning: 'tdx_guest_ids'
 defined but not used
Message-ID: <202209211607.tCtTWKbV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest-wip
head:   33cc9e3b6141b4339bceb2591c188d866c7a9052
commit: 3a38d73702055606f2b0a1ea0610767e7142e0cb [2/3] virt: Add TDX guest driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220921/202209211607.tCtTWKbV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/3a38d73702055606f2b0a1ea0610767e7142e0cb
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest-wip
        git checkout 3a38d73702055606f2b0a1ea0610767e7142e0cb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/virt/coco/tdx-guest/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/virt/coco/tdx-guest/tdx-guest.c:129:32: warning: 'tdx_guest_ids' defined but not used [-Wunused-const-variable=]
     129 | static const struct x86_cpu_id tdx_guest_ids[] = {
         |                                ^~~~~~~~~~~~~


vim +/tdx_guest_ids +129 drivers/virt/coco/tdx-guest/tdx-guest.c

   128	
 > 129	static const struct x86_cpu_id tdx_guest_ids[] = {
   130		X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
   131		{}
   132	};
   133	MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
   134	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
