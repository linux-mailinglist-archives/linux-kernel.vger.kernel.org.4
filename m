Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F096DB932
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDHGXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 02:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDHGXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 02:23:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F9B455;
        Fri,  7 Apr 2023 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680935017; x=1712471017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffIcKF6JLzI/Q34ihMZs5pPTke+VOLtLE4gbl3XwRis=;
  b=M0MnsuOruNjzvu3pvMnSWZkNLlOmbH+Ss62pWJhvWINp19YmJ/VyacV8
   Ez/cyGm+QGYqkN1QYSC9+2LN9iv2YcevDwz82uHPyrz7AngKrpvwiUoY3
   lcjM81by8CLHRVXmIYOFZxN5p4L/biAiROmoUnXdQ46rm6pwHxGHF5Znw
   S/S7crnROkNnGlk9h3k4Ak1M2Vf9HBMjc0aqi0l9l3bYaz6uaGpH/Urrb
   QlI6hQsVboHJsoWTcFTkgOTXgDQUvkxOFD7dVc2zS4wEWUQb/f4b7rZau
   TLJxWIS9Pff+qz7oLz/kUui/abkGVVmhvHsR+8JjesB9AiT/Ut8d5JqbD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="405942102"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="405942102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 23:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831384611"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="831384611"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2023 23:23:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pl1z4-000TPp-0w;
        Sat, 08 Apr 2023 06:23:34 +0000
Date:   Sat, 8 Apr 2023 14:23:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepanshu Kartikey <kartikey406@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Deepanshu Kartikey <kartikey406@gmail.com>
Subject: Re: [PATCH] Staging: fbtft: fbtft-bus: fixed extra space and
 parenthesis issue
Message-ID: <202304081417.MgYKE9jj-lkp@intel.com>
References: <20230408050323.70919-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408050323.70919-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepanshu,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepanshu-Kartikey/Staging-fbtft-fbtft-bus-fixed-extra-space-and-parenthesis-issue/20230408-130429
patch link:    https://lore.kernel.org/r/20230408050323.70919-1-kartikey406%40gmail.com
patch subject: [PATCH] Staging: fbtft: fbtft-bus: fixed extra space and parenthesis issue
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230408/202304081417.MgYKE9jj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a5c79ed6665465f3101e8251ca030a600cf1ea88
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Deepanshu-Kartikey/Staging-fbtft-fbtft-bus-fixed-extra-space-and-parenthesis-issue/20230408-130429
        git checkout a5c79ed6665465f3101e8251ca030a600cf1ea88
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304081417.MgYKE9jj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/fbtft/fbtft-bus.c:65:53: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                                                     ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
>> drivers/staging/fbtft/fbtft-bus.c:65:23: error: expected ';' before 'void'
      65 | define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
         |                       ^
         |                       ;
   drivers/staging/fbtft/fbtft-bus.c:67:57: error: macro "define_fbtft_write_reg" requires 4 arguments, but only 3 given
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                                                         ^
   drivers/staging/fbtft/fbtft-bus.c:14: note: macro "define_fbtft_write_reg" defined here
      14 | #define define_fbtft_write_reg(func, buffer_type, data_type, modifier)        \
         | 
   drivers/staging/fbtft/fbtft-bus.c:67:23: error: expected ';' before 'void'
      67 | define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
         |                       ^
         |                       ;
      68 | 
      69 | void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
         | ~~~~                   


vim +/define_fbtft_write_reg +65 drivers/staging/fbtft/fbtft-bus.c

    64	
  > 65	define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
    66	define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
    67	define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
