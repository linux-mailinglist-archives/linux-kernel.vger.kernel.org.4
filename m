Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBC74C6CF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGIRo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:44:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD76100
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688924694; x=1720460694;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8U6HApipRwoFX7KL3kdB1H5crxskD7kEsnoPjs5vQdk=;
  b=bLZeWa9pODvP87pSt2LvN4Ymm9Wtktwjq6wQ2vyIcpcDsm4bfoSzPm5D
   cHi8Ol8Hx0U8SjuPkGcs2oSdexM8chS16b4lC0fAHpEmcij2xLREN8ixl
   STG93YQwAZrCCVwh0b1V211eWugSfIX6RfcOm5TJ6/b/+ai2ra19QS/jQ
   iGQDNhVNp0iFBYUsspq63MXfbtgbEIjP39nz/OQWtRoH6NBHiM7Rz8/t+
   MQCqp51vvFX+JpmlLMj4ZOSNlEXTVsrGCaqO4bsz8syC7t+TRU4YPLBeM
   nsZEscEI3OSPRh52xhld/Kv++RYVXDMRNhu+agsJHwrYjKnBSrb5yj+s6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430262113"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="430262113"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 10:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="714558620"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="714558620"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2023 10:44:51 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIYSo-0003K0-1i;
        Sun, 09 Jul 2023 17:44:50 +0000
Date:   Mon, 10 Jul 2023 01:44:43 +0800
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
Message-ID: <202307100103.5TXiJnCm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy.Lin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c7873e3364570ec89343ff4877e0f27a7b21a61
commit: 453c3364632a1f305db7d425dc9f8d6711cd3491 drm/mediatek: Add ovl_adaptor support for MT8195
date:   4 months ago
config: arm64-randconfig-r021-20230709 (https://download.01.org/0day-ci/archive/20230710/202307100103.5TXiJnCm-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230710/202307100103.5TXiJnCm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307100103.5TXiJnCm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c:415:10: warning: cast to smaller integer type 'enum mtk_ovl_adaptor_comp_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
     415 |                 type = (enum mtk_ovl_adaptor_comp_type)of_id->data;
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
https://github.com/intel/lkp-tests/wiki
