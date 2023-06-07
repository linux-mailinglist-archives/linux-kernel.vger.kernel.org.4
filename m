Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963A727089
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjFGVYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjFGVYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:24:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6411BDF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686173087; x=1717709087;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zZ2DePtd/5n2kWZ3K/sTR9MXXW3+/h2OU665VEqhTss=;
  b=lcrapp/rwqrs5I/b8/DHRm0FP2z1hqyHknrM7bc/Yp9vppYRWl74yfHK
   XCo8JNtAIOCG8GPvfspwHse9mZalOdl21HHz4n10oX2ar4p5vx/0WBRKc
   BCzldfgzBc1kwajnIJ2cnIpUXaGZbcVeebq/B34qf7sVnYM7qjvucx1DG
   x3IJ208Edxym/l4y6vI/vFnjY4suIJq4WAPb4OW/t9W3U/C8iYMJfdkcu
   /HPJxuRsguNCinrOctCVgXkWksx39J86HtoeI0CUgOu4Ka2XLCAULRV5O
   X9xeeLpd3PMG2o4XezD9NTEL1EHXKxkNMGlGzDV2J/0UDVISeSx1dycDW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360444614"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="360444614"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 14:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="774790166"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="774790166"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2023 14:24:45 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q70e5-0006w3-0I;
        Wed, 07 Jun 2023 21:24:45 +0000
Date:   Thu, 8 Jun 2023 05:24:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: make[5]: *** No rule to make target 'scripts/module.lds', needed by
 'tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko'.
Message-ID: <202306080543.EJWQZYkE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a27648c742104a833a01c54becc24429898d85bf
commit: 82880283d7fcd0a1d20964a56d6d1a5cc0df0713 objtool: Fix truncated string warning
date:   1 year, 4 months ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=82880283d7fcd0a1d20964a56d6d1a5cc0df0713
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 82880283d7fcd0a1d20964a56d6d1a5cc0df0713
        make W=1 O=/tmp/kselftest headers
        make W=1 O=/tmp/kselftest -C tools/testing/selftests
        make W=1 O=/tmp/kselftest -C tools/testing/selftests/bpf

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306080543.EJWQZYkE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:19:1: warning: no previous prototype for 'bpf_testmod_test_mod_kfunc' [-Wmissing-prototypes]
      19 | bpf_testmod_test_mod_kfunc(int i)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:24:14: warning: no previous prototype for 'bpf_testmod_loop_test' [-Wmissing-prototypes]
      24 | noinline int bpf_testmod_loop_test(int n)
         |              ^~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:36:30: warning: no previous prototype for 'bpf_testmod_return_ptr' [-Wmissing-prototypes]
      36 | __weak noinline struct file *bpf_testmod_return_ptr(int arg)
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:53:1: warning: no previous prototype for 'bpf_testmod_test_read' [-Wmissing-prototypes]
      53 | bpf_testmod_test_read(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:89:1: warning: no previous prototype for 'bpf_testmod_test_write' [-Wmissing-prototypes]
      89 | bpf_testmod_test_write(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~~
--
>> make[5]: *** No rule to make target 'scripts/module.lds', needed by 'tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.ko'.
   make[5]: Target '__modfinal' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
