Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478426B4E13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCJRJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCJRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:07:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EE527D44
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678468010; x=1710004010;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AES5+2Fh3BTiDTC8WrIuo+taq69qwcusmoVnsbxFpsA=;
  b=ZGVe7fVn4/J/N5i+AJcSlAK7TmWC00Mo/XjcaMlaIQ5Ih27Tvfij1nPK
   5uHSJLXZMmQBClHDH63X9jCLf2MP1MzR37H2/EGIBAuAej9IWj7P2cwrk
   2IeYlPD1877W1ZyQRLyfovQWHB5+mWLO8A+bjs1q0tgEFISm4V+ZYH2Se
   9lLZS9c7jQgySH0geSumKVqzBrMlQkGum3rjL8b9Lp9UD4qkxmRs7LKNN
   q1sElnNhCvn68zOtOAdDxr8KTQh5nb1NT+oZ3fbxGNAB5L5tYXySlRNSl
   ppe+P4NqziPcmQT7TbcRt20Jczp18nI4qlSXTV4LHtAS5HXfdVlGPcZgu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335475530"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335475530"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 09:05:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="1007191527"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="1007191527"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2023 09:05:25 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pagBI-00041B-2z;
        Fri, 10 Mar 2023 17:05:24 +0000
Date:   Sat, 11 Mar 2023 01:04:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202303110050.1EF6YVC5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   44889ba56cbb3d51154660ccd15818bc77276696
commit: 92304df83b943776492309f42452effea0cc1089 power: supply: qcom_battmgr: remove bogus do_div()
date:   9 days ago
config: openrisc-randconfig-s042-20230310 (https://download.01.org/0day-ci/archive/20230311/202303110050.1EF6YVC5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92304df83b943776492309f42452effea0cc1089
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 92304df83b943776492309f42452effea0cc1089
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303110050.1EF6YVC5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
   drivers/power/supply/qcom_battmgr.c:357:31: sparse:     expected unsigned int [usertype] battery_id
   drivers/power/supply/qcom_battmgr.c:357:31: sparse:     got restricted __le32 [usertype]
   drivers/power/supply/qcom_battmgr.c:369:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] battery_id @@     got restricted __le32 [usertype] @@
   drivers/power/supply/qcom_battmgr.c:369:31: sparse:     expected unsigned int [usertype] battery_id
   drivers/power/supply/qcom_battmgr.c:369:31: sparse:     got restricted __le32 [usertype]
>> drivers/power/supply/qcom_battmgr.c:1285:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] owner @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1285:30: sparse:     expected restricted __le32 [usertype] owner
   drivers/power/supply/qcom_battmgr.c:1285:30: sparse:     got int
>> drivers/power/supply/qcom_battmgr.c:1286:29: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] type @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1286:29: sparse:     expected restricted __le32 [usertype] type
   drivers/power/supply/qcom_battmgr.c:1286:29: sparse:     got int
>> drivers/power/supply/qcom_battmgr.c:1287:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le32 [usertype] opcode @@     got int @@
   drivers/power/supply/qcom_battmgr.c:1287:31: sparse:     expected restricted __le32 [usertype] opcode
   drivers/power/supply/qcom_battmgr.c:1287:31: sparse:     got int

vim +357 drivers/power/supply/qcom_battmgr.c

29e8142b5623b5 Bjorn Andersson 2023-02-07  350  
29e8142b5623b5 Bjorn Andersson 2023-02-07  351  static int qcom_battmgr_update_status(struct qcom_battmgr *battmgr)
29e8142b5623b5 Bjorn Andersson 2023-02-07  352  {
29e8142b5623b5 Bjorn Andersson 2023-02-07  353  	struct qcom_battmgr_update_request request = {
29e8142b5623b5 Bjorn Andersson 2023-02-07  354  		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
29e8142b5623b5 Bjorn Andersson 2023-02-07  355  		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
29e8142b5623b5 Bjorn Andersson 2023-02-07  356  		.hdr.opcode = cpu_to_le32(BATTMGR_BAT_STATUS),
29e8142b5623b5 Bjorn Andersson 2023-02-07 @357  		.battery_id = cpu_to_le32(0),
29e8142b5623b5 Bjorn Andersson 2023-02-07  358  	};
29e8142b5623b5 Bjorn Andersson 2023-02-07  359  
29e8142b5623b5 Bjorn Andersson 2023-02-07  360  	return qcom_battmgr_request(battmgr, &request, sizeof(request));
29e8142b5623b5 Bjorn Andersson 2023-02-07  361  }
29e8142b5623b5 Bjorn Andersson 2023-02-07  362  

:::::: The code at line 357 was first introduced by commit
:::::: 29e8142b5623b5949587bcc4f591c4e6595c4aca power: supply: Introduce Qualcomm PMIC GLINK power supply

:::::: TO: Bjorn Andersson <bjorn.andersson@linaro.org>
:::::: CC: Bjorn Andersson <andersson@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
