Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1053C6D35B8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 08:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDBGH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 02:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDBGHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 02:07:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3120C3A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680415674; x=1711951674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cfWS3WWnocXx6FkYdCWQFfKAPgb+OY+jACBcbnjjei8=;
  b=GnI2lixSQTzBcrdG28DRuTjfYHb10iwPJaePNBfQ/0y4bF4JoQguefiV
   hxmPkNZOTI27pgTsNqfhw0L66vvKp77uJSLVbxHjFqe5w3rU0v4p5hPZj
   TNg3IKajXhMgHwZOIP5p7gZ7/WMfQpzqj06InPCKlhamL5EE6DJrVlb5W
   XGDxbn5Xyi+sXS9Yn12hucQwMLgGC/R7GS8X5iOBXIizFkKozZBZyfjGH
   TUhsobZTOhABPSPt9+s3x77+OAgW/p3Vvom9q6MZU9Ms5JLPKXfMua+qk
   abyVUt9+CUqMGVqSoRPG06sN0Zd4g94oO0OH/3N7/S9tXyYN1FZG2nvhB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="404460032"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="404460032"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 23:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="635733626"
X-IronPort-AV: E=Sophos;i="5.98,312,1673942400"; 
   d="scan'208";a="635733626"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2023 23:07:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piqsY-000NGn-2M;
        Sun, 02 Apr 2023 06:07:50 +0000
Date:   Sun, 2 Apr 2023 14:07:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: net/mptcp/protocol.h:547:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202304021442.5n1kM7dz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   8 months ago
config: loongarch-randconfig-s042-20230402 (https://download.01.org/0day-ci/archive/20230402/202304021442.5n1kM7dz-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304021442.5n1kM7dz-lkp@intel.com/

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
