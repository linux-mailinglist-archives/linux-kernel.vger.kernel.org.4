Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F86F8718
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjEEQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEEQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:55:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B6D191FE;
        Fri,  5 May 2023 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683305726; x=1714841726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/M3gQoGII5mFFWeYtKEFpt2tNhHvNDZduPkof6u7PJI=;
  b=UpHJVENn437M+n9lmiP+GLzIJOrpBDmvNpqajdiBISoz3YOFFVz69K/5
   YDVCIytbNqnKONgQPTWKhss/W5g/QV80K3TdhmjChBNLe8Ut3rY4oruYy
   JAzcF2TiQn+xhm7yV5c+4RDh+e36g8uAoGmhlnSo+Y1Sx+kAVo5/pWqXJ
   3MmncCUbX5tBVazT04UjurUSiMOIv6uQA7n5gVnUMb55ez7qPECP+If/N
   7x7/NBSBpFtOKhI1EbEwyaNbz1ABDswJkUXO3Y8TJ3PPYNPfEq9WfM22e
   jj2y4sCQZOxo7mz9xjjySbd45LPp+PXoHbQzvJRFmOR0PIVG0iLq32NBt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349289701"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349289701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="728156604"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="728156604"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2023 09:55:23 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puyiI-0000lV-2P;
        Fri, 05 May 2023 16:55:22 +0000
Date:   Sat, 6 May 2023 00:55:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure
 sensor
Message-ID: <202305060054.AFXCprUA-lkp@intel.com>
References: <ZFUC/3zBFQRBsYUk@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFUC/3zBFQRBsYUk@arbad>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on 457391b0380335d5e9a5babdec90ac53928b23b4]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mprls0025pa-sensor/20230505-212836
base:   457391b0380335d5e9a5babdec90ac53928b23b4
patch link:    https://lore.kernel.org/r/ZFUC%2F3zBFQRBsYUk%40arbad
patch subject: [PATCH v4 2/3] iio: pressure: Honeywell mprls0025pa pressure sensor
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230506/202305060054.AFXCprUA-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2e6fb6a53d15af5fb86052a7d5d64c4d343157d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andreas-Klinger/dt-bindings-iio-pressure-Support-Honeywell-mprls0025pa-sensor/20230505-212836
        git checkout 2e6fb6a53d15af5fb86052a7d5d64c4d343157d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305060054.AFXCprUA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/iio/pressure/mprls0025pa.c:18:
   drivers/iio/pressure/mprls0025pa.c: In function 'mpr_read_pressure':
>> drivers/iio/pressure/mprls0025pa.c:178:30: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     178 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:178:17: note: in expansion of macro 'dev_err'
     178 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                 ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:178:70: note: format string is defined here
     178 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                                                                     ~^
         |                                                                      |
         |                                                                      unsigned int
         |                                                                     %lu
   drivers/iio/pressure/mprls0025pa.c:221:30: warning: format '%u' expects argument of type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=]
     221 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:221:17: note: in expansion of macro 'dev_err'
     221 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                 ^~~~~~~
   drivers/iio/pressure/mprls0025pa.c:221:70: note: format string is defined here
     221 |                 dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
         |                                                                     ~^
         |                                                                      |
         |                                                                      unsigned int
         |                                                                     %lu


vim +178 drivers/iio/pressure/mprls0025pa.c

   144	
   145	/**
   146	 * mpr_read_pressure() - Read pressure value from sensor via I2C
   147	 * @data: Pointer to private data struct.
   148	 * @press: Output value read from sensor.
   149	 *
   150	 * Reading from the sensor by sending and receiving I2C telegrams.
   151	 *
   152	 * If there is an end of conversion (EOC) interrupt registered the function
   153	 * waits for a maximum of one second for the interrupt.
   154	 *
   155	 * Context: The function can sleep and data->lock should be held when calling it
   156	 * Return:
   157	 * * 0		- OK, the pressure value could be read
   158	 * * -ETIMEDOUT	- Timeout while waiting for the EOC interrupt or busy flag is
   159	 *		  still set after nloops attempts of reading
   160	 */
   161	static int mpr_read_pressure(struct mpr_data *data, s32 *press)
   162	{
   163		struct device *dev = &data->client->dev;
   164		int ret, i;
   165		u8 wdata[] = {0xAA, 0x00, 0x00};
   166		s32 status;
   167		int nloops = 10;
   168		u8 buf[5];
   169	
   170		reinit_completion(&data->completion);
   171	
   172		ret = i2c_master_send(data->client, wdata, sizeof(wdata));
   173		if (ret < 0) {
   174			dev_err(dev, "error while writing ret: %d\n", ret);
   175			return ret;
   176		}
   177		if (ret != sizeof(wdata)) {
 > 178			dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
   179									sizeof(wdata));
   180			return -EIO;
   181		}
   182	
   183		if (data->irq > 0) {
   184			ret = wait_for_completion_timeout(&data->completion, HZ);
   185			if (!ret) {
   186				dev_err(dev, "timeout while waiting for eoc irq\n");
   187				return -ETIMEDOUT;
   188			}
   189		} else {
   190			/* wait until status indicates data is ready */
   191			for (i = 0; i < nloops; i++) {
   192				/*
   193				 * datasheet only says to wait at least 5 ms for the
   194				 * data but leave the maximum response time open
   195				 * --> let's try it nloops (10) times which seems to be
   196				 *     quite long
   197				 */
   198				usleep_range(5000, 10000);
   199				status = i2c_smbus_read_byte(data->client);
   200				if (status < 0) {
   201					dev_err(dev,
   202						"error while reading, status: %d\n",
   203						status);
   204					return status;
   205				}
   206				if (!(status & MPR_I2C_BUSY))
   207					break;
   208			}
   209			if (i == nloops) {
   210				dev_err(dev, "timeout while reading\n");
   211				return -ETIMEDOUT;
   212			}
   213		}
   214	
   215		ret = i2c_master_recv(data->client, buf, sizeof(buf));
   216		if (ret < 0) {
   217			dev_err(dev, "error in i2c_master_recv ret: %d\n", ret);
   218			return ret;
   219		}
   220		if (ret != sizeof(buf)) {
   221			dev_err(dev, "received size doesn't fit - ret: %d / %u\n", ret,
   222									sizeof(buf));
   223			return -EIO;
   224		}
   225	
   226		if (buf[0] & MPR_I2C_BUSY) {
   227			/*
   228			 * it should never be the case that status still indicates
   229			 * business
   230			 */
   231			dev_err(dev, "data still not ready: %08x\n", buf[0]);
   232			return -ETIMEDOUT;
   233		}
   234	
   235		*press = get_unaligned_be24(&buf[1]);
   236	
   237		dev_dbg(dev, "received: %*ph cnt: %d\n", ret, buf, *press);
   238	
   239		return 0;
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
