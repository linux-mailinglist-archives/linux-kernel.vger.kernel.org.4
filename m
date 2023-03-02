Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3056A7B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCBGYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCBGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:24:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF6313D67
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677738282; x=1709274282;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aPxoQbiPjNGzEwV5XdJiqZq1/oypin3SyBjn4qo7OIg=;
  b=DgSO1YLU38WTkMexD2gyJrIRT98XK0xrVZhlu/tPAUgWElnhKpL2dNTr
   a0GB/uivKdPKNmcg3QE3lNeljP3B8mEZo0MUWtyz3TW8z7JN1ZgpSf5+O
   kKJKfCAFe1uBwJid1XXW+SQjF1RhXWJskq5lzEYuts9i+M7vWGZd6tLcF
   8Ffzq8Eu50VhwPLJ8MP1QuX3858edQ/mnqU6X6K1CnxRGqsR6QLK+ewJz
   0l1CwmETV+qC11SGP72h4OhraV/ZozUpyeA0vbeQJ5TrDlfwPAeFqfujl
   qgNqkcxBbSBcykdLqTQyANXs3V+dx9JTF6YXWwMNUWZeNVzQ8mzU2RlC2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362219159"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="362219159"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 22:24:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="743716299"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="743716299"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Mar 2023 22:24:04 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXcMG-0000GX-0H;
        Thu, 02 Mar 2023 06:24:04 +0000
