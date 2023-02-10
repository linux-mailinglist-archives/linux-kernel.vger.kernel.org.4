Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BFF691A06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjBJI3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjBJI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:29:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486D366B2;
        Fri, 10 Feb 2023 00:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676017773; x=1707553773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FvTZ8CF0SRrWAA/WY3/QF/tDGnDdOk3LmVrb3b04Erk=;
  b=YqAkMZjNXCt87tq5zuHjGKQ3pBNAJ//tOZUx5Q8BDHvc9V+uZBwfc2dg
   h5CTBrlcp8b/OJBI/gYGBo3v7i/pIgiU66BFu2dfkhf0NRR3lLDO2Pfgz
   nEDSs5qhd5GEfuIJ55ukRBwe05iUkYYOKcTRIQzP3P/Wr5GlTyz1K32tT
   SYiiJmn6ytthMXq+OTphWBmP4jJrVOngjUZzuKYeb0HHa1VYdz7NLxfxa
   QyWvh3EHpftkC3zQZB0oIfcFUsxjK55tal/UVoWgeWvEOUZExpg08ee3Q
   qdkv0LE9pywWikmioEOJAjSknT8aHlWldjboev+wGANGhZeFvQfQBY+xj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310000964"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="310000964"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 00:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="791888447"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="791888447"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2023 00:29:30 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQOmf-0005gf-2f;
        Fri, 10 Feb 2023 08:29:29 +0000
Date:   Fri, 10 Feb 2023 16:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c:49:34: warning:
 unused variable 'mdp_of_ids'
Message-ID: <202302101603.xNtJ8p91-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   38c1e0c65865426676123cc9a127526fa02bcac6
commit: 61890ccaefaff89f5babd2c8412fd222c3f5fe38 media: platform: mtk-mdp3: add MediaTek MDP3 driver
date:   5 months ago
config: hexagon-randconfig-r024-20230210 (https://download.01.org/0day-ci/archive/20230210/202302101603.xNtJ8p91-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=61890ccaefaff89f5babd2c8412fd222c3f5fe38
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 61890ccaefaff89f5babd2c8412fd222c3f5fe38
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/mediatek/mdp3/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302101603.xNtJ8p91-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c:49:34: warning: unused variable 'mdp_of_ids' [-Wunused-const-variable]
   static const struct of_device_id mdp_of_ids[] = {
                                    ^
   1 warning generated.
--
>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:607:34: warning: unused variable 'mdp_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mdp_comp_dt_ids[] = {
                                    ^
>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:627:34: warning: unused variable 'mdp_sub_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mdp_sub_comp_dt_ids[] = {
                                    ^
   2 warnings generated.


vim +/mdp_of_ids +49 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c

    48	
  > 49	static const struct of_device_id mdp_of_ids[] = {
    50		{ .compatible = "mediatek,mt8183-mdp3-rdma",
    51		  .data = &mt8183_mdp_driver_data,
    52		},
    53		{},
    54	};
    55	MODULE_DEVICE_TABLE(of, mdp_of_ids);
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
