Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEA87481BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGEKJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGEKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:08:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0F6FF;
        Wed,  5 Jul 2023 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688551738; x=1720087738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjwUrGJSDQH1/NNVvdRDGKdmNkxNCJL0yotysRWJqAQ=;
  b=Y1rSsWRatth+KBjxjdp7H00CFuUjRzdypuYuqOjdsNrAOCSLImF3K4EQ
   daHdSn99xSyMu6++ofqgIBRbRkc2BfltzBv4TRYF6qoWK72Um9GDFqdaQ
   80OpSIXstSlqmybkas2TXJgCEaqmsTzr3XI8Urcwz3Q2D5HSAdfCwJWAJ
   hsYtRqtOb9tjJl7N5GD6RrcwqQu2GH3f8ghL7XCglnc+uxQHmQergbr0p
   lpW58GcNTg8PcxC/SAAHkjycjYIwJFYTrHqSQPUZRAbQs/FpYDZuWihVa
   yKvS4vBY4jFiGCH5pkRRHnS5TnJ3YXHO1dDDSyzGwPz+621RKfF5ITC0j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="394054569"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="394054569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 03:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="669360902"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="669360902"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2023 03:08:55 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGzRO-0000ZC-2m;
        Wed, 05 Jul 2023 10:08:54 +0000
Date:   Wed, 5 Jul 2023 18:08:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
Message-ID: <202307051716.GC4vKJUY-lkp@intel.com>
References: <20230704105021.898555-1-andreaskleist@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704105021.898555-1-andreaskleist@gmail.com>
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

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4]
[also build test WARNING on linus/master next-20230705]
[cannot apply to dtor-input/next dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Helbech-Kleist/Input-exc3000-add-ACPI-support-for-EXC80H60/20230704-185127
base:   v6.4
patch link:    https://lore.kernel.org/r/20230704105021.898555-1-andreaskleist%40gmail.com
patch subject: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
config: i386-randconfig-i062-20230703 (https://download.01.org/0day-ci/archive/20230705/202307051716.GC4vKJUY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307051716.GC4vKJUY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307051716.GC4vKJUY-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/exc3000.c:460:51: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] driver_data @@     got struct eeti_dev_info * @@
   drivers/input/touchscreen/exc3000.c:460:51: sparse:     expected unsigned long [usertype] driver_data
   drivers/input/touchscreen/exc3000.c:460:51: sparse:     got struct eeti_dev_info *

vim +460 drivers/input/touchscreen/exc3000.c

   457	
   458	#ifdef CONFIG_ACPI
   459	static const struct acpi_device_id exc3000_acpi_match[] = {
 > 460		{ "EGA00001", .driver_data = &exc3000_info[EETI_EXC80H60] },
   461		{ }
   462	};
   463	MODULE_DEVICE_TABLE(acpi, exc3000_acpi_match);
   464	#endif
   465	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
