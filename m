Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315316A32D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBZQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:32:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D1C1B555;
        Sun, 26 Feb 2023 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677429125; x=1708965125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDTv/+Ng0xD08RBhJx3v0/Xro4Wp1Fh/Ij2PGrRb2FY=;
  b=RLPKCfQweDUcfqqGESel6B1XFpgxRTomZhvb7IORpuff64qU7nAz+QLL
   8dX8nNTMfeH3UNxJeVvX0b20cLSp4pOzysWTe/EaFjf6MMkoFukYnBxtv
   jM5ym4d7Dt25teexulrQJfKDhHsEzlOU+B7bxTBjB4pnOcOup2fDyRuQ/
   KmTyq8L8sJI5GvC95SjaLSldqPM1r9hsO+6k3DHffxdPKTZHadcf21aW/
   tWTs4+qlpixQ5k1D4Ex5EyBqVKjB1zvP+AEQlxiTGKqV+Ze6pIFGVpoYw
   Ec3oR1hauwJFZdJ0jxoIeLrBK1n8Hkn2aEwXs6TWQSL0VthZRXUXc8igp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332450552"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="332450552"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 08:32:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="650932936"
X-IronPort-AV: E=Sophos;i="5.97,330,1669104000"; 
   d="scan'208";a="650932936"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2023 08:32:01 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWJwP-0003p1-0l;
        Sun, 26 Feb 2023 16:32:01 +0000
Date:   Mon, 27 Feb 2023 00:31:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kang Chen <void0red@gmail.com>, konrad.dybcio@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, agross@kernel.org,
        andersson@kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: Re: [PATCH] hwspinlock: add a check of devm_regmap_field_alloc in
 qcom_hwspinlock_probe
Message-ID: <202302270016.oJqq1tKy-lkp@intel.com>
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
[also build test ERROR on v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kang-Chen/hwspinlock-add-a-check-of-devm_regmap_field_alloc-in-qcom_hwspinlock_probe/20230226-224824
patch link:    https://lore.kernel.org/r/20230226144545.4187442-1-void0red%40gmail.com
patch subject: [PATCH] hwspinlock: add a check of devm_regmap_field_alloc in qcom_hwspinlock_probe
config: arm-randconfig-r046-20230226 (https://download.01.org/0day-ci/archive/20230227/202302270016.oJqq1tKy-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b5a6ded03f6367c5e698c758864f3e569f1f762c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kang-Chen/hwspinlock-add-a-check-of-devm_regmap_field_alloc-in-qcom_hwspinlock_probe/20230226-224824
        git checkout b5a6ded03f6367c5e698c758864f3e569f1f762c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwspinlock/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302270016.oJqq1tKy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hwspinlock/qcom_hwspinlock.c: In function 'qcom_hwspinlock_probe':
>> drivers/hwspinlock/qcom_hwspinlock.c:200:47: error: expected ')' before 'return'
     200 |                 if (IS_ERR(bank->lock[i].priv)
         |                    ~                          ^
         |                                               )
     201 |                         return -ENOMEM;
         |                         ~~~~~~                 
>> drivers/hwspinlock/qcom_hwspinlock.c:202:9: error: expected expression before '}' token
     202 |         }
         |         ^


vim +200 drivers/hwspinlock/qcom_hwspinlock.c

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
 > 200			if (IS_ERR(bank->lock[i].priv)
   201				return -ENOMEM;
 > 202		}
   203	
   204		return devm_hwspin_lock_register(&pdev->dev, bank, &qcom_hwspinlock_ops,
   205						 0, QCOM_MUTEX_NUM_LOCKS);
   206	}
   207	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
