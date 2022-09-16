Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017325BB275
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiIPSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPSvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:51:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D56A6C57
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663354279; x=1694890279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=An2zso0Ry4s+z2vyFjJyS5fl3zC7siypLDshTVXPuvs=;
  b=KNnDCkbkUmzC2vg9F6LqrpluxXSDkSxv13H/wxcnLFJsyO59o7JygNB+
   7cL6KUyjMD4fdItU8szSM3ZVw+aAxuaSsQcWWhprCWmMJlTgrpfGd5yLd
   Q673CmMw10hboArEoOKyLxMHfPcD6K7MbBmCJu7oF7p1o7NxO+gAhb8bv
   2NL1yqZo18o4H2HrDv5KzBApekb6Xh8LP6Ldx6+BX8LIRrS4EHsZN+oTl
   EtGaLOi62UgjhrW+WY2FnoO4DXW8sUcfJ6HundxMDaR1JjxK6jFa1Bm1B
   7Jfdg0+04EiHNbnQXSg/WWqufy5GpIasPIdM1+a3V/R1J3mzYnK2vOFM8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="286097031"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="286097031"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686234503"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2022 11:51:17 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZGQm-00023k-1b;
        Fri, 16 Sep 2022 18:51:16 +0000
Date:   Sat, 17 Sep 2022 02:50:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:967:12:
 warning: stack frame size (1040) exceeds limit (1024) in
 'hclge_dbg_dump_tm_pri'
