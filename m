Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40296B6209
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCKX0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:26:10 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288214DBC0;
        Sat, 11 Mar 2023 15:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678577169; x=1710113169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mz0AjCkzbKeCmHlb639eYZ4/FdPvCjYWrfnrVIuqxSc=;
  b=DFXSsL4200Yup8VAMmk7PbcebK7IgxEqXZfUb4vUiL/+dVmU7ZQh9C0u
   0UyL7IOzR7U/yOFHic8cOrKhnDceGyYSFjPJaEDm06RtraZ9hIoS9we6S
   /+NqPdkmqL/5XgnpQd/vaQIvoDwAFoRpc20TVQmBkYK0HHULWvcwTZOlH
   BrDcayEqKDFw7ZFfHwaxmXOgzku5M9cQo5uveWPoWFCV3j8j4fbplEMyJ
   dsAkjlriYH1LmBUr+qmw+ZE2jblt/pwZFU06DAWTaLtRwr10D7qTy1udn
   JB/Jb7tFjeLInWCMWTMX8E4yADjaRElC2/4oPm2KZUSY+4JSimpksPIjD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399544207"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="399544207"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 15:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="708419426"
X-IronPort-AV: E=Sophos;i="5.98,253,1673942400"; 
   d="scan'208";a="708419426"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Mar 2023 15:26:05 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pb8bE-0004qn-18;
        Sat, 11 Mar 2023 23:26:04 +0000
Date:   Sun, 12 Mar 2023 07:25:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nishanth Menon <nm@ti.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, Bryan Brattlof <bb@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: Add k3-am625-beagleplay
Message-ID: <202303120702.ccWtDwJU-lkp@intel.com>
References: <20230311111022.23717-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230311111022.23717-3-nm@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on krzk/for-next krzk-mem-ctrl/for-next linus/master v6.3-rc1 next-20230310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nishanth-Menon/dt-bindings-arm-ti-Add-bindings-for-BeaglePlay/20230311-191215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230311111022.23717-3-nm%40ti.com
patch subject: [PATCH 2/3] arm64: dts: ti: Add k3-am625-beagleplay
config: arm64-randconfig-r011-20230312 (https://download.01.org/0day-ci/archive/20230312/202303120702.ccWtDwJU-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/95427154e987290b162289c090d9e12ac9a71d9e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nishanth-Menon/dt-bindings-arm-ti-Add-bindings-for-BeaglePlay/20230311-191215
        git checkout 95427154e987290b162289c090d9e12ac9a71d9e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303120702.ccWtDwJU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
