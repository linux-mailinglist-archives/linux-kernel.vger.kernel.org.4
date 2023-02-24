Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D396A1F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBXQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBXQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:16:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9112D6EB3B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 08:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677255359; x=1708791359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6ml9Rij3KBCXPLxf73qa6NWDty86Rof1kQKrXVrGBQ4=;
  b=m7pNrDiXDn7DNrh6NmRgNHc5s9JgBgtE+mO82tvfrP4A1/vhFuadFS5A
   OPdBfliLevPC+fFk7KeaBmEnH20ESVsy18YzIFNGnTu8R18yrTDb94OBq
   mr3HAD39Cirrm2xneRlJuZo2rA31zUdT/88PoMe56mpZdeONrPc+OFWud
   X4QFyj59A5qDk6VGKiXKOmyxvVFgN4iu/cW4/rgzT/FWJ3QM+Y0L3rtM5
   s4Vy/Zu4YIqIS83yE2H1WCSwJ82n55v8ayQMu003vxGOH6WhBp6ldJicR
   I0OQXrmr2cB3OcxALf/PhSUq2aMBbiP9QovQ6yzdSpmtRNrmx7P3Wgdlg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="396022753"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="396022753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 08:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="1001873461"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="1001873461"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Feb 2023 08:15:57 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pVajk-0002Wv-1H;
        Fri, 24 Feb 2023 16:15:56 +0000
Date:   Sat, 25 Feb 2023 00:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/gpu/drm/omapdrm/omap_fbdev.c:235:6: warning: variable
 'helper' is used uninitialized whenever 'if' condition is true
Message-ID: <202302250058.fYTe9aTP-lkp@intel.com>
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
head:   d2980d8d826554fa6981d621e569a453787472f8
commit: 3fb1f62f80a1d249260db5ea9e22c51e52fab9ae drm/fb-helper: Remove drm_fb_helper_unprepare() from drm_fb_helper_fini()
date:   3 days ago
config: arm-randconfig-r033-20230222 (https://download.01.org/0day-ci/archive/20230225/202302250058.fYTe9aTP-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fb1f62f80a1d249260db5ea9e22c51e52fab9ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3fb1f62f80a1d249260db5ea9e22c51e52fab9ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/omapdrm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302250058.fYTe9aTP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/omapdrm/omap_fbdev.c:235:6: warning: variable 'helper' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (!fbdev)
               ^~~~~~
   drivers/gpu/drm/omapdrm/omap_fbdev.c:259:26: note: uninitialized use occurs here
           drm_fb_helper_unprepare(helper);
                                   ^~~~~~
   drivers/gpu/drm/omapdrm/omap_fbdev.c:235:2: note: remove the 'if' if its condition is always false
           if (!fbdev)
           ^~~~~~~~~~~
   drivers/gpu/drm/omapdrm/omap_fbdev.c:228:30: note: initialize the variable 'helper' to silence this warning
           struct drm_fb_helper *helper;
                                       ^
                                        = NULL
   1 warning generated.


vim +235 drivers/gpu/drm/omapdrm/omap_fbdev.c

cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  222  
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  223  /* initialize fbdev helper */
efd1f06be004a6 drivers/gpu/drm/omapdrm/omap_fbdev.c Tomi Valkeinen    2018-02-09  224  void omap_fbdev_init(struct drm_device *dev)
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  225  {
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  226  	struct omap_drm_private *priv = dev->dev_private;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  227  	struct omap_fbdev *fbdev = NULL;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  228  	struct drm_fb_helper *helper;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  229  	int ret = 0;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  230  
2ee767922e1bc7 drivers/gpu/drm/omapdrm/omap_fbdev.c Laurent Pinchart  2018-03-05  231  	if (!priv->num_pipes)
da77772172059e drivers/gpu/drm/omapdrm/omap_fbdev.c Peter Ujfalusi    2017-12-15  232  		return;
da77772172059e drivers/gpu/drm/omapdrm/omap_fbdev.c Peter Ujfalusi    2017-12-15  233  
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  234  	fbdev = kzalloc(sizeof(*fbdev), GFP_KERNEL);
78110bb8dc4a7f drivers/staging/omapdrm/omap_fbdev.c Joe Perches       2013-02-11 @235  	if (!fbdev)
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  236  		goto fail;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  237  
9b55b95a8eca1a drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2012-03-05  238  	INIT_WORK(&fbdev->work, pan_worker);
9b55b95a8eca1a drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2012-03-05  239  
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  240  	helper = &fbdev->base;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  241  
6c80a93be62d39 drivers/gpu/drm/omapdrm/omap_fbdev.c Thomas Zimmermann 2023-01-25  242  	drm_fb_helper_prepare(dev, helper, 32, &omap_fb_helper_funcs);
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  243  
2dea2d1182179e drivers/gpu/drm/omapdrm/omap_fbdev.c Pankaj Bharadiya  2020-03-05  244  	ret = drm_fb_helper_init(dev, helper);
efd1f06be004a6 drivers/gpu/drm/omapdrm/omap_fbdev.c Tomi Valkeinen    2018-02-09  245  	if (ret)
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  246  		goto fail;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  247  
6c80a93be62d39 drivers/gpu/drm/omapdrm/omap_fbdev.c Thomas Zimmermann 2023-01-25  248  	ret = drm_fb_helper_initial_config(helper);
01934c2a691882 drivers/gpu/drm/omapdrm/omap_fbdev.c Thierry Reding    2014-12-19  249  	if (ret)
01934c2a691882 drivers/gpu/drm/omapdrm/omap_fbdev.c Thierry Reding    2014-12-19  250  		goto fini;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  251  
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  252  	priv->fbdev = helper;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  253  
efd1f06be004a6 drivers/gpu/drm/omapdrm/omap_fbdev.c Tomi Valkeinen    2018-02-09  254  	return;
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  255  
01934c2a691882 drivers/gpu/drm/omapdrm/omap_fbdev.c Thierry Reding    2014-12-19  256  fini:
01934c2a691882 drivers/gpu/drm/omapdrm/omap_fbdev.c Thierry Reding    2014-12-19  257  	drm_fb_helper_fini(helper);
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  258  fail:
3fb1f62f80a1d2 drivers/gpu/drm/omapdrm/omap_fbdev.c Thomas Zimmermann 2023-02-16  259  	drm_fb_helper_unprepare(helper);
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  260  	kfree(fbdev);
e1c1174f8d5602 drivers/gpu/drm/omapdrm/omap_fbdev.c Laurent Pinchart  2015-12-14  261  
e1c1174f8d5602 drivers/gpu/drm/omapdrm/omap_fbdev.c Laurent Pinchart  2015-12-14  262  	dev_warn(dev->dev, "omap_fbdev_init failed\n");
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  263  }
cd5351f4d2b1b8 drivers/staging/omapdrm/omap_fbdev.c Rob Clark         2011-11-12  264  

:::::: The code at line 235 was first introduced by commit
:::::: 78110bb8dc4a7ff331bfa3cfe7d4e287cfb3f22b staging: Remove unnecessary OOM messages

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
