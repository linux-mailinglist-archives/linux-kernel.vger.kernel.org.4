Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF977747886
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGDTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDTBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:01:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834E10D5;
        Tue,  4 Jul 2023 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688497267; x=1720033267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GerdEuVYZNzgmpXytW8Sy7zJg7Ex3oVa7I4XH2Irmg=;
  b=cSUrZxAcHcDFCnA4jN5pBs+89BIRRjfGMZ5xaQcbnG6DjRYUXdkQNWHv
   yM+OddaX4Yk//QoxKLsc96xZGXYVzCRyWfDRth8Z3wHiNhBcdeoGvVuZd
   zPAHkL9A9BKJD4rWLIhX/Pm3LYZ9P6sNT9tE6nIP6W1i1rDHc8Wu7ZIQu
   mk//ipf/rLLb5NGEwnIC70SmOdaQs1H3dHCXiGPz4r5439E9j3NNCJXu4
   B5jKMnASBE6XN1UkFD2RndrZWQ7bJyfUsqlp182B8rR7hM2FF3Ua1pdiN
   2ffM/L5jNOgwRAatELG3rwRW2vDbMkM+xcPqCLr2AFD7e7znEg2+ojWto
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="363213240"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363213240"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 12:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="965574596"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="965574596"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jul 2023 12:01:04 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGlGp-000ISZ-2n;
        Tue, 04 Jul 2023 19:01:03 +0000
Date:   Wed, 5 Jul 2023 03:00:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
Message-ID: <202307050258.WtWKQJdV-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.4]
[also build test ERROR on linus/master next-20230704]
[cannot apply to dtor-input/next dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Helbech-Kleist/Input-exc3000-add-ACPI-support-for-EXC80H60/20230704-185127
base:   v6.4
patch link:    https://lore.kernel.org/r/20230704105021.898555-1-andreaskleist%40gmail.com
patch subject: [PATCH] Input: exc3000 - add ACPI support for EXC80H60
config: x86_64-randconfig-x001-20230703 (https://download.01.org/0day-ci/archive/20230705/202307050258.WtWKQJdV-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230705/202307050258.WtWKQJdV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307050258.WtWKQJdV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/input/touchscreen/exc3000.c:460:31: error: incompatible pointer to integer conversion initializing 'kernel_ulong_t' (aka 'unsigned long') with an expression of type 'struct eeti_dev_info *' [-Wint-conversion]
           { "EGA00001", .driver_data = &exc3000_info[EETI_EXC80H60] },
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


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
