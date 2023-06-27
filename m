Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8973F4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjF0GsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjF0GsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:48:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038D1734
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687848483; x=1719384483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c0x4IzZ5x7svya+o8vVZ3AnRHa0821u/ac4osGpmwik=;
  b=Ee/C3GJoDBJNeOCj3Vr8DJ/TwQbhNoC0zqLI8H+V1VEzeUlAlaLWdDtT
   t8AKGOvCyCu9pXs6ChhBbWVEaC4rbP280v9PJ7pRkK5J4bbBaAGHbHDAe
   5icztexPBdJDtl+IVCoFM1QjMGiqV3zFRIeAXXyoEPav8LbvoAMPzWdyM
   9k2lZ+FLOOMtkI6aP24jG/ub2SJEOcDPa+mZmjWHTGWT1nZmaAVrbMCck
   2gDjbFVDdKy3zi1J5uEEg5uGlPW35fTqkTrCZ0LKvXYT0ibQqcfbpOLDd
   rUCQHEthz2jPHF46U+jFm/WHgEqBq2MR5TEsNMn/F0p9XLSYh0k5dFxtw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="360358655"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="360358655"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 23:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="786467750"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="786467750"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2023 23:47:59 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qE2UY-000Bm1-2v;
        Tue, 27 Jun 2023 06:47:58 +0000
Date:   Tue, 27 Jun 2023 14:47:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202306271413.5vS46KMc-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ef6663a587ba3e57dc5065a477db1c64481eedd
commit: 09f6b27d5ddd9ad0ec096d1b0f8decdacc70f0f8 ARM: dove: multiplatform support
date:   1 year, 3 months ago
config: arm-randconfig-r071-20230627 (https://download.01.org/0day-ci/archive/20230627/202306271413.5vS46KMc-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230627/202306271413.5vS46KMc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306271413.5vS46KMc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     got void *
>> drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     expected void *addr
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     got void [noderef] __iomem *

vim +145 drivers/gpu/drm/sti/sti_mixer.c

a5f81078a56c6a Vincent Abriou 2016-02-04  139  
a5f81078a56c6a Vincent Abriou 2016-02-04  140  static void mixer_dbg_mxn(struct seq_file *s, void *addr)
a5f81078a56c6a Vincent Abriou 2016-02-04  141  {
a5f81078a56c6a Vincent Abriou 2016-02-04  142  	int i;
a5f81078a56c6a Vincent Abriou 2016-02-04  143  
a5f81078a56c6a Vincent Abriou 2016-02-04  144  	for (i = 1; i < 8; i++)
a5f81078a56c6a Vincent Abriou 2016-02-04 @145  		seq_printf(s, "-0x%08X", (int)readl(addr + i * 4));
a5f81078a56c6a Vincent Abriou 2016-02-04  146  }
a5f81078a56c6a Vincent Abriou 2016-02-04  147  
a5f81078a56c6a Vincent Abriou 2016-02-04  148  static int mixer_dbg_show(struct seq_file *s, void *arg)
a5f81078a56c6a Vincent Abriou 2016-02-04  149  {
a5f81078a56c6a Vincent Abriou 2016-02-04  150  	struct drm_info_node *node = s->private;
a5f81078a56c6a Vincent Abriou 2016-02-04  151  	struct sti_mixer *mixer = (struct sti_mixer *)node->info_ent->data;
a5f81078a56c6a Vincent Abriou 2016-02-04  152  
a5f81078a56c6a Vincent Abriou 2016-02-04  153  	seq_printf(s, "%s: (vaddr = 0x%p)",
a5f81078a56c6a Vincent Abriou 2016-02-04  154  		   sti_mixer_to_str(mixer), mixer->regs);
a5f81078a56c6a Vincent Abriou 2016-02-04  155  
a5f81078a56c6a Vincent Abriou 2016-02-04  156  	DBGFS_DUMP(GAM_MIXER_CTL);
a5f81078a56c6a Vincent Abriou 2016-02-04  157  	mixer_dbg_ctl(s, sti_mixer_reg_read(mixer, GAM_MIXER_CTL));
a5f81078a56c6a Vincent Abriou 2016-02-04  158  	DBGFS_DUMP(GAM_MIXER_BKC);
a5f81078a56c6a Vincent Abriou 2016-02-04  159  	DBGFS_DUMP(GAM_MIXER_BCO);
a5f81078a56c6a Vincent Abriou 2016-02-04  160  	DBGFS_DUMP(GAM_MIXER_BCS);
a5f81078a56c6a Vincent Abriou 2016-02-04  161  	DBGFS_DUMP(GAM_MIXER_AVO);
a5f81078a56c6a Vincent Abriou 2016-02-04  162  	DBGFS_DUMP(GAM_MIXER_AVS);
a5f81078a56c6a Vincent Abriou 2016-02-04  163  	DBGFS_DUMP(GAM_MIXER_CRB);
a5f81078a56c6a Vincent Abriou 2016-02-04  164  	mixer_dbg_crb(s, sti_mixer_reg_read(mixer, GAM_MIXER_CRB));
a5f81078a56c6a Vincent Abriou 2016-02-04  165  	DBGFS_DUMP(GAM_MIXER_ACT);
a5f81078a56c6a Vincent Abriou 2016-02-04  166  	DBGFS_DUMP(GAM_MIXER_MBP);
a5f81078a56c6a Vincent Abriou 2016-02-04  167  	DBGFS_DUMP(GAM_MIXER_MX0);
a5f81078a56c6a Vincent Abriou 2016-02-04 @168  	mixer_dbg_mxn(s, mixer->regs + GAM_MIXER_MX0);
e9635133d47b9c Markus Elfring 2017-05-05  169  	seq_putc(s, '\n');
a5f81078a56c6a Vincent Abriou 2016-02-04  170  	return 0;
a5f81078a56c6a Vincent Abriou 2016-02-04  171  }
a5f81078a56c6a Vincent Abriou 2016-02-04  172  

:::::: The code at line 145 was first introduced by commit
:::::: a5f81078a56c6ab57b7db2402ac64c34338004c5 drm/sti: add debugfs entries for MIXER crtc

:::::: TO: Vincent Abriou <vincent.abriou@st.com>
:::::: CC: Vincent Abriou <vincent.abriou@st.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
