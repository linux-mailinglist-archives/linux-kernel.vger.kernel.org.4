Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACDF5E729D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIWEAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIWEAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:00:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11B9FA96
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663905633; x=1695441633;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pxYjuu3lxvrOnic49rQLuDK3YaKaCbJs6u697F/+o2k=;
  b=h5n6RrLuteQz9OI1CjJKajFlXMu1oTTFCALdPwdMQl+TFkHXmchYkude
   vfvXdSjYKsoYeS8OK/o9qaNwSmF70Zv5SOa/xQR6aGEtDNngpcV29hYG3
   3tU6hjNqUyvSw+PtnYpAiBTPe2jqGHXFdjqrOkYNNAbW1c9EhIwGoCO/I
   1dHPLQmDGQYuajUovwrL89EGunZkJqBIeEo6tImXNEjNCNnPx8YJYOWOy
   vxKP7qsUO4hA5yrgNSEVwuGN0P5gZqqnPggNxn0oaQVZwbwG0ZlT36Wna
   UQzL0EDdfD0YnIyDZ0GGUdr79ngvMdrIOh4XuUgU2dr7tFC9CW0f6j8ob
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362309294"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362309294"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 21:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597727579"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 21:00:30 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obZra-0005I8-0L;
        Fri, 23 Sep 2022 04:00:30 +0000
Date:   Fri, 23 Sep 2022 12:00:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:akpm/mm/mm-unstable 480/484]
 drivers/base/memory.c:186:34: error: 'struct memory_block' has no member
 named 'nr_hwpoison'
Message-ID: <202209231134.tnhKHRfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block akpm/mm/mm-unstable
head:   1dee68cfead9a3a85e244a274b4e85620abd5331
commit: 69b496f03bb46c7ce743aff0d976c078d753d6d6 [480/484] mm/hwpoison: introduce per-memory_block hwpoison counter
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220923/202209231134.tnhKHRfg-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/69b496f03bb46c7ce743aff0d976c078d753d6d6
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block akpm/mm/mm-unstable
        git checkout 69b496f03bb46c7ce743aff0d976c078d753d6d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/memory.c: In function 'memory_block_online':
>> drivers/base/memory.c:186:34: error: 'struct memory_block' has no member named 'nr_hwpoison'
     186 |         if (atomic_long_read(&mem->nr_hwpoison))
         |                                  ^~
   drivers/base/memory.c: In function 'remove_memory_block_devices':
   drivers/base/memory.c:870:61: error: 'struct memory_block' has no member named 'nr_hwpoison'
     870 |                 clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hwpoison));
         |                                                             ^~


vim +186 drivers/base/memory.c

   177	
   178	static int memory_block_online(struct memory_block *mem)
   179	{
   180		unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
   181		unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
   182		unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
   183		struct zone *zone;
   184		int ret;
   185	
 > 186		if (atomic_long_read(&mem->nr_hwpoison))
   187			return -EHWPOISON;
   188	
   189		zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
   190					  start_pfn, nr_pages);
   191	
   192		/*
   193		 * Although vmemmap pages have a different lifecycle than the pages
   194		 * they describe (they remain until the memory is unplugged), doing
   195		 * their initialization and accounting at memory onlining/offlining
   196		 * stage helps to keep accounting easier to follow - e.g vmemmaps
   197		 * belong to the same zone as the memory they backed.
   198		 */
   199		if (nr_vmemmap_pages) {
   200			ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
   201			if (ret)
   202				return ret;
   203		}
   204	
   205		ret = online_pages(start_pfn + nr_vmemmap_pages,
   206				   nr_pages - nr_vmemmap_pages, zone, mem->group);
   207		if (ret) {
   208			if (nr_vmemmap_pages)
   209				mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
   210			return ret;
   211		}
   212	
   213		/*
   214		 * Account once onlining succeeded. If the zone was unpopulated, it is
   215		 * now already properly populated.
   216		 */
   217		if (nr_vmemmap_pages)
   218			adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
   219						  nr_vmemmap_pages);
   220	
   221		mem->zone = zone;
   222		return ret;
   223	}
   224	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
