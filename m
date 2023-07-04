Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9CA7477BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGDR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:27:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA792E76;
        Tue,  4 Jul 2023 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688491623; x=1720027623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XwL8uyMljnBLssxo8kuvLA/EPrJKdQkQbgutU3Wa2Ek=;
  b=E8Ef8uZRZJXrhhq8RIuDEfl/0YAoTbKLHLjL9D+d3cf4es9DFIaTw8FF
   XabDsu8seLtLnPKLVJsXublspd08hjUKt35Fx2TVRVVaHdxpZC1POwwud
   mVFPkBwAStCNIPOVc8zzpKT3w6zUEZBH/UAtFaraseSZIGTHDqruXL5JM
   ziX87Lv7E7DceS1eGLbRaq4Ak2TAteqvVDs0TN4YhCT7F8vZILucppEF2
   MT1U7Wv1hYP09XdL4+m/QCE/PzDIOScv7MlZfBK/zjuJhoMMfMUlP8M2T
   yLOo/EbAZKn8hfkF2J6gDvbDSfIXAg0pFuwkPdcoNvuCLsHyAbBZyl3/i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="366648656"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="366648656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 10:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="808993743"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="808993743"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2023 10:27:01 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGjnp-000IPV-0U;
        Tue, 04 Jul 2023 17:27:01 +0000
Date:   Wed, 5 Jul 2023 01:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
Message-ID: <202307050124.E5Ze5uux-lkp@intel.com>
References: <20230704105021.898555-1-andreaskleist@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704105021.898555-1-andreaskleist@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.4]
[also build test WARNING on linus/master next-20230704]
[cannot apply to dtor-input/next dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Helbech-Kleist/Input-exc3000-add-ACPI-support-for-EXC80H60/20230704-185127
base:   v6.4
patch link:    https://lore.kernel.org/r/20230704105021.898555-1-andreaskleist%40gmail.com
patch subject: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230705/202307050124.E5Ze5uux-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307050124.E5Ze5uux-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307050124.E5Ze5uux-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/touchscreen/exc3000.c:460:38: warning: initialization of 'long unsigned int' from 'struct eeti_dev_info *' makes integer from pointer without a cast [-Wint-conversion]
     460 |         { "EGA00001", .driver_data = &exc3000_info[EETI_EXC80H60] },
         |                                      ^
   drivers/input/touchscreen/exc3000.c:460:38: note: (near initialization for 'exc3000_acpi_match[0].driver_data')


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
