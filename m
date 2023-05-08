Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3BD6FB310
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjEHOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjEHOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:37:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BB52D62
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683556656; x=1715092656;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6lsvlo5SdkqZICtvxPrgpkmQjrtlLkqifSzvhcOKSD4=;
  b=C6hZ94rsU6bEbvFfh8vOyG0ek3a/Ii5VC5ILUvXzzI0BLb72h48V7cWc
   hJP/qsp2ih2AolI5nV6mJJeJFWpa2S7yAn7bNe4K5dulv3Zux7x2a9Rhc
   a3KwMqj9o6zd313EmchlRR8cLDfKs90pDZQ+px5rE0UVI60AG4t/VAhVz
   EHp6osBzaRgJlhHY3r6XLfr3oMln/PRue5LsZjf+ltP5SvHK1o4ZWK7o9
   UgjmlADdzLv7N10pSJcOsZEahvYIJC1DSIb4PxmxC1ckIoXg9+1mtGbfN
   6I41EC47pEEa34Mqys63G14Vg/10KpR+QMoeabS9gHZLnbR27/7lDOBF3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="330024564"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="330024564"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 07:37:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="872826323"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="872826323"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 May 2023 07:37:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pw1za-0001Gj-03;
        Mon, 08 May 2023 14:37:34 +0000
Date:   Mon, 8 May 2023 22:37:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mustapha Ghaddar <mghaddar@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Kshitij Bhardwaj <kshitij.bhardwaj1@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_validation.c:351:13:
 warning: variable 'bw_needed' set but not used
Message-ID: <202305082222.xwzCCjfA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac9a78681b921877518763ba0e89202254349d1b
commit: a8b537605e22bfe277e666727fa0e9e01f2c729b drm/amd/display: Add function pointer for validate bw usb4
date:   7 weeks ago
config: s390-randconfig-r033-20230507 (https://download.01.org/0day-ci/archive/20230508/202305082222.xwzCCjfA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8b537605e22bfe277e666727fa0e9e01f2c729b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a8b537605e22bfe277e666727fa0e9e01f2c729b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305082222.xwzCCjfA-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   s390-linux-ld: arch/s390/purgatory/purgatory: in function `sha256_update':
>> (.text+0x248c): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x24a4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x24bc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29b4): undefined reference to `ftrace_likely_update'
   s390-linux-ld: (.text+0x29cc): undefined reference to `ftrace_likely_update'
   s390-linux-ld: arch/s390/purgatory/purgatory:(.text+0x29e4): more undefined references to `ftrace_likely_update' follow
--
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
