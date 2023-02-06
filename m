Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D8568C23C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBFPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBFPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:52:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDF1C7FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675698726; x=1707234726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WZrGjuXfj7Zf0Ou26gpE8uITdkyBqJo0y/5oAA3Q9bw=;
  b=L0xvvsZZ03723VSt4vhtMzJCH4n8cFVZCqsdH8cONChJaaFRKRfmaWc1
   QBFsMUBIjb3/exCZWzJXwJ+6oR0WJuIrJnIigR+LCatAJADTC+Hm32H72
   io7DNflzzge1yteVILlQu9ZoAItIJsc4nzpnrWypx4KxhbEDuAsvk1eXF
   SSVb+OvI6ZfjzQ/dqf0Hm0HUOxQqPs3/YnjNiCwc8qY1p4E8Gt58wnG/S
   3iKfp2ZOgdwc7BvpsLZTF/bCC1Pz/0yMn1RuXgOvFHEREo6mYwGrVmIZQ
   lEpa1+GD0u25X7qkl0R56lHtBgYXJmWdAdPMfRrJlBf38MUafRXm9nhpp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="312890956"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312890956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 07:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="659887416"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659887416"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2023 07:52:03 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pP3mk-0002e4-2U;
        Mon, 06 Feb 2023 15:52:02 +0000
Date:   Mon, 6 Feb 2023 23:52:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly
 requires more registers than available
