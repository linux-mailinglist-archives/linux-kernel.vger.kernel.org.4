Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB33F5B57A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiILJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiILJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:56:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C6180;
        Mon, 12 Sep 2022 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662976618; x=1694512618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkShfX+2NBduVhHbSZwihqpM/Kt1nti7IOAfsl2/4IA=;
  b=RStD21JQEEjsAmPpU7S500XSa3SjDRb/FfVS6LgHaJ2Nk0Bv0FdNflHu
   t3HaGZ4QT6Xe3/6NhQVcN/dmBOGejX+j/hQ9h6y0t2mlisvh+iEXW8u2F
   f0EEDUODGdoKLCWmBRHSTJImkPtZcv2Dowc8TnQL73V7ICJTs9il7dSuO
   qDJOClth5OpYfLu1snJruaf20i+BMcjNa3mgpBC+iJJn0NspSv+Ss244T
   y0C3b4slfRAhyUAUOzVAGVZjR2RIsxkLkepnU/FuZIJXPYrKZDqt9b/Hb
   EScu181OSaCZ2yTug0YIlu3q1jsLBarH/kL+LrGYlUNYVyRvpnZ0tKNan
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="278218266"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="278218266"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 02:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="567105183"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 02:56:40 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXgBD-0002Nm-2I;
        Mon, 12 Sep 2022 09:56:39 +0000
Date:   Mon, 12 Sep 2022 17:56:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kbuild: move -Wundef from KBUILD_CFLAGS to
 KBUILD_CPPFLAGS
Message-ID: <202209121730.ipnGRE83-lkp@intel.com>
References: <20220905083619.672091-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905083619.672091-2-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on linus/master v6.0-rc5]
[cannot apply to next-20220909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-move-Werror-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: s390-randconfig-s052-20220911 (https://download.01.org/0day-ci/archive/20220912/202209121730.ipnGRE83-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/2f8ee1865d7d00ad27460d94056c7752cad8481f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-move-Werror-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220905-164209
        git checkout 2f8ee1865d7d00ad27460d94056c7752cad8481f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/s390/boot/decompressor.c:28:7: sparse: sparse: undefined preprocessor identifier 'CONFIG_KERNEL_ZSTD'

vim +/CONFIG_KERNEL_ZSTD +28 arch/s390/boot/decompressor.c

1844c9bc0b2fed arch/s390/boot/compressed/misc.c         Martin Schwidefsky  2010-02-26  25  
54f45214522ae7 arch/s390/boot/compressed/decompressor.c Vasily Gorbik       2021-06-16  26  #ifdef CONFIG_KERNEL_BZIP2
1b3e3faf29d3ac arch/s390/boot/compressed/decompressor.c Mikhail Zaslonko    2020-01-30  27  #define BOOT_HEAP_SIZE	0x400000
7b034d9c1b08b3 arch/s390/boot/compressed/decompressor.c Dimitri John Ledkov 2021-06-15 @28  #elif CONFIG_KERNEL_ZSTD
7b034d9c1b08b3 arch/s390/boot/compressed/decompressor.c Dimitri John Ledkov 2021-06-15  29  #define BOOT_HEAP_SIZE	0x30000
1844c9bc0b2fed arch/s390/boot/compressed/misc.c         Martin Schwidefsky  2010-02-26  30  #else
1b3e3faf29d3ac arch/s390/boot/compressed/decompressor.c Mikhail Zaslonko    2020-01-30  31  #define BOOT_HEAP_SIZE	0x10000
1844c9bc0b2fed arch/s390/boot/compressed/misc.c         Martin Schwidefsky  2010-02-26  32  #endif
1844c9bc0b2fed arch/s390/boot/compressed/misc.c         Martin Schwidefsky  2010-02-26  33  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
