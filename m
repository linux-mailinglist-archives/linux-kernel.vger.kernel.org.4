Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAD6C272A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCUBPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUBO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F025591;
        Mon, 20 Mar 2023 18:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679361239; x=1710897239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neqS0div3l2OFqQ/6+ZJIu3ELpcYXAtz90xTmt6fo7Y=;
  b=i8e/TicJ5jmwwAHNB5nmIL7ERCq+APBIXd+FxSQ9GVBBy0uTapUyMVHH
   bzVD87DfJXJoQQheVUCXBNa3s0yVbRhCSiUKWjYGYDjiG0Q6+btrE7XoF
   J6NaBZD7BT9/vRdWPVJPvINjEKwIi5kjN7TnU7xe7yzwccQyCFg36CqXv
   bZUBusu0FmfNQIDDKMURdjCM/kLrvyG+jBHMB5cm+FI9nM7CKYRV2ukjm
   sxp9Mug/8DXRk/sFSHmGnAyXASBjVUbvBbJo51uuLS5K7RPyBg9Gbp/jz
   7TEI2OsGU0M7QOvBcg7m3373m9fDOF7esNXBQga6TXIhemxiU5HYEGQQV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="337535817"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="337535817"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674630692"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="674630692"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Mar 2023 18:06:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peQRw-000BSQ-2r;
        Tue, 21 Mar 2023 01:06:04 +0000
Date:   Tue, 21 Mar 2023 09:05:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        mazziesaccount@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <202303210809.RAQ7nfl7-lkp@intel.com>
References: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20230320]
[cannot apply to linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k%40gmail.com
patch subject: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
config: loongarch-randconfig-s032-20230319 (https://download.01.org/0day-ci/archive/20230321/202303210809.RAQ7nfl7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/40c75341c42d0e5bea5d73961202978a4be41cd2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
        git checkout 40c75341c42d0e5bea5d73961202978a4be41cd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210809.RAQ7nfl7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/accel/kionix-kx022a-spi.c:27:19: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct kx022a_chip_info *chip_info @@     got void const * @@
   drivers/iio/accel/kionix-kx022a-spi.c:27:19: sparse:     expected struct kx022a_chip_info *chip_info
   drivers/iio/accel/kionix-kx022a-spi.c:27:19: sparse:     got void const *
>> drivers/iio/accel/kionix-kx022a-spi.c:29:27: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct kx022a_chip_info *chip_info @@     got struct kx022a_chip_info const * @@
   drivers/iio/accel/kionix-kx022a-spi.c:29:27: sparse:     expected struct kx022a_chip_info *chip_info
   drivers/iio/accel/kionix-kx022a-spi.c:29:27: sparse:     got struct kx022a_chip_info const *

vim +27 drivers/iio/accel/kionix-kx022a-spi.c

    14	
    15	static int kx022a_spi_probe(struct spi_device *spi)
    16	{
    17		struct device *dev = &spi->dev;
    18		struct kx022a_chip_info *chip_info;
    19		struct regmap *regmap;
    20		const struct spi_device_id *id = spi_get_device_id(spi);
    21	
    22		if (!spi->irq) {
    23			dev_err(dev, "No IRQ configured\n");
    24			return -EINVAL;
    25		}
    26	
  > 27		chip_info = device_get_match_data(&spi->dev);
    28		if (!chip_info)
  > 29			chip_info = (const struct kx022a_chip_info *) id->driver_data;
    30	
    31		regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
    32		if (IS_ERR(regmap))
    33			return dev_err_probe(dev, PTR_ERR(regmap),
    34					     "Failed to initialize Regmap\n");
    35	
    36		return kx022a_probe_internal(dev, chip_info);
    37	}
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