Date:   Thu, 2 Mar 2023 14:23:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/radeon/radeon_fb.c:265:9: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202303021455.nC6Muze9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ee3f96b164688dae21e2466a57f2e806b64e8a37
commit: 8318f7c231d5be09e47410c5ab387b9bef6fe19e csky: optimize memcpy_{from,to}io() and memset_io()
date:   11 months ago
config: csky-randconfig-s033-20230302 (https://download.01.org/0day-ci/archive/20230302/202303021455.nC6Muze9-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8318f7c231d5be09e47410c5ab387b9bef6fe19e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8318f7c231d5be09e47410c5ab387b9bef6fe19e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash drivers/gpu/drm/radeon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303021455.nC6Muze9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/radeon/radeon_fb.c:265:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got void *kptr @@
   drivers/gpu/drm/radeon/radeon_fb.c:265:9: sparse:     expected void volatile [noderef] __iomem *
   drivers/gpu/drm/radeon/radeon_fb.c:265:9: sparse:     got void *kptr
   drivers/gpu/drm/radeon/radeon_fb.c:272:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *kptr @@
   drivers/gpu/drm/radeon/radeon_fb.c:272:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/gpu/drm/radeon/radeon_fb.c:272:27: sparse:     got void *kptr

vim +265 drivers/gpu/drm/radeon/radeon_fb.c

8be48d924c307e Dave Airlie       2010-03-30  211  
cd5428a5447cc6 Daniel Vetter     2013-01-21  212  static int radeonfb_create(struct drm_fb_helper *helper,
8be48d924c307e Dave Airlie       2010-03-30  213  			   struct drm_fb_helper_surface_size *sizes)
8be48d924c307e Dave Airlie       2010-03-30  214  {
a1d0280e678c4d Fabian Frederick  2014-09-14  215  	struct radeon_fbdev *rfbdev =
a1d0280e678c4d Fabian Frederick  2014-09-14  216  		container_of(helper, struct radeon_fbdev, helper);
8be48d924c307e Dave Airlie       2010-03-30  217  	struct radeon_device *rdev = rfbdev->rdev;
8be48d924c307e Dave Airlie       2010-03-30  218  	struct fb_info *info;
8be48d924c307e Dave Airlie       2010-03-30  219  	struct drm_framebuffer *fb = NULL;
308e5bcbdb1045 Jesse Barnes      2011-11-14  220  	struct drm_mode_fb_cmd2 mode_cmd;
8be48d924c307e Dave Airlie       2010-03-30  221  	struct drm_gem_object *gobj = NULL;
8be48d924c307e Dave Airlie       2010-03-30  222  	struct radeon_bo *rbo = NULL;
8be48d924c307e Dave Airlie       2010-03-30  223  	int ret;
8be48d924c307e Dave Airlie       2010-03-30  224  	unsigned long tmp;
8be48d924c307e Dave Airlie       2010-03-30  225  
8be48d924c307e Dave Airlie       2010-03-30  226  	mode_cmd.width = sizes->surface_width;
8be48d924c307e Dave Airlie       2010-03-30  227  	mode_cmd.height = sizes->surface_height;
8be48d924c307e Dave Airlie       2010-03-30  228  
8be48d924c307e Dave Airlie       2010-03-30  229  	/* avivo can't scanout real 24bpp */
8be48d924c307e Dave Airlie       2010-03-30  230  	if ((sizes->surface_bpp == 24) && ASIC_IS_AVIVO(rdev))
8be48d924c307e Dave Airlie       2010-03-30  231  		sizes->surface_bpp = 32;
771fe6b912fca5 Jerome Glisse     2009-06-05  232  
308e5bcbdb1045 Jesse Barnes      2011-11-14  233  	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
308e5bcbdb1045 Jesse Barnes      2011-11-14  234  							  sizes->surface_depth);
771fe6b912fca5 Jerome Glisse     2009-06-05  235  
8be48d924c307e Dave Airlie       2010-03-30  236  	ret = radeonfb_create_pinned_object(rfbdev, &mode_cmd, &gobj);
aaefcd4284a539 Dave Airlie       2012-03-06  237  	if (ret) {
aaefcd4284a539 Dave Airlie       2012-03-06  238  		DRM_ERROR("failed to create fbcon object %d\n", ret);
aaefcd4284a539 Dave Airlie       2012-03-06  239  		return ret;
aaefcd4284a539 Dave Airlie       2012-03-06  240  	}
aaefcd4284a539 Dave Airlie       2012-03-06  241  
7e4d15d90afe46 Daniel Vetter     2011-02-18  242  	rbo = gem_to_radeon_bo(gobj);
8be48d924c307e Dave Airlie       2010-03-30  243  
8be48d924c307e Dave Airlie       2010-03-30  244  	/* okay we have an object now allocate the framebuffer */
00450052436f87 Archit Taneja     2015-07-31  245  	info = drm_fb_helper_alloc_fbi(helper);
00450052436f87 Archit Taneja     2015-07-31  246  	if (IS_ERR(info)) {
00450052436f87 Archit Taneja     2015-07-31  247  		ret = PTR_ERR(info);
da7bdda2afdf1a Daniel Vetter     2017-02-07  248  		goto out;
771fe6b912fca5 Jerome Glisse     2009-06-05  249  	}
785b93ef8c3097 Dave Airlie       2009-08-28  250  
8782c647aec43e Daniel Vetter     2018-11-27  251  	/* radeon resume is fragile and needs a vt switch to help it along */
8782c647aec43e Daniel Vetter     2018-11-27  252  	info->skip_vt_switch = false;
8782c647aec43e Daniel Vetter     2018-11-27  253  
9a0f0c9d0c9de7 Daniel Stone      2018-03-30  254  	ret = radeon_framebuffer_init(rdev->ddev, &rfbdev->fb, &mode_cmd, gobj);
aaefcd4284a539 Dave Airlie       2012-03-06  255  	if (ret) {
8b513d0cf603c0 Masanari Iida     2013-05-21  256  		DRM_ERROR("failed to initialize framebuffer %d\n", ret);
da7bdda2afdf1a Daniel Vetter     2017-02-07  257  		goto out;
aaefcd4284a539 Dave Airlie       2012-03-06  258  	}
8be48d924c307e Dave Airlie       2010-03-30  259  
9a0f0c9d0c9de7 Daniel Stone      2018-03-30  260  	fb = &rfbdev->fb;
386516744ba45d Dave Airlie       2010-03-30  261  
386516744ba45d Dave Airlie       2010-03-30  262  	/* setup helper */
386516744ba45d Dave Airlie       2010-03-30  263  	rfbdev->helper.fb = fb;
771fe6b912fca5 Jerome Glisse     2009-06-05  264  
8be48d924c307e Dave Airlie       2010-03-30 @265  	memset_io(rbo->kptr, 0x0, radeon_bo_size(rbo));
bf8e828b00a5b6 Dave Airlie       2009-08-17  266  
771fe6b912fca5 Jerome Glisse     2009-06-05  267  	info->fbops = &radeonfb_ops;
785b93ef8c3097 Dave Airlie       2009-08-28  268  
8be48d924c307e Dave Airlie       2010-03-30  269  	tmp = radeon_bo_gpu_offset(rbo) - rdev->mc.vram_start;
f92e93eb5f4d56 Jerome Glisse     2009-06-22  270  	info->fix.smem_start = rdev->mc.aper_base + tmp;
8be48d924c307e Dave Airlie       2010-03-30  271  	info->fix.smem_len = radeon_bo_size(rbo);
8be48d924c307e Dave Airlie       2010-03-30  272  	info->screen_base = rbo->kptr;
8be48d924c307e Dave Airlie       2010-03-30  273  	info->screen_size = radeon_bo_size(rbo);
785b93ef8c3097 Dave Airlie       2009-08-28  274  
19d8a4e3d91fda Daniel Vetter     2019-03-26  275  	drm_fb_helper_fill_info(info, &rfbdev->helper, sizes);
ed8f0d9e708a1a Dave Airlie       2009-07-29  276  
ed8f0d9e708a1a Dave Airlie       2009-07-29  277  	/* setup aperture base/size for vesafb takeover */
1471ca9aa71cd3 Marcin Slusarz    2010-05-16  278  	info->apertures->ranges[0].base = rdev->ddev->mode_config.fb_base;
68d3059665c4a5 Dave Airlie       2010-12-20  279  	info->apertures->ranges[0].size = rdev->mc.aper_size;
ed8f0d9e708a1a Dave Airlie       2009-07-29  280  
fb2a99e15ff0d3 Sascha Hauer      2012-02-06  281  	/* Use default scratch pixmap (info->pixmap.flags = FB_PIXMAP_SYSTEM) */
4abe35204af82a Dave Airlie       2010-03-30  282  
771fe6b912fca5 Jerome Glisse     2009-06-05  283  	if (info->screen_base == NULL) {
771fe6b912fca5 Jerome Glisse     2009-06-05  284  		ret = -ENOSPC;
da7bdda2afdf1a Daniel Vetter     2017-02-07  285  		goto out;
4abe35204af82a Dave Airlie       2010-03-30  286  	}
4abe35204af82a Dave Airlie       2010-03-30  287  
771fe6b912fca5 Jerome Glisse     2009-06-05  288  	DRM_INFO("fb mappable at 0x%lX\n",  info->fix.smem_start);
771fe6b912fca5 Jerome Glisse     2009-06-05  289  	DRM_INFO("vram apper at 0x%lX\n",  (unsigned long)rdev->mc.aper_base);
8be48d924c307e Dave Airlie       2010-03-30  290  	DRM_INFO("size %lu\n", (unsigned long)radeon_bo_size(rbo));
b00c600e91531d Ville Syrjälä     2016-12-14  291  	DRM_INFO("fb depth is %d\n", fb->format->depth);
01f2c7730e1880 Ville Syrjälä     2011-12-20  292  	DRM_INFO("   pitch is %d\n", fb->pitches[0]);
771fe6b912fca5 Jerome Glisse     2009-06-05  293  
d86a41267b32e9 Thomas Zimmermann 2020-12-01  294  	vga_switcheroo_client_fb_set(rdev->pdev, info);
771fe6b912fca5 Jerome Glisse     2009-06-05  295  	return 0;
771fe6b912fca5 Jerome Glisse     2009-06-05  296  
da7bdda2afdf1a Daniel Vetter     2017-02-07  297  out:
f92e93eb5f4d56 Jerome Glisse     2009-06-22  298  	if (fb && ret) {
f11fb66ae92193 Emil Velikov      2020-05-15  299  		drm_gem_object_put(gobj);
362063619cf67c Daniel Vetter     2012-12-10  300  		drm_framebuffer_unregister_private(fb);
771fe6b912fca5 Jerome Glisse     2009-06-05  301  		drm_framebuffer_cleanup(fb);
771fe6b912fca5 Jerome Glisse     2009-06-05  302  		kfree(fb);
771fe6b912fca5 Jerome Glisse     2009-06-05  303  	}
771fe6b912fca5 Jerome Glisse     2009-06-05  304  	return ret;
771fe6b912fca5 Jerome Glisse     2009-06-05  305  }
771fe6b912fca5 Jerome Glisse     2009-06-05  306  

:::::: The code at line 265 was first introduced by commit
:::::: 8be48d924c307e72e3797ab5bde81b07a1ccc52d drm/kms/fb: move to using fb helper crtc grouping instead of core crtc list

:::::: TO: Dave Airlie <airlied@redhat.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
