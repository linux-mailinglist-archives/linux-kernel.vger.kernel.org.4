Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08A6BBF56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjCOVrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOVrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:47:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F81F6B977;
        Wed, 15 Mar 2023 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678916833; x=1710452833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cHzP/3Tzs/wORixRirXSEWJE6PYaNKurlGF+KU1RKV8=;
  b=WJ+8Wk09AcGeT/eFJ7FgD2efy1oPn1aRK8GX7wEW+svWzJdsKCsYe3fl
   VCqRShqYyEHkD19BLPUztcyQqBOdRW8DYgxTu/0gZBM0kjd3lmDt5sK7Z
   UWAkBhM8INu+gDhSnJzPT3JI3qMgqvsvhwq494v8bE+5CHjsAUUxjwzcu
   6EZp7UJWvvT4LuwnaEaTdsAiVqxMqkJiIdjwYob0ggqXW1QvY2BwhLL2R
   dKlOW1Y7nhhcmsPTgujQQ5Y6rvD6TcnRdmtpCgX3+T6qn04nZSHYMo19V
   G33MmD8vtun3+8zhOPnqgbyya5r+KooXOyzHFZAMgrSeI3J5b50G/5nik
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="337842525"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="337842525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 14:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="748604027"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="748604027"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2023 14:47:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcYxg-00083T-2T;
        Wed, 15 Mar 2023 21:47:08 +0000
Date:   Thu, 16 Mar 2023 05:46:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Desnes Nunes <desnesn@redhat.com>, iommu@lists.linux.dev,
        linux-scsi@vger.kernel.org, storagedev@microchip.com,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, hch@lst.de,
        martin.petersen@oracle.com, don.brace@microchip.com,
        m.szyprowski@samsung.com, robin.murphy@arm.com, jejb@linux.ibm.com,
        jsnitsel@redhat.com, Desnes Nunes <desnesn@redhat.com>
Subject: Re: [PATCH 2/3] dma-debug: add cacheline to user/kernel space dump
 messages
Message-ID: <202303160548.ReyuTsGD-lkp@intel.com>
References: <20230315192130.970021-3-desnesn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315192130.970021-3-desnesn@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Desnes,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jejb-scsi/for-next]
[also build test WARNING on mkp-scsi/for-next linus/master hch-configfs/for-next v6.3-rc2 next-20230315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Desnes-Nunes/dma-debug-small-dma_debug_entry-s-comment-and-variable-name-updates/20230316-032542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230315192130.970021-3-desnesn%40redhat.com
patch subject: [PATCH 2/3] dma-debug: add cacheline to user/kernel space dump messages
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230316/202303160548.ReyuTsGD-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ae3f8fdd17c54b837d476952733456723c472ed8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Desnes-Nunes/dma-debug-small-dma_debug_entry-s-comment-and-variable-name-updates/20230316-032542
        git checkout ae3f8fdd17c54b837d476952733456723c472ed8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303160548.ReyuTsGD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from include/linux/dma-map-ops.h:9,
                    from kernel/dma/debug.c:12:
   kernel/dma/debug.c: In function 'debug_dma_dump_mappings':
>> kernel/dma/debug.c:537:42: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 9 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     537 |                                          "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   kernel/dma/debug.c:536:33: note: in expansion of macro 'dev_info'
     536 |                                 dev_info(entry->dev,
         |                                 ^~~~~~~~
   kernel/dma/debug.c:537:87: note: format string is defined here
     537 |                                          "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
         |                                                                                    ~~~^
         |                                                                                       |
         |                                                                                       long long unsigned int
         |                                                                                    %x
   kernel/dma/debug.c: In function 'dump_show':
   kernel/dma/debug.c:568:87: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 11 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     568 |                                    "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
         |                                                                                    ~~~^
         |                                                                                       |
         |                                                                                       long long unsigned int
         |                                                                                    %x
   ......
     574 |                                    cln, dir2name[entry->direction],
         |                                    ~~~                                                 
         |                                    |
         |                                    phys_addr_t {aka unsigned int}


vim +537 kernel/dma/debug.c

   518	
   519	/*
   520	 * Dump mappings entries on kernel space for debugging purposes
   521	 */
   522	void debug_dma_dump_mappings(struct device *dev)
   523	{
   524		int idx;
   525		phys_addr_t cln;
   526	
   527		for (idx = 0; idx < HASH_SIZE; idx++) {
   528			struct hash_bucket *bucket = &dma_entry_hash[idx];
   529			struct dma_debug_entry *entry;
   530			unsigned long flags;
   531	
   532			spin_lock_irqsave(&bucket->lock, flags);
   533			list_for_each_entry(entry, &bucket->list, list) {
   534				if (!dev || dev == entry->dev) {
   535					cln = to_cacheline_number(entry);
   536					dev_info(entry->dev,
 > 537						 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%llx %s %s\n",
   538						 type2name[entry->type], idx,
   539						 phys_addr(entry), entry->pfn,
   540						 entry->dev_addr, entry->size,
   541						 cln, dir2name[entry->direction],
   542						 maperr2str[entry->map_err_type]);
   543				}
   544			}
   545			spin_unlock_irqrestore(&bucket->lock, flags);
   546	
   547			cond_resched();
   548		}
   549	}
   550	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
