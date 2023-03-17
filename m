Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55ED6BE054
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCQE6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQE6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:58:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432622333B;
        Thu, 16 Mar 2023 21:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679029088; x=1710565088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ijJdMJrDfBIOhYz8/mY8hquUBOVRWAoRCh0dBI911A=;
  b=WhL3Wjqlkbb4FfWJ9sQgfGuSpK/L/pbKeOVYgKKdby9Gk1Co3rPBTswL
   VLKz+USbdQ0sTVxwjGxXaYpib80baNt6y0sEC+QotrIg52c04atSOgrmM
   5NHyYunJ+LQjHqKOzp3Xx3cr9H8JKMCDtckQAaoAXUKl/CzlHTFdcS8c8
   dYDT5CQ93O/9dq6P1PPG+iAp881N34FAWqShJY5mSyXVihm6L4efIDmbV
   98UBfsxkOEktrwexT2ub/y9xoR4pnticOXhydnXEqyLvxmLOuEMS+19Si
   iN1io+aQ9MtywEI5/U2p9FyGTRAg1cepCGuwXdWEo/xWg8pR8JnWxFjhY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="340548459"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="340548459"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 21:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="673426784"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="673426784"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 16 Mar 2023 21:58:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd2A8-00096O-2L;
        Fri, 17 Mar 2023 04:57:56 +0000
Date:   Fri, 17 Mar 2023 12:57:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        mazziesaccount@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <202303171208.uYJzdkrv-lkp@intel.com>
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on next-20230317]
[cannot apply to linus/master v6.3-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k%40gmail.com
patch subject: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
config: i386-randconfig-a011-20230313 (https://download.01.org/0day-ci/archive/20230317/202303171208.uYJzdkrv-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/40c75341c42d0e5bea5d73961202978a4be41cd2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
        git checkout 40c75341c42d0e5bea5d73961202978a4be41cd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303171208.uYJzdkrv-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/accel/kionix-kx022a-i2c.c:27:12: error: assigning to 'struct kx022a_chip_info *' from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           chip_info = device_get_match_data(&i2c->dev);
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/kionix-kx022a-i2c.c:29:13: error: assigning to 'struct kx022a_chip_info *' from 'const struct kx022a_chip_info *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   chip_info = (const struct kx022a_chip_info *) id->driver_data;
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.
--
>> drivers/iio/accel/kionix-kx022a.c:598:16: warning: variable length array used [-Wvla]
           __le16 buffer[data->chip_info->fifo_length * 3];
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.
--
>> drivers/iio/accel/kionix-kx022a-spi.c:27:12: error: assigning to 'struct kx022a_chip_info *' from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           chip_info = device_get_match_data(&spi->dev);
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/kionix-kx022a-spi.c:29:13: error: assigning to 'struct kx022a_chip_info *' from 'const struct kx022a_chip_info *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                   chip_info = (const struct kx022a_chip_info *) id->driver_data;
                             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +27 drivers/iio/accel/kionix-kx022a-i2c.c

    14	
    15	static int kx022a_i2c_probe(struct i2c_client *i2c)
    16	{
    17		struct device *dev = &i2c->dev;
    18		struct kx022a_chip_info *chip_info;
    19		struct regmap *regmap;
    20		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
    21	
    22		if (!i2c->irq) {
    23			dev_err(dev, "No IRQ configured\n");
    24			return -EINVAL;
    25		}
    26	
  > 27		chip_info = device_get_match_data(&i2c->dev);
    28		if (!chip_info)
  > 29			chip_info = (const struct kx022a_chip_info *) id->driver_data;
    30	
    31		regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
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
