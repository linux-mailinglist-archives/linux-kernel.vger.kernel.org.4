Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1196D57D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjDDE6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjDDE6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:58:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1999710D9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 21:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680584294; x=1712120294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gYaPq0XDNja7Mbj6D/dkzEKJhUaad1UVnFibHQ0xd1k=;
  b=lAUhQ4UtuLM31U5X+GlIAnXvG24cDAFvcQNbWkcEYw8tr8p7+/EbbQ02
   l8V9s2im1yW8zWK9lpgO4UCqWxAOhpfMK+XOtQjN1uK3FHVAyed+vj58E
   dHluVsQGSYMR9xy6H/lBLPQJml+BebjLP76hMO8EDHV9DrJvtr4nJnAzD
   SiefWKWgxla6T2XlZ1+hmPQL29w/VZ28OHXtMC5fNZmWyQL/okmlLkUSe
   k7YAM6gPeFgWiq19EcPFO4YxijqU5rQu1LWhMK51vXirKo17IJ6/Vbkqw
   cVeHydnexUc4U2pJdFLZq/iPD2eMl4hd0aIlKqt5qpTOyz1k/V4ThuD44
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="407148663"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="407148663"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 21:58:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688752631"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="688752631"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Apr 2023 21:58:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjYk8-000PCs-0r;
        Tue, 04 Apr 2023 04:58:04 +0000
Date:   Tue, 4 Apr 2023 12:57:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Luo <haoluo@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:54:1: warning:
 no previous prototype for 'bpf_testmod_test_btf_type_tag_percpu_1'
Message-ID: <202304041254.hj58GxCB-lkp@intel.com>
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
commit: 50c6b8a9aea2b8dc6c4ffb0cc502b94f7f57a0dc selftests/bpf: Add a test for btf_type_tag "percpu"
date:   1 year, 1 month ago
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50c6b8a9aea2b8dc6c4ffb0cc502b94f7f57a0dc
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 50c6b8a9aea2b8dc6c4ffb0cc502b94f7f57a0dc
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304041254.hj58GxCB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:23:1: warning: no previous prototype for 'bpf_testmod_test_mod_kfunc' [-Wmissing-prototypes]
      23 | bpf_testmod_test_mod_kfunc(int i)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:41:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_user_1' [-Wmissing-prototypes]
      41 | bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:49:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_user_2' [-Wmissing-prototypes]
      49 | bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:54:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_percpu_1' [-Wmissing-prototypes]
      54 | bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:59:1: warning: no previous prototype for 'bpf_testmod_test_btf_type_tag_percpu_2' [-Wmissing-prototypes]
      59 | bpf_testmod_test_btf_type_tag_percpu_2(struct bpf_testmod_btf_type_tag_3 *arg) {
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:63:14: warning: no previous prototype for 'bpf_testmod_loop_test' [-Wmissing-prototypes]
      63 | noinline int bpf_testmod_loop_test(int n)
         |              ^~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:75:30: warning: no previous prototype for 'bpf_testmod_return_ptr' [-Wmissing-prototypes]
      75 | __weak noinline struct file *bpf_testmod_return_ptr(int arg)
         |                              ^~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:92:1: warning: no previous prototype for 'bpf_testmod_test_read' [-Wmissing-prototypes]
      92 | bpf_testmod_test_read(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:128:1: warning: no previous prototype for 'bpf_testmod_test_write' [-Wmissing-prototypes]
     128 | bpf_testmod_test_write(struct file *file, struct kobject *kobj,
         | ^~~~~~~~~~~~~~~~~~~~~~
   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.o: warning: objtool: bpf_testmod_return_ptr()+0x15: unreachable instruction


vim +/bpf_testmod_test_btf_type_tag_percpu_1 +54 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c

    21	
    22	noinline void
  > 23	bpf_testmod_test_mod_kfunc(int i)
    24	{
    25		*(int *)this_cpu_ptr(&bpf_testmod_ksym_percpu) = i;
    26	}
    27	
    28	struct bpf_testmod_btf_type_tag_1 {
    29		int a;
    30	};
    31	
    32	struct bpf_testmod_btf_type_tag_2 {
    33		struct bpf_testmod_btf_type_tag_1 __user *p;
    34	};
    35	
    36	struct bpf_testmod_btf_type_tag_3 {
    37		struct bpf_testmod_btf_type_tag_1 __percpu *p;
    38	};
    39	
    40	noinline int
  > 41	bpf_testmod_test_btf_type_tag_user_1(struct bpf_testmod_btf_type_tag_1 __user *arg) {
    42		BTF_TYPE_EMIT(func_proto_typedef);
    43		BTF_TYPE_EMIT(func_proto_typedef_nested1);
    44		BTF_TYPE_EMIT(func_proto_typedef_nested2);
    45		return arg->a;
    46	}
    47	
    48	noinline int
    49	bpf_testmod_test_btf_type_tag_user_2(struct bpf_testmod_btf_type_tag_2 *arg) {
    50		return arg->p->a;
    51	}
    52	
    53	noinline int
  > 54	bpf_testmod_test_btf_type_tag_percpu_1(struct bpf_testmod_btf_type_tag_1 __percpu *arg) {
    55		return arg->a;
    56	}
    57	
    58	noinline int
  > 59	bpf_testmod_test_btf_type_tag_percpu_2(struct bpf_testmod_btf_type_tag_3 *arg) {
    60		return arg->p->a;
    61	}
    62	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
