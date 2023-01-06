Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668EA65F964
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAFCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAFCFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:05:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486475F86
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672970735; x=1704506735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6VMcYmNHJ/oZ4CfBUmGhmOWLs1SQJbQG9gauunFPGbY=;
  b=oJqeQOohnPJ/jjMQJyL1bnErfWr2tODvqcE2m1bTd1WslvTT797uwvSe
   ETR9NqpcEL/usduyQXaalz6/hlogQ40FTnFCRAeYc/7YgtWw5/OU4Z0N3
   mrUhXtUTDGuIspWSl0OvZVkS5siQWrVqHw21eSiiu2KseuXph3lExlC5P
   e4epjqZiAlFKTjh8K7ElmtOCQtztHE8fRYERGFmkdOJ7x9u85sOAdbM67
   On/n9OsVFD/bl7lfVDVkGmQi7VMp9wQnRni2XvymT8nguYUacV6/YQJNL
   sQPVmJtDqhO4jLybb4r/pOg7B2zXu/BozuIdLWCMh5sd3Kc/fQGj0NrHk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="310171319"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="310171319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 18:05:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="779834737"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="779834737"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Jan 2023 18:05:32 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pDc6t-0002q3-2M;
        Fri, 06 Jan 2023 02:05:31 +0000
Date:   Fri, 6 Jan 2023 10:04:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: versioncheck: ./init/version-timestamp.c: 5 linux/version.h not
 needed.
Message-ID: <202301060933.Btw5f1Pl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f5abbd77e2c1787e74b7c2caffac97def78ba52
commit: 2df8220cc511326508ec4da2f43ef69311bdd7b9 kbuild: build init/built-in.a just once
date:   3 months ago
reproduce:
        make versioncheck

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-11 CC=gcc-11 -j16 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/scsi/cxgbi/libcxgbi.h: 27 linux/version.h not needed.
   ./drivers/scsi/mpi3mr/mpi3mr.h: 32 linux/version.h not needed.
   ./drivers/scsi/qedi/qedi_dbg.h: 14 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
>> ./init/version-timestamp.c: 5 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 301: need linux/version.h
   ./tools/perf/include/bpf/bpf.h: 70: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 60: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 47: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
