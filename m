Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3445B7D74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIMXWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIMXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:21:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337E71706
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663111318; x=1694647318;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RLFd5oUiPLNg8zPOfeOKaddBoSCIktSPR7btSTiM24I=;
  b=ZABykvAT5N8K+aPnaYmYX9Ii3KCaxa7TWX1NHymowNNR4EvDKT85a5ZF
   cgGljOs5IRSrXCHnwWYDoWkGEfZDiX3I+GR5HF9/nZbVGp3lK6ZnZmwO6
   ybqLokvydH4zRbTIM1znARyGWiAB5oQNth9WsuekT+F7buAwnf87BPj2l
   apAhAtEL2YhxJZO8thrrYtTn6JiqjIs1q9z77mfH0eJCg/vl4mZAvIWkt
   m2G2NpMsoQgPkgRzd6ZcADwZbg8583rtyMQYs9ciXLt/l1OoJUV/SUzhF
   oKONVnjNVZBJgyjPQLRJldM80fw05WKrnhYokyeGgdud/oCBn7q/xbBBe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="384578624"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="384578624"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 16:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="685072075"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2022 16:21:56 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYFE4-00047B-00;
        Tue, 13 Sep 2022 23:21:56 +0000
Date:   Wed, 14 Sep 2022 07:21:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [linux-stable-rc:linux-5.15.y 460/9999] undefined reference to
 `fb_set_suspend'
Message-ID: <202209140735.HVUioUdX-lkp@intel.com>
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

Hi Greg,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   dbbecf1f4a70fc81ce87ab06e01ebfb7b0e2de03
commit: b06962406eca3d0ca818e2cda96e1b2e1f82bc94 [460/9999] Revert "drm: fb_helper: fix CONFIG_FB dependency"
config: csky-randconfig-r024-20220912 (https://download.01.org/0day-ci/archive/20220914/202209140735.HVUioUdX-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=b06962406eca3d0ca818e2cda96e1b2e1f82bc94
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout b06962406eca3d0ca818e2cda96e1b2e1f82bc94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
>> (.text+0x21a): undefined reference to `fb_set_suspend'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x246): undefined reference to `fb_set_suspend'
   csky-linux-ld: drm_fb_helper.c:(.text+0x284): undefined reference to `fb_set_suspend'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
>> (.text+0x3f6): undefined reference to `unregister_framebuffer'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
>> (.text+0x488): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: (.text+0x498): undefined reference to `framebuffer_release'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
>> (.text+0x53c): undefined reference to `fb_sys_read'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `setcmap_new_gamma_lut':
   drm_fb_helper.c:(.text+0x61c): undefined reference to `unregister_framebuffer'
   csky-linux-ld: drm_fb_helper.c:(.text+0x628): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: drm_fb_helper.c:(.text+0x62c): undefined reference to `framebuffer_release'
   csky-linux-ld: drm_fb_helper.c:(.text+0x650): undefined reference to `fb_sys_read'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x13f8): undefined reference to `register_framebuffer'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_initial_config':
>> (.text+0x1500): undefined reference to `register_framebuffer'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
>> (.text+0x1918): undefined reference to `framebuffer_alloc'
   csky-linux-ld: (.text+0x1944): undefined reference to `fb_alloc_cmap'
   csky-linux-ld: (.text+0x19a2): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: (.text+0x19ca): undefined reference to `framebuffer_release'
   csky-linux-ld: (.text+0x1a10): undefined reference to `framebuffer_alloc'
   csky-linux-ld: (.text+0x1a18): undefined reference to `fb_alloc_cmap'
   csky-linux-ld: (.text+0x1a24): undefined reference to `fb_dealloc_cmap'
   csky-linux-ld: (.text+0x1a28): undefined reference to `framebuffer_release'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x1dd8): undefined reference to `fb_set_suspend'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `setcmap_atomic.isra.0':
   drm_fb_helper.c:(.text+0x2094): undefined reference to `fb_set_suspend'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x2868): undefined reference to `fb_deferred_io_init'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2904): undefined reference to `fb_deferred_io_init'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
>> (.text+0x2c02): undefined reference to `cfb_imageblit'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
>> (.text+0x2c32): undefined reference to `cfb_copyarea'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
>> (.text+0x2c62): undefined reference to `cfb_fillrect'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
>> (.text+0x2c92): undefined reference to `sys_imageblit'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
>> (.text+0x2cc2): undefined reference to `sys_copyarea'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
>> (.text+0x2cf2): undefined reference to `sys_fillrect'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
>> (.text+0x2d20): undefined reference to `fb_sys_write'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_fillrect':
>> drm_fb_helper.c:(.text+0x2e16): undefined reference to `cfb_fillrect'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2e26): undefined reference to `sys_fillrect'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_imageblit':
   drm_fb_helper.c:(.text+0x2e6e): undefined reference to `cfb_imageblit'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2e7e): undefined reference to `sys_imageblit'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_fb_copyarea':
   drm_fb_helper.c:(.text+0x2ec6): undefined reference to `cfb_copyarea'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2ed6): undefined reference to `sys_copyarea'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2efc): undefined reference to `cfb_imageblit'
>> csky-linux-ld: drm_fb_helper.c:(.text+0x2f04): undefined reference to `cfb_copyarea'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2f08): undefined reference to `cfb_fillrect'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2f0c): undefined reference to `sys_imageblit'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2f10): undefined reference to `sys_copyarea'
   csky-linux-ld: drm_fb_helper.c:(.text+0x2f14): undefined reference to `sys_fillrect'
>> csky-linux-ld: drm_fb_helper.c:(.text+0x2f18): undefined reference to `fb_sys_write'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x3080): undefined reference to `fb_deferred_io_cleanup'
   csky-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_client_unregister':
   drm_fb_helper.c:(.text+0x3184): undefined reference to `fb_deferred_io_cleanup'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
