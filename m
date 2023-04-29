Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFAE6F25DF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjD2SdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjD2SdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:33:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A804A1BCF;
        Sat, 29 Apr 2023 11:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682793193; x=1714329193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dGqeIYpC2JZwMxvQegezHt3ZAIGfnZ54XGzF0LvvvaM=;
  b=E7ycN8LxX0QEdtYh7S1ePLMRnqfI0f5s6UiGaOLzyLezpIIIAIF0KoZ5
   9c+ou7A6/PHq/ShOJC5EUtyboJ/DZs6BZUOR0SPQ84J5O1kCTUW+G5Y5t
   Si4Njhsacn4CW/dtOK5oUKRYUigXIkRxXKJr7pzN7uv9RaKgmstlCg/4r
   AMR68XT7OF6bUpcOmF4LzRxFlJAzA9w2PnevH9gl4EcOnufK+bEeRu8Gf
   OprOqCt9FoxhROnP1fTrpKIL3DNAofTGEG8JGLvZOXWQnULUi6MmPx4m/
   8Vf8sCEYkTqn/7EryccCL/uNKSnGpM+rdPqaUPBq1UgVofyyRpROJvZDt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="327582140"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="327582140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 11:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="819469895"
X-IronPort-AV: E=Sophos;i="5.99,237,1677571200"; 
   d="scan'208";a="819469895"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Apr 2023 11:33:11 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pspNe-0001In-0h;
        Sat, 29 Apr 2023 18:33:10 +0000
Date:   Sun, 30 Apr 2023 02:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/platform/verisilicon/hantro_drv.c:618:34: warning:
 unused variable 'of_hantro_match'
Message-ID: <202304300210.PXABWBvG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89d77f71f493a3663b10fa812d17f472935d24be
commit: fbb6c848dd89786fe24856ee6b5e773910ded29c media: destage Hantro VPU driver
date:   8 months ago
config: hexagon-buildonly-randconfig-r002-20230430 (https://download.01.org/0day-ci/archive/20230430/202304300210.PXABWBvG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 437b7602e4a998220871de78afcb020b9c14a661)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbb6c848dd89786fe24856ee6b5e773910ded29c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fbb6c848dd89786fe24856ee6b5e773910ded29c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/platform/verisilicon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304300210.PXABWBvG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/platform/verisilicon/hantro_drv.c:618:34: warning: unused variable 'of_hantro_match' [-Wunused-const-variable]
   static const struct of_device_id of_hantro_match[] = {
                                    ^
   1 warning generated.


vim +/of_hantro_match +618 drivers/media/platform/verisilicon/hantro_drv.c

775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  617  
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12 @618  static const struct of_device_id of_hantro_match[] = {
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  619  #ifdef CONFIG_VIDEO_HANTRO_ROCKCHIP
fb7cb344b96938 drivers/staging/media/hantro/hantro_drv.c             Paul Kocialkowski  2021-07-19  620  	{ .compatible = "rockchip,px30-vpu",   .data = &px30_vpu_variant, },
4f34591568e7a1 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  621  	{ .compatible = "rockchip,rk3036-vpu", .data = &rk3036_vpu_variant, },
78bb1ae5472cab drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  622  	{ .compatible = "rockchip,rk3066-vpu", .data = &rk3066_vpu_variant, },
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  623  	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
4b898fedeb26c4 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  624  	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
4b898fedeb26c4 drivers/staging/media/hantro/hantro_drv.c             Alex Bee           2021-06-14  625  	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
6f1ae821a6c4aa drivers/staging/media/hantro/hantro_drv.c             Nicolas Frattaroli 2022-06-12  626  	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
5f6bfab6da6531 drivers/staging/media/hantro/hantro_drv.c             Piotr Oniszczuk    2022-02-14  627  	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  628  #endif
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  629  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
cf1abc501a5c76 drivers/staging/media/hantro/hantro_drv.c             Adam Ford          2022-01-25  630  	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
8e4aaa68786319 drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2020-03-20  631  	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
6971efb70ac3e4 drivers/staging/media/hantro/hantro_drv.c             Adam Ford          2022-01-25  632  	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
45040f67504195 drivers/staging/media/hantro/hantro_drv.c             Benjamin Gaignard  2021-06-03  633  	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  634  #endif
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  635  #ifdef CONFIG_VIDEO_HANTRO_SAMA5D4
82ad940c009499 drivers/staging/media/hantro/hantro_drv.c             Emil Velikov       2021-04-01  636  	{ .compatible = "microchip,sama5d4-vdec", .data = &sama5d4_vdec_variant, },
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  637  #endif
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  638  #ifdef CONFIG_VIDEO_HANTRO_SUNXI
86790a4fdf4b3d drivers/staging/media/hantro/hantro_drv.c             Jernej Skrabec     2021-11-29  639  	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  640  #endif
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  641  	{ /* sentinel */ }
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  642  };
a29add8c9bb29d drivers/staging/media/hantro/hantro_drv.c             Philipp Zabel      2019-06-12  643  MODULE_DEVICE_TABLE(of, of_hantro_match);
775fec69008d30 drivers/staging/media/rockchip/vpu/rockchip_vpu_drv.c Ezequiel Garcia    2018-12-05  644  

:::::: The code at line 618 was first introduced by commit
:::::: a29add8c9bb29dfa8dc47c71b2702e9cc4f332a6 media: rockchip/vpu: rename from rockchip to hantro

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
