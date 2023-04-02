Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214676D3536
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDBCLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 22:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjDBCLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 22:11:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E5EC5F;
        Sat,  1 Apr 2023 19:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680401509; x=1711937509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EAUnShvAN7CBmVvc/poi83y0CvKkYQeH+bGcVMW0RxY=;
  b=D9mhDpUSJ2yj+AQGW83yIuafu8WApLBR7IxDRrr6XpktNcULizsjiCu8
   KOUBldjljWKn5Y6mwo/XH9u22JrYjORcR2k108ns1sJ9SYEuWW8ERo1tT
   Y/HlE4H4F+AXANLYBrB4ewVRDr+DROh/quYl6XjdxLQc8Wjyol+ZcFBeA
   bnrxYJRads9jRTmxYmFQGvkxM9sBEvIEHXrvuXnX3lnyjdAhnJDTUBoBj
   AvSo1oiXETfxfUmY5g/n0eHtsmEoROX1aYM64WRZVG5/bgTqkjnGJRUCY
   qB08Ut0Evxfve8Q5I23qcXBw0TMtOjqQAxgk9ZzLHC8jhMSl4/QlynErA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="341713738"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="341713738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 19:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="688113255"
X-IronPort-AV: E=Sophos;i="5.98,311,1673942400"; 
   d="scan'208";a="688113255"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2023 19:11:46 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pinC5-000NAx-2a;
        Sun, 02 Apr 2023 02:11:45 +0000
Date:   Sun, 2 Apr 2023 10:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v1 RESEND 1/1] HID: shield: Initial driver implementation
 with Thunderstrike support
Message-ID: <202304020922.vsngJnBT-lkp@intel.com>
References: <20230401032150.7424-2-rrameshbabu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401032150.7424-2-rrameshbabu@nvidia.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hid/for-next]
[also build test WARNING on linus/master v6.3-rc4 next-20230331]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rahul-Rameshbabu/HID-shield-Initial-driver-implementation-with-Thunderstrike-support/20230401-112438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230401032150.7424-2-rrameshbabu%40nvidia.com
patch subject: [PATCH v1 RESEND 1/1] HID: shield: Initial driver implementation with Thunderstrike support
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20230402/202304020922.vsngJnBT-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/febf8c75cc77baaf26a8ae869201cb1df6d67124
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rahul-Rameshbabu/HID-shield-Initial-driver-implementation-with-Thunderstrike-support/20230401-112438
        git checkout febf8c75cc77baaf26a8ae869201cb1df6d67124
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hid/ drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304020922.vsngJnBT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-shield.c:199:6: warning: no previous prototype for function 'thunderstrike_hostcmd_req_work_handler' [-Wmissing-prototypes]
   void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
        ^
   drivers/hid/hid-shield.c:199:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
   ^
   static 
   1 warning generated.


vim +/thunderstrike_hostcmd_req_work_handler +199 drivers/hid/hid-shield.c

   198	
 > 199	void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
   200	{
   201		struct thunderstrike *ts =
   202			container_of(work, struct thunderstrike, hostcmd_req_work);
   203		struct thunderstrike_hostcmd_req_report *report;
   204		unsigned long flags;
   205	
   206		report = ts->req_report_dmabuf;
   207	
   208		if (test_and_clear_bit(THUNDERSTRIKE_FW_VERSION_UPDATE, &ts->update_flags)) {
   209			thunderstrike_hostcmd_req_report_init(
   210				report, THUNDERSTRIKE_HOSTCMD_ID_FW_VERSION);
   211			thunderstrike_send_hostcmd_request(ts);
   212		}
   213	
   214		if (test_and_clear_bit(THUNDERSTRIKE_BOARD_INFO_UPDATE, &ts->update_flags)) {
   215			thunderstrike_hostcmd_req_report_init(
   216				report, THUNDERSTRIKE_HOSTCMD_ID_BOARD_INFO);
   217			thunderstrike_send_hostcmd_request(ts);
   218		}
   219	
   220		if (test_and_clear_bit(THUNDERSTRIKE_HAPTICS_UPDATE, &ts->update_flags)) {
   221			thunderstrike_hostcmd_req_report_init(
   222				report, THUNDERSTRIKE_HOSTCMD_ID_HAPTICS);
   223	
   224			report->haptics.update = 1;
   225			spin_lock_irqsave(&ts->haptics_update_lock, flags);
   226			report->haptics.motors = ts->haptics_val;
   227			spin_unlock_irqrestore(&ts->haptics_update_lock, flags);
   228	
   229			thunderstrike_send_hostcmd_request(ts);
   230		}
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
