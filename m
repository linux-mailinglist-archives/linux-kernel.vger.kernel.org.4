Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1AD6FF5CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbjEKPWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238623AbjEKPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:22:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4C18D;
        Thu, 11 May 2023 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683818545; x=1715354545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FsfjS41u2qx+ij80+EIng+hoUa8+xMlcVJCvISgDyDI=;
  b=Wao9e6AmUIa4pOjq/hNPRI3tS+PhthJfsNZ/89x5viSnY8NIMrv+GQXT
   Sl7cZnPzorm5C/pul/WX4iyzhpvVovj4/w/kkuXbzlAIxXusj1v3qk6dV
   qOFrQZXBuwWjAY8f1gXMMz2O63ZCIGS9QCPXaKp0G34pFIMzUVwnxGAc6
   INekYeRCNyYeHVARi9xhcs1jLpSOoqFEuuBjHlqjycrBYMmWvlIwMQy02
   SislygE6n7PnQafUsyUbumwTf7y3uEhSepS5eThZvMe3A38yXMvTBi22e
   n9OLahJTsZSpE1Qx7ngRhzd8+xhvteOPJK0DHjBLMhzHUzkwuj7+8Z87d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416146695"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="416146695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 08:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730401535"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="730401535"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 08:21:30 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1px86j-00044m-1C;
        Thu, 11 May 2023 15:21:29 +0000
Date:   Thu, 11 May 2023 23:21:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 2/2] hwmon: max31827: add MAX31827 driver
Message-ID: <202305112351.DBkFfs76-lkp@intel.com>
References: <20230508172427.23915-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508172427.23915-2-daniel.matyas@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linus/master v6.4-rc1 next-20230511]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Matyas/hwmon-max31827-add-MAX31827-driver/20230508-222643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230508172427.23915-2-daniel.matyas%40analog.com
patch subject: [PATCH v7 2/2] hwmon: max31827: add MAX31827 driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20230511/202305112351.DBkFfs76-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project b0fb98227c90adf2536c9ad644a74d5e92961111)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/89289262b54eadd8ac5f955bd358ed6d9a51908a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniel-Matyas/hwmon-max31827-add-MAX31827-driver/20230508-222643
        git checkout 89289262b54eadd8ac5f955bd358ed6d9a51908a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305112351.DBkFfs76-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/hwmon/max31827.c:12:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
>> drivers/hwmon/max31827.c:238:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (attr == hwmon_chip_update_interval) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/max31827.c:280:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/hwmon/max31827.c:238:3: note: remove the 'if' if its condition is always true
                   if (attr == hwmon_chip_update_interval) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/hwmon/max31827.c:134:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   7 warnings generated.


