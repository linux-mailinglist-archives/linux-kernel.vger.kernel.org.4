Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05E675BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjATRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjATRpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:45:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42E58645
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674236715; x=1705772715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DSu0aN1TgXR0l0onAvsmRPT0y3KxHhLoPrGtqtOamOo=;
  b=GOcXV+ZvwHxNWJW7OWaiROKInXIgcn1+yLcESvAJnLKnl7eHCoRKPKDD
   dXHbYLEdvygqsg7fDvWIwq3KZO3vto6V+sNy9JYHz8P/rwoM2SvsV2lZh
   ozNk921s3pMh+n+xL1/+0KV9EJa8G+9E19mMfzTCLU2FLu9b3af7umnNa
   6mlu9ZAM54Wi1Syqbte4rbAzpj30N2Lz/LB5dAaTCg29PJPyrP47n0jBb
   A9Ezxg8u8SsS/TCDzHJU+N4tP83N8DrkW1xP+ZE/ug+EGRtnFDkZ3a0P/
   h5h6Y4ED0u//d3rVifEGRTVUehtppHeJc5Bl2twpkvnIYsdoM+g1Fkqiq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="411872609"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411872609"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 09:45:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="729186851"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="729186851"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 09:45:13 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pIvRw-0002l8-3A;
        Fri, 20 Jan 2023 17:45:12 +0000
Date:   Sat, 21 Jan 2023 01:45:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/sparse.c:347:27: warning: unused function 'pgdat_to_phys'
Message-ID: <202301210155.1E5zABb5-lkp@intel.com>
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
head:   d368967cb1039b5c4cccb62b5a4b9468c50cd143
commit: ccbd6283a9b640c8d5c2b44db318fd72a63338ff mm/sparse: fix check_usemap_section_nr warnings
date:   1 year, 7 months ago
config: x86_64-randconfig-a003-20230116 (https://download.01.org/0day-ci/archive/20230121/202301210155.1E5zABb5-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccbd6283a9b640c8d5c2b44db318fd72a63338ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ccbd6283a9b640c8d5c2b44db318fd72a63338ff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/sparse.c:347:27: warning: unused function 'pgdat_to_phys' [-Wunused-function]
   static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
                             ^
   1 warning generated.


vim +/pgdat_to_phys +347 mm/sparse.c

   346	
 > 347	static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
   348	{
   349	#ifndef CONFIG_NEED_MULTIPLE_NODES
   350		return __pa_symbol(pgdat);
   351	#else
   352		return __pa(pgdat);
   353	#endif
   354	}
   355	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
