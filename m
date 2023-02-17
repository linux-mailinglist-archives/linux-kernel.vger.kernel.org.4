Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F83B69A961
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBQKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjBQKt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:49:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AA537557
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676630951; x=1708166951;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sey8O/cojQWNf1kMjlI1CMOo9+Y+Gn8QT+XBg8FNFEE=;
  b=HIqjDVvoV2b4NcnWQ2Klvgjo8ytKexT8bwh8xYv9tb9LU0P5ojqJgT6u
   DqtA9G+RT8KguXJhWEzxRcXHGxfD0JN3TWdogb323LYZSaH7aRui7W3mW
   lyeL13IILdthjN8leWLdIAKIbO13+vTd9STehh8ofNlHVrEYzcRH7AvdR
   qk4sNVVpGQ2rd56wqSSVeGUO3CN/LqJVRdHyYmsk+U9ma82HgegZwzoth
   vmjzW/MQD//9+IZ/dUaLETFO+uHGhkUPV5G3rcRgD4VibHy8E342edoFQ
   DTXAYpcRnCNiq8m4af9kDqYByxAw7P9o/00Ecwk5/YwX3+cVk1f86eHD5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="312326998"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="312326998"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 02:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="702938287"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="702938287"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2023 02:49:07 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSyId-000BLJ-0j;
        Fri, 17 Feb 2023 10:49:07 +0000
Date:   Fri, 17 Feb 2023 18:48:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202302171814.thbj6Ykw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec35307e18ba8174e2a3f701956059f6a36f22fb
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   6 months ago
config: loongarch-randconfig-s033-20230217 (https://download.01.org/0day-ci/archive/20230217/202302171814.thbj6Ykw-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/perf/ net/mptcp/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171814.thbj6Ykw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/mptcp/options.c: note: in included file:
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
--
   net/mptcp/protocol.c: note: in included file:
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
   net/mptcp/protocol.c:3011:24: sparse: sparse: context imbalance in 'mptcp_sk_clone' - unexpected unlock
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *
>> net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/mptcp/protocol.h:547:9: sparse:     expected void *ptr
   net/mptcp/protocol.h:547:9: sparse:     got unsigned int [noderef] __percpu *

vim +547 net/mptcp/protocol.h

b19bc2945b40b9 Paolo Abeni 2021-01-20  540  
bcd97734318d1d Paolo Abeni 2021-11-19  541  static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
b19bc2945b40b9 Paolo Abeni 2021-01-20  542  {
b19bc2945b40b9 Paolo Abeni 2021-01-20  543  	struct mptcp_delegated_action *delegated;
b19bc2945b40b9 Paolo Abeni 2021-01-20  544  	bool schedule;
b19bc2945b40b9 Paolo Abeni 2021-01-20  545  
bcd97734318d1d Paolo Abeni 2021-11-19  546  	/* the caller held the subflow bh socket lock */
bcd97734318d1d Paolo Abeni 2021-11-19 @547  	lockdep_assert_in_softirq();
bcd97734318d1d Paolo Abeni 2021-11-19  548  
b19bc2945b40b9 Paolo Abeni 2021-01-20  549  	/* The implied barrier pairs with mptcp_subflow_delegated_done(), and
b19bc2945b40b9 Paolo Abeni 2021-01-20  550  	 * ensures the below list check sees list updates done prior to status
b19bc2945b40b9 Paolo Abeni 2021-01-20  551  	 * bit changes
b19bc2945b40b9 Paolo Abeni 2021-01-20  552  	 */
bcd97734318d1d Paolo Abeni 2021-11-19  553  	if (!test_and_set_bit(action, &subflow->delegated_status)) {
b19bc2945b40b9 Paolo Abeni 2021-01-20  554  		/* still on delegated list from previous scheduling */
b19bc2945b40b9 Paolo Abeni 2021-01-20  555  		if (!list_empty(&subflow->delegated_node))
b19bc2945b40b9 Paolo Abeni 2021-01-20  556  			return;
b19bc2945b40b9 Paolo Abeni 2021-01-20  557  
b19bc2945b40b9 Paolo Abeni 2021-01-20  558  		delegated = this_cpu_ptr(&mptcp_delegated_actions);
b19bc2945b40b9 Paolo Abeni 2021-01-20  559  		schedule = list_empty(&delegated->head);
b19bc2945b40b9 Paolo Abeni 2021-01-20  560  		list_add_tail(&subflow->delegated_node, &delegated->head);
b19bc2945b40b9 Paolo Abeni 2021-01-20  561  		sock_hold(mptcp_subflow_tcp_sock(subflow));
b19bc2945b40b9 Paolo Abeni 2021-01-20  562  		if (schedule)
b19bc2945b40b9 Paolo Abeni 2021-01-20  563  			napi_schedule(&delegated->napi);
b19bc2945b40b9 Paolo Abeni 2021-01-20  564  	}
b19bc2945b40b9 Paolo Abeni 2021-01-20  565  }
b19bc2945b40b9 Paolo Abeni 2021-01-20  566  

:::::: The code at line 547 was first introduced by commit
:::::: bcd97734318d1d87bb237dbc0a60c81237b0ac50 mptcp: use delegate action to schedule 3rd ack retrans

:::::: TO: Paolo Abeni <pabeni@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
