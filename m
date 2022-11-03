Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB466176A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKCGOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKCGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:14:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324E1A3A9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667456068; x=1698992068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cSZg/1yw1xYAk0Wu2rgatZgqTPErhr/wyWJRW6mGwtQ=;
  b=flBMi3hquGeoxXoNMpfRES41Fp6hIRH1SSiOVO82XcaeQGJYjkKgLG2B
   AA4xh8akfy04G8d4ZzcCDeQfrIE03RbNu8Yk/w57SxYB4o5NwhdE3KfGf
   Kihtsr8nK9fScmsm1IkhL7v+TrRpIUmy0jKGHHltF9PqoFTUQ1YnFpbVO
   qSgT41uM6QqztXL6EZK0H4lIQeSI4w1jgS0OWWCAWocsLcxQPqbw6l5GX
   dUSEOXurCQZ1EMWH/etTv5pXXhyoZipuFPLY6BJjnukm2FhxfiFUvDEGn
   DMXeRN9yONA3jDpt/Ql/D2quEkUT8RpyXT31dG6d/GzFOvMq+GTa5E6dy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="395903505"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="395903505"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="612519410"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="612519410"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2022 23:14:21 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqTUb-000Fa1-1F;
        Thu, 03 Nov 2022 06:14:21 +0000
Date:   Thu, 3 Nov 2022 14:14:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/omap/hwa742.c:791:13: warning: variable 'vdisp'
 set but not used
Message-ID: <202211031431.RA4r2fSQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GwfpVxAv7z6/pTVz"
Content-Disposition: inline
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GwfpVxAv7z6/pTVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
commit: 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b fbdev: omap: avoid using mach/*.h files
date:   7 months ago
config: arm-randconfig-r032-20221103
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/video/fbdev/omap/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/video/fbdev/omap/hwa742.c:492:5: warning: no previous prototype for function 'hwa742_update_window_async' [-Wmissing-prototypes]
   int hwa742_update_window_async(struct fb_info *fbi,
       ^
   drivers/video/fbdev/omap/hwa742.c:492:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int hwa742_update_window_async(struct fb_info *fbi,
   ^
   static 
>> drivers/video/fbdev/omap/hwa742.c:791:13: warning: variable 'vdisp' set but not used [-Wunused-but-set-variable]
           int hdisp, vdisp;
                      ^
>> drivers/video/fbdev/omap/hwa742.c:943:31: warning: variable 'omapfb_conf' set but not used [-Wunused-but-set-variable]
           struct omapfb_platform_data *omapfb_conf;
                                        ^
   3 warnings generated.


vim +/vdisp +791 drivers/video/fbdev/omap/hwa742.c

aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   787  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   788  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   789  static int setup_tearsync(unsigned long pix_clk, int extif_div)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   790  {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  @791  	int hdisp, vdisp;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   792  	int hndp, vndp;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   793  	int hsw, vsw;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   794  	int hs, vs;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   795  	int hs_pol_inv, vs_pol_inv;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   796  	int use_hsvs, use_ndp;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   797  	u8  b;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   798  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   799  	hsw = hwa742_read_reg(HWA742_HS_W_REG);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   800  	vsw = hwa742_read_reg(HWA742_VS_W_REG);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   801  	hs_pol_inv = !(hsw & 0x80);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   802  	vs_pol_inv = !(vsw & 0x80);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   803  	hsw = hsw & 0x7f;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   804  	vsw = vsw & 0x3f;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   805  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   806  	hdisp = (hwa742_read_reg(HWA742_H_DISP_REG) & 0x7f) * 8;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   807  	vdisp = hwa742_read_reg(HWA742_V_DISP_1_REG) +
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   808  		((hwa742_read_reg(HWA742_V_DISP_2_REG) & 0x3) << 8);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   809  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   810  	hndp = hwa742_read_reg(HWA742_H_NDP_REG) & 0x7f;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   811  	vndp = hwa742_read_reg(HWA742_V_NDP_REG);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   812  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   813  	/* time to transfer one pixel (16bpp) in ps */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   814  	hwa742.pix_tx_time = hwa742.reg_timings.we_cycle_time;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   815  	if (hwa742.extif->get_max_tx_rate != NULL) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   816  		/*
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   817  		 * The external interface might have a rate limitation,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   818  		 * if so, we have to maximize our transfer rate.
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   819  		 */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   820  		unsigned long min_tx_time;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   821  		unsigned long max_tx_rate = hwa742.extif->get_max_tx_rate();
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   822  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   823  		dev_dbg(hwa742.fbdev->dev, "max_tx_rate %ld HZ\n",
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   824  			max_tx_rate);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   825  		min_tx_time = 1000000000 / (max_tx_rate / 1000);  /* ps */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   826  		if (hwa742.pix_tx_time < min_tx_time)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   827  			hwa742.pix_tx_time = min_tx_time;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   828  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   829  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   830  	/* time to update one line in ps */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   831  	hwa742.line_upd_time = (hdisp + hndp) * 1000000 / (pix_clk / 1000);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   832  	hwa742.line_upd_time *= 1000;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   833  	if (hdisp * hwa742.pix_tx_time > hwa742.line_upd_time)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   834  		/*
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   835  		 * transfer speed too low, we might have to use both
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   836  		 * HS and VS
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   837  		 */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   838  		use_hsvs = 1;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   839  	else
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   840  		/* decent transfer speed, we'll always use only VS */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   841  		use_hsvs = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   842  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   843  	if (use_hsvs && (hs_pol_inv || vs_pol_inv)) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   844  		/*
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   845  		 * HS or'ed with VS doesn't work, use the active high
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   846  		 * TE signal based on HNDP / VNDP
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   847  		 */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   848  		use_ndp = 1;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   849  		hs_pol_inv = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   850  		vs_pol_inv = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   851  		hs = hndp;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   852  		vs = vndp;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   853  	} else {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   854  		/*
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   855  		 * Use HS or'ed with VS as a TE signal if both are needed
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   856  		 * or VNDP if only vsync is needed.
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   857  		 */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   858  		use_ndp = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   859  		hs = hsw;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   860  		vs = vsw;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   861  		if (!use_hsvs) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   862  			hs_pol_inv = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   863  			vs_pol_inv = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   864  		}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   865  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   866  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   867  	hs = hs * 1000000 / (pix_clk / 1000);			/* ps */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   868  	hs *= 1000;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   869  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   870  	vs = vs * (hdisp + hndp) * 1000000 / (pix_clk / 1000);	/* ps */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   871  	vs *= 1000;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   872  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   873  	if (vs <= hs)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   874  		return -EDOM;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   875  	/* set VS to 120% of HS to minimize VS detection time */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   876  	vs = hs * 12 / 10;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   877  	/* minimize HS too */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   878  	hs = 10000;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   879  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   880  	b = hwa742_read_reg(HWA742_NDP_CTRL);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   881  	b &= ~0x3;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   882  	b |= use_hsvs ? 1 : 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   883  	b |= (use_ndp && use_hsvs) ? 0 : 2;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   884  	hwa742_write_reg(HWA742_NDP_CTRL, b);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   885  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   886  	hwa742.vsync_only = !use_hsvs;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   887  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   888  	dev_dbg(hwa742.fbdev->dev,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   889  		"pix_clk %ld HZ pix_tx_time %ld ps line_upd_time %ld ps\n",
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   890  		pix_clk, hwa742.pix_tx_time, hwa742.line_upd_time);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   891  	dev_dbg(hwa742.fbdev->dev,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   892  		"hs %d ps vs %d ps mode %d vsync_only %d\n",
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   893  		hs, vs, (b & 0x3), !use_hsvs);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   894  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   895  	return hwa742.extif->setup_tearsync(1, hs, vs,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   896  					    hs_pol_inv, vs_pol_inv, extif_div);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   897  }
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   898  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   899  static void hwa742_get_caps(int plane, struct omapfb_caps *caps)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   900  {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   901  	hwa742.int_ctrl->get_caps(plane, caps);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   902  	caps->ctrl |= OMAPFB_CAPS_MANUAL_UPDATE |
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   903  		      OMAPFB_CAPS_WINDOW_PIXEL_DOUBLE;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   904  	if (hwa742.te_connected)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   905  		caps->ctrl |= OMAPFB_CAPS_TEARSYNC;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   906  	caps->wnd_color |= (1 << OMAPFB_COLOR_RGB565) |
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   907  			   (1 << OMAPFB_COLOR_YUV420);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   908  }
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   909  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   910  static void hwa742_suspend(void)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   911  {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   912  	hwa742.update_mode_before_suspend = hwa742.update_mode;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   913  	hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   914  	/* Enable sleep mode */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   915  	hwa742_write_reg(HWA742_POWER_SAVE, 1 << 1);
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   916  	clk_disable(hwa742.sys_ck);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   917  }
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   918  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   919  static void hwa742_resume(void)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   920  {
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   921  	clk_enable(hwa742.sys_ck);
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   922  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   923  	/* Disable sleep mode */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   924  	hwa742_write_reg(HWA742_POWER_SAVE, 0);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   925  	while (1) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   926  		/* Loop until PLL output is stabilized */
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   927  		if (hwa742_read_reg(HWA742_PLL_DIV_REG) & (1 << 7))
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   928  			break;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   929  		set_current_state(TASK_UNINTERRUPTIBLE);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   930  		schedule_timeout(msecs_to_jiffies(5));
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   931  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   932  	hwa742_set_update_mode(hwa742.update_mode_before_suspend);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   933  }
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   934  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   935  static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   936  		       struct omapfb_mem_desc *req_vram)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   937  {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   938  	int r = 0, i;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   939  	u8 rev, conf;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   940  	unsigned long ext_clk;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   941  	unsigned long sys_clk, pix_clk;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   942  	int extif_mem_div;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  @943  	struct omapfb_platform_data *omapfb_conf;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   944  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   945  	BUG_ON(!fbdev->ext_if || !fbdev->int_ctrl);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   946  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   947  	hwa742.fbdev = fbdev;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   948  	hwa742.extif = fbdev->ext_if;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   949  	hwa742.int_ctrl = fbdev->int_ctrl;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   950  
dffb3b47baf472 drivers/video/omap/hwa742.c       Jingoo Han        2013-09-17   951  	omapfb_conf = dev_get_platdata(fbdev->dev);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   952  
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   953  	hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   954  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   955  	spin_lock_init(&hwa742.req_lock);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   956  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   957  	if ((r = hwa742.int_ctrl->init(fbdev, 1, req_vram)) < 0)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   958  		goto err1;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   959  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   960  	if ((r = hwa742.extif->init(fbdev)) < 0)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   961  		goto err2;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   962  
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   963  	ext_clk = clk_get_rate(hwa742.sys_ck);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   964  	if ((r = calc_extif_timings(ext_clk, &extif_mem_div)) < 0)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   965  		goto err3;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   966  	hwa742.extif->set_timings(&hwa742.reg_timings);
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28   967  	clk_enable(hwa742.sys_ck);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   968  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   969  	calc_hwa742_clk_rates(ext_clk, &sys_clk, &pix_clk);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   970  	if ((r = calc_extif_timings(sys_clk, &extif_mem_div)) < 0)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   971  		goto err4;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   972  	hwa742.extif->set_timings(&hwa742.reg_timings);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   973  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   974  	rev = hwa742_read_reg(HWA742_REV_CODE_REG);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   975  	if ((rev & 0xfc) != 0x80) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   976  		dev_err(fbdev->dev, "HWA742: invalid revision %02x\n", rev);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   977  		r = -ENODEV;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   978  		goto err4;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   979  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   980  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   981  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   982  	if (!(hwa742_read_reg(HWA742_PLL_DIV_REG) & 0x80)) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   983  		dev_err(fbdev->dev,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   984  		      "HWA742: controller not initialized by the bootloader\n");
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   985  		r = -ENODEV;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   986  		goto err4;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   987  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   988  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   989  	if ((r = setup_tearsync(pix_clk, extif_mem_div)) < 0) {
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   990  		dev_err(hwa742.fbdev->dev,
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   991  			"HWA742: can't setup tearing synchronization\n");
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   992  		goto err4;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   993  	}
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   994  	hwa742.te_connected = 1;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   995  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   996  	hwa742.max_transmit_size = hwa742.extif->max_transmit_size;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   997  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   998  	hwa742.update_mode = OMAPFB_UPDATE_DISABLED;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26   999  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1000  	hwa742.auto_update_window.x = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1001  	hwa742.auto_update_window.y = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1002  	hwa742.auto_update_window.width = fbdev->panel->x_res;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1003  	hwa742.auto_update_window.height = fbdev->panel->y_res;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1004  	hwa742.auto_update_window.format = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1005  
6c78935777d12e drivers/video/fbdev/omap/hwa742.c Kees Cook         2017-11-10  1006  	timer_setup(&hwa742.auto_update_timer, hwa742_update_window_auto, 0);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1007  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1008  	hwa742.prev_color_mode = -1;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1009  	hwa742.prev_flags = 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1010  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1011  	hwa742.fbdev = fbdev;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1012  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1013  	INIT_LIST_HEAD(&hwa742.free_req_list);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1014  	INIT_LIST_HEAD(&hwa742.pending_req_list);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1015  	for (i = 0; i < ARRAY_SIZE(hwa742.req_pool); i++)
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1016  		list_add(&hwa742.req_pool[i].entry, &hwa742.free_req_list);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1017  	BUG_ON(i <= IRQ_REQ_POOL_SIZE);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1018  	sema_init(&hwa742.req_sema, i - IRQ_REQ_POOL_SIZE);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1019  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1020  	conf = hwa742_read_reg(HWA742_CONFIG_REG);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1021  	dev_info(fbdev->dev, ": Epson HWA742 LCD controller rev %d "
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1022  			"initialized (CNF pins %x)\n", rev & 0x03, conf & 0x07);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1023  
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1024  	return 0;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1025  err4:
088962c243db42 drivers/video/omap/hwa742.c       Andrew de Quincey 2009-05-28  1026  	clk_disable(hwa742.sys_ck);
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1027  err3:
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1028  	hwa742.extif->cleanup();
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1029  err2:
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1030  	hwa742.int_ctrl->cleanup();
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1031  err1:
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1032  	return r;
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1033  }
aae76ef13e348c drivers/video/omap/hwa742.c       Imre Deak         2007-05-26  1034  

:::::: The code at line 791 was first introduced by commit
:::::: aae76ef13e348cebac225407ea2c452f8d0ff862 OMAP: add external Epson HWA742 LCD controller support

:::::: TO: Imre Deak <imre.deak@solidboot.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

