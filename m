Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865C5B6C14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiIMK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiIMK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:57:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF775F130
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663066623; x=1694602623;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BL9ydBtVwfEgQDpu1HgFXSFKo0fJNzYIDkD86bRaHYg=;
  b=T0RsWJF+LiW3Q3/AdZgYqVZNPxaiulYkPxn4EiBuWapLDGZ2E3Wia396
   HpvTBm6QHxn6D2QGZVFNu5nxJndd5g273CurFd4STlaewma3QqCOspxlh
   oSws6R1S3rOR9TAWfXKSRPqJoUbxkvZcejt5+KvHna8+4pg9ymA3Mb0nM
   UJUmbcP47zUMDqezmfDJYxoqhOXK38DMpMYRiHxYmtcOiUPre0P/sgAwW
   mMH6mQfJ5DAYfflwkdF5+KHMvl9Iz/p52ko6IrD8IKhJBN6BBL6J8LTf3
   b2VgVPmENLVvEBKcGMJ8zOXf4BCtZZ8vgtIozFfQMz1xJZc2I0Xy/VUk5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="277839542"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="277839542"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 03:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861511473"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2022 03:57:01 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oY3bB-0003WM-0Y;
        Tue, 13 Sep 2022 10:57:01 +0000
Date:   Tue, 13 Sep 2022 18:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>
Subject: [palmer:riscv-zicbom_fix 7/7] arch/riscv/mm/dma-noncoherent.c:15:14:
 error: redefinition of 'riscv_cbom_block_size' with a different type:
 'unsigned int' vs 'int'
Message-ID: <202209131858.0qmW0TEk-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git riscv-zicbom_fix
head:   933c80bff1907722a069a0d8bdce283183e4b203
commit: 933c80bff1907722a069a0d8bdce283183e4b203 [7/7] RISC-V: Clean up the Zicbom block size probing
config: riscv-buildonly-randconfig-r005-20220912 (https://download.01.org/0day-ci/archive/20220913/202209131858.0qmW0TEk-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?id=933c80bff1907722a069a0d8bdce283183e4b203
        git remote add palmer https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git
        git fetch --no-tags palmer riscv-zicbom_fix
        git checkout 933c80bff1907722a069a0d8bdce283183e4b203
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/riscv/mm/dma-noncoherent.c:15:14: error: redefinition of 'riscv_cbom_block_size' with a different type: 'unsigned int' vs 'int'
   unsigned int riscv_cbom_block_size;
                ^
   arch/riscv/include/asm/cacheflush.h:46:12: note: previous declaration is here
   extern int riscv_cbom_block_size;
              ^
   1 error generated.


vim +15 arch/riscv/mm/dma-noncoherent.c

    14	
  > 15	unsigned int riscv_cbom_block_size;
    16	static bool noncoherent_supported;
    17	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
