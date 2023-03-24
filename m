Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DC6C8753
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjCXVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCXVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:12:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C0F1;
        Fri, 24 Mar 2023 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679692372; x=1711228372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8Di552rD3NqtmjVFlh6tpaZWLEpiUzoEowAZA87bU0=;
  b=cu72fw0wtFZCRsME8gKdO+5C/v/5Rz3LlxmnzgtTL0031e+K7mIc8FQ/
   aKdNoaKUo6boyO9oSavnkt/SoMlMmcDY/j56V8YTzYxg2gM76yTNAVE1E
   Y6KA90vgheCHWVRzgZZBbES2j1YO2gqJljGtVZHU08G9yAVOrHFTYOLvI
   yMjYSkhhP3jbfTrLn7LG0AV0Um3/7mbYt1oHzmrpKLtlx/25rBKWyJT/O
   BJfy137sv8tjd1umFSL6/+77ymJvA9lqffTz7OGwCyoQhbKoBN/H0hwf4
   TQptkFfa6XPQeB+B/kIHE5nfSYf8rXfj1U53Q2nI4G3wttZPiW8JEDAPC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="337390890"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="337390890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 14:12:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="676303012"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="676303012"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2023 14:12:39 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pfoi9-000FfG-11;
        Fri, 24 Mar 2023 21:12:33 +0000
