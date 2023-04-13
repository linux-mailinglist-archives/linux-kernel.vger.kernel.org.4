Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B426E0D19
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDMLvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjDMLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:51:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B129BA244
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681386676; x=1712922676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9xJYrzq65Z7lAh8wTwslnmVBthgNArUDClkJW2ZxDeM=;
  b=GpVu3lJ5yfI7RcMiEwzhIu8vCzAKEbg+6dussb6Bw/NmTBX9L+amj+NB
   WQ2ZDfQkq2NHNLF4vvMgeWPOw1AKQyYbFhRIFfVF34L3qbnO0byQL+/Hb
   MfgumsIVK49K1hUEnqIb7bFLBm99fa+IeESd6wIlAMI59ssxua4Ka+Snk
   2ceNZIt7iPlYBmB4pC+lp0gwHJefJQjZeNKLWhkwt0qzzy/IibenDdvaL
   MLJ1PTLRr2AQhcU7yMPgQlEeyvYOv//3WiZUdPw22i15abvjV5GFHnTpg
   SXhA2giK8oby+KypylhYIBLnmgM/6vD4Mw3Y+p57P0n9NRaVAJcKuI54w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324518293"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="324518293"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 04:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="813430248"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="813430248"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2023 04:50:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmvTT-000YeP-0v;
        Thu, 13 Apr 2023 11:50:47 +0000
Date:   Thu, 13 Apr 2023 19:49:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: drivers/video/fbdev/offb.c:373:48: sparse: sparse: incorrect type in
 initializer (different base types)
Message-ID: <202304131941.ol8LcT9Y-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de4664485abbc0529b1eec44d0061bbfe58a28fb
commit: 9d8b5376cc2848ca22314fdec9a7a45b1bf69189 fbdev: make offb driver tristate
date:   4 months ago
config: powerpc-randconfig-s053-20230413 (https://download.01.org/0day-ci/archive/20230413/202304131941.ol8LcT9Y-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d8b5376cc2848ca22314fdec9a7a45b1bf69189
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9d8b5376cc2848ca22314fdec9a7a45b1bf69189
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304131941.ol8LcT9Y-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/offb.c:373:48: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __be32 @@     got int @@
   drivers/video/fbdev/offb.c:373:48: sparse:     expected restricted __be32
   drivers/video/fbdev/offb.c:373:48: sparse:     got int
>> drivers/video/fbdev/offb.c:581:42: sparse: sparse: restricted __be32 degrades to integer
>> drivers/video/fbdev/offb.c:602:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int addr_prop @@     got restricted __be32 const [usertype] @@
   drivers/video/fbdev/offb.c:602:27: sparse:     expected unsigned int addr_prop
   drivers/video/fbdev/offb.c:602:27: sparse:     got restricted __be32 const [usertype]

vim +373 drivers/video/fbdev/offb.c

^1da177e4c3f41 drivers/video/offb.c       Linus Torvalds         2005-04-16  322  
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  323  static void offb_init_palette_hacks(struct fb_info *info, struct device_node *dp,
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  324  				    unsigned long address)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  325  {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  326  	struct offb_par *par = (struct offb_par *) info->par;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  327  
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  328  	if (of_node_name_prefix(dp, "ATY,Rage128")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  329  		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  330  		if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  331  			par->cmap_type = cmap_r128;
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  332  	} else if (of_node_name_prefix(dp, "ATY,RageM3pA") ||
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  333  		   of_node_name_prefix(dp, "ATY,RageM3p12A")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  334  		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  335  		if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  336  			par->cmap_type = cmap_M3A;
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  337  	} else if (of_node_name_prefix(dp, "ATY,RageM3pB")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  338  		par->cmap_adr = offb_map_reg(dp, 2, 0, 0x1fff);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  339  		if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  340  			par->cmap_type = cmap_M3B;
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  341  	} else if (of_node_name_prefix(dp, "ATY,Rage6")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  342  		par->cmap_adr = offb_map_reg(dp, 1, 0, 0x1fff);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  343  		if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  344  			par->cmap_type = cmap_radeon;
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  345  	} else if (of_node_name_prefix(dp, "ATY,")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  346  		unsigned long base = address & 0xff000000UL;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  347  		par->cmap_adr =
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  348  			ioremap(base + 0x7ff000, 0x1000) + 0xcc0;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  349  		par->cmap_data = par->cmap_adr + 1;
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  350  		par->cmap_type = cmap_simple;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  351  	} else if (dp && (of_device_is_compatible(dp, "pci1014,b7") ||
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  352  			  of_device_is_compatible(dp, "pci1014,21c"))) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  353  		par->cmap_adr = offb_map_reg(dp, 0, 0x6000, 0x1000);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  354  		if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  355  			par->cmap_type = cmap_gxt2000;
00257e0cc550c4 drivers/video/fbdev/offb.c Rob Herring            2019-01-11  356  	} else if (of_node_name_prefix(dp, "vga,Display-")) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  357  		/* Look for AVIVO initialized by SLOF */
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  358  		struct device_node *pciparent = of_get_parent(dp);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  359  		const u32 *vid, *did;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  360  		vid = of_get_property(pciparent, "vendor-id", NULL);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  361  		did = of_get_property(pciparent, "device-id", NULL);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  362  		/* This will match most R5xx */
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  363  		if (vid && did && *vid == 0x1002 &&
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  364  		    ((*did >= 0x7100 && *did < 0x7800) ||
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  365  		     (*did >= 0x9400))) {
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  366  			par->cmap_adr = offb_map_reg(pciparent, 2, 0, 0x10000);
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  367  			if (par->cmap_adr)
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  368  				par->cmap_type = cmap_avivo;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  369  		}
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  370  		of_node_put(pciparent);
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  371  	} else if (dp && of_device_is_compatible(dp, "qemu,std-vga")) {
212c0cbd5be721 drivers/video/offb.c       Cedric Le Goater       2013-12-04  372  #ifdef __BIG_ENDIAN
212c0cbd5be721 drivers/video/offb.c       Cedric Le Goater       2013-12-04 @373  		const __be32 io_of_addr[3] = { 0x01000000, 0x0, 0x0 };
212c0cbd5be721 drivers/video/offb.c       Cedric Le Goater       2013-12-04  374  #else
212c0cbd5be721 drivers/video/offb.c       Cedric Le Goater       2013-12-04  375  		const __be32 io_of_addr[3] = { 0x00000001, 0x0, 0x0 };
212c0cbd5be721 drivers/video/offb.c       Cedric Le Goater       2013-12-04  376  #endif
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  377  		u64 io_addr = of_translate_address(dp, io_of_addr);
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  378  		if (io_addr != OF_BAD_ADDR) {
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  379  			par->cmap_adr = ioremap(io_addr + 0x3c8, 2);
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  380  			if (par->cmap_adr) {
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  381  				par->cmap_type = cmap_simple;
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  382  				par->cmap_data = par->cmap_adr + 1;
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  383  			}
9b961ed21a7c92 drivers/video/offb.c       Benjamin Herrenschmidt 2011-12-14  384  		}
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  385  	}
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  386  	info->fix.visual = (par->cmap_type != cmap_unknown) ?
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  387  		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_STATIC_PSEUDOCOLOR;
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  388  }
57a20d8fb0d2a0 drivers/video/offb.c       Benjamin Herrenschmidt 2008-07-17  389  

:::::: The code at line 373 was first introduced by commit
:::::: 212c0cbd5be721a39ef3e2f723e0c78008f9e955 offb: Little endian fixes

:::::: TO: Cedric Le Goater <clg@fr.ibm.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
