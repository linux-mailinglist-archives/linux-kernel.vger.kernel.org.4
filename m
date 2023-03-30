Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08B6CF7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjC3AI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjC3AIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:08:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE52340FE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680134900; x=1711670900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qReL1NQAo0s/ltkUWifMa5AxIawdGoSXs3VTdwExSJY=;
  b=foBWgyZ2kNEChckbB7b6WybJVbjBAyzQTt2pYjBoIz3Zt3XewmjhU6NR
   kap5TBYFofWNb0XE3J/+NLqWIt0pW6vcoeAp65oPJigvZvB7z9qF4DYAi
   6BCymdY2E/5bvP39rJuw39q/lPDZ6w5LJcLWg++0qnUrKvokn9TDQG70b
   KM7UvKZQHRIJcvbc2gCVMf0fLbVRnYlO9cKfKKLKpVMMz9jQN5Wp7mHyf
   Eg8U+aG1k05ePN66LkqPt6u60lC1/xS2PtLueKqifE55Z8zusIjiiXNUH
   vt4Il8GhqY43vmb+CVGZdvmkvsiqFVvDHpL5GBUofU+fbmkydKutjt+k9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341048610"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341048610"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:08:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753791960"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753791960"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Mar 2023 17:08:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phfpw-000K4W-2s;
        Thu, 30 Mar 2023 00:08:16 +0000
Date:   Thu, 30 Mar 2023 08:07:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: Re: [PATCH v3 5/6] drm/etnaviv: expand driver support for the pci
 devices
Message-ID: <202303300759.E9lbKNTQ-lkp@intel.com>
References: <20230329205129.1513734-6-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329205129.1513734-6-15330273260@189.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-etnaviv-add-a-dedicate-function-to-register-irq-handler-for-the-gpu/20230330-045519
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230329205129.1513734-6-15330273260%40189.cn
patch subject: [PATCH v3 5/6] drm/etnaviv: expand driver support for the pci devices
config: arc-randconfig-r043-20230329 (https://download.01.org/0day-ci/archive/20230330/202303300759.E9lbKNTQ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cfc3554b9fbd8ca3f3f6731d45d811bfa7fdf777
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-etnaviv-add-a-dedicate-function-to-register-irq-handler-for-the-gpu/20230330-045519
        git checkout cfc3554b9fbd8ca3f3f6731d45d811bfa7fdf777
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/etnaviv/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303300759.E9lbKNTQ-lkp@intel.com/

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
https://github.com/intel/lkp-tests
