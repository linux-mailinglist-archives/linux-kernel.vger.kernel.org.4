Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB066F48E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbjEBRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjEBRGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:06:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC71BF6
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683047195; x=1714583195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fEYMsK1Iiuu4vvTM0awEdj78uMJDPmIYBFIrEeHP8uI=;
  b=Uo6XEuR6P+eaaM37nQYNNeb+swfeYKq91scNZMrPZ9qvAcJ5/ybjhFBD
   s/QmK2Ym73PNjmzKWJu5lptW8CFAYwx4wZ+F7bjvIcWdNxrmU9C0ENybR
   L4sxUYksWSLRQcgBWbM8ZNHqnpPpbxJnUbAKtrl32ljAlvqdYfI/zVmpl
   8zoPsBdy1z6yh+BcHRSYwBNX4eN0uUrGh118V3tyvEnbNYh0H1X2GGE9o
   xql/7YWRUtaypYR4DApiP5p7KEq6bv3nGMx2+Ywsa+GXvVtNPnsU9D64I
   RsKH3CCxvmIMqV0Ze9hPLy0FxKEWdeVzk2sv00g7vDtyVbfimv47BzUub
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="345936014"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="345936014"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 10:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="729000952"
X-IronPort-AV: E=Sophos;i="5.99,244,1677571200"; 
   d="scan'208";a="729000952"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 May 2023 10:06:30 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pttSQ-0001BM-2i;
        Tue, 02 May 2023 17:06:30 +0000
Date:   Wed, 3 May 2023 01:06:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH 06/11] drm/mediatek: gamma: Use bitfield macros
Message-ID: <202305030043.iaNtiOtW-lkp@intel.com>
References: <20230502081650.25947-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502081650.25947-7-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/drm-mediatek-gamma-Adjust-mtk_drm_gamma_set_common-parameters/20230502-161758
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230502081650.25947-7-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH 06/11] drm/mediatek: gamma: Use bitfield macros
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20230503/202305030043.iaNtiOtW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/171ab0605a0c2b44167dc1339b29dc80c2ac7d4d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review AngeloGioacchino-Del-Regno/drm-mediatek-gamma-Adjust-mtk_drm_gamma_set_common-parameters/20230502-161758
        git checkout 171ab0605a0c2b44167dc1339b29dc80c2ac7d4d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305030043.iaNtiOtW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mediatek/mtk_disp_gamma.c: In function 'mtk_gamma_set_common':
>> drivers/gpu/drm/mediatek/mtk_disp_gamma.c:111:32: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     111 |                         word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, hwlut.red);
         |                                ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_PREP +111 drivers/gpu/drm/mediatek/mtk_disp_gamma.c

    77	
    78	void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crtc_state *state)
    79	{
    80		struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
    81		unsigned int i;
    82		struct drm_color_lut *lut;
    83		void __iomem *lut_base;
    84		bool lut_diff;
    85		u16 lut_size;
    86		u32 cfg_val, word;
    87	
    88		/* If there's no gamma lut there's nothing to do here. */
    89		if (!state->gamma_lut)
    90			return;
    91	
    92		if (gamma && gamma->data) {
    93			lut_diff = gamma->data->lut_diff;
    94			lut_size = gamma->data->lut_size;
    95		} else {
    96			lut_diff = false;
    97			lut_size = LUT_SIZE_DEFAULT;
    98		}
    99	
   100		cfg_val = readl(regs + DISP_GAMMA_CFG);
   101		lut_base = regs + DISP_GAMMA_LUT;
   102		lut = (struct drm_color_lut *)state->gamma_lut->data;
   103		for (i = 0; i < lut_size; i++) {
   104			struct drm_color_lut diff, hwlut;
   105	
   106			hwlut.red = drm_color_lut_extract(lut[i].red, LUT_BITS_DEFAULT);
   107			hwlut.green = drm_color_lut_extract(lut[i].green, LUT_BITS_DEFAULT);
   108			hwlut.red = drm_color_lut_extract(lut[i].blue, LUT_BITS_DEFAULT);
   109	
   110			if (!lut_diff || (i % 2 == 0)) {
 > 111				word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, hwlut.red);
   112				word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, hwlut.green);
   113				word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, hwlut.blue);
   114			} else {
   115				diff.red = lut[i].red - lut[i - 1].red;
   116				diff.red = drm_color_lut_extract(diff.red, LUT_BITS_DEFAULT);
   117	
   118				diff.green = lut[i].green - lut[i - 1].green;
   119				diff.green = drm_color_lut_extract(diff.green, LUT_BITS_DEFAULT);
   120	
   121				diff.blue = lut[i].blue - lut[i - 1].blue;
   122				diff.blue = drm_color_lut_extract(diff.blue, LUT_BITS_DEFAULT);
   123	
   124				word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, diff.red);
   125				word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, diff.green);
   126				word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, diff.blue);
   127			}
   128			writel(word, (lut_base + i * 4));
   129		}
   130	
   131		/* Enable the gamma table */
   132		cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
   133	
   134		writel(cfg_val, regs + DISP_GAMMA_CFG);
   135	}
   136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
