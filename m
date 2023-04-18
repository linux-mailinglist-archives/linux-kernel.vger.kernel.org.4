Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE36E5878
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDRFTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDRFT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:19:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F1835BE;
        Mon, 17 Apr 2023 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681795166; x=1713331166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApemhVgsU+TFdPtwqGDQRyH9z/W8/lC9uWid1us00p8=;
  b=jm6W5vWtURdp2gOlWJQBRL340792QWIMJYTuoD5HkQyscjpgcmhPOw9u
   +2VZ7kLGAA6xH6NylNEMyG09MgzgV6r63JlStLmpV9V1PivjXcJRx2cgz
   NSAWD40b/QgZE4QSuZ4s/ZVDUYgnVkMk+Ey1WZrv3GyU8zXEcj3F5H/3D
   7yxGsoQYGKdfww9iegSxtieIleAOMwca4AnWK1UncKND8VnzXXDuxQPVV
   /6UeIT5ZpKZ4wwocX9p2E7wwH8bHCnl25X4yZVm4yLpmoP3WIL1B/gj/Z
   9Tfl0XUwDE5DoTe7Z204E6lngPzR4uHWbA61rY0e7mP/73QNB0tuZj5Kp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325417315"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="325417315"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 22:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="815071972"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="815071972"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2023 22:19:22 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1podkP-000d1P-1u;
        Tue, 18 Apr 2023 05:19:21 +0000
Date:   Tue, 18 Apr 2023 13:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data
 Capture and Compare unit(DCC)
Message-ID: <202304181327.0grVYsHS-lkp@intel.com>
References: <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souradeep,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.3-rc7 next-20230417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Souradeep-Chowdhury/dt-bindings-misc-qcom-dcc-Add-the-dtschema/20230414-220304
patch link:    https://lore.kernel.org/r/b1a9cbbcfefe133cc9047a71a2acdaa74239df29.1681480351.git.quic_schowdhu%40quicinc.com
patch subject: [PATCH V1 2/3] drivers: misc: dcc: Add driver support for Data Capture and Compare unit(DCC)
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20230418/202304181327.0grVYsHS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 9638da200e00bd069e6dd63604e14cbafede9324)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f3f73f6008e1ebca6fba848e260b1f938d91be95
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Souradeep-Chowdhury/dt-bindings-misc-qcom-dcc-Add-the-dtschema/20230414-220304
        git checkout f3f73f6008e1ebca6fba848e260b1f938d91be95
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304181327.0grVYsHS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/misc/dcc.c:217:14: warning: variable 'ret' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
           for (i = 0; i < drvdata->nr_link_list; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/dcc.c:238:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/misc/dcc.c:217:14: note: remove the condition if it is always true
           for (i = 0; i < drvdata->nr_link_list; i++) {
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/dcc.c:190:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +217 drivers/misc/dcc.c

   186	
   187	static int dcc_sw_trigger(struct dcc_drvdata *drvdata)
   188	{
   189		void __iomem *addr;
   190		int ret;
   191		int i;
   192		u32 status;
   193		u32 ll_cfg;
   194		u32 tmp_ll_cfg;
   195		u32 val;
   196	
   197		mutex_lock(&drvdata->mutex);
   198	
   199		for (i = 0; i < drvdata->nr_link_list; i++) {
   200			if (!test_bit(i, drvdata->enable_bitmap))
   201				continue;
   202			ll_cfg = dcc_list_readl(drvdata, i, DCC_LL_CFG);
   203			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
   204			dcc_list_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
   205			dcc_list_writel(drvdata, 1, i, DCC_LL_SW_TRIGGER);
   206			dcc_list_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
   207		}
   208	
   209		addr = drvdata->base + DCC_STATUS(drvdata->mem_map_ver);
   210		if (readl_poll_timeout(addr, val, !FIELD_GET(DCC_STATUS_MASK, val),
   211				       1, STATUS_READY_TIMEOUT)) {
   212			dev_err(drvdata->dev, "DCC is busy after receiving sw trigger\n");
   213			ret = -EBUSY;
   214			goto out_unlock;
   215		}
   216	
 > 217		for (i = 0; i < drvdata->nr_link_list; i++) {
   218			if (!test_bit(i, drvdata->enable_bitmap))
   219				continue;
   220	
   221			status = dcc_list_readl(drvdata, i, DCC_LL_BUS_ACCESS_STATUS);
   222			if (!status)
   223				continue;
   224	
   225			dev_err(drvdata->dev, "Read access error for list %d err: 0x%x\n",
   226				i, status);
   227			ll_cfg = dcc_list_readl(drvdata, i, DCC_LL_CFG);
   228			tmp_ll_cfg = ll_cfg & ~DCC_TRIGGER_MASK;
   229			dcc_list_writel(drvdata, tmp_ll_cfg, i, DCC_LL_CFG);
   230			dcc_list_writel(drvdata, DCC_STATUS_MASK, i, DCC_LL_BUS_ACCESS_STATUS);
   231			dcc_list_writel(drvdata, ll_cfg, i, DCC_LL_CFG);
   232			ret = -ENODATA;
   233			break;
   234		}
   235	
   236	out_unlock:
   237		mutex_unlock(&drvdata->mutex);
   238		return ret;
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
