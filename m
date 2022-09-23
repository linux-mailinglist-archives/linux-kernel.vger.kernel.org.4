Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2987E5E71E3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiIWC1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbiIWC1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:27:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAD1115A58;
        Thu, 22 Sep 2022 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663900050; x=1695436050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jAYDgleBPbTOdu0y3VZbHd+A4x8iiSPAjiS8UjgjHoQ=;
  b=bi0fMUog5pEpdwn8HZZy5rP9mWbYmheutKqZpwgOqNAtl/w4yC/EHm3Z
   CNxK/z5p/XCIKn8+0/TUL1FKSLy4kCI3+W++g99O0/G4kmywHQ/wYvGma
   XsrLJnfxNYmO2hmS59VeV6B54nUi65mtp95KL8IVH3p5d9WgVyNtwe453
   b5PePvjjY6NDFsZPaidVRStWcVddz0WwapZ1Kq5vTSlwYvNbJnzHawBTa
   oZJ1A+eQ297MzFlhAYkjTb6ySu8WIr9CKBCxcz5lJfUhZLC71NHDzuLnC
   uY3+JoyW5sZnmdB6YilQ6NzNd1rieHF//YTWlTFEt//YIbj52ucRMs2J9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362296220"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362296220"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 19:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="709136696"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 19:27:25 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obYPU-0005DM-30;
        Fri, 23 Sep 2022 02:27:24 +0000
Date:   Fri, 23 Sep 2022 10:26:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: move -Wundef from KBUILD_CFLAGS to
 KBUILD_CPPFLAGS
Message-ID: <202209231052.nj1STd5X-lkp@intel.com>
References: <20220913080727.608495-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913080727.608495-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on masahiroy-kbuild/for-next]
[also build test WARNING on s390/features soc/for-next linus/master v6.0-rc6]
[cannot apply to next-20220921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbuild-move-Wundef-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220913-161447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: arm64-buildonly-randconfig-r003-20220922 (https://download.01.org/0day-ci/archive/20220923/202209231052.nj1STd5X-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ccf1a82d3dedb27a2b1b21f64e09183b197e1f6f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-move-Wundef-from-KBUILD_CFLAGS-to-KBUILD_CPPFLAGS/20220913-161447
        git checkout ccf1a82d3dedb27a2b1b21f64e09183b197e1f6f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/vmlinux.lds.S:65:
>> arch/arm64/include/asm/kernel-pgtable.h:135:41: warning: "PMD_SHIFT" is not defined, evaluates to 0 [-Wundef]
     135 | #define ARM64_MEMSTART_SHIFT            PMD_SHIFT
         |                                         ^~~~~~~~~
   arch/arm64/include/asm/kernel-pgtable.h:144:5: note: in expansion of macro 'ARM64_MEMSTART_SHIFT'
     144 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
         |     ^~~~~~~~~~~~~~~~~~~~


vim +/PMD_SHIFT +135 arch/arm64/include/asm/kernel-pgtable.h

87d1587bef394c Suzuki K. Poulose 2015-10-19  122  
a7f8de168ace48 Ard Biesheuvel    2016-02-16  123  /*
a7f8de168ace48 Ard Biesheuvel    2016-02-16  124   * To make optimal use of block mappings when laying out the linear
a7f8de168ace48 Ard Biesheuvel    2016-02-16  125   * mapping, round down the base of physical memory to a size that can
a7f8de168ace48 Ard Biesheuvel    2016-02-16  126   * be mapped efficiently, i.e., either PUD_SIZE (4k granule) or PMD_SIZE
a7f8de168ace48 Ard Biesheuvel    2016-02-16  127   * (64k granule), or a multiple that can be mapped using contiguous bits
a7f8de168ace48 Ard Biesheuvel    2016-02-16  128   * in the page tables: 32 * PMD_SIZE (16k granule)
a7f8de168ace48 Ard Biesheuvel    2016-02-16  129   */
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30  130  #if defined(CONFIG_ARM64_4K_PAGES)
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30  131  #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30  132  #elif defined(CONFIG_ARM64_16K_PAGES)
ca6ece6a76a8b5 Anshuman Khandual 2021-06-14  133  #define ARM64_MEMSTART_SHIFT		CONT_PMD_SHIFT
a7f8de168ace48 Ard Biesheuvel    2016-02-16  134  #else
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30 @135  #define ARM64_MEMSTART_SHIFT		PMD_SHIFT
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30  136  #endif
06e9bf2fd9b372 Ard Biesheuvel    2016-03-30  137  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
