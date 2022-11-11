Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F162560D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiKKJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiKKJAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:00:00 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B938C582
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668157100; x=1699693100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s/K1OGKvxiKFArO/iGi6he/zO4L5VAtoS58akme1yUs=;
  b=YqcMHBx25b8+npwSZF2W5p1wcSf0A5x6spe8wGpcUro+4qMlTCPr+j9L
   QcGW3cB7mTBvMAAGpac6ALN18hNoOYpY2/LxYFPpkBvZ0I7AacN4YXKXf
   H/GSVRDgYWBGSqRJVJJZ2XR+IyT/yUqkopsADA3ZoQhjQglZ9RTC0HjQs
   gt6guvciPPDrfgrxmMJMkqgfKMJqqQg1iNRaoc0L5LM1dO96PW58t4U5+
   hZMb0JjtoLee7w+Ue79MasFk+ePtjPPRstgiMEvGUNRU+Y7Dsu0Ufo3KX
   adW4qtOJ0ZsZMuXBypkhoKfbW/1g4khCIpNKS6/aieEAcnna98SY2DcHF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="291281600"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="291281600"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 00:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="966760126"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="966760126"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2022 00:58:00 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otPrM-0003n5-10;
        Fri, 11 Nov 2022 08:58:00 +0000
Date:   Fri, 11 Nov 2022 16:57:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/crypto/hisilicon/sec2/sec_main.c:282:6: warning: Local
 variable 'ctx_q_num' shadows outer variable [shadowVariable]
Message-ID: <202211111655.DyDy9Bu6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4bbf3422df78029f03161640dcb1e9d1ed64d1ea
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   3 months ago
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

cppcheck warnings: (new ones prefixed by >>)
>> drivers/crypto/hisilicon/sec2/sec_main.c:282:6: warning: Local variable 'ctx_q_num' shadows outer variable [shadowVariable]
    u32 ctx_q_num;
        ^
   drivers/crypto/hisilicon/sec2/sec_main.c:304:12: note: Shadowed declaration
   static u32 ctx_q_num = SEC_CTX_Q_NUM_DEF;
              ^
   drivers/crypto/hisilicon/sec2/sec_main.c:282:6: note: Shadow variable
    u32 ctx_q_num;
        ^
--
   drivers/crypto/hisilicon/qm.c:4563:8: warning: %x in format string (no. 2) requires 'unsigned int *' but the argument type is 'signed int *'. [invalidScanfArgType_int]
    ret = sscanf(tbuf_bdf, "%u:%x:%u.%u", &tmp1, &bus, &device, &function);
          ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/crypto/hisilicon/qm.c:1704:2: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
    dregs = NULL;
    ^
>> drivers/crypto/hisilicon/qm.c:4553:8: warning: sscanf() without field width limits can crash with huge input data. [invalidscanf]
    ret = sscanf(buf, "%s %s", tbuf_bdf, val_buf);
          ^
>> drivers/crypto/hisilicon/qm.c:3499:46: warning: Parameter 'pdev' can be declared as pointer to const [constParameter]
   static int qm_try_frozen_vfs(struct pci_dev *pdev,
                                                ^
>> drivers/crypto/hisilicon/qm.c:4229:29: warning: Uninitialized variable: tmp->distance [uninitvar]
      if (res->distance < tmp->distance) {
                               ^
   drivers/crypto/hisilicon/qm.c:4222:7: note: Assuming condition is false
     if (!res)
         ^
   drivers/crypto/hisilicon/qm.c:4229:29: note: Uninitialized variable: tmp->distance
      if (res->distance < tmp->distance) {
                               ^

vim +/ctx_q_num +282 drivers/crypto/hisilicon/sec2/sec_main.c

416d82204df44e Zaibo Xu 2019-11-13  279  
416d82204df44e Zaibo Xu 2019-11-13  280  static int sec_ctx_q_num_set(const char *val, const struct kernel_param *kp)
416d82204df44e Zaibo Xu 2019-11-13  281  {
416d82204df44e Zaibo Xu 2019-11-13 @282  	u32 ctx_q_num;
416d82204df44e Zaibo Xu 2019-11-13  283  	int ret;
416d82204df44e Zaibo Xu 2019-11-13  284  
416d82204df44e Zaibo Xu 2019-11-13  285  	if (!val)
416d82204df44e Zaibo Xu 2019-11-13  286  		return -EINVAL;
416d82204df44e Zaibo Xu 2019-11-13  287  
416d82204df44e Zaibo Xu 2019-11-13  288  	ret = kstrtou32(val, 10, &ctx_q_num);
416d82204df44e Zaibo Xu 2019-11-13  289  	if (ret)
416d82204df44e Zaibo Xu 2019-11-13  290  		return -EINVAL;
416d82204df44e Zaibo Xu 2019-11-13  291  
7c7d902aa4059b Zaibo Xu 2020-01-11  292  	if (!ctx_q_num || ctx_q_num > SEC_CTX_Q_NUM_MAX || ctx_q_num & 0x1) {
416d82204df44e Zaibo Xu 2019-11-13  293  		pr_err("ctx queue num[%u] is invalid!\n", ctx_q_num);
416d82204df44e Zaibo Xu 2019-11-13  294  		return -EINVAL;
416d82204df44e Zaibo Xu 2019-11-13  295  	}
416d82204df44e Zaibo Xu 2019-11-13  296  
416d82204df44e Zaibo Xu 2019-11-13  297  	return param_set_int(val, kp);
416d82204df44e Zaibo Xu 2019-11-13  298  }
416d82204df44e Zaibo Xu 2019-11-13  299  

:::::: The code at line 282 was first introduced by commit
:::::: 416d82204df44ef727de6eafafeaa4d12fdc78dc crypto: hisilicon - add HiSilicon SEC V2 driver

:::::: TO: Zaibo Xu <xuzaibo@huawei.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
