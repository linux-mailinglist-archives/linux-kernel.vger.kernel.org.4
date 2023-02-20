Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410869C629
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBTHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBTHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:55:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46FCDD1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676879710; x=1708415710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pum8+FH6zNVxtjT/aEItCZ+usznIQjUIey7BWxX4r2Y=;
  b=RrpBltz34yyMoJ9l5BB+/1RWZitB73FNfZeAxx+OVfSBXmh+VfoGtYqg
   qowyq8uKo4OCPu0rUE4q2FrTtv9EzRkhWi/dVWXV/ahPGpoD59cNko+yu
   M24rmgn8aTavo8tHLFTpjCDOlZ8O53lxkrU6sRnMUNhC2WSTZpXtuswK8
   AkLhWLQIZ1TIBRNbocSCLTqS+bDWhS9OKO9I8MB0OaRlfHu+aLcelgVGx
   bEk3Gto6Ec2/SOhdk1HuQ+y3am7Ko/rS13uqTekSRo6alDOO0iwF7vRkB
   pCEvz95Qt5XQzL5kkjcJEXyGtTzyIylQQ1x7+RcvUG6gCYY27SBH1uzPI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="359807781"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="359807781"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 23:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="664546421"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="664546421"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Feb 2023 23:55:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU10s-000Dld-2U;
        Mon, 20 Feb 2023 07:55:06 +0000
Date:   Mon, 20 Feb 2023 15:54:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: Re: [PATCH v2 3/4] tee: expose tee efivar register function
Message-ID: <202302201500.rOtaNOWt-lkp@intel.com>
References: <20230220051723.1257-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220051723.1257-4-masahisa.kojima@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahisa,

I love your patch! Yet something to improve:

[auto build test ERROR on efi/next]
[also build test ERROR on next-20230217]
[cannot apply to linus/master v6.2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahisa-Kojima/efi-expose-efivar-generic-ops-register-function/20230220-132235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/20230220051723.1257-4-masahisa.kojima%40linaro.org
patch subject: [PATCH v2 3/4] tee: expose tee efivar register function
config: nios2-randconfig-r036-20230220 (https://download.01.org/0day-ci/archive/20230220/202302201500.rOtaNOWt-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c9bb47729e4c5c9999ce523e6c72785e897d9ae6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahisa-Kojima/efi-expose-efivar-generic-ops-register-function/20230220-132235
        git checkout c9bb47729e4c5c9999ce523e6c72785e897d9ae6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201500.rOtaNOWt-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/tee/tee_core.o: in function `tee_register_efivar_ops':
>> tee_core.c:(.text+0x2634): undefined reference to `efivar_supports_writes'
   tee_core.c:(.text+0x2634): relocation truncated to fit: R_NIOS2_CALL26 against `efivar_supports_writes'
>> nios2-linux-ld: tee_core.c:(.text+0x2654): undefined reference to `efivars_generic_ops_unregister'
   tee_core.c:(.text+0x2654): relocation truncated to fit: R_NIOS2_CALL26 against `efivars_generic_ops_unregister'
>> nios2-linux-ld: tee_core.c:(.text+0x2674): undefined reference to `efivars_register'
   tee_core.c:(.text+0x2674): relocation truncated to fit: R_NIOS2_CALL26 against `efivars_register'
   nios2-linux-ld: drivers/tee/tee_core.o: in function `tee_unregister_efivar_ops':
>> tee_core.c:(.text+0x2684): undefined reference to `efivars_unregister'
   tee_core.c:(.text+0x2684): relocation truncated to fit: R_NIOS2_CALL26 against `efivars_unregister'
>> nios2-linux-ld: tee_core.c:(.text+0x2688): undefined reference to `efivars_generic_ops_register'
   tee_core.c:(.text+0x2688): relocation truncated to fit: R_NIOS2_CALL26 against `efivars_generic_ops_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
