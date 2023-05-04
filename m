Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7166F6C89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjEDNCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEDNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:02:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A0359E8
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683205324; x=1714741324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ee9nLZwjbDNeRswfIOmfPuxFBiAj4K/k63dxw8tvPdU=;
  b=WH0PpKgmbQl94QB4Ct+tnPkraSkyP8xrjxsXErmvoHe972l/unNEh480
   a8xcY4rS6ndYFsBrhRDI7HOZnkeNtrv8F0FSUrGCfjAr/3SqBA8Q/il9+
   AYJTy96igfMTU8Gq0uw6F3B7IpwPesey/Ky1RN8TdO2qVFvlkkyVPjiYA
   ff/Tbucm9fQ/eqW7JxArMAvFzgyisAmIdh8VgjqGAgtQLW/7iuUbYzzQU
   zQepfSUQQTml1SzxmVDU9c+DBZVPFu1bckSK/B0qPbvMOP8cXGjYtV2e7
   e8Ys2cNXLw2FYHX4RG5whqn9CN9DFEePgLgklPkpkBoczY11irH5031DM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="412108741"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="412108741"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 06:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="691126068"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="691126068"
Received: from lkp-server01.sh.intel.com (HELO 646801eb55b5) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 May 2023 06:02:01 -0700
Received: from kbuild by 646801eb55b5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puYau-00001J-31;
        Thu, 04 May 2023 13:02:00 +0000
Date:   Thu, 4 May 2023 21:01:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:415:10: warning:
 cast to smaller integer type 'enum mtk_ovl_adaptor_comp_type' from 'const
 void *'
Message-ID: <202305042054.ZtWME9OU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy.Lin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1a5304fecee523060f26e2778d9d8e33c0562df3
commit: 453c3364632a1f305db7d425dc9f8d6711cd3491 drm/mediatek: Add ovl_adaptor support for MT8195
date:   6 weeks ago
config: arm64-randconfig-r004-20230504 (https://download.01.org/0day-ci/archive/20230504/202305042054.ZtWME9OU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b1465cd49efcbc114a75220b153f5a055ce7911f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=453c3364632a1f305db7d425dc9f8d6711cd3491
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 453c3364632a1f305db7d425dc9f8d6711cd3491
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/gpu/drm/mediatek/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305042054.ZtWME9OU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:415:10: warning: cast to smaller integer type 'enum mtk_ovl_adaptor_comp_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   type = (enum mtk_ovl_adaptor_comp_type)of_id->data;
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +415 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c

   391	
   392	static int ovl_adaptor_comp_init(struct device *dev, struct component_match **match)
   393	{
   394		struct mtk_disp_ovl_adaptor *priv = dev_get_drvdata(dev);
   395		struct device_node *node, *parent;
   396		struct platform_device *comp_pdev;
   397	
   398		parent = dev->parent->parent->of_node->parent;
   399	
   400		for_each_child_of_node(parent, node) {
   401			const struct of_device_id *of_id;
   402			enum mtk_ovl_adaptor_comp_type type;
   403			int id;
   404	
   405			of_id = of_match_node(mtk_ovl_adaptor_comp_dt_ids, node);
   406			if (!of_id)
   407				continue;
   408	
   409			if (!of_device_is_available(node)) {
   410				dev_dbg(dev, "Skipping disabled component %pOF\n",
   411					node);
   412				continue;
   413			}
   414	
 > 415			type = (enum mtk_ovl_adaptor_comp_type)of_id->data;
   416			id = ovl_adaptor_comp_get_id(dev, node, type);
   417			if (id < 0) {
   418				dev_warn(dev, "Skipping unknown component %pOF\n",
   419					 node);
   420				continue;
   421			}
   422	
   423			comp_pdev = of_find_device_by_node(node);
   424			if (!comp_pdev)
   425				return -EPROBE_DEFER;
   426	
   427			priv->ovl_adaptor_comp[id] = &comp_pdev->dev;
   428	
   429			drm_of_component_match_add(dev, match, compare_of, node);
   430			dev_dbg(dev, "Adding component match for %pOF\n", node);
   431		}
   432	
   433		if (!*match) {
   434			dev_err(dev, "No match device for ovl_adaptor\n");
   435			return -ENODEV;
   436		}
   437	
   438		return 0;
   439	}
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
