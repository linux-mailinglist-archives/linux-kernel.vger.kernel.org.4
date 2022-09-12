Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAC5B5F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiILRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiILRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:44:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5DA7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663004666; x=1694540666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lcDb2hEgbOXk7wdmOeTMUBM/RCj168Apnv39oqfFv2g=;
  b=emvkmX0De0wa6F1GUDxIcrmobA90WxfHgYV3cxLqSKqFW8r9D5kp4tgl
   FzQgX8olcXR2ZIxjvhfI5YxutehYVHPg+eg94o6dEAnEK1mwRXJxVXSjq
   NyxCrPPx6JMdK1mnx+68V+QNbF2hgfm0+tRwj3RF5xEoNF2rWCCie8N9m
   y9XwNIDWlj3Xr1vjqBHJdDax0NQtxWATZoWz0mxk+JlRGQQzAPbfqUimY
   m0emevqkPAmsvjRR1Ej10lCIuZjhSOwVpJONg+bBbTzoAWKmGgrREDMBZ
   gPOIc/cJJal7SEKH5ZjDTc8GhwhOMh1zHJG4c32oeADyKsNXsXSwvpflc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="297930725"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="297930725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 10:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758477059"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 10:44:22 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXnTq-0002hH-0i;
        Mon, 12 Sep 2022 17:44:22 +0000
Date:   Tue, 13 Sep 2022 01:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, mingo@redhat.com
Cc:     kbuild-all@lists.01.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] sched/core: remove duplicate referenced
 header files
Message-ID: <202209130141.D1VI4JUi-lkp@intel.com>
References: <20220912082848.17859-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912082848.17859-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220909]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/sched-core-remove-duplicate-referenced-header-files/20220912-163221
base:    9a82ccda91ed2b40619cb3c10d446ae1f97bab6e
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220913/202209130141.D1VI4JUi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4a9f2bfb0bf0353106fa2c74d7a8a0a0db2573df
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/sched-core-remove-duplicate-referenced-header-files/20220912-163221
        git checkout 4a9f2bfb0bf0353106fa2c74d7a8a0a0db2573df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/core.c:8468:5: warning: no previous prototype for 'sched_dynamic_mode' [-Wmissing-prototypes]
    8468 | int sched_dynamic_mode(const char *str)
         |     ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8492:6: warning: no previous prototype for 'sched_dynamic_update' [-Wmissing-prototypes]
    8492 | void sched_dynamic_update(int mode)
         |      ^~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   kernel/sched/core.c: In function 'sched_dynamic_update':
