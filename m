Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A069F72AEE0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 22:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjFJUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 16:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjFJUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 16:54:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A682D46
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 13:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686430441; x=1717966441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZOXSVwmZKqTp3oD9fdi1X/eZyvyTPufuz/ImDOZpwGA=;
  b=BzdWxGjO7pevU6Pnj+w3DQ4eK5MMgrm7ZbEY+ZozrxjEY0Nk7sZLcAx7
   8HergO1gBzLjkogxh7fExKZ3bUtdglGdR1XesJ2V/DiV3VkZ8vRArtCEo
   YjcrSAFn9t7SWsvYMuR8nIqk6fVM6uwRd2fSIAe+klR7OUwQbp9JygzGE
   +ZbLm6uUBf7Ek1WwfXHzc1GkE+rmcOkwm5JJ4G3gVNY8SVheNgEhpLB8/
   ZY02LO0HE3InqIzuv/v/+S1rJ/n0GEqawIi75MEJNu5fEpvnloWfWPM54
   Ob52VjRzaofqCVlUcS7nquVF/mgUhR9jzScfH9QJLlkf6+K6LN04EbpvX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="361168177"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="361168177"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 13:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="688137502"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="688137502"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2023 13:53:59 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q85aw-000AQ4-2r;
        Sat, 10 Jun 2023 20:53:58 +0000
Date:   Sun, 11 Jun 2023 04:53:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202306110422.14XhzmV6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   64569520920a3ca5d456ddd9f4f95fc6ea9b8b45
commit: 29814986b82e820ae9d3eb7474cdcf66605bd114 remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
date:   5 months ago
config: arm64-randconfig-s052-20230611 (https://download.01.org/0day-ci/archive/20230611/202306110422.14XhzmV6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce:
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29814986b82e820ae9d3eb7474cdcf66605bd114
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 29814986b82e820ae9d3eb7474cdcf66605bd114
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306110422.14XhzmV6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse:     expected void *mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:528:26: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *dtb_mem_region @@     got void [noderef] __iomem * @@
   drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse:     expected void *dtb_mem_region
   drivers/remoteproc/qcom_q6v5_pas.c:550:30: sparse:     got void [noderef] __iomem *

vim +550 drivers/remoteproc/qcom_q6v5_pas.c

   508	
   509	static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
   510	{
   511		struct device_node *node;
   512		struct resource r;
   513		int ret;
   514	
   515		node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
   516		if (!node) {
   517			dev_err(adsp->dev, "no memory-region specified\n");
   518			return -EINVAL;
   519		}
   520	
   521		ret = of_address_to_resource(node, 0, &r);
   522		of_node_put(node);
   523		if (ret)
   524			return ret;
   525	
   526		adsp->mem_phys = adsp->mem_reloc = r.start;
   527		adsp->mem_size = resource_size(&r);
 > 528		adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
   529		if (!adsp->mem_region) {
   530			dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
   531				&r.start, adsp->mem_size);
   532			return -EBUSY;
   533		}
   534	
   535		if (!adsp->dtb_pas_id)
   536			return 0;
   537	
   538		node = of_parse_phandle(adsp->dev->of_node, "memory-region", 1);
   539		if (!node) {
   540			dev_err(adsp->dev, "no dtb memory-region specified\n");
   541			return -EINVAL;
   542		}
   543	
   544		ret = of_address_to_resource(node, 0, &r);
   545		if (ret)
   546			return ret;
   547	
   548		adsp->dtb_mem_phys = adsp->dtb_mem_reloc = r.start;
   549		adsp->dtb_mem_size = resource_size(&r);
 > 550		adsp->dtb_mem_region = devm_ioremap_wc(adsp->dev, adsp->dtb_mem_phys, adsp->dtb_mem_size);
   551		if (!adsp->dtb_mem_region) {
   552			dev_err(adsp->dev, "unable to map dtb memory region: %pa+%zx\n",
   553				&r.start, adsp->dtb_mem_size);
   554			return -EBUSY;
   555		}
   556	
   557		return 0;
   558	}
   559	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
