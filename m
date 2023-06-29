Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90111742713
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjF2NP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjF2NP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:15:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C028C213D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688044554; x=1719580554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CmFAGKdbvZV2LRKqPH8f4taWvGmmPRCv0r8vdINfC7Y=;
  b=WZz8NpCriWiU8pLJob8s1/Z/5xnjg/EyfiuGqJJkMZYpTs0Ah2ZNfFAd
   cJvFSfvKcnizhwhn8K9WuLh3pFzVNnqpqCvleXb6ak58g2XKar5wqMPFo
   NyfGrb2wnjKkTDbwq4IR3DLklBaKFU2M1Z9We22y9Tp7B0xIzcQ034bJ1
   OvmJZ7BJUQyfajBIjkDK3xs1Xd3+9xFaxCUZVbrFUVSk6DPcIpxFj5Z94
   uP6LqrGKlNkmknkbO5fGPWfENmCf/qlZy/Qr2bEKfj/dEDPlQLymPPAur
   uXGZD1any3R1ZVfzzz/5yDdbGsFc1/IrUrgxpgTkn+4OAql2hg4AE+SiJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="351905933"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="351905933"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841436602"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="841436602"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2023 06:07:27 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qErMs-000EAL-1o;
        Thu, 29 Jun 2023 13:07:26 +0000
Date:   Thu, 29 Jun 2023 21:06:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive()
 warn: inconsistent indenting
Message-ID: <202306292044.M7rvGInB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a8a670eeeaa40d87bd38a587438952741980c18
commit: 1d7f6932c522ea95668e14265175ce3d753d0c24 riscv: atomic: Optimize dec_if_positive functions
date:   1 year, 1 month ago
config: riscv-randconfig-m031-20230629 (https://download.01.org/0day-ci/archive/20230629/202306292044.M7rvGInB-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230629/202306292044.M7rvGInB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306292044.M7rvGInB-lkp@intel.com/

smatch warnings:
arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive() warn: inconsistent indenting

vim +317 arch/riscv/include/asm/atomic.h

fab957c11efe2f Palmer Dabbelt 2017-07-10  312  
1d7f6932c522ea Guo Ren        2022-05-05  313  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
fab957c11efe2f Palmer Dabbelt 2017-07-10  314  {
fab957c11efe2f Palmer Dabbelt 2017-07-10  315         int prev, rc;
fab957c11efe2f Palmer Dabbelt 2017-07-10  316  
fab957c11efe2f Palmer Dabbelt 2017-07-10 @317  	__asm__ __volatile__ (
5ce6c1f3535fa8 Andrea Parri   2018-03-09  318  		"0:	lr.w     %[p],  %[c]\n"
1d7f6932c522ea Guo Ren        2022-05-05  319  		"	addi     %[rc], %[p], -1\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  320  		"	bltz     %[rc], 1f\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  321  		"	sc.w.rl  %[rc], %[rc], %[c]\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  322  		"	bnez     %[rc], 0b\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  323  		"	fence    rw, rw\n"
5ce6c1f3535fa8 Andrea Parri   2018-03-09  324  		"1:\n"
fab957c11efe2f Palmer Dabbelt 2017-07-10  325  		: [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
1d7f6932c522ea Guo Ren        2022-05-05  326  		:
fab957c11efe2f Palmer Dabbelt 2017-07-10  327  		: "memory");
1d7f6932c522ea Guo Ren        2022-05-05  328  	return prev - 1;
fab957c11efe2f Palmer Dabbelt 2017-07-10  329  }
fab957c11efe2f Palmer Dabbelt 2017-07-10  330  

:::::: The code at line 317 was first introduced by commit
:::::: fab957c11efe2f405e08b9f0d080524bc2631428 RISC-V: Atomic and Locking Code

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
