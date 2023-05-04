Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4686F6960
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjEDK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjEDK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:59:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0EAA3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683197965; x=1714733965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VSYZ2ksxXks/w+kQKfNn4JVfzzDRVgK2yjBTSXUbcZg=;
  b=eL5B1hugvnTXOspKrCtX12n6uhZ+f7MkDicRs9L5eoHUYilEsjyUaRMX
   TDXZdLmmBnuWHIiNHsQAPPlBO93v0jsC56KEYqYm/Zt0DAp6EsSP4iAlJ
   8BcMcIoZzIOeUjbZy3VYs5q+p1PYUMee7UssYE3cUKj0zCXHfCiSiEWcq
   +C04XTAI6IsJDkkT8hZQHHIFsKKIaWODh09bKnCbFih6JrTwP4JjxTDxY
   8MWxJnI46F6bsTDZnjT8pnKVVKUQZR5ZsySugwR7tFzkIGfLmLCpm0VoH
   C4SIa8hMRzL0wEFHA/C45IIeyAkekqPUm4/vBotTzztsJg9v1/u36kZx1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="328520634"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="328520634"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 03:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="821118289"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="821118289"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2023 03:58:22 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puWfG-0002rW-0C;
        Thu, 04 May 2023 10:58:22 +0000
Date:   Thu, 4 May 2023 18:58:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jon Derrick <jonathan.derrick@linux.dev>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: drivers/md/md-bitmap.c:242 __write_sb_page() warn: unsigned 'offset'
 is never less than zero.
Message-ID: <202305041858.yfdVDDZ4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1a5304fecee523060f26e2778d9d8e33c0562df3
commit: 10172f200b67aafcb9b8ce7d0575d713c1aafbb7 md: Fix types in sb writer
date:   3 weeks ago
config: nios2-randconfig-m031-20230503 (https://download.01.org/0day-ci/archive/20230504/202305041858.yfdVDDZ4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305041858.yfdVDDZ4-lkp@intel.com/

New smatch warnings:
drivers/md/md-bitmap.c:242 __write_sb_page() warn: unsigned 'offset' is never less than zero.

Old smatch warnings:
arch/nios2/include/asm/thread_info.h:62 current_thread_info() error: uninitialized symbol 'sp'.

vim +/offset +242 drivers/md/md-bitmap.c

b2d2c4ceaddc30 drivers/md/bitmap.c    NeilBrown        2008-09-01  211  
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  212  static int __write_sb_page(struct md_rdev *rdev, struct bitmap *bitmap,
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  213  			   struct page *page)
a654b9d8f851f4 drivers/md/bitmap.c    NeilBrown        2005-06-21  214  {
a6ff7e089c7fca drivers/md/bitmap.c    Jonathan Brassow 2011-01-14  215  	struct block_device *bdev;
fd01b88c75a718 drivers/md/bitmap.c    NeilBrown        2011-10-11  216  	struct mddev *mddev = bitmap->mddev;
1ec885cdd01a9a drivers/md/bitmap.c    NeilBrown        2012-05-22  217  	struct bitmap_storage *store = &bitmap->storage;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  218  	sector_t offset = mddev->bitmap_info.offset;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  219  	sector_t ps, sboff, doff;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  220  	unsigned int size = PAGE_SIZE;
a6ff7e089c7fca drivers/md/bitmap.c    Jonathan Brassow 2011-01-14  221  
a6ff7e089c7fca drivers/md/bitmap.c    Jonathan Brassow 2011-01-14  222  	bdev = (rdev->meta_bdev) ? rdev->meta_bdev : rdev->bdev;
9b1215c102d4b1 drivers/md/bitmap.c    NeilBrown        2012-05-22  223  	if (page->index == store->file_pages - 1) {
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  224  		unsigned int last_page_size = store->bytes & (PAGE_SIZE - 1);
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  225  
9b1215c102d4b1 drivers/md/bitmap.c    NeilBrown        2012-05-22  226  		if (last_page_size == 0)
9b1215c102d4b1 drivers/md/bitmap.c    NeilBrown        2012-05-22  227  			last_page_size = PAGE_SIZE;
9b1215c102d4b1 drivers/md/bitmap.c    NeilBrown        2012-05-22  228  		size = roundup(last_page_size,
a6ff7e089c7fca drivers/md/bitmap.c    Jonathan Brassow 2011-01-14  229  			       bdev_logical_block_size(bdev));
9b1215c102d4b1 drivers/md/bitmap.c    NeilBrown        2012-05-22  230  	}
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  231  
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  232  	ps = page->index * PAGE_SIZE / SECTOR_SIZE;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  233  	sboff = rdev->sb_start + offset;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  234  	doff = rdev->data_offset;
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  235  
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  236  	/* Just make sure we aren't corrupting data or metadata */
f6af949c567211 drivers/md/bitmap.c    NeilBrown        2009-12-14  237  	if (mddev->external) {
f6af949c567211 drivers/md/bitmap.c    NeilBrown        2009-12-14  238  		/* Bitmap could be anywhere. */
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  239  		if (sboff + ps > doff &&
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  240  		    sboff < (doff + mddev->dev_sectors + PAGE_SIZE / SECTOR_SIZE))
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  241  			return -EINVAL;
f6af949c567211 drivers/md/bitmap.c    NeilBrown        2009-12-14 @242  	} else if (offset < 0) {
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  243  		/* DATA  BITMAP METADATA  */
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  244  		if (offset + ps + size / SECTOR_SIZE > 0)
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  245  			/* bitmap runs in to metadata */
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  246  			return -EINVAL;
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  247  
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  248  		if (doff + mddev->dev_sectors > sboff)
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  249  			/* data runs in to bitmap */
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  250  			return -EINVAL;
0f420358e3a2ab drivers/md/bitmap.c    Andre Noll       2008-07-11  251  	} else if (rdev->sb_start < rdev->data_offset) {
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  252  		/* METADATA BITMAP DATA */
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  253  		if (sboff + ps + size / SECTOR_SIZE > doff)
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  254  			/* bitmap runs in to data */
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  255  			return -EINVAL;
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  256  	} else {
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  257  		/* DATA METADATA BITMAP - no problems */
f0d76d70bc77b9 drivers/md/bitmap.c    NeilBrown        2007-07-17  258  	}
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  259  
10172f200b67aa drivers/md/md-bitmap.c Jon Derrick      2023-02-24  260  	md_super_write(mddev, rdev, sboff + ps, (int) size, page);
328e17d8d9428b drivers/md/md-bitmap.c Jon Derrick      2023-02-24  261  	return 0;
ab6085c795a71b drivers/md/bitmap.c    NeilBrown        2007-05-23  262  }
a654b9d8f851f4 drivers/md/bitmap.c    NeilBrown        2005-06-21  263  

:::::: The code at line 242 was first introduced by commit
:::::: f6af949c5672115313cc3c976d85b0533f607d7e md: support bitmap offset appropriate for external-metadata arrays.

:::::: TO: NeilBrown <neilb@suse.de>
:::::: CC: NeilBrown <neilb@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
