Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8C6C0278
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCSOrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:47:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32318B3C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679237231; x=1710773231;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S3To/L9hGP4vnvBmUVIHCo+t7DM/+Rf+c6vyW0RzeDU=;
  b=Kj6J61EODC4f8/Ahy5bS7Tl7Z3ZM9z1ipc7r0WensSIhXWSg0fMfbZQx
   rVOLmoDv1LnVMfjbzaoJHgTej0k4AybMpMz0jRUiQrBb878p9DYmBwvkC
   jASB3VPqzwtaTzBbYZYmK5x6Ks9gIui9EoDbLX0CeCwzxq9PYYasursDu
   aLxFg1bEtlDT43CkiGoaba2bDvvXhltHbRhPJap6+czEEzwyBVYNmxmW4
   6mJqKKwTHowYOK8E/eUevK42/DiArzW9E39s5qU41hHzK/ub+G/2gLAAO
   aNtQUXINSm7byo6zqFjRrw3cKzWYDQzowRA5/x6J5eTaxI9EvoirzKSLm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="340052154"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="340052154"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 07:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="680813634"
X-IronPort-AV: E=Sophos;i="5.98,273,1673942400"; 
   d="scan'208";a="680813634"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2023 07:47:09 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pduJQ-000AYQ-1o;
        Sun, 19 Mar 2023 14:47:08 +0000
Date:   Sun, 19 Mar 2023 22:46:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive()
 warn: inconsistent indenting
Message-ID: <202303192200.CcBA7bZy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3671bd86a9770e34969522d29bb30a1b66fd88a
commit: 1d7f6932c522ea95668e14265175ce3d753d0c24 riscv: atomic: Optimize dec_if_positive functions
date:   10 months ago
config: riscv-randconfig-m031-20230319 (https://download.01.org/0day-ci/archive/20230319/202303192200.CcBA7bZy-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303192200.CcBA7bZy-lkp@intel.com/

New smatch warnings:
arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:317 arch_atomic_dec_if_positive() warn: inconsistent indenting

Old smatch warnings:
drivers/block/mtip32xx/mtip32xx.c:2264 mtip_hw_read_device_status() warn: check sign expansion for 'size'
drivers/block/mtip32xx/mtip32xx.c:2328 mtip_hw_read_registers() warn: check sign expansion for 'size'
drivers/block/mtip32xx/mtip32xx.c:3638 mtip_block_initialize() warn: missing error code? 'rv'
drivers/block/mtip32xx/mtip32xx.c:4131 mtip_pci_remove() warn: '&dd->remove_list' not removed from list

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
https://github.com/intel/lkp-tests
