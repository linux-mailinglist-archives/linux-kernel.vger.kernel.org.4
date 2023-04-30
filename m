Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D186F2749
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 03:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjD3BWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 21:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD3BWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 21:22:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1010CE
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682817740; x=1714353740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AVnF9VDeZvsLXWfvD8Al3C8iXctwwF+ZYTtsAfhNyf4=;
  b=XjD24Myfs4Hs2lMoknquZwEEmJ7zyIBLNxv6I2R8rMT1e5YhZhTYsdU8
   X1WemFA//uKJHR5gYoZwWjxgHQ8njgm9tcnNhQblqjsB02DXcdtUty/np
   /TNwqHTF4MlIkAlF7XDwXEwzWpHNtJBvzb14F6/CA3JlAxg4dC3MSbj/I
   YYMO033SxUKXyoDs/pDQG/g725q72RxAsIVHBda3RQdFGAzPQ5mK/wbE/
   E/fbrbd5tNHI3o0d+AWygies2pqfeDtbIkvswhno7DRiirvz1/wRhnuBA
   CSFGid5ZivNwMkaheM3d+esRtrRwbk/sTP5azKPR/AoA5mObtMuxIEVEH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="337082095"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="337082095"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2023 18:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10695"; a="725901477"
X-IronPort-AV: E=Sophos;i="5.99,238,1677571200"; 
   d="scan'208";a="725901477"
Received: from lkp-server01.sh.intel.com (HELO 5bad9d2b7fcb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2023 18:22:17 -0700
Received: from kbuild by 5bad9d2b7fcb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1psvlY-0001Rf-0m;
        Sun, 30 Apr 2023 01:22:16 +0000
Date:   Sun, 30 Apr 2023 09:21:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: fs/dax.c:1087:23: sparse: sparse: Using plain integer as NULL pointer
Message-ID: <202304300917.nn0VclKO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ae78a14516b9372e4c90a89ac21b259339a3a3a
commit: ff17b8df224b98e282ec39a9949a3672fa3dbe93 fsdax: introduce dax_iomap_cow_copy()
date:   10 months ago
config: s390-randconfig-s041-20230430 (https://download.01.org/0day-ci/archive/20230430/202304300917.nn0VclKO-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff17b8df224b98e282ec39a9949a3672fa3dbe93
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ff17b8df224b98e282ec39a9949a3672fa3dbe93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304300917.nn0VclKO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/dax.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/fs_dax.h):
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:10:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:10:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:10:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   include/trace/events/fs_dax.h:153:1: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long mask @@     got restricted vm_fault_t @@
   include/trace/events/fs_dax.h:153:1: sparse:     expected unsigned long mask
   include/trace/events/fs_dax.h:153:1: sparse:     got restricted vm_fault_t
   fs/dax.c:658:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long v @@     got restricted vm_fault_t @@
   fs/dax.c:658:39: sparse:     expected unsigned long v
   fs/dax.c:658:39: sparse:     got restricted vm_fault_t
   fs/dax.c:660:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long v @@     got restricted vm_fault_t @@
   fs/dax.c:660:39: sparse:     expected unsigned long v
   fs/dax.c:660:39: sparse:     got restricted vm_fault_t
   fs/dax.c:664:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long v @@     got restricted vm_fault_t @@
   fs/dax.c:664:31: sparse:     expected unsigned long v
   fs/dax.c:664:31: sparse:     got restricted vm_fault_t
>> fs/dax.c:1087:23: sparse: sparse: Using plain integer as NULL pointer
   fs/dax.c:1139:41: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int result @@     got restricted vm_fault_t [assigned] [usertype] ret @@
   fs/dax.c:1139:41: sparse:     expected int result
   fs/dax.c:1139:41: sparse:     got restricted vm_fault_t [assigned] [usertype] ret
   fs/dax.c:1580:46: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int result @@     got restricted vm_fault_t [usertype] ret @@
   fs/dax.c:1580:46: sparse:     expected int result
   fs/dax.c:1580:46: sparse:     got restricted vm_fault_t [usertype] ret
   fs/dax.c:1596:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [assigned] [usertype] ret @@     got unsigned long @@
   fs/dax.c:1596:21: sparse:     expected restricted vm_fault_t [assigned] [usertype] ret
   fs/dax.c:1596:21: sparse:     got unsigned long
   fs/dax.c:1637:51: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int result @@     got restricted vm_fault_t [assigned] [usertype] ret @@
   fs/dax.c:1637:51: sparse:     expected int result
   fs/dax.c:1637:51: sparse:     got restricted vm_fault_t [assigned] [usertype] ret
   fs/dax.c:1815:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int result @@     got restricted vm_fault_t @@
   fs/dax.c:1815:55: sparse:     expected int result
   fs/dax.c:1815:55: sparse:     got restricted vm_fault_t
   fs/dax.c:1830:58: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int result @@     got restricted vm_fault_t [assigned] [usertype] ret @@
   fs/dax.c:1830:58: sparse:     expected int result
   fs/dax.c:1830:58: sparse:     got restricted vm_fault_t [assigned] [usertype] ret
   fs/dax.c:257:13: sparse: sparse: context imbalance in 'wait_entry_unlocked' - unexpected unlock
   fs/dax.c:439:49: sparse: sparse: context imbalance in 'dax_lock_page' - different lock contexts for basic block
   fs/dax.c:506:17: sparse: sparse: context imbalance in 'dax_lock_mapping_entry' - different lock contexts for basic block
   fs/dax.c:930:9: sparse: sparse: context imbalance in 'dax_writeback_one' - unexpected unlock

vim +1087 fs/dax.c

  1064	
  1065	/**
  1066	 * dax_iomap_cow_copy - Copy the data from source to destination before write
  1067	 * @pos:	address to do copy from.
  1068	 * @length:	size of copy operation.
  1069	 * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
  1070	 * @srcmap:	iomap srcmap
  1071	 * @daddr:	destination address to copy to.
  1072	 *
  1073	 * This can be called from two places. Either during DAX write fault (page
  1074	 * aligned), to copy the length size data to daddr. Or, while doing normal DAX
  1075	 * write operation, dax_iomap_actor() might call this to do the copy of either
  1076	 * start or end unaligned address. In the latter case the rest of the copy of
  1077	 * aligned ranges is taken care by dax_iomap_actor() itself.
  1078	 */
  1079	static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
  1080			const struct iomap *srcmap, void *daddr)
  1081	{
  1082		loff_t head_off = pos & (align_size - 1);
  1083		size_t size = ALIGN(head_off + length, align_size);
  1084		loff_t end = pos + length;
  1085		loff_t pg_end = round_up(end, align_size);
  1086		bool copy_all = head_off == 0 && end == pg_end;
> 1087		void *saddr = 0;
  1088		int ret = 0;
  1089	
  1090		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
  1091		if (ret)
  1092			return ret;
  1093	
  1094		if (copy_all) {
  1095			ret = copy_mc_to_kernel(daddr, saddr, length);
  1096			return ret ? -EIO : 0;
  1097		}
  1098	
  1099		/* Copy the head part of the range */
  1100		if (head_off) {
  1101			ret = copy_mc_to_kernel(daddr, saddr, head_off);
  1102			if (ret)
  1103				return -EIO;
  1104		}
  1105	
  1106		/* Copy the tail part of the range */
  1107		if (end < pg_end) {
  1108			loff_t tail_off = head_off + length;
  1109			loff_t tail_len = pg_end - end;
  1110	
  1111			ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
  1112						tail_len);
  1113			if (ret)
  1114				return -EIO;
  1115		}
  1116		return 0;
  1117	}
  1118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