vim +238 drivers/hwmon/max31827.c

   128	
   129	static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
   130				 u32 attr, int channel, long *val)
   131	{
   132		struct max31827_state *st = dev_get_drvdata(dev);
   133		unsigned int uval;
   134		int ret;
   135	
   136		switch (type) {
   137		case hwmon_temp:
   138			switch (attr) {
   139			case hwmon_temp_enable:
   140				ret = regmap_read(st->regmap,
   141						  MAX31827_CONFIGURATION_REG, &uval);
   142				if (ret)
   143					break;
   144	
   145				uval = FIELD_GET(MAX31827_CONFIGURATION_1SHOT_MASK |
   146						 MAX31827_CONFIGURATION_CNV_RATE_MASK,
   147						 uval);
   148				*val = !!uval;
   149	
   150				break;
   151			case hwmon_temp_input:
   152				mutex_lock(&st->lock);
   153	
   154				if (!st->enable) {
   155					/*
   156					 * This operation requires mutex protection,
   157					 * because the chip configuration should not
   158					 * be changed during the conversion process.
   159					 */
   160	
   161					ret = regmap_update_bits(st->regmap,
   162								 MAX31827_CONFIGURATION_REG,
   163								 MAX31827_CONFIGURATION_1SHOT_MASK,
   164								 1);
   165					if (ret) {
   166						mutex_unlock(&st->lock);
   167						return ret;
   168					}
   169	
   170					msleep(MAX31827_12_BIT_CNV_TIME);
   171				}
   172				ret = regmap_read(st->regmap, MAX31827_T_REG, &uval);
   173	
   174				mutex_unlock(&st->lock);
   175	
   176				if (ret)
   177					break;
   178	
   179				*val = MAX31827_16_BIT_TO_M_DGR(uval);
   180	
   181				break;
   182			case hwmon_temp_max:
   183				ret = regmap_read(st->regmap, MAX31827_TH_REG, &uval);
   184				if (ret)
   185					break;
   186	
   187				*val = MAX31827_16_BIT_TO_M_DGR(uval);
   188				break;
   189			case hwmon_temp_max_hyst:
   190				ret = regmap_read(st->regmap, MAX31827_TH_HYST_REG,
   191						  &uval);
   192				if (ret)
   193					break;
   194	
   195				*val = MAX31827_16_BIT_TO_M_DGR(uval);
   196				break;
   197			case hwmon_temp_max_alarm:
   198				ret = regmap_read(st->regmap,
   199						  MAX31827_CONFIGURATION_REG, &uval);
   200				if (ret)
   201					break;
   202	
   203				*val = FIELD_GET(MAX31827_CONFIGURATION_O_TEMP_STAT_MASK,
   204						 uval);
   205				break;
   206			case hwmon_temp_min:
   207				ret = regmap_read(st->regmap, MAX31827_TL_REG, &uval);
   208				if (ret)
   209					break;
   210	
   211				*val = MAX31827_16_BIT_TO_M_DGR(uval);
   212				break;
   213			case hwmon_temp_min_hyst:
   214				ret = regmap_read(st->regmap, MAX31827_TL_HYST_REG,
   215						  &uval);
   216				if (ret)
   217					break;
   218	
   219				*val = MAX31827_16_BIT_TO_M_DGR(uval);
   220				break;
   221			case hwmon_temp_min_alarm:
   222				ret = regmap_read(st->regmap,
   223						  MAX31827_CONFIGURATION_REG, &uval);
   224				if (ret)
   225					break;
   226	
   227				*val = FIELD_GET(MAX31827_CONFIGURATION_U_TEMP_STAT_MASK,
   228						 uval);
   229				break;
   230			default:
   231				ret = -EOPNOTSUPP;
   232				break;
   233			}
   234	
   235			break;
   236	
   237		case hwmon_chip:
 > 238			if (attr == hwmon_chip_update_interval) {
   239				ret = regmap_read(st->regmap,
   240						  MAX31827_CONFIGURATION_REG, &uval);
   241				if (ret)
   242					break;
   243	
   244				uval = FIELD_GET(MAX31827_CONFIGURATION_CNV_RATE_MASK,
   245						 uval);
   246				switch (uval) {
   247				case MAX31827_CNV_1_DIV_64_HZ:
   248					*val = 64000;
   249					break;
   250				case MAX31827_CNV_1_DIV_32_HZ:
   251					*val = 32000;
   252					break;
   253				case MAX31827_CNV_1_DIV_16_HZ:
   254					*val = 16000;
   255					break;
   256				case MAX31827_CNV_1_DIV_4_HZ:
   257					*val = 4000;
   258					break;
   259				case MAX31827_CNV_1_HZ:
   260					*val = 1000;
   261					break;
   262				case MAX31827_CNV_4_HZ:
   263					*val = 250;
   264					break;
   265				case MAX31827_CNV_8_HZ:
   266					*val = 125;
   267					break;
   268				default:
   269					*val = 0;
   270					break;
   271				}
   272			}
   273			break;
   274	
   275		default:
   276			ret = -EOPNOTSUPP;
   277			break;
   278		}
   279	
   280		return ret;
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
