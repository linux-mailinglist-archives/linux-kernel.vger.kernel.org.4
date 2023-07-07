Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D648D74A912
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGGCjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGGCjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:39:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A48119A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688697591; x=1720233591;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aa2MfFzHhcTpt4mRWlpBUWIS3n5T2fJqMcy5OQIcSWA=;
  b=J/crTWOlh4WeBjg+QiWt5iO76MYqHILB8RS63CafnLzWBadKZKOT9Fdv
   RiashS1M7KfLlLHtbFTpQKeDf0MPnmsx1D9HF844qEKWz6mu1l1Rvab6x
   02ZAVnErQyEUNJ9vx4+XuStAWGtKfn4387A5rZ74Dz3JYWKUD4rnm5GTr
   QyWGeNQUzFd9rwbjdQJsWZZdZLnkwv5s0rOf4FtghOMIDeCsfJIrZxBO5
   Wf9fo0iZeNK9RPYuCU7xdJAT66cwTeAPZOUqcc4lU+gj+yW81kMB6fHlQ
   l/5ff0Xne3AInNrs8JUeXoaNz3NuZN5tsPTqRBHS5cIshlY3RkTFSvLkz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="343369819"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="343369819"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 19:39:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="669997760"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="669997760"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2023 19:39:49 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHbNs-0001hk-1r;
        Fri, 07 Jul 2023 02:39:48 +0000
Date:   Fri, 7 Jul 2023 10:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: s390-linux-ld: arc-rimi.c:undefined reference to `iounmap'
Message-ID: <202307071010.VMWGjQjh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a452483508d7b70b0f6c69e249ec0b3ea2330b5c
commit: 6ef55060a1cc29dd54ff390f22cb3de266dab2b0 s390: make use of CONFIG_FUNCTION_ALIGNMENT
date:   4 months ago
config: s390-randconfig-r003-20230707 (https://download.01.org/0day-ci/archive/20230707/202307071010.VMWGjQjh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307071010.VMWGjQjh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307071010.VMWGjQjh-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `_dma_release_coherent_memory.part.0':
   coherent.c:(.text+0xa8): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x12a): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x1ac): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x8a): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0xee): undefined reference to `iounmap'
   s390-linux-ld: drivers/misc/open-dice.o: in function `open_dice_write':
   open-dice.c:(.text+0x19a): undefined reference to `devm_memremap'
   s390-linux-ld: open-dice.c:(.text+0x20e): undefined reference to `devm_memunmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_exit':
   com90xx.c:(.exit.text+0xa6): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `check_mirror':
   com90xx.c:(.init.text+0xb0): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x114): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_found':
   com90xx.c:(.init.text+0x344): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x480): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x77c): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0x8ec): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/com90xx.o: in function `com90xx_probe':
   com90xx.c:(.init.text+0xec4): undefined reference to `ioremap'
   s390-linux-ld: com90xx.c:(.init.text+0xf76): undefined reference to `iounmap'
   s390-linux-ld: com90xx.c:(.init.text+0x1482): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text+0x2f4): undefined reference to `ioremap'
>> s390-linux-ld: arc-rimi.c:(.text+0x324): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x4e): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
   arc-rimi.c:(.init.text+0x1f4): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x2f8): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x576): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x720): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x938): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x73a): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x81a): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x866): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x890): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0x16d8): undefined reference to `iounmap'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
