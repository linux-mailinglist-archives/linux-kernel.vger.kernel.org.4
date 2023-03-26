Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E55E6C98B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCZX3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCZX27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:28:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198049F0;
        Sun, 26 Mar 2023 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679873338; x=1711409338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZqzYgx1wmMTF/ya4EIk39hGV+DkzN55FNJE6pa1ltX8=;
  b=elCUTxu9gscNzKHoJDw8370z+1KHDPbTY2qpeNbv5ehVdrNuNrrjNF9l
   FfJ1Sv1Fylnt5/TN3LGVVwrNM512Tab57y/LdhQKkXQPV3Rxpadek7hp+
   Fy9vxHMFIHfsai3XkIYebtAhbstpzQ2hwh/lPtRkhuI2JhE1yEH/VSRtO
   rPPyx5xr7hx/6X+63aYSiyLWUX7rAtJgBvZdbD0v14ewWWcAxxlvMBRgF
   e0RZtpogmM5DoRhOKQT69ysgmulK30m33fo+n+eui94lTBQWuJFvjEHtP
   xnnCR5FCkxmvReQoRREUQZl+4U1FuDqUnuqw46VsxtvU4uFzsf7QNZHdX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="319798684"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="319798684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 16:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="857471050"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="857471050"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 Mar 2023 16:28:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pgZnC-000HPD-1v;
        Sun, 26 Mar 2023 23:28:54 +0000
Date:   Mon, 27 Mar 2023 07:28:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joy Chakraborty <joychakr@google.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com, Joy Chakraborty <joychakr@google.com>
Subject: Re: [PATCH v3 2/2] spi: dw: Add dma controller capability checks
Message-ID: <202303270715.w9sMJhIh-lkp@intel.com>
References: <20230326173511.710749-3-joychakr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326173511.710749-3-joychakr@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-spi/for-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joy-Chakraborty/spi-dw-Add-32-bpw-support-to-DW-DMA-Controller/20230327-013645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
patch link:    https://lore.kernel.org/r/20230326173511.710749-3-joychakr%40google.com
patch subject: [PATCH v3 2/2] spi: dw: Add dma controller capability checks
config: arc-randconfig-s041-20230326 (https://download.01.org/0day-ci/archive/20230327/202303270715.w9sMJhIh-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9962c1acd23cb0766a09948c1bee4f29950b8a96
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Joy-Chakraborty/spi-dw-Add-32-bpw-support-to-DW-DMA-Controller/20230327-013645
        git checkout 9962c1acd23cb0766a09948c1bee4f29950b8a96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303270715.w9sMJhIh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/spi/spi-dw-dma.c:241:56: sparse: sparse: marked inline, but without a definition

vim +241 drivers/spi/spi-dw-dma.c

f89a6d8f43ebe9 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  240  
57784411728ff4 drivers/spi/spi-dw-dma.c Serge Semin     2020-05-29 @241  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
57784411728ff4 drivers/spi/spi-dw-dma.c Serge Semin     2020-05-29  242  {
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  243  	switch (n_bytes) {
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  244  	case 1:
e31abce778bc05 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  245  		return DMA_SLAVE_BUSWIDTH_1_BYTE;
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  246  	case 2:
e31abce778bc05 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  247  		return DMA_SLAVE_BUSWIDTH_2_BYTES;
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  248  	case 3:
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  249  	case 4:
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  250  		return DMA_SLAVE_BUSWIDTH_4_BYTES;
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  251  	default:
e31abce778bc05 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  252  		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
e31abce778bc05 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  253  	}
80de96dae70648 drivers/spi/spi-dw-dma.c Joy Chakraborty 2023-03-26  254  }
e31abce778bc05 drivers/spi/spi-dw-mid.c Andy Shevchenko 2015-03-09  255  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
