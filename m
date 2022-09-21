Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34EA5C0575
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiIURte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIURtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:49:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B11125
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663782568; x=1695318568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FQhbBzcfelZ8xWnWoMLgl4CxP4yrTFfI6d5NwYEszFQ=;
  b=hsTBY9PMhdtFz+9z5ei23+F5gHwv72hawj8ywp0DBLkAozHZuf95CwAi
   pUxHCnsXTwb6GhAL+XlDW7FGhwGZPfhZl+cd5DA+5Y+LWMCbjW2xU9Bj2
   xX073g+umFZVP0yVHXo+eXIvtIOEYHtTQIVWwGRciq/Hb5mQw04KgIi7y
   QOIsDXqezzze4NX8sU094UYw+8wTgm4GgO57BCB2poKW8oIK0OiZDzvfE
   ZBfDKuwQr8peXBreW9ShhKrr4BkiG4ppoJPlgc3mY9TLH+Oo7GOpNldEu
   n0STSmnyDNsxMcOAN5Hw3e31BWYfoKpOhY5sxzkm4srvfJkbnV2494iMz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="283122562"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="283122562"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 10:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="948250549"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Sep 2022 10:39:30 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ob3h4-0003oA-0p;
        Wed, 21 Sep 2022 17:39:30 +0000
Date:   Thu, 22 Sep 2022 01:39:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Subject: [djiang:cxl-security 1/19] include/linux/memregion.h:54:9: error:
 implicit declaration of function 'WARN_ON_ONCE'
Message-ID: <202209220119.QSB1o664-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git cxl-security
head:   3b2ea8468d5dbe2e7b61dcd86cc3aeadfe766d07
commit: d8fab77dd9512ae56e653afddbef9351da206679 [1/19] memregion: Add cpu_cache_invalidate_memregion() interface
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220922/202209220119.QSB1o664-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=d8fab77dd9512ae56e653afddbef9351da206679
        git remote add djiang https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git
        git fetch --no-tags djiang cxl-security
        git checkout d8fab77dd9512ae56e653afddbef9351da206679
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/core/region.c:3:
   include/linux/memregion.h:52:5: warning: no previous prototype for 'cpu_cache_invalidate_memregion' [-Wmissing-prototypes]
      52 | int cpu_cache_invalidate_memregion(int res_desc)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memregion.h: In function 'cpu_cache_invalidate_memregion':
>> include/linux/memregion.h:54:9: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
      54 |         WARN_ON_ONCE("CPU cache invalidation required");
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/WARN_ON_ONCE +54 include/linux/memregion.h

    51	
    52	int cpu_cache_invalidate_memregion(int res_desc)
    53	{
  > 54		WARN_ON_ONCE("CPU cache invalidation required");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
