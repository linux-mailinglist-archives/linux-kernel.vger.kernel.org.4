Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F06E6A2B75
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBYTOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:14:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF1122
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677352483; x=1708888483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0KoMKXjQUApcRlDXH4w7hCtoT6tBYjfCi+UzayKz7cM=;
  b=kQyIYGIk0QcMvm9f/PiUdlTPn4SK020wwlBW4XFSZdrHLRKP2WNCj9Ml
   0Zw5KjU/dJHR3Hxq3aNbEEHhOOxz9xcOpeaxwcXQWmF6BXMAPXvWr3XZj
   ZyKueABbA9e1IMZ3AR1FVOJauzkPkwx1RzNn/HL4EOuQ54vOofxkyNvry
   Up7GkRi6D0A8JEhFhnKwMd0ZcDShXedNQL7ORQr8zuljBzhoeQI/wlDHw
   0wqNo6/aLDy88iDwt/8VCewMF13BSH+xEg6GmIpqgkNsONRIy0UW13F6R
   l7ISniRYsDTV9VWGMwjYtO31yCU7Mjk0+bHfAA4sK8f6l9LmDxImvcRTW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="332380335"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="332380335"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 11:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="705644472"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="705644472"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2023 11:14:41 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pW00H-0003Nn-0U;
        Sat, 25 Feb 2023 19:14:41 +0000
Date:   Sun, 26 Feb 2023 03:14:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Raviteja Narayanam <raviteja.narayanam@xilinx.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: drivers/i2c/busses/i2c-xiic.c:994:39: warning: 'xiic_2_00' defined
 but not used
Message-ID: <202302260317.PpagiXGe-lkp@intel.com>
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
head:   7c3dc440b1f5c75f45e24430f913e561dc82a419
commit: 2fd5cf352efa0c62dd20d1e046bc8767395b1ec0 i2c: xiic: Switch to Xiic standard mode for i2c-read
date:   3 weeks ago
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20230226/202302260317.PpagiXGe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fd5cf352efa0c62dd20d1e046bc8767395b1ec0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2fd5cf352efa0c62dd20d1e046bc8767395b1ec0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/i2c/busses/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302260317.PpagiXGe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-xiic.c:994:39: warning: 'xiic_2_00' defined but not used [-Wunused-const-variable=]
     994 | static const struct xiic_version_data xiic_2_00 = {
         |                                       ^~~~~~~~~


vim +/xiic_2_00 +994 drivers/i2c/busses/i2c-xiic.c

   993	
 > 994	static const struct xiic_version_data xiic_2_00 = {
   995		.quirks = DYNAMIC_MODE_READ_BROKEN_BIT,
   996	};
   997	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
