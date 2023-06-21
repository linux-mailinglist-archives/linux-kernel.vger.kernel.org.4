Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC270738A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFUPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjFUPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:46:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174DE69
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687362376; x=1718898376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6aeZt3AGr6ft5yHMkjJnVz9mKRAHdriZ/qLt81RNsCk=;
  b=U30gY86F34elzbJcD7pVKT0tTJgCQCVFIxnOsUp5p1SNQ8AV7c/13u71
   2Oeji41n05ypobXn0QpXxnz1J1OQ2neCNrb327omMN0/7JexvD5eVN/kG
   P2pt6CXKu513i5s9fi9bCCM9YSIjwwelsOTbRPqzoYRjipHDmd3x9Xlr3
   WJo14mSNEndKD+d0A88FVqXC7MQXVKU9wuU5ekvxHU5VI/OWMpBpJMRbf
   0Egvn/s4xw/O03b+cY94FTu326IStrWmWlhBLRRWYGocH7JWE2Oe78zfV
   XHXomBzX7zqaUAOkK7CqUiWd7A3ByEnQakAr9EriOgbe1d42YHT2T3FUd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359082022"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="359082022"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="717704974"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="717704974"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jun 2023 08:46:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qC025-0006uv-2s;
        Wed, 21 Jun 2023 15:46:09 +0000
Date:   Wed, 21 Jun 2023 23:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arc-rimi.c:undefined reference to `ioremap'
Message-ID: <202306212350.fgz5R8Xv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e660abd551f1172e428b4e4003de887176a8a1fd
commit: 6ef55060a1cc29dd54ff390f22cb3de266dab2b0 s390: make use of CONFIG_FUNCTION_ALIGNMENT
date:   3 months ago
config: s390-randconfig-r035-20230621 (https://download.01.org/0day-ci/archive/20230621/202306212350.fgz5R8Xv-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230621/202306212350.fgz5R8Xv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306212350.fgz5R8Xv-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
   clk-fixed-mmio.c:(.text+0x92): undefined reference to `of_iomap'
   s390-linux-ld: clk-fixed-mmio.c:(.text+0xda): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/fsl-edma.o: in function `fsl_edma_probe':
   fsl-edma.c:(.text+0xa02): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: fsl-edma.c:(.text+0xc86): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0x137a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0x13d4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x90): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xd4): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `config_ipwireless':
   main.c:(.text+0x23e): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x35c): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe.part.0':
   main.c:(.text+0x468): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x51c): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x56a): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x59e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
>> arc-rimi.c:(.text+0x2ba): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.text+0x2dc): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x2e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0xec): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x184): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2a4): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x37e): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x466): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_release':
   smc91c92_cs.c:(.text+0x9ce): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/smsc/smc91c92_cs.o: in function `smc91c92_config':
   smc91c92_cs.c:(.text+0x1a3a): undefined reference to `ioremap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_release':
   xirc2ps_cs.c:(.text+0x39e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xircom/xirc2ps_cs.o: in function `xirc2ps_config':
   xirc2ps_cs.c:(.text+0x1674): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x4a4): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x4de): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x562): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x574): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xdb6): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