Message-ID: <202302062324.HhzEZCF7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2d11f342b179f1894a901f143ec7c008caba43e
commit: 07b586fe06625b0b610dc3d3a969c51913d143d4 crypto: x86/curve25519 - replace with formally verified implementation
date:   3 years ago
config: x86_64-buildonly-randconfig-r006-20230206 (https://download.01.org/0day-ci/archive/20230206/202302062324.HhzEZCF7-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07b586fe06625b0b610dc3d3a969c51913d143d4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 07b586fe06625b0b610dc3d3a969c51913d143d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/crypto/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/crypto/curve25519-x86_64.c:954:6: warning: variable 'carry' set but not used [-Wunused-but-set-variable]
           u64 carry;
               ^
   arch/x86/crypto/curve25519-x86_64.c:951:6: warning: variable 'carry0' set but not used [-Wunused-but-set-variable]
           u64 carry0;
               ^
>> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
                   "  movq 0(%1), %%rdx;"                                       /* f[0] */
                   ^
>> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
   2 warnings and 2 errors generated.


vim +609 arch/x86/crypto/curve25519-x86_64.c

   600	
   601	/* Computes two field squarings:
   602	 * out[0] <- f[0] * f[0]
   603	 * out[1] <- f[1] * f[1]
   604	 * Uses the 16-element buffer tmp for intermediate results */
   605	static inline void fsqr2(u64 *out, const u64 *f, u64 *tmp)
   606	{
   607		asm volatile(
   608			/* Step 1: Compute all partial products */
 > 609			"  movq 0(%1), %%rdx;"                                       /* f[0] */
   610			"  mulxq 8(%1), %%r8, %%r14;"      "  xor %%r15, %%r15;"     /* f[1]*f[0] */
   611			"  mulxq 16(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
   612			"  mulxq 24(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
   613			"  movq 24(%1), %%rdx;"                                      /* f[3] */
   614			"  mulxq 8(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
   615			"  mulxq 16(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
   616			"  movq 8(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
   617			"  mulxq 16(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
   618	
   619			/* Step 2: Compute two parallel carry chains */
   620			"  xor %%r15, %%r15;"
   621			"  adox %%rax, %%r10;"
   622			"  adcx %%r8, %%r8;"
   623			"  adox %%rcx, %%r11;"
   624			"  adcx %%r9, %%r9;"
   625			"  adox %%r15, %%r12;"
   626			"  adcx %%r10, %%r10;"
   627			"  adox %%r15, %%r13;"
   628			"  adcx %%r11, %%r11;"
   629			"  adox %%r15, %%r14;"
   630			"  adcx %%r12, %%r12;"
   631			"  adcx %%r13, %%r13;"
   632			"  adcx %%r14, %%r14;"
   633	
   634			/* Step 3: Compute intermediate squares */
   635			"  movq 0(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[0]^2 */
   636			                           "  movq %%rax, 0(%0);"
   637			"  add %%rcx, %%r8;"       "  movq %%r8, 8(%0);"
   638			"  movq 8(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[1]^2 */
   639			"  adcx %%rax, %%r9;"      "  movq %%r9, 16(%0);"
   640			"  adcx %%rcx, %%r10;"     "  movq %%r10, 24(%0);"
   641			"  movq 16(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
   642			"  adcx %%rax, %%r11;"     "  movq %%r11, 32(%0);"
   643			"  adcx %%rcx, %%r12;"     "  movq %%r12, 40(%0);"
   644			"  movq 24(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
   645			"  adcx %%rax, %%r13;"     "  movq %%r13, 48(%0);"
   646			"  adcx %%rcx, %%r14;"     "  movq %%r14, 56(%0);"
   647	
   648			/* Step 1: Compute all partial products */
   649			"  movq 32(%1), %%rdx;"                                       /* f[0] */
   650			"  mulxq 40(%1), %%r8, %%r14;"      "  xor %%r15, %%r15;"     /* f[1]*f[0] */
   651			"  mulxq 48(%1), %%r9, %%r10;"     "  adcx %%r14, %%r9;"     /* f[2]*f[0] */
   652			"  mulxq 56(%1), %%rax, %%rcx;"    "  adcx %%rax, %%r10;"    /* f[3]*f[0] */
   653			"  movq 56(%1), %%rdx;"                                      /* f[3] */
   654			"  mulxq 40(%1), %%r11, %%r12;"     "  adcx %%rcx, %%r11;"    /* f[1]*f[3] */
   655			"  mulxq 48(%1), %%rax, %%r13;"    "  adcx %%rax, %%r12;"    /* f[2]*f[3] */
   656			"  movq 40(%1), %%rdx;"             "  adcx %%r15, %%r13;"    /* f1 */
   657			"  mulxq 48(%1), %%rax, %%rcx;"    "  mov $0, %%r14;"        /* f[2]*f[1] */
   658	
   659			/* Step 2: Compute two parallel carry chains */
   660			"  xor %%r15, %%r15;"
   661			"  adox %%rax, %%r10;"
   662			"  adcx %%r8, %%r8;"
   663			"  adox %%rcx, %%r11;"
   664			"  adcx %%r9, %%r9;"
   665			"  adox %%r15, %%r12;"
   666			"  adcx %%r10, %%r10;"
   667			"  adox %%r15, %%r13;"
   668			"  adcx %%r11, %%r11;"
   669			"  adox %%r15, %%r14;"
   670			"  adcx %%r12, %%r12;"
   671			"  adcx %%r13, %%r13;"
   672			"  adcx %%r14, %%r14;"
   673	
   674			/* Step 3: Compute intermediate squares */
   675			"  movq 32(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[0]^2 */
   676			                           "  movq %%rax, 64(%0);"
   677			"  add %%rcx, %%r8;"       "  movq %%r8, 72(%0);"
   678			"  movq 40(%1), %%rdx;"     "  mulx %%rdx, %%rax, %%rcx;"    /* f[1]^2 */
   679			"  adcx %%rax, %%r9;"      "  movq %%r9, 80(%0);"
   680			"  adcx %%rcx, %%r10;"     "  movq %%r10, 88(%0);"
   681			"  movq 48(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[2]^2 */
   682			"  adcx %%rax, %%r11;"     "  movq %%r11, 96(%0);"
   683			"  adcx %%rcx, %%r12;"     "  movq %%r12, 104(%0);"
   684			"  movq 56(%1), %%rdx;"    "  mulx %%rdx, %%rax, %%rcx;"    /* f[3]^2 */
   685			"  adcx %%rax, %%r13;"     "  movq %%r13, 112(%0);"
   686			"  adcx %%rcx, %%r14;"     "  movq %%r14, 120(%0);"
   687	
   688			/* Line up pointers */
   689			"  mov %0, %1;"
   690			"  mov %2, %0;"
   691	
   692			/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
   693			"  mov $38, %%rdx;"
   694			"  mulxq 32(%1), %%r8, %%r13;"
   695			"  xor %%rcx, %%rcx;"
   696			"  adoxq 0(%1), %%r8;"
   697			"  mulxq 40(%1), %%r9, %%r12;"
   698			"  adcx %%r13, %%r9;"
   699			"  adoxq 8(%1), %%r9;"
   700			"  mulxq 48(%1), %%r10, %%r13;"
   701			"  adcx %%r12, %%r10;"
   702			"  adoxq 16(%1), %%r10;"
   703			"  mulxq 56(%1), %%r11, %%rax;"
   704			"  adcx %%r13, %%r11;"
   705			"  adoxq 24(%1), %%r11;"
   706			"  adcx %%rcx, %%rax;"
   707			"  adox %%rcx, %%rax;"
   708			"  imul %%rdx, %%rax;"
   709	
   710			/* Step 2: Fold the carry back into dst */
   711			"  add %%rax, %%r8;"
   712			"  adcx %%rcx, %%r9;"
   713			"  movq %%r9, 8(%0);"
   714			"  adcx %%rcx, %%r10;"
   715			"  movq %%r10, 16(%0);"
   716			"  adcx %%rcx, %%r11;"
   717			"  movq %%r11, 24(%0);"
   718	
   719			/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
   720			"  mov $0, %%rax;"
   721			"  cmovc %%rdx, %%rax;"
   722			"  add %%rax, %%r8;"
   723			"  movq %%r8, 0(%0);"
   724	
   725			/* Step 1: Compute dst + carry == tmp_hi * 38 + tmp_lo */
   726			"  mov $38, %%rdx;"
   727			"  mulxq 96(%1), %%r8, %%r13;"
   728			"  xor %%rcx, %%rcx;"
   729			"  adoxq 64(%1), %%r8;"
   730			"  mulxq 104(%1), %%r9, %%r12;"
   731			"  adcx %%r13, %%r9;"
   732			"  adoxq 72(%1), %%r9;"
   733			"  mulxq 112(%1), %%r10, %%r13;"
   734			"  adcx %%r12, %%r10;"
   735			"  adoxq 80(%1), %%r10;"
   736			"  mulxq 120(%1), %%r11, %%rax;"
   737			"  adcx %%r13, %%r11;"
   738			"  adoxq 88(%1), %%r11;"
   739			"  adcx %%rcx, %%rax;"
   740			"  adox %%rcx, %%rax;"
   741			"  imul %%rdx, %%rax;"
   742	
   743			/* Step 2: Fold the carry back into dst */
   744			"  add %%rax, %%r8;"
   745			"  adcx %%rcx, %%r9;"
   746			"  movq %%r9, 40(%0);"
   747			"  adcx %%rcx, %%r10;"
   748			"  movq %%r10, 48(%0);"
   749			"  adcx %%rcx, %%r11;"
   750			"  movq %%r11, 56(%0);"
   751	
   752			/* Step 3: Fold the carry bit back in; guaranteed not to carry at this point */
   753			"  mov $0, %%rax;"
   754			"  cmovc %%rdx, %%rax;"
   755			"  add %%rax, %%r8;"
   756			"  movq %%r8, 32(%0);"
   757		: "+&r" (tmp), "+&r" (f), "+&r" (out)
   758		:
   759		: "%rax", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "memory", "cc"
   760		);
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
