Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031FF733748
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbjFPRQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjFPRQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:16:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42511FEC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686935809; x=1718471809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lotGMUHAEItQUQTJZiKHNQY4p2TuxIW8ZzXynQ0ZeTw=;
  b=Z6qfDGCxB86tJksmWbw8CHTa1TPJYnQ975vd4Zfnmap76joa8FyZ4XVJ
   x+61v/poxonaXkvN0xB4nRFV6z4jfD9z0E8QAOwC7e1T+h/vgk2Yr4kVq
   C9OfI7GK/JUCicNUPOYPNZRZvMpUNwYdmxQuRjnv0r3NadcOuSTMzwz5y
   LPIim1uo4U/tft04pV0GYle8dMHxS6UtAwHUiy9sV+AcusUmt5VZZ9GWP
   s8CSYkZLYD60HQ8o98L6Kg1qNu3L2HcDVSakmQnm9L8myVZys3Y3/TXMY
   f79wWzfWmyb/kkDAIQ6YZZVwRGTyfG6HTK/7xZwfz2yaieiGp5cvLgRKX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="388040374"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="388040374"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 10:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="887163314"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="887163314"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2023 10:16:45 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qAD40-0001bE-1i;
        Fri, 16 Jun 2023 17:16:44 +0000
Date:   Sat, 17 Jun 2023 01:16:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alison Wang <alison.wang@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, leoyang.li@nxp.com,
        xuelin.shi@nxp.com, xiaofeng.ren@nxp.com, feng.guo@nxp.com,
        Alison Wang <alison.wang@nxp.com>
Subject: Re: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Message-ID: <202306170138.BFDQ7A7K-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230617/202306170138.BFDQ7A7K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230617/202306170138.BFDQ7A7K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306170138.BFDQ7A7K-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:564,
                    from include/linux/kernel.h:30,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from drivers/firmware/ethosu/ethosu_buffer.h:28,
                    from drivers/firmware/ethosu/ethosu_buffer.c:25:
   drivers/firmware/ethosu/ethosu_buffer.c: In function 'ethosu_buffer_dma_ranges':
>> drivers/firmware/ethosu/ethosu_buffer.c:108:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:271:9: note: in expansion of macro '_dynamic_func_call'
     271 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:17: note: in expansion of macro 'dev_dbg'
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                 ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:42: note: format string is defined here
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                                       ~~~^
         |                                          |
         |                                          long long unsigned int
         |                                       %x
   drivers/firmware/ethosu/ethosu_buffer.c:108:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:271:9: note: in expansion of macro '_dynamic_func_call'
     271 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:17: note: in expansion of macro 'dev_dbg'
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                 ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:56: note: format string is defined here
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                                                     ~~~^
         |                                                        |
         |                                                        long long unsigned int
         |                                                     %x
   drivers/firmware/ethosu/ethosu_buffer.c:108:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:222:29: note: in definition of macro '__dynamic_func_call_cls'
     222 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '_dynamic_func_call_cls'
     248 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:271:9: note: in expansion of macro '_dynamic_func_call'
     271 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:17: note: in expansion of macro 'dev_dbg'
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                 ^~~~~~~
   drivers/firmware/ethosu/ethosu_buffer.c:108:69: note: format string is defined here
     108 |                 dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
         |                                                                  ~~~^
         |                                                                     |
         |                                                                     long long unsigned int
         |                                                                  %x
   In file included from include/linux/device.h:15,
                    from include/linux/mailbox_client.h:11,
                    from drivers/firmware/ethosu/ethosu_mailbox.h:30,
                    from drivers/firmware/ethosu/ethosu_device.h:29,
                    from drivers/firmware/ethosu/ethosu_buffer.c:27:
   drivers/firmware/ethosu/ethosu_buffer.c: In function 'ethosu_buffer_create':
   drivers/firmware/ethosu/ethosu_buffer.c:253:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
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
   drivers/firmware/ethosu/ethosu_buffer.c:253:92: note: format string is defined here
     253 |                  "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
         |                                                                                         ~~~^
         |                                                                                            |
         |                                                                                            long long unsigned int
         |                                                                                         %x
   drivers/firmware/ethosu/ethosu_buffer.c:253:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 7 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
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
   drivers/firmware/ethosu/ethosu_buffer.c:253:114: note: format string is defined here
     253 |                  "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
         |                                                                                                               ~~~^
         |                                                                                                                  |
         |                                                                                                                  long long unsigned int
         |                                                                                                               %x
>> drivers/firmware/ethosu/ethosu_buffer.c:253:18: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 8 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
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
         |                                                                                                                                 %x


