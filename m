Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404B6C8794
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCXVnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXVnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:43:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640810261;
        Fri, 24 Mar 2023 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679694220; x=1711230220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcrBWyt+plC+jyKx4GB1SFRBFOEkhh6uG5p5ikaNNVM=;
  b=a8sG5qYQCuPRoUgMGOTUkUEL3HfKGQf0xvUhUdV4UoVshYstpqUyUMRy
   GmxIFKLld4DEJuIdnP6IY/fVoUvckynYGzbDVRzSWHbwa06HLqRvF0SA9
   nOjZk6b1ZxLGfNZ1WrTwO1JsdE8/MwhOtQqsYeTi9GswRls+/o3s9j7Fg
   ZAOGEvOOjOSe/otu/b31W6e+p4W/o34XEXw163C6JM35/P6O1AmdVUNP+
   Xy3EzFsoBLXqhkY0d7PVRXrRKWSYnza2oXEoDFgMrYc4//BAe5rj+6pwP
   5C7ZjJX6s5gSwp8pOJMYuPssjiY3JaBArXIS0HhVrOhpep2Siwl5DsuCi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="426154959"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="426154959"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 14:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="857015458"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="857015458"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2023 14:43:35 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfpCA-000FgK-1p;
        Fri, 24 Mar 2023 21:43:34 +0000
Date:   Sat, 25 Mar 2023 05:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, will@kernel.org, dan.j.williams@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <202303250549.dFFcvnrK-lkp@intel.com>
References: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I love your patch! Yet something to improve:

