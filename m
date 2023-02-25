Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC66A2BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBYWIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjBYWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:08:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B132711140;
        Sat, 25 Feb 2023 14:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677362926; x=1708898926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qV1skxuPminG3+6XLAOhZB14mFP+wbEBXA1KiXVc01o=;
  b=k/PcuQwGoLTW6s3W/IWBShrgjRAF+Pk5sMO9giWr1P9UAqmFSnit+KbH
   1yXwcEEe68F/qGTDtDNHDDjkcMD9gwvm+VGVAp/myaTSonZIQrObLTwDj
   TYoCYg+wIQytuHW1ypMvj4+w9W+Ky5bh+d/8NES4lIq2MwPpLnTvVsDQg
   xFo4LSVSm3gfe2akFGrdwrBvHlLkuiGrSKAO2QYxQevwV+uMzBEdnW7WX
   f9YTgHzAbbEy5Fg132LNAP/r5YYHi5ZlMA66dtdkmQKuWDVKvKIPC/CrB
   qIClRtdCQdUKANLGIoj1GfFNsXZLCoMXYKUti4eDpF/kQ4466vwjKaB7/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="361216282"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="361216282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 14:08:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10632"; a="703559692"
X-IronPort-AV: E=Sophos;i="5.97,328,1669104000"; 
   d="scan'208";a="703559692"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2023 14:08:43 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pW2ih-0003Qk-0R;
        Sat, 25 Feb 2023 22:08:43 +0000
Date:   Sun, 26 Feb 2023 06:08:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, George Sun <george.sun@mediatek.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: drivers/media/v4l2-core/v4l2-vp9.c:1834:1: warning: the frame size
 of 1420 bytes is larger than 1024 bytes
Message-ID: <202302260626.Dnuv0krY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   116b41162f8b267987ea9a73eb7e73eaa7c2cce5
commit: 5d418351ca8f17defa1170d968df161c35b810e3 media: mediatek: vcodec: support stateless VP9 decoding
date:   10 months ago
config: csky-buildonly-randconfig-r004-20230226 (https://download.01.org/0day-ci/archive/20230226/202302260626.Dnuv0krY-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d418351ca8f17defa1170d968df161c35b810e3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d418351ca8f17defa1170d968df161c35b810e3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302260626.Dnuv0krY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/media/v4l2-core/v4l2-vp9.c: In function 'v4l2_vp9_adapt_noncoef_probs':
>> drivers/media/v4l2-core/v4l2-vp9.c:1834:1: warning: the frame size of 1420 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1834 | }
         | ^


vim +1834 drivers/media/v4l2-core/v4l2-vp9.c

