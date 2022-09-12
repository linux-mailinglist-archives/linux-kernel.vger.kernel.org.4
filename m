Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E625B6400
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiILXTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiILXTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:19:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B4C60C4;
        Mon, 12 Sep 2022 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663024778; x=1694560778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SQ2FaaPXa/LVPfniALtuHwZoDlfr6AMfM6JEvFyXCBE=;
  b=egCYk1H6NVhnxL3x/kSdlysf6e+Ewk2IWqMsTNQUxetLuToHk68mHfwm
   j8f5cBY41DLirOLiH/SnTe5PVCo/yDCw85bOzMYQPtmyKyPQURYRWEokB
   xJyl0/Dl8XZ4WSmUbuOdZ3NZDOK4wL1JR2cW31YLfMNAyr3xL2kTc4zBD
   yT1qQd1fzdyXJT6fustJqPlDvMKHrLYp3DjozsQNf9vrdvvqVlM0/uoSw
   mvMx++bRPkZ9aD3Zjr6ArxCAEkwaQMaeuk2nxdq5GSg4y8h3rFt5My7L5
   1fcysf4qp+Vb7VK8cPFM+LOZOe8dUQDyH2Zq5G81c0LR6ion0oTmw/H9s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324232367"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="324232367"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="567357309"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 16:19:34 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXsiD-0002xv-2x;
        Mon, 12 Sep 2022 23:19:33 +0000
Date:   Tue, 13 Sep 2022 07:18:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, anrao@nvidia.com, smangipudi@nvidia.com,
        pshete@nvidia.com
Subject: Re: [PATCH 1/2] mmc: sdhci-tegra: Separate T19x and T23x SoC data
Message-ID: <202209130728.VPH1SdRJ-lkp@intel.com>
References: <20220912132337.18159-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912132337.18159-1-pshete@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prathamesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tegra/for-next]
[also build test ERROR on linus/master v6.0-rc5 next-20220912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prathamesh-Shete/mmc-sdhci-tegra-Separate-T19x-and-T23x-SoC-data/20220912-212611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220913/202209130728.VPH1SdRJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d1a916947a4fb73d2982138d4e35dc50b4d19b3c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Prathamesh-Shete/mmc-sdhci-tegra-Separate-T19x-and-T23x-SoC-data/20220912-212611
        git checkout d1a916947a4fb73d2982138d4e35dc50b4d19b3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-tegra.c:1529:20: error: 'SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER' undeclared here (not in a function)
    1529 |                    SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER +1529 drivers/mmc/host/sdhci-tegra.c

  1521	
  1522	static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
  1523		.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
  1524			  SDHCI_QUIRK_SINGLE_POWER_WRITE |
  1525			  SDHCI_QUIRK_NO_HISPD_BIT |
  1526			  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
  1527			  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
  1528		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> 1529			   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
  1530		.ops  = &tegra186_sdhci_ops,
  1531	};
  1532	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
