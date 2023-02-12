Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F769377C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBLMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:53:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8AC12842;
        Sun, 12 Feb 2023 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676206426; x=1707742426;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TUnLdQngEgMWvrkAudk6ufpyfmAnF3rSTSx+s3TYcnY=;
  b=OGFPGNRjnJ57hiVNckOcePC/jz6BUlc1Gg2KzDziclx9IeQYuKWlLK1M
   HkJQ+dj1TIib6Wu+pGN2F02ZRJypOGIFUrryYJ8D7MnLtkXN8g4UP3oei
   Fj+QrTOmuOazD7UdKDhwTSPfGc/V5hb55L7t0VvsbE43l7117EMD30nz1
   QDUauBDWDbt/y/sS80rsyqQpipOoLO4dZI7gYxeXE1CpbP3Z/t7XALCP1
   qAq7x0ojz83H1Nn6GAqHhXmjxUGtCMK6OQ7AbkodvwgHJ5D/3eF1o8yZD
   TYIJdkp7HkPMgnYPjH4zL9cgZUfyxAZxlUgTgor+bkyJnpRp82DJZRl89
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="310346659"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="310346659"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 04:53:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10618"; a="842494185"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="842494185"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2023 04:53:44 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRBrT-0007DZ-2h;
        Sun, 12 Feb 2023 12:53:43 +0000
Date:   Sun, 12 Feb 2023 20:52:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning:
 unused variable 'mtk_mdp_comp_dt_ids'
Message-ID: <202302122022.1CJ8CO2t-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f339c2597ebb00e738f2b6328c14804ed19f5d57
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
date:   11 months ago
config: hexagon-randconfig-r022-20230212 (https://download.01.org/0day-ci/archive/20230212/202302122022.1CJ8CO2t-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2023a99811110aebba9eee4aa09ef7bd21a8a249
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/mediatek/mdp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302122022.1CJ8CO2t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/mdp/mtk_mdp_core.c:31:34: warning: unused variable 'mtk_mdp_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
                                    ^
   1 warning generated.


vim +/mtk_mdp_comp_dt_ids +31 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c

c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  30  
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08 @31  static const struct of_device_id mtk_mdp_comp_dt_ids[] = {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  32  	{
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  33  		.compatible = "mediatek,mt8173-mdp-rdma",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  34  		.data = (void *)MTK_MDP_RDMA
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  35  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  36  		.compatible = "mediatek,mt8173-mdp-rsz",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  37  		.data = (void *)MTK_MDP_RSZ
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  38  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  39  		.compatible = "mediatek,mt8173-mdp-wdma",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  40  		.data = (void *)MTK_MDP_WDMA
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  41  	}, {
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  42  		.compatible = "mediatek,mt8173-mdp-wrot",
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  43  		.data = (void *)MTK_MDP_WROT
55d80506c5f7c3 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  44  	},
55d80506c5f7c3 drivers/media/platform/mtk-mdp/mtk_mdp_core.c Vincent Stehlé 2016-10-27  45  	{ },
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  46  };
c8eb2d7e8202fd drivers/media/platform/mtk-mdp/mtk_mdp_core.c Minghsiu Tsai  2016-09-08  47  

:::::: The code at line 31 was first introduced by commit
:::::: c8eb2d7e8202fd9cb912f5d33cc34ede66dcb24a [media] media: Add Mediatek MDP Driver

:::::: TO: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