3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1757  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1758  /* 8.4.4 Non coefficient probability adaptation process */
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1759  void v4l2_vp9_adapt_noncoef_probs(struct v4l2_vp9_frame_context *probs,
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1760  				  struct v4l2_vp9_frame_symbol_counts *counts,
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1761  				  u8 reference_mode, u8 interpolation_filter, u8 tx_mode,
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1762  				  u32 flags)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1763  {
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1764  	unsigned int i, j;
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1765  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1766  	for (i = 0; i < ARRAY_SIZE(probs->is_inter); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1767  		probs->is_inter[i] = adapt_prob(probs->is_inter[i], (*counts->intra_inter)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1768  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1769  	for (i = 0; i < ARRAY_SIZE(probs->comp_mode); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1770  		probs->comp_mode[i] = adapt_prob(probs->comp_mode[i], (*counts->comp)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1771  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1772  	for (i = 0; i < ARRAY_SIZE(probs->comp_ref); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1773  		probs->comp_ref[i] = adapt_prob(probs->comp_ref[i], (*counts->comp_ref)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1774  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1775  	if (reference_mode != V4L2_VP9_REFERENCE_MODE_COMPOUND_REFERENCE)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1776  		for (i = 0; i < ARRAY_SIZE(probs->single_ref); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1777  			for (j = 0; j < ARRAY_SIZE(probs->single_ref[0]); j++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1778  				probs->single_ref[i][j] = adapt_prob(probs->single_ref[i][j],
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1779  								     (*counts->single_ref)[i][j]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1780  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1781  	for (i = 0; i < ARRAY_SIZE(probs->inter_mode); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1782  		adapt_probs_variant_c(probs->inter_mode[i], (*counts->mv_mode)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1783  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1784  	for (i = 0; i < ARRAY_SIZE(probs->y_mode); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1785  		adapt_probs_variant_d(probs->y_mode[i], (*counts->y_mode)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1786  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1787  	for (i = 0; i < ARRAY_SIZE(probs->uv_mode); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1788  		adapt_probs_variant_d(probs->uv_mode[i], (*counts->uv_mode)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1789  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1790  	for (i = 0; i < ARRAY_SIZE(probs->partition); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1791  		adapt_probs_variant_e(probs->partition[i], (*counts->partition)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1792  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1793  	for (i = 0; i < ARRAY_SIZE(probs->skip); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1794  		probs->skip[i] = adapt_prob(probs->skip[i], (*counts->skip)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1795  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1796  	if (interpolation_filter == V4L2_VP9_INTERP_FILTER_SWITCHABLE)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1797  		for (i = 0; i < ARRAY_SIZE(probs->interp_filter); i++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1798  			adapt_probs_variant_f(probs->interp_filter[i], (*counts->filter)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1799  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1800  	if (tx_mode == V4L2_VP9_TX_MODE_SELECT)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1801  		for (i = 0; i < ARRAY_SIZE(probs->tx8); i++) {
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1802  			adapt_probs_variant_b(probs->tx8[i], (*counts->tx8p)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1803  			adapt_probs_variant_f(probs->tx16[i], (*counts->tx16p)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1804  			adapt_probs_variant_e(probs->tx32[i], (*counts->tx32p)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1805  		}
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1806  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1807  	adapt_probs_variant_e(probs->mv.joint, *counts->mv_joint);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1808  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1809  	for (i = 0; i < ARRAY_SIZE(probs->mv.sign); i++) {
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1810  		probs->mv.sign[i] = adapt_prob(probs->mv.sign[i], (*counts->sign)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1811  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1812  		adapt_probs_variant_g(probs->mv.classes[i], (*counts->classes)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1813  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1814  		probs->mv.class0_bit[i] = adapt_prob(probs->mv.class0_bit[i], (*counts->class0)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1815  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1816  		for (j = 0; j < ARRAY_SIZE(probs->mv.bits[0]); j++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1817  			probs->mv.bits[i][j] = adapt_prob(probs->mv.bits[i][j],
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1818  							  (*counts->bits)[i][j]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1819  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1820  		for (j = 0; j < ARRAY_SIZE(probs->mv.class0_fr[0]); j++)
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1821  			adapt_probs_variant_e(probs->mv.class0_fr[i][j],
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1822  					      (*counts->class0_fp)[i][j]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1823  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1824  		adapt_probs_variant_e(probs->mv.fr[i], (*counts->fp)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1825  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1826  		if (!(flags & V4L2_VP9_FRAME_FLAG_ALLOW_HIGH_PREC_MV))
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1827  			continue;
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1828  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1829  		probs->mv.class0_hp[i] = adapt_prob(probs->mv.class0_hp[i],
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1830  						    (*counts->class0_hp)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1831  
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1832  		probs->mv.hp[i] = adapt_prob(probs->mv.hp[i], (*counts->hp)[i]);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1833  	}
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16 @1834  }
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1835  EXPORT_SYMBOL_GPL(v4l2_vp9_adapt_noncoef_probs);
3e3b1fb0e5d95c Andrzej Pietrasiewicz 2021-11-16  1836  

:::::: The code at line 1834 was first introduced by commit
:::::: 3e3b1fb0e5d95c0cd7278717185ca3fb00f5d771 media: Add VP9 v4l2 library

:::::: TO: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
