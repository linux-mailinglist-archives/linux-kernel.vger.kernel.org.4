Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60025B6519
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIMBbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiIMBbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:31:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B2E34
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663032700; x=1694568700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7GcriuGJN8QkCZ6dALbv+nUQS22ajzVge8n1O9gPcMA=;
  b=KPmvngxV+pLJQ0MmPyJRmG4Gi7KpIKZN4e05xwqShj0o7Myl4l3+hQsJ
   MK8aMLgdI8n2p2aL+ar8rfUv1ucBiFpwuQVnuPZuBHcohxGUT/7n4vojX
   miYc7mYZHRHsfPjTxk3kOZr/bp7BV6DYtOnjFlIYgGMLRcVEfs0obcRDY
   pBjvAq6UfBa4lJ01USHFob6sV9NTCkLqH7Bql53Qg9OyfpacI4ehiIVcA
   HPXnYHQ25PsDdaPsWfgKLXe5xwpX9MEznsIjqZwKdiGgMNKTen3tO5Zab
   /8yPNc7daxEgmZ1jFhnSSCGW3bv+X72G9XEZiST2pBT+VZp4o4CQ4XS6Y
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277743923"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="277743923"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 18:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="944856083"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2022 18:31:38 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXum2-00033x-0f;
        Tue, 13 Sep 2022 01:31:38 +0000
Date:   Tue, 13 Sep 2022 09:30:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or
 directory
Message-ID: <202209130916.1lUqRlBJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saleem,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e839a756012b6cad7a4eeb67b0598ac3f349f863
commit: fde9c59aebafb91caeed816cc510b56f14aa63ae riscv: explicitly use symbol offsets for VDSO
date:   1 year, 1 month ago
config: riscv-randconfig-r031-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130916.1lUqRlBJ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fde9c59aebafb91caeed816cc510b56f14aa63ae
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout fde9c59aebafb91caeed816cc510b56f14aa63ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld.lld: error: section .text load address range overlaps with _ftrace_annotated_branch
   >>> .text range is [0x800, 0x112B]
   >>> _ftrace_annotated_branch range is [0x840, 0xAAF]
>> llvm-nm: error: arch/riscv/kernel/vdso/vdso.so.dbg: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
