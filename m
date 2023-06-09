Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0862C7297E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbjFILKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjFILKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:10:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72981FF3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686309009; x=1717845009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C4KeraMQP4j1I8tOMmJZjO+/GzPrt3JC0BFP9gKyGAI=;
  b=WesI4QoF/I6Hfe2/4MAqu/zLeO16iQVlYMch1y2poBLzi4zJngREaT8S
   XU1r+Tm7ZuvMJACPCNO9O1eDndp79y1ftCzyi5R1LilNGS3MG96Naopwp
   ZTPkobCk9lwV7n4LexPwhLs1+htVNeJ2Wj5HzL7uMUekTmy6lP1GiiMSB
   2jIMJLNcx/4+LnQ33qRN94Dvv8OUGsrl0LB2TGX5AMVQt/wiTFRPUGuQi
   ArHgtlFaxQ/hATuOkp9wshc7glY5lx5uNRakEZEVOnhCtPHylG8ZPJjzQ
   hafcOQKEsoVcMj88FB2rAQEG/016RMR8Dx5DibVldilfOb4As415d/3oV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="355065917"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="355065917"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 04:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="834618559"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="834618559"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2023 04:10:08 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7a0N-0008x6-0v;
        Fri, 09 Jun 2023 11:10:07 +0000
Date:   Fri, 9 Jun 2023 19:09:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm: dts: qcom: sdx55: Add interconnect path
Message-ID: <202306091848.ra1frGj3-lkp@intel.com>
References: <1686154687-29356-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686154687-29356-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on robh/for-next linus/master v6.4-rc5 next-20230608]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/arm-dts-qcom-sdx55-Add-interconnect-path/20230608-011823
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/1686154687-29356-3-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v2 2/3] arm: dts: qcom: sdx55: Add interconnect path
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230609/202306091848.ra1frGj3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pci https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
        git fetch pci for-linus
        git checkout pci/for-linus
        b4 shazam https://lore.kernel.org/r/1686154687-29356-3-git-send-email-quic_krichai@quicinc.com
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091848.ra1frGj3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-sdx55.dtsi:425.33-34 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
