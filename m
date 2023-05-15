Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31B702A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 12:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbjEOKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240948AbjEOKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 06:07:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B81990
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684145217; x=1715681217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+mJ7t99156w497CD3cjMQMymJsQ9wfsziSUFcKbZuzo=;
  b=LyMOYWn6sc+ybPHni9lH5vmPSF8DWlD/fuRhJXwbOdEblWL8vHHdy5+g
   88F+Uyu2as5vgPtN6BTjgRmwor03zZ4pdyrwXlWtPfqlIFJ0dP6x5E5XV
   OHTPte1MK0J4xsfWX2O4YnR0N4NnfrUL4sGzMCB4+3Rp6vYrVDtcza95d
   njWeETjoq241UkCQMD7P45fVKVeFG9+VX2BS9WWiTQSTtnceeBMmrsreO
   mzhFSKh8HrqaQFbKK78nehwwRC0qF8+bCCsNKd2SMzMX06joKuMd4nxvj
   Dkv5Tq8OPYbNDI+ZMFQL5/WRa92ThneCwExXQ2oayohVjD3k+oN49XXUE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="335702277"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="335702277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 03:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="875128108"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200"; 
   d="scan'208";a="875128108"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2023 03:06:11 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pyV5m-0006J0-25;
        Mon, 15 May 2023 10:06:10 +0000
Date:   Mon, 15 May 2023 18:05:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regcache-maple.c:114:23: warning: 'upper_index'
 is used uninitialized
Message-ID: <202305151728.Nm5tSU82-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
commit: f033c26de5a5734625d2dd1dc196745fae186f1b regmap: Add maple tree based register cache
date:   6 weeks ago
config: arc-randconfig-r022-20230515 (https://download.01.org/0day-ci/archive/20230515/202305151728.Nm5tSU82-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f033c26de5a5734625d2dd1dc196745fae186f1b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f033c26de5a5734625d2dd1dc196745fae186f1b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/base/regmap/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305151728.Nm5tSU82-lkp@intel.com/

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
https://github.com/intel/lkp-tests
