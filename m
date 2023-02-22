Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159B69FD06
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjBVUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBVUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:33:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02191298F3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677098012; x=1708634012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ag4ZqHO80giNF7SmvbaB75bOhLVmOTB34bIaKAEaUHk=;
  b=ekTNexmiel8Wjil10njn+glwnKBHB2crv4L6mi2sNMgZu6R1CWErfc6F
   dvWzJ2pfXI8YAaA6t0RF6X3Wyx0QA0BFwatmXixyYLRKRpQH7DKnUp7lI
   +eVAUaYMWG0JNhDxxG6kjGQpoTGSpBuXgAP7N6ibaMU2HyO+GAM4y5rue
   1pGSRcoGb7uY1jWnSFMaP41SKPcr9X8VFCLlxLxqsUNRZ2Aj3wT8N6Z1e
   R2E9ZkJCOR1yR8UCvNcumS4VVcolsHTS9G+TgjGYv+m8Ch0wAqYVraGKu
   iT+72g3Ndkvs8vuiXn1t1E0W1el7IrMKAf3bdi/OdVXMTN6nKQ2dwyK2L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419261789"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="419261789"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 12:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="674238794"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="674238794"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2023 12:33:31 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pUvnu-0000hh-1v;
        Wed, 22 Feb 2023 20:33:30 +0000
Date:   Thu, 23 Feb 2023 04:32:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4
 equals destination size
Message-ID: <202302230414.sQbDHtiC-lkp@intel.com>
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

Hi Mark,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   70756b49be4ea8bf36a664322df6e7e89895fa60
commit: 8f9e0a52810dd83406c768972d022c37e7a18f1f ACPI: Don't build ACPICA with '-Os'
date:   4 weeks ago
config: ia64-defconfig (https://download.01.org/0day-ci/archive/20230223/202302230414.sQbDHtiC-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f9e0a52810dd83406c768972d022c37e7a18f1f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f9e0a52810dd83406c768972d022c37e7a18f1f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/acpi/acpica/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302230414.sQbDHtiC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/acpi/acpi.h:24,
                    from drivers/acpi/acpica/tbfind.c:10:
   drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
>> include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4 equals destination size [-Wstringop-truncation]
     525 | #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/tbfind.c:59:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
      59 |         ACPI_COPY_NAMESEG(header.signature, signature);
         |         ^~~~~~~~~~~~~~~~~
--
   In file included from include/acpi/acpi.h:24,
                    from drivers/acpi/acpica/utstring.c:8:
   drivers/acpi/acpica/utstring.c: In function 'acpi_ut_repair_name':
>> include/acpi/actypes.h:525:42: warning: 'strncpy' specified bound 4 equals destination size [-Wstringop-truncation]
     525 | #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
         |                                         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/acpi/acpica/utstring.c:148:9: note: in expansion of macro 'ACPI_COPY_NAMESEG'
     148 |         ACPI_COPY_NAMESEG(&original_name, &name[0]);
         |         ^~~~~~~~~~~~~~~~~


vim +/strncpy +525 include/acpi/actypes.h

ff60027174cf94 Bob Moore 2012-10-31  519  
50df4d8b0f6e19 Bob Moore 2008-12-31  520  #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
5599fb69355d7a Bob Moore 2019-04-08  521  #define ACPI_COMPARE_NAMESEG(a,b)       (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
a3ce7a8e0dd9ba Bob Moore 2019-04-08  522  #define ACPI_COPY_NAMESEG(dest,src)     (*ACPI_CAST_PTR (u32, (dest)) = *ACPI_CAST_PTR (u32, (src)))
50df4d8b0f6e19 Bob Moore 2008-12-31  523  #else
3278675567dfb9 Bob Moore 2019-04-08  524  #define ACPI_COMPARE_NAMESEG(a,b)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAMESEG_SIZE))
3278675567dfb9 Bob Moore 2019-04-08 @525  #define ACPI_COPY_NAMESEG(dest,src)     (strncpy (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAMESEG_SIZE))
50df4d8b0f6e19 Bob Moore 2008-12-31  526  #endif
50df4d8b0f6e19 Bob Moore 2008-12-31  527  

:::::: The code at line 525 was first introduced by commit
:::::: 3278675567dfb901d831d46849c386a4f932905e ACPICA: Rename nameseg length macro/define for clarity

:::::: TO: Bob Moore <robert.moore@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
