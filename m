Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7F71A032
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjFAOec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjFAOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:34:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37A1B0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685630064; x=1717166064;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVZHk094vji0+kgVJHCtjx1vJTvsyfjQSNPxk5yldL0=;
  b=LXIbl3swhZyPSQcWqAepeb8AUaOxnNFS5xwnd+rLpd6RM+5pWTHwwWul
   61xgMDsNVPQYfQQ+QvE8AkkoDMZhHKZi2YsV6kxSR7R7KbS4ghocKIaA6
   +1Rd9vmSfo/anow1o+9eqY6JkjhgWahOLRk1tAUufNzeB6gYrv7JhItvv
   DfsbZan23yYX0IF4KVN+Xn3TYRKhJw6Fe64BWWcn+/doroUcM07hjhv7O
   WzxPl6uY3zf1D4cgt4JjFFo9+YTdKRcTizKzyVKkuZJDURzhBuh4i0Xx6
   Xejg1v75uW9aiDl5OjbrK4LHykBSBxQdI/CSYv+1khk3FvfL+x6qy+y+5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="355585910"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="355585910"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 07:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="737123545"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="737123545"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2023 07:34:22 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4jNd-0002N4-1y;
        Thu, 01 Jun 2023 14:34:21 +0000
Date:   Thu, 1 Jun 2023 22:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: pmu-events/jevents.c:72:22: warning: no previous prototype for
 'convert'
Message-ID: <202306012020.E4oEWbWO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajol,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   929ed21dfdb6ee94391db51c9eedb63314ef6847
commit: 560ccbc4a52c567096023e0c6a9b920048e59017 perf jevents: Add support for parsing perchip/percore events
date:   2 years, 9 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=560ccbc4a52c567096023e0c6a9b920048e59017
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 560ccbc4a52c567096023e0c6a9b920048e59017
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306012020.E4oEWbWO-lkp@intel.com/

Note: functions only called from assembly code should be annotated with the asmlinkage attribute
All warnings (new ones prefixed by >>):

   Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
   Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs from latest version at 'include/uapi/linux/perf_event.h'
   Makefile.config:697: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
>> pmu-events/jevents.c:72:22: warning: no previous prototype for 'convert' [-Wmissing-prototypes]
      72 | enum aggr_mode_class convert(const char *aggr_mode)
         |                      ^~~~~~~
   In file included from sigchain.c:3:
   In function 'xrealloc',
       inlined from 'sigchain_push.isra' at sigchain.c:26:2:
   subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   In function 'xrealloc',
       inlined from 'sigchain_push' at sigchain.c:26:2,
       inlined from 'sigchain_push_common' at sigchain.c:53:2:
   subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:96: tools/perf/sigchain.o] Error 1
   make[6]: *** Waiting for unfinished jobs....
   In file included from help.c:12:
   In function 'xrealloc',
       inlined from 'add_cmdname' at help.c:24:2:
   subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      56 |                 ret = realloc(ptr, size);
         |                       ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
      58 |                         ret = realloc(ptr, 1);
         |                               ^~~~~~~~~~~~~~~
   subcmd-util.h:52:21: note: call to 'realloc' here
      52 |         void *ret = realloc(ptr, size);
         |                     ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
   make[6]: *** [tools/build/Makefile.build:96: tools/perf/help.o] Error 1
   make[5]: *** [Makefile:59: tools/perf/libsubcmd-in.o] Error 2
   make[4]: *** [Makefile.perf:811: tools/perf/libsubcmd.a] Error 2
   make[4]: *** Waiting for unfinished jobs....
     PERF_VERSION = 5.9.rc3.g560ccbc4a52c
   make[3]: *** [Makefile.perf:233: sub-make] Error 2
   make[2]: *** [Makefile:70: all] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
