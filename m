Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BA6AA80C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 05:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCDEtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 23:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCDEtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 23:49:41 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962B40F8;
        Fri,  3 Mar 2023 20:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677905380; x=1709441380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G6dihmxwb1tQgt5Z+zdr5TcbapRbPGbCC3x+s8NtXVQ=;
  b=k18g9RNRy9K3Ybx7saIuKjH43WjC4Mam7WGE6w3SynQo87GEx9PqKPlF
   4zXuTOVGD+c4pbu6rSy3h0HEibCURyCbqahB2wnkVILz719cRoJJci9G6
   Lb9kMPALR575omEUkvYC0fe1zlKvL4EyEWMEjyzUHGaQLujJo9kezs9XZ
   4E+m2SukfO46JxAWRQRmYEfPV+S9HfjtNlOcEsFe55l27aE8+hw0CL6ha
   w3cFDGX9iws6O/5RyZQt8+ZN6eTuhKhP5fgbC/f3aMJUQkXMNl9C8bV3r
   7yMv0hQvOStxov1dFMDsoQjFnKPeRsDnTo4qgfABUnzhuuhttfL2YgE2d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="337540297"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="337540297"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 20:49:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="764650285"
X-IronPort-AV: E=Sophos;i="5.98,232,1673942400"; 
   d="scan'208";a="764650285"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Mar 2023 20:49:34 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYJpu-0001rs-0x;
        Sat, 04 Mar 2023 04:49:34 +0000
Date:   Sat, 4 Mar 2023 12:48:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Wang <tomato1220@gmail.com>, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: Re: [PATCH 6/7] ARM: dts: nuvoton: gsj: Add non-mainline nodes
Message-ID: <202303041219.aqKPeLbq-lkp@intel.com>
References: <20230303063435.803097-6-davidwang@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303063435.803097-6-davidwang@quantatw.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on soc/for-next arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next xilinx-xlnx/master linus/master v6.2 next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Wang/ARM-dts-nuvoton-Add-Quanta-GSZ-BMC-Device-Tree/20230303-143845
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230303063435.803097-6-davidwang%40quantatw.com
patch subject: [PATCH 6/7] ARM: dts: nuvoton: gsj: Add non-mainline nodes
config: arm-randconfig-r046-20230302 (https://download.01.org/0day-ci/archive/20230304/202303041219.aqKPeLbq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e0e9ec65c5d1ad7030102833e6ee800d936bf266
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Wang/ARM-dts-nuvoton-Add-Quanta-GSZ-BMC-Device-Tree/20230303-143845
        git checkout e0e9ec65c5d1ad7030102833e6ee800d936bf266
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303041219.aqKPeLbq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:188.1-4 Label or path mc not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:192.1-6 Label or path emc0 not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:202.1-7 Label or path ohci1 not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:206.1-5 Label or path aes not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:210.1-5 Label or path sha not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:214.1-9 Label or path pcimbox not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:218.1-6 Label or path udc9 not found
>> Error: arch/arm/boot/dts/nuvoton-npcm730-gsj.dts:250.1-5 Label or path otp not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
