Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A46D2E6E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 07:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjDAFsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDAFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 01:48:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E990E380;
        Fri, 31 Mar 2023 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680328099; x=1711864099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tAxeISHFjUch5my/m6anU5mYMaYP5Vu4zvUbILAbrg=;
  b=Peq+Biq84pZ8S3XskWZ8U+i1XroSqGVADM06mDn5E9j5udY+y2CQJxK2
   rj/8AE55nAUgjWvADu75ztOgM284wdn09UdNAb9wN+isUxZr04NrHeYv+
   wVraRSbF7/863DwMyGJv+4xxyKIYASJACSLjkNJb6mILTLnCSqfWXNvWd
   YGFNHI1VOVztGb8XrHJJBcli/rZJXJU60Lfu+1GEQLCEWZOMk91Ww8oed
   Po/LTxlfDB1kjCWQG1oXrOi/VF0TtEfbqViwXfCgo2xv3DFjbuBsALLDb
   XwTg0CcP5RGlgAOr9jWsYYr/nbJq3ilnkKLcRu07rLB9UNp0vQb+C2hCU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="325613633"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="325613633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 22:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="717962073"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="717962073"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 31 Mar 2023 22:48:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piU63-000MWv-0L;
        Sat, 01 Apr 2023 05:48:15 +0000
Date:   Sat, 1 Apr 2023 13:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v1 RESEND 1/1] HID: shield: Initial driver implementation
 with Thunderstrike support
Message-ID: <202304011342.6Bh3cWhA-lkp@intel.com>
References: <20230401032150.7424-2-rrameshbabu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401032150.7424-2-rrameshbabu@nvidia.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20230401/202304011342.6Bh3cWhA-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/febf8c75cc77baaf26a8ae869201cb1df6d67124
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rahul-Rameshbabu/HID-shield-Initial-driver-implementation-with-Thunderstrike-support/20230401-112438
        git checkout febf8c75cc77baaf26a8ae869201cb1df6d67124
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304011342.6Bh3cWhA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-shield.c:199:6: warning: no previous prototype for 'thunderstrike_hostcmd_req_work_handler' [-Wmissing-prototypes]
     199 | void thunderstrike_hostcmd_req_work_handler(struct work_struct *work)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
