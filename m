Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D716E9E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjDTWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDTWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:05:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4DEB;
        Thu, 20 Apr 2023 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682028299; x=1713564299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QLTm7S7Qy0Ej6mfl0KwCOlaAKC/xPF/JLj0bt0xnj1E=;
  b=Gb7ueCvr88+Ru5BpHfXeRXWo/XOzBdsZW0ysuiM+WOkl4gFiitfcMPea
   4tTr+p7fplGzCyWmi7nd36VnklbrmJ3fSrtUVrYunN5/llPNliq7CkF3v
   WOrs/rNB087l+JfO3n1XM0dNIj7YMG+DDnCW+1wG7TFdI8dD8++YQdvsA
   vmwr3W2v9JrHZ0nCzeqmYI9SQAP+a9SVeCnzKbjzCUOZsJfzhdd8LJURo
   iBCeCgOprk9n94xuhRFVYr550MfQD5ilUIZk6doCrMiVXy5oespfOC6+G
   4LfPZrfZmt+F+iKINQ0lGZSoNDTNGEJEVI/dsNET+I3aOAQ/ghYA8/Y0D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="344614348"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="344614348"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 15:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="685523795"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="685523795"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2023 15:04:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppcOd-000g8W-1Y;
        Thu, 20 Apr 2023 22:04:55 +0000
Date:   Fri, 21 Apr 2023 06:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <202304210512.5qdqDRgd-lkp@intel.com>
References: <ZEGZ7VMrqaPNzhwj@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEGZ7VMrqaPNzhwj@arbad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e0ee50101346ca9cef52da75e3fb4380c27c042a]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mprls0025pa-sensor/20230421-040254
base:   e0ee50101346ca9cef52da75e3fb4380c27c042a
patch link:    https://lore.kernel.org/r/ZEGZ7VMrqaPNzhwj%40arbad
patch subject: [PATCH v3 2/3] iio: pressure: Honeywell mprls0025pa pressure sensor
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230421/202304210512.5qdqDRgd-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3d6a7eae49611392fb6f7563dcb71b74f12a0a78
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mprls0025pa-sensor/20230421-040254
        git checkout 3d6a7eae49611392fb6f7563dcb71b74f12a0a78
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304210512.5qdqDRgd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from drivers/iio/pressure/mprls0025pa.c:17:
   drivers/iio/pressure/mprls0025pa.c: In function 'mpr_read_pressure':
>> drivers/iio/pressure/mprls0025pa.c:169:30: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
     169 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(wdata));
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:169:17: note: in expansion of macro 'dev_err'
     169 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(wdata));
         |                 ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:169:70: note: format string is defined here
     169 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(wdata));
         |                                                                     ~^
         |                                                                      |
         |                                                                      int
         |                                                                     %ld
   drivers/iio/pressure/mprls0025pa.c:208:30: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
     208 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(buf));
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:208:17: note: in expansion of macro 'dev_err'
     208 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(buf));
         |                 ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:208:70: note: format string is defined here
     208 |                 dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(buf));
         |                                                                     ~^
         |                                                                      |
         |                                                                      int
         |                                                                     %ld


