Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767836B5FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCKS3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCKS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:29:04 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE9D67726;
        Sat, 11 Mar 2023 10:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678559343; x=1710095343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7UriBZLzyKs6P5CQrv2KqGpLUYP3a8QnxHq74IZZg7Y=;
  b=Cy9DPcZmYMyhveLduR6QswTpXiPBy66OgYI3FxiXEx+ruL0F5MOdNnvL
   wEmyoeAMie2PPEVdojuVihW2Erbs65jPKls8Fal08JcuQh/BEAfG08h5L
   e26BqF7yfCWglGPBDFm6Q14bxPe+C/bO1xIEjyaUUA35vF+eWPCVhnobn
   odR74FTwQ1twpO0mEoNRotXjj9hgQu9wUxUvtVgdNiGCz6dksuA5Q2YuM
   1JFKgqztLZAp06Ty0sl6n8hhgkKVcQvkiyM0P9ezcWJh/NN50XyMqhR2p
   +h1qKTwt9xYirYgwtWAZAhZ5SJi0gzoLQ0nTfUdZ0Qji8W0v3rBsnEawn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="423193505"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="423193505"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 10:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="628168721"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="628168721"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2023 10:29:00 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pb3xj-0004kn-16;
        Sat, 11 Mar 2023 18:28:59 +0000
Date:   Sun, 12 Mar 2023 02:28:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Moudy Ho <moudy.ho@mediatek.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:607:34:
 warning: unused variable 'mdp_comp_dt_ids'
Message-ID: <202303120236.ZykolTwn-lkp@intel.com>
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

Hi Moudy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ef5f68cc1f829b492b19cd4df5af4454aa816b93
commit: 61890ccaefaff89f5babd2c8412fd222c3f5fe38 media: platform: mtk-mdp3: add MediaTek MDP3 driver
date:   6 months ago
config: hexagon-randconfig-r001-20230312 (https://download.01.org/0day-ci/archive/20230312/202303120236.ZykolTwn-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303120236.ZykolTwn-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:607:34: warning: unused variable 'mdp_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mdp_comp_dt_ids[] = {
                                    ^
>> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:627:34: warning: unused variable 'mdp_sub_comp_dt_ids' [-Wunused-const-variable]
   static const struct of_device_id mdp_sub_comp_dt_ids[] = {
                                    ^
   2 warnings generated.


vim +/mdp_comp_dt_ids +607 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c

   606	
 > 607	static const struct of_device_id mdp_comp_dt_ids[] = {
   608		{
   609			.compatible = "mediatek,mt8183-mdp3-rdma",
   610			.data = (void *)MDP_COMP_TYPE_RDMA,
   611		}, {
   612			.compatible = "mediatek,mt8183-mdp3-ccorr",
   613			.data = (void *)MDP_COMP_TYPE_CCORR,
   614		}, {
   615			.compatible = "mediatek,mt8183-mdp3-rsz",
   616			.data = (void *)MDP_COMP_TYPE_RSZ,
   617		}, {
   618			.compatible = "mediatek,mt8183-mdp3-wrot",
   619			.data = (void *)MDP_COMP_TYPE_WROT,
   620		}, {
   621			.compatible = "mediatek,mt8183-mdp3-wdma",
   622			.data = (void *)MDP_COMP_TYPE_WDMA,
   623		},
   624		{}
   625	};
   626	
 > 627	static const struct of_device_id mdp_sub_comp_dt_ids[] = {
   628		{
   629			.compatible = "mediatek,mt8183-mdp3-wdma",
   630			.data = (void *)MDP_COMP_TYPE_PATH,
   631		}, {
   632			.compatible = "mediatek,mt8183-mdp3-wrot",
   633			.data = (void *)MDP_COMP_TYPE_PATH,
   634		},
   635		{}
   636	};
   637	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
