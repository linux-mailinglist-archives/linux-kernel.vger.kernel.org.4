Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD666AA934
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 11:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjCDKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 05:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 05:37:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD35FF9
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677926273; x=1709462273;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZXF3kzkGRkKJkysmUvKBusm72UhQV6+xyKP+pSDApks=;
  b=AClvsv6Jc8fnCD23CrY+h25verLrrCP1nIXAcYRDe43wm2agpbvypsYb
   1oU7vJf0NogtmfhrOwu4Pxf/FQ5savHf4QJfJTdIkIlq22PjocXMrXjOC
   A70W+fy4JkhKbaekXg/d+lKifLJ3VHC4E0cPazGYZ4XuA4kXgxaSQbh4U
   2GIvpH9Zmeyn1MM2I0mGuuJdaXKvqLQumz+pSOQWpstniNusbxSBL2HUW
   C0C7Lm/NjXd9RbQrg8glaurF3UekNtcFz1gF26Lg+nCpos1G/2McSvxuS
   XnwYtR+Id9fmdqaz5mmiJUN59AUyGRDzDmNEUEtJo7JTIczeVZaTrQYSQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332726671"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="332726671"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 02:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="708116617"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="708116617"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2023 02:37:50 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYPGv-00025g-2X;
        Sat, 04 Mar 2023 10:37:49 +0000
Date:   Sat, 4 Mar 2023 18:37:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/power/supply/qcom_battmgr.c:357:31: sparse: sparse:
 incorrect type in initializer (different base types)
Message-ID: <202303041819.L36zCcwM-lkp@intel.com>
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

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0988a0ea791999ebbf95693f2676381825b05033
commit: 92304df83b943776492309f42452effea0cc1089 power: supply: qcom_battmgr: remove bogus do_div()
date:   3 days ago
config: openrisc-randconfig-s052-20230302 (https://download.01.org/0day-ci/archive/20230304/202303041819.L36zCcwM-lkp@intel.com/config)
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
| Link: https://lore.kernel.org/oe-kbuild-all/202303041819.L36zCcwM-lkp@intel.com/

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