Date:   Sat, 25 Mar 2023 05:12:01 +0800
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
Message-ID: <202303250523.JdddC4Ld-lkp@intel.com>
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
config: parisc-randconfig-r036-20230324 (https://download.01.org/0day-ci/archive/20230325/202303250523.JdddC4Ld-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-Add-function-to-count-regblocks-of-a-given-type/20230325-011827
        git checkout a04f0052a1fa10bda54569c8c7b3ab7fe60ca975
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/cxl/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303250523.JdddC4Ld-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/cxl/cpmu.c: In function 'cpmu_parse_caps':
   drivers/cxl/cpmu.c:101:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
     101 |         val = readq(base + CPMU_CAP_REG);
         |               ^~~~~
         |               readl
   In file included from <command-line>:
   drivers/cxl/cpmu.c: In function 'cpmu_config_get_mask':
>> drivers/cxl/cpmu.c:416:51: error: 'struct perf_event' has no member named 'attr'
     416 |         return FIELD_GET(GENMASK_ULL(31, 0), event->attr.config);
         |                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:416:16: note: in expansion of macro 'FIELD_GET'
     416 |         return FIELD_GET(GENMASK_ULL(31, 0), event->attr.config);
         |                ^~~~~~~~~
   In file included from drivers/cxl/cxl.h:8,
                    from drivers/cxl/cxlpci.h:6,
                    from drivers/cxl/cpmu.c:32:
>> drivers/cxl/cpmu.c:416:51: error: 'struct perf_event' has no member named 'attr'
     416 |         return FIELD_GET(GENMASK_ULL(31, 0), event->attr.config);
         |                                                   ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/cxl/cpmu.c: In function 'cpmu_config_get_gid':
   drivers/cxl/cpmu.c:421:52: error: 'struct perf_event' has no member named 'attr'
     421 |         return FIELD_GET(GENMASK_ULL(47, 32), event->attr.config);
         |                                                    ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:421:16: note: in expansion of macro 'FIELD_GET'
     421 |         return FIELD_GET(GENMASK_ULL(47, 32), event->attr.config);
         |                ^~~~~~~~~
   drivers/cxl/cpmu.c:421:52: error: 'struct perf_event' has no member named 'attr'
     421 |         return FIELD_GET(GENMASK_ULL(47, 32), event->attr.config);
         |                                                    ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/cxl/cpmu.c: In function 'cpmu_config_get_vid':
   drivers/cxl/cpmu.c:426:52: error: 'struct perf_event' has no member named 'attr'
     426 |         return FIELD_GET(GENMASK_ULL(63, 48), event->attr.config);
         |                                                    ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:426:16: note: in expansion of macro 'FIELD_GET'
     426 |         return FIELD_GET(GENMASK_ULL(63, 48), event->attr.config);
         |                ^~~~~~~~~
   drivers/cxl/cpmu.c:426:52: error: 'struct perf_event' has no member named 'attr'
     426 |         return FIELD_GET(GENMASK_ULL(63, 48), event->attr.config);
         |                                                    ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/cxl/cpmu.c: In function 'cpmu_config1_get_threshold':
   drivers/cxl/cpmu.c:431:51: error: 'struct perf_event' has no member named 'attr'
     431 |         return FIELD_GET(GENMASK_ULL(15, 0), event->attr.config1);
         |                                                   ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:431:16: note: in expansion of macro 'FIELD_GET'
     431 |         return FIELD_GET(GENMASK_ULL(15, 0), event->attr.config1);
--
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:441:16: note: in expansion of macro 'FIELD_GET'
     441 |         return FIELD_GET(BIT(17), event->attr.config1);
         |                ^~~~~~~~~
   drivers/cxl/cpmu.c:441:40: error: 'struct perf_event' has no member named 'attr'
     441 |         return FIELD_GET(BIT(17), event->attr.config1);
         |                                        ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/cxl/cpmu.c: In function 'cpmu_config1_hdm_filter_en':
   drivers/cxl/cpmu.c:453:40: error: 'struct perf_event' has no member named 'attr'
     453 |         return FIELD_GET(BIT(14), event->attr.config1);
         |                                        ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:453:16: note: in expansion of macro 'FIELD_GET'
     453 |         return FIELD_GET(BIT(14), event->attr.config1);
         |                ^~~~~~~~~
   drivers/cxl/cpmu.c:453:40: error: 'struct perf_event' has no member named 'attr'
     453 |         return FIELD_GET(BIT(14), event->attr.config1);
         |                                        ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   drivers/cxl/cpmu.c: In function 'cpmu_config2_get_hdm_decoder':
   drivers/cxl/cpmu.c:458:47: error: 'struct perf_event' has no member named 'attr'
     458 |         return FIELD_GET(GENMASK(15, 0), event->attr.config2);
         |                                               ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:71:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      71 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:61:43: note: in expansion of macro '__unsigned_scalar_typeof'
      61 | #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))(x))
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:72:34: note: in expansion of macro '__bf_cast_unsigned'
      72 |                                  __bf_cast_unsigned(_reg, ~0ull),       \
         |                                  ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:154:17: note: in expansion of macro '__BF_FIELD_CHECK'
     154 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:458:16: note: in expansion of macro 'FIELD_GET'
     458 |         return FIELD_GET(GENMASK(15, 0), event->attr.config2);
         |                ^~~~~~~~~
   drivers/cxl/cpmu.c:458:47: error: 'struct perf_event' has no member named 'attr'
     458 |         return FIELD_GET(GENMASK(15, 0), event->attr.config2);
         |                                               ^~
   include/linux/bitfield.h:155:35: note: in definition of macro 'FIELD_GET'
     155 |                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
         |                                   ^~~~
   In file included from include/linux/kernel.h:21,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from drivers/cxl/cpmu.c:26:
   drivers/cxl/cpmu.c: In function 'cpmu_get_event_idx':
>> drivers/cxl/cpmu.c:489:56: error: 'struct perf_event' has no member named 'pmu'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:489:34: note: in expansion of macro 'pmu_to_cpmu_info'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:21,
                    from include/linux/bitops.h:6,
                    from drivers/cxl/cpmu.c:24:
>> drivers/cxl/cpmu.c:489:56: error: 'struct perf_event' has no member named 'pmu'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:489:34: note: in expansion of macro 'pmu_to_cpmu_info'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
>> drivers/cxl/cpmu.c:489:56: error: 'struct perf_event' has no member named 'pmu'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:489:34: note: in expansion of macro 'pmu_to_cpmu_info'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:489:34: note: in expansion of macro 'pmu_to_cpmu_info'
     489 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c: In function 'cpmu_event_init':
   drivers/cxl/cpmu.c:532:56: error: 'struct perf_event' has no member named 'pmu'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:532:34: note: in expansion of macro 'pmu_to_cpmu_info'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:532:56: error: 'struct perf_event' has no member named 'pmu'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:532:34: note: in expansion of macro 'pmu_to_cpmu_info'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:532:56: error: 'struct perf_event' has no member named 'pmu'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:532:34: note: in expansion of macro 'pmu_to_cpmu_info'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:532:34: note: in expansion of macro 'pmu_to_cpmu_info'
     532 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
>> drivers/cxl/cpmu.c:534:14: error: 'struct perf_event' has no member named 'cpu'
     534 |         event->cpu = info->on_cpu;
         |              ^~
   drivers/cxl/cpmu.c:536:18: error: 'struct perf_event' has no member named 'attr'
     536 |         if (event->attr.type != event->pmu->type)
         |                  ^~
   drivers/cxl/cpmu.c:536:38: error: 'struct perf_event' has no member named 'pmu'
     536 |         if (event->attr.type != event->pmu->type)
         |                                      ^~
>> drivers/cxl/cpmu.c:539:13: error: implicit declaration of function 'is_sampling_event' [-Werror=implicit-function-declaration]
     539 |         if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
         |             ^~~~~~~~~~~~~~~~~
>> drivers/cxl/cpmu.c:539:46: error: 'struct perf_event' has no member named 'attach_state'
     539 |         if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
         |                                              ^~
   drivers/cxl/cpmu.c: In function 'cpmu_pmu_enable':
   drivers/cxl/cpmu.c:559:17: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
     559 |                 writeq(0, base + CPMU_FREEZE_REG);
         |                 ^~~~~~
         |                 writel
   drivers/cxl/cpmu.c: In function 'cpmu_pmu_disable':
   include/linux/bits.h:35:18: warning: right shift count is negative [-Wshift-count-negative]
      35 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:37:38: note: in expansion of macro '__GENMASK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/cxl/cpmu.c:578:24: note: in expansion of macro 'GENMASK'
     578 |                 writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
         |                        ^~~~~~~
   drivers/cxl/cpmu.c: In function 'cpmu_event_start':
   drivers/cxl/cpmu.c:585:56: error: 'struct perf_event' has no member named 'pmu'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:585:34: note: in expansion of macro 'pmu_to_cpmu_info'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:585:56: error: 'struct perf_event' has no member named 'pmu'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:585:34: note: in expansion of macro 'pmu_to_cpmu_info'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:585:56: error: 'struct perf_event' has no member named 'pmu'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:585:34: note: in expansion of macro 'pmu_to_cpmu_info'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:585:34: note: in expansion of macro 'pmu_to_cpmu_info'
     585 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
>> drivers/cxl/cpmu.c:586:43: error: 'struct perf_event' has no member named 'hw'
     586 |         struct hw_perf_event *hwc = &event->hw;
         |                                           ^~
   In file included from arch/parisc/include/asm/bug.h:93:
>> drivers/cxl/cpmu.c:590:31: error: 'struct hw_perf_event' has no member named 'state'
     590 |         if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
         |                               ^~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
>> drivers/cxl/cpmu.c:590:41: error: 'PERF_HES_STOPPED' undeclared (first use in this function)
     590 |         if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
         |                                         ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   drivers/cxl/cpmu.c:590:41: note: each undeclared identifier is reported only once for each function it appears in
     590 |         if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
         |                                         ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   drivers/cxl/cpmu.c:593:27: error: 'struct hw_perf_event' has no member named 'state'
     593 |         WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
         |                           ^~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
>> drivers/cxl/cpmu.c:593:37: error: 'PERF_HES_UPTODATE' undeclared (first use in this function); did you mean 'PERF_EF_UPDATE'?
     593 |         WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
         |                                     ^~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:110:32: note: in definition of macro 'WARN_ON_ONCE'
     110 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   drivers/cxl/cpmu.c:594:12: error: 'struct hw_perf_event' has no member named 'state'
     594 |         hwc->state = 0;
         |            ^~
   In file included from drivers/cxl/cpmu.c:31:
>> drivers/cxl/cpmu.c:605:59: error: 'struct hw_perf_event' has no member named 'idx'
     605 |                 writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
         |                                                           ^~
   drivers/cxl/cpmu.h:43:62: note: in definition of macro 'CPMU_FILTER_CFG_REG'
      43 | #define CPMU_FILTER_CFG_REG(n, f)       (0x400 + 4 * ((f) + (n) * 8))
         |                                                              ^
   drivers/cxl/cpmu.c:608:52: error: 'struct hw_perf_event' has no member named 'idx'
     608 |         cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
         |                                                    ^~
   drivers/cxl/cpmu.h:29:55: note: in definition of macro 'CPMU_COUNTER_CFG_REG'
      29 | #define CPMU_COUNTER_CFG_REG(n)         (0x200 + 8 * (n))
         |                                                       ^
   drivers/cxl/cpmu.c:615:25: error: 'struct hw_perf_event' has no member named 'idx'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |                         ^~
   include/linux/bitops.h:49:32: note: in definition of macro 'bitop'
      49 |         ((__builtin_constant_p(nr) &&                                   \
         |                                ^~
   drivers/cxl/cpmu.c:615:13: note: in expansion of macro 'test_bit'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |             ^~~~~~~~
   drivers/cxl/cpmu.c:615:25: error: 'struct hw_perf_event' has no member named 'idx'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |                         ^~
   include/linux/bitops.h:53:20: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                    ^~
   drivers/cxl/cpmu.c:615:13: note: in expansion of macro 'test_bit'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |             ^~~~~~~~
   drivers/cxl/cpmu.c:615:25: error: 'struct hw_perf_event' has no member named 'idx'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |                         ^~
   include/linux/bitops.h:53:35: note: in definition of macro 'bitop'
      53 |          const##op(nr, addr) : op(nr, addr))
         |                                   ^~
   drivers/cxl/cpmu.c:615:13: note: in expansion of macro 'test_bit'
     615 |         if (test_bit(hwc->idx, info->conf_counter_bm)) {
         |             ^~~~~~~~
>> drivers/cxl/cpmu.c:616:77: error: 'struct hw_perf_event' has no member named 'event_base'
     616 |                 cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
         |                                                                             ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:616:24: note: in expansion of macro 'FIELD_PREP'
     616 |                 cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
         |                        ^~~~~~~~~~
>> drivers/cxl/cpmu.c:616:77: error: 'struct hw_perf_event' has no member named 'event_base'
     616 |                 cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
         |                                                                             ^~
   include/linux/compiler_types.h:377:23: note: in definition of macro '__compiletime_assert'
     377 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
     114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:616:24: note: in expansion of macro 'FIELD_PREP'
     616 |                 cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
         |                        ^~~~~~~~~~
>> drivers/cxl/cpmu.c:616:77: error: 'struct hw_perf_event' has no member named 'event_base'
     616 |                 cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
         |                                                                             ^~
   include/linux/bitfield.h:115:34: note: in definition of macro 'FIELD_PREP'
     115 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                  ^~~~
   drivers/cxl/cpmu.c:630:52: error: 'struct hw_perf_event' has no member named 'idx'
     630 |         writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
         |                                                    ^~
   drivers/cxl/cpmu.h:29:55: note: in definition of macro 'CPMU_COUNTER_CFG_REG'
      29 | #define CPMU_COUNTER_CFG_REG(n)         (0x200 + 8 * (n))
         |                                                       ^
>> drivers/cxl/cpmu.c:632:9: error: implicit declaration of function 'local64_set'; did you mean 'local_set'? [-Werror=implicit-function-declaration]
     632 |         local64_set(&hwc->prev_count, 0);
         |         ^~~~~~~~~~~
         |         local_set
>> drivers/cxl/cpmu.c:632:25: error: 'struct hw_perf_event' has no member named 'prev_count'
     632 |         local64_set(&hwc->prev_count, 0);
         |                         ^~
   drivers/cxl/cpmu.c:633:46: error: 'struct hw_perf_event' has no member named 'idx'
     633 |         writeq(0, base + CPMU_COUNTER_REG(hwc->idx));
         |                                              ^~
   drivers/cxl/cpmu.h:46:63: note: in definition of macro 'CPMU_COUNTER_REG'
      46 | #define CPMU_COUNTER_REG(n)                     (0xc00 + 8 * (n))
         |                                                               ^
>> drivers/cxl/cpmu.c:636:28: error: implicit declaration of function 'local64_read'; did you mean 'local_read'? [-Werror=implicit-function-declaration]
     636 |                 prev_cnt = local64_read(&hwc->prev_count);
         |                            ^~~~~~~~~~~~
         |                            local_read
   drivers/cxl/cpmu.c:636:45: error: 'struct hw_perf_event' has no member named 'prev_count'
     636 |                 prev_cnt = local64_read(&hwc->prev_count);
         |                                             ^~
   drivers/cxl/cpmu.c:637:61: error: 'struct hw_perf_event' has no member named 'idx'
     637 |                 writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
         |                                                             ^~
   drivers/cxl/cpmu.h:46:63: note: in definition of macro 'CPMU_COUNTER_REG'
      46 | #define CPMU_COUNTER_REG(n)                     (0xc00 + 8 * (n))
         |                                                               ^
>> drivers/cxl/cpmu.c:640:9: error: implicit declaration of function 'perf_event_update_userpage'; did you mean 'arch_perf_update_userpage'? [-Werror=implicit-function-declaration]
     640 |         perf_event_update_userpage(event);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         arch_perf_update_userpage
   drivers/cxl/cpmu.c: In function 'cpmu_read_counter':
   drivers/cxl/cpmu.c:645:56: error: 'struct perf_event' has no member named 'pmu'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                                        ^~
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   drivers/cxl/cpmu.c:645:34: note: in expansion of macro 'pmu_to_cpmu_info'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:645:56: error: 'struct perf_event' has no member named 'pmu'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:645:34: note: in expansion of macro 'pmu_to_cpmu_info'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:645:56: error: 'struct perf_event' has no member named 'pmu'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:645:34: note: in expansion of macro 'pmu_to_cpmu_info'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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
   drivers/cxl/cpmu.c:645:34: note: in expansion of macro 'pmu_to_cpmu_info'
     645 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
         |                                  ^~~~~~~~~~~~~~~~
   drivers/cxl/cpmu.c:648:51: error: 'struct perf_event' has no member named 'hw'
     648 |         return readq(base + CPMU_COUNTER_REG(event->hw.idx));
         |                                                   ^~
   drivers/cxl/cpmu.h:46:63: note: in definition of macro 'CPMU_COUNTER_REG'
      46 | #define CPMU_COUNTER_REG(n)                     (0xc00 + 8 * (n))
         |                                                               ^
   drivers/cxl/cpmu.c: In function '__cpmu_read':
   drivers/cxl/cpmu.c:653:56: error: 'struct perf_event' has no member named 'pmu'
     653 |         struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
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


vim +416 drivers/cxl/cpmu.c

   413	
   414	static u32 cpmu_config_get_mask(struct perf_event *event)
   415	{
 > 416		return FIELD_GET(GENMASK_ULL(31, 0), event->attr.config);
   417	}
   418	
   419	static u16 cpmu_config_get_gid(struct perf_event *event)
   420	{
   421		return FIELD_GET(GENMASK_ULL(47, 32), event->attr.config);
   422	}
   423	
   424	static u16 cpmu_config_get_vid(struct perf_event *event)
   425	{
   426		return FIELD_GET(GENMASK_ULL(63, 48), event->attr.config);
   427	}
   428	
   429	static u8 cpmu_config1_get_threshold(struct perf_event *event)
   430	{
   431		return FIELD_GET(GENMASK_ULL(15, 0), event->attr.config1);
   432	}
   433	
   434	static bool cpmu_config1_get_invert(struct perf_event *event)
   435	{
   436		return FIELD_GET(BIT(16), event->attr.config1);
   437	}
   438	
   439	static bool cpmu_config1_get_edge(struct perf_event *event)
   440	{
   441		return FIELD_GET(BIT(17), event->attr.config1);
   442	}
   443	
   444	/*
   445	 * CPMU specification allows for 8 filters, each with a 16 bit value...
   446	 * So we need to find 8x16bits to store it in.
   447	 * As the value used for disable is 0xffff, a separate enable switch
   448	 * is needed.
   449	 */
   450	
   451	static bool cpmu_config1_hdm_filter_en(struct perf_event *event)
   452	{
   453		return FIELD_GET(BIT(14), event->attr.config1);
   454	}
   455	
   456	static u16 cpmu_config2_get_hdm_decoder(struct perf_event *event)
   457	{
   458		return FIELD_GET(GENMASK(15, 0), event->attr.config2);
   459	}
   460	
   461	static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
   462				    char *buf)
   463	{
   464		struct cpmu_info *info = dev_get_drvdata(dev);
   465	
   466		return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
   467	}
   468	static DEVICE_ATTR_RO(cpumask);
   469	
   470	static struct attribute *cpmu_cpumask_attrs[] = {
   471		&dev_attr_cpumask.attr,
   472		NULL
   473	};
   474	
   475	static const struct attribute_group cpmu_cpumask_group = {
   476		.attrs = cpmu_cpumask_attrs,
   477	};
   478	
   479	static const struct attribute_group *cpmu_attr_groups[] = {
   480		&cpmu_events,
   481		&cpmu_format_group,
   482		&cpmu_cpumask_group,
   483		NULL
   484	};
   485	
   486	/* If counter_idx == NULL, don't try to allocate a counter. */
   487	static int cpmu_get_event_idx(struct perf_event *event, int *counter_idx, int *event_idx)
   488	{
 > 489		struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
   490		DECLARE_BITMAP(configurable_and_free, CPMU_MAX_COUNTERS);
   491		struct cpmu_event *cpmu_ev;
   492		u32 mask;
   493		u16 gid, vid;
   494		int i;
   495	
   496		vid = cpmu_config_get_vid(event);
   497		gid = cpmu_config_get_gid(event);
   498		mask = cpmu_config_get_mask(event);
   499	
   500		cpmu_ev = cpmu_find_fixed_counter_event(info, vid, gid, mask);
   501		if (!IS_ERR(cpmu_ev)) {
   502			if (!counter_idx)
   503				return 0;
   504			if (!info->hw_events[cpmu_ev->counter_idx]) {
   505				*counter_idx = cpmu_ev->counter_idx;
   506				return 0;
   507			}
   508			/* Fixed counter is in use, but maybe a configurable one? */
   509		}
   510	
   511		cpmu_ev = cpmu_find_config_counter_event(info, vid, gid, mask);
   512		if (!IS_ERR(cpmu_ev)) {
   513			if (!counter_idx)
   514				return 0;
   515	
   516			bitmap_andnot(configurable_and_free, info->conf_counter_bm,
   517				info->used_counter_bm, CPMU_MAX_COUNTERS);
   518	
   519			i = find_first_bit(configurable_and_free, CPMU_MAX_COUNTERS);
   520			if (i == CPMU_MAX_COUNTERS)
   521				return -EINVAL;
   522	
   523			*counter_idx = i;
   524			return 0;
   525		}
   526	
   527		return -EINVAL;
   528	}
   529	
   530	static int cpmu_event_init(struct perf_event *event)
   531	{
   532		struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
   533	
 > 534		event->cpu = info->on_cpu;
   535		/* Top level type sanity check - is this a Hardware Event being requested */
   536		if (event->attr.type != event->pmu->type)
   537			return -ENOENT;
   538	
 > 539		if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
   540			return -EOPNOTSUPP;
   541		/* TODO: Validation of any filter */
   542	
   543		/*
   544		 * Verify that it is possible to count what was requested. Either must
   545		 * be a fixed counter that is a precise match or a configurable counter
   546		 * where this is a subset.
   547		 */
   548		return cpmu_get_event_idx(event, NULL, NULL);
   549	}
   550	
   551	static void cpmu_pmu_enable(struct pmu *pmu)
   552	{
   553		struct cpmu_info *info = pmu_to_cpmu_info(pmu);
   554		void __iomem *base = info->base;
   555	
   556		/* We don't have a global enable, but we 'might' have a global freeze which we can use */
   557		if (info->freeze_for_enable) {
   558			/* Can assume frozen at this stage */
   559			writeq(0, base + CPMU_FREEZE_REG);
   560	
   561			return;
   562		}
   563	}
   564	
   565	static void cpmu_pmu_disable(struct pmu *pmu)
   566	{
   567		struct cpmu_info *info = pmu_to_cpmu_info(pmu);
   568		void __iomem *base = info->base;
   569	
   570		if (info->freeze_for_enable) {
   571			/*
   572			 * Whilst bits above number of counters are RsvdZ
   573			 * they are unlikely to be repurposed given
   574			 * number of counters is allowed to be 64 leaving
   575			 * no reserved bits.  Hence this is only slightly
   576			 * naughty.
   577			 */
   578			writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
   579			return;
   580		}
   581	}
   582	
   583	static void cpmu_event_start(struct perf_event *event, int flags)
   584	{
   585		struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
 > 586		struct hw_perf_event *hwc = &event->hw;
   587		void __iomem *base = info->base;
   588		u64 cfg, prev_cnt;
   589	
 > 590		if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
   591			return;
   592	
 > 593		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
   594		hwc->state = 0;
   595	
   596		/*
   597		 * Currently only hdm filter control is implemnted, this code will
   598		 * want generalizing when more filters are added.
   599		 */
   600		if (info->filter_hdm) {
   601			if (cpmu_config1_hdm_filter_en(event))
   602				cfg = cpmu_config2_get_hdm_decoder(event);
   603			else
   604				cfg = GENMASK(15, 0);
 > 605			writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
   606		}
   607	
   608		cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
   609		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
   610		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1);
   611		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EDGE, cpmu_config1_get_edge(event) ? 1 : 0);
   612		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INVERT, cpmu_config1_get_invert(event) ? 1 : 0);
   613	
   614		/* Fixed purpose counters have next two fields RO */
   615		if (test_bit(hwc->idx, info->conf_counter_bm)) {
   616			cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
   617			cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENTS_MSK, cpmu_config_get_mask(event));
   618		}
   619		cfg &= ~CPMU_COUNTER_CFG_THRESHOLD_MSK;
   620		/*
   621		 * For events that generate only 1 count per clock the CXL 3.0 spec
   622		 * states the threshold shall be set to 1 but if set to 0 it will
   623		 * count the raw value anwyay?
   624		 * There is no definition of what events will count multiple per cycle
   625		 * and hence to which non 1 values of threshold can apply.
   626		 * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
   627		 */
   628		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_THRESHOLD_MSK,
   629				  cpmu_config1_get_threshold(event));
   630		writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
   631	
   632		local64_set(&hwc->prev_count, 0);
   633		writeq(0, base + CPMU_COUNTER_REG(hwc->idx));
   634	
   635		if (flags & PERF_EF_RELOAD) {
   636			prev_cnt = local64_read(&hwc->prev_count);
   637			writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
   638		}
   639	
   640		perf_event_update_userpage(event);
   641	}
   642	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