--GwfpVxAv7z6/pTVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 5.18.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 16.0.0 (git://gitmirror/llvm_project 791a7ae1ba3efd6bca96338e10ffde557ba83920)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=160000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=160000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=160000
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_COMPILE_TEST=y
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_USELIB=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_GENERIC_IRQ_MULTI_HANDLER=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_TIME_KUNIT_TEST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
CONFIG_RCU_BOOST=y
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_TASKS_TRACE_RCU_READ_MB is not set
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_GENERIC_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_ARM=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_NO_IOPORT_MAP=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_PHYS_OFFSET=0x00800000
CONFIG_GENERIC_BUG=y
CONFIG_PGTABLE_LEVELS=2

#
# System Type
#
# CONFIG_MMU is not set
CONFIG_ARM_SINGLE_ARMV7M=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_AT91=y
# CONFIG_SOC_SAMV7 is not set

#
# Clocksource driver selection
#
CONFIG_ATMEL_CLOCKSOURCE_TCB=y
CONFIG_COMMON_CLK_AT91=y
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_STM32 is not set
CONFIG_ARCH_LPC18XX=y
CONFIG_ARCH_MPS2=y

#
# Processor Type
#
CONFIG_CPU_V7M=y
CONFIG_CPU_THUMBONLY=y
CONFIG_CPU_THUMB_CAPABLE=y
CONFIG_CPU_32v7M=y
CONFIG_CPU_ABRT_NOMMU=y
CONFIG_CPU_PABRT_LEGACY=y
CONFIG_CPU_CACHE_NOP=y
CONFIG_CPU_CACHE_V7M=y
CONFIG_CPU_V7M_NUM_IRQ=240

#
# Processor Features
#
CONFIG_ARM_THUMB=y
CONFIG_CPU_ICACHE_DISABLE=y
CONFIG_CPU_DCACHE_DISABLE=y
CONFIG_CPU_BPREDICT_DISABLE=y
CONFIG_ARM_L1_CACHE_SHIFT=5
# CONFIG_ARM_DMA_MEM_BUFFERABLE is not set
CONFIG_SET_MEM_PARAM=y
CONFIG_DRAM_BASE=0x00800000
CONFIG_DRAM_SIZE=0x00800000
CONFIG_REMAP_VECTORS_TO_RAM=y
# CONFIG_ARM_MPU is not set
# end of System Type

#
# Bus support
#
# end of Bus support

#
# Kernel Features
#
CONFIG_IRQSTACKS=y
CONFIG_PAGE_OFFSET=0x00800000
CONFIG_ARCH_NR_GPIO=0
CONFIG_HZ_FIXED=0
# CONFIG_HZ_100 is not set
# CONFIG_HZ_200 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_500 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_THUMB2_KERNEL=y
CONFIG_AEABI=y
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_CC_HAVE_STACKPROTECTOR_TLS=y
# end of Kernel Features

#
# Boot options
#
CONFIG_USE_OF=y
# CONFIG_ATAGS is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
# CONFIG_ARM_APPENDED_DTB is not set
CONFIG_CMDLINE=""
# CONFIG_XIP_KERNEL is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y
# end of Boot options

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set

#
# ARM CPU Idle Drivers
#
# CONFIG_ARM_CPUIDLE is not set
CONFIG_ARM_CLPS711X_CPUIDLE=y
CONFIG_ARM_KIRKWOOD_CPUIDLE=y
CONFIG_ARM_ZYNQ_CPUIDLE=y
# CONFIG_ARM_AT91_CPUIDLE is not set
# CONFIG_ARM_EXYNOS_CPUIDLE is not set
CONFIG_ARM_MVEBU_V7_CPUIDLE=y
# end of ARM CPU Idle Drivers
# end of CPU Idle
# end of CPU Power Management

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
# end of Floating point emulation

#
# Power management options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_APM_EMULATION=y
CONFIG_CPU_PM=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
# end of Power management options

CONFIG_ARM_CRYPTO=y
CONFIG_CRYPTO_SHA1_ARM=y
CONFIG_CRYPTO_BLAKE2S_ARM=y
CONFIG_CRYPTO_AES_ARM=y
# CONFIG_CRYPTO_CHACHA20_NEON is not set
CONFIG_CRYPTO_POLY1305_ARM=y
CONFIG_AS_VFP_VMRS_FPINST=y

#
# General architecture-dependent options
#
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_KEEPINITRD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_LTO_NONE=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_COMPAT_32BIT_TIME is not set
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_HAVE_ARCH_PFN_VALID=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
# CONFIG_BINFMT_ELF_FDPIC is not set
CONFIG_BINFMT_SCRIPT=y
CONFIG_ARCH_HAS_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT=y
CONFIG_BINFMT_FLAT_ARGVP_ENVP_ON_STACK=y
CONFIG_BINFMT_FLAT_OLD=y
CONFIG_BINFMT_ZFLAT=y
# CONFIG_BINFMT_SHARED_FLAT is not set
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_FLATMEM=y
CONFIG_ARCH_KEEP_MEMBLOCK=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=999999
# CONFIG_PAGE_REPORTING is not set
CONFIG_NOMMU_INITIAL_TRIM_EXCESS=1
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_ZPOOL is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

# CONFIG_NET is not set

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
# CONFIG_PCCARD is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
# CONFIG_DEVTMPFS is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_DRIVER_PE_KUNIT_TEST=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_ARM_INTEGRATOR_LM=y
# CONFIG_BRCMSTB_GISB_ARB is not set
CONFIG_BT1_APB=y
CONFIG_BT1_AXI=y
CONFIG_MOXTET=y
# CONFIG_HISILICON_LPC is not set
# CONFIG_INTEL_IXP4XX_EB is not set
CONFIG_QCOM_EBI2=y
CONFIG_VEXPRESS_CONFIG=y
# CONFIG_FSL_MC_BUS is not set
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# end of Bus devices

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
CONFIG_ARM_SCMI_PROTOCOL=y
CONFIG_ARM_SCMI_HAVE_TRANSPORT=y
CONFIG_ARM_SCMI_HAVE_SHMEM=y
CONFIG_ARM_SCMI_HAVE_MSG=y
CONFIG_ARM_SCMI_TRANSPORT_MAILBOX=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_VERSION1_COMPLIANCE=y
CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y
CONFIG_ARM_SCMI_POWER_DOMAIN=y
# end of ARM System Control and Management Interface Protocol

CONFIG_ARM_SCPI_PROTOCOL=y
CONFIG_ARM_SCPI_POWER_DOMAIN=y
CONFIG_QCOM_SCM=y
CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
CONFIG_TURRIS_MOX_RWTM=y
# CONFIG_BCM47XX_NVRAM is not set
# CONFIG_GOOGLE_FIRMWARE is not set
CONFIG_IMX_DSP=y
CONFIG_IMX_SCU=y
# CONFIG_IMX_SCU_PD is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_MTD_NAND_ECC_MXIC is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
# CONFIG_OF_ALL_DTBS is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
# CONFIG_BLK_DEV is not set

#
# NVME Support
#
# CONFIG_NVME_FC is not set
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_LOOP is not set
CONFIG_NVME_TARGET_FC=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=y
CONFIG_DUMMY_IRQ=y
# CONFIG_ICS932S401 is not set
CONFIG_ATMEL_SSC=y
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_GEHC_ACHC=y
# CONFIG_HI6421V600_IRQ is not set
# CONFIG_QCOM_COINCELL is not set
CONFIG_APDS9802ALS=y
CONFIG_ISL29003=y
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
CONFIG_HISI_HIKEY_USB=y
# CONFIG_OPEN_DICE is not set
CONFIG_C2PORT=y

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_SPI is not set
CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_ECHO=y
CONFIG_MISC_RTSX_USB=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_PPA is not set
CONFIG_SCSI_IMM=y
CONFIG_SCSI_IZIP_EPP16=y
CONFIG_SCSI_IZIP_SLOW_CTR=y
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=y
# CONFIG_TCM_IBLOCK is not set
# CONFIG_TCM_FILEIO is not set
# CONFIG_TCM_PSCSI is not set
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_SBP_TARGET=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_SBP2 is not set
# end of IEEE 1394 (FireWire) support

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADP5520=y
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_CLPS711X=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_EP93XX is not set
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
# CONFIG_KEYBOARD_TCA6416 is not set
CONFIG_KEYBOARD_TCA8418=y
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
CONFIG_KEYBOARD_SNVS_PWRKEY=y
CONFIG_KEYBOARD_IMX=y
CONFIG_KEYBOARD_IMX_SC_KEY=y
CONFIG_KEYBOARD_NEWTON=y
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_PMIC8XXX=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_GOLDFISH_EVENTS=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_ST_KEYSCAN is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_SH_KEYSC=y
CONFIG_KEYBOARD_IQS62X=y
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TC3589X is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_KEYBOARD_MT6779=y
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
CONFIG_JOYSTICK_ADI=y
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
CONFIG_JOYSTICK_SPACEBALL=y
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
# CONFIG_JOYSTICK_DB9 is not set
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_WALKERA0701=y
CONFIG_JOYSTICK_PSXPAD_SPI=y
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=y
CONFIG_JOYSTICK_QWIIC=y
CONFIG_JOYSTICK_FSIA6B=y
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_ADS7846=y
CONFIG_TOUCHSCREEN_AD7877=y
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=y
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=y
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DA9052=y
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
CONFIG_TOUCHSCREEN_EETI=y
CONFIG_TOUCHSCREEN_EGALAX=y
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=y
# CONFIG_TOUCHSCREEN_FUJITSU is not set
CONFIG_TOUCHSCREEN_GOODIX=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_IPROC=y
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=y
CONFIG_TOUCHSCREEN_EKTF2127=y
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MSG2638 is not set
CONFIG_TOUCHSCREEN_MTOUCH=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_IMX6UL_TSC=y
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=y
CONFIG_TOUCHSCREEN_PENMOUNT=y
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
CONFIG_TOUCHSCREEN_RASPBERRYPI_FW=y
CONFIG_TOUCHSCREEN_MIGOR=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
CONFIG_TOUCHSCREEN_PIXCIR=y
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=y
CONFIG_TOUCHSCREEN_MXS_LRADC=y
CONFIG_TOUCHSCREEN_MX25=y
# CONFIG_TOUCHSCREEN_MC13783 is not set
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TS4800=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
# CONFIG_TOUCHSCREEN_TSC2004 is not set
CONFIG_TOUCHSCREEN_TSC2005=y
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SURFACE3_SPI=y
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
# CONFIG_TOUCHSCREEN_ZET6223 is not set
CONFIG_TOUCHSCREEN_ZFORCE=y
CONFIG_TOUCHSCREEN_ROHM_BU21023=y
CONFIG_TOUCHSCREEN_IQS5XX=y
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
# CONFIG_INPUT_AD714X_I2C is not set
CONFIG_INPUT_AD714X_SPI=y
# CONFIG_INPUT_ARIEL_PWRBUTTON is not set
# CONFIG_INPUT_ATC260X_ONKEY is not set
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
# CONFIG_INPUT_PM8941_PWRKEY is not set
# CONFIG_INPUT_PM8XXX_VIBRATOR is not set
CONFIG_INPUT_PMIC8XXX_PWRKEY=y
CONFIG_INPUT_MAX77650_ONKEY=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
CONFIG_INPUT_MAX8925_ONKEY=y
CONFIG_INPUT_MC13783_PWRBUTTON=y
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
CONFIG_INPUT_ATI_REMOTE2=y
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_RETU_PWRBUTTON is not set
# CONFIG_INPUT_TPS65218_PWRBUTTON is not set
# CONFIG_INPUT_AXP20X_PEK is not set
CONFIG_INPUT_TWL4030_PWRBUTTON=y
# CONFIG_INPUT_TWL4030_VIBRA is not set
CONFIG_INPUT_TWL6040_VIBRA=y
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
CONFIG_INPUT_PCF50633_PMU=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_PWM_BEEPER=y
CONFIG_INPUT_PWM_VIBRA=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9052_ONKEY=y
# CONFIG_INPUT_DA9055_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
# CONFIG_INPUT_ADXL34X_SPI is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
CONFIG_INPUT_IQS626A=y
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_HISI_POWERKEY is not set
CONFIG_INPUT_RAVE_SP_PWRBUTTON=y
# CONFIG_INPUT_SC27XX_VIBRA is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_AMBAKMI=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=y
CONFIG_SERIO_OLPC_APSP=y
CONFIG_SERIO_SUN4I_PS2=y
CONFIG_SERIO_GPIO_PS2=y
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_AMBA_PL010=y
# CONFIG_SERIAL_AMBA_PL010_CONSOLE is not set
# CONFIG_SERIAL_AMBA_PL011 is not set
CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST=y
# CONFIG_SERIAL_ATMEL is not set
CONFIG_SERIAL_MESON=y
CONFIG_SERIAL_MESON_CONSOLE=y
CONFIG_SERIAL_CLPS711X=y
CONFIG_SERIAL_CLPS711X_CONSOLE=y
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
# CONFIG_SERIAL_SAMSUNG_CONSOLE is not set
CONFIG_SERIAL_TEGRA=y
CONFIG_SERIAL_TEGRA_TCU=y
CONFIG_SERIAL_TEGRA_TCU_CONSOLE=y
CONFIG_SERIAL_MAX3100=y
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_IMX=y
# CONFIG_SERIAL_IMX_CONSOLE is not set
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
# CONFIG_SERIAL_SH_SCI is not set
# CONFIG_SERIAL_HS_LPC32XX is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_MSM is not set
# CONFIG_SERIAL_VT8500 is not set
CONFIG_SERIAL_OMAP=y
# CONFIG_SERIAL_OMAP_CONSOLE is not set
# CONFIG_SERIAL_SIFIVE is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_SC16IS7XX_SPI is not set
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_BCM63XX=y
# CONFIG_SERIAL_BCM63XX_CONSOLE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_MXS_AUART=y
CONFIG_SERIAL_MXS_AUART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=y
CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
# CONFIG_SERIAL_MPS2_UART is not set
# CONFIG_SERIAL_ARC is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_ST_ASC=y
# CONFIG_SERIAL_ST_ASC_CONSOLE is not set
# CONFIG_SERIAL_MEN_Z135 is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
CONFIG_SERIAL_STM32=y
# CONFIG_SERIAL_STM32_CONSOLE is not set
CONFIG_SERIAL_MVEBU_UART=y
CONFIG_SERIAL_MVEBU_CONSOLE=y
CONFIG_SERIAL_OWL=y
CONFIG_SERIAL_OWL_CONSOLE=y
CONFIG_SERIAL_RDA=y
# CONFIG_SERIAL_RDA_CONSOLE is not set
CONFIG_SERIAL_MILBEAUT_USIO=y
CONFIG_SERIAL_MILBEAUT_USIO_PORTS=4
CONFIG_SERIAL_MILBEAUT_USIO_CONSOLE=y
CONFIG_SERIAL_LITEUART=y
CONFIG_SERIAL_LITEUART_MAX_PORTS=1
# CONFIG_SERIAL_LITEUART_CONSOLE is not set
CONFIG_SERIAL_SUNPLUS=y
# CONFIG_SERIAL_SUNPLUS_CONSOLE is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_GOLDFISH_TTY is not set
CONFIG_NULL_TTY=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_DCC=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=y
# CONFIG_IPMI_SI is not set
# CONFIG_IPMI_SSIF is not set
CONFIG_IPMI_IPMB=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMI_KCS_BMC=y
CONFIG_ASPEED_KCS_IPMI_BMC=y
CONFIG_NPCM7XX_KCS_IPMI_BMC=y
CONFIG_IPMI_KCS_BMC_CDEV_IPMI=y
# CONFIG_IPMI_KCS_BMC_SERIO is not set
# CONFIG_ASPEED_BT_IPMI_BMC is not set
CONFIG_IPMB_DEVICE_INTERFACE=y
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_ATMEL is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_BCM2835=y
CONFIG_HW_RANDOM_IPROC_RNG200=y
CONFIG_HW_RANDOM_IXP4XX=y
CONFIG_HW_RANDOM_OMAP=y
CONFIG_HW_RANDOM_OMAP3_ROM=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_IMX_RNGC is not set
# CONFIG_HW_RANDOM_NOMADIK is not set
CONFIG_HW_RANDOM_STM32=y
CONFIG_HW_RANDOM_MESON=y
# CONFIG_HW_RANDOM_MTK is not set
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_NPCM=y
CONFIG_HW_RANDOM_KEYSTONE=y
CONFIG_HW_RANDOM_CCTRNG=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_DEVMEM is not set
# CONFIG_TCG_TPM is not set
CONFIG_XILLYBUS_CLASS=y
# CONFIG_XILLYBUS is not set
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_DEMUX_PINCTRL=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
# CONFIG_I2C_ALGOPCA is not set
# end of I2C Algorithms

#
# I2C Hardware Bus support
#
# CONFIG_I2C_HIX5HD2 is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_ALTERA is not set
CONFIG_I2C_ASPEED=y
CONFIG_I2C_AT91=y
CONFIG_I2C_AT91_SLAVE_EXPERIMENTAL=y
CONFIG_I2C_AXXIA=y
CONFIG_I2C_BCM2835=y
# CONFIG_I2C_BCM_IPROC is not set
CONFIG_I2C_BCM_KONA=y
# CONFIG_I2C_BRCMSTB is not set
CONFIG_I2C_CADENCE=y
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DAVINCI=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DIGICOLOR=y
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_HIGHLANDER=y
CONFIG_I2C_HISI=y
# CONFIG_I2C_IMG is not set
CONFIG_I2C_IMX=y
CONFIG_I2C_IMX_LPI2C=y
# CONFIG_I2C_IOP3XX is not set
# CONFIG_I2C_JZ4780 is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_LPC2K=y
CONFIG_I2C_MESON=y
CONFIG_I2C_MT65XX=y
# CONFIG_I2C_MT7621 is not set
CONFIG_I2C_MV64XXX=y
CONFIG_I2C_MXS=y
CONFIG_I2C_NOMADIK=y
CONFIG_I2C_NPCM7XX=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=y
# CONFIG_I2C_OWL is not set
# CONFIG_I2C_APPLE is not set
# CONFIG_I2C_PCA_PLATFORM is not set
CONFIG_I2C_PNX=y
CONFIG_I2C_PXA=y
# CONFIG_I2C_PXA_SLAVE is not set
CONFIG_I2C_QCOM_CCI=y
# CONFIG_I2C_QUP is not set
# CONFIG_I2C_RIIC is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_S3C2410=y
CONFIG_I2C_SH_MOBILE=y
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_SPRD is not set
CONFIG_I2C_ST=y
CONFIG_I2C_STM32F4=y
CONFIG_I2C_STM32F7=y
CONFIG_I2C_SUN6I_P2WI=y
# CONFIG_I2C_SYNQUACER is not set
CONFIG_I2C_TEGRA=y
# CONFIG_I2C_TEGRA_BPMP is not set
CONFIG_I2C_UNIPHIER=y
CONFIG_I2C_UNIPHIER_F=y
CONFIG_I2C_VERSATILE=y
CONFIG_I2C_WMT=y
CONFIG_I2C_XILINX=y
CONFIG_I2C_XLP9XX=y
CONFIG_I2C_RCAR=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
# CONFIG_I2C_FSI is not set
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
CONFIG_SPI_AR934X=y
CONFIG_SPI_ATH79=y
# CONFIG_SPI_ARMADA_3700 is not set
CONFIG_SPI_ATMEL=y
CONFIG_SPI_AT91_USART=y
# CONFIG_SPI_ATMEL_QUADSPI is not set
CONFIG_SPI_AXI_SPI_ENGINE=y
CONFIG_SPI_BCM2835=y
# CONFIG_SPI_BCM2835AUX is not set
CONFIG_SPI_BCM63XX=y
CONFIG_SPI_BCM63XX_HSSPI=y
# CONFIG_SPI_BCM_QSPI is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
# CONFIG_SPI_CADENCE_QUADSPI is not set
CONFIG_SPI_CLPS711X=y
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_DMA is not set
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DW_BT1 is not set
# CONFIG_SPI_DLN2 is not set
# CONFIG_SPI_EP93XX is not set
# CONFIG_SPI_FSI is not set
CONFIG_SPI_FSL_LPSPI=y
# CONFIG_SPI_FSL_QUADSPI is not set
# CONFIG_SPI_HISI_KUNPENG is not set
CONFIG_SPI_HISI_SFC_V3XX=y
CONFIG_SPI_NXP_FLEXSPI=y
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_IMG_SPFI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_INGENIC=y
CONFIG_SPI_JCORE=y
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_LP8841_RTC is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_FSL_DSPI=y
CONFIG_SPI_MESON_SPICC=y
CONFIG_SPI_MESON_SPIFC=y
CONFIG_SPI_MT65XX=y
CONFIG_SPI_MT7621=y
# CONFIG_SPI_MTK_NOR is not set
# CONFIG_SPI_NPCM_FIU is not set
CONFIG_SPI_NPCM_PSPI=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_OMAP_UWIRE=y
CONFIG_SPI_OMAP24XX=y
CONFIG_SPI_TI_QSPI=y
# CONFIG_SPI_OMAP_100K is not set
CONFIG_SPI_ORION=y
# CONFIG_SPI_PIC32 is not set
# CONFIG_SPI_PIC32_SQI is not set
CONFIG_SPI_PL022=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_ROCKCHIP_SFC=y
CONFIG_SPI_RSPI=y
# CONFIG_SPI_QUP is not set
# CONFIG_SPI_S3C64XX is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SH_MSIOF=y
CONFIG_SPI_SH=y
CONFIG_SPI_SH_HSPI=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_SPRD=y
CONFIG_SPI_SPRD_ADI=y
CONFIG_SPI_STM32=y
CONFIG_SPI_ST_SSC4=y
CONFIG_SPI_SUN4I=y
# CONFIG_SPI_SUN6I is not set
CONFIG_SPI_SUNPLUS_SP7021=y
CONFIG_SPI_SYNQUACER=y
CONFIG_SPI_MXIC=y
CONFIG_SPI_TEGRA210_QUAD=y
CONFIG_SPI_TEGRA114=y
CONFIG_SPI_TEGRA20_SFLASH=y
CONFIG_SPI_TEGRA20_SLINK=y
CONFIG_SPI_UNIPHIER=y
CONFIG_SPI_XCOMM=y
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_XLP=y
CONFIG_SPI_XTENSA_XTFPGA=y
# CONFIG_SPI_ZYNQ_QSPI is not set
CONFIG_SPI_ZYNQMP_GQSPI=y
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
CONFIG_SPMI_MSM_PMIC_ARB=y
CONFIG_SPMI_MTK_PMIF=y
# CONFIG_HSI is not set
CONFIG_PPS=y
CONFIG_PPS_DEBUG=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_AS3722=y
CONFIG_PINCTRL_AT91=y
CONFIG_PINCTRL_AT91PIO4=y
# CONFIG_PINCTRL_AXP209 is not set
CONFIG_PINCTRL_BM1880=y
CONFIG_PINCTRL_DA850_PUPD=y
# CONFIG_PINCTRL_EQUILIBRIUM is not set
# CONFIG_PINCTRL_INGENIC is not set
# CONFIG_PINCTRL_LPC18XX is not set
# CONFIG_PINCTRL_MAX77620 is not set
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
# CONFIG_PINCTRL_OCELOT is not set
CONFIG_PINCTRL_PALMAS=y
CONFIG_PINCTRL_PISTACHIO=y
CONFIG_PINCTRL_ROCKCHIP=y
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STARFIVE is not set
# CONFIG_PINCTRL_STMFX is not set
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_OWL is not set
# CONFIG_PINCTRL_ASPEED_G4 is not set
# CONFIG_PINCTRL_ASPEED_G5 is not set
# CONFIG_PINCTRL_ASPEED_G6 is not set
# CONFIG_PINCTRL_BCM281XX is not set
CONFIG_PINCTRL_BCM2835=y
CONFIG_PINCTRL_BCM4908=y
CONFIG_PINCTRL_BCM63XX=y
CONFIG_PINCTRL_BCM6318=y
# CONFIG_PINCTRL_BCM6328 is not set
CONFIG_PINCTRL_BCM6358=y
# CONFIG_PINCTRL_BCM6362 is not set
# CONFIG_PINCTRL_BCM6368 is not set
# CONFIG_PINCTRL_BCM63268 is not set
CONFIG_PINCTRL_IPROC_GPIO=y
# CONFIG_PINCTRL_CYGNUS_MUX is not set
# CONFIG_PINCTRL_NS is not set
CONFIG_PINCTRL_NSP_GPIO=y
# CONFIG_PINCTRL_NS2_MUX is not set
# CONFIG_PINCTRL_NSP_MUX is not set
CONFIG_PINCTRL_BERLIN=y
# CONFIG_PINCTRL_AS370 is not set
CONFIG_PINCTRL_BERLIN_BG4CT=y
# CONFIG_PINCTRL_LOCHNAGAR is not set

#
# Intel pinctrl drivers
#
# end of Intel pinctrl drivers

#
# MediaTek pinctrl drivers
#
CONFIG_EINT_MTK=y
CONFIG_PINCTRL_MTK=y
CONFIG_PINCTRL_MTK_V2=y
CONFIG_PINCTRL_MTK_MOORE=y
CONFIG_PINCTRL_MTK_PARIS=y
# CONFIG_PINCTRL_MT2701 is not set
CONFIG_PINCTRL_MT7623=y
CONFIG_PINCTRL_MT7629=y
# CONFIG_PINCTRL_MT8135 is not set
# CONFIG_PINCTRL_MT8127 is not set
# CONFIG_PINCTRL_MT2712 is not set
CONFIG_PINCTRL_MT6765=y
CONFIG_PINCTRL_MT6779=y
# CONFIG_PINCTRL_MT6797 is not set
CONFIG_PINCTRL_MT7622=y
# CONFIG_PINCTRL_MT7986 is not set
CONFIG_PINCTRL_MT8167=y
CONFIG_PINCTRL_MT8173=y
# CONFIG_PINCTRL_MT8183 is not set
CONFIG_PINCTRL_MT8186=y
# CONFIG_PINCTRL_MT8192 is not set
# CONFIG_PINCTRL_MT8195 is not set
CONFIG_PINCTRL_MT8365=y
CONFIG_PINCTRL_MT8516=y
# CONFIG_PINCTRL_MT6397 is not set
# end of MediaTek pinctrl drivers

CONFIG_PINCTRL_WPCM450=y
# CONFIG_PINCTRL_NPCM7XX is not set
# CONFIG_PINCTRL_PXA25X is not set
# CONFIG_PINCTRL_PXA27X is not set
CONFIG_PINCTRL_MSM=y
CONFIG_PINCTRL_APQ8064=y
CONFIG_PINCTRL_APQ8084=y
CONFIG_PINCTRL_IPQ4019=y
CONFIG_PINCTRL_IPQ8064=y
CONFIG_PINCTRL_IPQ8074=y
CONFIG_PINCTRL_IPQ6018=y
# CONFIG_PINCTRL_MSM8226 is not set
CONFIG_PINCTRL_MSM8660=y
# CONFIG_PINCTRL_MSM8960 is not set
# CONFIG_PINCTRL_MDM9607 is not set
CONFIG_PINCTRL_MDM9615=y
CONFIG_PINCTRL_MSM8X74=y
CONFIG_PINCTRL_MSM8916=y
CONFIG_PINCTRL_MSM8953=y
# CONFIG_PINCTRL_MSM8976 is not set
CONFIG_PINCTRL_MSM8994=y
CONFIG_PINCTRL_MSM8996=y
CONFIG_PINCTRL_MSM8998=y
# CONFIG_PINCTRL_QCM2290 is not set
# CONFIG_PINCTRL_QCS404 is not set
CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
CONFIG_PINCTRL_SC7180=y
# CONFIG_PINCTRL_SC7280 is not set
# CONFIG_PINCTRL_SC8180X is not set
CONFIG_PINCTRL_SC8280XP=y
CONFIG_PINCTRL_SDM660=y
CONFIG_PINCTRL_SDM845=y
CONFIG_PINCTRL_SDX55=y
CONFIG_PINCTRL_SM6115=y
CONFIG_PINCTRL_SM6125=y
# CONFIG_PINCTRL_SM6350 is not set
# CONFIG_PINCTRL_SDX65 is not set
CONFIG_PINCTRL_SM8150=y
CONFIG_PINCTRL_SM8250=y
CONFIG_PINCTRL_SM8350=y
CONFIG_PINCTRL_SM8450=y
# CONFIG_PINCTRL_LPASS_LPI is not set

#
# Renesas pinctrl drivers
#
CONFIG_PINCTRL_RENESAS=y
CONFIG_PINCTRL_SH_PFC=y
CONFIG_PINCTRL_SH_PFC_GPIO=y
CONFIG_PINCTRL_SH_FUNC_GPIO=y
# CONFIG_PINCTRL_PFC_EMEV2 is not set
# CONFIG_PINCTRL_PFC_R8A77995 is not set
CONFIG_PINCTRL_PFC_R8A7794=y
# CONFIG_PINCTRL_PFC_R8A77990 is not set
CONFIG_PINCTRL_PFC_R8A7779=y
# CONFIG_PINCTRL_PFC_R8A7790 is not set
# CONFIG_PINCTRL_PFC_R8A77950 is not set
CONFIG_PINCTRL_PFC_R8A77951=y
# CONFIG_PINCTRL_PFC_R8A7778 is not set
CONFIG_PINCTRL_PFC_R8A7793=y
CONFIG_PINCTRL_PFC_R8A7791=y
CONFIG_PINCTRL_PFC_R8A77965=y
CONFIG_PINCTRL_PFC_R8A77960=y
CONFIG_PINCTRL_PFC_R8A77961=y
CONFIG_PINCTRL_PFC_R8A779F0=y
CONFIG_PINCTRL_PFC_R8A7792=y
CONFIG_PINCTRL_PFC_R8A77980=y
# CONFIG_PINCTRL_PFC_R8A77970 is not set
CONFIG_PINCTRL_PFC_R8A779A0=y
# CONFIG_PINCTRL_PFC_R8A7740 is not set
# CONFIG_PINCTRL_PFC_R8A73A4 is not set
# CONFIG_PINCTRL_RZA1 is not set
# CONFIG_PINCTRL_RZA2 is not set
# CONFIG_PINCTRL_RZG2L is not set
# CONFIG_PINCTRL_PFC_R8A77470 is not set
CONFIG_PINCTRL_PFC_R8A7745=y
# CONFIG_PINCTRL_PFC_R8A7742 is not set
# CONFIG_PINCTRL_PFC_R8A7743 is not set
CONFIG_PINCTRL_PFC_R8A7744=y
CONFIG_PINCTRL_PFC_R8A774C0=y
# CONFIG_PINCTRL_PFC_R8A774E1 is not set
CONFIG_PINCTRL_PFC_R8A774A1=y
CONFIG_PINCTRL_PFC_R8A774B1=y
CONFIG_PINCTRL_RZN1=y
# CONFIG_PINCTRL_PFC_SH7203 is not set
CONFIG_PINCTRL_PFC_SH7264=y
# CONFIG_PINCTRL_PFC_SH7269 is not set
CONFIG_PINCTRL_PFC_SH7720=y
# CONFIG_PINCTRL_PFC_SH7722 is not set
CONFIG_PINCTRL_PFC_SH7734=y
CONFIG_PINCTRL_PFC_SH7757=y
CONFIG_PINCTRL_PFC_SH7785=y
CONFIG_PINCTRL_PFC_SH7786=y
CONFIG_PINCTRL_PFC_SH73A0=y
CONFIG_PINCTRL_PFC_SH7723=y
CONFIG_PINCTRL_PFC_SH7724=y
# CONFIG_PINCTRL_PFC_SHX3 is not set
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS_ARM=y
# CONFIG_PINCTRL_EXYNOS_ARM64 is not set
# CONFIG_PINCTRL_S3C24XX is not set
# CONFIG_PINCTRL_S3C64XX is not set
CONFIG_PINCTRL_SPRD=y
CONFIG_PINCTRL_SPRD_SC9860=y
CONFIG_PINCTRL_STM32=y
CONFIG_PINCTRL_STM32F429=y
CONFIG_PINCTRL_STM32F469=y
# CONFIG_PINCTRL_STM32F746 is not set
CONFIG_PINCTRL_STM32F769=y
CONFIG_PINCTRL_STM32H743=y
# CONFIG_PINCTRL_STM32MP135 is not set
# CONFIG_PINCTRL_STM32MP157 is not set
# CONFIG_PINCTRL_TI_IODELAY is not set
# CONFIG_PINCTRL_UNIPHIER is not set
CONFIG_PINCTRL_VISCONTI=y
CONFIG_PINCTRL_TMPV7700=y
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_REGMAP=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_ASPEED=y
# CONFIG_GPIO_ASPEED_SGPIO is not set
# CONFIG_GPIO_ATH79 is not set
CONFIG_GPIO_RASPBERRYPI_EXP=y
# CONFIG_GPIO_BCM_KONA is not set
# CONFIG_GPIO_BCM_XGS_IPROC is not set
CONFIG_GPIO_BRCMSTB=y
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_CLPS711X is not set
# CONFIG_GPIO_DWAPB is not set
CONFIG_GPIO_EIC_SPRD=y
CONFIG_GPIO_EM=y
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HISI is not set
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_IOP=y
CONFIG_GPIO_LOGICVC=y
# CONFIG_GPIO_LPC18XX is not set
CONFIG_GPIO_LPC32XX=y
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MPC8XXX=y
# CONFIG_GPIO_MT7621 is not set
CONFIG_GPIO_MXC=y
# CONFIG_GPIO_MXS is not set
# CONFIG_GPIO_OMAP is not set
CONFIG_GPIO_PL061=y
CONFIG_GPIO_PMIC_EIC_SPRD=y
# CONFIG_GPIO_PXA is not set
CONFIG_GPIO_RCAR=y
# CONFIG_GPIO_RDA is not set
# CONFIG_GPIO_ROCKCHIP is not set
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SNPS_CREG=y
CONFIG_GPIO_SPRD=y
CONFIG_GPIO_STP_XWAY=y
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_TEGRA=y
CONFIG_GPIO_TEGRA186=y
CONFIG_GPIO_TS4800=y
# CONFIG_GPIO_UNIPHIER is not set
CONFIG_GPIO_VISCONTI=y
CONFIG_GPIO_WCD934X=y
CONFIG_GPIO_XGENE_SB=y
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_XLP is not set
# CONFIG_GPIO_ZEVIO is not set
CONFIG_GPIO_AMD_FCH=y
CONFIG_GPIO_IDT3243X=y
# end of Memory mapped GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCA9570=y
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y
# CONFIG_GPIO_TS4900 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=y
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD71815 is not set
# CONFIG_GPIO_BD71828 is not set
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DA9055 is not set
# CONFIG_GPIO_DLN2 is not set
CONFIG_HTC_EGPIO=y
CONFIG_GPIO_KEMPLD=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
CONFIG_GPIO_MAX77620=y
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_SL28CPLD is not set
CONFIG_GPIO_TC3589X=y
# CONFIG_GPIO_TPS65218 is not set
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
# CONFIG_GPIO_TPS65912 is not set
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_TWL6040=y
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8350 is not set
# end of MFD GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
CONFIG_GPIO_MOXTET=y
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
CONFIG_GPIO_SIM=y
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_MXC=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_APM_POWER is not set
CONFIG_IP5XXX_POWER=y
# CONFIG_MAX8925_POWER is not set
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
CONFIG_TEST_POWER=y
# CONFIG_CHARGER_ADP5061 is not set
CONFIG_BATTERY_ACT8945A=y
CONFIG_BATTERY_CW2015=y
# CONFIG_BATTERY_DS2760 is not set
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_CHARGER_ISP1704 is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
CONFIG_CHARGER_LTC4162L=y
# CONFIG_CHARGER_MAX14577 is not set
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MAX77976=y
CONFIG_CHARGER_MT6360=y
CONFIG_CHARGER_QCOM_SMBB=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_SC2731=y
CONFIG_CHARGER_UCS1002=y
CONFIG_CHARGER_BD99954=y
CONFIG_BATTERY_UG3105=y
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE=y
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CPU_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=y
CONFIG_HISI_THERMAL=y
# CONFIG_IMX_THERMAL is not set
CONFIG_IMX_SC_THERMAL=y
CONFIG_IMX8MM_THERMAL=y
CONFIG_K3_THERMAL=y
# CONFIG_MAX77620_THERMAL is not set
CONFIG_QORIQ_THERMAL=y
CONFIG_SPEAR_THERMAL=y
# CONFIG_SUN8I_THERMAL is not set
CONFIG_ROCKCHIP_THERMAL=y
CONFIG_RCAR_THERMAL=y
CONFIG_RCAR_GEN3_THERMAL=y
CONFIG_RZG2L_THERMAL=y
CONFIG_KIRKWOOD_THERMAL=y
CONFIG_DOVE_THERMAL=y
# CONFIG_ARMADA_THERMAL is not set
CONFIG_DA9062_THERMAL=y
# CONFIG_MTK_THERMAL is not set

#
# Intel thermal drivers
#

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers
# end of Intel thermal drivers

#
# Broadcom thermal drivers
#
CONFIG_BCM2711_THERMAL=y
CONFIG_BCM2835_THERMAL=y
CONFIG_BRCMSTB_THERMAL=y
CONFIG_BCM_NS_THERMAL=y
CONFIG_BCM_SR_THERMAL=y
# end of Broadcom thermal drivers

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set
# end of Texas Instruments thermal drivers

#
# Samsung thermal drivers
#
CONFIG_EXYNOS_THERMAL=y
# end of Samsung thermal drivers

#
# NVIDIA Tegra thermal drivers
#
CONFIG_TEGRA_SOCTHERM=y
CONFIG_TEGRA_BPMP_THERMAL=y
CONFIG_TEGRA30_TSENSOR=y
# end of NVIDIA Tegra thermal drivers

#
# Qualcomm thermal drivers
#
CONFIG_QCOM_TSENS=y
# end of Qualcomm thermal drivers

CONFIG_UNIPHIER_THERMAL=y
# CONFIG_SPRD_THERMAL is not set
# CONFIG_KHADAS_MCU_FAN_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_BD957XMUF_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_GPIO_WATCHDOG=y
CONFIG_GPIO_WATCHDOG_ARCH_INITCALL=y
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_SL28CPLD_WATCHDOG=y
CONFIG_ARM_SP805_WATCHDOG=y
CONFIG_ARMADA_37XX_WATCHDOG=y
CONFIG_ASM9260_WATCHDOG=y
CONFIG_AT91RM9200_WATCHDOG=y
# CONFIG_AT91SAM9X_WATCHDOG is not set
# CONFIG_SAMA5D4_WATCHDOG is not set
CONFIG_CADENCE_WATCHDOG=y
# CONFIG_977_WATCHDOG is not set
CONFIG_FTWDT010_WATCHDOG=y
# CONFIG_S3C2410_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_EP93XX_WATCHDOG=y
CONFIG_OMAP_WATCHDOG=y
CONFIG_PNX4008_WATCHDOG=y
CONFIG_DAVINCI_WATCHDOG=y
CONFIG_K3_RTI_WATCHDOG=y
CONFIG_ORION_WATCHDOG=y
# CONFIG_RN5T618_WATCHDOG is not set
# CONFIG_SUNXI_WATCHDOG is not set
# CONFIG_NPCM7XX_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
CONFIG_STMP3XXX_RTC_WATCHDOG=y
CONFIG_TS4800_WATCHDOG=y
CONFIG_TS72XX_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_MAX77620_WATCHDOG=y
CONFIG_IMX2_WDT=y
CONFIG_IMX7ULP_WDT=y
# CONFIG_RETU_WATCHDOG is not set
CONFIG_MOXART_WDT=y
CONFIG_ST_LPC_WATCHDOG=y
CONFIG_TEGRA_WATCHDOG=y
CONFIG_QCOM_WDT=y
# CONFIG_MESON_GXBB_WATCHDOG is not set
CONFIG_MESON_WATCHDOG=y
CONFIG_MEDIATEK_WATCHDOG=y
CONFIG_DIGICOLOR_WATCHDOG=y
CONFIG_LPC18XX_WATCHDOG=y
CONFIG_RENESAS_WDT=y
CONFIG_RENESAS_RZAWDT=y
CONFIG_RENESAS_RZG2LWDT=y
# CONFIG_ASPEED_WATCHDOG is not set
CONFIG_UNIPHIER_WATCHDOG=y
# CONFIG_RTD119X_WATCHDOG is not set
CONFIG_REALTEK_OTTO_WDT=y
CONFIG_SPRD_WATCHDOG=y
# CONFIG_PM8916_WATCHDOG is not set
CONFIG_VISCONTI_WATCHDOG=y
CONFIG_MSC313E_WATCHDOG=y
CONFIG_APPLE_WATCHDOG=y
CONFIG_SC520_WDT=y
# CONFIG_KEMPLD_WDT is not set
# CONFIG_ATH79_WDT is not set
CONFIG_BCM47XX_WDT=y
CONFIG_BCM2835_WDT=y
# CONFIG_BCM_KONA_WDT is not set
CONFIG_BCM7038_WDT=y
CONFIG_IMGPDC_WDT=y
CONFIG_MPC5200_WDT=y
CONFIG_MEN_A21_WDT=y
CONFIG_UML_WATCHDOG=y

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_MIPS=y
CONFIG_BCMA_PFLASH=y
CONFIG_BCMA_NFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_SUN4I_GPADC=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_AT91_USART=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_MADERA is not set
CONFIG_MFD_ASIC3=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_ENE_KB3930 is not set
CONFIG_MFD_EXYNOS_LPASS=y
# CONFIG_MFD_GATEWORKS_GSC is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_MP2629=y
CONFIG_MFD_MXS_LRADC=y
CONFIG_MFD_MX25_TSADC=y
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_MFD_HI6421_SPMI is not set
# CONFIG_MFD_HI655X_PMIC is not set
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77620=y
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77714=y
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_NTXEC is not set
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_PM8XXX=y
CONFIG_MFD_SPMI_PMIC=y
CONFIG_MFD_RT4831=y
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=y
# CONFIG_MFD_SL28CPLD is not set
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SC27XX_PMIC=y
CONFIG_ABX500_CORE=y
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SUN6I_PRCM is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_TWL4030_CORE=y
# CONFIG_TWL4030_POWER is not set
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TC3589X=y
CONFIG_MFD_TMIO=y
CONFIG_MFD_T7L66XB=y
# CONFIG_MFD_TC6387XB is not set
# CONFIG_MFD_TC6393XB is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_LOCHNAGAR=y
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_STW481X is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_ROHM_BD71828=y
CONFIG_MFD_ROHM_BD957XMUF=y
CONFIG_MFD_STM32_LPTIMER=y
CONFIG_MFD_STM32_TIMERS=y
# CONFIG_MFD_STPMIC1 is not set
CONFIG_MFD_STMFX=y
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_KHADAS_MCU=y
# CONFIG_MFD_ACER_A500_EC is not set
CONFIG_MFD_QCOM_PM8008=y
CONFIG_MFD_VEXPRESS_SYSREG=y
CONFIG_RAVE_SP_CORE=y
CONFIG_MFD_INTEL_M10_BMC=y
# CONFIG_MFD_RSMU_I2C is not set
CONFIG_MFD_RSMU_SPI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_ARM_SCMI is not set
CONFIG_REGULATOR_AS3711=y
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AXP20X=y
# CONFIG_REGULATOR_BCM590XX is not set
# CONFIG_REGULATOR_BD71815 is not set
# CONFIG_REGULATOR_BD71828 is not set
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD957XMUF=y
CONFIG_REGULATOR_CPCAP=y
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
CONFIG_REGULATOR_DA9121=y
# CONFIG_REGULATOR_DA9210 is not set
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_FAN53880 is not set
# CONFIG_REGULATOR_GPIO is not set
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LOCHNAGAR=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
# CONFIG_REGULATOR_LP8788 is not set
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
# CONFIG_REGULATOR_MAX77650 is not set
# CONFIG_REGULATOR_MAX8649 is not set
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
CONFIG_REGULATOR_MAX8907=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
CONFIG_REGULATOR_MAX20086=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
# CONFIG_REGULATOR_MAX77802 is not set
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MP5416=y
# CONFIG_REGULATOR_MP8859 is not set
# CONFIG_REGULATOR_MP886X is not set
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=y
CONFIG_REGULATOR_MT6360=y
CONFIG_REGULATOR_MT6380=y
CONFIG_REGULATOR_PALMAS=y
# CONFIG_REGULATOR_PBIAS is not set
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
# CONFIG_REGULATOR_PF8X00 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_RPMH is not set
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_ROHM=y
CONFIG_REGULATOR_RT4801=y
CONFIG_REGULATOR_RT4831=y
CONFIG_REGULATOR_RT5190A=y
CONFIG_REGULATOR_RT6160=y
CONFIG_REGULATOR_RT6245=y
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
# CONFIG_REGULATOR_S5M8767 is not set
# CONFIG_REGULATOR_SC2731 is not set
# CONFIG_REGULATOR_SKY81452 is not set
CONFIG_REGULATOR_SLG51000=y
# CONFIG_REGULATOR_STM32_BOOSTER is not set
CONFIG_REGULATOR_STM32_VREFBUF=y
CONFIG_REGULATOR_STM32_PWR=y
CONFIG_REGULATOR_TI_ABB=y
# CONFIG_REGULATOR_STW481X_VMMC is not set
CONFIG_REGULATOR_SY7636A=y
CONFIG_REGULATOR_SY8106A=y
# CONFIG_REGULATOR_SY8824X is not set
CONFIG_REGULATOR_SY8827N=y
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS6105X is not set
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS6286X=y
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_TPS68470=y
CONFIG_REGULATOR_TWL4030=y
CONFIG_REGULATOR_UNIPHIER=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_VEXPRESS=y
CONFIG_REGULATOR_WM831X=y
# CONFIG_REGULATOR_WM8350 is not set
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_QCOM_LABIBB=y
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
# CONFIG_RC_DECODERS is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=y
CONFIG_IR_FINTEK=y
# CONFIG_IR_GPIO_CIR is not set
CONFIG_IR_HIX5HD2=y
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
CONFIG_IR_IMON=y
CONFIG_IR_IMON_RAW=y
CONFIG_IR_ITE_CIR=y
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_MESON is not set
CONFIG_IR_MESON_TX=y
# CONFIG_IR_MTK is not set
CONFIG_IR_NUVOTON=y
CONFIG_IR_REDRAT3=y
CONFIG_IR_RX51=y
CONFIG_IR_SERIAL=y
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_SUNXI=y
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_ST is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_IR_IMG=y
# CONFIG_IR_IMG_RAW is not set
CONFIG_IR_IMG_HW=y
# CONFIG_IR_IMG_NEC is not set
# CONFIG_IR_IMG_JVC is not set
CONFIG_IR_IMG_SONY=y
# CONFIG_IR_IMG_SHARP is not set
# CONFIG_IR_IMG_SANYO is not set
CONFIG_IR_IMG_RC5=y
CONFIG_IR_IMG_RC6=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
CONFIG_DVB_MMAP=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
CONFIG_DVB_ULE_DEBUG=y
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=y
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_VIDEO_IR_I2C=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_SONY_BTF_MPX=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
CONFIG_VIDEO_ADV7183=y
# CONFIG_VIDEO_ADV748X is not set
# CONFIG_VIDEO_ADV7604 is not set
CONFIG_VIDEO_ADV7842=y
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
CONFIG_VIDEO_ISL7998X=y
CONFIG_VIDEO_KS0127=y
CONFIG_VIDEO_MAX9286=y
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=y
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_AD9389B=y
CONFIG_VIDEO_ADV7170=y
CONFIG_VIDEO_ADV7175=y
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
CONFIG_VIDEO_ADV7511=y
# CONFIG_VIDEO_ADV7511_CEC is not set
CONFIG_VIDEO_AK881X=y
CONFIG_VIDEO_SAA7127=y
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=y
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=y
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=y
# CONFIG_VIDEO_THS7303 is not set
# end of Miscellaneous helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_VIDEO_GS1662=y
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC0011 is not set
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_IT913X=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_MC44S803=y
CONFIG_MEDIA_TUNER_MSI001=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_MT2266 is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_MXL5005S is not set
# CONFIG_MEDIA_TUNER_MXL5007T is not set
CONFIG_MEDIA_TUNER_QM1D1B0004=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=y
CONFIG_MEDIA_TUNER_SI2157=y
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18212=y
# CONFIG_MEDIA_TUNER_TDA18218 is not set
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_TUA9001=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC4000=y
# CONFIG_MEDIA_TUNER_XC5000 is not set
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_M88DS3103=y
# CONFIG_DVB_MXL5XX is not set
# CONFIG_DVB_STB0899 is not set
CONFIG_DVB_STB6100=y
# CONFIG_DVB_STV090x is not set
CONFIG_DVB_STV0910=y
# CONFIG_DVB_STV6110x is not set
CONFIG_DVB_STV6111=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
# CONFIG_DVB_MN88472 is not set
CONFIG_DVB_MN88473=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_TDA18271C2DD=y

#
# DVB-S (satellite) frontends
#
# CONFIG_DVB_CX24110 is not set
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_CX24120=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_MB86A16=y
CONFIG_DVB_MT312=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_SI21XX=y
CONFIG_DVB_STB6000=y
# CONFIG_DVB_STV0288 is not set
CONFIG_DVB_STV0299=y
# CONFIG_DVB_STV0900 is not set
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8083=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_TUNER_CX24113=y
# CONFIG_DVB_TUNER_ITD1000 is not set
CONFIG_DVB_VES1X93=y
# CONFIG_DVB_ZL10036 is not set
CONFIG_DVB_ZL10039=y

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_AF9013=y
CONFIG_DVB_CX22700=y
CONFIG_DVB_CX22702=y
CONFIG_DVB_CXD2820R=y
CONFIG_DVB_CXD2841ER=y
# CONFIG_DVB_DIB3000MB is not set
CONFIG_DVB_DIB3000MC=y
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
# CONFIG_DVB_DRXD is not set
CONFIG_DVB_EC100=y
CONFIG_DVB_L64781=y
CONFIG_DVB_MT352=y
CONFIG_DVB_NXT6000=y
# CONFIG_DVB_RTL2830 is not set
CONFIG_DVB_RTL2832=y
# CONFIG_DVB_RTL2832_SDR is not set
CONFIG_DVB_S5H1432=y
# CONFIG_DVB_SI2168 is not set
CONFIG_DVB_SP887X=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_ZL10353 is not set
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_STV0297 is not set
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_VES1820=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_AU8522=y
# CONFIG_DVB_AU8522_DTV is not set
CONFIG_DVB_AU8522_V4L=y
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LG2160 is not set
# CONFIG_DVB_LGDT3305 is not set
CONFIG_DVB_LGDT3306A=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_MXL692=y
CONFIG_DVB_NXT200X=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_OR51211 is not set
# CONFIG_DVB_S5H1409 is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_DIB8000=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_S921=y

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_MN88443X=y
CONFIG_DVB_TC90522=y

#
# Digital terrestrial only tuners/PLL
#
# CONFIG_DVB_PLL is not set
# CONFIG_DVB_TUNER_DIB0070 is not set
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
# CONFIG_DVB_A8293 is not set
# CONFIG_DVB_AF9033 is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_HELENE=y
CONFIG_DVB_HORUS3A=y
CONFIG_DVB_ISL6405=y
CONFIG_DVB_ISL6421=y
CONFIG_DVB_ISL6423=y
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_LGS8GL5=y
# CONFIG_DVB_LGS8GXX is not set
# CONFIG_DVB_LNBH25 is not set
CONFIG_DVB_LNBH29=y
# CONFIG_DVB_LNBP21 is not set
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_M88RS2000 is not set
CONFIG_DVB_TDA665x=y
CONFIG_DVB_DRX39XYJ=y

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_TEGRA_HOST1X=y
# CONFIG_TEGRA_HOST1X_FIREWALL is not set
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_BUS=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_GEM_CMA_HELPER=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_HDLCD is not set
# CONFIG_DRM_MALI_DISPLAY is not set
CONFIG_DRM_KOMEDA=y
# end of ARM devices

CONFIG_DRM_KMB_DISPLAY=y
# CONFIG_DRM_ATMEL_HLCDC is not set
# CONFIG_DRM_RCAR_DU is not set
# CONFIG_DRM_RCAR_DW_HDMI is not set
CONFIG_DRM_RCAR_USE_LVDS=y
# CONFIG_DRM_RCAR_MIPI_DSI is not set
CONFIG_DRM_SHMOBILE=y
# CONFIG_DRM_SUN4I is not set
CONFIG_DRM_TILCDC=y
CONFIG_DRM_FSL_DCU=y
CONFIG_DRM_TEGRA=y
CONFIG_DRM_TEGRA_DEBUG=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ABT_Y030XX067A=y
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0=y
CONFIG_DRM_PANEL_BOE_HIMAX8279D=y
CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=y
CONFIG_DRM_PANEL_DSI_CM=y
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_ELIDA_KD35T133=y
CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02=y
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
# CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
# CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_EJ030NA=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
# CONFIG_DRM_PANEL_JDI_R63452 is not set
CONFIG_DRM_PANEL_KHADAS_TS050=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
# CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LB035Q02 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_NEC_NL8048HL11=y
CONFIG_DRM_PANEL_NOVATEK_NT35510=y
CONFIG_DRM_PANEL_NOVATEK_NT35560=y
# CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
# CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
CONFIG_DRM_PANEL_NOVATEK_NT39016=y
CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_RAYDIUM_RM67191=y
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6D27A1=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_SPI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0_DSI=y
CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SAMSUNG_SOFEF00=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SHARP_LS060T1SX01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
# CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_PANEL_SONY_ACX565AKM=y
# CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
CONFIG_DRM_PANEL_TDO_TL070WSH30=y
CONFIG_DRM_PANEL_TPO_TD028TTEC1=y
CONFIG_DRM_PANEL_TPO_TD043MTEA1=y
# CONFIG_DRM_PANEL_TPO_TPG110 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
CONFIG_DRM_PANEL_XINPENG_XPP055C272=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_CHIPONE_ICN6211=y
CONFIG_DRM_CHRONTEL_CH7033=y
CONFIG_DRM_CROS_EC_ANX7688=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
# CONFIG_DRM_ITE_IT6505 is not set
# CONFIG_DRM_LONTIUM_LT8912B is not set
CONFIG_DRM_LONTIUM_LT9611=y
CONFIG_DRM_LONTIUM_LT9611UXC=y
CONFIG_DRM_ITE_IT66121=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NWL_MIPI_DSI=y
CONFIG_DRM_NXP_PTN3460=y
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_PARADE_PS8640=y
CONFIG_DRM_SIL_SII8620=y
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_SIMPLE_BRIDGE=y
# CONFIG_DRM_THINE_THC63LVD1024 is not set
CONFIG_DRM_TOSHIBA_TC358762=y
CONFIG_DRM_TOSHIBA_TC358764=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TOSHIBA_TC358768=y
CONFIG_DRM_TOSHIBA_TC358775=y
# CONFIG_DRM_TI_TFP410 is not set
CONFIG_DRM_TI_SN65DSI83=y
# CONFIG_DRM_TI_SN65DSI86 is not set
# CONFIG_DRM_TI_TPD12S015 is not set
CONFIG_DRM_ANALOGIX_ANX6345=y
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
CONFIG_DRM_ANALOGIX_ANX7625=y
CONFIG_DRM_I2C_ADV7511=y
# CONFIG_DRM_I2C_ADV7511_CEC is not set
CONFIG_DRM_CDNS_MHDP8546=y
CONFIG_DRM_CDNS_MHDP8546_J721E=y
# end of Display Interface Bridges

CONFIG_DRM_IMX=y
CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
# CONFIG_DRM_IMX_TVE is not set
CONFIG_DRM_IMX_LDB=y
# CONFIG_DRM_IMX_HDMI is not set
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_MESON=y
# CONFIG_DRM_MESON_DW_HDMI is not set
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_PANEL_MIPI_DBI=y
CONFIG_TINYDRM_HX8357D=y
CONFIG_TINYDRM_ILI9163=y
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
# CONFIG_TINYDRM_MI0283QT is not set
CONFIG_TINYDRM_REPAPER=y
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
CONFIG_DRM_PL111=y
# CONFIG_DRM_TIDSS is not set
# CONFIG_DRM_SSD130X is not set
CONFIG_DRM_SPRD=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_CFB_REV_PIXELS_IN_BYTE=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_MACMODES=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
CONFIG_FB_ARMCLCD=y
CONFIG_FB_CLPS711X=y
CONFIG_FB_IMX=y
CONFIG_FB_ARC=y
CONFIG_FB_CONTROL=y
CONFIG_FB_GBE=y
CONFIG_FB_GBE_MEM=4
CONFIG_FB_PVR2=y
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_ATMEL=y
# CONFIG_FB_WM8505 is not set
CONFIG_FB_PXA168=y
CONFIG_FB_W100=y
CONFIG_FB_SH_MOBILE_LCDC=y
# CONFIG_FB_TMIO is not set
CONFIG_FB_S3C=y
# CONFIG_FB_S3C_DEBUG_REGWRITE is not set
CONFIG_FB_SMSCUFX=y
CONFIG_FB_UDL=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_GOLDFISH=y
CONFIG_FB_DA8XX=y
CONFIG_FB_VIRTUAL=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_BROADSHEET is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_OMAP=y
CONFIG_FB_OMAP_LCDC_EXTERNAL=y
CONFIG_FB_OMAP_LCDC_HWA742=y
CONFIG_FB_OMAP_MANUAL_UPDATE=y
# CONFIG_FB_OMAP_LCD_MIPID is not set
# CONFIG_FB_OMAP_DMA_TUNE is not set
CONFIG_FB_OMAP2=y
CONFIG_FB_OMAP2_DEBUG_SUPPORT=y
CONFIG_FB_OMAP2_NUM_FBS=3
CONFIG_FB_OMAP2_DSS_INIT=y
CONFIG_FB_OMAP2_DSS=y
# CONFIG_FB_OMAP2_DSS_DEBUG is not set
CONFIG_FB_OMAP2_DSS_DEBUGFS=y
# CONFIG_FB_OMAP2_DSS_COLLECT_IRQ_STATS is not set
CONFIG_FB_OMAP2_DSS_DPI=y
# CONFIG_FB_OMAP2_DSS_VENC is not set
# CONFIG_FB_OMAP4_DSS_HDMI is not set
# CONFIG_FB_OMAP5_DSS_HDMI is not set
CONFIG_FB_OMAP2_DSS_SDI=y
# CONFIG_FB_OMAP2_DSS_DSI is not set
CONFIG_FB_OMAP2_DSS_MIN_FCK_PER_PCK=0
CONFIG_FB_OMAP2_DSS_SLEEP_AFTER_VENC_RESET=y

#
# OMAPFB Panel and Encoder Drivers
#
CONFIG_FB_OMAP2_ENCODER_OPA362=y
CONFIG_FB_OMAP2_ENCODER_TFP410=y
CONFIG_FB_OMAP2_ENCODER_TPD12S015=y
# CONFIG_FB_OMAP2_CONNECTOR_DVI is not set
# CONFIG_FB_OMAP2_CONNECTOR_HDMI is not set
CONFIG_FB_OMAP2_CONNECTOR_ANALOG_TV=y
CONFIG_FB_OMAP2_PANEL_DPI=y
CONFIG_FB_OMAP2_PANEL_LGPHILIPS_LB035Q02=y
# end of OMAPFB Panel and Encoder Drivers

CONFIG_MMP_DISP=y
# CONFIG_MMP_DISP_CONTROLLER is not set
# CONFIG_MMP_PANEL_TPOHVGA is not set
# CONFIG_MMP_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
CONFIG_LCD_LTV350QV=y
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
CONFIG_LCD_PLATFORM=y
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_ATMEL_LCDC is not set
CONFIG_BACKLIGHT_KTD253=y
CONFIG_BACKLIGHT_LM3533=y
CONFIG_BACKLIGHT_OMAP1=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
CONFIG_BACKLIGHT_QCOM_WLED=y
CONFIG_BACKLIGHT_RT4831=y
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_PCF50633 is not set
CONFIG_BACKLIGHT_LM3630A=y
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_LP8788 is not set
CONFIG_BACKLIGHT_PANDORA=y
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=y
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_BACKLIGHT_RAVE_SP=y
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=y
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=y
# CONFIG_HID_BELKIN is not set
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELAN=y
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_FT260=y
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_VIVALDI_COMMON=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_XIAOMI=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LETSKETCH=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=y
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PLAYSTATION=y
# CONFIG_PLAYSTATION_FF is not set
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=y
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SIGMAMICRO is not set
CONFIG_HID_SONY=y
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
CONFIG_HID_WACOM=y
# CONFIG_HID_WIIMOTE is not set
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
# CONFIG_HID_ALPS is not set
CONFIG_HID_MCP2221=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_OF is not set
# CONFIG_I2C_HID_OF_GOODIX is not set
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_USB_CONN_GPIO=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_BRCMSTB is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_NPCM7XX=y
CONFIG_USB_EHCI_HCD_ORION=y
CONFIG_USB_EHCI_HCD_SPEAR=y
CONFIG_USB_EHCI_HCD_STI=y
CONFIG_USB_EHCI_HCD_AT91=y
CONFIG_USB_EHCI_SH=y
CONFIG_USB_EHCI_EXYNOS=y
CONFIG_USB_EHCI_MV=y
CONFIG_USB_CNS3XXX_EHCI=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
CONFIG_USB_ISP1362_HCD=y
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_RENESAS_USBHS_HCD=y
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y
CONFIG_USB_RENESAS_USBHS=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_MICROTEK=y
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=y
CONFIG_USB_CDNS3_GADGET=y
CONFIG_USB_CDNS3_HOST=y
# CONFIG_USB_CDNS3_TI is not set
CONFIG_USB_CDNS3_IMX=y
CONFIG_USB_MTU3=y
CONFIG_USB_MTU3_HOST=y
# CONFIG_USB_MTU3_GADGET is not set
# CONFIG_USB_MTU3_DUAL_ROLE is not set
CONFIG_USB_MTU3_DEBUG=y
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
CONFIG_USB_CHIPIDEA=y
# CONFIG_USB_CHIPIDEA_UDC is not set
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_CHIPIDEA_MSM=y
CONFIG_USB_CHIPIDEA_IMX=y
CONFIG_USB_CHIPIDEA_GENERIC=y
CONFIG_USB_CHIPIDEA_TEGRA=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_QCOM_EUD=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=y
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=y
CONFIG_BRCM_USB_PINMAP=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_KEYSTONE_USB_PHY=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_AM335X_CONTROL_USB=y
CONFIG_AM335X_PHY_USB=y
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# CONFIG_USB_TEGRA_PHY is not set
CONFIG_USB_ULPI=y
CONFIG_USB_ULPI_VIEWPORT=y
CONFIG_JZ4770_PHY=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
# CONFIG_USB_AT91 is not set
# CONFIG_USB_LPC32XX is not set
# CONFIG_USB_ATMEL_USBA is not set
CONFIG_USB_FUSB300=y
CONFIG_USB_FOTG210_UDC=y
# CONFIG_USB_GR_UDC is not set
CONFIG_USB_R8A66597=y
CONFIG_USB_RENESAS_USBHS_UDC=y
CONFIG_USB_RENESAS_USB3=y
CONFIG_USB_PXA27X=y
CONFIG_USB_MV_UDC=y
CONFIG_USB_MV_U3D=y
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_NET2272 is not set
CONFIG_USB_GADGET_XILINX=y
# CONFIG_USB_MAX3420_UDC is not set
# CONFIG_USB_ASPEED_VHUB is not set
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_F_TCM=y
# CONFIG_USB_CONFIGFS is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=y
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=y
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=y
CONFIG_USB_GADGET_TARGET=y
CONFIG_USB_G_SERIAL=y
CONFIG_USB_G_PRINTER=y
CONFIG_USB_G_ACM_MS=y
# CONFIG_USB_G_HID is not set
CONFIG_USB_G_DBGP=y
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
# CONFIG_USB_G_WEBCAM is not set
CONFIG_USB_RAW_GADGET=y
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=y
CONFIG_TYPEC_TCPCI=y
CONFIG_TYPEC_RT1711H=y
CONFIG_TYPEC_MT6360=y
CONFIG_TYPEC_TCPCI_MAXIM=y
# CONFIG_TYPEC_FUSB302 is not set
CONFIG_TYPEC_UCSI=y
CONFIG_UCSI_CCG=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
CONFIG_TYPEC_HD3SS3220=y
CONFIG_TYPEC_STUSB160X=y
CONFIG_TYPEC_QCOM_PMIC=y
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y
# CONFIG_MMC_CRYPTO is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_ARMMMCI=y
# CONFIG_MMC_STM32_SDMMC is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_OF_ARASAN=y
CONFIG_MMC_SDHCI_OF_ASPEED=y
CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
# CONFIG_MMC_SDHCI_OF_AT91 is not set
# CONFIG_MMC_SDHCI_OF_ESDHC is not set
# CONFIG_MMC_SDHCI_OF_DWCMSHC is not set
CONFIG_MMC_SDHCI_OF_SPARX5=y
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_CNS3XXX=y
# CONFIG_MMC_SDHCI_ESDHC_IMX is not set
CONFIG_MMC_SDHCI_DOVE=y
# CONFIG_MMC_SDHCI_TEGRA is not set
# CONFIG_MMC_SDHCI_S3C is not set
CONFIG_MMC_SDHCI_PXAV3=y
CONFIG_MMC_SDHCI_PXAV2=y
CONFIG_MMC_SDHCI_SPEAR=y
# CONFIG_MMC_SDHCI_BCM_KONA is not set
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_SDHCI_MILBEAUT=y
CONFIG_MMC_SDHCI_IPROC=y
# CONFIG_MMC_MESON_GX is not set
# CONFIG_MMC_MESON_MX_SDHC is not set
CONFIG_MMC_MESON_MX_SDIO=y
CONFIG_MMC_MOXART=y
CONFIG_MMC_SDHCI_ST=y
# CONFIG_MMC_OMAP_HS is not set
CONFIG_MMC_ATMELMCI=y
# CONFIG_MMC_SDHCI_MSM is not set
# CONFIG_MMC_MVSDIO is not set
CONFIG_MMC_DAVINCI=y
CONFIG_MMC_SPI=y
CONFIG_MMC_S3C=y
CONFIG_MMC_S3C_HW_SDIO_IRQ=y
# CONFIG_MMC_S3C_PIO is not set
CONFIG_MMC_S3C_DMA=y
CONFIG_MMC_SDHCI_SPRD=y
CONFIG_MMC_TMIO_CORE=y
CONFIG_MMC_TMIO=y
# CONFIG_MMC_SDHI is not set
CONFIG_MMC_UNIPHIER=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_PLTFM=y
# CONFIG_MMC_DW_BLUEFIELD is not set
CONFIG_MMC_DW_EXYNOS=y
CONFIG_MMC_DW_HI3798CV200=y
CONFIG_MMC_DW_K3=y
CONFIG_MMC_SH_MMCIF=y
CONFIG_MMC_VUB300=y
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_USB=y
CONFIG_MMC_SUNXI=y
CONFIG_MMC_CQHCI=y
CONFIG_MMC_HSQ=y
# CONFIG_MMC_BCM2835 is not set
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MMC_SDHCI_AM654=y
# CONFIG_MMC_OWL is not set
CONFIG_MMC_LITEX=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_ARIEL is not set
CONFIG_LEDS_AW2013=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_CPCAP=y
CONFIG_LEDS_CR0014114=y
CONFIG_LEDS_EL15203000=y
CONFIG_LEDS_TURRIS_OMNIA=y
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
CONFIG_LEDS_S3C24XX=y
# CONFIG_LEDS_COBALT_QUBE is not set
# CONFIG_LEDS_COBALT_RAQ is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
# CONFIG_LEDS_LP8788 is not set
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=y
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA9052=y
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=y
CONFIG_LEDS_REGULATOR=y
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=y
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_NS2=y
# CONFIG_LEDS_NETXBIG is not set
# CONFIG_LEDS_ASIC3 is not set
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_OT200=y
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=y
CONFIG_LEDS_IS31FL32XX=y
CONFIG_LEDS_SC27XX_BLTC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_PM8058=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_SPI_BYTE is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM3697 is not set
CONFIG_LEDS_LM36274=y
# CONFIG_LEDS_TPS6105X is not set
# CONFIG_LEDS_IP30 is not set
CONFIG_LEDS_LGM=y

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MT6360=y
CONFIG_LEDS_RT4505=y
CONFIG_LEDS_RT8515=y
CONFIG_LEDS_SGM3140=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=y
# CONFIG_LEDS_TRIGGER_GPIO is not set
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
# CONFIG_LEDS_TRIGGER_AUDIO is not set
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SERIALIO=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=y
CONFIG_SPEAKUP_SYNTH_ACNTPC=y
# CONFIG_SPEAKUP_SYNTH_APOLLO is not set
CONFIG_SPEAKUP_SYNTH_AUDPTR=y
CONFIG_SPEAKUP_SYNTH_BNS=y
# CONFIG_SPEAKUP_SYNTH_DECTLK is not set
# CONFIG_SPEAKUP_SYNTH_DECEXT is not set
# CONFIG_SPEAKUP_SYNTH_DTLK is not set
# CONFIG_SPEAKUP_SYNTH_KEYPC is not set
# CONFIG_SPEAKUP_SYNTH_LTLK is not set
CONFIG_SPEAKUP_SYNTH_SOFT=y
CONFIG_SPEAKUP_SYNTH_SPKOUT=y
CONFIG_SPEAKUP_SYNTH_TXPRT=y
CONFIG_SPEAKUP_SYNTH_DUMMY=y
# end of Speakup console speech

CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_LIB_KUNIT_TEST=y
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_RTC_INTF_PROC is not set
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_BRCMSTB=y
CONFIG_RTC_DRV_AS3722=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_LP8788 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8925 is not set
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_RS5C372=y
# CONFIG_RTC_DRV_ISL1208 is not set
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BD70528=y
CONFIG_RTC_DRV_BQ32K=y
# CONFIG_RTC_DRV_TWL4030 is not set
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS65910=y
CONFIG_RTC_DRV_RC5T583=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV3032 is not set
CONFIG_RTC_DRV_RV8803=y
CONFIG_RTC_DRV_S5M=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=y
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_RX6110=y

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
CONFIG_RTC_DRV_DA9063=y
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
CONFIG_RTC_DRV_GAMECUBE=y
CONFIG_RTC_DRV_WM831X=y
# CONFIG_RTC_DRV_WM8350 is not set
CONFIG_RTC_DRV_SC27XX=y
# CONFIG_RTC_DRV_SPEAR is not set
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_ASM9260=y
CONFIG_RTC_DRV_DAVINCI=y
# CONFIG_RTC_DRV_DIGICOLOR is not set
# CONFIG_RTC_DRV_FSL_FTM_ALARM is not set
# CONFIG_RTC_DRV_MESON is not set
CONFIG_RTC_DRV_MESON_VRTC=y
# CONFIG_RTC_DRV_OMAP is not set
# CONFIG_RTC_DRV_S3C is not set
CONFIG_RTC_DRV_EP93XX=y
# CONFIG_RTC_DRV_VR41XX is not set
CONFIG_RTC_DRV_PL030=y
CONFIG_RTC_DRV_PL031=y
CONFIG_RTC_DRV_AT91RM9200=y
CONFIG_RTC_DRV_AT91SAM9=y
CONFIG_RTC_DRV_GENERIC=y
CONFIG_RTC_DRV_VT8500=y
# CONFIG_RTC_DRV_SUN6I is not set
CONFIG_RTC_DRV_SUNXI=y
CONFIG_RTC_DRV_MV=y
CONFIG_RTC_DRV_ARMADA38X=y
CONFIG_RTC_DRV_CADENCE=y
# CONFIG_RTC_DRV_FTRTC010 is not set
CONFIG_RTC_DRV_STMP=y
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_JZ4740=y
# CONFIG_RTC_DRV_LPC24XX is not set
CONFIG_RTC_DRV_LPC32XX=y
# CONFIG_RTC_DRV_PM8XXX is not set
# CONFIG_RTC_DRV_TEGRA is not set
# CONFIG_RTC_DRV_MXC is not set
# CONFIG_RTC_DRV_MXC_V2 is not set
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MOXART=y
# CONFIG_RTC_DRV_MT2712 is not set
# CONFIG_RTC_DRV_MT6397 is not set
# CONFIG_RTC_DRV_MT7622 is not set
CONFIG_RTC_DRV_XGENE=y
# CONFIG_RTC_DRV_R7301 is not set
# CONFIG_RTC_DRV_STM32 is not set
CONFIG_RTC_DRV_CPCAP=y
CONFIG_RTC_DRV_RTD119X=y
# CONFIG_RTC_DRV_ASPEED is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
# CONFIG_RTC_DRV_MSC313 is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
CONFIG_DMABUF_SELFTESTS=y
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
# CONFIG_LCD2S is not set
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=y
CONFIG_VFIO=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PLATFORM=y
CONFIG_VFIO_AMBA=y
CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET=y
CONFIG_VFIO_PLATFORM_AMDXGBE_RESET=y
CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET=y
CONFIG_VFIO_MDEV=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_SCSI=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=y
CONFIG_COMEDI_PARPORT=y
CONFIG_COMEDI_SSV_DNP=y
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
CONFIG_COMEDI_NI_USB6501=y
CONFIG_COMEDI_USBDUX=y
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_TESTS=y
CONFIG_COMEDI_TESTS_EXAMPLE=y
# CONFIG_COMEDI_TESTS_NI_ROUTES is not set
# CONFIG_STAGING is not set
CONFIG_GOLDFISH=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CROS_EC is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_OLPC_XO175=y
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_WM831X is not set

#
# Clock driver for ARM Reference designs
#
CONFIG_CLK_ICST=y
CONFIG_CLK_SP810=y
CONFIG_CLK_VEXPRESS_OSC=y
# end of Clock driver for ARM Reference designs

# CONFIG_CLK_HSDK is not set
CONFIG_LMK04832=y
# CONFIG_COMMON_CLK_APPLE_NCO is not set
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SCMI=y
CONFIG_COMMON_CLK_SCPI=y
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_BM1880 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_TPS68470=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_FSL_FLEXSPI=y
# CONFIG_COMMON_CLK_FSL_SAI is not set
CONFIG_COMMON_CLK_GEMINI=y
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_ASPEED is not set
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_CLK_TWL6040=y
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
# CONFIG_CLK_QORIQ is not set
CONFIG_CLK_LS1028A_PLLDIG=y
CONFIG_COMMON_CLK_XGENE=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
CONFIG_COMMON_CLK_NXP=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_OXNAS=y
# CONFIG_COMMON_CLK_RS9_PCIE is not set
CONFIG_COMMON_CLK_VC5=y
# CONFIG_COMMON_CLK_MMP2_AUDIO is not set
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
# CONFIG_CLK_ACTIONS is not set
CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC=y
CONFIG_CLK_BAIKAL_T1=y
# CONFIG_CLK_BT1_CCU_PLL is not set
CONFIG_CLK_BT1_CCU_DIV=y
CONFIG_CLK_BCM2711_DVP=y
# CONFIG_CLK_BCM2835 is not set
CONFIG_CLK_BCM_63XX=y
# CONFIG_CLK_BCM_63XX_GATE is not set
# CONFIG_CLK_BCM_KONA is not set
CONFIG_COMMON_CLK_IPROC=y
# CONFIG_CLK_BCM_CYGNUS is not set
CONFIG_CLK_BCM_HR2=y
# CONFIG_CLK_BCM_NSP is not set
CONFIG_CLK_BCM_NS2=y
# CONFIG_CLK_BCM_SR is not set
CONFIG_CLK_RASPBERRYPI=y
CONFIG_COMMON_CLK_HI3516CV300=y
# CONFIG_COMMON_CLK_HI3519 is not set
# CONFIG_COMMON_CLK_HI3559A is not set
CONFIG_COMMON_CLK_HI3660=y
# CONFIG_COMMON_CLK_HI3670 is not set
CONFIG_COMMON_CLK_HI3798CV200=y
# CONFIG_COMMON_CLK_HI6220 is not set
CONFIG_RESET_HISI=y
CONFIG_STUB_CLK_HI3660=y
CONFIG_COMMON_CLK_BOSTON=y
CONFIG_MXC_CLK=y
# CONFIG_CLK_IMX8MM is not set
CONFIG_CLK_IMX8MN=y
CONFIG_CLK_IMX8MP=y
# CONFIG_CLK_IMX8MQ is not set
# CONFIG_CLK_IMX8ULP is not set
# CONFIG_CLK_IMX93 is not set

#
# Ingenic SoCs drivers
#
CONFIG_INGENIC_CGU_COMMON=y
# CONFIG_INGENIC_CGU_JZ4740 is not set
# CONFIG_INGENIC_CGU_JZ4725B is not set
# CONFIG_INGENIC_CGU_JZ4760 is not set
CONFIG_INGENIC_CGU_JZ4770=y
CONFIG_INGENIC_CGU_JZ4780=y
CONFIG_INGENIC_CGU_X1000=y
# CONFIG_INGENIC_CGU_X1830 is not set
CONFIG_INGENIC_TCU_CLK=y
# end of Ingenic SoCs drivers

CONFIG_COMMON_CLK_KEYSTONE=y
# CONFIG_TI_SYSCON_CLK is not set

#
# Clock driver for MediaTek SoC
#
CONFIG_COMMON_CLK_MEDIATEK=y
# CONFIG_COMMON_CLK_MT2701 is not set
CONFIG_COMMON_CLK_MT2712=y
CONFIG_COMMON_CLK_MT2712_BDPSYS=y
CONFIG_COMMON_CLK_MT2712_IMGSYS=y
# CONFIG_COMMON_CLK_MT2712_JPGDECSYS is not set
# CONFIG_COMMON_CLK_MT2712_MFGCFG is not set
CONFIG_COMMON_CLK_MT2712_MMSYS=y
# CONFIG_COMMON_CLK_MT2712_VDECSYS is not set
CONFIG_COMMON_CLK_MT2712_VENCSYS=y
CONFIG_COMMON_CLK_MT6765=y
CONFIG_COMMON_CLK_MT6765_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT6765_CAMSYS is not set
CONFIG_COMMON_CLK_MT6765_GCESYS=y
# CONFIG_COMMON_CLK_MT6765_MMSYS is not set
CONFIG_COMMON_CLK_MT6765_IMGSYS=y
# CONFIG_COMMON_CLK_MT6765_VCODECSYS is not set
CONFIG_COMMON_CLK_MT6765_MFGSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI0ASYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI0BSYS is not set
# CONFIG_COMMON_CLK_MT6765_MIPI1ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI1BSYS=y
# CONFIG_COMMON_CLK_MT6765_MIPI2ASYS is not set
CONFIG_COMMON_CLK_MT6765_MIPI2BSYS=y
# CONFIG_COMMON_CLK_MT6779 is not set
CONFIG_COMMON_CLK_MT6797=y
# CONFIG_COMMON_CLK_MT6797_MMSYS is not set
# CONFIG_COMMON_CLK_MT6797_IMGSYS is not set
# CONFIG_COMMON_CLK_MT6797_VDECSYS is not set
CONFIG_COMMON_CLK_MT6797_VENCSYS=y
CONFIG_COMMON_CLK_MT7622=y
CONFIG_COMMON_CLK_MT7622_ETHSYS=y
# CONFIG_COMMON_CLK_MT7622_HIFSYS is not set
CONFIG_COMMON_CLK_MT7622_AUDSYS=y
# CONFIG_COMMON_CLK_MT7629 is not set
# CONFIG_COMMON_CLK_MT7986 is not set
CONFIG_COMMON_CLK_MT8135=y
# CONFIG_COMMON_CLK_MT8167 is not set
CONFIG_COMMON_CLK_MT8173=y
CONFIG_COMMON_CLK_MT8173_MMSYS=y
CONFIG_COMMON_CLK_MT8183=y
CONFIG_COMMON_CLK_MT8183_AUDIOSYS=y
# CONFIG_COMMON_CLK_MT8183_CAMSYS is not set
CONFIG_COMMON_CLK_MT8183_IMGSYS=y
# CONFIG_COMMON_CLK_MT8183_IPU_CORE0 is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CORE1 is not set
# CONFIG_COMMON_CLK_MT8183_IPU_ADL is not set
# CONFIG_COMMON_CLK_MT8183_IPU_CONN is not set
CONFIG_COMMON_CLK_MT8183_MFGCFG=y
CONFIG_COMMON_CLK_MT8183_MMSYS=y
CONFIG_COMMON_CLK_MT8183_VDECSYS=y
# CONFIG_COMMON_CLK_MT8183_VENCSYS is not set
CONFIG_COMMON_CLK_MT8192=y
CONFIG_COMMON_CLK_MT8192_AUDSYS=y
# CONFIG_COMMON_CLK_MT8192_CAMSYS is not set
CONFIG_COMMON_CLK_MT8192_IMGSYS=y
CONFIG_COMMON_CLK_MT8192_IMP_IIC_WRAP=y
# CONFIG_COMMON_CLK_MT8192_IPESYS is not set
# CONFIG_COMMON_CLK_MT8192_MDPSYS is not set
# CONFIG_COMMON_CLK_MT8192_MFGCFG is not set
CONFIG_COMMON_CLK_MT8192_MMSYS=y
CONFIG_COMMON_CLK_MT8192_MSDC=y
CONFIG_COMMON_CLK_MT8192_SCP_ADSP=y
# CONFIG_COMMON_CLK_MT8192_VDECSYS is not set
# CONFIG_COMMON_CLK_MT8192_VENCSYS is not set
# CONFIG_COMMON_CLK_MT8195 is not set
CONFIG_COMMON_CLK_MT8516=y
# CONFIG_COMMON_CLK_MT8516_AUDSYS is not set
# end of Clock driver for MediaTek SoC

#
# Clock support for Amlogic platforms
#
# CONFIG_COMMON_CLK_MESON8B is not set
# end of Clock support for Amlogic platforms

# CONFIG_MSTAR_MSC313_MPLL is not set
# CONFIG_MCHP_CLK_MPFS is not set
# CONFIG_COMMON_CLK_PISTACHIO is not set
# CONFIG_COMMON_CLK_QCOM is not set
# CONFIG_CLK_MT7621 is not set
# CONFIG_CLK_RENESAS is not set
CONFIG_COMMON_CLK_SAMSUNG=y
CONFIG_S3C64XX_COMMON_CLK=y
# CONFIG_S5PV210_COMMON_CLK is not set
# CONFIG_EXYNOS_3250_COMMON_CLK is not set
CONFIG_EXYNOS_4_COMMON_CLK=y
# CONFIG_EXYNOS_5250_COMMON_CLK is not set
CONFIG_EXYNOS_5260_COMMON_CLK=y
# CONFIG_EXYNOS_5410_COMMON_CLK is not set
# CONFIG_EXYNOS_5420_COMMON_CLK is not set
CONFIG_EXYNOS_ARM64_COMMON_CLK=y
# CONFIG_EXYNOS_AUDSS_CLK_CON is not set
CONFIG_EXYNOS_CLKOUT=y
# CONFIG_S3C2410_COMMON_CLK is not set
CONFIG_S3C2412_COMMON_CLK=y
# CONFIG_S3C2443_COMMON_CLK is not set
# CONFIG_TESLA_FSD_COMMON_CLK is not set
CONFIG_CLK_SIFIVE=y
CONFIG_CLK_SIFIVE_PRCI=y
# CONFIG_CLK_INTEL_SOCFPGA is not set
# CONFIG_SPRD_COMMON_CLK is not set
CONFIG_CLK_STARFIVE_JH7100=y
CONFIG_CLK_STARFIVE_JH7100_AUDIO=y
CONFIG_CLK_SUNXI=y
# CONFIG_CLK_SUNXI_CLOCKS is not set
# CONFIG_CLK_SUNXI_PRCM_SUN6I is not set
# CONFIG_CLK_SUNXI_PRCM_SUN8I is not set
# CONFIG_CLK_SUNXI_PRCM_SUN9I is not set
CONFIG_SUNXI_CCU=y
CONFIG_SUNIV_F1C100S_CCU=y
CONFIG_SUN20I_D1_CCU=y
# CONFIG_SUN20I_D1_R_CCU is not set
# CONFIG_SUN50I_A64_CCU is not set
CONFIG_SUN50I_A100_CCU=y
# CONFIG_SUN50I_A100_R_CCU is not set
# CONFIG_SUN50I_H6_CCU is not set
CONFIG_SUN50I_H616_CCU=y
# CONFIG_SUN50I_H6_R_CCU is not set
CONFIG_SUN4I_A10_CCU=y
# CONFIG_SUN5I_CCU is not set
# CONFIG_SUN6I_A31_CCU is not set
CONFIG_SUN6I_RTC_CCU=y
CONFIG_SUN8I_A23_CCU=y
CONFIG_SUN8I_A33_CCU=y
CONFIG_SUN8I_A83T_CCU=y
CONFIG_SUN8I_H3_CCU=y
CONFIG_SUN8I_V3S_CCU=y
CONFIG_SUN8I_DE2_CCU=y
CONFIG_SUN8I_R40_CCU=y
CONFIG_SUN9I_A80_CCU=y
CONFIG_SUN8I_R_CCU=y
CONFIG_COMMON_CLK_TI_ADPLL=y
CONFIG_CLK_UNIPHIER=y
# CONFIG_COMMON_CLK_VISCONTI is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=y
# CONFIG_COMMON_CLK_ZYNQMP is not set
CONFIG_CLK_KUNIT_TEST=y
CONFIG_CLK_GATE_KUNIT_TEST=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKSRC_MMIO=y
# CONFIG_BCM2835_TIMER is not set
CONFIG_BCM_KONA_TIMER=y
# CONFIG_DAVINCI_TIMER is not set
CONFIG_DIGICOLOR_TIMER=y
# CONFIG_DW_APB_TIMER is not set
# CONFIG_FTTMR010_TIMER is not set
CONFIG_IXP4XX_TIMER=y
CONFIG_ROCKCHIP_TIMER=y
# CONFIG_ARMADA_370_XP_TIMER is not set
# CONFIG_MESON6_TIMER is not set
CONFIG_ORION_TIMER=y
# CONFIG_OWL_TIMER is not set
# CONFIG_RDA_TIMER is not set
CONFIG_SUN4I_TIMER=y
# CONFIG_SUN5I_HSTIMER is not set
# CONFIG_TEGRA_TIMER is not set
CONFIG_VT8500_TIMER=y
# CONFIG_NPCM7XX_TIMER is not set
CONFIG_CADENCE_TTC_TIMER=y
CONFIG_ASM9260_TIMER=y
# CONFIG_CLKSRC_NOMADIK_MTU is not set
# CONFIG_CLKSRC_DBX500_PRCMU is not set
# CONFIG_CLPS711X_TIMER is not set
# CONFIG_MXS_TIMER is not set
# CONFIG_NSPIRE_TIMER is not set
CONFIG_KEYSTONE_TIMER=y
CONFIG_INTEGRATOR_AP_TIMER=y
CONFIG_CLKSRC_LPC32XX=y
CONFIG_CLKSRC_PISTACHIO=y
CONFIG_CLKSRC_TI_32K=y
# CONFIG_CLKSRC_STM32 is not set
CONFIG_CLKSRC_STM32_LP=y
CONFIG_CLKSRC_MPS2=y
CONFIG_ARC_TIMERS=y
# CONFIG_ARC_TIMERS_64BIT is not set
CONFIG_ARM_GLOBAL_TIMER=y
CONFIG_ARM_GT_INITIAL_PRESCALER_VAL=1
# CONFIG_ARM_TIMER_SP804 is not set
CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK=y
CONFIG_ARMV7M_SYSTICK=y
# CONFIG_ATMEL_PIT is not set
CONFIG_ATMEL_ST=y
CONFIG_ATMEL_TCB_CLKSRC=y
# CONFIG_CLKSRC_EXYNOS_MCT is not set
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_FSL_FTM_TIMER is not set
# CONFIG_OXNAS_RPS_TIMER is not set
# CONFIG_MTK_TIMER is not set
CONFIG_CLKSRC_JCORE_PIT=y
# CONFIG_SH_TIMER_CMT is not set
CONFIG_SH_TIMER_MTU2=y
# CONFIG_RENESAS_OSTM is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_CLKSRC_QCOM is not set
# CONFIG_CLKSRC_VERSATILE is not set
CONFIG_CLKSRC_PXA=y
# CONFIG_H8300_TMR8 is not set
# CONFIG_H8300_TMR16 is not set
# CONFIG_H8300_TPU is not set
CONFIG_CLKSRC_IMX_GPT=y
CONFIG_CLKSRC_IMX_TPM=y
# CONFIG_TIMER_IMX_SYS_CTR is not set
# CONFIG_CLKSRC_ST_LPC is not set
# CONFIG_MILBEAUT_TIMER is not set
# CONFIG_MSC313E_TIMER is not set
CONFIG_INGENIC_TIMER=y
CONFIG_INGENIC_SYSOST=y
# CONFIG_INGENIC_OST is not set
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_ARM_MHU=y
CONFIG_ARM_MHU_V2=y
CONFIG_IMX_MBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PL320_MBOX is not set
CONFIG_ARMADA_37XX_RWTM_MBOX=y
# CONFIG_ROCKCHIP_MBOX is not set
CONFIG_ALTERA_MBOX=y
CONFIG_MAILBOX_TEST=y
CONFIG_POLARFIRE_SOC_MAILBOX=y
CONFIG_QCOM_APCS_IPC=y
CONFIG_BCM_PDC_MBOX=y
CONFIG_STM32_IPCC=y
# CONFIG_MTK_ADSP_MBOX is not set
# CONFIG_MTK_CMDQ_MBOX is not set
CONFIG_SUN6I_MSGBOX=y
CONFIG_SPRD_MBOX=y
# CONFIG_QCOM_IPCC is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# CONFIG_INGENIC_VPU_RPROC is not set
# CONFIG_MTK_SCP is not set
CONFIG_MESON_MX_AO_ARC_REMOTEPROC=y
CONFIG_RCAR_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
CONFIG_MESON_CANVAS=y
# CONFIG_MESON_CLK_MEASURE is not set
CONFIG_MESON_GX_SOCINFO=y
# CONFIG_MESON_MX_SOCINFO is not set
# end of Amlogic SoC drivers

#
# Apple SoC drivers
#
# end of Apple SoC drivers

#
# ASPEED SoC drivers
#
# CONFIG_ASPEED_LPC_CTRL is not set
CONFIG_ASPEED_LPC_SNOOP=y
# CONFIG_ASPEED_UART_ROUTING is not set
# CONFIG_ASPEED_P2A_CTRL is not set
CONFIG_ASPEED_SOCINFO=y
# end of ASPEED SoC drivers

# CONFIG_AT91_SOC_ID is not set
CONFIG_AT91_SOC_SFR=y

#
# Broadcom SoC drivers
#
# CONFIG_BCM2835_POWER is not set
# CONFIG_SOC_BCM63XX is not set
# CONFIG_SOC_BRCMSTB is not set
# CONFIG_BCM_PMB is not set
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# CONFIG_QUICC_ENGINE is not set
# CONFIG_DPAA2_CONSOLE is not set
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
CONFIG_SOC_IMX8M=y
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
CONFIG_IXP4XX_NPE=y
# end of IXP4xx SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# MediaTek SoC drivers
#
# CONFIG_MTK_CMDQ is not set
CONFIG_MTK_DEVAPC=y
CONFIG_MTK_INFRACFG=y
CONFIG_MTK_PMIC_WRAP=y
# CONFIG_MTK_SCPSYS is not set
# CONFIG_MTK_MMSYS is not set
# end of MediaTek SoC drivers

CONFIG_POLARFIRE_SOC_SYS_CTRL=y

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_COMMAND_DB=y
# CONFIG_QCOM_GENI_SE is not set
CONFIG_QCOM_GSBI=y
# CONFIG_QCOM_LLCC is not set
CONFIG_QCOM_RPMH=y
CONFIG_QCOM_RPMHPD=y
CONFIG_QCOM_SPM=y
# end of Qualcomm SoC drivers

# CONFIG_SOC_RENESAS is not set
CONFIG_ROCKCHIP_GRF=y
CONFIG_ROCKCHIP_IODOMAIN=y
CONFIG_SOC_SAMSUNG=y
# CONFIG_EXYNOS_ASV_ARM is not set
CONFIG_EXYNOS_CHIPID=y
# CONFIG_EXYNOS_USI is not set
CONFIG_EXYNOS_PMU=y
# CONFIG_EXYNOS_PMU_ARM_DRIVERS is not set
CONFIG_EXYNOS_PM_DOMAINS=y
CONFIG_EXYNOS_REGULATOR_COUPLER=y
# CONFIG_SOC_TEGRA20_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TEGRA30_VOLTAGE_COUPLER is not set
# CONFIG_SOC_TI is not set
CONFIG_UX500_SOC_ID=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_QCOM_SPMI_MISC=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_TUSB320=y
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_DEBUG=y
CONFIG_PWM_ATMEL=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_ATMEL_TCB=y
CONFIG_PWM_BCM_IPROC=y
# CONFIG_PWM_BCM_KONA is not set
CONFIG_PWM_BCM2835=y
CONFIG_PWM_BERLIN=y
# CONFIG_PWM_BRCMSTB is not set
# CONFIG_PWM_CLPS711X is not set
CONFIG_PWM_EP93XX=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_HIBVT=y
CONFIG_PWM_IMG=y
# CONFIG_PWM_IMX1 is not set
CONFIG_PWM_IMX27=y
# CONFIG_PWM_IMX_TPM is not set
CONFIG_PWM_INTEL_LGM=y
CONFIG_PWM_IQS620A=y
CONFIG_PWM_JZ4740=y
CONFIG_PWM_KEEMBAY=y
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPC18XX_SCT=y
CONFIG_PWM_LPC32XX=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PLATFORM=y
# CONFIG_PWM_MESON is not set
CONFIG_PWM_MTK_DISP=y
CONFIG_PWM_MEDIATEK=y
CONFIG_PWM_MXS=y
CONFIG_PWM_OMAP_DMTIMER=y
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_PXA=y
CONFIG_PWM_RASPBERRYPI_POE=y
CONFIG_PWM_RCAR=y
CONFIG_PWM_RENESAS_TPU=y
CONFIG_PWM_ROCKCHIP=y
# CONFIG_PWM_SAMSUNG is not set
# CONFIG_PWM_SIFIVE is not set
# CONFIG_PWM_SL28CPLD is not set
CONFIG_PWM_SPEAR=y
# CONFIG_PWM_SPRD is not set
CONFIG_PWM_STI=y
CONFIG_PWM_STM32=y
CONFIG_PWM_STM32_LP=y
# CONFIG_PWM_SUN4I is not set
CONFIG_PWM_TEGRA=y
CONFIG_PWM_TIECAP=y
# CONFIG_PWM_TIEHRPWM is not set
# CONFIG_PWM_TWL is not set
CONFIG_PWM_TWL_LED=y
CONFIG_PWM_VISCONTI=y
CONFIG_PWM_VT8500=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_NVIC=y
# CONFIG_AL_FIC is not set
# CONFIG_JCORE_AIC is not set
# CONFIG_RENESAS_INTC_IRQPIN is not set
CONFIG_RENESAS_IRQC=y
CONFIG_RENESAS_RZA1_IRQC=y
CONFIG_SL28CPLD_INTC=y
CONFIG_TS4800_IRQ=y
CONFIG_INGENIC_TCU_IRQ=y
# CONFIG_RENESAS_H8S_INTC is not set
# CONFIG_IRQ_UNIPHIER_AIDET is not set
CONFIG_MESON_IRQ_GPIO=y
CONFIG_IMX_IRQSTEER=y
# CONFIG_IMX_INTMUX is not set
CONFIG_EXYNOS_IRQ_COMBINER=y
# CONFIG_LOONGSON_PCH_PIC is not set
# CONFIG_MST_IRQ is not set
CONFIG_MCHP_EIC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_ARCH_HAS_RESET_CONTROLLER=y
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
CONFIG_RESET_AXS10X=y
# CONFIG_RESET_BCM6345 is not set
# CONFIG_RESET_BERLIN is not set
CONFIG_RESET_BRCMSTB=y
CONFIG_RESET_BRCMSTB_RESCAL=y
# CONFIG_RESET_HSDK is not set
# CONFIG_RESET_IMX7 is not set
CONFIG_RESET_INTEL_GW=y
CONFIG_RESET_K210=y
CONFIG_RESET_LANTIQ=y
# CONFIG_RESET_LPC18XX is not set
CONFIG_RESET_MCHP_SPARX5=y
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_MESON_AUDIO_ARB is not set
CONFIG_RESET_NPCM=y
CONFIG_RESET_PISTACHIO=y
CONFIG_RESET_QCOM_AOSS=y
# CONFIG_RESET_QCOM_PDC is not set
CONFIG_RESET_RASPBERRYPI=y
# CONFIG_RESET_RZG2L_USBPHY_CTRL is not set
CONFIG_RESET_SCMI=y
CONFIG_RESET_SIMPLE=y
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STARFIVE_JH7100 is not set
CONFIG_RESET_SUNXI=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_RESET_TN48M_CPLD=y
CONFIG_RESET_UNIPHIER=y
# CONFIG_RESET_UNIPHIER_GLUE is not set
CONFIG_RESET_ZYNQ=y
CONFIG_COMMON_RESET_HI3660=y
# CONFIG_COMMON_RESET_HI6220 is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_PHY_LPC18XX_USB_OTG=y
CONFIG_PHY_PISTACHIO_USB=y
CONFIG_PHY_XGENE=y
CONFIG_USB_LGM_PHY=y
# CONFIG_PHY_CAN_TRANSCEIVER is not set
CONFIG_PHY_SUN4I_USB=y
CONFIG_PHY_SUN6I_MIPI_DPHY=y
# CONFIG_PHY_SUN9I_USB is not set
# CONFIG_PHY_SUN50I_USB3 is not set
# CONFIG_PHY_MESON8_HDMI_TX is not set
CONFIG_PHY_MESON8B_USB2=y
CONFIG_PHY_MESON_GXL_USB2=y
# CONFIG_PHY_MESON_G12A_USB2 is not set
# CONFIG_PHY_MESON_G12A_USB3_PCIE is not set
CONFIG_PHY_MESON_AXG_PCIE=y
# CONFIG_PHY_MESON_AXG_MIPI_PCIE_ANALOG is not set
CONFIG_PHY_MESON_AXG_MIPI_DPHY=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_PHY_BCM63XX_USBH=y
CONFIG_PHY_CYGNUS_PCIE=y
# CONFIG_PHY_BCM_SR_USB is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_BCM_NS_USB2=y
# CONFIG_PHY_NS2_USB_DRD is not set
# CONFIG_PHY_BRCM_SATA is not set
CONFIG_PHY_BRCM_USB=y
CONFIG_PHY_BCM_SR_PCIE=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=y
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_DPHY_RX=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_CADENCE_SALVO=y
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
CONFIG_PHY_MIXEL_MIPI_DPHY=y
CONFIG_PHY_FSL_IMX8M_PCIE=y
CONFIG_PHY_FSL_LYNX_28G=y
CONFIG_PHY_HI6220_USB=y
CONFIG_PHY_HI3660_USB=y
# CONFIG_PHY_HI3670_USB is not set
CONFIG_PHY_HI3670_PCIE=y
CONFIG_PHY_HISTB_COMBPHY=y
# CONFIG_PHY_HISI_INNO_USB2 is not set
# CONFIG_PHY_INGENIC_USB is not set
CONFIG_PHY_LANTIQ_VRX200_PCIE=y
# CONFIG_PHY_LANTIQ_RCU_USB2 is not set
CONFIG_ARMADA375_USBCLUSTER_PHY=y
# CONFIG_PHY_BERLIN_SATA is not set
CONFIG_PHY_BERLIN_USB=y
CONFIG_PHY_MVEBU_A3700_UTMI=y
# CONFIG_PHY_MVEBU_A38X_COMPHY is not set
# CONFIG_PHY_MVEBU_CP110_UTMI is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_PXA_USB=y
# CONFIG_PHY_MMP3_USB is not set
CONFIG_PHY_MMP3_HSIC=y
# CONFIG_PHY_MTK_TPHY is not set
# CONFIG_PHY_MTK_UFS is not set
CONFIG_PHY_MTK_XSPHY=y
# CONFIG_PHY_MTK_HDMI is not set
CONFIG_PHY_MTK_MIPI_DSI=y
CONFIG_PHY_SPARX5_SERDES=y
CONFIG_PHY_LAN966X_SERDES=y
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
# CONFIG_PHY_OCELOT_SERDES is not set
CONFIG_PHY_ATH79_USB=y
CONFIG_PHY_QCOM_EDP=y
CONFIG_PHY_QCOM_IPQ4019_USB=y
CONFIG_PHY_QCOM_PCIE2=y
# CONFIG_PHY_QCOM_QMP is not set
CONFIG_PHY_QCOM_QUSB2=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
CONFIG_PHY_QCOM_USB_HSIC=y
# CONFIG_PHY_QCOM_USB_HS_28NM is not set
CONFIG_PHY_QCOM_USB_SS=y
CONFIG_PHY_QCOM_IPQ806X_USB=y
CONFIG_PHY_MT7621_PCI=y
CONFIG_PHY_RALINK_USB=y
# CONFIG_PHY_RCAR_GEN3_USB3 is not set
CONFIG_PHY_ROCKCHIP_DPHY_RX0=y
CONFIG_PHY_ROCKCHIP_INNO_HDMI=y
# CONFIG_PHY_ROCKCHIP_INNO_USB2 is not set
CONFIG_PHY_ROCKCHIP_INNO_CSIDPHY=y
CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
CONFIG_PHY_ROCKCHIP_PCIE=y
# CONFIG_PHY_ROCKCHIP_TYPEC is not set
CONFIG_PHY_EXYNOS_DP_VIDEO=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_EXYNOS_PCIE is not set
CONFIG_PHY_SAMSUNG_UFS=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_S5PV210_USB2=y
CONFIG_PHY_UNIPHIER_USB2=y
CONFIG_PHY_UNIPHIER_USB3=y
# CONFIG_PHY_UNIPHIER_PCIE is not set
# CONFIG_PHY_UNIPHIER_AHCI is not set
# CONFIG_PHY_ST_SPEAR1310_MIPHY is not set
# CONFIG_PHY_ST_SPEAR1340_MIPHY is not set
# CONFIG_PHY_STIH407_USB is not set
# CONFIG_PHY_STM32_USBPHYC is not set
CONFIG_PHY_TEGRA194_P2U=y
# CONFIG_PHY_DA8XX_USB is not set
CONFIG_PHY_DM816X_USB=y
CONFIG_PHY_AM654_SERDES=y
CONFIG_PHY_J721E_WIZ=y
CONFIG_OMAP_CONTROL_PHY=y
# CONFIG_TI_PIPE3 is not set
# CONFIG_PHY_TUSB1210 is not set
CONFIG_PHY_INTEL_KEEMBAY_EMMC=y
CONFIG_PHY_INTEL_KEEMBAY_USB=y
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# CONFIG_PHY_INTEL_THUNDERBAY_EMMC is not set
CONFIG_PHY_XILINX_ZYNQMP=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
CONFIG_ARM_CCN=y
# CONFIG_ARM_CMN is not set
# CONFIG_ARM_PMU is not set
CONFIG_FSL_IMX8_DDR_PMU=y
# CONFIG_ARM_DMC620_PMU is not set
# end of Performance monitor support

# CONFIG_RAS is not set

#
# Android
#
CONFIG_ANDROID=y
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_IMX_IIM=y
CONFIG_NVMEM_IMX_OCOTP=y
CONFIG_JZ4780_EFUSE=y
CONFIG_NVMEM_LPC18XX_EEPROM=y
CONFIG_NVMEM_LPC18XX_OTP=y
CONFIG_NVMEM_MXS_OCOTP=y
# CONFIG_MTK_EFUSE is not set
CONFIG_NVMEM_NINTENDO_OTP=y
CONFIG_QCOM_QFPROM=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_ROCKCHIP_EFUSE is not set
CONFIG_ROCKCHIP_OTP=y
# CONFIG_NVMEM_BCM_OCOTP is not set
CONFIG_NVMEM_STM32_ROMEM=y
# CONFIG_UNIPHIER_EFUSE is not set
# CONFIG_NVMEM_VF610_OCOTP is not set
# CONFIG_MESON_MX_EFUSE is not set
CONFIG_NVMEM_SNVS_LPGPR=y
CONFIG_RAVE_SP_EEPROM=y
CONFIG_SC27XX_EFUSE=y
CONFIG_SPRD_EFUSE=y
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_BRCM_NVRAM=y
# CONFIG_NVMEM_LAYERSCAPE_SFP is not set
CONFIG_NVMEM_SUNPLUS_OCOTP=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_STH is not set
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_MASTER_AST_CF is not set
CONFIG_FSI_MASTER_ASPEED=y
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_IMX=y
CONFIG_INTERCONNECT_IMX8MM=y
CONFIG_INTERCONNECT_IMX8MN=y
CONFIG_INTERCONNECT_IMX8MQ=y
# CONFIG_INTERCONNECT_QCOM_OSM_L3 is not set
# CONFIG_INTERCONNECT_SAMSUNG is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
# CONFIG_PECI_ASPEED is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
# CONFIG_GFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
CONFIG_ZONEFS_FS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_ENCRYPTION_INLINE_CRYPT is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_KUNIT_TEST=y
# CONFIG_EXFAT_FS is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=y
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
CONFIG_ADFS_FS_RW=y
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=y
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=y
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
# CONFIG_EROFS_FS_SECURITY is not set
CONFIG_EROFS_FS_ZIP=y
# CONFIG_EROFS_FS_ZIP_LZMA is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
CONFIG_NLS_CODEPAGE_855=y
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
# CONFIG_NLS_MAC_ICELAND is not set
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECDSA is not set
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
# CONFIG_CRYPTO_GCM is not set
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
# CONFIG_CRYPTO_PCBC is not set
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
# CONFIG_CRYPTO_CAST6 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_KDF800108_CTR=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_ALLWINNER is not set
CONFIG_CRYPTO_DEV_EXYNOS_RNG=y
CONFIG_CRYPTO_DEV_S5P=y
# CONFIG_CRYPTO_DEV_ATMEL_AUTHENC is not set
CONFIG_CRYPTO_DEV_ATMEL_AES=y
CONFIG_CRYPTO_DEV_ATMEL_TDES=y
# CONFIG_CRYPTO_DEV_ATMEL_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
CONFIG_CRYPTO_DEV_ATMEL_ECC=y
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
CONFIG_CRYPTO_DEV_QCE=y
CONFIG_CRYPTO_DEV_QCE_SKCIPHER=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_ALL is not set
CONFIG_CRYPTO_DEV_QCE_ENABLE_SKCIPHER=y
# CONFIG_CRYPTO_DEV_QCE_ENABLE_SHA is not set
# CONFIG_CRYPTO_DEV_QCE_ENABLE_AEAD is not set
CONFIG_CRYPTO_DEV_QCE_SW_MAX_LEN=512
CONFIG_CRYPTO_DEV_QCOM_RNG=y
CONFIG_CRYPTO_DEV_IMGTEC_HASH=y
# CONFIG_CRYPTO_DEV_ZYNQMP_AES is not set
CONFIG_CRYPTO_DEV_ZYNQMP_SHA3=y
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_SAFEXCEL=y
CONFIG_CRYPTO_DEV_ARTPEC6=y
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_CRYPTO_DEV_HISI_SEC=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_CRYPTO_DEV_SA2UL=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4=y
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_ECB is not set
# CONFIG_CRYPTO_DEV_KEEMBAY_OCS_AES_SM4_CTS is not set
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_ECC=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU=y
CONFIG_CRYPTO_DEV_KEEMBAY_OCS_HCU_HMAC_SHA224=y
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_HAVE_ARCH_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_STMP_DEVICE=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=9
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM3=y
CONFIG_CRYPTO_LIB_SM4=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_HAS_DMA_WRITE_COMBINE=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_DMA_NONCOHERENT_MMAP=y
CONFIG_DMA_GLOBAL_POOL=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_SG_SPLIT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_NO_SG_CHAIN=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# CONFIG_PARMAN is not set
# CONFIG_OBJAGG is not set
# end of Library routines

CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO_NONE=y
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
CONFIG_HEADERS_INSTALL=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
CONFIG_DEBUG_FS_DISALLOW_MOUNT=y
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=y
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_NOMMU_REGIONS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_REF_SCALE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_RCU_STRICT_GRACE_PERIOD is not set
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
# CONFIG_SAMPLES is not set

#
# arm Debugging
#
CONFIG_UNWINDER_ARM=y
CONFIG_ARM_UNWIND=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_LL is not set
CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
CONFIG_CORESIGHT=y
CONFIG_CORESIGHT_LINKS_AND_SINKS=y
# CONFIG_CORESIGHT_LINK_AND_SINK_TMC is not set
CONFIG_CORESIGHT_SINK_TPIU=y
CONFIG_CORESIGHT_SINK_ETBV10=y
CONFIG_CORESIGHT_SOURCE_ETM3X=y
CONFIG_CORESIGHT_STM=y
CONFIG_CORESIGHT_CPU_DEBUG=y
CONFIG_CORESIGHT_CPU_DEBUG_DEFAULT_ON=y
CONFIG_CORESIGHT_CTI=y
# CONFIG_CORESIGHT_CTI_INTEGRATION_REGS is not set
# end of arm Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
CONFIG_KUNIT_DEBUGFS=y
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
CONFIG_KUNIT_ALL_TESTS=y
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_MIN_HEAP=y
CONFIG_TEST_SORT=y
# CONFIG_TEST_DIV64 is not set
CONFIG_BACKTRACE_SELF_TEST=y
# CONFIG_TEST_REF_TRACKER is not set
CONFIG_RBTREE_TEST=y
CONFIG_REED_SOLOMON_TEST=y
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
CONFIG_TEST_HEXDUMP=y
# CONFIG_STRING_SELFTEST is not set
CONFIG_TEST_STRING_HELPERS=y
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_SCANF=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_XARRAY=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_SIPHASH=y
# CONFIG_TEST_IDA is not set
CONFIG_FIND_BIT_BENCHMARK=y
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
CONFIG_BITFIELD_KUNIT=y
CONFIG_HASH_KUNIT_TEST=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_LINEAR_RANGES_TEST=y
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_BITS_TEST=y
CONFIG_RATIONAL_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
CONFIG_OVERFLOW_KUNIT_TEST=y
CONFIG_STACKINIT_KUNIT_TEST=y
CONFIG_TEST_UDELAY=y
CONFIG_TEST_MEMCAT_P=y
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_FREE_PAGES=y
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage

CONFIG_WARN_MISSING_DOCUMENTS=y
CONFIG_WARN_ABI_ERRORS=y
# end of Kernel hacking

--GwfpVxAv7z6/pTVz--
