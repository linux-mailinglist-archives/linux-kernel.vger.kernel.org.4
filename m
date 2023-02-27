Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C808F6A466E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjB0PsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0PsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:48:07 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C79A27F;
        Mon, 27 Feb 2023 07:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677512886; x=1709048886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNlXYdVcu8iYvoqJ6fSj0TqDF6B1s6Rt+D937qVXnp8=;
  b=F7D4K7S6HmLxY0fyj9NuYyAwGURSeQFxJKF1YWc2QXjAD0w3DTRDY43Y
   jEyFAL8tF8EciTUn7KyTo6FlfXiEzXAozfexIMKeff44X9BRA9S8I8ma4
   OZV8W6ikLiWT0HQWksSUqDemsF0cg6f90syfKVgDYlxJzsd3RYHT5MxaR
   1heWCDx0d2bLB9koV6V8OZikOtoDn15LyaYon+opflgZxyO6YagRVQ5Zr
   whHs3kqjUzHpocEPS7Nf8UoKQqTvvPnIKWoz/CSYb6ivyxW98uG3kLegD
   ZFcMo5B2cYBP3BVIVsXSZwgUlBMHQhcJ4BKztSNjFw3qUYuNsiNiKBl/b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332609580"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="332609580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 07:47:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="623621427"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="623621427"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Feb 2023 07:47:47 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWfj8-0004Xf-2J;
        Mon, 27 Feb 2023 15:47:46 +0000
Date:   Mon, 27 Feb 2023 23:47:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <202302272311.tpyMXtCV-lkp@intel.com>
References: <20230227133255.32301-2-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227133255.32301-2-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.2]
[cannot apply to jic23-iio/togreg linus/master next-20230227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Looijmans/iio-adc-Add-TI-ADS1100-and-ADS1000/20230227-213529
patch link:    https://lore.kernel.org/r/20230227133255.32301-2-mike.looijmans%40topic.nl
patch subject: [PATCH v2 2/2] iio: adc: Add TI ADS1100 and ADS1000
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230227/202302272311.tpyMXtCV-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8bc0b6e697641a7c6274a492bf210faccdeb55bf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mike-Looijmans/iio-adc-Add-TI-ADS1100-and-ADS1000/20230227-213529
        git checkout 8bc0b6e697641a7c6274a492bf210faccdeb55bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302272311.tpyMXtCV-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ti-ads1100.c: In function 'ads1100_data_bits':
>> drivers/iio/adc/ti-ads1100.c:87:39: error: implicit declaration of function 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=implicit-function-declaration]
      87 |         return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
         |                                       ^~~~~~~~~
         |                                       FOLL_GET
   drivers/iio/adc/ti-ads1100.c: In function 'ads1100_set_data_rate':
>> drivers/iio/adc/ti-ads1100.c:156:41: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     156 |                                         FIELD_PREP(ADS1100_DR_MASK, i));
         |                                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +87 drivers/iio/adc/ti-ads1100.c

    84	
    85	static int ads1100_data_bits(struct ads1100_data *data)
    86	{
  > 87		return ads1100_data_rate_bits[FIELD_GET(ADS1100_DR_MASK, data->config)];
    88	}
    89	
    90	static int ads1100_get_adc_result(struct ads1100_data *data, int chan, int *val)
    91	{
    92		int ret;
    93		__be16 buffer;
    94		s16 value;
    95	
    96		if (chan != 0)
    97			return -EINVAL;
    98	
    99		ret = pm_runtime_resume_and_get(&data->client->dev);
   100		if (ret < 0)
   101			return ret;
   102	
   103		ret = i2c_master_recv(data->client, (char *)&buffer, sizeof(buffer));
   104	
   105		pm_runtime_mark_last_busy(&data->client->dev);
   106		pm_runtime_put_autosuspend(&data->client->dev);
   107	
   108		if (ret < 0) {
   109			dev_err(&data->client->dev, "I2C read fail: %d\n", ret);
   110			return ret;
   111		}
   112	
   113		/* Value is always 16-bit 2's complement */
   114		value = be16_to_cpu(buffer);
   115		/* Shift result to compensate for bit resolution vs. sample rate */
   116		value <<= 16 - ads1100_data_bits(data);
   117		*val = sign_extend32(value, 15);
   118	
   119		return 0;
   120	}
   121	
   122	static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
   123	{
   124		int microvolts;
   125		int gain;
   126		int i;
   127	
   128		/* With Vdd between 2.7 and 5V, the scale is always below 1 */
   129		if (val)
   130			return -EINVAL;
   131	
   132		microvolts = regulator_get_voltage(data->reg_vdd);
   133		/* Calculate: gain = ((microvolts / 1000) / (val2 / 1000000)) >> 15 */
   134		gain = ((microvolts + BIT(14)) >> 15) * 1000 / val2;
   135	
   136		for (i = 0; i < 4; i++) {
   137			if (BIT(i) == gain) {
   138				ads1100_set_config_bits(data, ADS1100_PGA_MASK, i);
   139				return 0;
   140			}
   141		}
   142	
   143		return -EINVAL;
   144	}
   145	
   146	static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
   147	{
   148		unsigned int i;
   149		unsigned int size;
   150	
   151		size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
   152		for (i = 0; i < size; ++i) {
   153			if (ads1100_data_rate[i] == rate) {
   154				return ads1100_set_config_bits(
   155						data, ADS1100_DR_MASK,
 > 156						FIELD_PREP(ADS1100_DR_MASK, i));
   157			}
   158		}
   159	
   160		return -EINVAL;
   161	}
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
