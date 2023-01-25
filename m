Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371C67A9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 06:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjAYFMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 00:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAYFMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 00:12:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4B4232;
        Tue, 24 Jan 2023 21:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674623567; x=1706159567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9kh4pjpDmY2kWfdusSrzxSlKzDtAEvxznpXtozkLK4=;
  b=CX+6v7RZiLGypWtqHDaHOPQgN8bBIPT3+HI2fpyWQG9Av1dWovZ/EMVq
   Ui2ANbhPl4wJDQax7ovD6bMzY4BpGHOThrTu3v2UNEq1kbGgY22bh9a+y
   SuFhj1oRuoNYdZ4o/uMQbQXVD72L7RW5mVhabWl1JI5GWWSwI22wHveSs
   0eMYoMK0PcVAhtlkF0iR5MSHLRBKv+EUJjnj9M/twNXepBv3kqP3BXada
   I7uklcOK5Z7iCAL6Wn9YP5x7rTnwOetPqH0QS3y8NFHTsbNpfJe9rDug2
   cDdVZ/F1Io50r4puo8nWgHwkz7idhZGdIYTxIecC7Sn02LX9LYCzziVNl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328570928"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="328570928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 21:12:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694618374"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="694618374"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2023 21:12:43 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pKY5S-00073E-0m;
        Wed, 25 Jan 2023 05:12:42 +0000
Date:   Wed, 25 Jan 2023 13:12:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alex Elder <elder@ieee.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, vkoul@kernel.org,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH V2 1/3] soc: qcom: dcc: Add bootconfig support for DCC
Message-ID: <202301251351.Vmj07n6Z-lkp@intel.com>
References: <62d98c7d56e752afff5216cfcd42451edb82cb4d.1674531462.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d98c7d56e752afff5216cfcd42451edb82cb4d.1674531462.git.quic_schowdhu@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Souradeep,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230123]
[cannot apply to clk/clk-next soc/for-next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Souradeep-Chowdhury/soc-qcom-dcc-Add-bootconfig-support-for-DCC/20230124-115549
patch link:    https://lore.kernel.org/r/62d98c7d56e752afff5216cfcd42451edb82cb4d.1674531462.git.quic_schowdhu%40quicinc.com
patch subject: [PATCH V2 1/3] soc: qcom: dcc: Add bootconfig support for DCC
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20230125/202301251351.Vmj07n6Z-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/752745566c275592d6d18692bc53886e6e955e94
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Souradeep-Chowdhury/soc-qcom-dcc-Add-bootconfig-support-for-DCC/20230124-115549
        git checkout 752745566c275592d6d18692bc53886e6e955e94
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xbc_node_get_child" [drivers/soc/qcom/dcc.ko] undefined!
>> ERROR: modpost: "xbc_node_get_next" [drivers/soc/qcom/dcc.ko] undefined!
>> ERROR: modpost: "xbc_node_find_value" [drivers/soc/qcom/dcc.ko] undefined!
>> ERROR: modpost: "xbc_node_get_data" [drivers/soc/qcom/dcc.ko] undefined!
>> ERROR: modpost: "xbc_node_find_subkey" [drivers/soc/qcom/dcc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
