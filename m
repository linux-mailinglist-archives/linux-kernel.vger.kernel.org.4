Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE8744AD5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjGAS2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 14:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGAS2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 14:28:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5151BF3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688236101; x=1719772101;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=emZhbCfguNVy5XePL4s5ylCI8nKG8H5etyDhN/w2EFw=;
  b=He+pxd4VIy8g4bt5eqr4SbgkZFqGSxp9dNkGQcgBODTQNFDaXYRWvFRL
   hD7O90zDSsT1B+KLXntmvAizYodBZVPZBVYV5I6dMy5+faYxnIfFCzbj+
   0Dz27vQQ5XRPj98sJZW9HtjiSjgKg79+QM8v/+rw1niiLyX6U5a1SxeJR
   OWAvGpSdydJPg62PYyK1V/JwF0lkqGWpxPzuthq7vOgchxY79COC7kiEi
   p+xYVp/DN1vjMJ1JjrO48xYc8ZXKfuvbmsU2rXA5Nu9b1VGY4OYHvHOwV
   0ZBns8xjFaeamdzTC5iQy177OBO1MR5e1qDmln+gRvsg+gb6NU5NJpO5Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="428659768"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="428659768"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 11:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="1048602908"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="1048602908"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Jul 2023 11:28:19 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFfKU-000GCP-0a;
        Sat, 01 Jul 2023 18:28:18 +0000
Date:   Sun, 2 Jul 2023 02:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index'
 is used uninitialized
Message-ID: <202307020213.Qt5xjEi8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e3c2b10d6f15640407bef3098accf10faa4ecf1b
commit: f033c26de5a5734625d2dd1dc196745fae186f1b regmap: Add maple tree based register cache
date:   3 months ago
config: arc-vdk_hs38_defconfig (https://download.01.org/0day-ci/archive/20230702/202307020213.Qt5xjEi8-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020213.Qt5xjEi8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307020213.Qt5xjEi8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
   drivers/base/regmap/regcache-maple.c:113:23: warning: 'lower_index' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                       ^~~~~~~~~~~
   drivers/base/regmap/regcache-maple.c:113:36: warning: 'lower_last' is used uninitialized [-Wuninitialized]
     113 |         unsigned long lower_index, lower_last;
         |                                    ^~~~~~~~~~
>> drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                       ^~~~~~~~~~~
>> drivers/base/regmap/regcache-maple.c:114:36: warning: 'upper_last' is used uninitialized [-Wuninitialized]
     114 |         unsigned long upper_index, upper_last;
         |                                    ^~~~~~~~~~


vim +/upper_index +114 drivers/base/regmap/regcache-maple.c

   106	
   107	static int regcache_maple_drop(struct regmap *map, unsigned int min,
   108				       unsigned int max)
   109	{
   110		struct maple_tree *mt = map->cache;
   111		MA_STATE(mas, mt, min, max);
   112		unsigned long *entry, *lower, *upper;
 > 113		unsigned long lower_index, lower_last;
 > 114		unsigned long upper_index, upper_last;
   115		int ret;
   116	
   117		lower = NULL;
   118		upper = NULL;
   119	
   120		mas_lock(&mas);
   121	
   122		mas_for_each(&mas, entry, max) {
   123			/*
   124			 * This is safe because the regmap lock means the
   125			 * Maple lock is redundant, but we need to take it due
   126			 * to lockdep asserts in the maple tree code.
   127			 */
   128			mas_unlock(&mas);
   129	
   130			/* Do we need to save any of this entry? */
   131			if (mas.index < min) {
   132				lower_index = mas.index;
   133				lower_last = min -1;
   134	
   135				lower = kmemdup(entry, ((min - mas.index) *
   136							sizeof(unsigned long)),
   137						GFP_KERNEL);
   138				if (!lower) {
   139					ret = -ENOMEM;
   140					goto out;
   141				}
   142			}
   143	
   144			if (mas.last > max) {
   145				upper_index = max + 1;
   146				upper_last = mas.last;
   147	
   148				upper = kmemdup(&entry[max + 1],
   149						((mas.last - max) *
   150						 sizeof(unsigned long)),
   151						GFP_KERNEL);
   152				if (!upper) {
   153					ret = -ENOMEM;
   154					goto out;
   155				}
   156			}
   157	
   158			kfree(entry);
   159			mas_lock(&mas);
   160			mas_erase(&mas);
   161	
   162			/* Insert new nodes with the saved data */
   163			if (lower) {
   164				mas_set_range(&mas, lower_index, lower_last);
   165				ret = mas_store_gfp(&mas, lower, GFP_KERNEL);
   166				if (ret != 0)
   167					goto out;
   168				lower = NULL;
   169			}
   170	
   171			if (upper) {
   172				mas_set_range(&mas, upper_index, upper_last);
   173				ret = mas_store_gfp(&mas, upper, GFP_KERNEL);
   174				if (ret != 0)
   175					goto out;
   176				upper = NULL;
   177			}
   178		}
   179	
   180	out:
   181		mas_unlock(&mas);
   182		kfree(lower);
   183		kfree(upper);
   184	
   185		return ret;
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
