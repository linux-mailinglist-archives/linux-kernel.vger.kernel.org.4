Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539D6D29C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjCaVHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 17:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCaVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 17:07:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219422368C;
        Fri, 31 Mar 2023 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680296825; x=1711832825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hqlv68DJE/cu8rDemNi42irkA/HAx4L+cOrET7Znf9g=;
  b=YAgkWMZeB2Y5+/d6WPKR5+ghbBdJ4pe+adChmY/YmRslNKr2XH7Uzehv
   W8VYsX5DE9mTh0J8AoG1iJ38EXnO+8WMV9Omd8ZZjfO2exlzHAaBIOqrS
   2qS//K1K+2ESQGBQa+jaSnDA8LBl/6tn5qhorbl2IAit/BlHEhb0zEZ17
   KHF+LuNlkfsFxL2pg7cFkOGoRS+wPJHNJNzSyAe4iCV1wG3zvKl0QcqrX
   TX2PetcRdSw6xopOYK5hrxkpjnQJie9qQQR40/oCDBl+xME75y+FiPukY
   XOfFvhi1k8BQglr32XfhQSDFvIhVH/X+/5HklBJBUXZ+hZM9zTN8/1f3U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="325540886"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="325540886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 14:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="678745608"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="678745608"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 Mar 2023 14:07:02 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piLxY-000MAJ-1Y;
        Fri, 31 Mar 2023 21:06:56 +0000
Date:   Sat, 1 Apr 2023 05:06:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: sdx55-fn980: Move "status" property
 to the end of node
Message-ID: <202304010413.fguDBfM6-lkp@intel.com>
References: <20230331145915.11653-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331145915.11653-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230331]
[cannot apply to robh/for-next v6.3-rc4 v6.3-rc3 v6.3-rc2 linus/master v6.3-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manivannan-Sadhasivam/ARM-dts-qcom-sdx55-fn980-Move-status-property-to-the-end-of-node/20230331-230033
patch link:    https://lore.kernel.org/r/20230331145915.11653-2-manivannan.sadhasivam%40linaro.org
patch subject: [PATCH 2/2] ARM: dts: qcom: sdx55-fn980: Move "status" property to the end of node
config: arm-randconfig-r046-20230329 (https://download.01.org/0day-ci/archive/20230401/202304010413.fguDBfM6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0ec51f1198e0249d2b1b75a883d1bffb0cdbd024
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Manivannan-Sadhasivam/ARM-dts-qcom-sdx55-fn980-Move-status-property-to-the-end-of-node/20230331-230033
        git checkout 0ec51f1198e0249d2b1b75a883d1bffb0cdbd024
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304010413.fguDBfM6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts:279.2-18 Properties must precede subnodes
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
