Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1307170471E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjEPHz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjEPHzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:55:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67438559A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684223716; x=1715759716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q4augfCG1Tn7l0DL9Xd2VgTpFaaVySHIlN7sWJf0bSM=;
  b=kMgrTSp642xOkkE6L5JFHFNS+3sAWGRslnUgz6XU/Cx1oZWJc9OS40xb
   jsIrtJcwClEp5CJCKLCiCG+vCYtqVT5Fu80jhcEkYL5m9Yn4uff9q/lKw
   hkiLCpo8Lpz2R+bCbfpQ9DLcVR6cKi1CkJa1Vt4JgcidsI+2FeGm5vZhi
   hocybnAkhCRwl492RVaxgUeetxfbcQNWUSJ7siCG0jiA3wHia5UmepxUn
   J1RjsaKORi0pkNW/BITSwtoOZ8xgHdKNdBDnmYqOl87KhfdhWfTFmgcIg
   Q9gLdbMZgumJ5Z2/H2luwj8KehqcSvykALKfapKo/Pc7H7osN7U1XRIKA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331027636"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="331027636"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 00:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="947738401"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="947738401"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 16 May 2023 00:54:02 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pypVR-0007B8-2g;
        Tue, 16 May 2023 07:54:01 +0000
Date:   Tue, 16 May 2023 15:53:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/gma500/fbdev.c:245:9: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202305161516.nT7k9Ujh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: 8f1aaccb04b7cf63135f4e2748226dfa2fb01e3f drm/gma500: Implement client-based fbdev emulation
date:   8 weeks ago
config: i386-randconfig-s001-20230515 (https://download.01.org/0day-ci/archive/20230516/202305161516.nT7k9Ujh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f1aaccb04b7cf63135f4e2748226dfa2fb01e3f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f1aaccb04b7cf63135f4e2748226dfa2fb01e3f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/gma500/ drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305161516.nT7k9Ujh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/gma500/fbdev.c:245:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     expected void const *
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/gpu/drm/gma500/fbdev.c:245:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char [noderef] __iomem *screen_base @@
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     expected void const *
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     got char [noderef] __iomem *screen_base
>> drivers/gpu/drm/gma500/fbdev.c:245:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got char [noderef] __iomem *screen_base @@
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     expected void *
   drivers/gpu/drm/gma500/fbdev.c:245:9: sparse:     got char [noderef] __iomem *screen_base

vim +245 drivers/gpu/drm/gma500/fbdev.c

   158	
   159	/*
   160	 * struct drm_fb_helper_funcs
   161	 */
   162	
   163	static int psb_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
   164				      struct drm_fb_helper_surface_size *sizes)
   165	{
   166		struct drm_device *dev = fb_helper->dev;
   167		struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
   168		struct pci_dev *pdev = to_pci_dev(dev->dev);
   169		struct fb_info *info;
   170		struct drm_framebuffer *fb;
   171		struct drm_mode_fb_cmd2 mode_cmd = { };
   172		int size;
   173		int ret;
   174		struct psb_gem_object *backing;
   175		struct drm_gem_object *obj;
   176		u32 bpp, depth;
   177	
   178		/* No 24-bit packed mode */
   179		if (sizes->surface_bpp == 24) {
   180			sizes->surface_bpp = 32;
   181			sizes->surface_depth = 24;
   182		}
   183		bpp = sizes->surface_bpp;
   184		depth = sizes->surface_depth;
   185	
   186		/*
   187		 * If the mode does not fit in 32 bit then switch to 16 bit to get
   188		 * a console on full resolution. The X mode setting server will
   189		 * allocate its own 32-bit GEM framebuffer.
   190		 */
   191		size = ALIGN(sizes->surface_width * DIV_ROUND_UP(bpp, 8), 64) *
   192			     sizes->surface_height;
   193		size = ALIGN(size, PAGE_SIZE);
   194	
   195		if (size > dev_priv->vram_stolen_size) {
   196			sizes->surface_bpp = 16;
   197			sizes->surface_depth = 16;
   198		}
   199		bpp = sizes->surface_bpp;
   200		depth = sizes->surface_depth;
   201	
   202		mode_cmd.width = sizes->surface_width;
   203		mode_cmd.height = sizes->surface_height;
   204		mode_cmd.pitches[0] = ALIGN(mode_cmd.width * DIV_ROUND_UP(bpp, 8), 64);
   205		mode_cmd.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
   206	
   207		size = mode_cmd.pitches[0] * mode_cmd.height;
   208		size = ALIGN(size, PAGE_SIZE);
   209	
   210		/* Allocate the framebuffer in the GTT with stolen page backing */
   211		backing = psb_gem_create(dev, size, "fb", true, PAGE_SIZE);
   212		if (IS_ERR(backing))
   213			return PTR_ERR(backing);
   214		obj = &backing->base;
   215	
   216		fb = psb_framebuffer_create(dev, &mode_cmd, obj);
   217		if (IS_ERR(fb)) {
   218			ret = PTR_ERR(fb);
   219			goto err_drm_gem_object_put;
   220		}
   221	
   222		fb_helper->fb = fb;
   223	
   224		info = drm_fb_helper_alloc_info(fb_helper);
   225		if (IS_ERR(info)) {
   226			ret = PTR_ERR(info);
   227			goto err_drm_framebuffer_unregister_private;
   228		}
   229	
   230		info->fbops = &psb_fbdev_fb_ops;
   231		info->flags = FBINFO_DEFAULT;
   232		/* Accessed stolen memory directly */
   233		info->screen_base = dev_priv->vram_addr + backing->offset;
   234		info->screen_size = size;
   235	
   236		drm_fb_helper_fill_info(info, fb_helper, sizes);
   237	
   238		info->fix.smem_start = dev_priv->fb_base;
   239		info->fix.smem_len = size;
   240		info->fix.ywrapstep = 0;
   241		info->fix.ypanstep = 0;
   242		info->fix.mmio_start = pci_resource_start(pdev, 0);
   243		info->fix.mmio_len = pci_resource_len(pdev, 0);
   244	
 > 245		memset(info->screen_base, 0, info->screen_size);
   246	
   247		/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
   248	
   249		dev_dbg(dev->dev, "allocated %dx%d fb\n", fb->width, fb->height);
   250	
   251		return 0;
   252	
   253	err_drm_framebuffer_unregister_private:
   254		drm_framebuffer_unregister_private(fb);
   255		fb->obj[0] = NULL;
   256		drm_framebuffer_cleanup(fb);
   257		kfree(fb);
   258	err_drm_gem_object_put:
   259		drm_gem_object_put(obj);
   260		return ret;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
