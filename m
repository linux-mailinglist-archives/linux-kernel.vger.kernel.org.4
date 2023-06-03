Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62134720CBC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbjFCAy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjFCAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:54:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0226E55
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685753650; x=1717289650;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=77S8wqZFuLvz4bxzjRd3xCSQzfeWnG+uOlPaJ3x2F/4=;
  b=gbo75TYG8qqCGbk2cvPnlOD2xNrHizf6Ok9q1Mz4ByzuuO13Gp3ZDd4j
   SYrrOltb+mCyxUtOISPQ5by1MGSgJV3ABQ485EvWRZ29BhqiXlT5I/wRd
   4xeKnEZcX+Wsp+mYrF/5cjs6HVHrafvU+pRFeQZHXA+oifvFof8T15QhS
   tq7r1VoTXREXqgIlKxTcvuHv/nGVyjpILsauEnJ9EM2TBZPVJm5uF3qh9
   4o98+4DsDncGEuLV2KVKXfNzFzCQhAomxNDsC1BuE8GEHpOGu70xAV8Wn
   2Aw9C+Ys7iIo/ZP3KvnmJ8ZZkD/luoajbFhmda1Aru9TzhPgJgZOEoA6w
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="345593441"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="345593441"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 17:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737722583"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="737722583"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 17:54:08 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5FWx-00016P-35;
        Sat, 03 Jun 2023 00:54:07 +0000
Date:   Sat, 3 Jun 2023 08:54:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230602 7/7]
 fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]'
 is partly outside array bounds of 'unsigned char[26]'
Message-ID: <202306030807.GiXzVRcZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230602
head:   20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
commit: 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8 [7/7] Makefile: Enable -Warray-bounds
config: x86_64-buildonly-randconfig-r003-20230531 (https://download.01.org/0day-ci/archive/20230603/202306030807.GiXzVRcZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        git remote add gustavoars https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars testing/fam01-next20230602
        git checkout 20aaaa40b39f5178aee00e3982b68ab8fd0c59a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/clocksource/ drivers/mmc/host/ drivers/soc/qcom/ drivers/spi/ fs/jffs2/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030807.GiXzVRcZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/jffs2/summary.c:23:
   In function 'jffs2_sum_add_mem',
       inlined from 'jffs2_sum_add_inode_mem' at fs/jffs2/summary.c:130:9:
>> fs/jffs2/nodelist.h:43:28: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
      43 | #define je16_to_cpu(x) ((x).v16)
         |                        ~~~~^~~~~
   fs/jffs2/summary.c:71:17: note: in expansion of macro 'je16_to_cpu'
      71 |         switch (je16_to_cpu(item->u.nodetype)) {
         |                 ^~~~~~~~~~~
   In file included from fs/jffs2/summary.c:17:
   In function 'kmalloc',
       inlined from 'jffs2_sum_add_inode_mem' at fs/jffs2/summary.c:118:37:
   include/linux/slab.h:559:24: note: object of size 26 allocated by 'kmalloc_trace'
     559 |                 return kmalloc_trace(
         |                        ^~~~~~~~~~~~~~
     560 |                                 kmalloc_caches[kmalloc_type(flags)][index],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     561 |                                 flags, size);
         |                                 ~~~~~~~~~~~~
   In file included from fs/jffs2/nodelist.h:22:
   In function 'jffs2_sum_add_mem',
       inlined from 'jffs2_sum_add_inode_mem' at fs/jffs2/summary.c:130:9:
>> fs/jffs2/summary.c:79:73: warning: array subscript 'union jffs2_sum_mem[0]' is partly outside array bounds of 'unsigned char[26]' [-Warray-bounds]
      79 |                         s->sum_size += JFFS2_SUMMARY_DIRENT_SIZE(item->d.nsize);
   fs/jffs2/summary.h:34:80: note: in definition of macro 'JFFS2_SUMMARY_DIRENT_SIZE'
      34 | #define JFFS2_SUMMARY_DIRENT_SIZE(x) (sizeof(struct jffs2_sum_dirent_flash) + (x))
         |                                                                                ^
   In function 'kmalloc',
       inlined from 'jffs2_sum_add_inode_mem' at fs/jffs2/summary.c:118:37:
   include/linux/slab.h:559:24: note: object of size 26 allocated by 'kmalloc_trace'
     559 |                 return kmalloc_trace(
         |                        ^~~~~~~~~~~~~~
     560 |                                 kmalloc_caches[kmalloc_type(flags)][index],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     561 |                                 flags, size);
         |                                 ~~~~~~~~~~~~
--
   drivers/spi/spi-imx.c: In function 'spi_imx_probe':
>> drivers/spi/spi-imx.c:1705:34: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
    1705 |         slave_mode = devtype_data->has_slavemode &&
         |                      ~~~~~~~~~~~~^~~~~~~~~~~~~~~
--
   In file included from include/linux/clocksource.h:22,
                    from include/linux/clockchips.h:14,
                    from drivers/clocksource/timer-tegra.c:12:
   In function '__writel',
       inlined from 'tegra_timer_resume' at drivers/clocksource/timer-tegra.c:113:2:
>> arch/x86/include/asm/io.h:56:3: warning: array subscript 0 is outside array bounds of 'void[0]' [-Warray-bounds]
      56 | { asm volatile("mov" size " %0,%1": :reg (val), \
         |   ^~~
   arch/x86/include/asm/io.h:73:1: note: in expansion of macro 'build_mmio_write'
      73 | build_mmio_write(__writel, "l", unsigned int, "r", )
         | ^~~~~~~~~~~~~~~~
--
   drivers/soc/qcom/llcc-qcom.c: In function 'qcom_llcc_probe':
>> drivers/soc/qcom/llcc-qcom.c:1039:17: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
    1039 |         if (!cfg->no_edac) {
         |              ~~~^~~~~~~~~
--
   drivers/mmc/host/sdhci-msm.c: In function 'sdhci_msm_probe':
>> drivers/mmc/host/sdhci-msm.c:2557:48: warning: array subscript 0 is outside array bounds of 'const bool[0]' {aka 'const _Bool[]'} [-Warray-bounds]
    2557 |         msm_host->restore_dll_config = var_info->restore_dll_config;
         |                                        ~~~~~~~~^~~~~~~~~~~~~~~~~~~~


vim +43 fs/jffs2/nodelist.h

566865a2a4791c David Woodhouse 2007-04-23  42  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @43  #define je16_to_cpu(x) ((x).v16)
^1da177e4c3f41 Linus Torvalds  2005-04-16  44  #define je32_to_cpu(x) ((x).v32)
^1da177e4c3f41 Linus Torvalds  2005-04-16  45  #define jemode_to_cpu(x) (jffs2_to_os_mode((x).m))
^1da177e4c3f41 Linus Torvalds  2005-04-16  46  #elif defined(JFFS2_BIG_ENDIAN)
^1da177e4c3f41 Linus Torvalds  2005-04-16  47  #define cpu_to_je16(x) ((jint16_t){cpu_to_be16(x)})
^1da177e4c3f41 Linus Torvalds  2005-04-16  48  #define cpu_to_je32(x) ((jint32_t){cpu_to_be32(x)})
^1da177e4c3f41 Linus Torvalds  2005-04-16  49  #define cpu_to_jemode(x) ((jmode_t){cpu_to_be32(os_to_jffs2_mode(x))})
^1da177e4c3f41 Linus Torvalds  2005-04-16  50  

:::::: The code at line 43 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
