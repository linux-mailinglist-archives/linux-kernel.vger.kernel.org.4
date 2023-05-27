Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4E71342C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjE0LHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjE0LHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:07:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F076DF
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685185622; x=1716721622;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c8SZlaZKDb1Fv7N4ngXxJJOnIKnbR83Yw15Uwsk+Sg0=;
  b=M8WzUab4vLIs5kN6nwIu5MKBUBYMbPBYB4FDxDY2IwnPSct0kMZIuHhR
   uK4oikCQiOFOVehLi5tN3YnzAuIREd7Z0EExEUneE3BPsuxyQ5ZBCiP4L
   dwWo5Q7oXPUIKSS976uDXIdraj7LJPjrFWJXIj1DU2xtrgGo3VSqwmKw+
   g7ZtB1sSTrVhhxzv88khJch6ZgbiBL0R5Yc9lzqQwZypYxtU9DmFEAZEE
   q5qQTPpivZRnFM9Cg3K14MvNwxELxrcp6rB2fVXsq89ER+tYOUiNYZUe2
   YOcknRYTDahFFVTSMynymzLGzy/PELTWcFcDBIkq/mKByQMvNNIXjn4Hr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="334009496"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="334009496"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2023 04:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="708672892"
X-IronPort-AV: E=Sophos;i="6.00,196,1681196400"; 
   d="scan'208";a="708672892"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 May 2023 04:07:00 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q2rlE-000Jv4-0p;
        Sat, 27 May 2023 11:07:00 +0000
Date:   Sat, 27 May 2023 19:06:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/mux/mmio.c:29:34: warning: 'mux_mmio_dt_ids' defined but not
 used
Message-ID: <202305271837.P7wi3WCR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   49572d5361298711207ab387a6c318407deb963a
commit: e4d4371253029528c02bfb43a46c252e1c3d035f phy: phy-can-transceiver: Add support for setting mux
date:   1 year, 2 months ago
config: i386-buildonly-randconfig-r006-20230526 (https://download.01.org/0day-ci/archive/20230527/202305271837.P7wi3WCR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e4d4371253029528c02bfb43a46c252e1c3d035f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e4d4371253029528c02bfb43a46c252e1c3d035f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/mux/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305271837.P7wi3WCR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mux/mmio.c:29:34: warning: 'mux_mmio_dt_ids' defined but not used [-Wunused-const-variable=]
      29 | static const struct of_device_id mux_mmio_dt_ids[] = {
         |                                  ^~~~~~~~~~~~~~~


vim +/mux_mmio_dt_ids +29 drivers/mux/mmio.c

73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  28  
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14 @29  static const struct of_device_id mux_mmio_dt_ids[] = {
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  30  	{ .compatible = "mmio-mux", },
8ecfaca7926f4b drivers/mux/mmio.c     Pankaj Bansal 2019-06-12  31  	{ .compatible = "reg-mux", },
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  32  	{ /* sentinel */ }
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  33  };
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  34  MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids);
73726380a26fa1 drivers/mux/mux-mmio.c Philipp Zabel 2017-05-14  35  

:::::: The code at line 29 was first introduced by commit
:::::: 73726380a26fa1ed490f30fccee10ed9da28dc0c mux: mmio-based syscon mux controller

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