vim +169 drivers/iio/pressure/mprls0025pa.c

  > 17	#include <linux/i2c.h>
    18	#include <linux/module.h>
    19	#include <linux/mod_devicetable.h>
    20	#include <linux/device.h>
    21	#include <linux/gpio/consumer.h>
    22	#include <linux/regulator/consumer.h>
    23	#include <linux/math64.h>
    24	
    25	#include <asm/unaligned.h>
    26	
    27	#include <linux/iio/iio.h>
    28	#include <linux/iio/buffer.h>
    29	#include <linux/iio/triggered_buffer.h>
    30	#include <linux/iio/trigger_consumer.h>
    31	
    32	/* bits in i2c status byte */
    33	#define MPR_I2C_POWER	BIT(6)	/* device is powered */
    34	#define MPR_I2C_BUSY	BIT(5)	/* device is busy */
    35	#define MPR_I2C_MEMORY	BIT(2)	/* integrity test passed */
    36	#define MPR_I2C_MATH	BIT(0)	/* internal math saturation */
    37	
    38	#define MPR_NANO_PART	1000000000LL
    39	
    40	/*
    41	 * _INPUT interface:
    42	 * Calculation formular from the datasheet:
    43	 * pressure = (press_cnt - outputmin) * scale + pmin
    44	 * with:
    45	 * * pressure	- measured pressure in Pascal
    46	 * * press_cnt	- raw value read from sensor
    47	 * * pmin	- minimum pressure range value of sensor (data->pmin)
    48	 * * pmax	- maximum pressure range value of sensor (data->pmax)
    49	 * * outputmin	- minimum numerical range raw value delivered by sensor (MPR_OUT_MIN)
    50	 * * outputmax	- maximum numerical range raw value delivered by sensor (MPR_OUT_MAX)
    51	 * * scale	- (pmax - pmin) / (outputmax - outputmin)
    52	 *
    53	 * _RAW interface:
    54	 * pressure = (raw + offset) * scale
    55	 * --> need to adjust offset for fitting into _RAW interface
    56	 * Values for _RAW interface:
    57	 * * raw	- press_cnt
    58	 * * scale	- (pmax - pmin) / (outputmax - outputmin)
    59	 * * offset	- (-1 * outputmin) - pmin / scale
    60	 *                note: With all sensors from the datasheet pmin = 0 which reduces the offset to
    61	 *                (-1 * outputmin)
    62	 */
    63	
    64	/*
    65	 * transfer function A: 10%   to 90%   of 2^24
    66	 * transfer function B:  2.5% to 22.5% of 2^24
    67	 * transfer function C: 20%   to 80%   of 2^24
    68	 */
    69	enum mpr_func_id {
    70		MPR_FUNCTION_A,
    71		MPR_FUNCTION_B,
    72		MPR_FUNCTION_C,
    73	};
    74	
    75	struct mpr_func_spec {
    76		u32			output_min;
    77		u32			output_max;
    78	};
    79	
    80	static const struct mpr_func_spec mpr_func_spec[] = {
    81		[MPR_FUNCTION_A] = {.output_min = 1677722, .output_max = 15099494},
    82		[MPR_FUNCTION_B] = {.output_min =  419430, .output_max =  3774874},
    83		[MPR_FUNCTION_C] = {.output_min = 3355443, .output_max = 13421773},
    84	};
    85	
    86	struct mpr_chan {
    87		s32			pres;		/* pressure value */
    88		s64			ts;		/* timestamp */
    89	};
    90	
    91	struct mpr_data {
    92		struct i2c_client	*client;
    93		struct mutex		lock;		/* i2c transactions */
    94		u32			pmin;		/* minimal pressure in pascal */
    95		u32			pmax;		/* maximal pressure in pascal */
    96		u32			function;	/* transfer function */
    97		u32			outmin;		/* minimal numerical range raw value from sensor */
    98		u32			outmax;		/* maximal numerical range raw value from sensor */
    99		int                     scale;          /* int part of scale */
   100		int                     scale2;         /* nano part of scale */
   101		int                     offset;         /* int part of offset */
   102		int                     offset2;        /* nano part of offset */
   103		struct gpio_desc	*gpiod_reset;	/* reset */
   104		int			irq;		/* end of conversion interrupt */
   105		struct completion	completion;	/* handshake from irq to read */
   106		struct mpr_chan		chan;		/* channel values for buffered mode */
   107		struct regulator	*vdd;		/* optional external voltage regulator */
   108	};
   109	
   110	static const struct iio_chan_spec mpr_channels[] = {
   111		{
   112			.type = IIO_PRESSURE,
   113			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
   114						BIT(IIO_CHAN_INFO_SCALE) |
   115						BIT(IIO_CHAN_INFO_OFFSET),
   116			.scan_index = 0,
   117			.scan_type = {
   118				.sign = 's',
   119				.realbits = 32,
   120				.storagebits = 32,
   121				.endianness = IIO_CPU,
   122			},
   123		},
   124		IIO_CHAN_SOFT_TIMESTAMP(1),
   125	};
   126	
   127	static void mpr_reset(struct mpr_data *data)
   128	{
   129		if (data->gpiod_reset) {
   130			gpiod_set_value(data->gpiod_reset, 0);
   131			udelay(10);
   132			gpiod_set_value(data->gpiod_reset, 1);
   133		}
   134	}
   135	
   136	/**
   137	 * mpr_read_pressure() - Read pressure value from sensor via I2C
   138	 * @data: Pointer to private data struct.
   139	 * @press: Output value read from sensor.
   140	 *
   141	 * Reading from the sensor by sending and receiving I2C telegrams.
   142	 *
   143	 * If there is an end of conversion (EOC) interrupt registered the function waits for a maximum of
   144	 * one second for the interrupt.
   145	 *
   146	 * Context: The function can sleep and data->lock should be held when calling it.
   147	 * Return:
   148	 * * 0		- OK, the pressure value could be read
   149	 * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is still set after nloops
   150	 *		  attempts of reading
   151	 */
   152	static int mpr_read_pressure(struct mpr_data *data, s32 *press)
   153	{
   154		struct device *dev = &data->client->dev;
   155		int ret, i;
   156		u8 wdata[] = {0xAA, 0x00, 0x00};
   157		s32 status;
   158		int nloops = 10;
   159		u8 buf[5];
   160	
   161		reinit_completion(&data->completion);
   162	
   163		ret = i2c_master_send(data->client, wdata, sizeof(wdata));
   164		if (ret < 0) {
   165			dev_err(dev, "error while writing ret: %d\n", ret);
   166			return ret;
   167		}
   168		if (ret != sizeof(wdata)) {
 > 169			dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(wdata));
   170			return -EIO;
   171		}
   172	
   173		if (data->irq > 0) {
   174			ret = wait_for_completion_timeout(&data->completion, HZ);
   175			if (!ret) {
   176				dev_err(dev, "timeout while waiting for eoc interrupt\n");
   177				return -ETIMEDOUT;
   178			}
   179		} else {
   180			/* wait until status indicates data is ready */
   181			for (i = 0; i < nloops; i++) {
   182				/*
   183				 * datasheet only says to wait at least 5 ms for the data but leave the
   184				 * maximum response time open
   185				 * --> let's try it nloops (10) times which seems to be quite long
   186				 */
   187				usleep_range(5000, 10000);
   188				status = i2c_smbus_read_byte(data->client);
   189				if (status < 0) {
   190					dev_err(dev, "error while reading, status: %d\n", status);
   191					return status;
   192				}
   193				if (!(status & MPR_I2C_BUSY))
   194					break;
   195			}
   196			if (i == nloops) {
   197				dev_err(dev, "timeout while reading\n");
   198				return -ETIMEDOUT;
   199			}
   200		}
   201	
   202		ret = i2c_master_recv(data->client, buf, sizeof(buf));
   203		if (ret < 0) {
   204			dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
   205			return ret;
   206		}
   207		if (ret != sizeof(buf)) {
   208			dev_err(dev, "received size doesn't fit - ret: %d / %d\n", ret, sizeof(buf));
   209			return -EIO;
   210		}
   211	
   212		if (buf[0] & MPR_I2C_BUSY) {
   213			/* it should never be the case that status still indicates business */
   214			dev_err(dev, "data still not ready: %08x\n", buf[0]);
   215			return -ETIMEDOUT;
   216		}
   217	
   218		*press = get_unaligned_be24(&buf[1]);
   219	
   220		dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
   221	
   222		return 0;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
