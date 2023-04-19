Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02996E827B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjDSUTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDSUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:19:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733313C0D;
        Wed, 19 Apr 2023 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935546; x=1713471546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VY84knn+qne8QfA5OMOBL73+DU9BMrIqscEw4mQ6kCw=;
  b=iv8parqA+H2edF+Rzmn/1PYL6kWx6UthrdRFTeTJpS5i2uZ2nqySlHQ/
   dJAB+XUSOcggoZJfVnmlWRSYpYF9ilYDqvvKD44Gq0K/VgAI00cGAndQL
   pZU/PhPq9W+WwAPlWgjN3Wn1QTu1CiUxHAObJ7DvJe04wgrXIBmV/hcIw
   CRqPKP+750sagN3AmeeE/sRpyqJRgpxx9H2KlzLEMd5iWYDGMxZFNCCrx
   QYr2tmioZ4d7fyR/7SEC1C7pcBJSjTf0QvVyZ9PUpbVAjSmWMpUKj1O4M
   E5vnkN7UIAxUcmsGwWgGPwx/HMC3y/TxVo+0Xv1jnEzqbBcYusRn5SI09
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347407272"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="347407272"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:19:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="756229394"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="756229394"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Apr 2023 13:19:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppEGd-000fAa-0C;
        Wed, 19 Apr 2023 20:19:03 +0000
Date:   Thu, 20 Apr 2023 04:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 1/4] block: constify partition prober array
Message-ID: <202304200454.r3d73iaw-lkp@intel.com>
References: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419-const-partition-v1-1-2d66f2d83873@weissschuh.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on af67688dca57999fd848f051eeea1d375ba546b2]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
base:   af67688dca57999fd848f051eeea1d375ba546b2
patch link:    https://lore.kernel.org/r/20230419-const-partition-v1-1-2d66f2d83873%40weissschuh.net
patch subject: [PATCH 1/4] block: constify partition prober array
config: x86_64-randconfig-s023 (https://download.01.org/0day-ci/archive/20230420/202304200454.r3d73iaw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9bc1f4308c10322c327c9e86ede6bb9e862440aa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Thomas-Wei-schuh/block-constify-partition-prober-array/20230419-155356
        git checkout 9bc1f4308c10322c327c9e86ede6bb9e862440aa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 olddefconfig
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304200454.r3d73iaw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> block/partitions/core.c:24:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:24:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:24:9: sparse:     got int ( * )( ... )
   block/partitions/core.c:47:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:47:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:47:9: sparse:     got int ( * )( ... )
   block/partitions/core.c:53:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:53:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:53:9: sparse:     got int ( * )( ... )
   block/partitions/core.c:56:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:56:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:56:9: sparse:     got int ( * )( ... )
   block/partitions/core.c:68:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:68:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:68:9: sparse:     got int ( * )( ... )
   block/partitions/core.c:71:9: sparse: sparse: incorrect type in initializer (different modifiers) @@     expected int ( const * )( ... ) @@     got int ( * )( ... ) @@
   block/partitions/core.c:71:9: sparse:     expected int ( const * )( ... )
   block/partitions/core.c:71:9: sparse:     got int ( * )( ... )

vim +24 block/partitions/core.c

387048bf67eeff Christoph Hellwig 2020-03-24  14  
9bc1f4308c1032 Thomas Weiﬂschuh  2023-04-19  15  static const int (*check_part[])(struct parsed_partitions *) = {
387048bf67eeff Christoph Hellwig 2020-03-24  16  	/*
387048bf67eeff Christoph Hellwig 2020-03-24  17  	 * Probe partition formats with tables at disk address 0
387048bf67eeff Christoph Hellwig 2020-03-24  18  	 * that also have an ADFS boot block at 0xdc0.
387048bf67eeff Christoph Hellwig 2020-03-24  19  	 */
387048bf67eeff Christoph Hellwig 2020-03-24  20  #ifdef CONFIG_ACORN_PARTITION_ICS
387048bf67eeff Christoph Hellwig 2020-03-24  21  	adfspart_check_ICS,
387048bf67eeff Christoph Hellwig 2020-03-24  22  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  23  #ifdef CONFIG_ACORN_PARTITION_POWERTEC
387048bf67eeff Christoph Hellwig 2020-03-24 @24  	adfspart_check_POWERTEC,
387048bf67eeff Christoph Hellwig 2020-03-24  25  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  26  #ifdef CONFIG_ACORN_PARTITION_EESOX
387048bf67eeff Christoph Hellwig 2020-03-24  27  	adfspart_check_EESOX,
387048bf67eeff Christoph Hellwig 2020-03-24  28  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  29  
387048bf67eeff Christoph Hellwig 2020-03-24  30  	/*
387048bf67eeff Christoph Hellwig 2020-03-24  31  	 * Now move on to formats that only have partition info at
387048bf67eeff Christoph Hellwig 2020-03-24  32  	 * disk address 0xdc0.  Since these may also have stale
387048bf67eeff Christoph Hellwig 2020-03-24  33  	 * PC/BIOS partition tables, they need to come before
387048bf67eeff Christoph Hellwig 2020-03-24  34  	 * the msdos entry.
387048bf67eeff Christoph Hellwig 2020-03-24  35  	 */
387048bf67eeff Christoph Hellwig 2020-03-24  36  #ifdef CONFIG_ACORN_PARTITION_CUMANA
387048bf67eeff Christoph Hellwig 2020-03-24  37  	adfspart_check_CUMANA,
387048bf67eeff Christoph Hellwig 2020-03-24  38  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  39  #ifdef CONFIG_ACORN_PARTITION_ADFS
387048bf67eeff Christoph Hellwig 2020-03-24  40  	adfspart_check_ADFS,
387048bf67eeff Christoph Hellwig 2020-03-24  41  #endif
387048bf67eeff Christoph Hellwig 2020-03-24  42  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