Message-ID: <202209170244.YEyh6kEm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6879c2d3b96039ff1668b4328a4d0dd3ea952cff
commit: 69d0db01e210e07fe915e5da91b54a867cda040f ubsan: remove CONFIG_UBSAN_OBJECT_SIZE
date:   8 months ago
config: powerpc-randconfig-r023-20220916 (https://download.01.org/0day-ci/archive/20220917/202209170244.YEyh6kEm-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=69d0db01e210e07fe915e5da91b54a867cda040f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 69d0db01e210e07fe915e5da91b54a867cda040f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/hns3pf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:967:12: warning: stack frame size (1040) exceeds limit (1024) in 'hclge_dbg_dump_tm_pri' [-Wframe-larger-than]
   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
              ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for HOTPLUG_CPU
   Depends on [n]: SMP [=y] && (PPC_PSERIES [=n] || PPC_PMAC [=n] || PPC_POWERNV [=n] || FSL_SOC_BOOKE [=n])
   Selected by [y]:
   - PM_SLEEP_SMP [=y] && SMP [=y] && (ARCH_SUSPEND_POSSIBLE [=y] || ARCH_HIBERNATION_POSSIBLE [=y]) && PM_SLEEP [=y]


vim +/hclge_dbg_dump_tm_pri +967 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c

04d96139ddb32d Guangbin Huang 2021-08-30   966  
04987ca1b9b684 Guangbin Huang 2021-01-28  @967  static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
04987ca1b9b684 Guangbin Huang 2021-01-28   968  {
04d96139ddb32d Guangbin Huang 2021-08-30   969  	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
04d96139ddb32d Guangbin Huang 2021-08-30   970  	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
04d96139ddb32d Guangbin Huang 2021-08-30   971  	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
04d96139ddb32d Guangbin Huang 2021-08-30   972  	char content[HCLGE_DBG_TM_INFO_LEN];
04d96139ddb32d Guangbin Huang 2021-08-30   973  	u8 pri_num, sch_mode, weight, i, j;
04d96139ddb32d Guangbin Huang 2021-08-30   974  	int pos, ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   975  
04987ca1b9b684 Guangbin Huang 2021-01-28   976  	ret = hclge_tm_get_pri_num(hdev, &pri_num);
04987ca1b9b684 Guangbin Huang 2021-01-28   977  	if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   978  		return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   979  
04d96139ddb32d Guangbin Huang 2021-08-30   980  	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
04d96139ddb32d Guangbin Huang 2021-08-30   981  		result[i] = &data_str[i][0];
04d96139ddb32d Guangbin Huang 2021-08-30   982  
04d96139ddb32d Guangbin Huang 2021-08-30   983  	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
04d96139ddb32d Guangbin Huang 2021-08-30   984  			       NULL, ARRAY_SIZE(tm_pri_items));
04d96139ddb32d Guangbin Huang 2021-08-30   985  	pos = scnprintf(buf, len, "%s", content);
04987ca1b9b684 Guangbin Huang 2021-01-28   986  
04987ca1b9b684 Guangbin Huang 2021-01-28   987  	for (i = 0; i < pri_num; i++) {
04987ca1b9b684 Guangbin Huang 2021-01-28   988  		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
04987ca1b9b684 Guangbin Huang 2021-01-28   989  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   990  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   991  
04987ca1b9b684 Guangbin Huang 2021-01-28   992  		ret = hclge_tm_get_pri_weight(hdev, i, &weight);
04987ca1b9b684 Guangbin Huang 2021-01-28   993  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   994  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   995  
04987ca1b9b684 Guangbin Huang 2021-01-28   996  		ret = hclge_tm_get_pri_shaper(hdev, i,
04987ca1b9b684 Guangbin Huang 2021-01-28   997  					      HCLGE_OPC_TM_PRI_C_SHAPPING,
04987ca1b9b684 Guangbin Huang 2021-01-28   998  					      &c_shaper_para);
04987ca1b9b684 Guangbin Huang 2021-01-28   999  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28  1000  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28  1001  
04987ca1b9b684 Guangbin Huang 2021-01-28  1002  		ret = hclge_tm_get_pri_shaper(hdev, i,
04987ca1b9b684 Guangbin Huang 2021-01-28  1003  					      HCLGE_OPC_TM_PRI_P_SHAPPING,
04987ca1b9b684 Guangbin Huang 2021-01-28  1004  					      &p_shaper_para);
04987ca1b9b684 Guangbin Huang 2021-01-28  1005  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28  1006  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28  1007  
04987ca1b9b684 Guangbin Huang 2021-01-28  1008  		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
04987ca1b9b684 Guangbin Huang 2021-01-28  1009  			       "sp";
04987ca1b9b684 Guangbin Huang 2021-01-28  1010  
04d96139ddb32d Guangbin Huang 2021-08-30  1011  		j = 0;
04d96139ddb32d Guangbin Huang 2021-08-30  1012  		sprintf(result[j++], "%04u", i);
04d96139ddb32d Guangbin Huang 2021-08-30  1013  		sprintf(result[j++], "%4s", sch_mode_str);
04d96139ddb32d Guangbin Huang 2021-08-30  1014  		sprintf(result[j++], "%3u", weight);
04d96139ddb32d Guangbin Huang 2021-08-30  1015  		hclge_dbg_fill_shaper_content(&c_shaper_para, result, &j);
04d96139ddb32d Guangbin Huang 2021-08-30  1016  		hclge_dbg_fill_shaper_content(&p_shaper_para, result, &j);
04d96139ddb32d Guangbin Huang 2021-08-30  1017  		hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
04d96139ddb32d Guangbin Huang 2021-08-30  1018  				       (const char **)result,
04d96139ddb32d Guangbin Huang 2021-08-30  1019  				       ARRAY_SIZE(tm_pri_items));
04d96139ddb32d Guangbin Huang 2021-08-30  1020  		pos += scnprintf(buf + pos, len - pos, "%s", content);
04987ca1b9b684 Guangbin Huang 2021-01-28  1021  	}
04987ca1b9b684 Guangbin Huang 2021-01-28  1022  
04987ca1b9b684 Guangbin Huang 2021-01-28  1023  	return 0;
04987ca1b9b684 Guangbin Huang 2021-01-28  1024  }
04987ca1b9b684 Guangbin Huang 2021-01-28  1025  

:::::: The code at line 967 was first introduced by commit
:::::: 04987ca1b9b6841cfa5f9b459c5a270b75c89345 net: hns3: add debugfs support for tm nodes, priority and qset info

:::::: TO: Guangbin Huang <huangguangbin2@huawei.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
