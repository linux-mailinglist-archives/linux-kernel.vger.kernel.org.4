Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC567637B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 04:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAUDkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 22:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAUDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:40:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A716B40E9;
        Fri, 20 Jan 2023 19:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674272448; x=1705808448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=76058+GAT2hqimIP8ccK9sXC5zs9L8sllpS9/nWoN0U=;
  b=Zdw2SYpAHmbCm+wQx1RzBRyqYSJSqr/LAZABI5WBOCtzFN8yrbmUqXqM
   KP2/MQV+xOFVR0sbf0Sv+NJ6KWMcv3KcCGnd2U+8c64je4kghgS6zVaEU
   4qIiFieTnS9KKhTQt2VtBaTSHldLhuGKPd1ZQ1SR9sYBk8LAzOYo2cQL8
   Pko0HLHHzrGiJUDGRhOs7q8RiymHMV4YxMSB+oBmI9fm55LG4HkwfwbcV
   ULxTPJHzbW5lYrPowW+0w94SWHqOd4hW67nCDHvnZN7le4eoUH5XDmvXB
   +FRg0RdYNJn9UYLGg5Ay4oY9b4Vlron00R8LYX5p4NXOKOzzzXunMS0gF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="306114227"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="306114227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 19:40:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="906180541"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="906180541"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jan 2023 19:40:45 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ4kG-0003LU-2P;
        Sat, 21 Jan 2023 03:40:44 +0000
Date:   Sat, 21 Jan 2023 11:39:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c4
Message-ID: <202301211130.XOrJCPF2-lkp@intel.com>
References: <20230119214749.4048933-5-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119214749.4048933-5-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on robh/for-next broonie-sound/for-next linus/master v6.2-rc4]
[cannot apply to next-20230120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bjorn-Andersson/dt-bindings-regulator-Describe-Maxim-MAX20411/20230120-061409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20230119214749.4048933-5-quic_bjorande%40quicinc.com
patch subject: [PATCH 4/4] arm64: dts: qcom: sa8295p-adp: Add max20411 on i2c4
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230121/202301211130.XOrJCPF2-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/75c5fbc70a2e2cbd360675e2dc0fb001b3ad6fdf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bjorn-Andersson/dt-bindings-regulator-Describe-Maxim-MAX20411/20230120-061409
        git checkout 75c5fbc70a2e2cbd360675e2dc0fb001b3ad6fdf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/qcom/sa8295p-adp.dts:502.1-16 Label or path pmm8540a_gpios not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
