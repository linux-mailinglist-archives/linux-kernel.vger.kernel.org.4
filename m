Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0A687466
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 05:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBBEXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 23:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBBEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 23:23:17 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE07151C6F;
        Wed,  1 Feb 2023 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675311794; x=1706847794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRjDoncShj8+SssxokKgsGrrecQq1hGkUGW2vyCqEh0=;
  b=UANfDHhxCQuGbKePnFUAefodDR+/fh2cFQfYB6DHHoftuyGap3TT/nno
   y+2YuBiBurBrvbs1kyrqVLlaGHvBEnV+pgMPmtxVRc0rjaxNB/y3/Kt5U
   xXEJnwZU7Q/P920ig8DD02qcC+aIn2N/ey4/yPdx1NQ1QRAZY90+ftt2a
   5NRPtVTLeWwgS74eihSO12R9VDqLxsws77aehAwQiWwp0lAb//fXxZM/X
   5jqrWqQfhDcj3SKrEQtWlFIU+4stvivfM0GoFwXJ4V5OJuNwabiv3O3ye
   wmdQnk7v1/NDXy15pxkGTvj0Zv3ntqqzia93wS4GRZbclf+43btq1zdPO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="311992907"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="311992907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 20:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="642736779"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="642736779"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2023 20:23:09 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pNR7s-00068m-34;
        Thu, 02 Feb 2023 04:23:08 +0000
Date:   Thu, 2 Feb 2023 12:22:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: Re: [v1 3/3] drm/msm/disp/dpu1: reserve the resources on topology
 change
Message-ID: <202302021238.o9yx7MKs-lkp@intel.com>
References: <1675092092-26412-4-git-send-email-quic_kalyant@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675092092-26412-4-git-send-email-quic_kalyant@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalyan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.2-rc6 next-20230201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalyan-Thota/drm-msm-disp-dpu1-clear-dspp-reservations-in-rm-release/20230130-232224
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/1675092092-26412-4-git-send-email-quic_kalyant%40quicinc.com
patch subject: [v1 3/3] drm/msm/disp/dpu1: reserve the resources on topology change
config: riscv-randconfig-r042-20230130 (https://download.01.org/0day-ci/archive/20230202/202302021238.o9yx7MKs-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4c49c3233fc18f3b746a96b5ff4ce5008da3bfec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kalyan-Thota/drm-msm-disp-dpu1-clear-dspp-reservations-in-rm-release/20230130-232224
        git checkout 4c49c3233fc18f3b746a96b5ff4ce5008da3bfec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c:2091:6: error: conflicting types for 'dpu_encoder_prepare_commit'
   void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc)
        ^
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h:155:6: note: previous declaration is here
   void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc,
        ^
   1 error generated.
--
>> drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:443:38: error: too few arguments to function call, expected 2, have 1
                           dpu_encoder_prepare_commit(encoder);
                           ~~~~~~~~~~~~~~~~~~~~~~~~~~        ^
   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h:155:6: note: 'dpu_encoder_prepare_commit' declared here
   void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc,
        ^
   1 error generated.


vim +/dpu_encoder_prepare_commit +2091 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c

ae4d721ce10057a Abhinav Kumar     2022-04-26  2090  
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27 @2091  void dpu_encoder_prepare_commit(struct drm_encoder *drm_enc)
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2092  {
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2093  	struct dpu_encoder_virt *dpu_enc;
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2094  	struct dpu_encoder_phys *phys;
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2095  	int i;
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2096  
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2097  	if (!drm_enc) {
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2098  		DPU_ERROR("invalid encoder\n");
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2099  		return;
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2100  	}
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2101  	dpu_enc = to_dpu_encoder_virt(drm_enc);
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2102  
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2103  	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2104  		phys = dpu_enc->phys_encs[i];
b6fadcade627040 Drew Davenport    2019-12-06  2105  		if (phys->ops.prepare_commit)
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2106  			phys->ops.prepare_commit(phys);
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2107  	}
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2108  }
25fdd5933e4c0f5 Jeykumar Sankaran 2018-06-27  2109  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
