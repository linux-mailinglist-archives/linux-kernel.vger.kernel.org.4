Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718269646B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjBNNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjBNNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:18:28 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF8A59F7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676380707; x=1707916707;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g391b4pJcaUYSaaGDlfnXGBI5zhmmzJlOmuYqqWus60=;
  b=IKWR15ieN/ws2C+vnFsCflv6ln7XQDk1iR/1xBFqfxVr5a07gJPbUIM3
   40666gJrK1iP465Hk6+1+HgISFrAs0oR6RYP9fzSYZ9IaozXZWRzIQ6Pn
   N/rUtfr86sOl4ugCGjDpHDoDpfH0/ac23yf9twKkRM/bLw+KaF/tvJPnL
   M8Ghd2TxQJT31G2TXupA0ZFqAWpN3T3mEZ8guY/tClGWfBtpwRcRyuP6s
   2bg0ek32TvlNny4mAHlcaJwRd1PU8Bsqubxs7XUoTbNOMjJOYCTPxueRG
   ZuDZCgFfv4ybmflGWe3NVwZ6c04zvTHitsr8qPvh8d1zImNNuFRnOc4j9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="311515474"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="311515474"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 05:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="662534581"
X-IronPort-AV: E=Sophos;i="5.97,296,1669104000"; 
   d="scan'208";a="662534581"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2023 05:18:11 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pRvCE-0008X6-16;
        Tue, 14 Feb 2023 13:18:10 +0000
Date:   Tue, 14 Feb 2023 21:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202302142132.37Z1iUQa-lkp@intel.com>
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
head:   f6feea56f66d34259c4222fa02e8171c4f2673d1
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   6 months ago
config: loongarch-randconfig-s053-20230214 (https://download.01.org/0day-ci/archive/20230214/202302142132.37Z1iUQa-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 93a4fa622eb061f75f87f0cf9609ab4e69c67d01
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/media/usb/uvc/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302142132.37Z1iUQa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_events_user.c:280:37: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:461:38: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:482:40: sparse: sparse: Using plain integer as NULL pointer
   kernel/trace/trace_events_user.c:1181:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1181:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1181:16: sparse:    void *
   kernel/trace/trace_events_user.c:1248:13: sparse: sparse: cast removes address space '__user' of expression
   kernel/trace/trace_events_user.c:1248:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:1248:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:1248:13: sparse:     got char *
   kernel/trace/trace_events_user.c:1264:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1264:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1264:16: sparse:    void *
   kernel/trace/trace_events_user.c:1291:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:1291:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:1291:9: sparse:    void *
   kernel/trace/trace_events_user.c: note: in included file:
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
>> kernel/trace/trace.h:1338:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got struct ring_buffer_event *[noderef] __percpu * @@
   kernel/trace/trace.h:1338:13: sparse:     expected void *ptr
   kernel/trace/trace.h:1338:13: sparse:     got struct ring_buffer_event *[noderef] __percpu *
--
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got unsigned int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
>> drivers/media/usb/uvc/uvc_queue.c:165:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:165:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got unsigned int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     expected void *ptr
   drivers/media/usb/uvc/uvc_queue.c:184:9: sparse:     got int [noderef] __percpu *

vim +1338 kernel/trace/trace.h

0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1333) 
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1334) static inline void
13292494379f92 Steven Rostedt (VMware   2019-12-13  1335) __trace_event_discard_commit(struct trace_buffer *buffer,
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1336) 			     struct ring_buffer_event *event)
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1337) {
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03 @1338) 	if (this_cpu_read(trace_buffered_event) == event) {
6c536d76cfe63b Steven Rostedt (VMware   2021-11-29  1339) 		/* Simply release the temp buffer and enable preemption */
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1340) 		this_cpu_dec(trace_buffered_event_cnt);
6c536d76cfe63b Steven Rostedt (VMware   2021-11-29  1341) 		preempt_enable_notrace();
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1342) 		return;
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1343) 	}
6c536d76cfe63b Steven Rostedt (VMware   2021-11-29  1344) 	/* ring_buffer_discard_commit() enables preemption */
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1345) 	ring_buffer_discard_commit(buffer, event);
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1346) }
0fc1b09ff1ff40 Steven Rostedt (Red Hat  2016-05-03  1347) 

:::::: The code at line 1338 was first introduced by commit
:::::: 0fc1b09ff1ff404ddf753f5ffa5cd0adc8fdcdc9 tracing: Use temp buffer when filtering events

:::::: TO: Steven Rostedt (Red Hat) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
