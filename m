Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D9D676320
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjAUCjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjAUCjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:39:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80A73EC8;
        Fri, 20 Jan 2023 18:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674268786; x=1705804786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kkRU9+v7s3/jgXK0nwbwD2l2LkQPlCkqam5LVNMcsA8=;
  b=ODrT4E915IEjILUY6xxVSjlgkULwKVS8rtva0BBKVdPto/uZ5Z4Xcecu
   +NO/vNMZXzSF55aWN6x8NkvtJ6+vwhT5/C8HjFeruh7GkhqlZ4VehaGED
   NVA3wgKFzeLNyXRwxlNV3bxQQWQ+X/3CfNmjCSJ0eZnUvTVyyjGD2qKa/
   UyXFq9bi6ENDPp2VjsgwyWSVXZA3Am4V6nN2vr4sSXfkwDqN2er37bHb7
   XgtW2wzLeonxp64FluDeKpbD5Ni+q1utWPnKOR2WUZ7wT0VueQbJTXiNd
   a8y9+V2AOB0PD1o/O4v+Bm8bDuwVqhGIsCrBg5FJe2ukTtqYS07bHRxfz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="327021861"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="327021861"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 18:39:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="749566740"
X-IronPort-AV: E=Sophos;i="5.97,234,1669104000"; 
   d="scan'208";a="749566740"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2023 18:39:42 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJ3nB-0003HQ-2w;
        Sat, 21 Jan 2023 02:39:41 +0000
Date:   Sat, 21 Jan 2023 10:38:44 +0800
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
Message-ID: <202301211057.EQa4jBtA-lkp@intel.com>
References: <20230119214749.4048933-5-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119214749.4048933-5-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230121/202301211057.EQa4jBtA-lkp@intel.com/config)
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

>> Error: arch/arm64/boot/dts/qcom/sa8295p-adp.dts:502.1-16 Label or path pmm8540a_gpios not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
