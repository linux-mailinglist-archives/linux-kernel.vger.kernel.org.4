Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDC5E78AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiIWKuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiIWKtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:49:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DB13F5F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663930189; x=1695466189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Frrn/uI59Fb5x+Vyv8/aK9jxiEYhtFvtdq/l1l5uTnc=;
  b=nNVAAH2IwUsyD5eDXmmk0qoLjmKmslwfJ1Pz6u8S2J/RqlQvg3eGlA7q
   uUQnmszul6iIrjOpxVaP9z0a1WEZOSlIRgWo5Y5F00dDA3/CZLJSj4hrN
   B4oqSprTMT9iqVACgM8X83KQvMrRC9ru4kESxRQkiDgP2QoQKCP5SR30T
   tpGqXsdPF2BSAj1jd7sYbpPzZVRcdMGvpKdFPS7ArKMiDhLYpFO9E2WiT
   3UhYbnbnSSCPNTGZshIUBhWmMUdjylaCOlKzhkIOIY5MYWv5hlMYbN0Eg
   5SKmEgdZ2q1SMP+SP17+3Els4aWu4JMIRHPtBxDr1XS/p9FEW4uN4Cw9I
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283663219"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="283663219"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="709261031"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2022 03:49:46 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obgFd-0005aW-1F;
        Fri, 23 Sep 2022 10:49:45 +0000
Date:   Fri, 23 Sep 2022 18:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>
Subject: [linux-stable-rc:linux-5.15.y 4824/9999] undefined reference to
 `fb_set_suspend'
Message-ID: <202209231837.lURoaR04-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   16d41e601858766935e69e3f9d62db810e5d277d
commit: 81e5b16de862866e7f09a1b00b49f97a9bc23a78 [4824/9999] platform: chrome: Split trace include file
config: ia64-randconfig-r026-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231837.lURoaR04-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=81e5b16de862866e7f09a1b00b49f97a9bc23a78
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout 81e5b16de862866e7f09a1b00b49f97a9bc23a78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend':
>> (.text+0x912): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_resume_worker':
   drm_fb_helper.c:(.text+0x972): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_unregister_fbi':
>> (.text+0xab2): undefined reference to `unregister_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_fini':
>> (.text+0xb82): undefined reference to `fb_dealloc_cmap'
>> ia64-linux-ld: (.text+0xb92): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_read':
>> (.text+0xd52): undefined reference to `fb_sys_read'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fbdev_cleanup':
   drm_fb_helper.c:(.text+0x2b12): undefined reference to `fb_deferred_io_cleanup'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
>> (.text+0x35d2): undefined reference to `framebuffer_alloc'
>> ia64-linux-ld: (.text+0x3622): undefined reference to `fb_alloc_cmap'
>> ia64-linux-ld: (.text+0x3672): undefined reference to `fb_dealloc_cmap'
   ia64-linux-ld: (.text+0x36d2): undefined reference to `framebuffer_release'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_generic_probe':
   drm_fb_helper.c:(.text+0x39f2): undefined reference to `fb_deferred_io_init'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `__drm_fb_helper_initial_config_and_unlock':
   drm_fb_helper.c:(.text+0x3e32): undefined reference to `register_framebuffer'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_set_suspend_unlocked':
   (.text+0x5a42): undefined reference to `fb_set_suspend'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_imageblit':
>> (.text+0x6742): undefined reference to `cfb_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_copyarea':
>> (.text+0x67d2): undefined reference to `cfb_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_cfb_fillrect':
>> (.text+0x6862): undefined reference to `cfb_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_imageblit':
>> (.text+0x68f2): undefined reference to `sys_imageblit'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_copyarea':
>> (.text+0x6a22): undefined reference to `sys_copyarea'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_fillrect':
>> (.text+0x6b52): undefined reference to `sys_fillrect'
   ia64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_sys_write':
>> (.text+0x6c82): undefined reference to `fb_sys_write'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
