Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8A6E8802
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjDTCgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjDTCgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:36:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1277E49C6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681958175; x=1713494175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h9lJLb6T+BZfNqQ0RRBDG+ud1sTD37uwQ6hC7BLE4Ro=;
  b=HhXsu1WZOmKksGTC4N8DFHWtrnGA/3pbrPT5vFQcAK1s7hYl8pUMc/I9
   +R7CLbneBbhTLPmoA5xcyGM1o3r1zaxEpjZeeIFtJO7PG3c33wWY1eyid
   9gUPL8U9EUnyDh51luhwsPb2mYsu2C3qvhSbSuUHkNeudIGnKnTxh/huM
   Bgl7d5IKUGREMWHLDGmN9Hk8OqjFeegIyOwTPHHOynb2eJjA1uzmwwkjd
   TmDztePmJJtninU8wVG2G7GwoTdPoNynfBa91/uKlNPVMy/Y7NXulQnp1
   L8ZanPjnhdwlsl3Hy+op/JXgzjkLxtLSXzqTDUDz/HOk/IP2N+UFZqzgt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325945923"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="325945923"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 19:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803153321"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="803153321"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2023 19:36:13 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppK9c-000fOU-1A;
        Thu, 20 Apr 2023 02:36:12 +0000
Date:   Thu, 20 Apr 2023 10:35:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Sharma <anupnewsmail@gmail.com>, zbr@ioremap.net
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: w1: slaves: Drop unnecessary explicit casting
Message-ID: <202304201037.YqeNgQrk-lkp@intel.com>
References: <ZECFjQMLwnoYPMeL@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZECFjQMLwnoYPMeL@yoga>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.3-rc7 next-20230419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anup-Sharma/drivers-w1-slaves-Drop-unnecessary-explicit-casting/20230420-082340
patch link:    https://lore.kernel.org/r/ZECFjQMLwnoYPMeL%40yoga
patch subject: [PATCH] drivers: w1: slaves: Drop unnecessary explicit casting
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230420/202304201037.YqeNgQrk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/211461ea088a31e3a084fd539e243c9d32db3cb6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anup-Sharma/drivers-w1-slaves-Drop-unnecessary-explicit-casting/20230420-082340
        git checkout 211461ea088a31e3a084fd539e243c9d32db3cb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/w1/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201037.YqeNgQrk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from drivers/w1/slaves/w1_ds2433.c:11:
   drivers/w1/slaves/w1_ds2433.c: In function 'eeprom_write':
>> drivers/w1/slaves/w1_ds2433.c:216:35: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'loff_t' {aka 'long long int'} [-Wformat=]
     216 |                 dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/w1/slaves/w1_ds2433.c:216:17: note: in expansion of macro 'dev_err'
     216 |                 dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                 ^~~~~~~
   drivers/w1/slaves/w1_ds2433.c:216:62: note: format string is defined here
     216 |                 dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                                                             ~^
         |                                                              |
         |                                                              void *
         |                                                             %lld
   drivers/w1/slaves/w1_ds2433.c:224:43: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'loff_t' {aka 'long long int'} [-Wformat=]
     224 |                         dev_err(&sl->dev, "bad CRC at offset %pe\n", off);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/w1/slaves/w1_ds2433.c:224:25: note: in expansion of macro 'dev_err'
     224 |                         dev_err(&sl->dev, "bad CRC at offset %pe\n", off);
         |                         ^~~~~~~
   drivers/w1/slaves/w1_ds2433.c:224:63: note: format string is defined here
     224 |                         dev_err(&sl->dev, "bad CRC at offset %pe\n", off);
         |                                                              ~^
         |                                                               |
         |                                                               void *
         |                                                              %lld
--
   In file included from include/linux/device.h:15,
                    from drivers/w1/slaves/w1_ds28e04.c:11:
   drivers/w1/slaves/w1_ds28e04.c: In function 'eeprom_write':
>> drivers/w1/slaves/w1_ds28e04.c:237:43: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'loff_t' {aka 'long long int'} [-Wformat=]
     237 |                         dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/w1/slaves/w1_ds28e04.c:237:25: note: in expansion of macro 'dev_err'
     237 |                         dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                         ^~~~~~~
   drivers/w1/slaves/w1_ds28e04.c:237:70: note: format string is defined here
     237 |                         dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
         |                                                                     ~^
         |                                                                      |
         |                                                                      void *
         |                                                                     %lld
   drivers/w1/slaves/w1_ds28e04.c:246:51: warning: format '%p' expects argument of type 'void *', but argument 3 has type 'loff_t' {aka 'long long int'} [-Wformat=]
     246 |                                 dev_err(&sl->dev, "bad CRC at offset %pe\n",
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/w1/slaves/w1_ds28e04.c:246:33: note: in expansion of macro 'dev_err'
     246 |                                 dev_err(&sl->dev, "bad CRC at offset %pe\n",
         |                                 ^~~~~~~
   drivers/w1/slaves/w1_ds28e04.c:246:71: note: format string is defined here
     246 |                                 dev_err(&sl->dev, "bad CRC at offset %pe\n",
         |                                                                      ~^
         |                                                                       |
         |                                                                       void *
         |                                                                      %lld


vim +216 drivers/w1/slaves/w1_ds2433.c

   202	
   203	static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
   204				    struct bin_attribute *bin_attr, char *buf,
   205				    loff_t off, size_t count)
   206	{
   207		struct w1_slave *sl = kobj_to_w1_slave(kobj);
   208		int addr, len, idx;
   209	
   210		if ((count = w1_f23_fix_count(off, count, W1_EEPROM_SIZE)) == 0)
   211			return 0;
   212	
   213	#ifdef CONFIG_W1_SLAVE_DS2433_CRC
   214		/* can only write full blocks in cached mode */
   215		if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
 > 216			dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
   217				off, count);
   218			return -EINVAL;
   219		}
   220	
   221		/* make sure the block CRCs are valid */
   222		for (idx = 0; idx < count; idx += W1_PAGE_SIZE) {
   223			if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE) != CRC16_VALID) {
   224				dev_err(&sl->dev, "bad CRC at offset %pe\n", off);
   225				return -EINVAL;
   226			}
   227		}
   228	#endif	/* CONFIG_W1_SLAVE_DS2433_CRC */
   229	
   230		mutex_lock(&sl->master->bus_mutex);
   231	
   232		/* Can only write data to one page at a time */
   233		idx = 0;
   234		while (idx < count) {
   235			addr = off + idx;
   236			len = W1_PAGE_SIZE - (addr & W1_PAGE_MASK);
   237			if (len > (count - idx))
   238				len = count - idx;
   239	
   240			if (w1_f23_write(sl, addr, len, &buf[idx]) < 0) {
   241				count = -EIO;
   242				goto out_up;
   243			}
   244			idx += len;
   245		}
   246	
   247	out_up:
   248		mutex_unlock(&sl->master->bus_mutex);
   249	
   250		return count;
   251	}
   252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
