Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4978274C8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 00:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGIWXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGIWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 18:23:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566DB123
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688941380; x=1720477380;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kn6PrDY/vkvmFm5UWt3D6cx/WuJYX1oDONlXkHRpLOg=;
  b=THL953BuWzyC9tt0Pcw1UB8yKD6ztX1+d9YcOsu90J9y+BASwmhRxxY9
   V4Ec8dfgyCVZp6h4ZIce9Hi+PkQQ432Zdq0LRn+Xi57NqjNgLlT9tcH0L
   jWUbl9yhqrJ0ugbx73+TrCCc8IrJI/RAHsSa91ASic4ZLDw9NNZvAQfZe
   sQUG2vRK1Rt5sueqXFZUDhbI5K8A1RySclf2CJmPAZfMCcGNtq9lxyk7L
   wvw6tDKVAODi8+2m6GRqvB5qBCXhu4E8pCKryp4aM9fRlth0+Iwdhuxfs
   MNqwjyZ3OolbPx3H3U/+6StSC7/XtyC6m6UWdZmhrQKdUmZMfM0+bOOKp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="349016073"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="349016073"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 15:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834059050"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="834059050"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2023 15:22:58 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIcnx-0003Pc-10;
        Sun, 09 Jul 2023 22:22:57 +0000
Date:   Mon, 10 Jul 2023 06:22:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: ld.lld: error: section .bss load address range overlaps with
 .init.pi.text
Message-ID: <202307100638.uoomUZol-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
commit: 3b90b09af5be42491a8a74a549318cfa265b3029 riscv: Fix orphan section warnings caused by kernel/pi
date:   9 weeks ago
config: riscv-randconfig-r022-20230710 (https://download.01.org/0day-ci/archive/20230710/202307100638.uoomUZol-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230710/202307100638.uoomUZol-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307100638.uoomUZol-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: section .bss load address range overlaps with .init.pi.text
   >>> .bss range is [0xDD5000, 0x1EC438F]
   >>> .init.pi.text range is [0x1DBC350, 0x1DBF39B]
--
>> ld.lld: error: section .rodata load address range overlaps with .init.pi.bss
   >>> .rodata range is [0x1DBF400, 0x2888177]
   >>> .init.pi.bss range is [0x1EC4390, 0x1EC478F]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
