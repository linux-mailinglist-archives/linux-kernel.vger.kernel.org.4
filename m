Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CD715949
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjE3JAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjE3JAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:00:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7624B2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685437220; x=1716973220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rTflTYiV3VKyBm981Ml2WLipgh57SbrnaZBjjFs8J7A=;
  b=iqHEU7GNUpMwkO+cXY7zo4U/ulCJ1/GS3SYv4mpV7auZfUfsbuN9ABJC
   7SoqNd/FFvX66DeH0VKEjYAq/QNx3j+I6Fi61EYSLnQO5L1fa678piisu
   GBeXoZMoJSX9pXrkVblOzYY9Vdj1xxaY4beO/lcqZpNwxhV9/qlkCs25P
   AMuooWEROHG4iou/BsVRzYurSoGbBGiDwu2ErXrL4FOXamR6j0yv8+X83
   Ti33zqbit0DljPekfxH5yHKkGqHmp9BPcoTyVApDKytIZnJVg3i91d8K4
   Tp0EKhfGvJ6DDltk3pOhaxS8xZl7jxuDEQ9n2dYvI0Qditay9UQrrnYEC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335207057"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="335207057"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="880689121"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="880689121"
Received: from lkp-server01.sh.intel.com (HELO fd90924b3b99) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 02:00:16 -0700
Received: from kbuild by fd90924b3b99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3vDE-0000Eo-2X;
        Tue, 30 May 2023 09:00:16 +0000
Date:   Tue, 30 May 2023 17:00:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v5 5/6] drm/etnaviv: expand driver support for the PCI
 devices
Message-ID: <202305301659.4guSLavL-lkp@intel.com>
References: <20230529172452.2148819-6-suijingfeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529172452.2148819-6-suijingfeng@loongson.cn>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.4-rc4 next-20230530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-etnaviv-add-a-dedicated-function-to-register-an-irq-handler/20230530-012547
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230529172452.2148819-6-suijingfeng%40loongson.cn
patch subject: [PATCH v5 5/6] drm/etnaviv: expand driver support for the PCI devices
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230530/202305301659.4guSLavL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1d05a5fa048dd4b2a934ffbb07c330ddd9279287
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-etnaviv-add-a-dedicated-function-to-register-an-irq-handler/20230530-012547
        git checkout 1d05a5fa048dd4b2a934ffbb07c330ddd9279287
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/etnaviv/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305301659.4guSLavL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c: In function 'etnaviv_gpu_pci_fini':
>> drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c:32:9: error: implicit declaration of function 'pci_clear_master'; did you mean 'pci_set_master'? [-Werror=implicit-function-declaration]
      32 |         pci_clear_master(pdev);
         |         ^~~~~~~~~~~~~~~~
         |         pci_set_master
   cc1: some warnings being treated as errors


vim +32 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c

    27	
    28	static void etnaviv_gpu_pci_fini(struct etnaviv_gpu *gpu, bool component)
    29	{
    30		struct pci_dev *pdev = to_pci_dev(gpu->dev);
    31	
  > 32		pci_clear_master(pdev);
    33	
    34		dev_dbg(gpu->dev, "component is %s\n",
    35			component ? "enabled" : "disabled");
    36	}
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
