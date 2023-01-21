Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F7676403
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 06:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjAUFfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 00:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjAUFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 00:35:01 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEE4F84B;
        Fri, 20 Jan 2023 21:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674279300; x=1705815300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NyAaTmyfPMukEU82BbayaCdDYiu0nA0LRprRqC50EW4=;
  b=MjK8izKm4nynY0Nh24ue4AzZqWi+PBYSomZlBmNFY3gZe5JCfdoF6WQ9
   KMhg841cN/pL4Uhctc4ZF5MKd/80TVjedkXkSRSiUmXd4SvcplgAfDKFy
   bIFf5ymrJbZS8A9logkkoDIZJ5j8evjToh4Mx0vAPM0GNG5J3QmIrbNVK
   wU12GpcaXmFejHdI3hV1IAVM7w9/Aiq9ihx2KnC33u4PFRUJ305vDwDUD
   S5re4HJkPDYz1nEfOfsA9aJ3dQdGS9j6IX8PZl5ZpwfD2mI92iX2dZIte
   /mCz1YxnnNQ3oEH30O80rzLoA0sj1x5m6pBke6cE0J2GVZ0dcuudAUbSX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324448691"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="324448691"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 21:34:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="662773341"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="662773341"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2023 21:34:55 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ6Wk-0003ZX-2Q;
        Sat, 21 Jan 2023 05:34:54 +0000
Date:   Sat, 21 Jan 2023 13:34:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v5 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc
 into lpass_aon
Message-ID: <202301211339.VDhvfKMQ-lkp@intel.com>
References: <1674218806-7711-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674218806-7711-6-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.2-rc4 next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Srinivasa-Rao-Mandadapu/dt-bindings-clock-qcom-sc7280-lpasscc-Add-qcom-adsp-pil-mode-property/20230120-204835
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/1674218806-7711-6-git-send-email-quic_srivasam%40quicinc.com
patch subject: [PATCH v5 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
config: arc-randconfig-r043-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211339.VDhvfKMQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9163f9ad677af61b97b9ea5ef569722f277a7d20
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/dt-bindings-clock-qcom-sc7280-lpasscc-Add-qcom-adsp-pil-mode-property/20230120-204835
        git checkout 9163f9ad677af61b97b9ea5ef569722f277a7d20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/qcom/lpassaudiocc-sc7280.c: In function 'lpass_aon_cc_sc7280_probe':
>> drivers/clk/qcom/lpassaudiocc-sc7280.c:831:17: error: 'res' undeclared (first use in this function); did you mean 'ret'?
     831 |                 res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
         |                 ^~~
         |                 ret
   drivers/clk/qcom/lpassaudiocc-sc7280.c:831:17: note: each undeclared identifier is reported only once for each function it appears in


vim +831 drivers/clk/qcom/lpassaudiocc-sc7280.c

   819	
   820	static int lpass_aon_cc_sc7280_probe(struct platform_device *pdev)
   821	{
   822		const struct qcom_cc_desc *desc;
   823		struct regmap *regmap;
   824		int ret;
   825	
   826		ret = lpass_audio_setup_runtime_pm(pdev);
   827		if (ret)
   828			return ret;
   829	
   830		if (of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
 > 831			res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
   832			if (res) {
   833				lpass_audio_cc_sc7280_regmap_config.name = "cc";
   834				desc = &lpass_cc_sc7280_desc;
   835				return qcom_cc_probe(pdev, desc);
   836			}
   837		}
   838	
   839		lpass_audio_cc_sc7280_regmap_config.name = "lpasscc_aon";
   840		lpass_audio_cc_sc7280_regmap_config.max_register = 0xa0008;
   841		desc = &lpass_aon_cc_sc7280_desc;
   842	
   843		regmap = qcom_cc_map(pdev, desc);
   844		if (IS_ERR(regmap)) {
   845			ret = PTR_ERR(regmap);
   846			goto exit;
   847		}
   848	
   849		clk_lucid_pll_configure(&lpass_aon_cc_pll, regmap, &lpass_aon_cc_pll_config);
   850	
   851		ret = qcom_cc_really_probe(pdev, &lpass_aon_cc_sc7280_desc, regmap);
   852		if (ret) {
   853			dev_err(&pdev->dev, "Failed to register LPASS AON CC clocks\n");
   854			goto exit;
   855		}
   856	
   857		pm_runtime_mark_last_busy(&pdev->dev);
   858	exit:
   859		pm_runtime_put_autosuspend(&pdev->dev);
   860	
   861		return ret;
   862	}
   863	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