vim +108 drivers/firmware/ethosu/ethosu_buffer.c

    59	
    60	/****************************************************************************
    61	 * Functions
    62	 ****************************************************************************/
    63	
    64	/*
    65	 * The 'dma-ranges' device tree property for shared dma memory does not seem
    66	 * to be fully supported for coherent memory. Therefor we apply the DMA range
    67	 * offset ourselves.
    68	 */
    69	static dma_addr_t ethosu_buffer_dma_ranges(struct device *dev,
    70						   dma_addr_t dma_addr,
    71						   size_t dma_buf_size)
    72	{
    73		struct device_node *node = dev->of_node;
    74		const __be32 *ranges;
    75		int len;
    76		int naddr;
    77		int nsize;
    78		int inc;
    79		int i;
    80	
    81		if (!node)
    82			return dma_addr;
    83	
    84		/* Get the #address-cells and #size-cells properties */
    85		naddr = of_n_addr_cells(node);
    86		nsize = of_n_size_cells(node);
    87	
    88		/* Read the 'dma-ranges' property */
    89		ranges = of_get_property(node, "dma-ranges", &len);
    90		if (!ranges || len <= 0)
    91			return dma_addr;
    92	
    93		dev_dbg(dev, "ranges=%p, len=%d, naddr=%d, nsize=%d\n",
    94			ranges, len, naddr, nsize);
    95	
    96		len /= sizeof(*ranges);
    97		inc = naddr + naddr + nsize;
    98	
    99		for (i = 0; (i + inc) <= len; i += inc) {
   100			dma_addr_t daddr;
   101			dma_addr_t paddr;
   102			dma_addr_t size;
   103	
   104			daddr = of_read_number(&ranges[i], naddr);
   105			paddr = of_read_number(&ranges[i + naddr], naddr);
   106			size = of_read_number(&ranges[i + naddr + naddr], nsize);
   107	
 > 108			dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
   109				daddr, paddr, size);
   110	
   111			if (dma_addr >= paddr &&
   112			    (dma_addr + dma_buf_size) < (paddr + size))
   113				return dma_addr + daddr - paddr;
   114		}
   115	
   116		return dma_addr;
   117	}
   118	
   119	static bool ethosu_buffer_verify(struct file *file)
   120	{
   121		return file->f_op == &ethosu_buffer_fops;
   122	}
   123	
   124	static void ethosu_buffer_destroy(struct kref *kref)
   125	{
   126		struct ethosu_buffer *buf =
   127			container_of(kref, struct ethosu_buffer, kref);
   128	
   129		dev_info(buf->edev->dev, "Buffer destroy. handle=0x%pK\n", buf);
   130	
   131		dma_free_coherent(buf->edev->dev, buf->capacity, buf->cpu_addr,
   132				  buf->dma_addr_orig);
   133		devm_kfree(buf->edev->dev, buf);
   134	}
   135	
   136	static int ethosu_buffer_release(struct inode *inode,
   137					 struct file *file)
   138	{
   139		struct ethosu_buffer *buf = file->private_data;
   140	
   141		dev_info(buf->edev->dev, "Buffer release. handle=0x%pK\n", buf);
   142	
   143		ethosu_buffer_put(buf);
   144	
   145		return 0;
   146	}
   147	
   148	static int ethosu_buffer_mmap(struct file *file,
   149				      struct vm_area_struct *vma)
   150	{
   151		struct ethosu_buffer *buf = file->private_data;
   152		int ret;
   153	
   154		dev_info(buf->edev->dev, "Buffer mmap. handle=0x%pK\n", buf);
   155	
   156		ret = dma_mmap_coherent(buf->edev->dev, vma, buf->cpu_addr,
   157					buf->dma_addr_orig,
   158					buf->capacity);
   159	
   160		return ret;
   161	}
   162	
   163	static long ethosu_buffer_ioctl(struct file *file,
   164					unsigned int cmd,
   165					unsigned long arg)
   166	{
   167		struct ethosu_buffer *buf = file->private_data;
   168		void __user *udata = (void __user *)arg;
   169		int ret = -EINVAL;
   170	
   171		ret = mutex_lock_interruptible(&buf->edev->mutex);
   172		if (ret)
   173			return ret;
   174	
   175		dev_info(buf->edev->dev, "Ioctl. cmd=%u, arg=%lu\n", cmd, arg);
   176	
   177		switch (cmd) {
   178		case ETHOSU_IOCTL_BUFFER_SET: {
   179			struct ethosu_uapi_buffer uapi;
   180	
   181			if (copy_from_user(&uapi, udata, sizeof(uapi)))
   182				break;
   183	
   184			dev_info(buf->edev->dev,
   185				 "Ioctl: Buffer set. size=%u, offset=%u\n",
   186				 uapi.size, uapi.offset);
   187	
   188			ret = ethosu_buffer_resize(buf, uapi.size, uapi.offset);
   189			break;
   190		}
   191		case ETHOSU_IOCTL_BUFFER_GET: {
   192			struct ethosu_uapi_buffer uapi;
   193	
   194			uapi.size = buf->size;
   195			uapi.offset = buf->offset;
   196	
   197			dev_info(buf->edev->dev,
   198				 "Ioctl: Buffer get. size=%u, offset=%u\n",
   199				 uapi.size, uapi.offset);
   200	
   201			if (copy_to_user(udata, &uapi, sizeof(uapi)))
   202				break;
   203	
   204			ret = 0;
   205			break;
   206		}
   207		default: {
   208			dev_err(buf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
   209				cmd, arg);
   210			break;
   211		}
   212		}
   213	
   214		mutex_unlock(&buf->edev->mutex);
   215	
   216		return ret;
   217	}
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
