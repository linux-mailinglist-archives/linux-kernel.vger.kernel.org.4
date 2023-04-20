Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390E76E8A65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjDTG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjDTG3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:29:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5546A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681972172; x=1713508172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IyOzyJAd/6ABxtofxBPj1J0sAalEL4tioDUX48t0eqQ=;
  b=OVMACydnUpKkMgigcsHtkNy4Pdc+CW2LCde0dNc8HqsTY/7kURxghnMJ
   InAYXpYfNjnMO6TiMVvryCvBw1BSXFEaEvtsaN8mk/+5TgZZ+xYBhbPcj
   SKfdwGxU0s/cQO8rAE9w/Jz8fL+ce6qP3gacv/6sfI1k68VpVssxY6esw
   lWJjOPX9vvqKIRLxU7SX0QC3Z3l76EnKSkJssXltN0JjSpDNdw0F0V+3J
   fIQEIuKRyjM5fUxDM/q533u6syXF+rG4F5dUqJ4+whoXZFm3PTl+Uaq+j
   garI7ctQgcTeJd8GQ+p65aGhL5QPP8vM6hwsKpVKfLHWphbUDTVqq4MzB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="408558519"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="408558519"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 23:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="937931937"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="937931937"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Apr 2023 23:29:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppNnN-000fYG-0e;
        Thu, 20 Apr 2023 06:29:29 +0000
Date:   Thu, 20 Apr 2023 14:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Sharma <anupnewsmail@gmail.com>, zbr@ioremap.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: w1: slaves: Drop unnecessary explicit casting
Message-ID: <202304201411.fS7y0KJP-lkp@intel.com>
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
config: x86_64-randconfig-a015-20230417 (https://download.01.org/0day-ci/archive/20230420/202304201411.fS7y0KJP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/211461ea088a31e3a084fd539e243c9d32db3cb6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anup-Sharma/drivers-w1-slaves-Drop-unnecessary-explicit-casting/20230420-082340
        git checkout 211461ea088a31e3a084fd539e243c9d32db3cb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/w1/slaves/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304201411.fS7y0KJP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/w1/slaves/w1_ds28e04.c:238:5: warning: format specifies type 'void *' but the argument has type 'loff_t' (aka 'long long') [-Wformat]
                                   off, count);
                                   ^~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/w1/slaves/w1_ds28e04.c:247:6: warning: format specifies type 'void *' but the argument has type 'loff_t' (aka 'long long') [-Wformat]
                                           off);
                                           ^~~
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   2 warnings generated.


vim +238 drivers/w1/slaves/w1_ds28e04.c

   221	
   222	static ssize_t eeprom_write(struct file *filp, struct kobject *kobj,
   223				    struct bin_attribute *bin_attr, char *buf,
   224				    loff_t off, size_t count)
   225	
   226	{
   227		struct w1_slave *sl = kobj_to_w1_slave(kobj);
   228		int addr, len, idx;
   229	
   230		count = w1_f1C_fix_count(off, count, W1_EEPROM_SIZE);
   231		if (count == 0)
   232			return 0;
   233	
   234		if (w1_enable_crccheck) {
   235			/* can only write full blocks in cached mode */
   236			if ((off & W1_PAGE_MASK) || (count & W1_PAGE_MASK)) {
   237				dev_err(&sl->dev, "invalid offset/count off=%pe cnt=%zd\n",
 > 238					off, count);
   239				return -EINVAL;
   240			}
   241	
   242			/* make sure the block CRCs are valid */
   243			for (idx = 0; idx < count; idx += W1_PAGE_SIZE) {
   244				if (crc16(CRC16_INIT, &buf[idx], W1_PAGE_SIZE)
   245					!= CRC16_VALID) {
   246					dev_err(&sl->dev, "bad CRC at offset %pe\n",
   247						off);
   248					return -EINVAL;
   249				}
   250			}
   251		}
   252	
   253		mutex_lock(&sl->master->mutex);
   254	
   255		/* Can only write data to one page at a time */
   256		idx = 0;
   257		while (idx < count) {
   258			addr = off + idx;
   259			len = W1_PAGE_SIZE - (addr & W1_PAGE_MASK);
   260			if (len > (count - idx))
   261				len = count - idx;
   262	
   263			if (w1_f1C_write(sl, addr, len, &buf[idx]) < 0) {
   264				count = -EIO;
   265				goto out_up;
   266			}
   267			idx += len;
   268		}
   269	
   270	out_up:
   271		mutex_unlock(&sl->master->mutex);
   272	
   273		return count;
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
