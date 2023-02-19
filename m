Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A456169BEDD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBSHN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 02:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSHN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 02:13:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635BDDBC9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 23:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=28+VCGGBjMHKKEsc9LEVcy5JTHEOm7v1qkru7Lvtm/c=; b=ZH4sNElf+vF35B/FrW1SsMocXk
        MNRmq20Aw9L9yRQlKyQUH9xBy6A/0ka2lPDXlFVTulmV4nQ1F+nhBFVVd4g0MgrqS2a2ezh7haUF8
        Xz6FQbMEQKMxNTF7KV31HgvUcGdaFpgcNtu5dPTCoB5Z8+J9BWF0fumqjZWhUicPkvJOdZzGMfMVR
        xpsox/RGeG/ZNcR+VruCQK1u+vK4cmz9wlhc6gC2sua7GBaOs11obFzXm/rhHXQ1Uh36vo50PiznJ
        fr300LxhWfqOrQ/SSdwXftnWVmd18lJPOgI25tM4Y3WoLZ872lJfMQfkw3RcZ/DQukWROeNxQ29ec
        07knydkg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTdsp-000tYG-QJ; Sun, 19 Feb 2023 07:13:15 +0000
Message-ID: <948cc265-53dd-0a5e-93b6-a0d0fe768198@infradead.org>
Date:   Sat, 18 Feb 2023 23:13:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: arch/powerpc/platforms/83xx/suspend.c:210:3: error: call to
 undeclared function 'enable_kernel_fp'; ISO C99 and later do not support
 implicit function declarations
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202302181414.nAdxC08J-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202302181414.nAdxC08J-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 2/17/23 22:21, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   38f8ccde04a3fa317b51b05e63c3cb57e1641931
> commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
> date:   11 months ago
> config: powerpc-randconfig-r013-20230218 (https://download.01.org/0day-ci/archive/20230218/202302181414.nAdxC08J-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project db89896bbbd2251fff457699635acbbedeead27f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e8c07082a810fbb9db303a2b66b66b8d7e588b53
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/platforms/83xx/ drivers/android/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302181414.nAdxC08J-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/powerpc/platforms/83xx/suspend.c:210:3: error: call to undeclared function 'enable_kernel_fp'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                    enable_kernel_fp();
>                    ^
>    arch/powerpc/platforms/83xx/suspend.c:210:3: note: did you mean 'enable_kernel_vsx'?
>    arch/powerpc/include/asm/switch_to.h:75:20: note: 'enable_kernel_vsx' declared here
>    static inline void enable_kernel_vsx(void)
>                       ^
>    1 error generated.
> 

When # CONFIG_PPC_FPU is not set, enable_kernel_fp() is not defined.
Looks to me like it is caused by:

commit 7d68c8916950
Author: Christophe Leroy <christophe.leroy@csgroup.eu>
Date:   Tue Aug 18 17:19:18 2020 +0000

    powerpc/32s: Allow deselecting CONFIG_PPC_FPU on mpc832x

Adding a stub for enable_kernel_fp() in include/asm/switch_to.h
makes this problem disappear. (There is still a different build error.)

Ideas?

Thanks.


> 
> vim +/enable_kernel_fp +210 arch/powerpc/platforms/83xx/suspend.c
> 
> 87faaabb09d080 Anton Vorontsov 2009-12-10  173  
> d49747bdfb2dde Scott Wood      2007-10-09  174  static int mpc83xx_suspend_enter(suspend_state_t state)
> d49747bdfb2dde Scott Wood      2007-10-09  175  {
> d49747bdfb2dde Scott Wood      2007-10-09  176  	int ret = -EAGAIN;
> d49747bdfb2dde Scott Wood      2007-10-09  177  
> d49747bdfb2dde Scott Wood      2007-10-09  178  	/* Don't go to sleep if there's a race where pci_pm_state changes
> d49747bdfb2dde Scott Wood      2007-10-09  179  	 * between the agent thread checking it and the PM code disabling
> d49747bdfb2dde Scott Wood      2007-10-09  180  	 * interrupts.
> d49747bdfb2dde Scott Wood      2007-10-09  181  	 */
> d49747bdfb2dde Scott Wood      2007-10-09  182  	if (wake_from_pci) {
> d49747bdfb2dde Scott Wood      2007-10-09  183  		if (pci_pm_state != (deep_sleeping ? 3 : 2))
> d49747bdfb2dde Scott Wood      2007-10-09  184  			goto out;
> d49747bdfb2dde Scott Wood      2007-10-09  185  
> d49747bdfb2dde Scott Wood      2007-10-09  186  		out_be32(&pmc_regs->config1,
> d49747bdfb2dde Scott Wood      2007-10-09  187  		         in_be32(&pmc_regs->config1) | PMCCR1_PME_EN);
> d49747bdfb2dde Scott Wood      2007-10-09  188  	}
> d49747bdfb2dde Scott Wood      2007-10-09  189  
> d49747bdfb2dde Scott Wood      2007-10-09  190  	/* Put the system into low-power mode and the RAM
> d49747bdfb2dde Scott Wood      2007-10-09  191  	 * into self-refresh mode once the core goes to
> d49747bdfb2dde Scott Wood      2007-10-09  192  	 * sleep.
> d49747bdfb2dde Scott Wood      2007-10-09  193  	 */
> d49747bdfb2dde Scott Wood      2007-10-09  194  
> d49747bdfb2dde Scott Wood      2007-10-09  195  	out_be32(&pmc_regs->config, PMCCR_SLPEN | PMCCR_DLPEN);
> d49747bdfb2dde Scott Wood      2007-10-09  196  
> d49747bdfb2dde Scott Wood      2007-10-09  197  	/* If it has deep sleep (i.e. it's an 831x or compatible),
> d49747bdfb2dde Scott Wood      2007-10-09  198  	 * disable power to the core upon entering sleep mode.  This will
> d49747bdfb2dde Scott Wood      2007-10-09  199  	 * require going through the boot firmware upon a wakeup event.
> d49747bdfb2dde Scott Wood      2007-10-09  200  	 */
> d49747bdfb2dde Scott Wood      2007-10-09  201  
> d49747bdfb2dde Scott Wood      2007-10-09  202  	if (deep_sleeping) {
> 87faaabb09d080 Anton Vorontsov 2009-12-10  203  		mpc83xx_suspend_save_regs();
> 87faaabb09d080 Anton Vorontsov 2009-12-10  204  
> d49747bdfb2dde Scott Wood      2007-10-09  205  		out_be32(&pmc_regs->mask, PMCER_ALL);
> d49747bdfb2dde Scott Wood      2007-10-09  206  
> d49747bdfb2dde Scott Wood      2007-10-09  207  		out_be32(&pmc_regs->config1,
> d49747bdfb2dde Scott Wood      2007-10-09  208  		         in_be32(&pmc_regs->config1) | PMCCR1_POWER_OFF);
> d49747bdfb2dde Scott Wood      2007-10-09  209  
> d49747bdfb2dde Scott Wood      2007-10-09 @210  		enable_kernel_fp();
> d49747bdfb2dde Scott Wood      2007-10-09  211  
> d49747bdfb2dde Scott Wood      2007-10-09  212  		mpc83xx_enter_deep_sleep(immrbase);
> d49747bdfb2dde Scott Wood      2007-10-09  213  
> d49747bdfb2dde Scott Wood      2007-10-09  214  		out_be32(&pmc_regs->config1,
> d49747bdfb2dde Scott Wood      2007-10-09  215  		         in_be32(&pmc_regs->config1) & ~PMCCR1_POWER_OFF);
> d49747bdfb2dde Scott Wood      2007-10-09  216  
> d49747bdfb2dde Scott Wood      2007-10-09  217  		out_be32(&pmc_regs->mask, PMCER_PMCI);
> 87faaabb09d080 Anton Vorontsov 2009-12-10  218  
> 87faaabb09d080 Anton Vorontsov 2009-12-10  219  		mpc83xx_suspend_restore_regs();
> d49747bdfb2dde Scott Wood      2007-10-09  220  	} else {
> d49747bdfb2dde Scott Wood      2007-10-09  221  		out_be32(&pmc_regs->mask, PMCER_PMCI);
> d49747bdfb2dde Scott Wood      2007-10-09  222  
> d49747bdfb2dde Scott Wood      2007-10-09  223  		mpc6xx_enter_standby();
> d49747bdfb2dde Scott Wood      2007-10-09  224  	}
> d49747bdfb2dde Scott Wood      2007-10-09  225  
> d49747bdfb2dde Scott Wood      2007-10-09  226  	ret = 0;
> d49747bdfb2dde Scott Wood      2007-10-09  227  
> d49747bdfb2dde Scott Wood      2007-10-09  228  out:
> d49747bdfb2dde Scott Wood      2007-10-09  229  	out_be32(&pmc_regs->config1,
> d49747bdfb2dde Scott Wood      2007-10-09  230  	         in_be32(&pmc_regs->config1) & ~PMCCR1_PME_EN);
> d49747bdfb2dde Scott Wood      2007-10-09  231  
> d49747bdfb2dde Scott Wood      2007-10-09  232  	return ret;
> d49747bdfb2dde Scott Wood      2007-10-09  233  }
> d49747bdfb2dde Scott Wood      2007-10-09  234  
> 
> :::::: The code at line 210 was first introduced by commit
> :::::: d49747bdfb2ddebea24d1580da55b79d093d48a9 powerpc/mpc83xx: Power Management support
> 
> :::::: TO: Scott Wood <scottwood@freescale.com>
> :::::: CC: Kumar Gala <galak@kernel.crashing.org>
> 

-- 
~Randy
