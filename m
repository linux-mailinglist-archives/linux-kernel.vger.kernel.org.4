Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B940676AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAVCqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 21:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVCqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 21:46:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61021DBB6
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 18:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674355564; x=1705891564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7JxessS1C5MOQ+njwK7vKSrJWGrwNujGmHN306VwfRI=;
  b=h6i+xdOMn+hW/Ru4PFn34cnB/3TQX0BWWOHmbUsCGjIMcXD0cqw6tuzL
   B4kmy6MzSxwb67PSG/Qoh/s85Wh6s8EO9ZdoHH/LWyS3WX5SrUlPCVK8e
   7UrVUSjj5he22tKUIzHJuZHOH71e07n7bN3cu0rx6fQJRfzozKkknAVEg
   s6CM6eqRcE+OILdWOBYhPDhsz7wUhFELlZw6l0C+icbrZv+32iBHq4mGg
   n9jl0mo4jQ8vaBW5FQ4gQMV2i3lTkbvueOeTjphWqQr1L7ZWzsTeTpYhT
   Ry1r2kBOfafAaQGi/1WBWyjbbVK1H+PoN0ZZA562GS7GfX4l/R2YXg+2l
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="323551887"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="323551887"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 18:46:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10597"; a="610903178"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="610903178"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2023 18:46:02 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJQMr-0004h2-2z;
        Sun, 22 Jan 2023 02:46:01 +0000
Date:   Sun, 22 Jan 2023 10:45:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/include/asm/hw_irq.h:494 mtmsr_isync_irqsafe() warn:
 inconsistent indenting
Message-ID: <202301221036.HWXK8O00-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2241ab53cbb5cdb08a6b2d4688feb13971058f65
commit: 0fa6831811f62cfc10415d731bcf9fde2647ad81 powerpc/64: Fix msr_check_and_set/clear MSR[EE] race
date:   4 months ago
config: powerpc-randconfig-m031-20230121 (https://download.01.org/0day-ci/archive/20230122/202301221036.HWXK8O00-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
arch/powerpc/include/asm/hw_irq.h:494 mtmsr_isync_irqsafe() warn: inconsistent indenting

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
https://github.com/intel/lkp-tests
