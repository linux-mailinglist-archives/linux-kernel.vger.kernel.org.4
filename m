Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC85B8755
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINLiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:38:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDB7C19C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663155482; x=1694691482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dhlpitfb4lr0LNOa/3JulGS19oum15x9nPMye9eciFo=;
  b=MMED0z6p81jF4rM4m2epQR9QRoD+PMMsu5iAQeZ0fAyC6Rd7V1xAuaw1
   dT4PvvV7E3mVXjqoFBJ7dWxUnS3iICkIX1j6SD/iPCg1IBzSTRyoFxOQs
   nUxk3VDRI0hcV+Xc0sBSkNtWcIU4zqyVRlEyX2/zOTRE5ogZz1GCL6xK/
   sdodRYe1T/7OR7DUI5indOL/pd0n3JgA/lNqzf1j+q7hQrCBcMvtXZoeh
   EaON5Rb6OY84sUZWFWc81wDFkr+Z7Y7PaOeVZtTgN1ZNCABSjy3KmTlAz
   NDpSNEfH+BRdb8iuoG+b2WTbCYfEKltVNaaREOEspwaDu18GHbNWrKZhQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="299763598"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299763598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 04:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="594349591"
Received: from lkp-server01.sh.intel.com (HELO d6e6b7c4e5a2) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2022 04:37:59 -0700
Received: from kbuild by d6e6b7c4e5a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oYQiM-00009I-1d;
        Wed, 14 Sep 2022 11:37:58 +0000
Date:   Wed, 14 Sep 2022 19:37:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 16/22] include/linux/dax.h:195:26:
 error: expected ';' after top level declarator
Message-ID: <202209141902.w0oaRZqa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   e27a0356de15f16934325784c6b1d89cf0f13458
commit: 155ac6b670cf6385f6dd14910560d569560af889 [16/22] devdax: Move address_space helpers to the DAX core
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220914/202209141902.w0oaRZqa-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=155ac6b670cf6385f6dd14910560d569560af889
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout 155ac6b670cf6385f6dd14910560d569560af889
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/filemap.c:15:
>> include/linux/dax.h:195:26: error: expected ';' after top level declarator
                                                     pgoff_t nr_pages)
                                                                      ^
                                                                      ;
   In file included from mm/filemap.c:25:
   include/linux/mman.h:154:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:132:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from mm/readahead.c:118:
>> include/linux/dax.h:195:26: error: expected ';' after top level declarator
                                                     pgoff_t nr_pages)
                                                                      ^
                                                                      ;
   1 error generated.


vim +195 include/linux/dax.h

5fac7408d82871 Dan Williams 2018-03-09  192  
a55637f2b5002e Dan Williams 2022-09-07  193  static inline struct page *dax_zap_mappings_range(struct address_space *mapping,
a55637f2b5002e Dan Williams 2022-09-07  194  						  pgoff_t start,
a55637f2b5002e Dan Williams 2022-09-07 @195  						  pgoff_t nr_pages)
155ac6b670cf63 Dan Williams 2022-09-03  196  static inline dax_entry_t dax_lock_page(struct page *page)
6bbdd563ee9a60 Vivek Goyal  2020-03-03  197  {
155ac6b670cf63 Dan Williams 2022-09-03  198  	if (IS_DAX(page->mapping->host))
155ac6b670cf63 Dan Williams 2022-09-03  199  		return ~0UL;
155ac6b670cf63 Dan Williams 2022-09-03  200  	return 0;
6bbdd563ee9a60 Vivek Goyal  2020-03-03  201  }
6bbdd563ee9a60 Vivek Goyal  2020-03-03  202  

:::::: The code at line 195 was first introduced by commit
:::::: a55637f2b5002e15813f88741e90ce6f463879e1 fsdax: Rework dax_layout_busy_page() to dax_zap_mappings()

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Dan Williams <dan.j.williams@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
