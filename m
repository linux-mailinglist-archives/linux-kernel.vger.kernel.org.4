Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6236D554B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjDCX46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCX45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:56:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568551BEF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680566216; x=1712102216;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iOZF2gUXcgkejuunu842XICJGYS5is/qQt593vfk5ZY=;
  b=XAatGB39kcrbYRGuAloWFYfUFS4TRWF/oonPnCFnBQ1PGvT9VDDZa0+u
   W6s7d0wLfMGWcdpacWbHXu9rabcShAic2payve5b7w71iMlM2qiyR78Mh
   hTfXU+dOTIhwWDQ8mA5HyBoZUSGWei7rxTtA3jSeWT9C3QSpohGOrMO7f
   b09Tm24AMDRx6t823mOJ+ktW6X6crIw9g+nz7JKR8GEmd8uApdZ3/gYbT
   7+uYzqohVOtvJz79UILqlsX4AeztDFuZ2CFmrmuYJoQa/xof+Ee4y1B0K
   S4gbpP/nusJZp4Yt0vWRo0o861C9tcKXk8VNHDVVITy+8b8jxsHyx/wat
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407105413"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="407105413"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 16:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="775406499"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="775406499"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2023 16:56:53 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjU2a-000Owx-0w;
        Mon, 03 Apr 2023 23:56:48 +0000
Date:   Tue, 4 Apr 2023 07:56:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:33:1: warning:
 no previous prototype for 'bpf_testmod_test_btf_type_tag_user_1'
Message-ID: <202304040710.NAEyrWKF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   148341f0a2f53b5e8808d093333d85170586a15d
commit: 696c39011538fe0124fcc0e81ebc44ff7f8623b4 selftests/bpf: add a selftest with __user tag
date:   1 year, 2 months ago
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=696c39011538fe0124fcc0e81ebc44ff7f8623b4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 696c39011538fe0124fcc0e81ebc44ff7f8623b4
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304040710.NAEyrWKF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:19:1: warning: no previous prototype for 'bpf_testmod_test_mod_kfunc' [-Wmissing-prototypes]
      19 | bpf_testmod_test_mod_kfunc(int i)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:33:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_user_1' [-Wmissing-prototypes]
      33 | bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:38:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_user_2' [-Wmissing-prototypes]
      38 | bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:42:14: warning: no previous prototype for 'bpf_testmod_loop_test' [-Wmissing-prototypes]
      42 | noinline int bpf_testmod_loop_test(int n)
         |              ^~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:54:30: warning: no previous prototype for 'bpf_testmod_return_ptr' [-Wmissing-prototypes]
      54 | __weak noinline struct file *bpf_testmod_return_ptr(int arg)
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:71:1: warning: no previous prototype for 'bpf_testmod_test_read' [-Wmissing-prototypes]
      71 | bpf_testmod_test_read(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:107:1: warning: no previous prototype for 'bpf_testmod_test_write' [-Wmissing-prototypes]
     107 | bpf_testmod_test_write(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.o: warning: objtool: bpf_testmod_return_ptr()+0x15: unreachable instruction


vim +/bpf_testmod_test_btf_type_tag_user_1 +33 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c

    17	
    18	noinline void
  > 19	bpf_testmod_test_mod_kfunc(int i)
    20	{
    21		*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
    22	}
    23	
    24	struct bpf_testmod_btf_type_tag_1 {
    25		int a;
    26	};
    27	
    28	struct bpf_testmod_btf_type_tag_2 {
    29		struct bpf_testmod_btf_type_tag_1 __user *p;
    30	};
    31	
    32	noinline int
  > 33	bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
    34		return arg->a;
    35	}
    36	
    37	noinline int
  > 38	bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
    39		return arg->p->a;
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
