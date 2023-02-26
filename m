Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE626A32E4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBZQnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBZQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:43:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B2B471;
        Sun, 26 Feb 2023 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677429785; x=1708965785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PARJCqxKU6lXd7WNvTros8YIqtOYtgJ/UmFexCKEVYw=;
  b=D9/EWzypDbOgI1qzOJu414PHNFjQzKbF6CN7dSo8yK68q2HTeYHFtvbL
   Qpa7RHF+9lpILyJ2qhR+z5NUKBb/50ADaqEwFkGUgvb1dsbe+RWA8VLm+
   PO7CEBFB185OSTJmho47Jh/2wdmwoK+gTB87/1v4pvqT5btvfEpucSdon
   8M3ts4ocyYhl2639ws9hCKnmf1zt2LlzY09Ey44pPfj9EW+Zu32z9hHwf
   ODTBvj8Za+fIweEWBO9UdctNCCnBegXDjBCe1dPjq8u0b7i4StkktsemI
   aOYOoVEziEdqOauyxns/SnyvPwmz7yt5EfTOk+x+LyP+hSlRvYTEqjr2p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332451415"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="332451415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 08:43:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="650934214"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="650934214"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2023 08:43:02 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWK73-0003p9-0x;
        Sun, 26 Feb 2023 16:43:01 +0000
Date:   Mon, 27 Feb 2023 00:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kang Chen <void0red@gmail.com>, konrad.dybcio@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        agross@kernel.org, andersson@kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: Re: [PATCH] hwspinlock: add a check of devm_regmap_field_alloc in
 qcom_hwspinlock_probe
Message-ID: <202302270034.DqtDwv49-lkp@intel.com>
References: <20230226144545.4187442-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226144545.4187442-1-void0red@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20230225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kang-Chen/hwspinlock-add-a-check-of-devm_regmap_field_alloc-in-qcom_hwspinlock_probe/20230226-224824
patch link:    https://lore.kernel.org/r/20230226144545.4187442-1-void0red%40gmail.com
patch subject: [PATCH] hwspinlock: add a check of devm_regmap_field_alloc in qcom_hwspinlock_probe
config: hexagon-randconfig-r041-20230226 (https://download.01.org/0day-ci/archive/20230227/202302270034.DqtDwv49-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b5a6ded03f6367c5e698c758864f3e569f1f762c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kang-Chen/hwspinlock-add-a-check-of-devm_regmap_field_alloc-in-qcom_hwspinlock_probe/20230226-224824
        git checkout b5a6ded03f6367c5e698c758864f3e569f1f762c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwspinlock/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270034.DqtDwv49-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/hwspinlock/qcom_hwspinlock.c:8:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/hwspinlock/qcom_hwspinlock.c:8:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/hwspinlock/qcom_hwspinlock.c:8:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/hwspinlock/qcom_hwspinlock.c:201:4: error: expected ')'
                           return -ENOMEM;
                           ^
   drivers/hwspinlock/qcom_hwspinlock.c:200:6: note: to match this '('
                   if (IS_ERR(bank->lock[i].priv)
                      ^
   6 warnings and 1 error generated.


vim +201 drivers/hwspinlock/qcom_hwspinlock.c

   168	
   169	static int qcom_hwspinlock_probe(struct platform_device *pdev)
   170	{
   171		struct hwspinlock_device *bank;
   172		struct reg_field field;
   173		struct regmap *regmap;
   174		size_t array_size;
   175		u32 stride;
   176		u32 base;
   177		int i;
   178	
   179		regmap = qcom_hwspinlock_probe_syscon(pdev, &base, &stride);
   180		if (IS_ERR(regmap) && PTR_ERR(regmap) == -ENODEV)
   181			regmap = qcom_hwspinlock_probe_mmio(pdev, &base, &stride);
   182	
   183		if (IS_ERR(regmap))
   184			return PTR_ERR(regmap);
   185	
   186		array_size = QCOM_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
   187		bank = devm_kzalloc(&pdev->dev, sizeof(*bank) + array_size, GFP_KERNEL);
   188		if (!bank)
   189			return -ENOMEM;
   190	
   191		platform_set_drvdata(pdev, bank);
   192	
   193		for (i = 0; i < QCOM_MUTEX_NUM_LOCKS; i++) {
   194			field.reg = base + i * stride;
   195			field.lsb = 0;
   196			field.msb = 31;
   197	
   198			bank->lock[i].priv = devm_regmap_field_alloc(&pdev->dev,
   199								     regmap, field);
   200			if (IS_ERR(bank->lock[i].priv)
 > 201				return -ENOMEM;
   202		}
   203	
   204		return devm_hwspin_lock_register(&pdev->dev, bank, &qcom_hwspinlock_ops,
   205						 0, QCOM_MUTEX_NUM_LOCKS);
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