>> include/linux/static_call_types.h:15:41: error: '__SCT__cond_resched' undeclared (first use in this function); did you mean '__cond_resched'?
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8498:9: note: in expansion of macro 'preempt_dynamic_enable'
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call_types.h:15:41: note: each undeclared identifier is reported only once for each function it appears in
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8498:9: note: in expansion of macro 'preempt_dynamic_enable'
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> kernel/sched/core.c:8498:32: error: 'cond_resched_dynamic_enabled' undeclared (first use in this function)
    8498 |         preempt_dynamic_enable(cond_resched);
         |                                ^~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8498:9: note: in expansion of macro 'preempt_dynamic_enable'
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:9:41: error: '__SCK__cond_resched' undeclared (first use in this function); did you mean '__cond_resched'?
       9 | #define STATIC_CALL_KEY_PREFIX          __SCK__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:12:41: note: in expansion of macro '__PASTE'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:12:49: note: in expansion of macro 'STATIC_CALL_KEY_PREFIX'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:155:31: note: in expansion of macro 'STATIC_CALL_KEY'
     155 |         __static_call_update(&STATIC_CALL_KEY(name),                    \
         |                               ^~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8498:9: note: in expansion of macro 'preempt_dynamic_enable'
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8498:9: note: in expansion of macro 'preempt_dynamic_enable'
    8498 |         preempt_dynamic_enable(cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:15:41: error: '__SCT__might_resched' undeclared (first use in this function); did you mean '__might_resched'?
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8499:9: note: in expansion of macro 'preempt_dynamic_enable'
    8499 |         preempt_dynamic_enable(might_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> kernel/sched/core.c:8499:32: error: 'might_resched_dynamic_enabled' undeclared (first use in this function)
    8499 |         preempt_dynamic_enable(might_resched);
         |                                ^~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8499:9: note: in expansion of macro 'preempt_dynamic_enable'
    8499 |         preempt_dynamic_enable(might_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:9:41: error: '__SCK__might_resched' undeclared (first use in this function); did you mean '__might_resched'?
       9 | #define STATIC_CALL_KEY_PREFIX          __SCK__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:12:41: note: in expansion of macro '__PASTE'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:12:49: note: in expansion of macro 'STATIC_CALL_KEY_PREFIX'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:155:31: note: in expansion of macro 'STATIC_CALL_KEY'
     155 |         __static_call_update(&STATIC_CALL_KEY(name),                    \
         |                               ^~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8499:9: note: in expansion of macro 'preempt_dynamic_enable'
    8499 |         preempt_dynamic_enable(might_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8499:9: note: in expansion of macro 'preempt_dynamic_enable'
    8499 |         preempt_dynamic_enable(might_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:15:41: error: '__SCT__preempt_schedule' undeclared (first use in this function)
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8500:9: note: in expansion of macro 'preempt_dynamic_enable'
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> kernel/sched/core.c:8500:32: error: 'preempt_schedule_dynamic_enabled' undeclared (first use in this function); did you mean 'preempt_dynamic_enable'?
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |                                ^~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8500:9: note: in expansion of macro 'preempt_dynamic_enable'
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:9:41: error: '__SCK__preempt_schedule' undeclared (first use in this function)
       9 | #define STATIC_CALL_KEY_PREFIX          __SCK__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:12:41: note: in expansion of macro '__PASTE'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:12:49: note: in expansion of macro 'STATIC_CALL_KEY_PREFIX'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:155:31: note: in expansion of macro 'STATIC_CALL_KEY'
     155 |         __static_call_update(&STATIC_CALL_KEY(name),                    \
         |                               ^~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8500:9: note: in expansion of macro 'preempt_dynamic_enable'
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8500:9: note: in expansion of macro 'preempt_dynamic_enable'
    8500 |         preempt_dynamic_enable(preempt_schedule);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:15:41: error: '__SCT__preempt_schedule_notrace' undeclared (first use in this function)
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8501:9: note: in expansion of macro 'preempt_dynamic_enable'
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> kernel/sched/core.c:8501:32: error: 'preempt_schedule_notrace_dynamic_enabled' undeclared (first use in this function)
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8501:9: note: in expansion of macro 'preempt_dynamic_enable'
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:9:41: error: '__SCK__preempt_schedule_notrace' undeclared (first use in this function)
       9 | #define STATIC_CALL_KEY_PREFIX          __SCK__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:12:41: note: in expansion of macro '__PASTE'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:12:49: note: in expansion of macro 'STATIC_CALL_KEY_PREFIX'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:155:31: note: in expansion of macro 'STATIC_CALL_KEY'
     155 |         __static_call_update(&STATIC_CALL_KEY(name),                    \
         |                               ^~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8501:9: note: in expansion of macro 'preempt_dynamic_enable'
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8501:9: note: in expansion of macro 'preempt_dynamic_enable'
    8501 |         preempt_dynamic_enable(preempt_schedule_notrace);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:15:41: error: '__SCT__irqentry_exit_cond_resched' undeclared (first use in this function)
      15 | #define STATIC_CALL_TRAMP_PREFIX        __SCT__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:18:41: note: in expansion of macro '__PASTE'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:18:49: note: in expansion of macro 'STATIC_CALL_TRAMP_PREFIX'
      18 | #define STATIC_CALL_TRAMP(name)         __PASTE(STATIC_CALL_TRAMP_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:17: note: in expansion of macro 'STATIC_CALL_TRAMP'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                 ^~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8502:9: note: in expansion of macro 'preempt_dynamic_enable'
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
>> kernel/sched/core.c:8502:32: error: 'irqentry_exit_cond_resched_dynamic_enabled' undeclared (first use in this function)
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8502:9: note: in expansion of macro 'preempt_dynamic_enable'
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
>> include/linux/static_call_types.h:9:41: error: '__SCK__irqentry_exit_cond_resched' undeclared (first use in this function)
       9 | #define STATIC_CALL_KEY_PREFIX          __SCK__
         |                                         ^~~~~~~
   include/linux/compiler_types.h:73:23: note: in definition of macro '___PASTE'
      73 | #define ___PASTE(a,b) a##b
         |                       ^
   include/linux/static_call_types.h:12:41: note: in expansion of macro '__PASTE'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                         ^~~~~~~
   include/linux/static_call_types.h:12:49: note: in expansion of macro 'STATIC_CALL_KEY_PREFIX'
      12 | #define STATIC_CALL_KEY(name)           __PASTE(STATIC_CALL_KEY_PREFIX, name)
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:155:31: note: in expansion of macro 'STATIC_CALL_KEY'
     155 |         __static_call_update(&STATIC_CALL_KEY(name),                    \
         |                               ^~~~~~~~~~~~~~~
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8502:9: note: in expansion of macro 'preempt_dynamic_enable'
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/tracepoint.h:22,
                    from include/trace/syscall.h:5,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8502:9: note: in expansion of macro 'preempt_dynamic_enable'
    8502 |         preempt_dynamic_enable(irqentry_exit_cond_resched);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8506:17: note: in expansion of macro 'preempt_dynamic_enable'
    8506 |                 preempt_dynamic_enable(cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
>> kernel/sched/core.c:8507:41: error: 'might_resched_dynamic_disabled' undeclared (first use in this function)
    8507 |                 preempt_dynamic_disable(might_resched);
         |                                         ^~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8507:17: note: in expansion of macro 'preempt_dynamic_disable'
    8507 |                 preempt_dynamic_disable(might_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8507:17: note: in expansion of macro 'preempt_dynamic_disable'
    8507 |                 preempt_dynamic_disable(might_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
>> kernel/sched/core.c:8508:41: error: 'preempt_schedule_dynamic_disabled' undeclared (first use in this function); did you mean 'preempt_dynamic_disable'?
    8508 |                 preempt_dynamic_disable(preempt_schedule);
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8508:17: note: in expansion of macro 'preempt_dynamic_disable'
    8508 |                 preempt_dynamic_disable(preempt_schedule);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8508:17: note: in expansion of macro 'preempt_dynamic_disable'
    8508 |                 preempt_dynamic_disable(preempt_schedule);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
>> kernel/sched/core.c:8509:41: error: 'preempt_schedule_notrace_dynamic_disabled' undeclared (first use in this function)
    8509 |                 preempt_dynamic_disable(preempt_schedule_notrace);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8509:17: note: in expansion of macro 'preempt_dynamic_disable'
    8509 |                 preempt_dynamic_disable(preempt_schedule_notrace);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8509:17: note: in expansion of macro 'preempt_dynamic_disable'
    8509 |                 preempt_dynamic_disable(preempt_schedule_notrace);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
>> kernel/sched/core.c:8510:41: error: 'irqentry_exit_cond_resched_dynamic_disabled' undeclared (first use in this function)
    8510 |                 preempt_dynamic_disable(irqentry_exit_cond_resched);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8510:17: note: in expansion of macro 'preempt_dynamic_disable'
    8510 |                 preempt_dynamic_disable(irqentry_exit_cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8510:17: note: in expansion of macro 'preempt_dynamic_disable'
    8510 |                 preempt_dynamic_disable(irqentry_exit_cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8515:17: note: in expansion of macro 'preempt_dynamic_enable'
    8515 |                 preempt_dynamic_enable(cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8516:17: note: in expansion of macro 'preempt_dynamic_enable'
    8516 |                 preempt_dynamic_enable(might_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8517:17: note: in expansion of macro 'preempt_dynamic_disable'
    8517 |                 preempt_dynamic_disable(preempt_schedule);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8518:17: note: in expansion of macro 'preempt_dynamic_disable'
    8518 |                 preempt_dynamic_disable(preempt_schedule_notrace);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8519:17: note: in expansion of macro 'preempt_dynamic_disable'
    8519 |                 preempt_dynamic_disable(irqentry_exit_cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
>> kernel/sched/core.c:8524:41: error: 'cond_resched_dynamic_disabled' undeclared (first use in this function)
    8524 |                 preempt_dynamic_disable(cond_resched);
         |                                         ^~~~~~~~~~~~
   include/linux/static_call.h:154:49: note: in definition of macro 'static_call_update'
     154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
         |                                                 ^~~~
   kernel/sched/core.c:8524:17: note: in expansion of macro 'preempt_dynamic_disable'
    8524 |                 preempt_dynamic_disable(cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8524:17: note: in expansion of macro 'preempt_dynamic_disable'
    8524 |                 preempt_dynamic_disable(cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8484:41: note: in expansion of macro 'static_call_update'
    8484 | #define preempt_dynamic_disable(f)      static_call_update(f, f##_dynamic_disabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8525:17: note: in expansion of macro 'preempt_dynamic_disable'
    8525 |                 preempt_dynamic_disable(might_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8526:17: note: in expansion of macro 'preempt_dynamic_enable'
    8526 |                 preempt_dynamic_enable(preempt_schedule);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8527:17: note: in expansion of macro 'preempt_dynamic_enable'
    8527 |                 preempt_dynamic_enable(preempt_schedule_notrace);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   include/linux/static_call.h:156:60: warning: passing argument 3 of '__static_call_update' makes pointer from integer without a cast [-Wint-conversion]
     156 |                              STATIC_CALL_TRAMP_ADDR(name), __F);        \
         |                                                            ^~~
         |                                                            |
         |                                                            int
   kernel/sched/core.c:8483:41: note: in expansion of macro 'static_call_update'
    8483 | #define preempt_dynamic_enable(f)       static_call_update(f, f##_dynamic_enabled)
         |                                         ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8528:17: note: in expansion of macro 'preempt_dynamic_enable'
    8528 |                 preempt_dynamic_enable(irqentry_exit_cond_resched);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/static_call.h:177:82: note: expected 'void *' but argument is of type 'int'
     177 | extern void __static_call_update(struct static_call_key *key, void *tramp, void *func);
         |                                                                            ~~~~~~^~~~
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:8566:14: error: redefinition of 'preempt_model_none'
    8566 |         bool preempt_model_##mode(void)                                          \
         |              ^~~~~~~~~~~~~~
   kernel/sched/core.c:8573:1: note: in expansion of macro 'PREEMPT_MODEL_ACCESSOR'
    8573 | PREEMPT_MODEL_ACCESSOR(none);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/sched/mm.h:7,
                    from include/linux/xarray.h:19,
                    from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:9:
   include/linux/sched.h:2154:20: note: previous definition of 'preempt_model_none' with type 'bool(void)' {aka '_Bool(void)'}
    2154 | static inline bool preempt_model_none(void)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:8566:14: error: redefinition of 'preempt_model_voluntary'
    8566 |         bool preempt_model_##mode(void)                                          \
         |              ^~~~~~~~~~~~~~
   kernel/sched/core.c:8574:1: note: in expansion of macro 'PREEMPT_MODEL_ACCESSOR'
    8574 | PREEMPT_MODEL_ACCESSOR(voluntary);
         | ^~~~~~~~~~~~~~~~~~~~~~


vim +/cond_resched_dynamic_enabled +8498 kernel/sched/core.c

8a69fe0be143b0 Mark Rutland 2022-02-14  8491  
4c7485584d48f6 Mark Rutland 2022-02-14  8492  void sched_dynamic_update(int mode)
4c7485584d48f6 Mark Rutland 2022-02-14  8493  {
4c7485584d48f6 Mark Rutland 2022-02-14  8494  	/*
4c7485584d48f6 Mark Rutland 2022-02-14  8495  	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
4c7485584d48f6 Mark Rutland 2022-02-14  8496  	 * the ZERO state, which is invalid.
4c7485584d48f6 Mark Rutland 2022-02-14  8497  	 */
8a69fe0be143b0 Mark Rutland 2022-02-14 @8498  	preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8499  	preempt_dynamic_enable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8500  	preempt_dynamic_enable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8501  	preempt_dynamic_enable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8502  	preempt_dynamic_enable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8503  
4c7485584d48f6 Mark Rutland 2022-02-14  8504  	switch (mode) {
4c7485584d48f6 Mark Rutland 2022-02-14  8505  	case preempt_dynamic_none:
8a69fe0be143b0 Mark Rutland 2022-02-14  8506  		preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8507  		preempt_dynamic_disable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8508  		preempt_dynamic_disable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8509  		preempt_dynamic_disable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14 @8510  		preempt_dynamic_disable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8511  		pr_info("Dynamic Preempt: none\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8512  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8513  
4c7485584d48f6 Mark Rutland 2022-02-14  8514  	case preempt_dynamic_voluntary:
8a69fe0be143b0 Mark Rutland 2022-02-14  8515  		preempt_dynamic_enable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8516  		preempt_dynamic_enable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8517  		preempt_dynamic_disable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8518  		preempt_dynamic_disable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8519  		preempt_dynamic_disable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8520  		pr_info("Dynamic Preempt: voluntary\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8521  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8522  
4c7485584d48f6 Mark Rutland 2022-02-14  8523  	case preempt_dynamic_full:
8a69fe0be143b0 Mark Rutland 2022-02-14 @8524  		preempt_dynamic_disable(cond_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8525  		preempt_dynamic_disable(might_resched);
8a69fe0be143b0 Mark Rutland 2022-02-14  8526  		preempt_dynamic_enable(preempt_schedule);
8a69fe0be143b0 Mark Rutland 2022-02-14  8527  		preempt_dynamic_enable(preempt_schedule_notrace);
8a69fe0be143b0 Mark Rutland 2022-02-14  8528  		preempt_dynamic_enable(irqentry_exit_cond_resched);
4c7485584d48f6 Mark Rutland 2022-02-14  8529  		pr_info("Dynamic Preempt: full\n");
4c7485584d48f6 Mark Rutland 2022-02-14  8530  		break;
4c7485584d48f6 Mark Rutland 2022-02-14  8531  	}
4c7485584d48f6 Mark Rutland 2022-02-14  8532  
4c7485584d48f6 Mark Rutland 2022-02-14  8533  	preempt_dynamic_mode = mode;
4c7485584d48f6 Mark Rutland 2022-02-14  8534  }
4c7485584d48f6 Mark Rutland 2022-02-14  8535  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
