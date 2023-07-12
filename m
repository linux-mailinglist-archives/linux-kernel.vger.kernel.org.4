Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35C75028C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGLJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:10:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23643B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689153052; x=1720689052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p1OIKRT/YkkGQqHSoD1+RPI2nnaB7lUxGT9t/mmclBE=;
  b=gbh8e1Ep9cNlld187rqhXsQXiKFyO9GmwZ/H7FupvUQIxVqsOBaV/Vvv
   2OI6bzzG8nikd7KfQWVrOohljR3nPRYUr6UoTf+cbelvhLwQnsKnekYlt
   ccFyGhV8tDztUhj8dhfESiTmhYj9faJsPqyJPNB4nZt4HHcb/eUZMGE4S
   KZYPiHudjQfoY/rzkgVMTrXB86sahtyFV8YwxyezWssQ/BYEvB2XLOHx/
   g81q2YdRIitQxQ7eL0mF6/sH5SQYJTURuJzmD7yPZ9hocNKGr+ybY0kl3
   M1Xj9fGVKiPmafmrJyw/R3q/jCZBmGh1qE8juTYxYD0YxA7GNd6czE8Wl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362307687"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="362307687"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 02:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="1052091586"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="1052091586"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2023 02:10:48 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJVs0-0005ZN-0s;
        Wed, 12 Jul 2023 09:10:48 +0000
Date:   Wed, 12 Jul 2023 17:10:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: mm/madvise.c:1385:5: warning: stack frame size (2064) exceeds limit
 (2048) in 'do_madvise'
