Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1668D180
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjBGIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBGIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:35:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE372ED66
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675758899; x=1707294899;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7h93IpIj5ozX3HQ0og1Lx/oTF8dHsl4ZE8UKhuKLWso=;
  b=GPt8KhNxUplMBbYTdV2IdcvueBUwBQhHjamWyO11ncivwofqZW4zWY6/
   eDSnd7hUW8vtvIRqJw7+scIeXhNQ4aaSwKMrI8tdRYbdyrAA4USUZqmq4
   +mddcKYgKfj1dgJUJ3jZkx+ngoSrDBgUcqtbSk85CoK7jZFmzKSH2iCLx
   eBj2tiyu0/9cahcC+U9pv84vG94N11/Jd5xpFFHsBpwpUVaAxRbBwUf/0
   vx16CWCXIuwZHAJOC36kf/b7GvcAC/3HJwEyIQO5MYpmfpeMB58jN2etd
   j1MVqs/J9hFWF+dNl0IeFWahIsaJRKuRuQn6vg7VneefReRb/xKWF29xo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="317469640"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="317469640"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 00:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="755552657"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="755552657"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2023 00:34:51 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pPJRD-0003MK-00;
        Tue, 07 Feb 2023 08:34:51 +0000
Date:   Tue, 7 Feb 2023 16:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/omap/omapfb_main.c:549 set_fb_var() warn:
 inconsistent indenting
