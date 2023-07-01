Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34EC744896
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjGAK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGAK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:59:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FD73ABD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688209153; x=1719745153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9gSBtOdBbL5EszgpLqy6s7dTPkpfEsMtL/0Y2VVsd5Y=;
  b=UcKwzwlmFz+f8thQypPDdbSNI7EtfvL2/djEtQZR8fB9reFxD3kwSjzK
   E3w9s8OqMXTxwkMBM7vh/TlT+0U3wvS+60Q6MWW9vfxbsoNmeoPucqw0/
   YlOMSZ1tJIrzjisKmRqcIfXieFX6/jOAzIBgW3FfWmTKmSVHVpF//M5MO
   FlkfY38TOZXGmui64n5JxmC75I4knPf1sWcIF99zHTFRu1lcDdydV0LJm
   JxwLx03IU3XV6aujA4i/nTJdgGdQKTC06v4mjF2iW7VZOg9h7OeQDBNak
   JdbLAO4xT7Nkp37ryTNMbyijJQl8Lf2voXepWgy32r71ZO/+25XbnoEVK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="393318033"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="393318033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 03:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="892033274"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="892033274"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Jul 2023 03:59:10 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qFYJp-000Fz9-1d;
        Sat, 01 Jul 2023 10:59:09 +0000
Date:   Sat, 1 Jul 2023 18:58:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: arch/loongarch/kernel/stacktrace.c:47:25: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202307011821.uIMwFiL1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a507db1d8fdc39802415e4d2ef6d1aecd67927fa
commit: 4d7bf939df08218e682f7a42952eee3bad4dceb7 LoongArch: Add USER_STACKTRACE support
date:   11 months ago
config: loongarch-randconfig-r073-20230627 (https://download.01.org/0day-ci/archive/20230701/202307011821.uIMwFiL1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230701/202307011821.uIMwFiL1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307011821.uIMwFiL1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/stacktrace.c:47:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long [noderef] __user *user_frame_tail @@     got unsigned long * @@
   arch/loongarch/kernel/stacktrace.c:47:25: sparse:     expected unsigned long [noderef] __user *user_frame_tail
   arch/loongarch/kernel/stacktrace.c:47:25: sparse:     got unsigned long *

vim +47 arch/loongarch/kernel/stacktrace.c

    39	
    40	static int
    41	copy_stack_frame(unsigned long fp, struct stack_frame *frame)
    42	{
    43		int ret = 1;
    44		unsigned long err;
    45		unsigned long __user *user_frame_tail;
    46	
  > 47		user_frame_tail = (unsigned long *)(fp - sizeof(struct stack_frame));
    48		if (!access_ok(user_frame_tail, sizeof(*frame)))
    49			return 0;
    50	
    51		pagefault_disable();
    52		err = (__copy_from_user_inatomic(frame, user_frame_tail, sizeof(*frame)));
    53		if (err || (unsigned long)user_frame_tail >= frame->fp)
    54			ret = 0;
    55		pagefault_enable();
    56	
    57		return ret;
    58	}
    59	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