Message-ID: <202307121757.6jFBwr12-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
commit: 648321fa0d970c04b4327ac1a053abf43d285931 riscv: mm: try VMA lock-based page fault handling first
date:   3 weeks ago
config: riscv-randconfig-r023-20230712 (https://download.01.org/0day-ci/archive/20230712/202307121757.6jFBwr12-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20230712/202307121757.6jFBwr12-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307121757.6jFBwr12-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/madvise.c:1385:5: warning: stack frame size (2064) exceeds limit (2048) in 'do_madvise' [-Wframe-larger-than]
   int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
       ^
   1 warning generated.


vim +/do_madvise +1385 mm/madvise.c

9a10064f5625d5 Colin Cross        2022-01-14  1288  
9a10064f5625d5 Colin Cross        2022-01-14  1289  int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
5c26f6ac9416b6 Suren Baghdasaryan 2022-03-04  1290  			  unsigned long len_in, struct anon_vma_name *anon_name)
9a10064f5625d5 Colin Cross        2022-01-14  1291  {
9a10064f5625d5 Colin Cross        2022-01-14  1292  	unsigned long end;
9a10064f5625d5 Colin Cross        2022-01-14  1293  	unsigned long len;
9a10064f5625d5 Colin Cross        2022-01-14  1294  
9a10064f5625d5 Colin Cross        2022-01-14  1295  	if (start & ~PAGE_MASK)
9a10064f5625d5 Colin Cross        2022-01-14  1296  		return -EINVAL;
9a10064f5625d5 Colin Cross        2022-01-14  1297  	len = (len_in + ~PAGE_MASK) & PAGE_MASK;
9a10064f5625d5 Colin Cross        2022-01-14  1298  
9a10064f5625d5 Colin Cross        2022-01-14  1299  	/* Check to see whether len was rounded up from small -ve to zero */
9a10064f5625d5 Colin Cross        2022-01-14  1300  	if (len_in && !len)
9a10064f5625d5 Colin Cross        2022-01-14  1301  		return -EINVAL;
9a10064f5625d5 Colin Cross        2022-01-14  1302  
9a10064f5625d5 Colin Cross        2022-01-14  1303  	end = start + len;
9a10064f5625d5 Colin Cross        2022-01-14  1304  	if (end < start)
9a10064f5625d5 Colin Cross        2022-01-14  1305  		return -EINVAL;
9a10064f5625d5 Colin Cross        2022-01-14  1306  
9a10064f5625d5 Colin Cross        2022-01-14  1307  	if (end == start)
9a10064f5625d5 Colin Cross        2022-01-14  1308  		return 0;
9a10064f5625d5 Colin Cross        2022-01-14  1309  
5c26f6ac9416b6 Suren Baghdasaryan 2022-03-04  1310  	return madvise_walk_vmas(mm, start, end, (unsigned long)anon_name,
9a10064f5625d5 Colin Cross        2022-01-14  1311  				 madvise_vma_anon_name);
9a10064f5625d5 Colin Cross        2022-01-14  1312  }
9a10064f5625d5 Colin Cross        2022-01-14  1313  #endif /* CONFIG_ANON_VMA_NAME */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1314  /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  1315   * The madvise(2) system call.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1316   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  1317   * Applications can use madvise() to advise the kernel how it should
^1da177e4c3f41 Linus Torvalds     2005-04-16  1318   * handle paging I/O in this VM area.  The idea is to help the kernel
^1da177e4c3f41 Linus Torvalds     2005-04-16  1319   * use appropriate read-ahead and caching techniques.  The information
^1da177e4c3f41 Linus Torvalds     2005-04-16  1320   * provided is advisory only, and can be safely disregarded by the
^1da177e4c3f41 Linus Torvalds     2005-04-16  1321   * kernel without affecting the correct operation of the application.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1322   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  1323   * behavior values:
^1da177e4c3f41 Linus Torvalds     2005-04-16  1324   *  MADV_NORMAL - the default behavior is to read clusters.  This
^1da177e4c3f41 Linus Torvalds     2005-04-16  1325   *		results in some read-ahead and read-behind.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1326   *  MADV_RANDOM - the system should read the minimum amount of data
^1da177e4c3f41 Linus Torvalds     2005-04-16  1327   *		on any access, since it is unlikely that the appli-
^1da177e4c3f41 Linus Torvalds     2005-04-16  1328   *		cation will need more than what it asks for.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1329   *  MADV_SEQUENTIAL - pages in the given range will probably be accessed
^1da177e4c3f41 Linus Torvalds     2005-04-16  1330   *		once, so they can be aggressively read ahead, and
^1da177e4c3f41 Linus Torvalds     2005-04-16  1331   *		can be freed soon after they are accessed.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1332   *  MADV_WILLNEED - the application is notifying the system to read
^1da177e4c3f41 Linus Torvalds     2005-04-16  1333   *		some pages ahead.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1334   *  MADV_DONTNEED - the application is finished with the given range,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1335   *		so the kernel can free resources associated with it.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1336   *  MADV_FREE - the application marks pages in the given range as lazy free,
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1337   *		where actual purges are postponed until memory pressure happens.
f6b3ec238d12c8 Badari Pulavarty   2006-01-06  1338   *  MADV_REMOVE - the application wants to free up the given range of
f6b3ec238d12c8 Badari Pulavarty   2006-01-06  1339   *		pages and associated backing store.
3866ea90d3635d Hugh Dickins       2009-09-21  1340   *  MADV_DONTFORK - omit this area from child's address space when forking:
3866ea90d3635d Hugh Dickins       2009-09-21  1341   *		typically, to avoid COWing pages pinned by get_user_pages().
3866ea90d3635d Hugh Dickins       2009-09-21  1342   *  MADV_DOFORK - cancel MADV_DONTFORK: no longer omit this area when forking.
c02c3009325418 Yang Shi           2017-10-13  1343   *  MADV_WIPEONFORK - present the child process with zero-filled memory in this
c02c3009325418 Yang Shi           2017-10-13  1344   *              range after a fork.
c02c3009325418 Yang Shi           2017-10-13  1345   *  MADV_KEEPONFORK - undo the effect of MADV_WIPEONFORK
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1346   *  MADV_HWPOISON - trigger memory error handler as if the given memory range
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1347   *		were corrupted by unrecoverable hardware memory failure.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1348   *  MADV_SOFT_OFFLINE - try to soft-offline the given range of memory.
f8af4da3b4c14e Hugh Dickins       2009-09-21  1349   *  MADV_MERGEABLE - the application recommends that KSM try to merge pages in
f8af4da3b4c14e Hugh Dickins       2009-09-21  1350   *		this area with pages of identical content from other such areas.
f8af4da3b4c14e Hugh Dickins       2009-09-21  1351   *  MADV_UNMERGEABLE- cancel MADV_MERGEABLE: no longer merge pages with others.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1352   *  MADV_HUGEPAGE - the application wants to back the given range by transparent
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1353   *		huge pages in the future. Existing pages might be coalesced and
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1354   *		new pages might be allocated as THP.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1355   *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1356   *		transparent huge pages so the existing pages will not be
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1357   *		coalesced into THP and new pages will not be allocated as THP.
7d8faaf155454f Zach O'Keefe       2022-07-06  1358   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1359   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1360   *		from being included in its core dump.
d7206a70af5c09 Naoya Horiguchi    2016-03-15  1361   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
ecb8ac8b1f1469 Minchan Kim        2020-10-17  1362   *  MADV_COLD - the application is not expected to use this memory soon,
ecb8ac8b1f1469 Minchan Kim        2020-10-17  1363   *		deactivate pages in this range so that they can be reclaimed
f0953a1bbaca71 Ingo Molnar        2021-05-06  1364   *		easily if memory pressure happens.
ecb8ac8b1f1469 Minchan Kim        2020-10-17  1365   *  MADV_PAGEOUT - the application is not expected to use this memory soon,
ecb8ac8b1f1469 Minchan Kim        2020-10-17  1366   *		page out the pages in this range immediately.
4ca9b3859dac14 David Hildenbrand  2021-06-30  1367   *  MADV_POPULATE_READ - populate (prefault) page tables readable by
4ca9b3859dac14 David Hildenbrand  2021-06-30  1368   *		triggering read faults if required
4ca9b3859dac14 David Hildenbrand  2021-06-30  1369   *  MADV_POPULATE_WRITE - populate (prefault) page tables writable by
4ca9b3859dac14 David Hildenbrand  2021-06-30  1370   *		triggering write faults if required
^1da177e4c3f41 Linus Torvalds     2005-04-16  1371   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  1372   * return values:
^1da177e4c3f41 Linus Torvalds     2005-04-16  1373   *  zero    - success
^1da177e4c3f41 Linus Torvalds     2005-04-16  1374   *  -EINVAL - start + len < 0, start is not page-aligned,
^1da177e4c3f41 Linus Torvalds     2005-04-16  1375   *		"behavior" is not a valid value, or application
c02c3009325418 Yang Shi           2017-10-13  1376   *		is attempting to release locked or shared pages,
c02c3009325418 Yang Shi           2017-10-13  1377   *		or the specified address range includes file, Huge TLB,
c02c3009325418 Yang Shi           2017-10-13  1378   *		MAP_SHARED or VMPFNMAP range.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1379   *  -ENOMEM - addresses in the specified range are not currently
^1da177e4c3f41 Linus Torvalds     2005-04-16  1380   *		mapped, or are outside the AS of the process.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1381   *  -EIO    - an I/O error occurred while paging in data.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1382   *  -EBADF  - map exists, but area maps something that isn't a file.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1383   *  -EAGAIN - a kernel resource was temporarily unavailable.
^1da177e4c3f41 Linus Torvalds     2005-04-16  1384   */
0726b01e70455f Minchan Kim        2020-10-17 @1385  int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior)
^1da177e4c3f41 Linus Torvalds     2005-04-16  1386  {
ac1e9acc5acf0b Colin Cross        2022-01-14  1387  	unsigned long end;
ac1e9acc5acf0b Colin Cross        2022-01-14  1388  	int error;
f7977793240d83 Jason Baron        2007-07-15  1389  	int write;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1390  	size_t len;
1998cc04890110 Shaohua Li         2013-02-22  1391  	struct blk_plug plug;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1392  
75927af8bcb940 Nicholas Piggin    2009-06-16  1393  	if (!madvise_behavior_valid(behavior))
ac1e9acc5acf0b Colin Cross        2022-01-14  1394  		return -EINVAL;
75927af8bcb940 Nicholas Piggin    2009-06-16  1395  
df6c6500b4416b Wei Yang           2019-11-30  1396  	if (!PAGE_ALIGNED(start))
ac1e9acc5acf0b Colin Cross        2022-01-14  1397  		return -EINVAL;
df6c6500b4416b Wei Yang           2019-11-30  1398  	len = PAGE_ALIGN(len_in);
^1da177e4c3f41 Linus Torvalds     2005-04-16  1399  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1400  	/* Check to see whether len was rounded up from small -ve to zero */
^1da177e4c3f41 Linus Torvalds     2005-04-16  1401  	if (len_in && !len)
ac1e9acc5acf0b Colin Cross        2022-01-14  1402  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1403  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1404  	end = start + len;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1405  	if (end < start)
ac1e9acc5acf0b Colin Cross        2022-01-14  1406  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds     2005-04-16  1407  
^1da177e4c3f41 Linus Torvalds     2005-04-16  1408  	if (end == start)
ac1e9acc5acf0b Colin Cross        2022-01-14  1409  		return 0;
84d96d897671cf Rasmus Villemoes   2013-04-29  1410  

:::::: The code at line 1385 was first introduced by commit
:::::: 0726b01e70455f9900ab524117c7b520d197dc8c mm/madvise: pass mm to do_madvise

:::::: TO: Minchan Kim <minchan@kernel.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
