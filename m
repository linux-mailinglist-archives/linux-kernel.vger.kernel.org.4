Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385E75B676A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIMFh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIMFhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:37:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C6B564C5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663047470; x=1694583470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BqvdjSStK0WbMYgG1QF/4YPV9mpJKHbEwmUKuzUmJDs=;
  b=VtEZWqx9OwOXF9+joVD3SvBbwIj+qTNJ3H91jlxKHNuYPoiloMdqLx2u
   8PYN5NwzAqhPq2a5M1mRu0DASkchMUpj2yWzsOGyZ98l2AEjZCtbQtbUn
   QYb5pcjpaZpFW1uQpH6MFD6aCpLdPWoDgDHtt/+gFkJgeaX7mFx/jq35X
   JFI+qOOaGJpJiSGrRDXWz/iultqb/Aut3PU4Jek1nawgFgvc+pQ7o7Suu
   73Ucd4zFWfd0jmlK+ARtg9LXc40cmpHtEZbNd6KzuvuN2auNlC5/OGYWH
   3XPsL2lkpMCgqFzUy4RfTKHbIvtlkaff9IH9IfCBQzvc5guPsbB45VP8q
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="359769013"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="359769013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:37:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="649525382"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Sep 2022 22:37:47 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXycF-0003GN-0k;
        Tue, 13 Sep 2022 05:37:47 +0000
Date:   Tue, 13 Sep 2022 13:37:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.19.y 437/3807] net/core/sock.c:1090: Error:
 unrecognized opcode `csrs sstatus,s10'
Message-ID: <202209131317.seWzh601-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   25c60543745dcb5c04cd98a6353ab78209c242cb
commit: 0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86 [437/3807] af_unix: fix races in sk_peer_pid and sk_peer_cred accesses
config: riscv-randconfig-c032-20220911 (https://download.01.org/0day-ci/archive/20220913/202209131317.seWzh601-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout 0512a9aede6e4417c4fa6e0042a7ca8bc7e06b86
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/include/asm/irqflags.h: Assembler messages:
   arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc a4,sstatus,2'
   arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1112: Error: unrecognized opcode `csrs sstatus,a3'
   net/core/sock.c:1112: Error: unrecognized opcode `csrc sstatus,a3'
   net/core/sock.c:1420: Error: unrecognized opcode `csrs sstatus,a3'
   net/core/sock.c:1420: Error: unrecognized opcode `csrc sstatus,a3'
   net/core/sock.c:610: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:610: Error: unrecognized opcode `csrc sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:1267: Error: unrecognized opcode `csrc sstatus,a4'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrs sstatus,s10'
>> net/core/sock.c:1090: Error: unrecognized opcode `csrc sstatus,s10'
   arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc a4,sstatus,2'
   arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,a4'
   arch/riscv/include/asm/irqflags.h:42: Error: unrecognized opcode `csrrc a4,sstatus,2'
   arch/riscv/include/asm/irqflags.h:60: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:673: Error: unrecognized opcode `csrs sstatus,a4'
   net/core/sock.c:673: Error: unrecognized opcode `csrc sstatus,a4'


vim +1090 net/core/sock.c

3f551f9436c05a Eric W. Biederman 2010-06-13  1083  
28b5ba2aa0f55d David Herrmann    2017-06-21  1084  static int groups_to_user(gid_t __user *dst, const struct group_info *src)
28b5ba2aa0f55d David Herrmann    2017-06-21  1085  {
28b5ba2aa0f55d David Herrmann    2017-06-21  1086  	struct user_namespace *user_ns = current_user_ns();
28b5ba2aa0f55d David Herrmann    2017-06-21  1087  	int i;
28b5ba2aa0f55d David Herrmann    2017-06-21  1088  
28b5ba2aa0f55d David Herrmann    2017-06-21  1089  	for (i = 0; i < src->ngroups; i++)
28b5ba2aa0f55d David Herrmann    2017-06-21 @1090  		if (put_user(from_kgid_munged(user_ns, src->gid[i]), dst + i))
28b5ba2aa0f55d David Herrmann    2017-06-21  1091  			return -EFAULT;
28b5ba2aa0f55d David Herrmann    2017-06-21  1092  
28b5ba2aa0f55d David Herrmann    2017-06-21  1093  	return 0;
28b5ba2aa0f55d David Herrmann    2017-06-21  1094  }
28b5ba2aa0f55d David Herrmann    2017-06-21  1095  

:::::: The code at line 1090 was first introduced by commit
:::::: 28b5ba2aa0f55d80adb2624564ed2b170c19519e net: introduce SO_PEERGROUPS getsockopt

:::::: TO: David Herrmann <dh.herrmann@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
