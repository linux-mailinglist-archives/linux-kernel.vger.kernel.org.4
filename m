Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8CE6DBC01
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDHPvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjDHPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:51:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40AE11657
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 08:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EB4260A76
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 15:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB87C433D2;
        Sat,  8 Apr 2023 15:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680969040;
        bh=Y7aLsdu9wZV8LzZW/CITM6rQS9K9lgkKwj5eYz4H5w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f+cEIvG4AOjoZSAndl42B/X0PojYAsoJ4h3OLkr6fdIgkYjZyMKzAOoFYYpNFUSfg
         XGyX7mR9VHaIkIZgv6Tb5yf6GXY/vO6Mu+fefd7MgcvfI/wEPx3iH4aNjI6t0vO4it
         vjPLkXs/XUFIhuS4x35FHcn8fR6evQnPZzHf6x9yfsmwjouJ3J1R4FIEU4nBF6XpA0
         fKGT7y3BEAKL9LuAZLW8Kgoaxk1Rnb2A7i3ljcsxAwN2syYO8PdoDOUeAIqutjJOoe
         zKlo9NGlE3Uf8MXYhE+rR4ViN8oBGklitBKL5++uInRxmZfoeV9b0BSyq2E57/i1E2
         riQP9xxOOUPmA==
Received: by pali.im (Postfix)
        id 7255D7B7; Sat,  8 Apr 2023 17:50:37 +0200 (CEST)
Date:   Sat, 8 Apr 2023 17:50:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] powerpc/fsl_uli1575: Misc cleanup
Message-ID: <20230408155037.hxcxanfetm7mzcik@pali>
References: <20230408132151.8902-2-pali@kernel.org>
 <202304082352.xhNWS4WV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202304082352.xhNWS4WV-lkp@intel.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 April 2023 23:24:07 kernel test robot wrote:
> Hi Pali,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on powerpc/fixes linus/master v6.3-rc5 next-20230406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-212610
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> patch link:    https://lore.kernel.org/r/20230408132151.8902-2-pali%40kernel.org
> patch subject: [PATCH 1/8] powerpc/fsl_uli1575: Misc cleanup
> config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230408/202304082352.xhNWS4WV-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/4d3f86e2ae53d180d2cbbe556355ff5b03d4251b
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Pali-Roh-r/powerpc-fsl_uli1575-Misc-cleanup/20230408-212610
>         git checkout 4d3f86e2ae53d180d2cbbe556355ff5b03d4251b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304082352.xhNWS4WV-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/kernel/sys_ppc32.c:56:
>    arch/powerpc/include/asm/ppc-pci.h:71:45: error: 'struct pci_controller' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>       71 | static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
>          |                                             ^~~~~~~~~~~~~~
>    arch/powerpc/include/asm/ppc-pci.h: In function 'uli_exclude_device':
> >> arch/powerpc/include/asm/ppc-pci.h:71:102: error: 'PCIBIOS_SUCCESSFUL' undeclared (first use in this function)
>       71 | static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
>          |                                                                                                      ^~~~~~~~~~~~~~~~~~
>    arch/powerpc/include/asm/ppc-pci.h:71:102: note: each undeclared identifier is reported only once for each function it appears in
>    cc1: all warnings being treated as errors
> 
> 
> vim +/PCIBIOS_SUCCESSFUL +71 arch/powerpc/include/asm/ppc-pci.h
> 
>     69	
>     70	#if !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575)
>   > 71	static inline int uli_exclude_device(struct pci_controller *hose, u_char bus, u_char devfn) { return PCIBIOS_SUCCESSFUL; }
>     72	#endif /* !defined(CONFIG_PCI) || !defined(CONFIG_FSL_ULI1575) */
>     73	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

Fixed in V2:
https://lore.kernel.org/linuxppc-dev/20230408154814.10400-1-pali@kernel.org/T/#t
