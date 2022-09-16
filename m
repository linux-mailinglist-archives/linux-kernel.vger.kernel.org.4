Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4C5BB1F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIPSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIPSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:19:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEDDB6D49
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663352356; x=1694888356;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AX8WPJSoE1iegzEIPKYPAudRkoCG92AyTwp6vTEzpcc=;
  b=TLCnnHVOftecxsQtM1GWGlGWjmBYcq8N57OLqKm6o8c1AsTJDdzQDMq9
   4nH0N9xs7vnlfN7J5YFAZVRC8KzXTYuxw8HV1gPlEuU7Q4LxmjPvBIfQz
   VNt5MfBw/dZypVpE5JA8+G8OmRUjzNRdTK8fblhNjmbSp0SxKe4VlbH9l
   OceotRpCm8EZ4dTy1zXV2wbYimtX+C4e5PIwHNMBPeizZw5mtxamQag6r
   2AP54v0nfgeumLVGNhj/Cu8B65bkSV5AxZhTIkoxPeJWaO7FxNnlwNvCe
   6nMGqCHlNl29DK+j/fz9q/3X/OhXcNXKgT400Q773CEC6Gnxxsu+FuA8n
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="282075941"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="282075941"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 11:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="595341274"
Received: from lkp-server02.sh.intel.com (HELO 41300c7200ea) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2022 11:19:14 -0700
Received: from kbuild by 41300c7200ea with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oZFvl-00022A-1x;
        Fri, 16 Sep 2022 18:19:13 +0000
Date:   Sat, 17 Sep 2022 02:18:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.4.y 5364/5387]
 drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: cast to pointer from
 integer of different size
Message-ID: <202209170232.grVMomkJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   ba0de553122f5be5dde3102746a1060fd2737e63
commit: e7f78835d551bb2deb5aa3346d84c8f03ade313d [5364/5387] RDMA/siw: Pass a pointer to virt_to_page()
config: riscv-randconfig-r013-20220916 (https://download.01.org/0day-ci/archive/20220917/202209170232.grVMomkJ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e7f78835d551bb2deb5aa3346d84c8f03ade313d
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout e7f78835d551bb2deb5aa3346d84c8f03ade313d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/infiniband/sw/siw/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/page.h:130,
                    from arch/riscv/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:39,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/prandom.h:12,
                    from include/linux/random.h:101,
                    from include/linux/net.h:18,
                    from drivers/infiniband/sw/siw/siw_qp_tx.c:8:
   drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
>> drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      32 |                 return virt_to_page((void *)paddr);
         |                                     ^
   include/asm-generic/memory_model.h:69:32: note: in definition of macro '__pfn_to_page'
      69 | ({      unsigned long __pfn = (pfn);                    \
         |                                ^~~
   arch/riscv/include/asm/page.h:100:34: note: in expansion of macro 'PFN_DOWN'
     100 | #define phys_to_pfn(phys)       (PFN_DOWN(phys))
         |                                  ^~~~~~~~
   arch/riscv/include/asm/page.h:103:34: note: in expansion of macro 'phys_to_pfn'
     103 | #define virt_to_pfn(vaddr)      (phys_to_pfn(__pa(vaddr)))
         |                                  ^~~~~~~~~~~
   arch/riscv/include/asm/page.h:103:46: note: in expansion of macro '__pa'
     103 | #define virt_to_pfn(vaddr)      (phys_to_pfn(__pa(vaddr)))
         |                                              ^~~~
   arch/riscv/include/asm/page.h:106:46: note: in expansion of macro 'virt_to_pfn'
     106 | #define virt_to_page(vaddr)     (pfn_to_page(virt_to_pfn(vaddr)))
         |                                              ^~~~~~~~~~~
   drivers/infiniband/sw/siw/siw_qp_tx.c:32:24: note: in expansion of macro 'virt_to_page'
      32 |                 return virt_to_page((void *)paddr);
         |                        ^~~~~~~~~~~~


vim +32 drivers/infiniband/sw/siw/siw_qp_tx.c

     5	
     6	#include <linux/errno.h>
     7	#include <linux/types.h>
   > 8	#include <linux/net.h>
     9	#include <linux/scatterlist.h>
    10	#include <linux/highmem.h>
    11	#include <net/tcp.h>
    12	
    13	#include <rdma/iw_cm.h>
    14	#include <rdma/ib_verbs.h>
    15	#include <rdma/ib_user_verbs.h>
    16	
    17	#include "siw.h"
    18	#include "siw_verbs.h"
    19	#include "siw_mem.h"
    20	
    21	#define MAX_HDR_INLINE					\
    22		(((uint32_t)(sizeof(struct siw_rreq_pkt) -	\
    23			     sizeof(struct iwarp_send))) & 0xF8)
    24	
    25	static struct page *siw_get_pblpage(struct siw_mem *mem, u64 addr, int *idx)
    26	{
    27		struct siw_pbl *pbl = mem->pbl;
    28		u64 offset = addr - mem->va;
    29		dma_addr_t paddr = siw_pbl_get_buffer(pbl, offset, NULL, idx);
    30	
    31		if (paddr)
  > 32			return virt_to_page((void *)paddr);
    33	
    34		return NULL;
    35	}
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
