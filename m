Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216826D3A1B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDBT6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjDBT6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 15:58:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F6293CA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680465497; x=1712001497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eJdGunJV7QWtkK6oQDnpr255s9hWhpOpOirs10ueWcM=;
  b=YzwogKovRfWwGjIv9SCGMUOBac6Ph7vnsQFUyHyah9/BYq+UhPseUmaD
   nywDalpl0WhNpqdRX+/xjIIUw83x/K3+IdbHY29Gel63uWP22Jg4/kiY+
   +d724xC+j2ZINF3UifYifpHmwyCs8hfPu+2BstdRTLqXCkRv27ZsS/Uls
   Sjz5m7c8Ip5PHdxx1V8GZYpbfiIh3r7ug8eUPJ5WnPQRbNZCNS1sjVzQg
   3sgRXkLmKPlF/m8vMPyIuNUxnj3FxGU5tUmYNB+7LJ4g11yFpm1ypQkIz
   Kt8v8Fcg58wBbgxhqCSRskx9RdwIgYs6LJhxaPXHIZlgxlfpQprR8BUcT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="369566935"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="369566935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2023 12:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10668"; a="662971598"
X-IronPort-AV: E=Sophos;i="5.98,313,1673942400"; 
   d="scan'208";a="662971598"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2023 12:58:15 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pj3qA-000Ne5-2W;
        Sun, 02 Apr 2023 19:58:14 +0000
Date:   Mon, 3 Apr 2023 03:57:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/gpu/drm/tests/drm_buddy_test.c:431:7: warning: Local
 variable 'order' shadows outer variable [shadowVariable]
Message-ID: <202304030354.XjyAhCHl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00c7b5f4ddc5b346df62b757ec73f9357bb452af
commit: 932da861956ac425ba4e65f7696458f96d833883 drm: selftest: convert drm_buddy selftest to KUnit
date:   9 months ago
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 932da861956ac425ba4e65f7696458f96d833883
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304030354.XjyAhCHl-lkp@intel.com/

cppcheck warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tests/drm_buddy_test.c:431:7: warning: Local variable 'order' shadows outer variable [shadowVariable]
     int order, err;
         ^
   drivers/gpu/drm/tests/drm_buddy_test.c:410:7: note: Shadowed declaration
    int *order;
         ^
   drivers/gpu/drm/tests/drm_buddy_test.c:431:7: note: Shadow variable
     int order, err;
         ^

vim +/order +431 drivers/gpu/drm/tests/drm_buddy_test.c

   404	
   405	static void igt_buddy_alloc_smoke(struct kunit *test)
   406	{
   407		u64 mm_size, chunk_size, start = 0;
   408		unsigned long flags = 0;
   409		struct drm_buddy mm;
   410		int *order;
   411		int i;
   412	
   413		DRM_RND_STATE(prng, random_seed);
   414		IGT_TIMEOUT(end_time);
   415	
   416		igt_mm_config(&mm_size, &chunk_size);
   417	
   418		KUNIT_ASSERT_FALSE_MSG(test, drm_buddy_init(&mm, mm_size, chunk_size),
   419				       "buddy_init failed\n");
   420	
   421		order = drm_random_order(mm.max_order + 1, &prng);
   422		KUNIT_ASSERT_TRUE(test, order);
   423	
   424		for (i = 0; i <= mm.max_order; ++i) {
   425			struct drm_buddy_block *block;
   426			int max_order = order[i];
   427			bool timeout = false;
   428			LIST_HEAD(blocks);
   429			u64 total, size;
   430			LIST_HEAD(tmp);
 > 431			int order, err;
   432	
   433			KUNIT_ASSERT_FALSE_MSG(test, igt_check_mm(test, &mm),
   434					       "pre-mm check failed, abort\n");
   435	
   436			order = max_order;
   437			total = 0;
   438	
   439			do {
   440	retry:
   441				size = get_size(order, chunk_size);
   442				err = drm_buddy_alloc_blocks(&mm, start, mm_size, size, size, &tmp, flags);
   443				if (err) {
   444					if (err == -ENOMEM) {
   445						KUNIT_FAIL(test, "buddy_alloc hit -ENOMEM with order=%d\n",
   446							   order);
   447					} else {
   448						if (order--) {
   449							err = 0;
   450							goto retry;
   451						}
   452	
   453						KUNIT_FAIL(test, "buddy_alloc with order=%d failed\n",
   454							   order);
   455					}
   456	
   457					break;
   458				}
   459	
   460				block = list_first_entry_or_null(&tmp, struct drm_buddy_block, link);
   461				KUNIT_ASSERT_TRUE_MSG(test, block, "alloc_blocks has no blocks\n");
   462	
   463				list_move_tail(&block->link, &blocks);
   464				KUNIT_EXPECT_EQ_MSG(test, drm_buddy_block_order(block), order,
   465						    "buddy_alloc order mismatch\n");
   466	
   467				total += drm_buddy_block_size(&mm, block);
   468	
   469				if (__igt_timeout(end_time, NULL)) {
   470					timeout = true;
   471					break;
   472				}
   473			} while (total < mm.size);
   474	
   475			if (!err)
   476				err = igt_check_blocks(test, &mm, &blocks, total, false);
   477	
   478			drm_buddy_free_list(&mm, &blocks);
   479	
   480			if (!err) {
   481				KUNIT_EXPECT_FALSE_MSG(test, igt_check_mm(test, &mm),
   482						       "post-mm check failed\n");
   483			}
   484	
   485			if (err || timeout)
   486				break;
   487	
   488			cond_resched();
   489		}
   490	
   491		kfree(order);
   492		drm_buddy_fini(&mm);
   493	}
   494	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
