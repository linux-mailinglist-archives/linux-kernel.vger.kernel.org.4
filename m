Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F4B7295B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbjFIJnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbjFIJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:43:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2CD55B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686303467; x=1717839467;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rk7chkn2Ajk2IUmRC+vui8JKJ3e/M+H0BoW4sdyq49Q=;
  b=DI897rqW3XVa6tDwsXMxX+eUxphf7gyykQ2iozk/u+Sni7R2h1ohd0vT
   L3qwSFUv1lHoORHnIImrJHCZ2Huryjun/KRear1W1sMwYcDZvUsGG9vxY
   EzNViF6g5aHj66Bctfj9FzUoelnN9LVHdS8qf7BFiws3iyFnA8C+jOeII
   oucykjcsJ+L9vCh2MKCoGx8DmRmAVCUI35F/ZseYK8kUec15doUXdamv7
   cHVApAQ71xhL9n7ypPzvBjazhoVXwsI8ay2nBeHNUAiseERHXs+iDH+qa
   4CYkKPsxxTMN5I8ldNpJRyjeGYcLiVJFEOlOjTNzkyho8wAPmEViMcUYm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360918493"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="360918493"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 02:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713449337"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713449337"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 02:36:02 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7YXJ-0008to-1m;
        Fri, 09 Jun 2023 09:36:01 +0000
Date:   Fri, 9 Jun 2023 17:35:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/include/asm/hw_irq.h:494 mtmsr_isync_irqsafe() warn:
 inconsistent indenting
Message-ID: <202306091705.0mLF1ntp-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33f2b5785a2b6b0ed1948aafee60d3abb12f1e3a
commit: 0fa6831811f62cfc10415d731bcf9fde2647ad81 powerpc/64: Fix msr_check_and_set/clear MSR[EE] race
date:   8 months ago
config: powerpc-randconfig-m031-20230608 (https://download.01.org/0day-ci/archive/20230609/202306091705.0mLF1ntp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306091705.0mLF1ntp-lkp@intel.com/

New smatch warnings:
arch/powerpc/include/asm/hw_irq.h:494 mtmsr_isync_irqsafe() warn: inconsistent indenting

Old smatch warnings:
arch/powerpc/kernel/process.c:445 giveup_all() warn: bitwise AND condition is false here
arch/powerpc/kernel/process.c:587 save_all() warn: bitwise AND condition is false here

vim +494 arch/powerpc/include/asm/hw_irq.h

   473	
   474	static inline unsigned long mtmsr_isync_irqsafe(unsigned long msr)
   475	{
   476	#ifdef CONFIG_PPC64
   477		if (arch_irqs_disabled()) {
   478			/*
   479			 * With soft-masking, MSR[EE] can change from 1 to 0
   480			 * asynchronously when irqs are disabled, and we don't want to
   481			 * set MSR[EE] back to 1 here if that has happened. A race-free
   482			 * way to do this is ensure EE is already 0. Another way it
   483			 * could be done is with a RESTART_TABLE handler, but that's
   484			 * probably overkill here.
   485			 */
   486			msr &= ~MSR_EE;
   487			mtmsr_isync(msr);
   488			irq_soft_mask_set(IRQS_ALL_DISABLED);
   489			local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
   490		} else
   491	#endif
   492			mtmsr_isync(msr);
   493	
 > 494		return msr;
   495	}
   496	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
