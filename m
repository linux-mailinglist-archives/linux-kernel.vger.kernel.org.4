Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4367FA36
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 19:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbjA1S1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 13:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjA1S05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 13:26:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC52413A;
        Sat, 28 Jan 2023 10:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674930413; x=1706466413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H34/gJbDq4+JIR5uFeM8higdX76HQfP4/UQEFCIjdP4=;
  b=N3QAIGlNc76i/nuP0Gh09hxnIXYur85dPMeD8ZvkPpObGUR11HemxYwZ
   Ob1U+n7CWI3+2mUwuOFXXFxeQUh3f6sF3Kt+jCresmPOv2jeBPuglvJFS
   As4wKlpccRsUzWot2NBZhlAvVK7p/V51cJBYr9TpGaqCcsDbkvqe11A87
   1sAQk8uFVESmTPQt0VCM7nP8hj5vLeyWtwqiCvj0gWm/X7KFeQ0V4gMyd
   Yib0j1WkG6cMBZ5j7mdGMhiDeAGGNFWvwP+ZIeIB1k+ffEMB56QsSBTyM
   zLcmhxTJYFxO/skGVHptoYtdIc7sKxBC6v+BzEtnTjq2ZbI+iHrOaxK0U
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="306969667"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="306969667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 10:26:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="992421344"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="992421344"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jan 2023 10:26:46 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLpuX-0000z9-2G;
        Sat, 28 Jan 2023 18:26:45 +0000
