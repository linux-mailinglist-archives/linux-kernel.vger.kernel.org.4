Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB418692C59
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBKA75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKA7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:59:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695461F488
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676077194; x=1707613194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=my0Dio6Eygineyq8/cN0u9ylURVyq0Pkp3wlMqDshAE=;
  b=GyU7S5R2FYSdjeqMkMzrxHIL6bEjeVivKjQcMiASQksYh7hH8FgvNzmm
   XLvpFiBMP1A8o53Iehf58ME+GD48k+GuhqPelPqWPirTIReLMII4iV7T9
   6id8YeBZ87cU5Vfqo3d+wXLmP1dMD2B+mxop1PzNLpA/0KNaYSORbXJmy
   +5oHo4tszbL/8oaBdRSTn5wF1SrN0ac8CcjJIoqApVXp1Y6zirNzRy3FG
   t9IEB0LGyD8q5ZvPpoH+gFOccTb7blXw4DPDsW7oVBKWl4cTA3Nr0Gw6v
   dVXEP57Xoyc9fp4qzzUpmkYdGpDPvAjZt18Pi0/NvRUfcL8xvk9EswLqJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392969308"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392969308"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668236991"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668236991"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 16:59:52 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pQeF5-00069N-1x;
        Sat, 11 Feb 2023 00:59:51 +0000
Date:   Sat, 11 Feb 2023 08:59:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:949:12:
 warning: stack frame size (1040) exceeds limit (1024) in
 'hclge_dbg_dump_tm_pri'
Message-ID: <202302110819.YzQu5wGF-lkp@intel.com>
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

Hi Guangbin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4cfd5afcd87eb213f08863b6f34944978b0a678d
commit: 04d96139ddb32dd15e5941c303f511a92759a5be net: hns3: refine function hclge_dbg_dump_tm_pri()
date:   1 year, 5 months ago
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230211/202302110819.YzQu5wGF-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db0e6591612b53910a1b366863348bdb9d7d2fb1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04d96139ddb32dd15e5941c303f511a92759a5be
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04d96139ddb32dd15e5941c303f511a92759a5be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/hisilicon/hns3/hns3pf/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302110819.YzQu5wGF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:949:12: warning: stack frame size (1040) exceeds limit (1024) in 'hclge_dbg_dump_tm_pri' [-Wframe-larger-than]
   static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
              ^
   112/1040 (10.77%) spills, 928/1040 (89.23%) variables
   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c:722:12: warning: stack frame size (1072) exceeds limit (1024) in 'hclge_dbg_dump_tm_pg' [-Wframe-larger-than]
   static int hclge_dbg_dump_tm_pg(struct hclge_dev *hdev, char *buf, int len)
              ^
   116/1072 (10.82%) spills, 956/1072 (89.18%) variables
   2 warnings generated.


vim +/hclge_dbg_dump_tm_pri +949 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c

