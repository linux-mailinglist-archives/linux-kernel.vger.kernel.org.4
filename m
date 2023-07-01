Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D3F744BA6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGAWw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 18:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 18:52:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89B10D0
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688251945; x=1719787945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aT21eX5ZX1k2UFewqeNd8gsd73GOde4L130zhE4Xmmo=;
  b=PPOQtW8wenNkLfdcb6ymCwQCjUV5BfUvuzmHQdgebYzwL3+s+ASfp0WL
   7JsSK+v/gigNGzXTXaq0ARdSOis+9SgzirjVpRAy6W5K+gWPsCNItCJEp
   tMThL5QDfoPpX+ThJhF1TIZMucuVwggIV1Nq6XmubcmLXj+SXn3ZiuGHu
   XguogVpvBbYoLvy/CYbe9Gx+ALwjeQ99u1EwHlTVVkbNUKKAjtdADYLCI
   ucuLhjsMVxq+rB2SaOcrASrERvt4vgU+2dyMxydletCj3VHNoRtZcqFRv
   lYtqCF5H4rRokROEmGPIK/MjvttCRVf2T4IJaYaOYeEaDkL0InOQE7fzo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="347418113"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="347418113"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 15:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="892139143"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="892139143"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jul 2023 15:52:22 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFjS2-000GJ7-0R;
        Sat, 01 Jul 2023 22:52:22 +0000
Date:   Sun, 2 Jul 2023 06:51:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/loongson64/smp.c:203:26: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202307020639.QCZOKp8B-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfab92f27c600fea3cadc6e2cb39f092024e1fef
commit: 5bd3990723bdf43333b2c268cc6644cb1961125b MIPS: Loongson64: Prefix ipi register address pointers with __iomem
date:   4 months ago
config: mips-randconfig-r081-20230702 (https://download.01.org/0day-ci/archive/20230702/202307020639.QCZOKp8B-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230702/202307020639.QCZOKp8B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/mips/loongson64/smp.c:203:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:203:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:203:26: sparse:     got void *
   arch/mips/loongson64/smp.c:205:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:205:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:205:26: sparse:     got void *
   arch/mips/loongson64/smp.c:207:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:207:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:207:26: sparse:     got void *
   arch/mips/loongson64/smp.c:209:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:209:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:209:26: sparse:     got void *
   arch/mips/loongson64/smp.c:211:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:211:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:211:26: sparse:     got void *
   arch/mips/loongson64/smp.c:213:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:213:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:213:26: sparse:     got void *
   arch/mips/loongson64/smp.c:215:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:215:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:215:26: sparse:     got void *
   arch/mips/loongson64/smp.c:217:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:217:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:217:26: sparse:     got void *
   arch/mips/loongson64/smp.c:219:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:219:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:219:26: sparse:     got void *
   arch/mips/loongson64/smp.c:221:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:221:26: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:221:26: sparse:     got void *
   arch/mips/loongson64/smp.c:223:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:223:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:223:27: sparse:     got void *
   arch/mips/loongson64/smp.c:225:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:225:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:225:27: sparse:     got void *
   arch/mips/loongson64/smp.c:227:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:227:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:227:27: sparse:     got void *
   arch/mips/loongson64/smp.c:229:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:229:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:229:27: sparse:     got void *
   arch/mips/loongson64/smp.c:231:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:231:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:231:27: sparse:     got void *
   arch/mips/loongson64/smp.c:233:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:233:27: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:233:27: sparse:     got void *
   arch/mips/loongson64/smp.c:239:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:239:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:239:28: sparse:     got void *
   arch/mips/loongson64/smp.c:241:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:241:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:241:28: sparse:     got void *
   arch/mips/loongson64/smp.c:243:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:243:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:243:28: sparse:     got void *
   arch/mips/loongson64/smp.c:245:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:245:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:245:28: sparse:     got void *
   arch/mips/loongson64/smp.c:247:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:247:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:247:28: sparse:     got void *
   arch/mips/loongson64/smp.c:249:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:249:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:249:28: sparse:     got void *
   arch/mips/loongson64/smp.c:251:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:251:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:251:28: sparse:     got void *
   arch/mips/loongson64/smp.c:253:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:253:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:253:28: sparse:     got void *
   arch/mips/loongson64/smp.c:255:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:255:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:255:28: sparse:     got void *
   arch/mips/loongson64/smp.c:257:28: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:257:28: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:257:28: sparse:     got void *
   arch/mips/loongson64/smp.c:259:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:259:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:259:29: sparse:     got void *
   arch/mips/loongson64/smp.c:261:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:261:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:261:29: sparse:     got void *
   arch/mips/loongson64/smp.c:263:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:263:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:263:29: sparse:     got void *
   arch/mips/loongson64/smp.c:265:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:265:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:265:29: sparse:     got void *
   arch/mips/loongson64/smp.c:267:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:267:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:267:29: sparse:     got void *
   arch/mips/loongson64/smp.c:269:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:269:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:269:29: sparse:     got void *
   arch/mips/loongson64/smp.c:275:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:275:29: sparse:     expected void [noderef] __iomem *
   arch/mips/loongson64/smp.c:275:29: sparse:     got void *
   arch/mips/loongson64/smp.c:277:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/mips/loongson64/smp.c:277:29: sparse:     expected void [noderef] __iomem *

vim +203 arch/mips/loongson64/smp.c

ffe59ee36aaa83 arch/mips/loongson64/loongson-3/smp.c Huacai Chen 2019-09-21  200  
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  201  static void ipi_set0_regs_init(void)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  202  {
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26 @203  	ipi_set0_regs[0] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  204  		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  205  	ipi_set0_regs[1] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  206  		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  207  	ipi_set0_regs[2] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  208  		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  209  	ipi_set0_regs[3] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  210  		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  211  	ipi_set0_regs[4] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  212  		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  213  	ipi_set0_regs[5] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  214  		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  215  	ipi_set0_regs[6] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  216  		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  217  	ipi_set0_regs[7] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  218  		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  219  	ipi_set0_regs[8] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  220  		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  221  	ipi_set0_regs[9] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  222  		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  223  	ipi_set0_regs[10] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  224  		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  225  	ipi_set0_regs[11] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  226  		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  227  	ipi_set0_regs[12] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  228  		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  229  	ipi_set0_regs[13] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  230  		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  231  	ipi_set0_regs[14] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  232  		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  233  	ipi_set0_regs[15] = (void *)
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  234  		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + SET0);
e7841be50fe2b8 arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-06-26  235  }
300459d558725c arch/mips/loongson/loongson-3/smp.c   Huacai Chen 2014-03-21  236  

:::::: The code at line 203 was first introduced by commit
:::::: e7841be50fe2b8751a51a068b8cdcdcb6611e354 MIPS: Add Loongson-3B support

:::::: TO: Huacai Chen <chenhc@lemote.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
