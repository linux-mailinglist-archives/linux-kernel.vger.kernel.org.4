Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EC74CB50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjGJEkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGJEkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:40:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD73107
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688964013; x=1720500013;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UOUaiguCef64qsJv1iADJ0JKEdcapd14q4Yi/uTKdyo=;
  b=TdtecAWUbfa107c2x6BTxZNyVLBANSuzjCxW29Xeq2HePbGSuRcqfghh
   SwbnUOCy+AYR1xvRK/kj+8lMB86cWU7UOwuwW7mhy8bHR4G5SxsAfLL+t
   ZYsH22w0+QzEAWD1i7iLHumE59UHt24GkGPepZ24jsvaI28z/YuM6a9Ps
   QEjLqrL1VdOPPHimcb7FnrE1AHdLCNc7XoYOyuBz5+q2AJuUBNPr2WVxn
   Zcauq17FAd9U0EmufvNw81d29RvnVnIbLqQ7haVzSldZtsV0a2SIZnzee
   HWqiVuww/Wo2MUNOn9Z+jMdxJsSf8RxhREOllszjUkiqm5uM7Su7ZD1cC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="354112399"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="354112399"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 21:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834128656"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834128656"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2023 21:40:06 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qIigw-0003XE-13;
        Mon, 10 Jul 2023 04:40:06 +0000
Date:   Mon, 10 Jul 2023 12:39:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Subject: tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one
 of the .gitignore files
Message-ID: <202307101239.qYEDPWtZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
commit: b7a2d774c9c5a9a3228c6169ecf32f05b96609cf perf build: Add ability to build with a generated vmlinux.h
date:   2 weeks ago
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230710/202307101239.qYEDPWtZ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230710/202307101239.qYEDPWtZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307101239.qYEDPWtZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> tools/perf/util/bpf_skel/vmlinux/vmlinux.h: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/config: warning: ignored by one of the .gitignore files
   tools/testing/selftests/kvm/settings: warning: ignored by one of the .gitignore files

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
