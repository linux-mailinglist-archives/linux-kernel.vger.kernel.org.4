Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B015B7DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 02:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiINAXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINAXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 20:23:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308616C11B;
        Tue, 13 Sep 2022 17:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663114982; x=1694650982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BEZbqskRU3Qqoaap6epCX9f3SVPC24cLFK4ZgsHlh98=;
  b=fk6V6L8TyH685FCTW2RkKrZiGJW0katNyIWSU2jbeutzlbVripC1EymN
   FTDxlSBN7b2FprA1K7Azxhx7ZvzsK21HyZ1RGZlPcacMwBsWSeg7ovAzs
   zxQSvnaZ026oyWJ8FuaLJ5UXRf6fzVN5WoSLCkNxfvlWFu1cvXeDsEyuX
   eL592D4LgX21gzo24MYWJhEnOc+LaWrrGGizFqWkehfZc+Y0QsS2wITTg
   MptdFB4TY924ttPbnYZJxXe9XMiUbz3aFeKSESN1jOYsnAmIyps/xooG+
   4DE3zKUC+5Kt7c5pt0hrJFV6stVqktrdir4/kX6YGlbyOCPeRKNk3SAzc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285334574"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="285334574"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 17:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="792130674"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2022 17:22:58 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYGB7-00049f-1f;
        Wed, 14 Sep 2022 00:22:57 +0000
Date:   Wed, 14 Sep 2022 08:22:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        robh@kernel.org, andersson@kernel.org, rafael@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8150: Add qmi cooling device
 nodes
Message-ID: <202209140842.dk0QBtpI-lkp@intel.com>
References: <20220912091643.3537857-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912091643.3537857-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm64/for-next/core clk/clk-next rockchip/for-next shawnguo/for-next soc/for-next xilinx-xlnx/master linus/master v6.0-rc5 next-20220913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/arm64-qcom-Introduce-Qualcomm-Cooling-Driver-suppport/20220912-171936
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220914/202209140842.dk0QBtpI-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/34ee1e982e105446a5f8ec8d41381f38a9c8bf0b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Bhupesh-Sharma/arm64-qcom-Introduce-Qualcomm-Cooling-Driver-suppport/20220912-171936
        git checkout 34ee1e982e105446a5f8ec8d41381f38a9c8bf0b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/qcom/sa8155p-adp.dts:10:
>> arch/arm64/boot/dts/qcom/sm8150.dtsi:16:10: fatal error: dt-bindings/thermal/qcom,tmd.h: No such file or directory
      16 | #include <dt-bindings/thermal/qcom,tmd.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +16 arch/arm64/boot/dts/qcom/sm8150.dtsi

  > 16	#include <dt-bindings/thermal/qcom,tmd.h>
    17	#include <dt-bindings/thermal/thermal.h>
    18	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