[auto build test ERROR on acme/perf/core]
[also build test ERROR on tip/perf/core cxl/next cxl/pending linus/master v6.3-rc3 next-20230324]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
patch link:    https://lore.kernel.org/r/20230324171313.18448-5-Jonathan.Cameron%40huawei.com
patch subject: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
config: alpha-buildonly-randconfig-r006-20230322 (https://download.01.org/0day-ci/archive/20230325/202303250549.dFFcvnrK-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
        git checkout a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250549.dFFcvnrK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:653:34: note: in expansion of macro 'pmu_to_cpmu_info'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:653:56: error: 'struct perf_event' has no member named 'pmu'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:653:34: note: in expansion of macro 'pmu_to_cpmu_info'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:653:56: error: 'struct perf_event' has no member named 'pmu'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:653:34: note: in expansion of macro 'pmu_to_cpmu_info'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:653:34: note: in expansion of macro 'pmu_to_cpmu_info'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:654:43: error: 'struct perf_event' has no member named 'hw'
     654 |         struct hw_perf_event *hwc = &event->hw;
         |                                           ^~
   drivers/cxl/cpmu.c:658:45: error: 'struct hw_perf_event' has no member named 'prev_count'
     658 |                 prev_cnt = local64_read(&hwc->prev_count);
         |                                             ^~
   arch/alpha/include/asm/local.h:14:44: note: in definition of macro 'local_read'
      14 | #define local_read(l)   atomic_long_read(&(l)->a)
         |                                            ^
   drivers/cxl/cpmu.c:658:28: note: in expansion of macro 'local64_read'
     658 |                 prev_cnt = local64_read(&hwc->prev_count);
         |                            ^~~~~~~~~~~~
   In file included from include/linux/atomic.h:82,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11:
   drivers/cxl/cpmu.c:660:38: error: 'struct hw_perf_event' has no member named 'prev_count'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                                      ^~
   include/linux/atomic/atomic-instrumented.h:2049:16: note: in definition of macro 'cmpxchg_local'
    2049 |         typeof(ptr) __ai_ptr = (ptr); \
         |                ^~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:38: error: 'struct hw_perf_event' has no member named 'prev_count'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                                      ^~
   include/linux/atomic/atomic-instrumented.h:2049:33: note: in definition of macro 'cmpxchg_local'
    2049 |         typeof(ptr) __ai_ptr = (ptr); \
         |                                 ^~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
>> include/linux/atomic/atomic-instrumented.h:2050:50: error: invalid type argument of unary '*' (have 'int')
    2050 |         instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
         |                                                  ^~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
>> include/linux/atomic/atomic-instrumented.h:2050:33: warning: passing argument 1 of 'instrument_atomic_write' makes pointer from integer without a cast [-Wint-conversion]
    2050 |         instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
         |                                 ^~~~~~~~
         |                                 |
         |                                 int
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   In file included from include/linux/atomic/atomic-instrumented.h:22:
   include/linux/instrumented.h:85:74: note: expected 'const volatile void *' but argument is of type 'int'
      85 | static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
         |                                                     ~~~~~~~~~~~~~~~~~~~~~^
   In file included from arch/alpha/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7:
>> arch/alpha/include/asm/cmpxchg.h:22:20: error: invalid type argument of unary '*' (have 'int')
      22 |         __typeof__(*(ptr)) _o_ = (o);                                   \
         |                    ^~~~~~
   include/linux/atomic/atomic-instrumented.h:2051:9: note: in expansion of macro 'arch_cmpxchg_local'
    2051 |         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/cmpxchg.h:23:20: error: invalid type argument of unary '*' (have 'int')
      23 |         __typeof__(*(ptr)) _n_ = (n);                                   \
         |                    ^~~~~~
   include/linux/atomic/atomic-instrumented.h:2051:9: note: in expansion of macro 'arch_cmpxchg_local'
    2051 |         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/cmpxchg.h:24:21: error: invalid type argument of unary '*' (have 'int')
      24 |         (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_, \
         |                     ^~~~~~
   include/linux/atomic/atomic-instrumented.h:2051:9: note: in expansion of macro 'arch_cmpxchg_local'
    2051 |         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/cmpxchg.h:26:50: error: invalid type argument of unary '*' (have 'int')
      26 |                                           sizeof(*(ptr)));              \
         |                                                  ^~~~~~
   include/linux/atomic/atomic-instrumented.h:2051:9: note: in expansion of macro 'arch_cmpxchg_local'
    2051 |         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
>> arch/alpha/include/asm/cmpxchg.h:24:46: warning: passing argument 1 of '__cmpxchg_local' makes pointer from integer without a cast [-Wint-conversion]
      24 |         (__typeof__(*(ptr))) __cmpxchg_local((ptr), (unsigned long)_o_, \
         |                                              ^~~~~
         |                                              |
         |                                              int
   include/linux/atomic/atomic-instrumented.h:2051:9: note: in expansion of macro 'arch_cmpxchg_local'
    2051 |         arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
         |         ^~~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/local.h:56:10: note: in expansion of macro 'cmpxchg_local'
      56 |         (cmpxchg_local(&((l)->a.counter), (o), (n)))
         |          ^~~~~~~~~~~~~
   include/asm-generic/local64.h:45:34: note: in expansion of macro 'local_cmpxchg'
      45 | #define local64_cmpxchg(l, o, n) local_cmpxchg((&(l)->a), (o), (n))
         |                                  ^~~~~~~~~~~~~
   drivers/cxl/cpmu.c:660:18: note: in expansion of macro 'local64_cmpxchg'
     660 |         } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
         |                  ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/xchg.h:229:30: note: expected 'volatile void *' but argument is of type 'int'
     229 | ____cmpxchg(, volatile void *ptr, unsigned long old, unsigned long new,
         |               ~~~~~~~~~~~~~~~^~~
   arch/alpha/include/asm/cmpxchg.h:10:69: note: in definition of macro '____cmpxchg'
      10 | #define ____cmpxchg(type, args...)      __cmpxchg ## type ## _local(args)
         |                                                                     ^~~~
   drivers/cxl/cpmu.c:670:34: error: 'struct perf_event' has no member named 'count'
     670 |         local64_add(delta, &event->count);
         |                                  ^~
   arch/alpha/include/asm/local.h:18:48: note: in definition of macro 'local_add'
      18 | #define local_add(i,l)  atomic_long_add((i),(&(l)->a))
         |                                                ^
   drivers/cxl/cpmu.c:670:9: note: in expansion of macro 'local64_add'
     670 |         local64_add(delta, &event->count);
         |         ^~~~~~~~~~~
   drivers/cxl/cpmu.c: In function 'cpmu_event_stop':
   drivers/cxl/cpmu.c:680:56: error: 'struct perf_event' has no member named 'pmu'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:680:34: note: in expansion of macro 'pmu_to_cpmu_info'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:680:56: error: 'struct perf_event' has no member named 'pmu'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:680:34: note: in expansion of macro 'pmu_to_cpmu_info'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:680:56: error: 'struct perf_event' has no member named 'pmu'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:680:34: note: in expansion of macro 'pmu_to_cpmu_info'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/cxl/cpmu.c:82:32: note: in expansion of macro 'container_of'
      82 | #define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
         |                                ^~~~~~~~~~~~
   drivers/cxl/cpmu.c:680:34: note: in expansion of macro 'pmu_to_cpmu_info'
     680 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:682:43: error: 'struct perf_event' has no member named 'hw'
     682 |         struct hw_perf_event *hwc = &event->hw;
         |                                           ^~
   drivers/cxl/cpmu.c:686:25: error: 'struct hw_perf_event' has no member named 'state'
     686 |         WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);


vim +2050 include/linux/atomic/atomic-instrumented.h

0aa7be05d83cc5 include/linux/atomic/atomic-instrumented.h Uros Bizjak   2022-05-15  2046  
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland  2018-09-04  2047  #define cmpxchg_local(ptr, ...) \
b06ed71a624ba0 include/asm-generic/atomic-instrumented.h  Dmitry Vyukov 2018-01-29  2048  ({ \
df79ed2c064363 include/asm-generic/atomic-instrumented.h  Mark Rutland  2018-07-16  2049  	typeof(ptr) __ai_ptr = (ptr); \
ed8af2e4d2a71b include/asm-generic/atomic-instrumented.h  Marco Elver   2020-01-21 @2050  	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
aa525d063851a9 include/asm-generic/atomic-instrumented.h  Mark Rutland  2018-09-04  2051  	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__); \
b06ed71a624ba0 include/asm-generic/atomic-instrumented.h  Dmitry Vyukov 2018-01-29  2052  })
b06ed71a624ba0 include/asm-generic/atomic-instrumented.h  Dmitry Vyukov 2018-01-29  2053  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
