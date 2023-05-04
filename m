Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286F6F6A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjEDL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:59:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092945580;
        Thu,  4 May 2023 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683201567; x=1714737567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wCXBg5zlOMnRfdDbHBWzSwfpftDOz/d8B2/eAav00OQ=;
  b=abk3r+NfsJKMOTX7jPBo6MEBHSB2vM3RXJMMA539R4V6XDBcNg6kot9g
   l2LoVVmspKy8lbx3uw+bmy2ZmadwWtjz//+otHY+7zAX3q1SRJiyiVENg
   naRXK3iJ1wmNyHAqEr2GygEoaz74ycvpHJoDVFfVFX4FAe5MKZyfjfEK4
   e8sBs6CIkXCffK+BO1LjJOtzYnTSyllk/ZUITpcfEvJbANoPje2q8Ku8d
   LAA/j4MZNmPHe0OrC34SsNt0jhgibV2PTyjv4eojHi3pQceT+yB0UbJJY
   4Q/N5GdtJHwmvnAzVCae5SG/laWXxvrcUOSUTBSFWk6v6nUFuV0joBiIJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="435219600"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="435219600"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 04:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="943307312"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="943307312"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2023 04:59:24 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puXcJ-0002to-2p;
        Thu, 04 May 2023 11:59:23 +0000
Date:   Thu, 4 May 2023 19:59:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v11 13/14] HP BIOSCFG driver  - Makefile
Message-ID: <202305041942.Cc0sqwxY-lkp@intel.com>
References: <20230420165454.9517-14-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420165454.9517-14-jorge.lopez2@hp.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.3 next-20230428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jorge-Lopez/HP-BIOSCFG-driver-Documentation/20230421-012956
base:   linus/master
patch link:    https://lore.kernel.org/r/20230420165454.9517-14-jorge.lopez2%40hp.com
patch subject: [PATCH v11 13/14] HP BIOSCFG driver  - Makefile
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230504/202305041942.Cc0sqwxY-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/55e860a942040b0d0f1b58362dc4885b1a8acaf2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jorge-Lopez/HP-BIOSCFG-driver-Documentation/20230421-012956
        git checkout 55e860a942040b0d0f1b58362dc4885b1a8acaf2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305041942.Cc0sqwxY-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/hp/hp-bioscfg/bioscfg.o: in function `get_wmiobj_pointer':
>> bioscfg.c:(.text+0x750): multiple definition of `get_wmiobj_pointer'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x830): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/bioscfg.o: in function `get_instance_count':
>> bioscfg.c:(.text+0x7ac): multiple definition of `get_instance_count'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x88c): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.o: in function `init_bios_attr_set_interface':
>> biosattr-interface.c:(.text+0x4dc): multiple definition of `init_bios_attr_set_interface'; drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.o:biosattr-interface.c:(.text+0x33c): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/biosattr-interface.o: in function `exit_bios_attr_set_interface':
>> biosattr-interface.c:(.text+0x4f8): multiple definition of `exit_bios_attr_set_interface'; drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.o:biosattr-interface.c:(.text+0x358): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.o: in function `init_bios_attr_pass_interface':
>> passwdattr-interface.c:(.text+0x68): multiple definition of `init_bios_attr_pass_interface'; drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.o:passwordattr-interface.c:(.text+0x338): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.o: in function `exit_bios_attr_pass_interface':
>> passwdattr-interface.c:(.text+0x84): multiple definition of `exit_bios_attr_pass_interface'; drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.o:passwordattr-interface.c:(.text+0x354): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.o: in function `calculate_security_buffer':
>> spmobj-attributes.c:(.text+0x4c4): multiple definition of `calculate_security_buffer'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x714): first defined here
   ld: drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.o: in function `populate_security_buffer':
>> spmobj-attributes.c:(.text+0x524): multiple definition of `populate_security_buffer'; drivers/platform/x86/dell/dell-wmi-sysman/sysman.o:sysman.c:(.text+0x744): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
