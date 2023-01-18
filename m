Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A438671F99
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjARO3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjARO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:28:55 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1942CFCD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674051353; x=1705587353;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ExSxMGo/2xKeNFhZxTWMnzdZWLZQe7hwQn1jBMq3Xjk=;
  b=SZrfWKFb3bX/xTHHz0depJq7G977JY2ueUr2h5hl1G/8/I1B9oNzwdIA
   E8fslCNL0fOwW0WOAA4NMiGJHpv7abOCY4B+NvvVxk42Xf4HZuhB5Bs4j
   0kmOdpx848Pcs3itOtdIDHb4PGhqMpehGXOGN/9mSc9ZZCmp5KQSxY5yl
   JwHLW/O5LYBTKtnYO78ILt+qs8hj3+wENEEdCB4fx6h4YgzDwdIFWalff
   tnbzUl5KHS1y552zof0bNk208gSVzZYssvOmmVVGVxeIYzXlwahDEr78V
   0hXChlNCbZKiARozUg84RRS+neJuKazYUQNtZTzM1H5zvq5g7AGiLFjjx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="322678825"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322678825"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 06:15:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988559115"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="988559115"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2023 06:15:50 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pI9EE-0000Pk-08;
        Wed, 18 Jan 2023 14:15:50 +0000
Date:   Wed, 18 Jan 2023 22:15:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/filemap.c:2190:6: warning: unused function 'folio_more_pages'
Message-ID: <202301182254.XhRmZw9A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1649ec55708ae42091a2f1bca1ab49ecd722d55
commit: 48658d8509d2db3391c95aa74308a2b1fc8e8461 filemap: remove find_get_pages_contig()
date:   4 months ago
config: arm-randconfig-r026-20230116 (https://download.01.org/0day-ci/archive/20230118/202301182254.XhRmZw9A-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48658d8509d2db3391c95aa74308a2b1fc8e8461
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 48658d8509d2db3391c95aa74308a2b1fc8e8461
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/filemap.c:2190:6: warning: unused function 'folio_more_pages' [-Wunused-function]
   bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
        ^
   1 warning generated.


vim +/folio_more_pages +2190 mm/filemap.c

be0ced5e9cb81a Matthew Wilcox (Oracle  2022-06-03  2188) 
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2189) static inline
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27 @2190) bool folio_more_pages(struct folio *folio, pgoff_t index, pgoff_t max)
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2191) {
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2192) 	if (!folio_test_large(folio) || folio_test_hugetlb(folio))
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2193) 		return false;
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2194) 	if (index >= max)
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2195) 		return false;
6b24ca4a1a8d4e Matthew Wilcox (Oracle  2020-06-27  2196) 	return index < folio->index + folio_nr_pages(folio) - 1;
^1da177e4c3f41 Linus Torvalds          2005-04-16  2197  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  2198  

:::::: The code at line 2190 was first introduced by commit
:::::: 6b24ca4a1a8d4ee3221d6d44ddbb99f542e4bda3 mm: Use multi-index entries in the page cache

:::::: TO: Matthew Wilcox (Oracle) <willy@infradead.org>
:::::: CC: Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
