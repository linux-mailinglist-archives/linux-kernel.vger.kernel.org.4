Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0273A7C8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFVRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjFVRzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:55:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD271BE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687456504; x=1718992504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tRiiGjGdv54z/J7itdv3G70cSX/YZlvgu1tU75BM+HY=;
  b=GHaeNDcf86Ve6dA1rLGUgX/kAW6DelyrQY9OPpnVZAXprj9kbMBbsaVo
   eLm4t8WtnyvDRiIcF/QlIIdvjTXcZcvKIDy9pOpccSBypGAqtLJKyouBw
   xhswYUi6qJDJ7GtqyBhGimp85f/wfDlhcLm8+Kd4mkmCae2YeagDtfdhL
   ft+rXfdzMkwxerShQ1nF1tw9nNNuT8I6xH3FPlCGy42TIzcQhrSGFcmvj
   mJWjlQk3PGJSfRsVZbXyFDJ/a0fMDxHEwvhM4/H5GhcTRBaD7X32cK/k8
   frJzRYjcMrJEqF+L8TuA65IvQl6cfuxyn8cvtTg6OsczvP4GHxVuC6ySj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="446940504"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="446940504"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="839157386"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="839157386"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2023 10:54:45 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qCOW4-0007ir-2f;
        Thu, 22 Jun 2023 17:54:44 +0000
Date:   Fri, 23 Jun 2023 01:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mach-imx/pm-imx25.c:31:13: warning: no previous prototype
 for 'imx25_pm_init'
Message-ID: <202306230159.SlgPEfcA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dad9774deaf1cf8e8f7483310dfb2690310193d2
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   1 year, 2 months ago
config: arm-randconfig-r034-20230622 (https://download.01.org/0day-ci/archive/20230623/202306230159.SlgPEfcA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230623/202306230159.SlgPEfcA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306230159.SlgPEfcA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-imx/pm-imx25.c:31:13: warning: no previous prototype for 'imx25_pm_init' [-Wmissing-prototypes]
      31 | void __init imx25_pm_init(void)
         |             ^~~~~~~~~~~~~
--
>> arch/arm/mach-imx/cpu-imx25.c:40:5: warning: no previous prototype for 'mx25_revision' [-Wmissing-prototypes]
      40 | int mx25_revision(void)
         |     ^~~~~~~~~~~~~
--
>> arch/arm/mm/copypage-feroceon.c:65:6: warning: no previous prototype for 'feroceon_copy_user_highpage' [-Wmissing-prototypes]
      65 | void feroceon_copy_user_highpage(struct page *to, struct page *from,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mm/copypage-feroceon.c:78:6: warning: no previous prototype for 'feroceon_clear_user_highpage' [-Wmissing-prototypes]
      78 | void feroceon_clear_user_highpage(struct page *page, unsigned long vaddr)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/imx25_pm_init +31 arch/arm/mach-imx/pm-imx25.c

8c4300c227ffff Fabio Estevam 2016-02-02  30  
8c4300c227ffff Fabio Estevam 2016-02-02 @31  void __init imx25_pm_init(void)

:::::: The code at line 31 was first introduced by commit
:::::: 8c4300c227ffffc4db26b6bb3e0271de7ddbd289 ARM: mx25: Add basic suspend/resume support

:::::: TO: Fabio Estevam <fabio.estevam@nxp.com>
:::::: CC: Shawn Guo <shawnguo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