Date:   Sun, 29 Jan 2023 02:26:22 +0800
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
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com
Subject: Re: [PATCH v6 5/7] cdx: add cdx controller
Message-ID: <202301290233.80xUAwYL-lkp@intel.com>
References: <20230126104630.15493-6-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126104630.15493-6-nipun.gupta@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: powerpc-buildonly-randconfig-r004-20230129 (https://download.01.org/0day-ci/archive/20230129/202301290233.80xUAwYL-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f412d73800370b8e51d1be454e651d3c4ff796a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nipun-Gupta/cdx-add-the-cdx-bus-driver/20230128-161622
        git checkout f412d73800370b8e51d1be454e651d3c4ff796a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/cdx/controller/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/cdx/controller/cdx_controller.c:102:13: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
                      ^
>> drivers/cdx/controller/cdx_controller.c:102:11: error: incompatible integer to pointer conversion assigning to 'struct cdx_mcdi *' from 'int' [-Wint-conversion]
           cdx_mcdi = kzalloc(sizeof(*cdx_mcdi), GFP_KERNEL);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cdx/controller/cdx_controller.c:115:6: error: incompatible integer to pointer conversion assigning to 'struct cdx_controller *' from 'int' [-Wint-conversion]
           cdx = kzalloc(sizeof(*cdx), GFP_KERNEL);
               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/cdx/controller/cdx_controller.c:131:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           kfree(cdx_mcdi);
           ^
   drivers/cdx/controller/cdx_controller.c:141:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           kfree(cdx);
           ^
   5 errors generated.
--
>> drivers/cdx/controller/mcdi.c:272:2: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           CDX_POPULATE_DWORD_7(hdr[0],
           ^
   drivers/cdx/controller/bitfield.h:72:30: note: expanded from macro 'CDX_POPULATE_DWORD_7'
   #define CDX_POPULATE_DWORD_7 CDX_POPULATE_DWORD
                                ^
   drivers/cdx/controller/bitfield.h:69:32: note: expanded from macro 'CDX_POPULATE_DWORD'
           (dword).cdx_u32 = cpu_to_le32(CDX_INSERT_FIELDS(__VA_ARGS__))
                                         ^
   drivers/cdx/controller/bitfield.h:60:3: note: expanded from macro 'CDX_INSERT_FIELDS'
           (CDX_INSERT_FIELD(field1, (value1)) |           \
            ^
   drivers/cdx/controller/bitfield.h:46:3: note: expanded from macro 'CDX_INSERT_FIELD'
           (FIELD_PREP(GENMASK(CDX_HIGH_BIT(field),                \
            ^
>> drivers/cdx/controller/mcdi.c:635:12: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           respseq = CDX_DWORD_FIELD(outbuf[0], MCDI_HEADER_SEQ);
                     ^
   drivers/cdx/controller/bitfield.h:38:3: note: expanded from macro 'CDX_DWORD_FIELD'
           (FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),    \
            ^
   drivers/cdx/controller/mcdi.c:692:12: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           respcmd = CDX_DWORD_FIELD(outbuf[0], MCDI_HEADER_CODE);
                     ^
   drivers/cdx/controller/bitfield.h:38:3: note: expanded from macro 'CDX_DWORD_FIELD'
           (FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),    \
            ^
   3 errors generated.
--
>> drivers/cdx/controller/mcdi_functions.c:25:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return MCDI_DWORD(outbuf, CDX_BUS_ENUM_BUSES_OUT_BUS_COUNT);
                  ^
   drivers/cdx/controller/mcdi.h:223:2: note: expanded from macro 'MCDI_DWORD'
           CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
           ^
   drivers/cdx/controller/bitfield.h:38:3: note: expanded from macro 'CDX_DWORD_FIELD'
           (FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),    \
            ^
>> drivers/cdx/controller/mcdi_functions.c:35:2: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           MCDI_SET_DWORD(inbuf, CDX_BUS_ENUM_DEVICES_IN_BUS, bus_num);
           ^
   drivers/cdx/controller/mcdi.h:221:2: note: expanded from macro 'MCDI_SET_DWORD'
           CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field), CDX_DWORD, _value)
           ^
   drivers/cdx/controller/bitfield.h:84:2: note: expanded from macro 'CDX_POPULATE_DWORD_1'
           CDX_POPULATE_DWORD_2(dword, CDX_DWORD, 0, __VA_ARGS__)
           ^
   drivers/cdx/controller/bitfield.h:82:2: note: expanded from macro 'CDX_POPULATE_DWORD_2'
           CDX_POPULATE_DWORD_3(dword, CDX_DWORD, 0, __VA_ARGS__)
           ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/cdx/controller/bitfield.h:69:32: note: expanded from macro 'CDX_POPULATE_DWORD'
           (dword).cdx_u32 = cpu_to_le32(CDX_INSERT_FIELDS(__VA_ARGS__))
                                         ^
   drivers/cdx/controller/bitfield.h:60:3: note: expanded from macro 'CDX_INSERT_FIELDS'
           (CDX_INSERT_FIELD(field1, (value1)) |           \
            ^
   drivers/cdx/controller/bitfield.h:46:3: note: expanded from macro 'CDX_INSERT_FIELD'
           (FIELD_PREP(GENMASK(CDX_HIGH_BIT(field),                \
            ^
   drivers/cdx/controller/mcdi_functions.c:45:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return MCDI_DWORD(outbuf, CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT);
                  ^
   drivers/cdx/controller/mcdi.h:223:2: note: expanded from macro 'MCDI_DWORD'
           CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
           ^
   drivers/cdx/controller/bitfield.h:38:3: note: expanded from macro 'CDX_DWORD_FIELD'
           (FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),    \
            ^
   drivers/cdx/controller/mcdi_functions.c:59:2: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           MCDI_SET_DWORD(inbuf, CDX_BUS_GET_DEVICE_CONFIG_IN_BUS, bus_num);
           ^
   drivers/cdx/controller/mcdi.h:221:2: note: expanded from macro 'MCDI_SET_DWORD'
           CDX_POPULATE_DWORD_1(*_MCDI_DWORD(_buf, _field), CDX_DWORD, _value)
           ^
   drivers/cdx/controller/bitfield.h:84:2: note: expanded from macro 'CDX_POPULATE_DWORD_1'
           CDX_POPULATE_DWORD_2(dword, CDX_DWORD, 0, __VA_ARGS__)
           ^
   drivers/cdx/controller/bitfield.h:82:2: note: expanded from macro 'CDX_POPULATE_DWORD_2'
           CDX_POPULATE_DWORD_3(dword, CDX_DWORD, 0, __VA_ARGS__)
           ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   drivers/cdx/controller/bitfield.h:69:32: note: expanded from macro 'CDX_POPULATE_DWORD'
           (dword).cdx_u32 = cpu_to_le32(CDX_INSERT_FIELDS(__VA_ARGS__))
                                         ^
   drivers/cdx/controller/bitfield.h:60:3: note: expanded from macro 'CDX_INSERT_FIELDS'
           (CDX_INSERT_FIELD(field1, (value1)) |           \
            ^
   drivers/cdx/controller/bitfield.h:46:3: note: expanded from macro 'CDX_INSERT_FIELD'
           (FIELD_PREP(GENMASK(CDX_HIGH_BIT(field),                \
            ^
   drivers/cdx/controller/mcdi_functions.c:73:11: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           req_id = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_REQUESTER_ID);
                    ^
   drivers/cdx/controller/mcdi.h:223:2: note: expanded from macro 'MCDI_DWORD'
           CDX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), CDX_DWORD)
           ^
   drivers/cdx/controller/bitfield.h:38:3: note: expanded from macro 'CDX_DWORD_FIELD'
           (FIELD_GET(GENMASK(CDX_HIGH_BIT(field), CDX_LOW_BIT(field)),    \
            ^
   5 errors generated.


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
