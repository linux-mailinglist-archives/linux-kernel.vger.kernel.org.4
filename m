Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA86CB119
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjC0V6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0V6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:58:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9B210D;
        Mon, 27 Mar 2023 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679954322; x=1711490322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8elsuuHEP+ah5YfSiPOlfAsO3FRV8t6GIdL66uBhyg=;
  b=ZcGCkwyvZMo11NPbrBxllz7sYABCfhQx9tOIAErgztvxTPZB1xMJTvuK
   bluh2RzPiEWPytJruN4Tqq3oL2YIQTQ9QwzBPeNJa2EPojYrRqvO/WbkU
   G41R2E7cxwW58zPmExhUryhvxx9Ex/dea0n4fr8I77+9QeLbOqJ3PJ5PJ
   JXurzQ6dH35lh12a5CgTXsup2Gg2t7/tu2uhpRK0htOMheN8hCqsgSD97
   EzUFPQ7TSZDesENyRBrvNhaJrWuKkoqZ5puJSeXXQEbWaaWO9cL4TskzO
   B1LHrxKByEpNfF2M3Gis7bVaQEkHhR6uOL/s5jvJdhHfeBuN6a41EFYpi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403002687"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="403002687"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="929623497"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="929623497"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2023 14:58:36 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgurL-000I2n-1e;
        Mon, 27 Mar 2023 21:58:35 +0000
Date:   Tue, 28 Mar 2023 05:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 6/7] mmc: sdhci-msm: Switch to the new ICE API
Message-ID: <202303280550.QHofWszH-lkp@intel.com>
References: <20230327134734.3256974-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327134734.3256974-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on mkp-scsi/for-next jejb-scsi/for-next linus/master v6.3-rc4 next-20230327]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abel-Vesa/dt-bindings-crypto-Add-Qualcomm-Inline-Crypto-Engine/20230327-214958
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230327134734.3256974-7-abel.vesa%40linaro.org
patch subject: [PATCH v4 6/7] mmc: sdhci-msm: Switch to the new ICE API
config: microblaze-randconfig-s042-20230326 (https://download.01.org/0day-ci/archive/20230328/202303280550.QHofWszH-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/2b59bf19ddc6de631e808bb2f30d5cf030f37828
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Abel-Vesa/dt-bindings-crypto-Add-Qualcomm-Inline-Crypto-Engine/20230327-214958
        git checkout 2b59bf19ddc6de631e808bb2f30d5cf030f37828
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/soc/qcom/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303280550.QHofWszH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/soc/qcom/ice.c:273:32: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct qcom_ice * @@     got void [noderef] __iomem *[assigned] base @@
   drivers/soc/qcom/ice.c:273:32: sparse:     expected struct qcom_ice *
   drivers/soc/qcom/ice.c:273:32: sparse:     got void [noderef] __iomem *[assigned] base

vim +273 drivers/soc/qcom/ice.c

a9e1199fcc2742 Abel Vesa 2023-03-27  256  
a9e1199fcc2742 Abel Vesa 2023-03-27  257  struct qcom_ice *of_qcom_ice_get(struct device *dev)
a9e1199fcc2742 Abel Vesa 2023-03-27  258  {
a9e1199fcc2742 Abel Vesa 2023-03-27  259  	struct platform_device *pdev = to_platform_device(dev);
a9e1199fcc2742 Abel Vesa 2023-03-27  260  	struct qcom_ice *ice = ERR_PTR(-EPROBE_DEFER);
a9e1199fcc2742 Abel Vesa 2023-03-27  261  	struct device_node *node;
a9e1199fcc2742 Abel Vesa 2023-03-27  262  	struct resource *res;
a9e1199fcc2742 Abel Vesa 2023-03-27  263  	void __iomem *base;
a9e1199fcc2742 Abel Vesa 2023-03-27  264  
a9e1199fcc2742 Abel Vesa 2023-03-27  265  	if (!dev || !dev->of_node)
a9e1199fcc2742 Abel Vesa 2023-03-27  266  		return ERR_PTR(-ENODEV);
a9e1199fcc2742 Abel Vesa 2023-03-27  267  
a9e1199fcc2742 Abel Vesa 2023-03-27  268  	/* legacy has ice reg range in the consumer DT node */
a9e1199fcc2742 Abel Vesa 2023-03-27  269  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice");
a9e1199fcc2742 Abel Vesa 2023-03-27  270  	if (res) {
a9e1199fcc2742 Abel Vesa 2023-03-27  271  		base = devm_ioremap_resource(&pdev->dev, res);
a9e1199fcc2742 Abel Vesa 2023-03-27  272  		if (IS_ERR(base))
a9e1199fcc2742 Abel Vesa 2023-03-27 @273  			return base;
a9e1199fcc2742 Abel Vesa 2023-03-27  274  
a9e1199fcc2742 Abel Vesa 2023-03-27  275  		/* create ICE instance using consumer dev */
a9e1199fcc2742 Abel Vesa 2023-03-27  276  		return qcom_ice_create(pdev, base);
a9e1199fcc2742 Abel Vesa 2023-03-27  277  	}
a9e1199fcc2742 Abel Vesa 2023-03-27  278  
a9e1199fcc2742 Abel Vesa 2023-03-27  279  	node = of_parse_phandle(dev->of_node, "qcom,ice", 0);
a9e1199fcc2742 Abel Vesa 2023-03-27  280  	if (!node) {
a9e1199fcc2742 Abel Vesa 2023-03-27  281  		ice = NULL;
a9e1199fcc2742 Abel Vesa 2023-03-27  282  		goto out;
a9e1199fcc2742 Abel Vesa 2023-03-27  283  	}
a9e1199fcc2742 Abel Vesa 2023-03-27  284  
a9e1199fcc2742 Abel Vesa 2023-03-27  285  	pdev = of_find_device_by_node(node);
a9e1199fcc2742 Abel Vesa 2023-03-27  286  	if (!pdev) {
a9e1199fcc2742 Abel Vesa 2023-03-27  287  		dev_err(dev, "Cannot find device node %s\n", node->name);
a9e1199fcc2742 Abel Vesa 2023-03-27  288  		goto out;
a9e1199fcc2742 Abel Vesa 2023-03-27  289  	}
a9e1199fcc2742 Abel Vesa 2023-03-27  290  
a9e1199fcc2742 Abel Vesa 2023-03-27  291  	ice = platform_get_drvdata(pdev);
a9e1199fcc2742 Abel Vesa 2023-03-27  292  	if (!ice) {
a9e1199fcc2742 Abel Vesa 2023-03-27  293  		dev_err(dev, "Cannot get ice\n");
a9e1199fcc2742 Abel Vesa 2023-03-27  294  		put_device(&pdev->dev);
a9e1199fcc2742 Abel Vesa 2023-03-27  295  		return ERR_PTR(-ENODEV);
a9e1199fcc2742 Abel Vesa 2023-03-27  296  	}
a9e1199fcc2742 Abel Vesa 2023-03-27  297  
a9e1199fcc2742 Abel Vesa 2023-03-27  298  out:
a9e1199fcc2742 Abel Vesa 2023-03-27  299  	of_node_put(node);
a9e1199fcc2742 Abel Vesa 2023-03-27  300  
a9e1199fcc2742 Abel Vesa 2023-03-27  301  	return ice;
a9e1199fcc2742 Abel Vesa 2023-03-27  302  }
a9e1199fcc2742 Abel Vesa 2023-03-27  303  EXPORT_SYMBOL_GPL(of_qcom_ice_get);
a9e1199fcc2742 Abel Vesa 2023-03-27  304  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
