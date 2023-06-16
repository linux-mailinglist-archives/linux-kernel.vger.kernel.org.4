Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF51732F17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjFPKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345266AbjFPKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:50:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAE859E6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686912162; x=1718448162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COE9GyQG4Th3bEBEMpjdRsaTABmturmcDhUYhNM4kLA=;
  b=efYhgND+5MQ9WX5W0ywqFyxP7IZ9DqL4POkYsnKTgvnia1zvkMTbG3Wf
   gEluHvPTXuCV2lm6/w/t2n3jX8z5k4nIDJTvHQUr/n0qIg06ToLwgINQc
   39CXaQTo/ez2uNREVuWrPUjqxMSLtUiBqP3XqZWEjRTSCoPY7RUPEqg9h
   VIS9BOCl/1F3Qq2TxB0FANg2sqMA2aHWN75XFFXA1OH6dBcBYdTijAWtL
   5E94gETp+TRbTOvq5e2Gsw+/zvQMD+qXmaiQF3jNpfFdR+5JxTnJGC04r
   pk2Z/wpsC0pU5YA8hiXR/PRHkm/cEVATR38fCxDADbBr+2VIBo/z6G2iU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361715699"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="361715699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 03:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="857337586"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; 
   d="scan'208";a="857337586"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jun 2023 03:42:23 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qA6uM-00018k-0n;
        Fri, 16 Jun 2023 10:42:22 +0000
Date:   Fri, 16 Jun 2023 18:42:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alison Wang <alison.wang@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, leoyang.li@nxp.com,
        xuelin.shi@nxp.com, xiaofeng.ren@nxp.com, feng.guo@nxp.com,
        Alison Wang <alison.wang@nxp.com>
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <202306161815.GoCnwgZ8-lkp@intel.com>
References: <20230616055913.2360-2-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616055913.2360-2-alison.wang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alison,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.4-rc6 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alison-Wang/ethosu-Add-Arm-Ethos-U-driver/20230616-141036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20230616055913.2360-2-alison.wang%40nxp.com
patch subject: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230616/202306161815.GoCnwgZ8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add soc https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
        git fetch soc for-next
        git checkout soc/for-next
        b4 shazam https://lore.kernel.org/r/20230616055913.2360-2-alison.wang@nxp.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/firmware/ethosu/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306161815.GoCnwgZ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/mailbox_client.h:11,
                    from drivers/firmware/ethosu/ethosu_mailbox.h:30,
                    from drivers/firmware/ethosu/ethosu_device.h:29,
                    from drivers/firmware/ethosu/ethosu_buffer.c:27:
   drivers/firmware/ethosu/ethosu_buffer.c: In function 'ethosu_buffer_create':
>> drivers/firmware/ethosu/ethosu_buffer.c:253:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 8 has type 'long unsigned int' [-Wformat=]
     253 |                  "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:252:9: note: in expansion of macro 'dev_info'
     252 |         dev_info(buf->edev->dev,
         |         ^~~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:253:132: note: format string is defined here
     253 |                  "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
         |                                                                                                                                 ~~~^
         |                                                                                                                                    |
         |                                                                                                                                    long long unsigned int
         |                                                                                                                                 %lx


vim +253 drivers/firmware/ethosu/ethosu_buffer.c

   218	
   219	int ethosu_buffer_create(struct ethosu_device *edev,
   220				 size_t capacity)
   221	{
   222		struct ethosu_buffer *buf;
   223		int ret = -ENOMEM;
   224	
   225		buf = devm_kzalloc(edev->dev, sizeof(*buf), GFP_KERNEL);
   226		if (!buf)
   227			return -ENOMEM;
   228	
   229		buf->edev = edev;
   230		buf->capacity = capacity;
   231		buf->offset = 0;
   232		buf->size = 0;
   233		kref_init(&buf->kref);
   234	
   235		buf->cpu_addr = dma_alloc_coherent(buf->edev->dev, capacity,
   236						   &buf->dma_addr_orig, GFP_KERNEL);
   237		if (!buf->cpu_addr)
   238			goto free_buf;
   239	
   240		buf->dma_addr = ethosu_buffer_dma_ranges(buf->edev->dev,
   241							 buf->dma_addr_orig,
   242							 buf->capacity);
   243	
   244		ret = anon_inode_getfd("ethosu-buffer", &ethosu_buffer_fops, buf,
   245				       O_RDWR | O_CLOEXEC);
   246		if (ret < 0)
   247			goto free_dma;
   248	
   249		buf->file = fget(ret);
   250		fput(buf->file);
   251	
   252		dev_info(buf->edev->dev,
 > 253			 "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
   254			 buf, capacity, buf->cpu_addr, buf->dma_addr,
   255			 buf->dma_addr_orig, virt_to_phys(buf->cpu_addr));
   256	
   257		return ret;
   258	
   259	free_dma:
   260		dma_free_coherent(buf->edev->dev, buf->capacity, buf->cpu_addr,
   261				  buf->dma_addr_orig);
   262	
   263	free_buf:
   264		devm_kfree(buf->edev->dev, buf);
   265	
   266		return ret;
   267	}
   268	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
