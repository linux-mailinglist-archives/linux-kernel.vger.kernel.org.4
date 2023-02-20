Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885869C62A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjBTHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBTHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:55:13 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51658CC3E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676879710; x=1708415710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=32t0/bxl4iiiasv7QIsw5inkvsafBn9AwV4nvETbeSw=;
  b=TwHYTtddZsz1Q842VYV/GGiMnvo4NOWVPwkfo06bZ5FkSSVwxq6opNSa
   6oVhdEJzj19Jqo/bKIwi4Qkq17fNP1pzoFggP/7PXGge99ZL8UlCzmoHd
   3kCUaaaXNjbr03KBZBgogtG+t5U5H3jesqg2FFFVI1UrpRSjK2kZ4XG1F
   sxax9nr7Q9aH6V1xeJa/KiTxXzJv2M/5Dm2VZ2otSKYBT3/4mB5tX0bMq
   /3Q2mCDkXa4L7tt1gLGJRUb2VP9Kke804m0YBVPBnL6cGES2h9YirSdnz
   ltAmmGz92p/tJ3HFpsg8j08OhCF3ZPypgpDbATm7kI6w/NVHaus5u9H4r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="330059136"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="330059136"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 23:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="814045927"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="814045927"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2023 23:55:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pU10s-000Dlf-2e;
        Mon, 20 Feb 2023 07:55:06 +0000
Date:   Mon, 20 Feb 2023 15:54:33 +0800
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
Message-ID: <202302201500.w7nKUwV7-lkp@intel.com>
References: <20230220051723.1257-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220051723.1257-4-masahisa.kojima@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
config: arm64-randconfig-r034-20230220 (https://download.01.org/0day-ci/archive/20230220/202302201500.w7nKUwV7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c9bb47729e4c5c9999ce523e6c72785e897d9ae6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahisa-Kojima/efi-expose-efivar-generic-ops-register-function/20230220-132235
        git checkout c9bb47729e4c5c9999ce523e6c72785e897d9ae6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302201500.w7nKUwV7-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "efivar_supports_writes" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "efivars_register" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "efivars_generic_ops_register" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "efivars_unregister" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "efivars_generic_ops_unregister" [drivers/tee/tee.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
