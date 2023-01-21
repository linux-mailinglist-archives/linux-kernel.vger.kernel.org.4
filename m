Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B976764F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAUH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUH2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:28:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EC70292;
        Fri, 20 Jan 2023 23:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674286090; x=1705822090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qkoh5MykipgiNXgEPEeWoVT+cm37cUhUw0TSx1mdBDY=;
  b=Haas8j6OcFI5ioKZmJW1BzeGejRsmTXgP0NDOKd0dxRBKSyFFsSMXvcM
   XK1mBXpc04pmG4dfE5u3rwQO8G35r9OL9LUoGjoaWS7akEQb1YCF2UlX3
   xmu2D0AQsCBDn9jzcne7fK7N8UpVK9oKkRgVF+Jl5b/v4dU71xZeaiDlm
   7/o3p43GnclMeSVvblA+2QP/HGsPgzfWaI5Ds5izgZMXlo8M8jcgydoIV
   Jr+wQ8j5U4Rd1CwipXFTtv01xCEq+n69cvc2gyaDnLwVznIS0eKWnDNRo
   Fh41PMlGGYBb9i0iUP9GlJCL4R7ngebWhn33NPg10OcYiBYp5RpavmpCk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="353020249"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="353020249"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 23:28:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="803325301"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="803325301"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2023 23:28:05 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ8IH-0003lW-0V;
        Sat, 21 Jan 2023 07:28:05 +0000
Date:   Sat, 21 Jan 2023 15:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        swboyd@chromium.org, agross@kernel.org, andersson@kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, quic_plai@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: Re: [PATCH v5 5/6] clk: qcom: lpassaudiocc-sc7280: Merge lpasscc
 into lpass_aon
Message-ID: <202301211545.p4v6zuaX-lkp@intel.com>
References: <1674218806-7711-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674218806-7711-6-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-randconfig-r006-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211545.p4v6zuaX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9163f9ad677af61b97b9ea5ef569722f277a7d20
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/dt-bindings-clock-qcom-sc7280-lpasscc-Add-qcom-adsp-pil-mode-property/20230120-204835
        git checkout 9163f9ad677af61b97b9ea5ef569722f277a7d20
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/lpassaudiocc-sc7280.c:831:3: error: use of undeclared identifier 'res'; did you mean 'ret'?
                   res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
                   ^~~
                   ret
   drivers/clk/qcom/lpassaudiocc-sc7280.c:824:6: note: 'ret' declared here
           int ret;
               ^
>> drivers/clk/qcom/lpassaudiocc-sc7280.c:831:7: error: incompatible pointer to integer conversion assigning to 'int' from 'struct resource *' [-Wint-conversion]
                   res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cc");
                       ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/qcom/lpassaudiocc-sc7280.c:832:7: error: use of undeclared identifier 'res'; did you mean 'ret'?
                   if (res) {
                       ^~~
                       ret
   drivers/clk/qcom/lpassaudiocc-sc7280.c:824:6: note: 'ret' declared here
           int ret;
               ^
   3 errors generated.


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
