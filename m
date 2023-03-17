Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663CE6BDDDF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjCQBB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:01:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576ECB6D19;
        Thu, 16 Mar 2023 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679014913; x=1710550913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=90aXFT30DnFK60tUbNIT7GTgbDigZvOI9/EjEEL+EKw=;
  b=TPUuqqpS38x4KPGyXpQOm2XV6FhbtqelJgOU4RQuUHtJSdO3lhwigzfR
   nHp7XOW6G+8keIn5Qf9H+4dCXHOa977gAvG7289Cu0AeuY5QkJF6Wj9p0
   S52x2NVMTBDnmUgP1lqsa4r9MhDmts6n0/PuevGClhNhbOkFg6YmvzB6M
   ul6MFvSUDerDnOtCcQPvglk9+ibs2IzOdLDUXBaPhsrDohKRMQcy3DY0T
   L/poWvhm3VWSYa/ShWuIJpPbyJq1+RwWMRUP04JTwb8V4kRPndG+9OhsP
   EFkmNxo4oofvHrFIHsJuCbX/Cer+FJrI7t15+TngORCXj/4iR3+gDA3bD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317806976"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="317806976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 18:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="710335151"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="710335151"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2023 18:01:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcyTd-0008wQ-23;
        Fri, 17 Mar 2023 01:01:49 +0000
Date:   Fri, 17 Mar 2023 09:01:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        mazziesaccount@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <202303170813.jSOLGCL5-lkp@intel.com>
References: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on next-20230316]
[cannot apply to linus/master v6.3-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k%40gmail.com
patch subject: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230317/202303170813.jSOLGCL5-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/40c75341c42d0e5bea5d73961202978a4be41cd2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mehdi-Djait/dt-bindings-iio-Add-KX132-accelerometer/20230317-075056
        git checkout 40c75341c42d0e5bea5d73961202978a4be41cd2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303170813.jSOLGCL5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/accel/kionix-kx022a.c: In function '__kx022a_fifo_flush':
>> drivers/iio/accel/kionix-kx022a.c:598:9: warning: ISO C90 forbids variable length array 'buffer' [-Wvla]
     598 |         __le16 buffer[data->chip_info->fifo_length * 3];
         |         ^~~~~~
--
   drivers/iio/accel/kionix-kx022a-i2c.c: In function 'kx022a_i2c_probe':
>> drivers/iio/accel/kionix-kx022a-i2c.c:27:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      27 |         chip_info = device_get_match_data(&i2c->dev);
         |                   ^
   drivers/iio/accel/kionix-kx022a-i2c.c:29:27: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      29 |                 chip_info = (const struct kx022a_chip_info *) id->driver_data;
         |                           ^
--
   drivers/iio/accel/kionix-kx022a-spi.c: In function 'kx022a_spi_probe':
>> drivers/iio/accel/kionix-kx022a-spi.c:27:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      27 |         chip_info = device_get_match_data(&spi->dev);
         |                   ^
   drivers/iio/accel/kionix-kx022a-spi.c:29:27: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      29 |                 chip_info = (const struct kx022a_chip_info *) id->driver_data;
         |                           ^


vim +/buffer +598 drivers/iio/accel/kionix-kx022a.c

   593	
   594	static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
   595				       bool irq)
   596	{
   597		struct kx022a_data *data = iio_priv(idev);
 > 598		__le16 buffer[data->chip_info->fifo_length * 3];
   599		uint64_t sample_period;
   600		int count, fifo_bytes;
   601		bool renable = false;
   602		int64_t tstamp;
   603		int ret, i;
   604	
   605		fifo_bytes = kx022a_get_fifo_bytes(data);
   606		count = fifo_bytes / KX_FIFO_SAMPLES_SIZE_BYTES;
   607		if (!count)
   608			return 0;
   609	
   610		/*
   611		 * If we are being called from IRQ handler we know the stored timestamp
   612		 * is fairly accurate for the last stored sample. Otherwise, if we are
   613		 * called as a result of a read operation from userspace and hence
   614		 * before the watermark interrupt was triggered, take a timestamp
   615		 * now. We can fall anywhere in between two samples so the error in this
   616		 * case is at most one sample period.
   617		 */
   618		if (!irq) {
   619			/*
   620			 * We need to have the IRQ disabled or we risk of messing-up
   621			 * the timestamps. If we are ran from IRQ, then the
   622			 * IRQF_ONESHOT has us covered - but if we are ran by the
   623			 * user-space read we need to disable the IRQ to be on a safe
   624			 * side. We do this usng synchronous disable so that if the
   625			 * IRQ thread is being ran on other CPU we wait for it to be
   626			 * finished.
   627			 */
   628			disable_irq(data->irq);
   629			renable = true;
   630	
   631			data->old_timestamp = data->timestamp;
   632			data->timestamp = iio_get_time_ns(idev);
   633		}
   634	
   635		/*
   636		 * Approximate timestamps for each of the sample based on the sampling
   637		 * frequency, timestamp for last sample and number of samples.
   638		 *
   639		 * We'd better not use the current bandwidth settings to compute the
   640		 * sample period. The real sample rate varies with the device and
   641		 * small variation adds when we store a large number of samples.
   642		 *
   643		 * To avoid this issue we compute the actual sample period ourselves
   644		 * based on the timestamp delta between the last two flush operations.
   645		 */
   646		if (data->old_timestamp) {
   647			sample_period = data->timestamp - data->old_timestamp;
   648			do_div(sample_period, count);
   649		} else {
   650			sample_period = data->odr_ns;
   651		}
   652		tstamp = data->timestamp - (count - 1) * sample_period;
   653	
   654		if (samples && count > samples) {
   655			/*
   656			 * Here we leave some old samples to the buffer. We need to
   657			 * adjust the timestamp to match the first sample in the buffer
   658			 * or we will miscalculate the sample_period at next round.
   659			 */
   660			data->timestamp -= (count - samples) * sample_period;
   661			count = samples;
   662		}
   663	
   664		fifo_bytes = count * KX_FIFO_SAMPLES_SIZE_BYTES;
   665		ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
   666					&buffer[0], fifo_bytes);
   667		if (ret)
   668			goto renable_out;
   669	
   670		for (i = 0; i < count; i++) {
   671			__le16 *sam = &buffer[i * 3];
   672			__le16 *chs;
   673			int bit;
   674	
   675			chs = &data->scan.channels[0];
   676			for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
   677				chs[bit] = sam[bit];
   678	
   679			iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
   680	
   681			tstamp += sample_period;
   682		}
   683	
   684		ret = count;
   685	
   686	renable_out:
   687		if (renable)
   688			enable_irq(data->irq);
   689	
   690		return ret;
   691	}
   692	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
