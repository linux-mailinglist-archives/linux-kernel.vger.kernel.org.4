Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911B76F0EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbjD0XEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjD0XEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:04:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8082711
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682636690; x=1714172690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TRe0GTx2G1cIsMBbn6q4T6/rYfOWxDvebgw9LUumrZ8=;
  b=MalD/RiojpXOnWJM/7RGJUwcguEoH6CFWc/7tU2Leo2E0vZ/GzwsgL87
   81BqnZFPGEN+JDMKZCVVwap+J+lWu3LYDMpoB+dcocJxbnD5wMMJm/lxJ
   ifW8RQlqKA5wdEKrF1lM8lv5/1IQRec4xjn1G3SKEqIlE54mSFmI6WSzP
   OUaS25Mbl8G8qBQUgkedGclEZGFiRREd5zFCNlOnBWTSHdgezaRAXo2d/
   OTkcXqyPgAyseaOA08xHLu96FJVmqULLa8Zedf/ZkiSC1RVUjDjucZSlU
   lE4oRUMwhtVl91JNrterQZLc47txgf1rqcOh95QXTnHwgzqGY54xf8a/S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331877530"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="331877530"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 16:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="764029584"
X-IronPort-AV: E=Sophos;i="5.99,232,1677571200"; 
   d="scan'208";a="764029584"
Received: from lkp-server01.sh.intel.com (HELO b95e16499b55) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2023 16:03:29 -0700
Received: from kbuild by b95e16499b55 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psAe8-0000BT-2C;
        Thu, 27 Apr 2023 23:03:28 +0000
Date:   Fri, 28 Apr 2023 07:02:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mustapha Ghaddar <mghaddar@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Kshitij Bhardwaj <kshitij.bhardwaj1@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13:
 warning: variable 'bw_needed' set but not used
Message-ID: <202304280633.PIOK67I0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mustapha,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cec24b8b6bb841a19b5c5555b600a511a8988100
commit: a8b537605e22bfe277e666727fa0e9e01f2c729b drm/amd/display: Add function pointer for validate bw usb4
date:   5 weeks ago
config: alpha-randconfig-r032-20230427 (https://download.01.org/0day-ci/archive/20230428/202304280633.PIOK67I0-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8b537605e22bfe277e666727fa0e9e01f2c729b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a8b537605e22bfe277e666727fa0e9e01f2c729b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304280633.PIOK67I0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c: In function 'link_validate_dpia_bandwidth':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:352:25: warning: variable 'link' set but not used [-Wunused-but-set-variable]
     352 |         struct dc_link *link[MAX_DPIA_NUM];
         |                         ^~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13: warning: variable 'bw_needed' set but not used [-Wunused-but-set-variable]
     351 |         int bw_needed[MAX_DPIA_NUM];
         |             ^~~~~~~~~


vim +/bw_needed +351 drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c

   347	
   348	bool link_validate_dpia_bandwidth(const struct dc_stream_state *stream, const unsigned int num_streams)
   349	{
   350		bool ret = true;
 > 351		int bw_needed[MAX_DPIA_NUM];
 > 352		struct dc_link *link[MAX_DPIA_NUM];

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
