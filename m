Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61C85BE882
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiITOSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiITOSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:18:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2588745F66
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663683315; x=1695219315;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xA0JrjBAnkFO5QAWRGJQ/YU/q0V/00/ns9LMq7yznFk=;
  b=RaCRzSLef9lSPswwGMmcd9jm3qXIXAv6TI/LqeUQONI4WU0DUmT2c5P3
   2yG8klbWym5cRa7YYYhWDMIuD6gmEKVtkbBX5HXSgINxYx7V4fyjlpiY4
   QLVkZi7BYAnCnXapUf1nuPvh8K6ooIhi17GEGnO6I5bVxV8pk/1UwxnXm
   eDSSYSZ4KG1xdWxE1pTbReeCOahQwYcHl/XPx2MWtrpC7Mj5v5u8mj2o1
   5f4mpVStkWVvsfO0R+cRgdYtayYyhH+6IwWfiRVsmfuHJYSbjQV9J8H61
   zLEGnMV/aQYL6p+JYCeiEzdnakPG7d9dDb/uc0xkHoyYFEanj4DNOD+ze
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363663896"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="363663896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="570097051"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Sep 2022 07:14:59 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oae1a-0002ng-1m;
        Tue, 20 Sep 2022 14:14:58 +0000
Date:   Tue, 20 Sep 2022 22:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/entry/common.c:736:24: warning: no previous prototype for
 'xen_pv_evtchn_do_upcall'
Message-ID: <202209202208.CpsEyXIp-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   521a547ced6477c54b4b0cc206000406c221b4d6
commit: 2f6474e4636bcc68af6c44abb2703f12d7f083da x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
date:   2 years, 3 months ago
config: x86_64-randconfig-r016-20220919 (https://download.01.org/0day-ci/archive/20220920/202209202208.CpsEyXIp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f6474e4636bcc68af6c44abb2703f12d7f083da
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2f6474e4636bcc68af6c44abb2703f12d7f083da
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/entry/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

   arch/x86/entry/common.c:274:24: warning: no previous prototype for 'prepare_exit_to_usermode' [-Wmissing-prototypes]
     274 | __visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/entry/common.c:336:24: warning: no previous prototype for 'syscall_return_slowpath' [-Wmissing-prototypes]
     336 | __visible noinstr void syscall_return_slowpath(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/entry/common.c:736:24: warning: no previous prototype for 'xen_pv_evtchn_do_upcall' [-Wmissing-prototypes]
     736 | __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~


vim +/xen_pv_evtchn_do_upcall +736 arch/x86/entry/common.c

   735	
 > 736	__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
