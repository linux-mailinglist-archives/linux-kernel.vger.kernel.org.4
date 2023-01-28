Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712B467F7D6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjA1Mpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 07:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjA1Mpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 07:45:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA7493DF;
        Sat, 28 Jan 2023 04:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674909942; x=1706445942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5WBaJzgPqwEeJyKfKa2dgk9LEXgRCs5k6shDAwh9+E=;
  b=Wqu46WD03WDNzASUYMv0gzRIfHEaCfRqDuCXETe9PPWsWV42adABDhGB
   M78QyJeCiiphQxkUoKvhkjRbbrGkeReIz4yyf++gweN+3tjFv/fmd4/31
   1IFNXsTecByKSZTn7fGruQwaStI64NV+LcdeGK+a5cJm3GGHZAMjyJ+kO
   KITQQaz0Hke6tidCXE8mWpYwqL6+QQkLAOQ40lGNcGoC/S858YkyXLpWv
   EU6W1cxlAq5BNJxS8THP/1DZtkYmLJjIascWafYxIkeOoq/mD7jvqLJeD
   WFv4fyOixQZ8hPWrzgJwHZ+qsPA84hpMUBodLPZe3Csq+XFTbd2eUiD2J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="329415206"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="329415206"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 04:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="787501973"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="787501973"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jan 2023 04:45:34 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLkaG-0000eR-1i;
        Sat, 28 Jan 2023 12:45:28 +0000
Date:   Sat, 28 Jan 2023 20:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nipun Gupta <nipun.gupta@amd.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com
Subject: Re: [PATCH v6 5/7] cdx: add cdx controller
Message-ID: <202301282010.JreX4WjQ-lkp@intel.com>
References: <20230126104630.15493-6-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126104630.15493-6-nipun.gupta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nipun,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230127]
[cannot apply to masahiroy-kbuild/for-next masahiroy-kbuild/fixes robh/for-next joro-iommu/next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nipun-Gupta/cdx-add-the-cdx-bus-driver/20230128-161622
patch link:    https://lore.kernel.org/r/20230126104630.15493-6-nipun.gupta%40amd.com
patch subject: [PATCH v6 5/7] cdx: add cdx controller
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230128/202301282010.JreX4WjQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f412d73800370b8e51d1be454e651d3c4ff796a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nipun-Gupta/cdx-add-the-cdx-bus-driver/20230128-161622
        git checkout f412d73800370b8e51d1be454e651d3c4ff796a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/cdx/controller/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/cdx/controller/cdx_controller.c: In function 'xlnx_cdx_probe':
>> drivers/cdx/controller/cdx_controller.c:102:20: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     102 |         cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
         |                    ^~~~~~~
>> drivers/cdx/controller/cdx_controller.c:102:18: warning: assignment to 'struct cdx_mcdi *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     102 |         cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
         |                  ^
>> drivers/cdx/controller/cdx_controller.c:115:13: warning: assignment to 'struct cdx_controller *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     115 |         cdx = kzalloc(sizeof(*cdx), GFP_KERNEL);
         |             ^
>> drivers/cdx/controller/cdx_controller.c:131:9: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     131 |         kfree(cdx_mcdi);
         |         ^~~~~
         |         kvfree
   cc1: some warnings being treated as errors


vim +/kzalloc +102 drivers/cdx/controller/cdx_controller.c

    95	
    96	static int xlnx_cdx_probe(struct platform_device *pdev)
    97	{
    98		struct cdx_controller *cdx;
    99		struct cdx_mcdi *cdx_mcdi;
   100		int ret;
   101	
 > 102		cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
   103		if (!cdx_mcdi)
   104			return -ENOMEM;
   105	
   106		/* Store the MCDI ops */
   107		cdx_mcdi->mcdi_ops = &mcdi_ops;
   108		/* MCDI FW: Initialize the FW path */
   109		ret = cdx_mcdi_init(cdx_mcdi);
   110		if (ret) {
   111			dev_err_probe(&pdev->dev, ret, "MCDI Initialization failed\n");
   112			goto mcdi_init_fail;
   113		}
   114	
 > 115		cdx = kzalloc(sizeof(*cdx), GFP_KERNEL);
   116		if (!cdx) {
   117			ret = -ENOMEM;
   118			goto cdx_alloc_fail;
   119		}
   120		platform_set_drvdata(pdev, cdx);
   121	
   122		cdx->dev = &pdev->dev;
   123		cdx->priv = cdx_mcdi;
   124		cdx->ops = &cdx_ops;
   125	
   126		return 0;
   127	
   128	cdx_alloc_fail:
   129		cdx_mcdi_finish(cdx_mcdi);
   130	mcdi_init_fail:
 > 131		kfree(cdx_mcdi);
   132	
   133		return ret;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
