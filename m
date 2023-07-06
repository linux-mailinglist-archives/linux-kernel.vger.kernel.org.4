Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C774A3E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGFSpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGFSpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:45:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E971BF6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688669143; x=1720205143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3wOeUZs6JXKyWVNdi7+CcHIAObG75WGMUOy+RpNjDSU=;
  b=KhHY8dIEJasY1471xuqGd7veoQhf0/N94/aWPMtWNty5s5XT95s3AWI1
   bJ16M6t+BOnz9vC05j43dfwZcFScDwCm6gC1G9YJYWFXLs+RO9fpco51T
   58PbL8SbV9/IQmRH7/6WlMV7yyiRaS4wBcAAThF2jo11Ufmj41Oqa3CgN
   wWS74zPqwI9NmN4G51n3Y4jA6iXNfKNcTCTBPoR+ULDFY040RXKrxhoBz
   cmMitDxnrspta2BunqXQFirKrXgtCRss2To7EfMmZEBW1xLDZfinZcjEP
   iCC7HgjrlQthtr1I/DytQCsis59MY8S3QmVpuhp+P1+0RReXMewTqh/2d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="344021164"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="344021164"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 11:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="719668691"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="719668691"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2023 11:45:40 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qHTz2-0001Va-11;
        Thu, 06 Jul 2023 18:45:40 +0000
Date:   Fri, 7 Jul 2023 02:45:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: memdev.c:undefined reference to `firmware_upload_unregister'
Message-ID: <202307070209.tLMRS8xd-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c17414a273b81fe4e34e11d69fc30cc8b1431614
commit: 9521875bbe0055805557fff0b08fd9a29d02b7bc cxl: add a firmware update mechanism using the sysfs firmware loader
date:   11 days ago
config: xtensa-randconfig-r035-20230706 (https://download.01.org/0day-ci/archive/20230707/202307070209.tLMRS8xd-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230707/202307070209.tLMRS8xd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307070209.tLMRS8xd-lkp@intel.com/

All errors (new ones prefixed by >>):

   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_shutdown':
>> memdev.c:(.text+0xb10): undefined reference to `firmware_upload_unregister'
   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `devm_cxl_remove_fw_upload':
   memdev.c:(.text+0xb32): undefined reference to `firmware_upload_unregister'
   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `clear_exclusive_cxl_commands':
>> memdev.c:(.text+0x2334): undefined reference to `firmware_upload_register'
   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
   memdev.c:(.text+0x23d6): undefined reference to `firmware_upload_register'
   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `clear_exclusive_cxl_commands':
   memdev.c:(.text+0x2344): undefined reference to `firmware_upload_unregister'
   xtensa-linux-ld: drivers/cxl/core/memdev.o: in function `cxl_memdev_setup_fw_upload':
   memdev.c:(.text+0x24ab): undefined reference to `firmware_upload_unregister'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
