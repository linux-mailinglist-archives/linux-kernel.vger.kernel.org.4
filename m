Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C5D6769D6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 23:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUWsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 17:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 17:48:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAA23C7E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674341330; x=1705877330;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=j1MhCgB/WnOYYlD7hDFxnu//+hizRmNSZgH3VqUiz3M=;
  b=NRO4zlO1AxB70AMk9T5Mk67WNdfhPm10agzw07CEh5q3ey7f418nxvw8
   2BTrf+rTqaBqygOrL9lSl/5Xm35SV7lkmTVXt8tN0BA7J0y69xcM3GxSq
   SJvcZptbC3WCB0DUX2Ft8niD8Rcu1KGTnOgM/wZ95dndM23zHPuGaUpE6
   fo61SsLtiTLZTTeCSXMk+RDEFZaDIPr5kD9NGrR63o5HeuNfwkuh0N/Mk
   GCjfIrr6eXIXKb+4WqnDwoNKWS9nzuCj5gst1beCRTEv1kqnNbcJ7gp0R
   iFlsJkyIft5u470fZpx6OYTdqhIRFD8nbvbcDBhhiuZYt5st7Ra/PQn2e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="390345692"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="390345692"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 14:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="749747623"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="749747623"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2023 14:48:48 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJMfH-0004YA-28;
        Sat, 21 Jan 2023 22:48:47 +0000
Date:   Sun, 22 Jan 2023 06:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/omap/lcd_mipid.c:451:23: sparse: sparse: cast to
 restricted __be32
Message-ID: <202301220608.62FbzOrd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f67144022885344375ad03593e7a290cc614da34
commit: 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b fbdev: omap: avoid using mach/*.h files
date:   9 months ago
config: arm-randconfig-s033-20230122 (https://download.01.org/0day-ci/archive/20230122/202301220608.62FbzOrd-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 804f7f19c2e2928aeb8eafef8379fe8b8d13f98b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/video/fbdev/omap/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/omap/lcd_mipid.c:451:23: sparse: sparse: cast to restricted __be32

vim +451 drivers/video/fbdev/omap/lcd_mipid.c

66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  444  
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  445  static int panel_enabled(struct mipid_device *md)
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  446  {
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  447  	u32 disp_status;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  448  	int enabled;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  449  
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  450  	mipid_read(md, MIPID_CMD_READ_DISP_STATUS, (u8 *)&disp_status, 4);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22 @451  	disp_status = __be32_to_cpu(disp_status);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  452  	enabled = (disp_status & (1 << 17)) && (disp_status & (1 << 10));
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  453  	dev_dbg(&md->spi->dev,
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  454  		"LCD panel %senabled by bootloader (status 0x%04x)\n",
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  455  		enabled ? "" : "not ", disp_status);
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  456  	return enabled;
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  457  }
66d2f99d0bb5a2 drivers/video/omap/lcd_mipid.c Imre Deak 2009-09-22  458  

:::::: The code at line 451 was first introduced by commit
:::::: 66d2f99d0bb5a2972fb5c1d88b61169510e540d6 omapfb: add support for MIPI-DCS compatible LCDs

:::::: TO: Imre Deak <imre.deak@nokia.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
