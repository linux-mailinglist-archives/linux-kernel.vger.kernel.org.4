Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048BB6C5B64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCWAfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjCWAfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:35:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7E84ED5;
        Wed, 22 Mar 2023 17:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679531705; x=1711067705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wp4vyR2Y2dOx4yjIT2WaC+9FkZoxRrFcxxrBaYARJOI=;
  b=RjHDcvOyuYC60laji9YoVk4gML/oUoaArp5iEEM/IiNvvK9kav+4WbHF
   b3EE7ps51t6U356XwwAjZx0fnlJ0BSMWKShpBdP48RVOv0QVRXOSpOmtE
   YLSQRKaYHMFz5zxJ/ZvNsXgXUG9qJRkqC+dDTZ9UbbpirBoxSuuIjr/JF
   JeQk73kQV8CBJ2McRXBBN4iPFWDL9EmyFcvUKk3/dlX+BU2vPUiVuYwqq
   1eNQKeiqO2Q8ZHx5o+jdHoXRPcsuRjyzyhhYhKO33KMenu0lq737HUyBO
   dtbhqd3Etf518A0I6vLpBN3iszSzJy96CP0OcCc6D/JKsw5Jwkaj24LCg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319756228"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="319756228"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 17:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="928031581"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="928031581"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2023 17:35:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pf8uz-000Dma-2A;
        Thu, 23 Mar 2023 00:35:01 +0000
Date:   Thu, 23 Mar 2023 08:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add
 Xiaomi Mi Pad 5 Pro BOE variant
Message-ID: <202303230827.w5y3UTfE-lkp@intel.com>
References: <20230322150320.31787-3-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322150320.31787-3-lujianhua000@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianhua,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.3-rc3 next-20230322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianhua-Lu/arm64-dts-qcom-sm8250-xiaomi-elish-add-mdss-and-dsi-node/20230322-230551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230322150320.31787-3-lujianhua000%40gmail.com
patch subject: [PATCH 3/4] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add Xiaomi Mi Pad 5 Pro BOE variant
config: arm64-randconfig-r011-20230322 (https://download.01.org/0day-ci/archive/20230323/202303230827.w5y3UTfE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/14b429402cdaeb77734646a64f00653841d703a7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianhua-Lu/arm64-dts-qcom-sm8250-xiaomi-elish-add-mdss-and-dsi-node/20230322-230551
        git checkout 14b429402cdaeb77734646a64f00653841d703a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303230827.w5y3UTfE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi:516.14-15 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
