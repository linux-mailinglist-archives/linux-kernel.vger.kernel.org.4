Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAB6B3136
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjCIWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjCIWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:44:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87365C56;
        Thu,  9 Mar 2023 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678401830; x=1709937830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBE1n3VDHKOa0my/fpWQs/hh4OEzhEHXYLpvjY/5Y0Q=;
  b=dPbm4nXmq99X2ep99J4vzLJ6u1gjzlzgjL0SNI9L55ZHTIy3HkySEhb3
   WX4gr59wlATQowjxz+91nxZA2kWsXHUiJD5cJUuf8vQFT+2RAZzZL7rAT
   Cp+DzHCkEmng1aafKzUQsQGpdV1rbQncRFnyvGbUZZpWVoPpf+ozZsjge
   7P8jkyDNjpXcg3CWyCSgiv+KWPFzf612tFWFXOxYER7q2GgE1t2sTHxa2
   bm8eCtHMaW2sOp1sN9Zdw+gWW6M/T5QUXKoR+esx8qWYu4DbKwIFXSUFD
   P4o0UCOUa0EA1SVlShCoPnt+rSM26u1VmUWMcf5IlvDDy57XxCCXlE9KS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335289373"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="335289373"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 14:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="654953046"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="654953046"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2023 14:42:42 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1paOy9-0003H1-2U;
        Thu, 09 Mar 2023 22:42:41 +0000
Date:   Fri, 10 Mar 2023 06:42:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM7150 support
Message-ID: <202303100615.2vRPxq4R-lkp@intel.com>
References: <20230309185049.170878-3-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309185049.170878-3-danila@jiaxyga.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danila,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.3-rc1 next-20230309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Danila-Tikhonov/dt-bindings-phy-Add-QMP-UFS-PHY-comptible-for-SM7150/20230310-025222
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230309185049.170878-3-danila%40jiaxyga.com
patch subject: [PATCH 2/2] phy: qcom-qmp-ufs: Add SM7150 support
config: arm64-randconfig-r023-20230308 (https://download.01.org/0day-ci/archive/20230310/202303100615.2vRPxq4R-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/95e826acacaf3b5ba79c06b481199a17abed44ba
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Danila-Tikhonov/dt-bindings-phy-Add-QMP-UFS-PHY-comptible-for-SM7150/20230310-025222
        git checkout 95e826acacaf3b5ba79c06b481199a17abed44ba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/phy/qualcomm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303100615.2vRPxq4R-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:380:3: error: expected identifier or '('
   };)
     ^
>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:972:14: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
                   .serdes         = sm8150_ufsphy_serdes,
                                     ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:973:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
                   .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
                                                ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:973:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:973:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1004:14: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
                   .serdes         = sm8150_ufsphy_serdes,
                                     ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1005:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
                   .serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
                                                ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1005:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1005:28: error: use of undeclared identifier 'sm8150_ufsphy_serdes'
   9 errors generated.


vim +380 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c

   370	
   371	static const struct qmp_phy_init_tbl sm7150_ufsphy_pcs[] = {
   372		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6f),
   373		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
   374		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
   375		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
   376		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
   377		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1, 0x0f),
   378		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xFF),
   379		QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 > 380	};)
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