04d96139ddb32d Guangbin Huang 2021-08-30   948  
04987ca1b9b684 Guangbin Huang 2021-01-28  @949  static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
04987ca1b9b684 Guangbin Huang 2021-01-28   950  {
04d96139ddb32d Guangbin Huang 2021-08-30   951  	char data_str[ARRAY_SIZE(tm_pri_items)][HCLGE_DBG_DATA_STR_LEN];
04d96139ddb32d Guangbin Huang 2021-08-30   952  	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
04d96139ddb32d Guangbin Huang 2021-08-30   953  	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
04d96139ddb32d Guangbin Huang 2021-08-30   954  	char content[HCLGE_DBG_TM_INFO_LEN];
04d96139ddb32d Guangbin Huang 2021-08-30   955  	u8 pri_num, sch_mode, weight, i, j;
04d96139ddb32d Guangbin Huang 2021-08-30   956  	int pos, ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   957  
04987ca1b9b684 Guangbin Huang 2021-01-28   958  	ret = hclge_tm_get_pri_num(hdev, &pri_num);
04987ca1b9b684 Guangbin Huang 2021-01-28   959  	if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   960  		return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   961  
04d96139ddb32d Guangbin Huang 2021-08-30   962  	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
04d96139ddb32d Guangbin Huang 2021-08-30   963  		result[i] = &data_str[i][0];
04d96139ddb32d Guangbin Huang 2021-08-30   964  
04d96139ddb32d Guangbin Huang 2021-08-30   965  	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
04d96139ddb32d Guangbin Huang 2021-08-30   966  			       NULL, ARRAY_SIZE(tm_pri_items));
04d96139ddb32d Guangbin Huang 2021-08-30   967  	pos = scnprintf(buf, len, "%s", content);
04987ca1b9b684 Guangbin Huang 2021-01-28   968  
04987ca1b9b684 Guangbin Huang 2021-01-28   969  	for (i = 0; i < pri_num; i++) {
04987ca1b9b684 Guangbin Huang 2021-01-28   970  		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
04987ca1b9b684 Guangbin Huang 2021-01-28   971  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   972  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   973  
04987ca1b9b684 Guangbin Huang 2021-01-28   974  		ret = hclge_tm_get_pri_weight(hdev, i, &weight);
04987ca1b9b684 Guangbin Huang 2021-01-28   975  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   976  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   977  
04987ca1b9b684 Guangbin Huang 2021-01-28   978  		ret = hclge_tm_get_pri_shaper(hdev, i,
04987ca1b9b684 Guangbin Huang 2021-01-28   979  					      HCLGE_OPC_TM_PRI_C_SHAPPING,
04987ca1b9b684 Guangbin Huang 2021-01-28   980  					      &c_shaper_para);
04987ca1b9b684 Guangbin Huang 2021-01-28   981  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   982  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   983  
04987ca1b9b684 Guangbin Huang 2021-01-28   984  		ret = hclge_tm_get_pri_shaper(hdev, i,
04987ca1b9b684 Guangbin Huang 2021-01-28   985  					      HCLGE_OPC_TM_PRI_P_SHAPPING,
04987ca1b9b684 Guangbin Huang 2021-01-28   986  					      &p_shaper_para);
04987ca1b9b684 Guangbin Huang 2021-01-28   987  		if (ret)
04987ca1b9b684 Guangbin Huang 2021-01-28   988  			return ret;
04987ca1b9b684 Guangbin Huang 2021-01-28   989  
04987ca1b9b684 Guangbin Huang 2021-01-28   990  		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
04987ca1b9b684 Guangbin Huang 2021-01-28   991  			       "sp";
04987ca1b9b684 Guangbin Huang 2021-01-28   992  
04d96139ddb32d Guangbin Huang 2021-08-30   993  		j = 0;
04d96139ddb32d Guangbin Huang 2021-08-30   994  		sprintf(result[j++], "%04u", i);
04d96139ddb32d Guangbin Huang 2021-08-30   995  		sprintf(result[j++], "%4s", sch_mode_str);
04d96139ddb32d Guangbin Huang 2021-08-30   996  		sprintf(result[j++], "%3u", weight);
04d96139ddb32d Guangbin Huang 2021-08-30   997  		hclge_dbg_fill_shaper_content(&c_shaper_para, result, &j);
04d96139ddb32d Guangbin Huang 2021-08-30   998  		hclge_dbg_fill_shaper_content(&p_shaper_para, result, &j);
04d96139ddb32d Guangbin Huang 2021-08-30   999  		hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
04d96139ddb32d Guangbin Huang 2021-08-30  1000  				       (const char **)result,
04d96139ddb32d Guangbin Huang 2021-08-30  1001  				       ARRAY_SIZE(tm_pri_items));
04d96139ddb32d Guangbin Huang 2021-08-30  1002  		pos += scnprintf(buf + pos, len - pos, "%s", content);
04987ca1b9b684 Guangbin Huang 2021-01-28  1003  	}
04987ca1b9b684 Guangbin Huang 2021-01-28  1004  
04987ca1b9b684 Guangbin Huang 2021-01-28  1005  	return 0;
04987ca1b9b684 Guangbin Huang 2021-01-28  1006  }
04987ca1b9b684 Guangbin Huang 2021-01-28  1007  

:::::: The code at line 949 was first introduced by commit
:::::: 04987ca1b9b6841cfa5f9b459c5a270b75c89345 net: hns3: add debugfs support for tm nodes, priority and qset info

:::::: TO: Guangbin Huang <huangguangbin2@huawei.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
