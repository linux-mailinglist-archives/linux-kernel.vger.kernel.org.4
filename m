Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17AD728BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbjFHXs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFHXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:48:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BE2715
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686268132; x=1717804132;
  h=date:from:to:cc:subject:message-id;
  bh=Vhg0/ILlINgffGOCpEq28IGl/J4iK5JB8UDjPg3i7fI=;
  b=EiqcnG3M5lxt6fRgpvLAsEw81P+3ZXK8aOVySKZsS8nV3ANQL006KxLH
   NftSkGcbErI6USHUMkaZMDvj8U+hyN5dgUbWtOSKnF2zPXH4upLulhpds
   Fwm42TWBIW/YxjTEtROqXQUolOL5My30ZqLAMtMnbNPfzdDEow6Z6/T1z
   iqQ2sr3opRydHwPXbO5k5nCjfYnuRr+zzVRTeB47pbUL5/MRXG4x+7bUG
   UQzAk7oT+0Ub3tsRZrXOXpJ6M2Igf48ly//gs4855hFgb+X0Mgti6CcJE
   JeZuZybN6ceNs8zmL8nW3ASPQJYG2GkJEKJ65/wzipLcqH7cPFt6+IpI3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342139881"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="342139881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 16:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713290391"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="713290391"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2023 16:48:48 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7PN2-0008Mc-0i;
        Thu, 08 Jun 2023 23:48:48 +0000
Date:   Fri, 09 Jun 2023 07:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/fam01-next20230608] BUILD SUCCESS WITH
 WARNING 22036d64a3a8a2358891a284b0e6b5fdbaecab73
Message-ID: <202306090737.vtRhCFDN-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/fam01-next20230608
branch HEAD: 22036d64a3a8a2358891a284b0e6b5fdbaecab73  ARM: OMAP2+: Fix -Warray-bounds warning _pwrdm_state_switch()

Warning: (recently discovered and may have been fixed)

arch/x86/kvm/ioapic.c:214:33: warning: array subscript 32 is above array bounds of 'union kvm_ioapic_redirect_entry[24]' [-Warray-bounds]
drivers/hwmon/lm85.c:1110:26: warning: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Warray-bounds]
drivers/leds/trigger/ledtrig-netdev.c:190:41: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: warning: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Warray-bounds]
drivers/net/wireless/ath/ath9k/mac.c:373:22: warning: array subscript 32 is above array bounds of 'struct ath9k_tx_queue_info[10]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[160]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[256]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[272]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[320]' [-Warray-bounds]
drivers/staging/rtl8712/rtl871x_xmit.c:949:40: warning: array subscript 4 is outside array bounds of 'void[448]' [-Warray-bounds]
fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
kernel/sched/psi.c:832:38: warning: array subscript 32 is above array bounds of 'unsigned int[4]' [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arc-allyesconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-allmodconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- arm64-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- i386-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-below-array-bounds-of-long-unsigned-int
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   |-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- kernel-sched-psi.c:warning:array-subscript-is-above-array-bounds-of-unsigned-int
|-- m68k-allmodconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- m68k-allyesconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- mips-allmodconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- mips-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- parisc-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- powerpc-allmodconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- riscv-allmodconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- riscv-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- s390-allmodconfig
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- s390-allyesconfig
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   `-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|-- s390-defconfig
|   `-- fs-smb-client-cifssmb.c:warning:writing-byte-into-a-region-of-size
|-- sh-allmodconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- sparc-allyesconfig
|   `-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|-- x86_64-allyesconfig
|   |-- arch-x86-kvm-ioapic.c:warning:array-subscript-is-above-array-bounds-of-union-kvm_ioapic_redirect_entry
|   |-- drivers-hwmon-lm85.c:warning:array-subscript-is-outside-array-bounds-of-struct-lm85_autofan
|   |-- drivers-leds-trigger-ledtrig-netdev.c:warning:writing-byte-into-a-region-of-size
|   |-- drivers-net-ethernet-mellanox-mlx4-alloc.c:warning:array-subscript-is-below-array-bounds-of-long-unsigned-int
|   |-- drivers-net-wireless-ath-ath9k-mac.c:warning:array-subscript-is-above-array-bounds-of-struct-ath9k_tx_queue_info
|   |-- drivers-staging-rtl8712-rtl871x_xmit.c:warning:array-subscript-is-outside-array-bounds-of-void
|   `-- kernel-sched-psi.c:warning:array-subscript-is-above-array-bounds-of-unsigned-int
`-- x86_64-rhel-8.3
    `-- fs-smb-client-cifssmb.c:warning:writing-byte-into-a-region-of-size

elapsed time: 725m

configs tested: 61
configs skipped: 2

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon                             defconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-x051-20230608   clang
x86_64               randconfig-x052-20230608   clang
x86_64               randconfig-x053-20230608   clang
x86_64               randconfig-x054-20230608   clang
x86_64               randconfig-x055-20230608   clang
x86_64               randconfig-x056-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
