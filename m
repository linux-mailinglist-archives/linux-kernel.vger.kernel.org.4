Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15FB7138DE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjE1J1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE1J1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 05:27:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC236B9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685266023; x=1716802023;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6mhlJqjhqlP4LY6Pvn9jWj1zGbcelYAc4Ee/JyCTqVY=;
  b=A+jeOJ3Syf/FGve729YgVwUUFV1Wubn0aVoHR3oVcQffklKRWPtIwMNV
   j+P2KyapUobD1swAzqYEypDV5aunLYEOw1dR0nXPdVYcm3fu0DcCc2Hae
   hS6SfXHM3PNbOFqtHLabVhHlxt4dmQC5UyyU+jTsfUIyOIiJjtvxty5uj
   7zHxe7JeVpePHnUVenNYotydfnY3x77PpRmj9393TH8RIjw8sEM0KTCUL
   R6XEj3u2AVADSu5D6Hz+E7qnUSHn3t175w6b94x+YBzUuKhuxQWD1oPd4
   /VxxzZ9rrGR1HnCubcGKwzn4+pPNituGD4kl4kxdxSLegwyogtsLioqhz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="353341386"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="353341386"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 02:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10723"; a="656142962"
X-IronPort-AV: E=Sophos;i="6.00,198,1681196400"; 
   d="scan'208";a="656142962"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 May 2023 02:27:01 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3Cg0-000KWA-10;
        Sun, 28 May 2023 09:27:00 +0000
Date:   Sun, 28 May 2023 17:26:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: arch/riscv/include/asm/syscall.h:87 syscall_handler() warn:
 inconsistent indenting
Message-ID: <202305281715.WnNJQvvE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   416839029e3858f61dc7dd346559c03e74ed8380
commit: f0bddf50586da81360627a772be0e355b62f071e riscv: entry: Convert to generic entry
date:   9 weeks ago
config: riscv-randconfig-m031-20230528 (https://download.01.org/0day-ci/archive/20230528/202305281715.WnNJQvvE-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305281715.WnNJQvvE-lkp@intel.com/

smatch warnings:
arch/riscv/include/asm/syscall.h:87 syscall_handler() warn: inconsistent indenting

vim +87 arch/riscv/include/asm/syscall.h

    76	
    77	typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulong);
    78	static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
    79	{
    80		syscall_t fn;
    81	
    82	#ifdef CONFIG_COMPAT
    83		if ((regs->status & SR_UXL) == SR_UXL_32)
    84			fn = compat_sys_call_table[syscall];
    85		else
    86	#endif
  > 87			fn = sys_call_table[syscall];
    88	
    89		regs->a0 = fn(regs->orig_a0, regs->a1, regs->a2,
    90			      regs->a3, regs->a4, regs->a5, regs->a6);
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