Message-ID: <202302071628.D2cZY8jL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
commit: 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b fbdev: omap: avoid using mach/*.h files
date:   10 months ago
config: arm-randconfig-m031-20230207 (https://download.01.org/0day-ci/archive/20230207/202302071628.D2cZY8jL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/video/fbdev/omap/omapfb_main.c:549 set_fb_var() warn: inconsistent indenting

Old smatch warnings:
drivers/video/fbdev/omap/omapfb_main.c:551 set_fb_var() warn: inconsistent indenting
drivers/video/fbdev/omap/omapfb_main.c:556 set_fb_var() warn: inconsistent indenting
drivers/video/fbdev/omap/omapfb_main.c:558 set_fb_var() warn: inconsistent indenting
drivers/video/fbdev/omap/omapfb_main.c:1646 omapfb_do_probe() warn: platform_get_irq() does not return zero
drivers/video/fbdev/omap/omapfb_main.c:1653 omapfb_do_probe() warn: platform_get_irq() does not return zero

vim +549 drivers/video/fbdev/omap/omapfb_main.c

8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  457  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  458  /*
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  459   * Check the values in var against our capabilities and in case of out of
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  460   * bound values try to adjust them.
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  461   */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  462  static int set_fb_var(struct fb_info *fbi,
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  463  		      struct fb_var_screeninfo *var)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  464  {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  465  	int		bpp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  466  	unsigned long	max_frame_size;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  467  	unsigned long	line_size;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  468  	int		xres_min, xres_max;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  469  	int		yres_min, yres_max;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  470  	struct omapfb_plane_struct *plane = fbi->par;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  471  	struct omapfb_device *fbdev = plane->fbdev;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  472  	struct lcd_panel *panel = fbdev->panel;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  473  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  474  	if (set_color_mode(plane, var) < 0)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  475  		return -EINVAL;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  476  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  477  	bpp = var->bits_per_pixel;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  478  	if (plane->color_mode == OMAPFB_COLOR_RGB444)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  479  		bpp = 16;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  480  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  481  	switch (var->rotate) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  482  	case 0:
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  483  	case 180:
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  484  		xres_min = OMAPFB_PLANE_XRES_MIN;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  485  		xres_max = panel->x_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  486  		yres_min = OMAPFB_PLANE_YRES_MIN;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  487  		yres_max = panel->y_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  488  		if (cpu_is_omap15xx()) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  489  			var->xres = panel->x_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  490  			var->yres = panel->y_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  491  		}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  492  		break;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  493  	case 90:
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  494  	case 270:
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  495  		xres_min = OMAPFB_PLANE_YRES_MIN;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  496  		xres_max = panel->y_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  497  		yres_min = OMAPFB_PLANE_XRES_MIN;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  498  		yres_max = panel->x_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  499  		if (cpu_is_omap15xx()) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  500  			var->xres = panel->y_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  501  			var->yres = panel->x_res;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  502  		}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  503  		break;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  504  	default:
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  505  		return -EINVAL;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  506  	}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  507  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  508  	if (var->xres < xres_min)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  509  		var->xres = xres_min;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  510  	if (var->yres < yres_min)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  511  		var->yres = yres_min;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  512  	if (var->xres > xres_max)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  513  		var->xres = xres_max;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  514  	if (var->yres > yres_max)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  515  		var->yres = yres_max;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  516  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  517  	if (var->xres_virtual < var->xres)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  518  		var->xres_virtual = var->xres;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  519  	if (var->yres_virtual < var->yres)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  520  		var->yres_virtual = var->yres;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  521  	max_frame_size = fbdev->mem_desc.region[plane->idx].size;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  522  	line_size = var->xres_virtual * bpp / 8;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  523  	if (line_size * var->yres_virtual > max_frame_size) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  524  		/* Try to keep yres_virtual first */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  525  		line_size = max_frame_size / var->yres_virtual;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  526  		var->xres_virtual = line_size * 8 / bpp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  527  		if (var->xres_virtual < var->xres) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  528  			/* Still doesn't fit. Shrink yres_virtual too */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  529  			var->xres_virtual = var->xres;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  530  			line_size = var->xres * bpp / 8;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  531  			var->yres_virtual = max_frame_size / line_size;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  532  		}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  533  		/* Recheck this, as the virtual size changed. */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  534  		if (var->xres_virtual < var->xres)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  535  			var->xres = var->xres_virtual;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  536  		if (var->yres_virtual < var->yres)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  537  			var->yres = var->yres_virtual;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  538  		if (var->xres < xres_min || var->yres < yres_min)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  539  			return -EINVAL;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  540  	}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  541  	if (var->xres + var->xoffset > var->xres_virtual)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  542  		var->xoffset = var->xres_virtual - var->xres;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  543  	if (var->yres + var->yoffset > var->yres_virtual)
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  544  		var->yoffset = var->yres_virtual - var->yres;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  545  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  546  	if (plane->color_mode == OMAPFB_COLOR_RGB444) {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  547  		var->red.offset	  = 8; var->red.length	 = 4;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  548  						var->red.msb_right   = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17 @549  		var->green.offset = 4; var->green.length = 4;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  550  						var->green.msb_right = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  551  		var->blue.offset  = 0; var->blue.length  = 4;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  552  						var->blue.msb_right  = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  553  	} else {
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  554  		var->red.offset	 = 11; var->red.length	 = 5;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  555  						var->red.msb_right   = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  556  		var->green.offset = 5;  var->green.length = 6;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  557  						var->green.msb_right = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  558  		var->blue.offset = 0;  var->blue.length  = 5;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  559  						var->blue.msb_right  = 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  560  	}
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  561  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  562  	var->height		= -1;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  563  	var->width		= -1;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  564  	var->grayscale		= 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  565  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  566  	/* pixclock in ps, the rest in pixclock */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  567  	var->pixclock		= 10000000 / (panel->pixel_clock / 100);
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  568  	var->left_margin	= panel->hfp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  569  	var->right_margin	= panel->hbp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  570  	var->upper_margin	= panel->vfp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  571  	var->lower_margin	= panel->vbp;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  572  	var->hsync_len		= panel->hsw;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  573  	var->vsync_len		= panel->vsw;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  574  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  575  	/* TODO: get these from panel->config */
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  576  	var->vmode		= FB_VMODE_NONINTERLACED;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  577  	var->sync		= 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  578  
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  579  	return 0;
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  580  }
8b08cf2b64f5a6 drivers/video/omap/omapfb_main.c Imre Deak 2007-07-17  581  

:::::: The code at line 549 was first introduced by commit
:::::: 8b08cf2b64f5a60594b07795b2ad518c6d044566 OMAP: add TI OMAP framebuffer driver

:::::: TO: Imre Deak <imre.deak@solidboot.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
